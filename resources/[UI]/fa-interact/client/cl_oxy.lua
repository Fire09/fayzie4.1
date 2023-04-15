--#############--
--## VOID RP ##--
--#############--

-- MADE BY EVAN --

local Entries = {}

-- Sell Locations Start --

local HeadingToEastJoshua = false
local HeadingToNorthRockford = false
local HeadingToClinton = false

local spawnCoord1 = nil
local spawnCoord2 = nil

-- Sell Locations End

-- Start Of Pickup Locations --

local LocationPickup1 = false
local LocationPickup2 = false
local LocationPickup3  = false

-- End Of Pickup Locations --

-- Random Locals --

local OnTheWayToDropoffLocation1 = false
local CanCollectPackageLocation1 = true
local CanSell1 = false

local OnTheWayToDropoffLocation2 = false
local CanCollectPackageLocation2 = true
local CanSell2 = false

local OnTheWayToDropoffLocation3 = false
local CanCollectPackageLocation3 = true
local CanSell3 = false

-- End Of Random Locals --

-- Start Of Check For Dirty Money -- 

RegisterNetEvent('fa-illegalactivities:check_for_illegal_cash')
AddEventHandler('fa-illegalactivities:check_for_illegal_cash', function()
    if exports['fa-inventory']:hasEnoughOfItem('cashroll', 5) then
        TriggerServerEvent('fa-illegalactivities:oxy_payment', math.random(75, 100))
        TriggerEvent('inventory:removeItem', 'cashroll', 5)
    elseif exports['fa-inventory']:hasEnoughOfItem('band', 5) then
        TriggerEvent('inventory:removeItem', 'band', 5)
        TriggerServerEvent('fa-illegalactivities:oxy_payment', math.random(456, 786))
    end
end)

-- Shibiz n Dat -- 

RegisterNetEvent('fa-illegalactivities:location')
AddEventHandler('fa-illegalactivities:location', function()
    if EvanOxyLocation1 then
        TriggerEvent('fa-illegalactivities:sell_package')
        print('[EVAN 1] - VOID RP OXY RUNS - MADE BY Evan')
        TriggerEvent('fa-illegalactivities:call_cops')
    elseif EvanOxyLocation2 then
        print('[EVAN 2] - VOID RP OXY RUNS - MADE BY Evan')
        TriggerEvent('fa-illegalactivities:sell_package_location2')
        TriggerEvent('fa-illegalactivities:call_cops')
    elseif EvanOxyLocation3 then
        print('[EVAN 3] - VOID RP OXY RUNS - MADE BY Evan')
        TriggerEvent('fa-illegalactivities:sell_package_location3')
        TriggerEvent('fa-illegalactivities:call_cops')
    end
end)

local VehicleModels = {
    [1] = 'feltzer',
    [2] = 'felon',
    [3] = 'blista',
    [4] = 'jackal',
    [5] = 'oracle2',
    [6] = 'buffalo',
    [7] = 'voodoo2',
    [8] = 'premier',
    [9] = 'washington',
    [10] = 'primo2'
}

local PedModels = {
    [1] = 'a_f_y_business_02',
    [2] = 'a_f_y_tourist_01',
    [3] = 'a_f_y_tourist_01',
    [4] = 'a_m_m_socenlat_01'
}

local StartedOxyRun = false

local LocationPickup3 = false

local EvanFirstLocalStarted = false

local PackagesCollected = 0
local PackagesToDrop = 0

RegisterNetEvent('fa-oxy:start_run')
AddEventHandler('fa-oxy:start_run', function()
    if not StartedOxyRun then
        if exports['fa-inventory']:hasEnoughOfItem('vpnxj', 1) then
            exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Checked in as Oxy Runner.')
            StartedOxyRun = true
            Citizen.Wait(math.random(1, 180000))
            TriggerEvent('fa-oxyrun:get_packagelocation')
            Citzen.Wait(180000)
            StartedOxyRun = false
        else
            TriggerEvent('DoLongHudText', 'You need a VPN', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You\'re already on a oxy run, or recently finished a run.', 2)
    end
end)

