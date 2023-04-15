Config = {}

Config.DevCommands = false
Config.CreateContractCommand = 'createContract'
Config.FetchInfo = 'fetch'

Config.Database = 'oxmysql' --['ghmattimysql' / 'oxmysql' ]
Config.OldVersion = false
Config.Framework = 'qbcore' --[ 'esx' / 'qbcore' ] -- If you use 'standalone' or 'customfw' some functions may not work as you want
Config.CustomKeySystem = false
-- if you use CustomSystem you need to export this when the door is opened
-- opened export["fa-boosting"]:SetOpenedDoors() this only for continue with process, will not unlock car

Config.XpGain = math.random(1, 10)  --PER CONTRACT
Config.XpGainHackerman = math.random(1, 2)  --PER Hackerman
Config.QueueTimeMin = 30 -- in minutes
Config.QueueTimeMax = 60 -- in minutes
Config.ExtraVinGne = 70  --EXTRA FOR VIN
Config.VinCoolDown = 10080  --IN MINUTES
Config.DisablerCooldown = math.random(10000, 20000) --IN MILLISECONDS  = 10 SECONDS

Config.UnitPrice = 1000

-- if you don't want to use the apps you can disable them
Config.BennysApp = true
Config.BuyApp = true 


Config.NumberOfContracts = {
    D = 4,
    C = 4,
    B = 4,
    A = 4,
    S = 4,
    SPLUS = 4,
}

Config.NumberOfHacks = {  --MAX OF HACKS 10, IF YOU SET MORE WILL GET TONS OF ERRROS
    D = 2,
    C = 4,
    B = 6,
    A = 8,
    S = 9,
    SPLUS = 10,
}

