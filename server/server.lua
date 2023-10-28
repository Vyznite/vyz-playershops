FXCore = Config.CoreObject

shop_table = [[
    CREATE TABLE IF NOT EXISTS `shops` (
		`id` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
		`owner` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
		`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
		`stock` LONGTEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_bin',
		`balance` DOUBLE NULL DEFAULT '0',
		PRIMARY KEY (`id`) USING BTREE,
		INDEX `owner` (`owner`) USING BTREE,
		CONSTRAINT `stock` CHECK (json_valid(`stock`))
	)
	COLLATE='utf8mb3_general_ci'
	ENGINE=InnoDB;
]]

shop_logs = [[ --
	CREATE TABLE IF NOT EXISTS `shops_logs` (
		`id` INT(11) NOT NULL AUTO_INCREMENT,
		`shopid` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
		`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
		`amount` INT(11) NOT NULL DEFAULT '0',
		`price` DOUBLE NOT NULL DEFAULT '0',
		`timestamp` DATETIME NULL DEFAULT current_timestamp(),
		PRIMARY KEY (`id`) USING BTREE,
		INDEX `shopid` (`shopid`) USING BTREE,
		INDEX `item` (`item`) USING BTREE,
		INDEX `time` (`timestamp`) USING BTREE
	)
	COLLATE='utf8mb3_general_ci'
	ENGINE=InnoDB;
]]

MySQL.query(shop_table)
MySQL.query(shop_logs)

LockedShops = {}


Citizen.CreateThread(function()
	MySQL.query('SELECT `id`, `owner`, `name` FROM `shops`', {}, function(results)
		if results then
			for k, v in pairs(results) do
				if Config.Shops[v.id] then
					if v.name then
						Config.Shops[v.id].label = v.name
					end

					Config.Shops[v.id].owner = v.owner
				end
			end
		end

		TriggerClientEvent('fx-playershops:client:setShops', -1, Config)
	end)
end)

RegisterNetEvent('fx-playershops:server:getShops', function()
	TriggerClientEvent('fx-playershops:client:setShops', source, Config)
end)

FXCore.Functions.CreateCallback('fx-playershops:server:AddStock',
	function(source, cb, store, _item, billprice, billamount)
		local src = source
		local Player = FXCore.Functions.GetPlayer(src)

		LockedShops[store] = src

		if Player then
			local item = Player.Functions.GetItemByName(_item)

			if item and billamount then
				if item.amount >= billamount then
					if billprice < 1 then
						TriggerClientEvent('FXCore:Notify', src, "Prijs moet hoger dan $1 zijn.", 'error')
						return
					end

					MySQL.query('SELECT `stock` FROM `shops` WHERE `id` = @id AND `owner` = @owner',
						{ ['@id'] = store, ['@owner'] = Player.PlayerData.citizenid }, function(results)
							local stock = {}

							if results[1] then
								stock = json.decode(results[1].stock)
							end

							local added = false

							if next(stock) then
								for k, stockItem in pairs(stock) do
									if stockItem.name == item.name then
										if AreTablesEqual(stockItem.info, item.info) then
											stockItem.amount = stockItem.amount + billamount
											stockItem.price = billprice

											added = true
											break
										else
											table.insert(stock, {
												name = item.name,
												info = item.info,
												type = item.type,
												amount = billamount,
												price = billprice,
												slot = #stock + 1
											})

											added = true
											break
										end
									end
								end
							end

							if not added then
								table.insert(stock, {
									name = item.name,
									info = item.info,
									type = item.type,
									amount = billamount,
									price = billprice,
									slot = #stock + 1
								})
							end

							Player.Functions.RemoveItem(item.name, billamount, item.slot)
							TriggerClientEvent("inventory:client:ItemBox", src, FXCore.Shared.Items[item.name], "remove",
								billamount)

							MySQL.query(
								'INSERT INTO `shops` (`id`, `owner`, `stock`) VALUES (@id, @owner, @stock) ON DUPLICATE KEY UPDATE `stock` = @stock'
								, {
									['@id'] = store,
									['@owner'] = Player.PlayerData.citizenid,
									['@stock'] = json.encode(stock)
								},
								function(results)
									if results then
										TriggerClientEvent('FXCore:Notify', src, "Stock toegevoegd", 'success')
										cb(true)
									else
										cb(false)
									end

									LockedShops[store] = nil
								end)
						end)
				end
			end
		else
			LockedShops[store] = nil
		end
	end)