RegisterNetEvent('fa-oxy:clock_out')
AddEventHandler('fa-oxy:clock_out', function()
    if StartedOxyRun then
        TriggerEvent('phone:addJobNotify', 'Clocked Out.')
        StartedOxyRun = false
        PackagesCollected = 0
        PackagesToDrop = 0
    end
end)


-- Package Location --

RegisterNetEvent('fa-oxyrun:get_packagelocation')
AddEventHandler('fa-oxyrun:get_packagelocation', function()
    local PedLoc = math.random(1, 3)
    if PedLoc == 1 then
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Head towards the area on your GPS and grab the packages.')
        LocationPickup1 = true
        TriggerEvent('fa-illegalactivities:create_location1_oxy_ped_and_blip')
    elseif PedLoc == 2 then
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Head towards the area on your GPS and grab the packages.')
        LocationPickup2 = true
        TriggerEvent('fa-illegalactivities:create_location2_oxy_ped_and_blip')
    elseif PedLoc == 3 then
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Head towards the area on your GPS and grab the packages.')
        LocationPickup3 = true
        TriggerEvent('fa-illegalactivities:create_location3_oxy_ped_and_blip')
    end
end)

RegisterNetEvent('fa-illegalactivities:call_cops')
AddEventHandler('fa-illegalactivities:call_cops', function()
    local EvanChance = math.random(1, 2)
    if EvanChance == 1 then
        TriggerEvent('fa-mdt:drugsale')
    elseif EvanChance == 2 then
        print('[VoidRP] RND')
    end
end)

-- Package Location End --

-- Sell Location --

RegisterNetEvent('fa-illegalactivities:go_to_sell_location')
AddEventHandler('fa-illegalactivities:go_to_sell_location', function()
    local EvanOxySellLocations = math.random(1, 2)
    if EvanOxySellLocations == 1 then
        print('GO TO SELL LOCATION 1')
        EvanFirstLocalStarted = false
        HeadingToNorthRockford = true
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Head over to North Rockford Drive.') 

        OxyLocationSell1 = AddBlipForCoord(-1945.648, 324.43765, 89.591361)
        SetBlipSprite(OxyLocationSell1, 473)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Oxy Sales Location")
        EndTextCommandSetBlipName(OxyLocationSell1)
        SetBlipRoute(OxyLocationSell1, true)
        SetBlipRouteColour(OxyLocationSell1, 3)
    elseif EvanOxySellLocations == 2 then
        print('GO TO SELL LOCATION 2')
        EvanFirstLocalStarted = false
        HeadingToEastJoshua = true
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'Head over to Seaview Road.') 
        EvanFirstLocalStarted = false

        OxyLocationSell2 = AddBlipForCoord(1809.3687, 4581.3452, 36.135059)
        SetBlipSprite(OxyLocationSell2, 473)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Oxy Sales Location")
        EndTextCommandSetBlipName(OxyLocationSell2)
        SetBlipRoute(OxyLocationSell2, true)
        SetBlipRouteColour(OxyLocationSell2, 3)
    end
end)

-- Sell Location End --

-- Location 1 --

EvanOxyLocation1 = false

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("evan_oxy_location_inside_1", vector3(-1931.29, 327.56, 89.75), 25, 40, {
        name="evan_oxy_location_inside_1",
        heading=10,
    })
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "evan_oxy_location_inside_1" then
        EvanOxyLocation1 = true     
        if EvanOxyLocation1 and not EvanFirstLocalStarted and HeadingToNorthRockford then
            print('SENDING FIRST LOCAL TO LOCATION | Location 1')
            OnTheWayToDropoffLocation1 = true
            TriggerEvent('fa-illegalactivities:ped_to_sellpoint1')
        else
            print('NOT ON THE RUN 1')
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "evan_oxy_location_inside_1" then
        EvanOxyLocation1 = false
    end
