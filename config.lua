Config = {}

Config.CoreObject = exports['fx-core']:GetCoreObject()

Config.Blip = 52
Config.BlipForSale = 375

Config.Wholesale = vector3(908.18, -1722.29, 32.16)

Config.WholesaleStock = {
	slots = 30,
	label = 'Stay Frosty Groothandel',
	items = {
		[1] = {
			name = "water_bottle",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 1,
		},
		[2] = {
			name = "ecola",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 2,
		},
		[3] = {
			name = "sprunk",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 3,
		},
		[4] = {
			name = "meto_bar",
			price = 3,
			amount = 50,
			info = {},
			type = "item",
			slot = 4,
		},
		[5] = {
			name = "ego_bar",
			price = 3,
			amount = 50,
			info = {},
			type = "item",
			slot = 5,
		},
		[6] = {
			name = "tosti",
			price = 7,
			amount = 50,
			info = {},
			type = "item",
			slot = 6,
		},
		[7] = {
			name = "sandwich",
			price = 7,
			amount = 50,
			info = {},
			type = "item",
			slot = 7,
		},
		[8] = {
			name = "gezond",
			price = 7,
			amount = 50,
			info = {},
			type = "item",
			slot = 8,
		},
		[9] = {
			name = "boerenkool",
			price = 7,
			amount = 50,
			info = {},
			type = "item",
			slot = 9,
		},
		[10] = {
			name = "fishstick",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 10,
		},
		[11] = {
			name = "meat",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 11,
		},
		[12] = {
			name = "kwark",
			price = 5,
			amount = 50,
			info = {},
			type = "item",
			slot = 12,
		},
		[13] = {
			name = "komkommer",
			price = 2,
			amount = 50,
			info = {},
			type = "item",
			slot = 13,
		},
		[14] = {
			name = "lettuce",
			price = 2,
			amount = 50,
			info = {},
			type = "item",
			slot = 14,
		},
		[15] = {
			name = "weed_nutrition",
			price = 50,
			amount = 1050,
			info = {},
			type = "item",
			slot = 15,
		},
		[16] = {
			name = "phone",
			price = 950,
			amount = 50,
			info = {},
			type = "item",
			slot = 16,
		},
		[17] = {
			name = "lighter",
			price = 3,
			amount = 50,
			info = {},
			type = "item",
			slot = 17,
		},
	}
}

