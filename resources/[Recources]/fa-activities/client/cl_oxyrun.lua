Config = {
    Peds = {
        [1] = vector4(1602.96, 3708.16, 33.4, 139.44),
        [2] = vector4(569.84, -1023.8, 32.6, 107.48),
        [3] = vector4(-1439.96, -378.16, 37.12, 112.44)
    },

    startped = {
        [1] = vector4(-1564.08, -440.30, 36.01, 133.45)
    },

    Corners = {
        [1] = vector3(1552.72, 3689.92, 34.48),
        [2] = vector3(-152.0987, -2035.403, 22.707763),
        [3] = vector3(673.29071, 201.07421, 93.504981),
        [4] = vector3(-390.8697, -137.8393, 38.527053),
        [5] = vector3(159.5664, -1737.869, 29.254535),
        [6] = vector3(-1326.231, -1044.333, 7.4314107),
        [7] = vector3(-929.9666, 292.97021, 70.701713),
        [8] = vector3(-33.14533, 6516.7802, 31.262533),
        [9] = vector3(1808.0168, 4582.121, 36.248184),
        [10] = vector3(1229.7456, -1692.032, 39.462047)
    },

    CarSpawnLoc = {
        [1] = vector4(1580.16, 3723.08, 34.56, 148.56),
        [2] = vector4(-205.2193, -2022.081, 27.620428, 346.92074),
        [3] = vector4(820.62237, 229.30963, 83.085472, 173.1961),
        [4] = vector4(-475.9742, -100.9482, 38.753559, 257.95483),
        [5] = vector4(100.17118, -1743.51, 29.304788, 310.37442),
        [6] = vector4(-1320.178, -1005.191, 7.6503548, 123.56649),
        [7] = vector4(-857.9289, 185.16496, 71.049156, 346.52008),
        [8] = vector4(107.77635, 6643.8422, 32.445312, 132.68867),
        [9] = vector4(1718.5452, 4702.8959, 42.674926, 94.286613),
        [10] = vector4(1198.0798, -1750.083, 38.662097, 31.035415)
    },

    CarStopLoc = {
        [1] = vector3(1549.28, 3693.36, 34.6),
        [2] = vector3(-153.5692, -2033.492, 22.633916),
        [3] = vector3(673.29071, 201.07421, 93.504981),
        [4] = vector3(-390.5425, -136.652, 38.456768),
        [5] = vector3(158.56784, -1738.366, 29.240036),
        [6] = vector3(-1326.974, -1049.346, 7.4170861),
        [7] = vector3(-929.1844, 292.7286, 70.736282),
        [8] = vector3(-27.98838, 6517.7651, 32.43227),
        [9] = vector3(1809.981, 4579.5952, 36.191501),
        [10] = vector3(1229.7456, -1692.032, 39.462047)
    },

    CarFinishLoc = {
        [1] = vector3(1489.48, 3662.28, 34.68),
        [2] = vector3(-257.1615, -2119.366, 22.096162),
        [3] = vector3(617.05682, 195.23992, 99.008293),
        [4] = vector3(-391.2099, -203.9425, 36.389244),
        [5] = vector3(162.45802, -1817.739, 28.266754),
        [6] = vector3(-1356.246, -1139.402, 4.7198519),
        [7] = vector3(-1002.529, 347.17349, 70.833625),
        [8] = vector3(-175.9005, 6448.1752, 32.133975),
        [9] = vector3(1809.981, 4579.5952, 36.191501),
        [10] = vector3(1314.2027, -1663.54, 51.407882)
    }
}

local collected, runStarted = false, false
local prop = nil
local model, model2 = nil, nil
local ped = nil
local veh = nil
local pedSpawnedWithVehicle = false
local oldugum_bolge = nil
local totalOxyCollected, handoff, jobs = 0, 0, 0
local pPlate = nil
local bliptable = {}