end)

RegisterNetEvent('fa-illegalactivities:evan_oxyrun:getpackages_1')
AddEventHandler('fa-illegalactivities:evan_oxyrun:getpackages_1', function()
    if not exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        if CanCollectPackageLocation1 then
            TriggerEvent('player:receiveItem', 'darkmarketpackage', 1)
            CanCollectPackageLocation1 = false
            PackagesCollected = PackagesCollected + 1
            RemoveBlip(OxyLocation1Collect)
            exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesCollected..'/5) Packages Collected') 
            if PackagesCollected == 5 then
                Citizen.Wait(5000)
                DeleteEntity(created_ped)
                LocationPickup1 = false
                PackagesCollected = 0
                TriggerEvent('fa-illegalactivities:go_to_sell_location')
                OnTheWayToDropoffLocation1 = true
            else
                Citizen.Wait(10000)
                CanCollectPackageLocation1 = true
            end
        else
            TriggerEvent('DoLongHudText', 'You feel a little tired, wait a few seconds', 2)
        end
    elseif exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        TriggerEvent('DoLongHudText', 'You aint quite learnt how to multitask yet', 2)
    end
end)

RegisterNetEvent('fa-illegalactivities:create_location1_oxy_ped_and_blip')
AddEventHandler('fa-illegalactivities:create_location1_oxy_ped_and_blip', function()
    modelHash = GetHashKey("csb_ramp_gang")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    created_ped = CreatePed(0, modelHash , 558.92376, -1037.308, 31.779758 -1, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityHeading(created_ped, 89.084686)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_AA_SMOKE", 0, true)

    OxyLocation1Collect = AddBlipForCoord(557.91583, -1025.197, 31.534187)
    SetBlipSprite(OxyLocation1Collect, 524)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Oxy Collect Location")
    EndTextCommandSetBlipName(OxyLocation1Collect)
    SetBlipRoute(OxyLocation1Collect, true)
    SetBlipRouteColour(OxyLocation1Collect, 3)
end)

exports["fa-polytarget"]:AddBoxZone("evan_oxyruns_ped_1", vector3(559.0, -1037.3, 31.34), 0.8, 0.8, {
    heading=0,
    minZ=28.74,
    maxZ=32.74
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("evan_oxyruns_ped_1", {{
    event = "fa-illegalactivities:evan_oxyrun:getpackages_1",
    id = "evan_oxyruns_ped_1",
    icon = "circle",
    label = "Collect Package",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return LocationPickup1
    end,
});

RegisterNetEvent('fa-illegalactivities:sell_package')
AddEventHandler('fa-illegalactivities:sell_package', function()
    local OxyChance = math.random(1, 2)
    coordA = GetEntityCoords(PlayerPedId(), 1)
	coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	vehicle = getVehicleInDirection(coordA, coordB)

    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		licensePlate = GetVehicleNumberPlateText(vehicle)
        print('License Plate: '..licensePlate)
        print('Vehicle: '..vehicle)
		if licensePlate == setOxyVehicle then
            if OnTheWayToDropoffLocation1 then
                if CanSell2 or CanSell3 or CanSell1 then
                    if exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
                        HeadingToNorthRockford = false
                        TriggerEvent('inventory:removeItem', 'darkmarketpackage', 1)
                        TriggerServerEvent('fa-illegalactivities:oxy_payment', math.random(88, 175))
                        TriggerEvent('player:receiveItem', 'oxy', 2)
                        TriggerEvent('fa-illegalactivities:check_for_illegal_cash')
                        PackagesToDrop = PackagesToDrop + 1 
                        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesToDrop..'/5) Packages Dropped Off.') 
                        RemoveBlip(OxyLocationSell1)
                        print(Vehicle)

                        DeleteEntity(veh)
                        DeleteEntity(driverPed)
                        CanSell1 = false
                        Citizen.Wait(7000)
                        print('PASSED')
                        TriggerEvent('fa-illegalactivities:ped_to_sellpoint1')
                    else
                        TriggerEvent('DoLongHudText', 'Well I need one of those packages to buy ...', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'This is not your customer', 2)
                end
            end
        end
    else
        TriggerEvent('DoLongHudText', 'This is not your customer', 2)
    end
end)

RegisterNetEvent('fa-illegalactivities:sell_point_1_coords')
AddEventHandler('fa-illegalactivities:sell_point_1_coords', function()
    local OxyCoords = math.random(3)
    if OxyCoords == 1 then
        spawnCoord1 = vector3(-1868.433, 327.90695, 88.634056)
    elseif OxyCoords == 2 then
        spawnCoord1 = vector3(-1953.272, 400.87396, 96.25521)
    elseif OxyCoords == 3 then
        spawnCoord1 = vector3(-1928.685, 255.01237, 85.339492)
    end
end)

RegisterNetEvent('fa-illegalactivities:ped_to_sellpoint1')
AddEventHandler('fa-illegalactivities:ped_to_sellpoint1', function()
    EvanFirstLocalStarted = true

    local radius = 1.00
    TriggerEvent('fa-illegalactivities:sell_point_1_coords')

    local model = VehicleModels[math.random(10)]
    local vehicaleHash = GetHashKey(model)
    RequestModel(vehicaleHash)
    while not HasModelLoaded(vehicaleHash) do
        Wait(1)
    end

    local npcped = PedModels[math.random(4)]
    local npcpedhash = GetHashKey(npcped)
    RequestModel(npcpedhash)
    while not HasModelLoaded(npcpedhash) do
        Wait(1)
    end

    if PackagesToDrop == 5 then
        StartedOxyRun = false
        print(PackagesToDrop)
        PackagesToDrop = 0
        print(PackagesToDrop)
        Citizen.Wait(13000)
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'The Job Offer Was Completed.') 
    else
        print('x Coordinate: '..spawnCoord1.x)
        print('y Coordinate: '..spawnCoord1.y)
        print('z Coordinate: '..spawnCoord1.z)

        veh = CreateVehicle(vehicaleHash, spawnCoord1.x, spawnCoord1.y, spawnCoord1.z, 0.0, true, false)
        driverPed = CreatePed(0, npcpedhash, spawnCoord1.x+2, spawnCoord1.y+2, spawnCoord1.z+1, 0, true, false)
        print(x, y, z)
        TaskWarpPedIntoVehicle(driverPed, veh, -1)
        SetModelAsNoLongerNeeded(npcpedhash)
        SetBlockingOfNonTemporaryEvents(driverPed, true)
        SetModelAsNoLongerNeeded(model)
        local plate = GetVehicleNumberPlateText(veh)
        setOxyVehicle = plate

        Citizen.Wait(5000)
        TaskVehicleDriveToCoord(driverPed, veh, -1945.648, 324.43765, 89.591361, 10.0, false, model, 8388614, 2.0, 0)
        CanSell2 = true
        print(CanSell2)
    end
end)

-- End Location 1 Shit --

-- Location 2 --

EvanOxyLocation2 = false

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("evan_oxy_location_inside_2", vector3(1807.56, 4577.12, 36.14), 25, 30, {
        name="evan_oxy_location_inside_2",
        heading=0,
    })
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "evan_oxy_location_inside_2" then
        EvanOxyLocation2 = true     
        if EvanOxyLocation2 and not EvanFirstLocalStarted and HeadingToEastJoshua then
            print('SENDING FIRST LOCAL TO LOCATION | Location 2')
            OnTheWayToDropoffLocation2 = true
            TriggerEvent('fa-illegalactivities:ped_to_sellpoint2')
        else
            print('NOT ON THE RUN 2')
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "evan_oxy_location_inside_2" then
        EvanOxyLocation2 = false
    end
end)

RegisterNetEvent('fa-illegalactivities:evan_oxyrun:getpackages_2')
AddEventHandler('fa-illegalactivities:evan_oxyrun:getpackages_2', function()
    if not exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        if CanCollectPackageLocation2 then
            TriggerEvent('player:receiveItem', 'darkmarketpackage', 1)
            CanCollectPackageLocation2 = false
            PackagesCollected = PackagesCollected + 1
            RemoveBlip(OxyLocation2Collect)
            exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesCollected..'/5) Packages Collected') 
            if PackagesCollected == 5 then
                Citizen.Wait(5000)
                DeleteEntity(ped_created)
                LocationPickup2 = false
                PackagesCollected = 0
                TriggerEvent('fa-illegalactivities:go_to_sell_location')
                OnTheWayToDropoffLocation2 = true
            else
                Citizen.Wait(10000)
                CanCollectPackageLocation2 = true
            end
        else
            TriggerEvent('DoLongHudText', 'You feel a little tired, wait a few seconds', 2)
        end
    elseif exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        TriggerEvent('DoLongHudText', 'You aint quite learnt how to multitask yet', 2)
    end
end)

