RegisterNetEvent("fa-jobmanager:playerBecameJob")
AddEventHandler("fa-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ems" then isMedic = false isInService = false end
    if isCop and job ~= "police" or "state" or "sheriff" or "ranger" then isCop = false isInService = false end
    if job == "police" or "state" or "sheriff" or "ranger" then isCop = true isInService = true end
    if job == "ems" then isMedic = true isInService = true end

end)

local attempted = 0
local LootedTruck = false

local pickup = false
local additionalWait = 0
RegisterNetEvent('fa-heists:start_loop')
AddEventHandler('fa-heists:start_loop', function()
    pickup = true
    TriggerEvent("fa-heists:pick_cash")
    Wait(180000)
    Wait(additionalWait)
    pickup = false
end)

RegisterNetEvent('fa-heists:pick_cash')
AddEventHandler('fa-heists:pick_cash', function()
    local markerlocation = GetOffsetFromEntityInWorldCoords(attempted, 0.0, -3.7, 0.1)
    SetVehicleHandbrake(attempted,true)
    while pickup do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], markerlocation["x"],markerlocation["y"],markerlocation["z"])
        if aDist < 2.0 and not LootedTruck then
            DrawText3Ds(markerlocation["x"],markerlocation["y"],markerlocation["z"], "Press [E] to pick up cash.")
            if IsDisabledControlJustReleased(0, 38) then
                if not LootedTruck then
                    FreezeEntityPosition(PlayerPedId(), true)
                    TriggerEvent('animation:PlayAnimation', 'search')
                    TriggerEvent('fa-hud:show_money')
                    local BankTruckBarLoot = exports['fa-taskbar']:taskBar(60000, 'Looting the truck')
                    if BankTruckBarLoot == 100 then
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerEvent('fa-heists:banktruck_loot') 
                        TriggerEvent('fa-hud:hide_money') 
                        LootedTruck = true
                        Citizen.Wait(900000) 
                        LootedTruck = false     
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerEvent('DoLongHudText', 'You notice cash dropping everywhere.', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'You a bit greedy huh?', 2)
                end
            end
        end
    end
end)    

RegisterNetEvent('fa-heists:banktruck_loot')
AddEventHandler('fa-heists:banktruck_loot', function()
    local LootTable = math.random(1, 3)
    if LootTable == 1 then
        TriggerEvent('player:receiveItem', 'cashroll', math.random(50, 100))
        TriggerEvent('player:receiveItem', 'bank', math.random(10, 25))
        TriggerEvent('fa-mining:get_gem')
    elseif LootTable == 2 then
        TriggerEvent('player:receiveItem', 'inkedmoneybag', math.random(4, 8))
    elseif LootTable == 3 then
        TriggerEvent('player:receiveItem', 'inkset', math.random(10, 20))
    end
end)

RegisterNetEvent('fa-heists:spawn_peds')
AddEventHandler('fa-heists:spawn_peds', function(veh)
    local cType = 's_m_m_highsec_01'
    local pedmodel = GetHashKey(cType)
    RequestModel(pedmodel)
    while not HasModelLoaded(pedmodel) do
        RequestModel(pedmodel)
        Citizen.Wait(100)
    end
    ped2 = CreatePedInsideVehicle(veh, 4, pedmodel, 0, 1, 0.0)
    DecorSetBool(ped2, 'ScriptedPed', true)
    ped3 = CreatePedInsideVehicle(veh, 4, pedmodel, 1, 1, 0.0)
    DecorSetBool(ped3, 'ScriptedPed', true)
    ped4 = CreatePedInsideVehicle(veh, 4, pedmodel, 2, 1, 0.0)
    DecorSetBool(ped4, 'ScriptedPed', true)

    GiveWeaponToPed(ped2, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)

    SetPedDropsWeaponsWhenDead(ped2,false)
    SetPedRelationshipGroupDefaultHash(ped2,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped2,GetHashKey('COP'))
    SetPedAsCop(ped2,true)
    SetCanAttackFriendly(ped2,false,true)

    SetPedDropsWeaponsWhenDead(ped3,false)
    SetPedRelationshipGroupDefaultHash(ped3,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped3,GetHashKey('COP'))
    SetPedAsCop(ped3,true)
    SetCanAttackFriendly(ped3,false,true)

    SetPedDropsWeaponsWhenDead(ped4,false)
    SetPedRelationshipGroupDefaultHash(ped4,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped4,GetHashKey('COP'))
    SetPedAsCop(ped4,true)
    SetCanAttackFriendly(ped4,false,true)

    TaskCombatPed(ped2, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped3, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped4, GetPlayerPed(-1), 0, 16)
end)