Config.Shops = {
	-- // 247 SUPERMARKET // --
	["247supermarket1"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(26.45, -1346.98, 29.5),
		["owner"] = "",
		['manage'] = vector3(28.97, -1339.73, 29.5),
		["npc"] = {
			pos = vector4(24.88, -1347.19, 29.5, 276.77),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket2"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(-3242.5, 1002.07, 12.83),
		["owner"] = "",
		['manage'] = vector3(-3249.52, 1005.07, 12.83),
		["npc"] = {
			pos = vector4(-3242.59, 1000.45, 12.83, 346.33),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket3"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(1729.94, 6414.66, 35.04),
		["owner"] = "",
		['manage'] = vector3(1735.27, 6420.12, 35.04),
		["npc"] = {
			pos = vector4(1728.37, 6415.27, 35.04, 242.32),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket4"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(1697.99, 4924.4, 42.06),
		["owner"] = "",
		['manage'] = vector3(1706.82, 4920.99, 42.06),
		["npc"] = {
			pos = vector4(1697.16, 4923.54, 42.06, 321.42),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket5"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(1961.48, 3741.33, 32.34),
		["owner"] = "",
		['manage'] = vector3(1960.13, 3748.88, 32.34),
		["npc"] = {
			pos = vector4(1960.26, 3740.57, 32.34, 297.48),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket6"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(547.21, 2670.66, 42.16),
		["owner"] = "",
		['manage'] = vector3(545.64, 2663.15, 42.16),
		["npc"] = {
			pos = vector4(548.68, 2670.97, 42.16, 93.51),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket7"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(2678.58, 3281.34, 55.24),
		["owner"] = "",
		['manage'] = vector3(2673.55, 3287.02, 55.24),
		["npc"] = {
			pos = vector4(2677.84, 3279.97, 55.24, 324.18),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket8"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(2556.86, 382.81, 108.62),
		["owner"] = "",
		['manage'] = vector3(2549.77, 385.58, 108.62),
		["npc"] = {
			pos = vector4(2556.85, 381.27, 108.62, 351.04),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket9"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(374.64, 326.48, 103.57),
		["owner"] = "",
		['manage'] = vector3(378.73, 332.68, 103.57),
		["npc"] = {
			pos = vector4(373.06, 326.65, 103.57, 248.65),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_lifeinvad_01"
		}
	},
	["247supermarket10"] = {
		["label"] = "24/7 Supermarkt",
		["coords"] = vector3(814.25, -782.57, 26.17),
		["owner"] = "",
		['manage'] = vector3(816.75, -775.06, 26.17),
		["npc"] = {
			pos = vector4(812.8, -782.56, 26.17, 272.89),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "s_m_m_cntrybar_01"
		}
	},

	-- // LTD GASOLINE // --
	["ltdgasoline"] = {
		["label"] = "LTD Gasoline",
		["coords"] = vector3(-48.44, -1757.86, 29.42),
		["owner"] = "",
		['manage'] = vector3(-44.22, -1749.41, 29.42),
		["npc"] = {
			pos = vector4(-47.4, -1758.65, 29.42, 47.16),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "mp_m_shopkeep_01"
		}
	},
	["ltdgasoline2"] = {
		["label"] = "LTD Gasoline",
		["coords"] = vector3(-707.36, -914.72, 19.22),
		["owner"] = "",
		['manage'] = vector3(-709.67, -905.47, 19.22),
		["npc"] = {
			pos = vector4(-706.17, -914.62, 19.22, 86.69),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "mp_m_shopkeep_01"
		}
	},
	["ltdgasoline3"] = {
		["label"] = "LTD Gasoline",
		["coords"] = vector3(-1820.33, 792.66, 138.1),

		["owner"] = "",
		['manage'] = vector3(-1828.33, 797.91, 138.19),
		["npc"] = {
			pos = vector4(-1819.58, 793.55, 138.09, 129.73),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "mp_m_shopkeep_01"
		}
	},
	["ltdgasoline4"] = {
		["label"] = "LTD Gasoline",
		["coords"] = vector3(1163.7, -323.92, 69.2),
		["owner"] = "",
		['manage'] = vector3(1159.79, -315.3, 69.21),
		["npc"] = {
			pos = vector4(1164.83, -323.73, 69.21, 94.43),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "mp_m_shopkeep_01"
		}
	},

	-- // ROB LIQOUR STORE -- //
	["robsliquor"] = {
		["label"] = "Rob's Liqour",
		["coords"] = vector3(-1222.77, -907.19, 12.32),
		["owner"] = "",
		['manage'] = vector3(-1219.98, -908.73, 12.33),
		["npc"] = {
			pos = vector4(-1222.05, -908.34, 12.33, 26.93),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "csb_popov"
		}
	},
	["robsliquor2"] = {
		["label"] = "Rob's Liqour",
		["coords"] = vector3(-1487.7, -378.53, 40.16),
		["owner"] = "",
		['manage'] = vector3(-1486.4, -375.94, 40.16),
		["npc"] = {
			pos = vector4(-1486.67, -377.61, 40.16, 130.08),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "csb_popov"
		}
	},
	["robsliquor3"] = {
		["label"] = "Rob's Liqour",
		["coords"] = vector3(-2967.79, 391.64, 15.04),
		["owner"] = "",
		['manage'] = vector3(-2964.87, 392.35, 15.04),
		["npc"] = {
			pos = vector4(-2966.32, 391.46, 15.04, 77.61),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "csb_popov"
		}
	},
	["robsliquor4"] = {
		["label"] = "Rob's Liqour",
		["coords"] = vector3(1165.28, 2709.4, 38.15),
		["owner"] = "",
		['manage'] = vector3(1164.51, 2712.23, 38.16),
		["npc"] = {
			pos = vector4(1165.44, 2710.81, 38.16, 177.28),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "csb_popov"
		}
	},
	["robsliquor5"] = {
		["label"] = "Rob's Liqour",
		["coords"] = vector3(1135.66, -982.76, 46.41),
		["owner"] = "",
		['manage'] = vector3(1133.01, -984.09, 46.42),
		["npc"] = {
			pos = vector4(1134.32, -983.01, 46.42, 275.72),
			scenario = "WORLD_HUMAN_CLIPBOARD",
			model = "csb_popov"
		}
	},
}