CreateThread(function()
    while true do
        local msec = 5000
        if runStarted and not pedSpawnedWithVehicle then
            for k,v in pairs(Config.Corners) do
                local dist = #(GetEntityCoords(PlayerPedId()) - vector3(v.x, v.y, v.z)) <= 10.0
                if dist then
                    oldugum_bolge = k

                    if not pedSpawnedWithVehicle then
                        pedSpawnedWithVehicle = true

                        model = generateModel()
                        model2 = generatePedModel()

                        while model == nil do Wait(10) end
                        local generateCoords = Config.CarSpawnLoc[oldugum_bolge]

                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Wait(10)
                        end

                        RequestModel(model2)
                        while not HasModelLoaded(model2) do
                            Wait(10)
                        end

                        veh = CreateVehicle(model, generateCoords.x, generateCoords.y, generateCoords.z, generateCoords.w, true, false)
                        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
                        SetModelAsNoLongerNeeded(model)
                        local plate = GetVehicleNumberPlateText(veh)
                        pPlate = plate
                        
                        RequestModel(GetHashKey('a_m_m_soucent_03'))
                        while not HasModelLoaded(GetHashKey('a_m_m_soucent_03')) do
                            Wait(10)
                        end
                        
                        ped = CreatePed('CIVMALE', model2, generateCoords.x+0.3, generateCoords.y, generateCoords.z, generateCoords.w, true, false)
                        SetPedCanBeDraggedOut(ped, false)

                        TaskVehicleDriveToCoord(ped, veh, Config.CarStopLoc[oldugum_bolge].x, Config.CarStopLoc[oldugum_bolge].y, Config.CarStopLoc[oldugum_bolge].z, 10.0, false, model, 316, 0.1, false)
                        SetDriverAggressiveness(ped, 0.0)

                        CreateThread(function()
                            while true do 
                                Wait(25)
                                if #(GetEntityCoords(veh) - vector3(Config.CarStopLoc[oldugum_bolge].x, Config.CarStopLoc[oldugum_bolge].y, Config.CarStopLoc[oldugum_bolge].z)) < 1.0 then
                                    canHandOff = true
                                    FreezeEntityPosition(veh, true)
                                    return
                                end
                            end
                        end)
                    end
                end
            end
            if not runStarted then
                Wait(1000)
            end
        end
        Wait(msec)
    end
end)

RegisterNetEvent('fa-activities:signIntoOxy', function()
    exports['fa-phone']:phoneNotification('jobactivity', 'Signed in as criminal', 'Job Center')
    TriggerServerEvent("jobssystem:jobs", "criminal")
end)

RegisterNetEvent('fa-activities:startOxy', function(locationPed)
    ClearAllBlipRoutes()
    createNewMarker(Config.Peds[locationPed].x, Config.Peds[locationPed].y, 524, 3, 0.7, 'Supplier')
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Head towards the location on your GPS.')

    exports["fa-interact"]:AddPeekEntryByModel(GetHashKey('a_m_m_bevhills_01'), {{
        event = "fa-activities:collectOxyPackages",
        id = "collect-pack",
        icon = "circle",
        label = "Collect Package",
        parameters = {},
    }}, { distance = { radius = 2.5 } })
end)

RegisterNetEvent('fa-activities:collectOxyPackages', function()
    if totalOxyCollected < 10 then
        if not exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
            TriggerEvent("player:receiveItem", "darkmarketpackage", 1, false, nil)
            RPC.execute('fa-activities:syncPackageCollect')
        else
            TriggerEvent('DoLongHudText', 'Put the other package in your trunk before grabbing another.', 2)
        end
    else
        runStarted = true
    end
end)

RegisterNetEvent('fa-activities:collectPackageSync')
AddEventHandler('fa-activities:collectPackageSync', function()
    if totalOxyCollected < 10 then
        ClearAllBlipRoutes()
        for _,v in pairs(bliptable) do
            RemoveBlip(v)
        end

        totalOxyCollected = totalOxyCollected + 1
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..totalOxyCollected..'/10) Packages Collected.')

        if totalOxyCollected == 10 then
            TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'All Packages Collected.')
            RPC.execute('fa-activities:syncGenCornerLoc', math.random(1, 10))
            Citizen.Wait(5000)
            TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Head towards the drop location.')
        end
    else
        TriggerEvent('DoLongHudText', 'You can\'t get anymore.', 2)
    end
end)

RegisterNetEvent('fa-activities:generateFirstOxyDropoff', function(location)
    jobs = jobs + 1
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end

    ClearAllBlipRoutes()
    createNewMarker(Config.Corners[location].x, Config.Corners[location].y, 514, 3, 0.7, 'Corner')
end)