-- Create Ped For Sale Start --

RegisterNetEvent('fa-illegalactivities:create_location2_oxy_ped_and_blip')
AddEventHandler('fa-illegalactivities:create_location2_oxy_ped_and_blip', function()
    modelHash = GetHashKey("csb_ramp_gang")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    ped_created = CreatePed(0, modelHash , -1024.586, 2892.2041, 6.3962297 -1, true)
    FreezeEntityPosition(ped_created, true)
    SetEntityHeading(ped_created, 276.82211)
    SetEntityInvincible(ped_created, true)
    SetBlockingOfNonTemporaryEvents(ped_created, true)
    TaskStartScenarioInPlace(ped_created, "WORLD_HUMAN_AA_SMOKE", 0, true)

    OxyLocation2Collect = AddBlipForCoord(-1024.586, 2892.2041, 6.3962297)
    SetBlipSprite(OxyLocation2Collect, 524)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Oxy Collect Location")
    EndTextCommandSetBlipName(OxyLocation2Collect)
    SetBlipRoute(OxyLocation2Collect, true)
    SetBlipRouteColour(OxyLocation2Collect, 3)
end)

exports["fa-polytarget"]:AddBoxZone("evan_oxyruns_ped_2", vector3(-1024.59, 2892.2, 6.4), 0.8, 0.8, {
    heading=0,
    --debugPoly=true,
    minZ=3.4,
    maxZ=7.4
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("evan_oxyruns_ped_2", {{
    event = "fa-illegalactivities:evan_oxyrun:getpackages_2",
    id = "evan_oxyruns_ped_2",
    icon = "circle",
    label = "Collect Package",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return LocationPickup2
    end,
});

-- Create Ped For Sale End --

-- Sell Location Start --

RegisterNetEvent('fa-illegalactivities:sell_package_location2')
AddEventHandler('fa-illegalactivities:sell_package_location2', function()
    local OxyChance = math.random(1, 2)
    coordA = GetEntityCoords(PlayerPedId(), 1)
	coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	vehicle = getVehicleInDirection(coordA, coordB)

    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		licensePlate = GetVehicleNumberPlateText(vehicle)
        print('License Plate: '..licensePlate)
        print('Vehicle: '..vehicle)
		if licensePlate == setOxyVehicle then
            if OnTheWayToDropoffLocation2 then
                if CanSell2 or CanSell3 or CanSell1 then
                    if exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
                        HeadingToEastJoshua = false
                        TriggerEvent('inventory:removeItem', 'darkmarketpackage', 1)
                        TriggerServerEvent('fa-illegalactivities:oxy_payment', math.random(88, 175))
                        TriggerEvent('player:receiveItem', 'oxy', 2)
                        TriggerEvent('fa-illegalactivities:check_for_illegal_cash')
                        PackagesToDrop = PackagesToDrop + 1 
                        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesToDrop..'/5) Packages Dropped Off.') 
                        RemoveBlip(OxyLocationSell2)
                        
                        DeleteEntity(veh)
                        DeleteEntity(driverPed)
                        CanSell2 = false
                        Citizen.Wait(7000)
                        TriggerEvent('fa-illegalactivities:ped_to_sellpoint2')
                    else
                        TriggerEvent('DoLongHudText', 'Well I need one of those packages to buy ...', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'This is not your customer', 2)
                end
            end
        end
    else
        TriggerEvent('DoLongHudText', 'This is not your customer', 2)
    end
end)

RegisterNetEvent('fa-illegalactivities:sell_point_2_coords')
AddEventHandler('fa-illegalactivities:sell_point_2_coords', function()
    local OxyCoords = math.random(3)
    if OxyCoords == 1 then
        spawnCoord2 = vector3(1704.7603, 4649.0361, 43.539546)
    elseif OxyCoords == 2 then
        spawnCoord2 = vector3(1910.596, 4611.0825, 38.181156)
    elseif OxyCoords == 3 then
        spawnCoord2 = vector3(1965.1672, 4609.3813, 40.348526)
    end
end)

RegisterNetEvent('fa-illegalactivities:ped_to_sellpoint2')
AddEventHandler('fa-illegalactivities:ped_to_sellpoint2', function()
    EvanFirstLocalStarted = true

    local radius = 1.00
    TriggerEvent('fa-illegalactivities:sell_point_2_coords')

    local model = VehicleModels[math.random(10)]
    local vehicaleHash = GetHashKey(model)
    RequestModel(vehicaleHash)
    while not HasModelLoaded(vehicaleHash) do
        Wait(1)
    end

    local npcped = PedModels[math.random(4)]
    local npcpedhash = GetHashKey(npcped)
    RequestModel(npcpedhash)
    while not HasModelLoaded(npcpedhash) do
        Wait(1)
    end

    if PackagesToDrop == 5 then
        StartedOxyRun = false
        print(PackagesToDrop)
        PackagesToDrop = 0
        print(PackagesToDrop)
        Citizen.Wait(13000)
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'The Job Offer Was Completed.') 
    else
        print('x Coordinate: '..spawnCoord2.x)
        print('y Coordinate: '..spawnCoord2.y)
        print('z Coordinate: '..spawnCoord2.z)
        
        veh = CreateVehicle(vehicaleHash, spawnCoord2.x, spawnCoord2.y, spawnCoord2.z, 0.0, true, false)
        driverPed = CreatePed(0, npcpedhash, spawnCoord2.x+2, spawnCoord2.y+2, spawnCoord2.z+1, 0, true, false)
        print(x, y, z)
        TaskWarpPedIntoVehicle(driverPed, veh, -1)
        SetModelAsNoLongerNeeded(npcpedhash)
        SetBlockingOfNonTemporaryEvents(driverPed, true)
        SetModelAsNoLongerNeeded(model)
        local plate = GetVehicleNumberPlateText(veh)
        setOxyVehicle = plate

        Citizen.Wait(5000)
        TaskVehicleDriveToCoord(driverPed, veh, 1806.6345, 4581.7597, 36.228626, 10.0, false, model, 8388614, 2.0, 0)
        CanSell2 = true
        print(CanSell2)
    end
end)

-- Sell Location End --

-- End Location 2 Shit --

-- Location 3 --

EvanOxyLocation3 = false

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("evan_oxy_location_inside_3", vector3(673.85, 197.74, 94.65), 25, 40.4, {
        name="evan_oxy_location_inside_3",
        heading=345,
    })
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "evan_oxy_location_inside_3" then
        EvanOxyLocation3 = true     
        if EvanOxyLocation3 and not EvanFirstLocalStarted and HeadingToClinton then
            print('SENDING FIRST LOCAL TO LOCATION | Location 3')
            CanCollectPackageLocation3 = true
            TriggerEvent('fa-illegalactivities:ped_to_sellpoint3')
        else
            print('NOT ON THE RUN 3')
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "evan_oxy_location_inside_3" then
        EvanOxyLocation3 = false
    end
end)

