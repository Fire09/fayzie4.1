RegisterNetEvent('FinishMoneyCheckForVehpdm')
RegisterNetEvent('pdmvehshop:spawnVehicle')
local vehshop_blips = {}
local buyPlate = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local rank = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 5000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 5000, description = {}, model = "rumpo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 200, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 250, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 400, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 200, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 600, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 600, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "PDM tuners", description = ''},
				{name = "S-Class", description = ''},
				{name = "A-Class", description = ''},
				{name = "B-Class", description = ''},
				{name = "C-Class", description = ''},
				{name = "D-Class", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 5000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 5000, description = {}, model = "rumpo"},
			}
		},
		["pdm-tuners"] = {
			title = "pdm-tuners",
			name = "pdm-tuners",
			buttons = {
				{name = "Calico GTF", costs = 165000, description = {}, model = "calico"},
				{name = "Dominator GTT", costs = 145000, description = {}, model = "dominator8"},
				{name = "Euros", costs = 155000, description = {}, model = "euros"},
				{name = "Futo GTX", costs = 115000, description = {}, model = "futo2"},
				{name = "Jester RR", costs = 185000, description = {}, model = "jester4"},
				{name = "Remus", costs = 145000, description = {}, model = "remus"},
				{name = "RT3000", costs = 132500, description = {}, model = "rt3000"},
				{name = "Tailgater S", costs = 165000, description = {}, model = "tailgater2"},
				{name = "Warrener HKR", costs = 14750, description = {}, model = "warrener2"},
				{name = "ZR350", costs = 125000, description = {}, model = "zr350"},
				{name = "Comet S2", costs = 189000, description = {}, model = "comet6"},
				{name = "Dominator ASP", costs = 156750, description = {}, model = "dominator7"},
				{name = "Vectre", costs = 186500, description = {}, model = "vectre"},
				{name = "Growler", costs = 192500, description = {}, model = "growler"},
				{name = "Sultan RS Classic", costs = 175000, description = {}, model = "sultan3"},
				{name = "Cypher", costs = 165000, description = {}, model = "cypher"},
				{name = "Previon", costs = 145000, description = {}, model = "previon"},
			}
		},
		["s-class"] = {
			title = "s-class",
			name = "s-class",
			buttons = {
				{name = "Bravado Gauntlet Classic", costs = 148500, description = {}, model = "gauntlet3"},
				{name = "Grotti Furia", costs = 158000, description = {}, model = "furia"},
				{name = "Vulcar Nebula Turbo", costs = 125000, description = {}, model = "nebula"},
				{name = "Grotti Turismo Classic", costs = 126000, description = {}, model = "turismo2"},
				{name = "Itali GTO", costs = 154000, description = {}, model = "italigto"},
				{name = "Itali RSX", costs = 156000, description = {}, model = "italirsx"},
				{name = "Gauntlet HELFIRE", costs = 154000, description = {}, model = "gauntlet4"},
				{name = "Comet SR", costs = 125000, description = {}, model = "comet5"},
				{name = "Dominator GTX", costs = 140000, description = {}, model = "dominator3"},
				{name = "Jester Retro", costs = 135000, description = {}, model = "jester3"},
				{name = "Drafter", costs = 152000, description = {}, model = "Drafter"},
				{name = "Jester RR", costs = 134000, description = {}, model = "Jester4"},
				{name = "Dominator ASP", costs = 147500, description = {}, model = "Dominator7"},
				{name = "Vectre", costs = 150000, description = {}, model = "Vectre"},
				{name = "Sultan RS", costs = 148000, description = {}, model = "SultanRS"},
				{name = "ZR350", costs = 140000, description = {}, model = "ZR350"},
				{name = "Elegy Retro Custom", costs = 147500, description = {}, model = "elegy"},
				{name = "Progen T20", costs = 145000, description = {}, model = "T20"},
				{name = "Remus", costs = 135000, description = {}, model = "Remus"},
				{name = "RT3000", costs = 132000, description = {}, model = "RT3000"},
				{name = "Dominator GTT", costs = 138000, description = {}, model = "DOMINATOR8"},
				{name = "Annis Euros", costs = 160000, description = {}, model = "EUROS"},
				{name = "Futo GTX", costs = 128000, description = {}, model = "Futo2"},
				{name = "Calico GTF", costs = 148000, description = {}, model = "Calico"},
				{name = "Comet S2", costs = 1340000, description = {}, model = "COMET6"},
				{name = "UBERMACHT Cypher", costs = 137000, description = {}, model = "Cypher"},
				{name = "Growler", costs = 148000, description = {}, model = "Growler"},
				{name = "Sultan RS classic", costs = 140000, description = {}, model = "Sultan3"},
				{name = "Banshee 900R", costs = 150000, description = {}, model = "banshee2"},
				{name = "Coquette D10", costs = 150000, description = {}, model = "coquette4"},
				{name = "Schlagen GT", costs = 140000, description = {}, model = "Schlagen"},
				{name = "Infernus Classic", costs = 135000, description = {}, model = "infernus2"},
				{name = "Deviant", costs = 130000, description = {}, model = "deviant"},
				{name = "Grotti Turismo R", costs = 135000, description = {}, model = "turismor"},
			}
		},
        ["b-class"] = {
			title = "b-class",
			name = "b-class",
			buttons = {
				{name = "Lampadati Komoda", costs = 58000, description = {}, model = "komoda"},
				{name = "Dinka Blista", costs = 40000, description = {}, model = "blista"},
				{name = "Albany VSTR", costs = 60000, description = {}, model = "vstr"},
				{name = "Dinka Sugoi", costs = 56000, description = {}, model = "sugoi"},
				{name = "Karin Kuruma", costs = 58000, description = {}, model = "kuruma"},
				{name = "Vapid GB200", costs = 56000, description = {}, model = "gb200"},
				{name = "Lampadati Tropos Rally", costs = 45000, description = {}, model = "tropos"},
				{name = "Bollokon Prairie", costs = 42000, description = {}, model = "prairie"},
				{name = "Annis Savestra", costs = 47000, description = {}, model = "savestra"},
				{name = "Ubermacht Sentinel", costs = 50000, description = {}, model = "sentinel"},
				{name = "Ubermacht Sentinel XS", costs = 50000, description = {}, model = "sentinel2"},
				{name = "Ubermacht Zion Classic", costs = 43000, description = {}, model = "zion3"},
				{name = "Bravado Buffalo", costs = 57500, description = {}, model = "buffalo"},
				{name = "Bravado Buffalo S", costs = 57500, description = {}, model = "buffalo2"},				
				{name = "Shyster Fusilade", costs = 45000, description = {}, model = "fusilade"},
				{name = "Karin Futo", costs = 45000, description = {}, model = "futo"},
				{name = "Revolter", costs = 65000, description = {}, model = "revolter"},
				{name = "Ubermacht Schafter", costs = 53000, description = {}, model = "schafter2"},
				{name = "Enus Cognoscenti", costs = 55000, description = {}, model = "cognoscenti"},
				{name = "Enus Cognoscenti 55", costs = 55000, description = {}, model = "cog55"},
				{name = "Cheval Fugitive", costs = 50000, description = {}, model = "fugitive"},
				{name = "Karin Intruder", costs = 43000, description = {}, model = "intruder"},
				{name = "Declasse Premier", costs = 30000, description = {}, model = "premier"},
				{name = "Zirconium Stratum", costs = 60000, description = {}, model = "stratum"},
				{name = "Enus Super Diamond", costs = 56000, description = {}, model = "superd"},
				{name = "Obey Tailgater", costs = 48000, description = {}, model = "tailgater"},
				{name = "Dewbauchee Exemplar", costs = 42000, description = {}, model = "exemplar"},
				{name = "Ocelot Jackal", costs = 43000, description = {}, model = "jackal"},
				{name = "Ubermacht Oracle", costs = 42000, description = {}, model = "oracle"},
				{name = "Ubermacht Oracle XS", costs = 42000, description = {}, model = "oracle2"},
				{name = "Lampadati Felon", costs = 45000, description = {}, model = "felon"},
				{name = "Coil Raiden", costs = 62000, description = {}, model = "raiden"},
				{name = "Cheval Surge", costs = 50000, description = {}, model = "surge"},
				{name = "Weeny Issi Sport", costs = 55000, description = {}, model = "issi7"},
				{name = "Lampadati Michelli GT", costs = 49000, description = {}, model = "michelli"},
				{name = "Vapid Retinue", costs = 50000, description = {}, model = "retinue"},
				{name = "Vapid Retinue MkII", costs = 52000, description = {}, model = "retinue2"},
				{name = "Nagasaki Outlaw", costs = 47000, description = {}, model = "outlaw"},
				{name = "Maxwell Vagrant", costs = 52000, description = {}, model = "vagrant"},
				{name = "Karin Everon", costs = 55000, description = {}, model = "everon"},
				{name = "Vapid Trophy Truck", costs = 52000, description = {}, model = "trophytruck"},
				{name = "Vapid Desert Raid", costs = 50000, description = {}, model = "trophytruck2"},
				{name = "Albany Buccaneer", costs = 46000, description = {}, model = "buccaneer"},
				{name = "Albany Buccaneer Custom", costs = 46000, description = {}, model = "buccaneer2"},				
				{name = "Vapid Clique", costs = 44000, description = {}, model = "clique"},
				{name = "Willard Faction", costs = 49000, description = {}, model = "faction"},
				{name = "Declasse Impaler", costs = 47000, description = {}, model = "impaler"},
				{name = "Imponte Nightshade", costs = 46000, description = {}, model = "nightshade"},
				{name = "Imponte Phoenix", costs = 45000, description = {}, model = "phoenix"},
				{name = "Cheval Picador", costs = 44000, description = {}, model = "picador"},
				{name = "Bravado Rat-Truck", costs = 47500, description = {}, model = "ratloader2"},
				{name = "Declasse Sabre Turbo Custom", costs = 50000, description = {}, model = "sabregt2"},
				{name = "Declasse Stallion", costs = 48000, description = {}, model = "stalion"},
				{name = "Declasse Tulip", costs = 45000, description = {}, model = "tulip"},
				{name = "Declasse Vigero", costs = 48000, description = {}, model = "vigero"},
				{name = "Albany Virgo", costs = 65000, description = {}, model = "virgo"},
				{name = "Benefactor Stirling GT", costs = 62000, description = {}, model = "feltzer3"},
				{name = "Invetero Coquette Classic", costs = 58000, description = {}, model = "coquette2"},
				{name = "Invetero Coquette Blackfin", costs = 60000, description = {}, model = "coquette3"},
				{name = "Grotti GT500", costs = 57500, description = {}, model = "gt500"},
				{name = "Declasse Mamba", costs = 56000, description = {}, model = "mamba"},
				{name = "Grotti Stinger", costs = 50000, description = {}, model = "stinger"},
				{name = "Grotti Stinger GT", costs = 50000, description = {}, model = "stingergt"},
				{name = "Ocelot Swinger", costs = 58000, description = {}, model = "swinger"},
				{name = "Lampadati Viseris", costs = 57000, description = {}, model = "viseris"},
				{name = "Dewbauchee Rapid GT Classic", costs = 55000, description = {}, model = "rapidgt3"},
				{name = "HK Warrener", costs = 50000, description = {}, model = "Warrener2"},
				{name = "Jugular", costs = 55000, description = {}, model = "jugular"},
			}
		},
		["c-class"] = {
			title = "c-class",
			name = "c-class",
			buttons = {
				{name = "Dinka Blista Compact", costs = 25000, description = {}, model = "blista2"},
				{name = "Karin Asterope", costs = 40000, description = {}, model = "asterope"},
				{name = "Vulcar Ingot", costs = 28000, description = {}, model = "ingot"},
				{name = "Albany Primo", costs = 40000, description = {}, model = "primo"},
				{name = "Albany Primo Custom", costs = 42000, description = {}, model = "primo2"},
				{name = "Vapid Stanier", costs = 34000, description = {}, model = "stanier"},
				{name = "Dundreary Stretch", costs = 30000, description = {}, model = "stretch"},
				{name = "Vulcar Warrener", costs = 30500, description = {}, model = "warrener"},
				{name = "Albany Washington", costs = 30000, description = {}, model = "washington"},
				{name = "Weeny Issi", costs = 30000, description = {}, model = "issi2"},
				{name = "Benefactor Panto", costs = 30000, description = {}, model = "panto"},
				{name = "Declasse Rhapsody", costs = 32500, description = {}, model = "rhapsody"},
				{name = "Gallivanter Baller", costs = 40000, description = {}, model = "baller2"},
				{name = "Karin BeeJay XL", costs = 32000, description = {}, model = "bjxl"},
				{name = "Fathom FQ-2", costs = 34000, description = {}, model = "fq2"},
				{name = "Karin 190z", costs = 36000, description = {}, model = "z190"},
				{name = "Lampadati Casco", costs = 20000, description = {}, model = "casco"},
				{name = "Emperor Habanero", costs = 33000, description = {}, model = "habanero"},
				{name = "Mammoth Patriot", costs = 35000, description = {}, model = "patriot"},
				{name = "Mammoth Patriot WCR", costs = 40000, description = {}, model = "patriot2"},
				{name = "Vapid Caracara", costs = 38000, description = {}, model = "caracara2"},
				{name = "Vapid Contender", costs = 35000, description = {}, model = "contender"},
				{name = "Benefactor Streiter", costs = 32000, description = {}, model = "streiter"},
				{name = "Pfister Comet Safari", costs = 35000, description = {}, model = "comet4"},
				{name = "Canis Freecrawler", costs = 30000, description = {}, model = "freecrawler"},
				{name = "Vapid Guardian", costs = 40000, description = {}, model = "guardian"},
				{name = "Bravado Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Vapid Bobcat XL", costs = 38000, description = {}, model = "bobcatxl"},
				{name = "Vapid Riata", costs = 40000, description = {}, model = "riata"},
				{name = "Benefactor Glendale", costs = 32000, description = {}, model = "glendale"},
				{name = "Vulcar Fagaloa", costs = 30000, description = {}, model = "fagaloa"},
				{name = "Weeny Issi Classic", costs = 35000, description = {}, model = "issi3"},
				{name = "Willard Faction Donk", costs = 40000, description = {}, model = "faction3"},
				{name = "Vapid Chino", costs = 30000, description = {}, model = "chino"},
				{name = "Vapid Chino Custom", costs = 30000, description = {}, model = "chino2"},
				{name = "Vapid Hotknife", costs = 25000, description = {}, model = "hotknife"},
				{name = "Albany Roosevelt", costs = 40000, description = {}, model = "btype"}, 
				{name = "Albany Roosevelt Valor", costs = 40000, description = {}, model = "btype3"},
				{name = "Truffade Z-Type", costs = 40000, description = {}, model = "ztype"},
			}
		},
		["casino"] = {
			title = "casino",
			name = "casino",
			buttons = {
--				{name = "Jugular", costs = 175000, description = {}, model = "jugular"},
--				{name = "Peyote", costs = 75000, description = {}, model = "peyote2"},
--				{name = "Gauntlet 4", costs = 150000, description = {}, model = "gauntlet4"},
--				{name = "Caracara", costs = 190000, description = {}, model = "caracara2"},
--				{name = "Novak", costs = 140000, description = {}, model = "Novak"},
--				{name = "Issi 7", costs = 200000, description = {}, model = "issi7"},
--				{name = "Hellion", costs = 110000, description = {}, model = "hellion"},
--				{name = "Dynasty", costs = 110000, description = {}, model = "Dynasty"},
--				{name = "Gauntlet 3", costs = 130000, description = {}, model = "gauntlet3"},
--				{name = "Nebula", costs = 83000, description = {}, model = "nebula"},
--				{name = "Zion 3", costs = 75000, description = {}, model = "zion3"},
--				{name = "Drafter", costs = 140000, description = {}, model = "drafter"},
--				{name = "Komoda", costs = 195000, description = {}, model = "komoda"},
--				{name = "Rebla", costs = 110000, description = {}, model = "rebla"},
--				{name = "Retinue", costs = 80000, description = {}, model = "retinue2"},
--				{name = "Sugoi", costs = 105000, description = {}, model = "sugoi"},
--				{name = "Sultan 2", costs = 155000, description = {}, model = "sultan2"},
--				{name = "VSTR", costs = 186000, description = {}, model = "vstr"},



			}
		},
		
		["d-class"] = {
			title = "d-class",
			name = "d-class",
			buttons = {
				{name = "Declasse Asea", costs = 10000, description = {}, model = "asea"},
				{name = "Declasse Emperor", costs = 15000, description = {}, model = "emperor"},
				{name = "Dundreary Regina", costs = 5000, description = {}, model = "regina"},
				{name = "Chariot Romero Hearse", costs = 5000, description = {}, model = "romero"},
				{name = "Canis Kalahari", costs = 10000, description = {}, model = "kalahari"},
				{name = "Karin Dilettante", costs = 5000, description = {}, model = "dilettante"},
				{name = "Canis Bodhi", costs = 10000, description = {}, model = "bodhi2"},
				{name = "Declasse Rancher XL", costs = 20000, description = {}, model = "rancherxl"},
				{name = "Bravado Duneloader", costs = 5000, description = {}, model = "dloader"},
				{name = "Weeny Dynasty", costs = 10000, description = {}, model = "dynasty"},
				{name = "Albany Hermes", costs = 20000, description = {}, model = "hermes"},
				{name = "Vapid Hustler ", costs = 15000, description = {}, model = "hustler"},
				{name = "Albany Virgo Custom", costs = 17000, description = {}, model = "virgo2"},
				{name = "Albany Virgo Classic", costs = 17000, description = {}, model = "virgo3"},
				{name = "Albany Manana", costs = 14000, description = {}, model = "manana"},
				{name = "Declasse Voodoo", costs = 16000, description = {}, model = "voodoo"},		
				{name = "Vapid Peyote", costs = 15000, description = {}, model = "peyote"},
				{name = "Declasse Tornado", costs = 15000, description = {}, model = "tornado"},
				{name = "Declasse Tornado Cabrio", costs = 15000, description = {}, model = "tornado2"},
				{name = "Declasse Tornado Custom", costs = 15000, description = {}, model = "tornado5"},
				{name = "Lampadati Pigalle", costs = 12000, description = {}, model = "pigalle"},				
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 7500, description = {}, model = "bifta"},
				{name = "Blazer", costs = 5000, description = {}, model = "blazer"},
				{name = "Brawler", costs = 35000, description = {}, model = "brawler"},
				{name = "Dune Buggy", costs = 15000, description = {}, model = "dune"},
				{name = "Rebel", costs = 30000, description = {}, model = "rebel2"},
				{name = "Sadler", costs = 20000, description = {}, model = "sadler"},
				{name = "Sandking", costs = 60000, description = {}, model = "sandking"},
				{name = "Kamacho", costs = 60000, description = {}, model = "kamacho"},
				{name = "Dubsta 6x6", costs = 85000, description = {}, model = "dubsta3"},
				{name = "Vapid Sandking XL", costs = 85000, description = {}, model = "sandking2"},
				{name = "Canis Mesa Lifted", costs = 80000, description = {}, model = "mesa3"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Cavalcade", costs = 40000, description = {}, model = "cavalcade2"},
				{name = "Granger", costs = 40000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 50000, description = {}, model = "huntley"},
				{name = "Landstalker XL", costs = 35000, description = {}, model = "landstalker2"},
				{name = "Radius", costs = 24500, description = {}, model = "radi"},
				{name = "Rocoto", costs = 45000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 35000, description = {}, model = "seminole"},
				{name = "XLS", costs = 50000, description = {}, model = "xls"},
				{name = "Dubsta", costs = 50000, description = {}, model = "dubsta"},
				{name = "Patriot", costs = 50000, description = {}, model = "patriot"},
				{name = "Gresley", costs = 50000, description = {}, model = "gresley"},
				{name = "Toros", costs = 120000, description = {}, model = "toros"},
				{name = "Bravado Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Bravado Rumpo Custom", costs = 25000, description = {}, model = "rumpo3"},
				{name = "Ubermacht Rebla", costs = 55000, description = {}, model = "rebla"},
				{name = "Lampadati Novak", costs = 55000, description = {}, model = "novak"},		
				{name = "Benefactor Dubsta Mandem", costs = 50000, description = {}, model = "dubsta2"},
				{name = "Benefactor Serrano", costs = 35000, description = {}, model = "serrano"},
				{name = "Vapid Scuffvan Custom", costs = 30000, description = {}, model = "minivan2"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Gang Burrito", costs = 20000, description = {}, model = "gburrito"},
				{name = "Declasse Burrito G2", costs = 13000, description = {}, model = "gburrito2"},
				{name = "Journey", costs = 10000, description = {}, model = "journey"},
				{name = "Minivan", costs = 15000, description = {}, model = "minivan"},
				{name = "Paradise", costs = 15000, description = {}, model = "paradise"},
				{name = "Surfer", costs = 8000, description = {}, model = "surfer"},
				{name = "Youga", costs = 15000, description = {}, model = "youga"},
				{name = "Moonbeam", costs = 15000, description = {}, model = "moonbeam"},
				{name = "Camper", costs = 15000, description = {}, model = "camper"},
				{name = "Vapid Slamvan", costs = 20000, description = {}, model = "slamvan"},
				{name = "Vapid Slamvan Custom", costs = 20000, description = {}, model = "slamvan3"},
				{name = "Bravado Youga Classic", costs = 28000, description = {}, model = "youga2"},
				{name = "Vapid Speedo", costs = 10000, description = {}, model = "speedo"},
				{name = "Brute Pony", costs = 5000, description = {}, model = "pony"},
				{name = "Declasse Moonbeam", costs = 15000, description = {}, model = "moonbeam"},
				{name = "Declasse Moonbeam Custom", costs = 20000, description = {}, model = "moonbeam2"},
				{name = "Canis Mesa", costs = 20000, description = {}, model = "mesa"},
			}
		},
		["a-class"] = {
			title = "a-class",
			name = "a-class",
			buttons = {
				{name = "Dewbauchee Seven-70", costs = 105000, description = {}, model = "seven70"},
				{name = "Dewbauchee Specter", costs = 100000, description = {}, model = "specter"},
				{name = "Dewbauchee Specter Sport", costs = 115000, description = {}, model = "specter2"},
				{name = "Dinka Jester", costs = 120000, description = {}, model = "jester"},
				{name = "Bravado Banshee", costs = 120000, description = {}, model = "banshee"},
				{name = "Invetero Coquette", costs = 115000, description = {}, model = "coquette"},
				{name = "Obey 9F", costs = 100000, description = {}, model = "ninef"},
				{name = "Ocelot Locust", costs = 95000, description = {}, model = "locust"},
				{name = "Obey 9F Cabrio", costs = 100000, description = {}, model = "ninef2"},
				{name = "Albany Alpha", costs = 85000, description = {}, model = "alpha"},
				{name = "Grotti Bestia GTS", costs = 95500, description = {}, model = "bestiagts"},
				{name = "Grotti Carbonizzare", costs = 110000, description = {}, model = "carbonizzare"},
				{name = "Pfister Comet", costs = 115000, description = {}, model = "comet2"},
				{name = "Pfister Comet Retro", costs = 120000, description = {}, model = "comet3"},
				{name = "Benefactor Feltzer", costs = 115000, description = {}, model = "feltzer2"},
				{name = "Dewbauchee Massacro", costs = 120000, description = {}, model = "massacro"},
				{name = "Ocelot Pariah", costs = 130000, description = {}, model = "pariah"},
				{name = "Dewbauchee Rapid GT", costs = 110000, description = {}, model = "rapidgt"},
				{name = "Dewbauchee Rapid GT Cabrio", costs = 110000, description = {}, model = "rapidgt2"},
				{name = "Hijak Ruston", costs = 100000, description = {}, model = "ruston"},
				{name = "Benefactor Schwartzer", costs = 110000, description = {}, model = "schwarzer"},
				{name = "Benefactor Surano", costs = 90000, description = {}, model = "surano"},
				{name = "Enus Cognoscenti Cabrio", costs = 130000, description = {}, model = "cogcabrio"},
				{name = "Ocelot F620", costs = 125000, description = {}, model = "f620"},
				{name = "Ubermacht Zion", costs = 115000, description = {}, model = "zion"},
				{name = "Furore GT", costs = 115000, description = {}, model = "furoregt"},
				{name = "Ubermacht Zion Cabrio", costs = 115000, description = {}, model = "zion2"},
				{name = "Enus Windsor", costs = 90000, description = {}, model = "windsor"},
				{name = "Grotti Brioso R/A", costs = 85000, description = {}, model = "brioso"},
				{name = "Coil Voltic", costs = 125000, description = {}, model = "voltic"},
				{name = "Vapid Dominator", costs = 120000, description = {}, model = "dominator"},
				{name = "Enus Stafford", costs = 80000, description = {}, model = "stafford"},
				{name = "Vapid Blade", costs = 78000, description = {}, model = "blade"},
				{name = "Imponte Dukes", costs = 80000, description = {}, model = "dukes"},
				{name = "Declasse Vamos", costs = 80000, description = {}, model = "vamos"},
				{name = "Vapid Ellie", costs = 82000, description = {}, model = "ellie"},
				{name = "Imponte Ruiner", costs = 85000, description = {}, model = "ruiner"},
				{name = "Declasse Sabre Turbo", costs = 82000, description = {}, model = "sabregt"},
				{name = "Kanjo", costs = 83500, description = {}, model = "kanjo"},
				{name = "Elegy RH8", costs = 80000, description = {}, model = "elegy2"},
				{name = "Penumbra FF", costs = 95000, description = {}, model = "Penumbra2"},
				{name = "Ober Tailgater S", costs = 85000, description = {}, model = "Tailgater2"},
				{name = "Enus Windsor Drop", costs = 90000, description = {}, model = "windsor2"},
				{name = "Ubermacht Sentinel SG4", costs = 115000, description = {}, model = "sentinelsg4"},
				{name = "Sultan", costs = 85000, description = {}, model = "Sultan"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {		
				{name = "Akuma", costs = 27500, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 20000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 28000, description = {}, model = "bati"},
				{name = "BF400", costs = 26000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 30000, description = {}, model = "carbonrs"},
				{name = "Daemon", costs = 20000, description = {}, model = "daemon"},
				{name = "Enduro", costs = 18000, description = {}, model = "enduro"},
				{name = "Faggio", costs = 5000, description = {}, model = "faggio"},
				{name = "Gargoyle", costs = 25000, description = {}, model = "gargoyle"},
				{name = "Hexer", costs = 20000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 20000, description = {}, model = "innovation"},
				{name = "Nemesis", costs = 19000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 15000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 23500, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 20000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 8000, description = {}, model = "sovereign"},
				{name = "Zombiea", costs = 20000, description = {}, model = "zombiea"},
				{name = "Vespa", costs = 5000, description = {}, model = "faggio2"},
				{name = "Manchez", costs = 22000, description = {}, model = "manchez"},
				{name = "Vortex", costs = 21500, description = {}, model = "vortex"},
				{name = "Avarus", costs = 23400, description = {}, model = "avarus"},
				{name = "Vader", costs = 22000, description = {}, model = "vader"},
				{name = "Esskey", costs = 25000, description = {}, model = "esskey"},
				{name = "Defiler", costs = 23750, description = {}, model = "defiler"},
				{name = "Chimera", costs = 22500, description = {}, model = "chimera"},
				{name = "DaemonHigh", costs = 20000, description = {}, model = "daemon2"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 200, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 250, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 400, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 200, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 600, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 600, description = {}, model = "tribike3"},
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-32.953842163086,-1097.5648193359,27.257934570312},
		inside = {-75.283508300781,-819.25714111328,326.17358398438},
		outside = {-32.953842163086,-1097.5648193359,27.257934570312},
	}
}

local carspawns = {
	[1] =  { ['x'] = -39.2861, ['y'] = -1102.435, ['z'] = 26.006631, ['h'] = 206.44213, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -46.8323, ['y'] = -1100.173, ['z'] = 26.009416, ['h'] = 161.24565, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -53.24962, ['y'] = -1094.594, ['z'] = 26.008417, ['h'] = 80.707878, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -45.81505, ['y'] = -1092.928, ['z'] = 26.008174, ['h'] = 98.824806, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -36.01248, ['y'] = -1098.277, ['z'] = 26.009742, ['h'] = 212.33009, ['info'] = ' Car Spot 5' },
}

local carTable = { 
	[1] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[2] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	for i=1, #carTable do
		carTable[currentCarSpawnLocation]["id"] = i
		carTable[currentCarSpawnLocation]["model"] = model
		carTable[currentCarSpawnLocation]["baseprice"] = price
		carTable[currentCarSpawnLocation]["name"] = name
		TriggerServerEvent("fa-pdm:CarTablePDM",carTable)
	end
end

local myspawnedvehs = {}

RegisterNetEvent("fa-pdm:testdrive")
AddEventHandler("fa-pdm:testdrive", function()
	if exports["fa-business"]:IsEmployedAt("pdm") or #(vector3(-30.31887, -1089.345, 26.04948) - GetEntityCoords(PlayerPedId())) > 50.0 then

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-30.31887, -1089.345, 26.04948, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-30.31887, -1089.345, 26.04948, 337.11862,true,false)
		local vehplate = "PDM"..math.random(10000,99999)
		SetVehicleNumberPlateText(veh, vehplate)
		local plate = GetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("keys:addNew",vehplate, plate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		Citizen.Wait(100)
		exports['fa-interface']:hideInteraction()
		myspawnedvehs[veh] = true
		end
	else
		TriggerEvent('DoLongHudText', 'A car is on the spawn point.', 2)
	end
end)

RegisterNetEvent("fa-pdm:EnableBuy")
AddEventHandler("fa-pdm:EnableBuy", function()
	if #(vector3(-30.31887, -1089.345, 26.04948) - GetEntityCoords(PlayerPedId())) > 50.0 and exports["fa-business"]:IsEmployedAt("pdm") then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("fa-pdm:BuyEnabledSV",vehplate)
end)

RegisterNetEvent("fa-pdm:BuyEnabledCL")
AddEventHandler("fa-pdm:BuyEnabledCL", function(addplate)
	buyPlate[addplate] = true
	Citizen.Wait(60000)
	buyPlate[addplate] = nil
end)

RegisterNetEvent("fa-pdm:PDMCommission")
AddEventHandler("fa-pdm:PDMCommission", function(newAmount)
	if exports["fa-business"]:IsEmployedAt("pdm") or #(vector3(-30.31887, -1089.345, 26.04948) - GetEntityCoords(PlayerPedId())) > 50.0 then
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("fa-pdm:CarTablePDM",carTable)
			end
		end
	end
end)

RegisterNetEvent("fa-pdm:ReturnPDMTTable")
AddEventHandler("fa-pdm:ReturnPDMTTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false
local spawnedvehicles = {}
local vehicles_spawned = false

function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlate[addplate] ~= nil then
				TriggerEvent('DoLongHudText', 'Attempting Purchase!', 1)
				AttemptBuy(i, false)
			end
		end
	end
end

function AttemptBuy(tableid)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent('DoLongHudText', 'Could not locate vehicle!', 2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/ 100)

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerEvent("keys:addNew",veh, plate)
	TriggerServerEvent('fa-pdm:ChechMoney',name, model, price)
	commissionbuy = (baseprice * commission / 100)
	Citizen.Wait(100)
	exports['fa-interface']:hideInteraction()
end

function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			icon = "<center><i class='fas fa-car' style=' color: white;font-size: 25px;text-align:center; padding:5px;'></i></center>"
			if exports["fa-business"]:IsEmployedAt("pdm") then
				if buyPlate[addplate] ~= nil then
					exports['fa-interface']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy.")
				else
					exports['fa-interface']:showInteraction("$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if buyPlate[addplate] ~= nil then
					exports['fa-interface']:showInteraction("$" .. math.ceil(price) .. " [G] to buy.")
				else
					exports['fa-interface']:showInteraction("Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		elseif #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			exports['fa-interface']:hideInteraction()
		end
	end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("fa-pdm:RequestPDMTTable")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {191,"Enter"}}
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-30.31887, -1089.345, 26.04948) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-30.31887, -1089.345, 26.04948,"["..Controlkey["generalUse"][2].."] Return Vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 100 then
						currentlocation = b
						if not vehicles_spawned then
--							print("Spawning Display Vehicles?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 35 then
							DrawPrices()
						end

						if exports["fa-business"]:IsEmployedAt("pdm") then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
--							print("Despawning Display ?")
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	if ownerMenu then
		vehshop = vehshopOwner
	else
		vehshop = vehshopDefault
	end

	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	exports['fa-interface']:hideInteraction()
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, plate)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name	
			local vehicle = veh
			local price = price		
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,-30.31887, -1089.345, 26.04948,true,false)
			SetEntityHeading(personalvehicle, 340.06222)
			SetModelAsNoLongerNeeded(model)

			if name == "rumpo" then
				SetVehicleLivery(personalvehicle,0)
			end

			if name == "taxi" then
				SetVehicleExtra(personalvehicle, 8, 0)
				SetVehicleExtra(personalvehicle, 9, 0)
				SetVehicleExtra(personalvehicle, 5, 1)
			end

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end

			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
			SetEntityVisible(ped,true)			
			local primarycolor = colors[1]
			local secondarycolor = colors[2]	
			local pearlescentcolor = extra_colors[1]
			local wheelcolor = extra_colors[2]
			local VehicleProps = exports['fa-bennys']:FetchVehProps(personalvehicle)
			local model = GetEntityModel(personalvehicle)
			local vehname = GetDisplayNameFromVehicleModel(model)
			SetVehicleNumberPlateText(personalvehicle, plate)
			TriggerEvent("keys:addNew",personalvehicle, plate)
			TriggerServerEvent('fa-pdm:BuyVehicle', plate, vehname, vehicle, price, VehicleProps)
			TriggerServerEvent('fa-cardealer:log', exports['isPed']:isPed('cid'), vehname, price, plate, 'PDM')
			TriggerServerEvent('fa-financials:business_money', price / 10, 'pdm', 'add')
			exports['fa-interface']:hideInteraction()
			DespawnSaleVehicles()
			SpawnSaleVehicles()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

RegisterNetEvent("fa-pdm:FailedPurchase")
AddEventHandler("fa-pdm:FailedPurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)


function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,255,55,55,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(250,250,250, 255)
	end

	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,255,255,255)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,55,55,220)
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "B-Class" then
			OpenMenu('b-class')
		elseif btn == "A-Class" then
			OpenMenu('a-class')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "PDM tuners" then
			OpenMenu('pdm-tuners')
		elseif btn == "S-Class" then
			OpenMenu('s-class')
		elseif btn == "C-Class" then
			OpenMenu("c-class")
		elseif btn == "casino" then
			OpenMenu('casino')
		elseif btn == "D-Class" then
			OpenMenu('d-class')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end
	elseif this == "jobvehicles" or this == "a-class" or this == "b-class" or this == "s-class" or this == "pdm-tuners" or this == "c-class" or this == "casino" or this == "d-class" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('fa-pdm:ChechMoney',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "a-class" or vehshop.currentmenu == "b-class" or vehshop.currentmenu == "s-class" or vehshop.currentmenu == "pdm-tuners" or vehshop.currentmenu == "c-class" or vehshop.currentmenu == "casino" or vehshop.currentmenu == "d-class" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if exports["fa-business"]:IsEmployedAt("pdm") and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)

					if button.costs ~= nil then
						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
					end

					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "a-class" or vehshop.currentmenu == "b-class" or vehshop.currentmenu == "s-class" or vehshop.currentmenu == "pdm-tuners" or vehshop.currentmenu == "c-class" or vehshop.currentmenu == "casino" or vehshop.currentmenu == "d-class" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
								local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end
	end
end)

AddEventHandler('FinishMoneyCheckForVehpdm', function(name, vehicle, price, plate)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, plate)
end)