RegisterNetEvent('fa-activities:generateSecondOxyDropoff', function(corneringLocation)
    if jobs == 2 then
        runStarted = false
        jobs = 0
        for _,v in pairs(bliptable) do
            RemoveBlip(v)
        end
        return
    end
    jobs = jobs+1
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Drive to the next location.')
    
    runStarted = false
    handoff = 0
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end

    if corneringLocation == oldugum_bolge then
        if corneringLocation == 3 then
            corneringLocation = corneringLocation-1
        else
            corneringLocation = corneringLocation+1
        end
        ClearAllBlipRoutes()
        createNewMarker(Config.Corners[corneringLocation].x, Config.Corners[corneringLocation].y, 514, 3, 0.7, 'Corner')
    else
        ClearAllBlipRoutes()
        createNewMarker(Config.Corners[corneringLocation].x, Config.Corners[corneringLocation].y, 514, 3, 0.7, 'Corner')
    end

    CreateThread(function()
        while true do 
            Wait(750)
            if #(GetEntityCoords(PlayerPedId()) - vector3(Config.Corners[corneringLocation].x, Config.Corners[corneringLocation].y, Config.Corners[corneringLocation].z)) < 25.0 then
                runStarted = true
                break
            end
        end
    end)
end)

RegisterNetEvent('handoff-package', function()
    local alertCoord = vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z)
    if alertCoord then alertCoord = vector3(alertCoord.x, alertCoord.y, alertCoord.z) end
    local var1, var2 = GetStreetNameAtCoord(alertCoord.x, alertCoord.y, alertCoord.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local street = GetStreetNameFromHashKey(var1)
    local sokak2 = GetStreetNameFromHashKey(var2)
    if sokak2 ~= nil and sokak2 ~= '' then
        street = street .. ', ' .. sokak2
    end

    coordA = GetEntityCoords(PlayerPedId(), 1)
    coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    licensePlate = GetVehicleNumberPlateText(vehicle)

    if exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        if licensePlate == pPlate then
            FreezeEntityPosition(veh, false)
            if handoff < 5 then
                DeleteObject(prop)
                ClearPedTasks(PlayerPedId())
                collected = false
                canHandOff = false
            end
            if handoff == 5 then
                if not secondRun then
                    secondRun = true
                    RPC.execute('fa-activities:generateNewCornerLoc', math.random(1, 10))
                else
                    secondRun = false
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Job Complete.')
                    Citizen.Wait(2500)
                    TriggerEvent('fa-phone:JobNotifyClose')
                end
                return
            end
            local rnd = math.random(1, 2)
            if rnd == 1 then
                RPC.execute("dispatch:addCall", "10-31A", "Investigate Suspicious Actitity", {{icon = "fa-traffic-light", info = street}}, {GetEntityCoords(PlayerPedId())[1], GetEntityCoords(PlayerPedId())[2], GetEntityCoords(PlayerPedId())[3]}, 102, 480, 0)
            end
            TriggerEvent("player:receiveItem", "oxy", math.random(1, 5))
            TriggerEvent("inventory:removeItem", "darkmarketpackage", 1)
            RPC.execute('fa-activities:sendHandoffGroupMembers')
            TriggerEvent('fa-oxyruns:clean')
            Wait(500)
            TaskVehicleDriveWander(ped, veh, 20.0, 16777216)
            SetDriverAggressiveness(ped, 0.0)
            Wait(15000)
            DeleteEntity(ped)
            DeleteEntity(veh)
            pedSpawnedWithVehicle = false
        end
    end
end)

RegisterNetEvent('fa-activities:syncHandoff', function()
    handoff = handoff + 1
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..handoff..'/5) Packages Handed Off.')
end)

