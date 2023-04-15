local GarbageRuns = 0
local AmountOfGarbages = 0
local CurrentlyStarting = false
local isJobStarted = false
local truckTaken = false
local pickedUp = false
local nearDropOff = false
local isTrunkBusy = false
local vehPlate = ""
local ZoneSelected = 0
local ZoneOneEntered = false
local ZoneTwoEntered = false
local ZoneThreeEntered = false
local ZoneFourEntered = false
local ZoneFiveEntered = false
local ZoneSixEntered = false
local ZoneSevenEntered = false
local ZoneEightEntered = false
local alreadyInZone = false
local isBusy = false
local returningTruck = false
local ZoneBlip

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("return_garbagetruck", vector3(-350.18, -1560.91, 25.22), 12.4, 7.8, {
		name="return_garbagetruck",
		heading=270,
    }) 

    exports["fa-polyzone"]:AddBoxZone("garbage_zone1", vector3(973.61, -1512.86, 53.5), 120, 116.0, {
		name="garbage_zone1",
        heading=0
    }) 

    exports["fa-polyzone"]:AddBoxZone("garbage_zone2", vector3(-1303.67, -790.96, 17.59), 39.59, 185.2, {
		name="garbage_zone2",
        heading=311
    }) 

    exports["fa-polyzone"]:AddCircleZone("garbage_zone3", vector3(1144.52, -558.76, 57.64), 264.40000000001, {
		name="garbage_zone3",
        useZ=false    
    }) 
    exports["fa-polyzone"]:AddBoxZone("garbage_zone4", vector3(314.77, -186.08, 61.58), 102.2 , 67.2,  {
		name="garbage_zone4",
        heading=70    
    })
    exports["fa-polyzone"]:AddBoxZone("garbage_zone5", vector3(-1792.7, -393.05, 45.01), 100, 100, {
		name="garbage_zone5",
        useZ=false  
    })
    exports["fa-polyzone"]:AddBoxZone("garbage_zone6", vector3(254.95, -3087.25, 5.81), 100, 100, {
		name="garbage_zone6",
        useZ=false  
    })
    exports["fa-polyzone"]:AddBoxZone("garbage_zone7", vector3(1183.09, -1315.99, 34.8), 196.40000000001, 100.0, {
		name="garbage_zone7",
        useZ=false  
    })
    exports["fa-polyzone"]:AddBoxZone("garbage_zone8", vector3(854.96, -1048.24, 28.69), 80.600000000001, 110.0, {
		name="garbage_zone8",
        useZ=false  
    }) 
end)

local GarbageCarSpawns = {
	[8] =  { ["x"] = -324.3, ["y"] = -1527.73, ["z"] = 27.25, ["h"] = 2.67 },
	[7] =  { ["x"] = -327.34, ["y"] = -1527.92, ["z"] = 27.25, ["h"] = 358.43 },
	[6] =  { ["x"] = -330.59, ["y"] = -1527.93, ["z"] = 27.25, ["h"] = 359.4 },
	[5] =  { ["x"] = -333.67, ["y"] = -1527.95, ["z"] = 27.27, ["h"] = 359.36 },
	[4] =  { ["x"] = -319.39, ["y"] = -1519.42, ["z"] = 27.27, ["h"] = 178.17 },
	[3] =  { ["x"] = -322.84, ["y"] = -1519.24, ["z"] = 27.26, ["h"] = 180.81 },
    [2] =  { ["x"] = -326.1, ["y"] = -1519.81, ["z"] = 27.25, ["h"] = 180.18 },
    [1] =  { ["x"] = -329.2, ["y"] = -1519.2, ["z"] = 27.25, ["h"] = 178.77 },
}

RegisterNetEvent('fa-garbage:ToggleTrunkStatus', function(jStatus)
    isTrunkBusy = jStatus
end)