RegisterNetEvent('fa-heists:start_hitting_truck')
AddEventHandler('fa-heists:start_hitting_truck', function(veh)
    TriggerEvent('fa-dispatch:bank_truck_robbery')
    attempted = veh
    SetEntityAsMissionEntity(attempted,true,true)
    local plate = GetVehicleNumberPlateText(veh)
    TriggerServerEvent("fa-heists:check_if_robbed",plate)
end)

RegisterNetEvent('sec:AllowHeist')
AddEventHandler('sec:AllowHeist', function()
    TriggerServerEvent('banktruckrobbery:log')
    TriggerEvent("fa-heists:spawn_peds",attempted)
    SetVehicleDoorOpen(attempted, 2, 0, 0)
    SetVehicleDoorOpen(attempted, 3, 0, 0)
    TriggerEvent("fa-heists:start_loop")

end)

function DrawText3Ds(x,y,z, text)
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

function FindEndPointCar(x,y)   
	local randomPool = 50.0
	while true do

		if (randomPool > 2900) then
			return
		end
	    local vehSpawnResult = {}
	    vehSpawnResult["x"] = 0.0
	    vehSpawnResult["y"] = 0.0
	    vehSpawnResult["z"] = 30.0
	    vehSpawnResult["x"] = x + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    vehSpawnResult["y"] = y + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    roadtest, vehSpawnResult, outHeading = GetClosestVehicleNode(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"],  0, 55.0, 55.0)

        Citizen.Wait(1000)        
        if vehSpawnResult["z"] ~= 0.0 then
            local caisseo = GetClosestVehicle(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], 20.000, 0, 70)
            if not DoesEntityExist(caisseo) then

                return vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], outHeading
            end
            
        end

        randomPool = randomPool + 50.0
	end
end

RegisterNetEvent('fa-heists:banktruck:cl')
AddEventHandler('fa-heists:banktruck:cl', function()
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    local Police = exports["fa-duty"]:LawAmount()
    if Police >= 4 then
        if targetVehicle ~= 0 and GetHashKey("stockade") == GetEntityModel(targetVehicle) then
            local entityCreatePoint = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0, -4.0, 0.0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], entityCreatePoint["x"], entityCreatePoint["y"],entityCreatePoint["z"])
            local cityCenter = vector3(-204.92, -1010.13, 29.55) -- alta street train station
            local timeToOpen = 45000
            local distToCityCenter = #(coords - cityCenter)
            if distToCityCenter > 1000 then
                local multi = math.floor(distToCityCenter / 1000)
                timeToOpen = timeToOpen + (30000 * multi)
            end
            if aDist < 2.0 then
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TriggerServerEvent('fa-heists:bankTruckLog')
                TriggerEvent('fa-dispatch:bank_truck_robbery')
                local finished = exports["fa-taskbar"]:taskBar(timeToOpen,"Unlocking Vehicle",false,false,playerVeh)
                if finished == 100 then
                    TriggerEvent('fa-hud:show_hackerman')
                    exports['fa-thermite']:OpenThermiteGame(function(success)
                        if success then
                            TriggerEvent('fa-hud:hide_hackerman')
                            TriggerEvent('inventory:removeItem', 'Gruppe6Card', 1)
                            TriggerEvent("fa-heists:start_hitting_truck", targetVehicle)
                        else
                            TriggerEvent('fa-hud:hide_hackerman')
                            TriggerEvent('inventory:removeItem', 'Gruppe6Card', 1)
                        end
                    end, 5, 3, 10)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    TriggerEvent("evidence:bleeding")
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            else
                TriggerEvent("DoLongHudText","You need to do this from behind the vehicle.")
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not enough police', 2)
    end
end)