generateModel = function()
    local models = {
        'sultan',
        'asea',
        'tailgater',
        'enduro',
        'Dubsta',
        'Cavalcade',
        'Dominator',
        'Phoenix',
        'Defiler',
        'Oracle',
        'Zion',
        'Prairie',
        'Gauntlet',
        'Virgo',
        'Tampa',
        'Stalion',
        'Asterope',
        'Reaper',
        'Zentorno',
        'Osiris',
        'Infernus'
    }
    local generateModel = math.random(1, #models)
    local retval = GetHashKey(models[generateModel])
    return retval
end

generatePedModel = function()
    local peds = {
        'ig_money',
        'a_m_y_beachvesp_02',
        'a_m_y_breakdance_01',
        'ig_car3guy1',
        'a_m_y_business_03',
        's_m_m_cntrybar_01',
        'ig_devin',
        'ig_dreyfuss',
        'a_m_m_fatlatin_01',
        'u_m_y_baygor',
    }
    local generateModel = math.random(1, #peds)
    local retval = GetHashKey(peds[generateModel])
    return retval
end

LoadPropDict = function(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

loadAnimDict = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

function createNewMarker(x, y, sprite, colour, scale, text)
    local blip = AddBlipForCoord(x, y)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, true)
    table.insert(bliptable, blip)
end

function canHandOffPackages()
    if canHandOff then
        canHandOff = true
    elseif not canHandOff then
        canHandOff = false
    end
    return canHandOff
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

local billsCleaningStuff = {
    ["band"] = { extra = 5, price = 100 },
    ["markedbills"] = { extra = 8, price = 250 },
    ["rollcash"] = { extra = 15, price = 30 },
    ["inkset"] = { extra = 15, price = 150 },
}

AddEventHandler("fa-oxyruns:clean", function(pRandomChance)
    local payment = 0
    for typ, conf in pairs(billsCleaningStuff) do
    local randomAmount = math.random(4, 12)
    local randomChance = pRandomChance and pRandomChance or 0.4
    local totalAmount = randomAmount + conf.extra
    if math.random() < randomChance and exports["fa-inventory"]:hasEnoughOfItem(typ, totalAmount, false) then
        TriggerEvent("inventory:removeItem", typ, totalAmount)
        payment = payment + (conf.price * totalAmount)
        payment = payment + math.random(5, 15)
        if exports['fa-hud']:MoneyBuff() then
            TriggerServerEvent('fa-activities:givePayout', payment*2, 'cash', '[Oxy Run | With Buff | Cleaned Bands]')
        else
            TriggerServerEvent('fa-activities:givePayout', payment, 'cash', '[Oxy Run | Without Buff | Cleaned Bands]')
        end
    end
end
    if payment == 0 then
        TriggerServerEvent('fa-activities:givePayout', math.random(150, 350), 'cash', '[Oxy Run | Without Buff | Reg Payout]')
    end
end)

    -- Thread Shit --

    function thread()
    peds = {}    
    
    pedcreate = function(name, hash, x, y, z, h)
        if peds[name] then
            if peds[name].spawn then
                DeletePed(peds[name].ped)
                peds[name].spawn = false
                peds[name].ped = 0
            end
        end
        peds[name] = {hash = hash, x = x, y = y, z = z, h = h, spawn = false, ped = 0}
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            for x, pedData in pairs(peds) do
                local distance = #(coords - vector3(pedData.x, pedData.y, pedData.z))
                if distance < 100 then
                    if not pedData.spawn then
                        Citizen.CreateThread(function()
                            local hash = pedData.hash
                            if not IsModelValid(hash) then 
                                print("[PED] ".. hash .. "("..x..") invalid!")
                            else
                                while not HasModelLoaded(hash) do
                                    RequestModel(hash)
                                    Citizen.Wait(1) 
                                end
                                local ped = CreatePed(4, hash, pedData.x, pedData.y, pedData.z, pedData.h, false, true)
                                FreezeEntityPosition(ped, true)
                                SetEntityInvincible(ped, true)
                                SetBlockingOfNonTemporaryEvents(ped, true)
                                SetModelAsNoLongerNeeded(hash)
                                peds[x].ped = ped
                                peds[x].spawn = true
                            end
                        end)
                    end
                else
                    if pedData.spawn then
                        DeletePed(pedData.ped)
                        peds[x].spawn = false
                        peds[x].ped = 0
                    end
                end
            end
        end
    end)

    for i=1, #Config.Peds do
        pedcreate(Config.Peds[i]..'oxy', GetHashKey('a_m_m_bevhills_01'), Config.Peds[i].x, Config.Peds[i].y, Config.Peds[i].z, Config.Peds[i].w)
    end
    for i=1, #Config.startped do
        pedcreate(Config.startped[i]..'startjob', 0xA8C22996, Config.startped[i].x, Config.startped[i].y, Config.startped[i].z, Config.startped[i].w)
    end

    exports["fa-polytarget"]:AddCircleZone("oxystart", vector3(-1564.06, -440.33, 37.39), 0.55, {
        useZ=true,
    })
    
    exports["fa-interact"]:AddPeekEntryByPolyTarget("oxystart", {
        {
            event = "fa-activities:signIntoOxy",
            id = "oxystart1",
            icon = "circle",
            label = "Sign In.",
            parameters = {},
        }
    }, {
        distance = { radius = 2.5 },
        isEnabled = function()
            return true
        end,
    });      
end

CreateThread(thread)