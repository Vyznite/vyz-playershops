fx_version 'cerulean'
game 'gta5'

version '1.0.0'
author 'Vyznite'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'server/server.lua'
}

shared_scripts {
	'config.lua',
	'helper.lua'
}

client_scripts {
	'client/*.l*a',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.l*a'
}

dependency '/assetpacks'