RegisterNetEvent('fa-illegalactivities:evan_oxyrun:getpackages_3')
AddEventHandler('fa-illegalactivities:evan_oxyrun:getpackages_3', function()
    if not exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        if CanCollectPackageLocation3 then
            TriggerEvent('player:receiveItem', 'darkmarketpackage', 1)
            CanCollectPackageLocation3 = false
            PackagesCollected = PackagesCollected + 1
            RemoveBlip(OxyLocation3Collect)
            exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesCollected..'/5) Packages Collected') 
            if PackagesCollected == 5 then
                Citizen.Wait(5000)
                DeleteEntity(evan_ped_dog_innit)
                LocationPickup3 = false
                PackagesCollected = 0
                TriggerEvent('fa-illegalactivities:go_to_sell_location')
                CanCollectPackageLocation3 = true
            else
                Citizen.Wait(10000)
                CanCollectPackageLocation3 = true
            end
        else
            TriggerEvent('DoLongHudText', 'You feel a little tired, wait a few seconds', 2)
        end
    elseif exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
        TriggerEvent('DoLongHudText', 'You aint quite learnt how to multitask yet', 2)
    end
end)

-- Create Ped For Sale Start --

RegisterNetEvent('fa-illegalactivities:create_location3_oxy_ped_and_blip')
AddEventHandler('fa-illegalactivities:create_location3_oxy_ped_and_blip', function()
    modelHash = GetHashKey("csb_ramp_gang")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    evan_ped_dog_innit = CreatePed(0, modelHash , 1161.2382, -1383.723, 34.740676 -1, true)
    FreezeEntityPosition(evan_ped_dog_innit, true)
    SetEntityHeading(evan_ped_dog_innit, 355.30395)
    SetEntityInvincible(evan_ped_dog_innit, true)
    SetBlockingOfNonTemporaryEvents(evan_ped_dog_innit, true)
    TaskStartScenarioInPlace(evan_ped_dog_innit, "WORLD_HUMAN_AA_SMOKE", 0, true)

    OxyLocation3Collect = AddBlipForCoord(1161.2382, -1383.723, 34.740676)
    SetBlipSprite(OxyLocation3Collect, 524)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Oxy Collect Location")
    EndTextCommandSetBlipName(OxyLocation3Collect)
    SetBlipRoute(OxyLocation3Collect, true)
    SetBlipRouteColour(OxyLocation3Collect, 3)
end)