Config.BoostingContracts = {
    ["D"] ={   -- LEVEL 1  
        [1] = {vehicle = "panto", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [2] = {vehicle = "rhapsody", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [3] = {vehicle = "blista", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [4] = {vehicle = "issi2", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [5] = {vehicle = "hermes", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [6] = {vehicle = "hustler", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [7] = {vehicle = "peyote", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [8] = {vehicle = "bodhi2", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [9] = {vehicle = "rancherxl", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [10] = {vehicle = "dloader", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
        [11] = {vehicle = "pigalle", type = "D", owner = "faye", expires = math.random(15000, 20000), units = 5, ExtraVin = 100},
    },
    ["C"] ={   -- LEVEL 2
        [1] = {vehicle = "seminole2", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [2] = {vehicle = "patriot", type    = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [3] = {vehicle = "huntley", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [4] = {vehicle = "fq2", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [5] = {vehicle = "ruiner", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [6] = {vehicle = "sentinel", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [7] = {vehicle = "feltzer", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [8] = {vehicle = "komoda", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [9] = {vehicle = "blista2", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [10] = {vehicle = "stretch", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [11] = {vehicle = "washington", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [12] = {vehicle = "caracara2", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [13] = {vehicle = "guardian", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [14] = {vehicle = "bobcatxl", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [15] = {vehicle = "riata", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [16] = {vehicle = "hotknife", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [17] = {vehicle = "issi3", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [18] = {vehicle = "glendale", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [19] = {vehicle = "chino2", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
        [20] = {vehicle = "ztype", type = "C", owner = "faye", expires = math.random(15000, 20000), units = 15, ExtraVin = 100},
    },
    ["B"] ={   -- LEVEL 3
        [1] = {vehicle = "stanier", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [2] = {vehicle = "warrener", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [3] = {vehicle = "stratum", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [4] = {vehicle = "premier", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [5] = {vehicle = "vstr", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [6] = {vehicle = "sugoi", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [7] = {vehicle = "sentinel2", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [8] = {vehicle = "schafter2", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [9] = {vehicle = "exemplar", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [10] = {vehicle = "jackal", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [11] = {vehicle = "oracle2", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [12] = {vehicle = "outlaw", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [13] = {vehicle = "retinue2", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [14] = {vehicle = "trophytruck", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [15] = {vehicle = "feltzer3", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [16] = {vehicle = "coquette", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [17] = {vehicle = "jugular", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [18] = {vehicle = "issi7", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [19] = {vehicle = "buffalo", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
        [20] = {vehicle = "zion3", type = "B", owner = "faye", expires = math.random(15000, 20000), units = 35, ExtraVin = 100},
    },
    ["A"] ={   -- LEVEL 4
        [1] = {vehicle = "elegy2", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [2] = {vehicle = "fusilade", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [3] = {vehicle = "jester", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [4] = {vehicle = "neon", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [5] = {vehicle = "lc100", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [6] = {vehicle = "seven70", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [7] = {vehicle = "specter", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [8] = {vehicle = "rapidgt", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [9] = {vehicle = "pariah", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [10] = {vehicle = "schwarzer", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [11] = {vehicle = "carbonizzare", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [12] = {vehicle = "dukes", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [13] = {vehicle = "ellie", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [14] = {vehicle = "Penumbra2", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [15] = {vehicle = "Sultan", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [16] = {vehicle = "ninef2", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [17] = {vehicle = "jester", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [18] = {vehicle = "surano", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [19] = {vehicle = "massacro", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
        [20] = {vehicle = "zion", type = "A", owner = "faye", expires = math.random(15000, 20000), units = 85, ExtraVin = 100},
    },
    ["S"] ={   -- LEVEL 5
        [1] = {vehicle = "torero", type = "S", owner = "faye", expires = math.random(15000, 20000), units = 150, ExtraVin = 100},
        [2] = {vehicle = "ztype", type = "S", owner = "faye", expires = math.random(15000, 20000), units = 150, ExtraVin = 100},
        [3] = {vehicle = "turismo2", type = "S", owner = "faye", expires = math.random(15000, 20000), units = 150, ExtraVin = 100},
        [4] = {vehicle = "stingergt", type = "S", owner = "faye", expires = math.random(15000, 20000), units = 150, ExtraVin = 100},
    },
    ["S+"] ={  -- LEVEL 6
        [1] = {vehicle = "turismor", type = "S+", owner = "faye", expires = math.random(15000, 20000), units = 250, ExtraVin = 100},
        [2] = {vehicle = "visione", type = "S+", owner = "faye", expires = math.random(15000, 20000), units = 250, ExtraVin = 100},
        [3] = {vehicle = "xa21", type = "S+", owner = "faye", expires = math.random(15000, 20000), units = 250, ExtraVin = 100},
        [4] = {vehicle = "zorrusso", type = "S+", owner = "faye", expires = math.random(15000, 20000), units = 250, ExtraVin = 100},
    },
}

Config.NumberBoostingLocations = 23  --VEHICLESPAWN LOCATIONS
Config.BoostinSpawnLocations = {
    [1] = {coords = vector3(-775.96527099609,-193.89460754395,37.283687591553)},
    [2] = {coords = vector3(-355.91485595703,32.215831756592,47.796535491943)},
    [3] = {coords = vector3(80.010726928711,88.372627258301,78.57487487793)},
    [4] = {coords = vector3(974.43048095703,-228.11796569824,69.771072387695)},
    [5] = {coords = vector3(-1219.7900390625,-658.20697021484,40.357620239258)},
    [6] = {coords = vector3(-69.75252532959,83.473098754883,71.50944519043)},
    [7] = {coords = vector3(10.328959465027,6588.6694335938,32.469841003418)},
    [8] = {coords = vector3(-560.48, 301.88, 82.75)},
    [9] = {coords = vector3(-753.77, 356.53, 87.44)},
    [10] = {coords = vector3(-1662.42, -384.56, 44.42)},
    [11] = {coords = vector3(253.19, -3059.2, 5.36)},
    [12] = {coords = vector3(344.13, -2684.3, 5.64)},
    [13] = {coords = vector3(1204.27, -3116.46, 5.12)},
    [14] = {coords = vector3(757.04, -3195.09, 5.65)},
    [15] = {coords = vector3(1015.08, -2524.98, 27.88)},
    [16] = {coords = vector3(855.68, -2496.68, 27.9)},
    [17] = {coords = vector3(819.73, -2403.3, 23.24)},
    [18] = {coords = vector3(845.48, -2360.9, 29.92)},
    [19] = {coords = vector3(1090.75, -2404.22, 30.13)},
    [20] = {coords = vector3(1075.73, -2323.9, 29.87)},
    [21] = {coords = vector3(1000.73, -1559.97, 30.34)},
    [22] = {coords = vector3(942.02, -1496.56, 29.66)},
    [23] = {coords = vector3(952.82, -1513.12, 30.68)},
}

Config.NumberDropZones = 12  --NORMAL DROP
Config.DropZones = {
    [1] = {coords = vector3(201.88290405273,-158.49359130859,56.783882141113)},
    [2] = {coords = vector3(-1277.8936767578,-280.75573730469,38.155086517334)},
    [3] = {coords = vector3(516.95355224609,-540.58734130859,24.73127746582)},
    [4] = {coords = vector3(-1079.4503173828,-2172.3471679688,13.281025886536)},
    [5] = {coords = vector3(166.01, 2283.64, 93.01)},
    [6] = {coords = vector3(-114.41, -56.9, 55.95)},
    [7] = {coords = vector3(-368.99, -98.6, 45.24)},
    [8] = {coords = vector3(-461.68, -62.0, 44.09)},
    [9] = {coords = vector3(-357.32, 78.49, 62.88)},
    [10] = {coords = vector3(-487.21, 171.65, 70.51)},
    [11] = {coords = vector3(-446.19, 291.44, 82.81)},
    [12] = {coords = vector3(-560.48, 301.88, 82.75)},
}

Config.NumberVinDropZones = 1 --VIN SCRATCH
Config.VinDropZones = {
    [1] = {coords = vector3(479.78033447266,-1315.9255371094,29.203012466431)}
}

--BENNYS
Config.NumberDropBennysZones = 2 --BENNYS PARTS
Config.DropBennysZones = {
    [1] = {coords = vector3(1182.705078125,-3322.177734375,6.0287265777588)},
    [2] = {coords = vector3(1778.5551757812,3641.6020507812,34.496780395508)},
}


Config.ConsumableItemsEnable = true
Config.PerformanceObjectEnable = true
Config.CosmeticObjectEnable = true

--Bennys
Config.ConsumableItems = { --Set Consumable Items In Bennys App
    {label = 'Adv Repair Kit', item = 'advrepairkit', price = 5, icon =   'https://i.imgur.com/EUwJpsq.png'},
    {label = 'Harness', item = 'harness', price = 25, icon =   'https://i.imgur.com/Im1s1TI.png'},
    {label = 'Nitrous', item = 'nitrous', price = 50, icon =   'https://i.imgur.com/BvFyGLh.png'},
    {label = 'Tracker Disabler', item = 'trackerdisabler', price = 50, icon =   'https://i.imgur.com/hTCokqn.png'},
}

Config.PerformanceObject = { --Set Performance Items In Bennys App
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Performance', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
}

Config.CosmeticObject =  {  --Set Cosmetic Items In Bennys App
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
    -- {label = 'Item Cosmetic', item = 'item', price = 125, icon = 'https://imgur.com/UxYwiKC.png'},
}

CustomMinigame = function()  --The minigame will start when you lockpick a vehicle, [NEEDS TO RETURN TRUE OR FALSE]
    local game = exports["fa-ui"]:taskBarSkill(1200,7)
    if game == 100 then
        return true  
    else
        return false  
    end
end

CustomMinigameHack = function() --The minigame will start when you get in car, [NEEDS TO RETURN TRUE OR FALSE]
    local types =  math.random(1,5)
    if types == 1 then
        return exports["fa-minigame"]:Open()
    elseif types == 2 then
        return exports["fa-minigame"]:Open()
    elseif types == 3 then
        return exports["fa-minigame"]:Open()
    elseif types == 4 then
        return exports["fa-minigame"]:Open()
    elseif types == 5 then
        return exports["fa-minigame"]:Open()
    end
end