FXCore.Functions.CreateCallback('fx-playershops:server:EditStock', function(source, cb, store, _newName)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)

	MySQL.query('SELECT `stock` FROM `shops` WHERE `id` = @id AND `owner` = @owner',
		{ ['@id'] = store, ['@owner'] = Player.PlayerData.citizenid }, function(results)
			if results[1] then
				Config.Shops[store].label = _newName

				MySQL.query('UPDATE `shops` SET `name` = @name WHERE `id` = @id AND `owner` = @owner',
					{ ['@id'] = store, ['@owner'] = Player.PlayerData.citizenid, ['@name'] = _newName },
					function(results)
						if results then
							TriggerClientEvent('FXCore:Notify', src, "Shopnaam gewijzigd", 'success')
							TriggerClientEvent('fx-playershops:client:setShops', -1, Config)
							cb(true)
						else
							cb(false)
						end
					end)
			end
		end)
end)


function AreTablesEqual(table1, table2)
	if #table1 ~= #table2 then
		return false
	end
	for k, v in pairs(table1) do
		if type(v) == 'table' then
			if not AreTablesEqual(v, table2[k]) then
				return false
			end
		else
			if v ~= table2[k] then
				return false
			end
		end
	end
	return true
end

FXCore.Functions.CreateCallback('fx-playershops:server:GetStoreInfo', function(source, cb, store)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)

	MySQL.query('SELECT * FROM `shops` WHERE `id` = @id AND `owner` = @owner',
		{ ['@id'] = store, ['@owner'] = Player.PlayerData.citizenid }, function(results)
			if results[1] then
				cb(results[1])
			else
				cb(false)
			end
		end)
end)


FXCore.Functions.CreateCallback('fx-playershops:server:GetStore', function(source, cb, store)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)

	if LockedShops[store] == nil then
		LockedShops[store] = src

		MySQL.query('SELECT `stock` FROM `shops` WHERE `id` = @id', { ['@id'] = store }, function(results)
			if results[1] then
				local stock = json.decode(results[1].stock)
				cb(stock, false)

				if not next(stock) then
					LockedShops[store] = nil
				end
			else
				LockedShops[store] = nil
				cb(false, false)
			end
		end)
	else
		cb(false, true)
	end
end)

RegisterNetEvent('fx-playershops:server:TakeMoneyConfirm', function(shop)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)

	MySQL.query('SELECT `balance` FROM `shops` WHERE `id` = @id AND `owner` = @owner',
		{ ['@id'] = shop, ['@owner'] = Player.PlayerData.citizenid }, function(results)
			if results[1] then
				local balance = results[1].balance

				if balance > 0 then
					Player.Functions.AddMoney('cash', results[1].balance, 'winkel payout')
					MySQL.query('UPDATE `shops` SET `balance` = 0 WHERE `id` = @id AND `owner` = @owner',
						{ ['@id'] = shop, ['@owner'] = Player.PlayerData.citizenid })

					TriggerClientEvent('FXCore:Notify', src, "Je hebt $" .. balance .. " uit de kluis gepakt.",
						'success')
				else
					TriggerClientEvent('FXCore:Notify', src, "Er zit geen geld in de kluis.", 'error')
				end
			end
		end)
end)

RegisterNetEvent('fx-shops:server:UpdateShopItems', function(shop, itemData, amount)
	if Config.Shops[shop] then
		MySQL.query('SELECT `stock`, `balance` FROM `shops` WHERE `id` = @id', { ['@id'] = shop }, function(results)
			if results[1] then
				local stock = json.decode(results[1].stock)
				local balance = results[1].balance

				for k, stockItem in pairs(stock) do
					if stockItem.name == itemData.name and AreTablesEqual(stockItem.info, itemData.info) then
						local newAmount = stockItem.amount - amount

						balance = balance + (stockItem.price * amount)

						if newAmount == 0 then
							table.remove(stock, k)
						else
							stockItem.amount = newAmount
						end

						MySQL.insert(
							'INSERT INTO `shops_logs` (`shopid`, `item`, `amount`, `price`) VALUES (@shopid, @item, @amount, @price)'
							, {
								['@shopid'] = shop,
								['@item'] = stockItem.name,
								['@amount'] = amount,
								['@price'] = stockItem.price
							})
					end
				end

				for k, stockItem in pairs(stock) do
					stockItem.slot = k
				end

				MySQL.query('UPDATE `shops` SET `stock` = @stock, `balance` = @balance WHERE `id` = @id',
					{ ['@id'] = shop, ['@stock'] = json.encode(stock), ['@balance'] = balance })
			else
				return
			end
		end)
	end
end)