exports["fa-polytarget"]:AddBoxZone("evan_oxyruns_ped_3", vector3(1161.24, -1383.72, 34.74), 0.8, 0.8, {
    heading=0,
    --debugPoly=true,
    minZ=31.74,
    maxZ=35.74
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("evan_oxyruns_ped_3", {{
    event = "fa-illegalactivities:evan_oxyrun:getpackages_3",
    id = "evan_oxyruns_ped_3",
    icon = "circle",
    label = "Collect Package",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return LocationPickup3
    end,
});

-- Create Ped For Sale End --

-- Sell Location Start --

RegisterNetEvent('fa-illegalactivities:sell_package_location3')
AddEventHandler('fa-illegalactivities:sell_package_location3', function()
    local OxyChance = math.random(1, 2)
    coordA = GetEntityCoords(PlayerPedId(), 1)
	coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	vehicle = getVehicleInDirection(coordA, coordB)

    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		licensePlate = GetVehicleNumberPlateText(vehicle)
        print('License Plate: '..licensePlate)
        print('Vehicle: '..vehicle)
		if licensePlate == setOxyVehicle then
            if CanCollectPackageLocation3 then
                if CanSell2 or CanSell3 or CanSell1 then
                    if exports['fa-inventory']:hasEnoughOfItem('darkmarketpackage', 1) then
                        HeadingToClinton = false
                        TriggerEvent('inventory:removeItem', 'darkmarketpackage', 1)
                        TriggerServerEvent('fa-illegalactivities:oxy_payment', math.random(88, 175))
                        TriggerEvent('player:receiveItem', 'oxy', 2)
                        TriggerEvent('fa-illegalactivities:check_for_illegal_cash')
                        PackagesToDrop = PackagesToDrop + 1 
                        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", '('..PackagesToDrop..'/5) Packages Dropped Off.') 
                        RemoveBlip(OxyLocationSell3)
                        
                        DeleteEntity(veh)
                        DeleteEntity(driverPed)
                        CanSell3 = false
                        Citizen.Wait(7000)
                        TriggerEvent('fa-illegalactivities:ped_to_sellpoint3')
                    else
                        TriggerEvent('DoLongHudText', 'Well I need one of those packages to buy ...', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'This is not your customer', 2)
                end
            end
        end
    else
        TriggerEvent('DoLongHudText', 'This is not your customer', 2)
    end
end)

RegisterNetEvent('fa-illegalactivities:ped_to_sellpoint3')
AddEventHandler('fa-illegalactivities:ped_to_sellpoint3', function()
    EvanFirstLocalStarted = true

    local radius = 1.00
    local x = 586.74444 + math.random(-radius,radius)
    local y = 268.70654 + math.random(-radius,radius)
    local z = 102.95005 + math.random(-radius,radius)

    local model = VehicleModels[math.random(10)]
    local vehicaleHash = GetHashKey(model)
    RequestModel(vehicaleHash)
    while not HasModelLoaded(vehicaleHash) do
        Wait(1)
    end

    local npcped = PedModels[math.random(4)]
    local npcpedhash = GetHashKey(npcped)
    RequestModel(npcpedhash)
    while not HasModelLoaded(npcpedhash) do
        Wait(1)
    end

    if PackagesToDrop == 5 then
        StartedOxyRun = false
        print(PackagesToDrop)
        PackagesToDrop = 0
        print(PackagesToDrop)
        Citizen.Wait(13000)
        exports["fa-phone"]:DoPhoneNotification("home-screen", "CURRENT", 'The Job Offer Was Completed.') 
    else
        veh = CreateVehicle(vehicaleHash, x, y, z, 0.0, true, false)
        driverPed = CreatePed(0, npcpedhash, x+2, y+2, z+1, 0, true, false)
        print(x, y, z)
        TaskWarpPedIntoVehicle(driverPed, veh, -1)
        SetModelAsNoLongerNeeded(npcpedhash)
        SetBlockingOfNonTemporaryEvents(driverPed, true)
        SetModelAsNoLongerNeeded(model)
        local plate = GetVehicleNumberPlateText(veh)
        setOxyVehicle = plate

        Citizen.Wait(5000)
        TaskVehicleDriveToCoord(driverPed, veh, 669.72314, 203.28317, 94.130302, 10.0, false, model, 8388614, 2.0, 0)
        CanSell3 = true
        print(CanSell3)
    end
end)

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

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 2 },
    data = {
        {
            id = "handoff_package",
            label = "Handoff Package",
            icon = "hand-holding",    
            event = "fa-illegalactivities:location",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.8 },
        isEnabled = function(pEntity, pContext)
            return CanSell3 or CanSell2 or CanSell1
        end
    }
}

-- Sell Location End --

-- End Location 3 Shit --

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)