RegisterNetEvent('fa-jobs:startGarbageRun', function()
    local engine = not GetIsVehicleEngineRunning(veh)
    local car = GetHashKey('trash2')
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local GarbageVehSpawn = 1
    for i = 1, #GarbageCarSpawns do
        local GarbageVehCheck = GetClosestVehicle(GarbageCarSpawns[i]["x"], GarbageCarSpawns[i]["y"], GarbageCarSpawns[i]["z"], 3.500, 0, 70)
        if not DoesEntityExist(GarbageVehCheck) then
            GarbageVehSpawn = i
        end
    end

    vehicle = CreateVehicle(car, GarbageCarSpawns[GarbageVehSpawn]["x"], GarbageCarSpawns[GarbageVehSpawn]["y"], GarbageCarSpawns[GarbageVehSpawn]["z"], GarbageCarSpawns[GarbageVehSpawn]["h"], true, false)
    truckplate = GetVehicleNumberPlateText(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    TriggerEvent("keys:addNew", vehicle, truckplate)
    SetVehicleEngineOn(vehicle, engine, false, true)
    CurrentlyStarting = true
    Wait(1)
    TriggerServerEvent('fa-garbage:StartJob_SV', math.random(1, 8), CurrentlyStarting)
    vehPlate = truckplate
end)

RegisterNetEvent('fa-garbage:StartJob_CL', function(ZoneSelect)
    ZoneSelected = ZoneSelect
    isJobStarted = true

    Wait(1)

    if ZoneSelected == 1 then 
        ZoneBlip = AddBlipForRadius(973.61, -1512.86, 53.5, 100.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneBlip, true)	   
        GarbageRuns = 0
        AmountOfGarbages = 10
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Le Mesa)')
    elseif ZoneSelected == 2 then 
        ZoneBlip = AddBlipForRadius(-1303.67, -790.96, 17.59, 100.0)
        SetBlipSprite(ZoneBlip, 9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	   
        GarbageRuns = 0
        AmountOfGarbages = 18
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Del Perro)')
    elseif ZoneSelected == 3 then 
        ZoneBlip = AddBlipForRadius(1118.1362304688,-538.40441894531,60.401489257812, 350.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 14
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Mirror Park)')
    elseif ZoneSelected == 4 then 
        ZoneBlip = AddBlipForRadius(314.77, -186.08, 61.58, 85.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 14
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Pink Cage)')
    elseif ZoneSelected == 5 then 
        ZoneBlip = AddBlipForRadius(-1792.7, -393.05, 45.01, 100.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 14
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Von Crastenburg)')
    elseif ZoneSelected == 6 then 
        ZoneBlip = AddBlipForRadius(247.58, -3088.17, 5.63, 90.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 10
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Tuner Docks)')
    elseif ZoneSelected == 7 then 
        ZoneBlip = AddBlipForRadius(1178.84, -1330.32, 34.97, 150.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 20
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (El Rancho Weld)')
    elseif ZoneSelected == 8 then  
        ZoneBlip = AddBlipForRadius(861.41, -1045.44, 29.57, 100.0)
        SetBlipSprite(ZoneBlip,9)
        SetBlipColour(ZoneBlip,25)
        SetBlipAlpha(ZoneBlip,75)
        SetBlipAsShortRange(ZoneOne, true)	
        GarbageRuns = 0
        AmountOfGarbages = 13
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Go to assigned zone (Popular St.)')
    end

    Wait(1000)
    CurrentlyStarting = false
end)

local dumpsterBinModels = {
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_3a",
    "prop_dumpster_4a",
    "prop_dumpster_4b"
}

attachedProp = 0
local searchedDumpers = {}

RegisterNetEvent('fa-garbage:PickUpTrash', function()
    if GarbageRuns ~= AmountOfGarbages then
        local boneindex = GetPedBoneIndex(PlayerPedId(), 57005)
        local pos = GetEntityCoords(PlayerPedId(), false)
        for k, v in pairs(dumpsterBinModels) do 
            print(v)
            local entity = GetClosestObjectOfType(pos, 1.0,GetHashKey(v), false, false, false)
            if DoesEntityExist(entity) then
                if not searchedDumpers[entity] then
                    searchedDumpers[entity] = true
                    attachedProp = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)
                    AttachEntityToEntity(attachedProp, PlayerPedId(), boneindex, 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
                    TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
                    pickedUp = true
                else
                    TriggerEvent('DoLongHudText', 'This dumpster has already been picked up!', 2)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('fa-garbage:RemovePickedUpTrash', function()
    if GarbageRuns ~= AmountOfGarbages then
        GarbageRuns = GarbageRuns + 1
    else
        GarbageRuns = AmountOfGarbages
    end
    Wait(1)
    if GarbageRuns == AmountOfGarbages then
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Head back to depo and return the truck.')
        returningTruck = true
        RemoveBlip(ZoneBlip)
        Wait(200)
        ZoneBlip = AddBlipForCoord(-354.11, -1560.63, 25.19, 100.0)
        SetBlipScale(ZoneBlip, 0.7)
        SetBlipSprite(ZoneBlip, 1)
        SetBlipColour(ZoneBlip, 25)
        SetBlipAsShortRange(ZoneBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Garabe Drop Off')
        EndTextCommandSetBlipName(ZoneBlip)
        SetBlipAsShortRange(ZoneBlip, 1)
    else
        TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
    end
end)

RegisterNetEvent('fa-garbage:ThrowTrashInTruck', function()
    TriggerServerEvent('fa-garbage:SetState', true)
    Wait(5)
    if not isTrunkBusy then
        if GarbageRuns ~= AmountOfGarbages then
            if pickedUp then
                if not isBusy then  
                    isBusy = true
                    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
                        RequestAnimDict("anim@heists@narcotics@trash") 
                        while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
                            Citizen.Wait(0)
                        end
                    end
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
                    Wait(100)
                    if DoesEntityExist(attachedProp) then
                        DeleteEntity(attachedProp)
                        attachedProp = 0
                    end
                    Citizen.Wait(800)
                    ClearPedTasksImmediately(GetPlayerPed(-1))

                    TriggerServerEvent('fa-garbage:RemoveTrash')
                    
                    Wait(1000)
                    pickedUp = false
                    isBusy = false
                    TriggerServerEvent('fa-garbage:ResetState')
                end
            else
                TriggerEvent('DoLongHudText', 'You need to pick up more trash!', 2)
            end
        else
            ClearPedTasksImmediately(GetPlayerPed(-1))
            if DoesEntityExist(attachedProp) then
                DeleteEntity(attachedProp)
                attachedProp = 0
            end
            pickedUp = false
            isBusy = false
        end
    end
end)

RegisterNetEvent('fa-polyzone:enter', function(name)
    if name == "return_garbagetruck" then
        if exports['isPed']:isPed('myjob') == 'sanitation_worker' and returningTruck then
            nearDropOff = true
            AtDropOffLocation()
            exports['fa-interface']:showInteraction(("[E] %s"):format("Drop Off Trash"))
        end
    end

    if name == "garbage_zone1" then 
        alreadyInZone = true
        if ZoneSelected == 1 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneOneEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end

    if name == "garbage_zone2" then
        alreadyInZone = true
        if ZoneSelected == 2 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneTwoEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end

    if name == "garbage_zone3" then
        alreadyInZone = true
        if ZoneSelected == 3 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneThreeEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
    if name == "garbage_zone4" then
        alreadyInZone = true
        if ZoneSelected == 4 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneFourEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
    if name == "garbage_zone5" then
        alreadyInZone = true
        if ZoneSelected == 5 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneFiveEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
    if name == "garbage_zone6" then
        alreadyInZone = true
        if ZoneSelected == 6 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneSixEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
    if name == "garbage_zone7" then
        alreadyInZone = true
        if ZoneSelected == 7 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneSevenEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
    if name == "garbage_zone8" then
        alreadyInZone = true
        if ZoneSelected == 8 then 
            if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
                ZoneEightEntered = true
            end
            if isJobStarted == true and GarbageRuns ~= AmountOfGarbages then
                Wait(100)
                if alreadyInZone then
                    TriggerEvent('fa-phone:JobNotify', 'CURRENT', '('..GarbageRuns ..'/' .. AmountOfGarbages..') Collect Trash.')
                end
            end
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit', function(name)
    if name == "return_garbagetruck" then
        nearDropOff = false
        exports['fa-interface']:hideInteraction()
    end

    if name == "garbage_zone1" then
        if ZoneSelected == 1 then 
            ZoneOneEntered = false
        end
    end

    if name == "garbage_zone2" then
        if ZoneSelected == 2 then 
            ZoneTwoEntered = false
        end
    end

    if name == "garbage_zone3" then
        if ZoneSelected == 3 then 
            ZoneThreeEntered = false
        end
    end
    if name == "garbage_zone4" then
        if ZoneSelected == 4 then 
            ZoneFourEntered = false
        end
    end
    if name == "garbage_zone5" then
        if ZoneSelected == 5 then 
            ZoneFiveEntered = false
        end
    end
    if name == "garbage_zone6" then
        if ZoneSelected == 6 then 
            ZoneSixEntered = false
        end
    end
    if name == "garbage_zone7" then
        if ZoneSelected == 7 then 
            ZoneSevenEntered = false
        end
    end
    if name == "garbage_zone8" then
        if ZoneSelected == 8 then 
            ZoneEightEntered = false
        end
    end
end)

RegisterNetEvent('fa-garbage:payClients', function()
    TriggerEvent('player:receiveItem', 'recyclablematerial', math.random(20, 50))
    if exports['fa-hud']:MoneyBuff() then
        RPC.execute('fa-jobs:givePayout', math.random(650, 727), "cash", '[24/7 Delivery Job | With Buff]')
    else
        RPC.execute('fa-jobs:givePayout', math.random(500, 678), "cash", '[24/7 Delivery Job | Without Buff]')
    end
    Citizen.Wait(2500)
    TriggerEvent('fa-phone:JobNotifyClose')
end)

function AtDropOffLocation()
	Citizen.CreateThread(function()
        while nearDropOff do
            Citizen.Wait(5)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = GetVehicleNumberPlateText(vehicle)
            if IsControlJustReleased(0, 38) then
                if vehPlate == plate then
                    if GarbageRuns == AmountOfGarbages then
                        jobCompleted = true
                        local finished = exports['fa-taskbar']:taskBar(5000, "Dropping off trash", false)
                        if finished == 100 then
                            returningTruck = false
                            nearDropOff = false
                            deleteCar(vehicle)
                            vehPlate = ""
                            pickedUp = false
                            GarbageRuns = 0
                            AmountOfGarbages = 0
                            TriggerServerEvent('fa-garbage:payGroupAndMembers')
                            jobCompleted = false
                            ZoneOneEntered = false
                            ZoneTwoEntered = false
                            ZoneThreeEntered = false
                            ZoneFourEntered = false
                            ZoneFiveEntered = false
                            ZoneSixEntered = false
                            ZoneSevenEntered = false
                            ZoneEightEntered = false
                            RemoveBlip(ZoneBlip)
                            Wait(1000)
                            ZoneSelected = 0
                            searchedDumpers = {}
                            exports['fa-interface']:hideInteraction()
                        end
                    else
                        TriggerEvent('DoLongHudText', 'You need to compelete the rest of your tasks!', 2)
                    end
                else
                    TriggerEvent('DoLongHudText','The leader needs to turn in the vehicle!', 2)
                end
            end
        end
    end)
end

RegisterNetEvent('fa-garbage:JobCancel', function(status)
    TriggerServerEvent('fa-garbage:RequestCancel', status)
end)

RegisterNetEvent('fa-garbage:RestSomeStatus', function()
    alreadyInZone = false
    isJobStarted = false
    RemoveBlip(ZoneBlip)
end)

RegisterNetEvent('fa-garbage:FullyCanceled', function()
    vehPlate = ""
    pickedUp = false
    GarbageRuns = 0
    AmountOfGarbages = 0
    truckTaken = false
    jobCompleted = false
    ZoneOneEntered = false
    ZoneTwoEntered = false
    ZoneThreeEntered = false
    ZoneFourEntered = false
    ZoneFiveEntered = false
    ZoneSixEntered = false
    ZoneSevenEntered = false
    ZoneEightEntered = false
    RemoveBlip(ZoneBlip)
    Wait(1000)
    ZoneSelected = 0
    searchedDumpers = {}
end)

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

exports('GetGarbageZoneActive', function()
    if ZoneOneEntered or ZoneTwoEntered or ZoneThreeEntered or ZoneFourEntered or ZoneFiveEntered or ZoneSixEntered or ZoneSevenEntered or ZoneEightEntered then 
        return true
    else
        return false
    end
end)

exports["fa-polyzone"]:AddBoxZone("sign_in_garbage", vector3(-353.88, -1545.97, 27.72), 2.0, 1.4, {
    name="sign_in_garbage",
    heading=0,
    --debugPoly=false,
    minZ=24.92,
    maxZ=28.92
})

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "sign_in_garbage" then
        inGarbageLocationSignIn = true
        if exports['isPed']:isPed('myjob') == 'sanitation_worker' then
            exports['fa-interface']:showInteraction('[E] Sign Out', 'error')

            Citizen.CreateThread(function()
                while inGarbageLocationSignIn do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        if inJob then
                            TriggerServerEvent("jobssystem:jobs", "unemployed")
                            RPC.execute('fa-phone:group_CheckOut')
                            exports['fa-phone']:phoneNotification('jobactivity', 'Clocked Out.', 'Job Center')
                            inJob = false
                        end
                    end
                end
            end)
        else
            exports['fa-interface']:showInteraction('[E] Sign In')

            Citizen.CreateThread(function()
                while inGarbageLocationSignIn do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        if not inJob then
                            TriggerServerEvent("jobssystem:jobs", "sanitation_worker")
                            exports['fa-phone']:phoneNotification('jobactivity', 'Signed into Sanitation.', 'Job Center')
                            inJob = true
                            exports['fa-interface']:hideInteraction()
                        end
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "sign_in_garbage" then
        inGarbageLocationSignIn = false
        exports['fa-interface']:hideInteraction()
    end
end)

RegisterCommand('setGarbageRuns', function()
    GarbageRuns = GarbageRuns + 1
end)