function releaseShop()
	local src = source

	for k, v in pairs(LockedShops) do
		if v == src then
			LockedShops[k] = nil
		end
	end
end

AddEventHandler('playerDropped', releaseShop)
RegisterNetEvent('fx-shops:server:releaseShop', releaseShop)


FXCore.Commands.Add('sellShop', 'Verkoop de dichtbijzijnde winkel',
	{ { name = 'player', help = 'Speler ID' }, { name = 'price', help = 'Prijs' } }, true, function(source, args)
		local src = source
		local Player = FXCore.Functions.GetPlayer(src)

		if Player and Player.PlayerData.job.name == "realestate" then
			TriggerClientEvent('fx-shops:client:sellShop', src, args)
		else
			TriggerClientEvent('FXCore:Notify', src, "Je bent niet bevoegd om deze winkel te verkopen.", 'error')
		end
	end)

FXCore.Commands.Add('releaseshops', 'Voer dit alleen uit als een winkel niet toegangelijk is', {}, false,
	function(source, args)
		LockedShops = {}
		TriggerClientEvent("FXCore:Notify", source, "Alle winkels zijn vrijgegeven.", "success")
	end, 'admin')


RegisterNetEvent('fx-shops:server:sellShop', function(closestShop, args)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)
	local Target = FXCore.Functions.GetPlayer(tonumber(args[1]))

	if Player and Player.PlayerData.job.name == "realestate" then
		if Config.Shops[closestShop] and Config.Shops[closestShop].owner == "" then
			if Target then
				local price = tonumber(args[2])

				if price and price > 0 then
					TriggerClientEvent('fx-shops:client:buyShop', tonumber(args[1]), closestShop, price)
				else
					TriggerClientEvent('FXCore:Notify', src, "De prijs moet een positief getal zijn.", 'error')
				end
			else
				TriggerClientEvent('FXCore:Notify', src, "Deze speler is niet online.", 'error')
				return
			end
		end
	else
		TriggerClientEvent('FXCore:Notify', src, "Je bent niet bevoegd om deze winkel te verkopen.", 'error')
	end
end)

FXCore.Functions.CreateCallback('fx-shops:server:BuyShop', function(source, cb, data)
	local src = source
	local Player = FXCore.Functions.GetPlayer(src)

	local price = data.price
	local shop = data.shop

	if Config.Shops[shop] and Config.Shops[shop].owner == "" then
		if Player.Functions.RemoveMoney('cash', price, 'Bought Shop') or
			Player.Functions.RemoveMoney('bank', price, 'Bought Shop') then
			MySQL.query(
				'INSERT INTO `shops` (`id`, `owner`, `name`) VALUES (@id, @owner, @name) ON DUPLICATE KEY UPDATE `owner` = @owner'
				, { ['@id'] = shop, ['@owner'] = Player.PlayerData.citizenid, ['@name'] = Config.Shops[shop].label },
				function(results)
					if results then
						TriggerClientEvent('FXCore:Notify', src, "Je hebt de winkel gekocht voor $" .. price .. ".",
							'success')

						Config.Shops[shop].owner = Player.PlayerData.citizenid

						TriggerClientEvent('fx-playershops:client:setShops', -1, Config)
					else
						TriggerClientEvent('FXCore:Notify', src, "Er is iets fout gegaan.", 'error')
					end
				end)
		else
			TriggerClientEvent('FXCore:Notify', src, "Je hebt niet genoeg geld om de winkel te kopen.", 'error')
		end
	end
end)