local firstspawn = 0

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('pdmvehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

RegisterCommand('commissionpdm', function(source, args, raw)
	if exports["fa-business"]:IsEmployedAt("pdm") then
		local amount = args[1]
		if tonumber(amount) > 0 and tonumber(amount) <= 60 then
			TriggerEvent('fa-pdm:PDMCommission', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 2)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('testdrivepdm', function(source, args, raw)
	if exports["fa-business"]:IsEmployedAt("pdm") then
		TriggerEvent('fa-pdm:testdrive')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterCommand('enableBuypdm', function(source, args, raw)
	if exports["fa-business"]:IsEmployedAt("pdm") then
		TriggerEvent('fa-pdm:EnableBuy')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterNetEvent('fa-fuel:pdmmenushit', function()


	local menuData = {
		{
			title = "Change Commission",
			icon = 'credit-card',
			key = "EVENTS.CARD",
			action = 'fa-pdm:pdmcom',
			disabled = canPayBill
		},
	}
	exports["fa-interface"]:showContextMenu(menuData)
end)

RegisterInterfaceCallback('fa-pdm:pdmcom', function(data, cb, pParams)
	cb({ data = {}, meta = { ok = true, message = '' } })
	exports['fa-interface']:openApplication('textbox', {
		callbackUrl = 'fa-pdm:send_pdm',
		key = 1,
		items = {
		  {
			icon = "address-card", 
			label = "Commission 0-60%",
			name = "pPDMPayCom",
		  },
		},
	  show = true,
	})
end)

RegisterInterfaceCallback('fa-pdm:send_pdm', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerServerEvent("fa-pdm:wtf", data.values.pPDMPayCom)
end) 



RegisterNetEvent("fa-pdm:commissionpdm") 
AddEventHandler("fa-pdm:commissionpdm", function(args)
	print("YO")
	if exports["fa-business"]:IsEmployedAt("pdm") then
		print("IM PDM WORKER")
		local amount = args
		print(amount)
		if tonumber(amount) > 0 and tonumber(amount) <= 60 then
			TriggerEvent('fa-pdm:PDMCommission', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 2)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end) 

RegisterNetEvent("fa-pdm:testdrivepdm")
AddEventHandler("fa-pdm:testdrivepdm", function()
	if exports["fa-business"]:IsEmployedAt("pdm") then
		TriggerEvent('fa-pdm:testdrive')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterNetEvent("fa-pdm:enableBuypdm")
AddEventHandler("fa-pdm:enableBuypdm", function()
	if exports["fa-business"]:IsEmployedAt("pdm") then
		TriggerEvent('fa-pdm:EnableBuy')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)