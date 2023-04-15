local pDodoHQ = {x = -424.33847045898, y = -2789.8154296875, z = 6.5157470703125}
local possibility = 0

local pDodoPoints = {
    [1] = {name = "", x = -324.29, y = -1356.19, z = 31.29},
    [2] = {name = "", x = -42.39, y = -664.43, z = 33.47},
    [3] = {name = "", x = -245.79, y = -677.92, z = 37.74},
    [4] = {name = "", x = 402.29, y = -338.80, z = 46.97},
    [5] = {name = "", x = 352.89, y = -142.58, z = 66.68},
    [6] = {name = "", x = 581.00, y = 139.25, z = 99.47},
    [7] = {name = "", x = 367.17, y = 351.38, z = 103.32},
    [8] = {name = "", x = 190.20, y = 291.91, z = 105.53},
    [9] = {name = "", x = -536.59, y = -45.93, z = 42.57},
    [10] = {name = "", x = -783.62, y = -390.65, z = 37.33},
}

local coordinates = 0
local isToDropLocation = false
local pOnWayDodo = false
local multiplicador_De_dinero = 0.05
local pVeh = nil

local px = 0
local py = 0
local pz = 0

-------------------------------
-------------BLIPS-------------
-------------------------------

function CreateJob(pDodoPoints, coordinates)
    pDeliveryLoc = AddBlipForCoord(pDodoPoints[coordinates].x,pDodoPoints[coordinates].y, pDodoPoints[coordinates].z)
    SetBlipSprite(pDeliveryLoc, 457)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Location")
    EndTextCommandSetBlipName(pDeliveryLoc)
    SetBlipRoute(pDeliveryLoc, 2)
    SetBlipRouteColour(pDeliveryLoc, 3)
    SetBlipColour(pDeliveryLoc, 3)
end

RegisterNetEvent('fa-jobs:dodoLogisticsGetJob')
AddEventHandler('fa-jobs:dodoLogisticsGetJob', function(loc)
    isToDropLocation = true
    px = pDodoPoints[loc].x
    py = pDodoPoints[loc].y
    pz = pDodoPoints[loc].z
    distance = round(GetDistanceBetweenCoords(pDodoHQ.x, pDodoHQ.y, pDodoHQ.z, px,py,pz))
    CreateJob(pDodoPoints, loc)
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Drive to the delivery location.')

    Citizen.CreateThread(function()
        while isToDropLocation do
            Citizen.Wait(0)
            if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 2.5 then
                if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder")) then
                    exports['fa-interface']:showInteraction('[E] Drop Off Package')
                    if IsControlJustPressed(1,38) then
                        RPC.execute('fa-jobs:returnBackDodoDock')
                    end
                end
            else
                exports['fa-interface']:hideInteraction()
            end
        end
    end)
end)

RegisterNetEvent('fa-jobs:dodoLogisticsPayout')
AddEventHandler('fa-jobs:dodoLogisticsPayout', function()
    if pOnWayDodo == true then
        if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder"))  then
            if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("pounder")) then
                TriggerServerEvent('fa-jobs:dodoLogisticsPayout')
                exports['fa-interface']:hideInteraction()
                isToDropLocation = false
                pOnWayDodo = false
                px = 0
                py = 0
                pz = 0
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                SetEntityAsMissionEntity( vehicle, true, true )
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle) )
            end
        end
    end
end)

RegisterNetEvent('fa-jobs:returningDodo')
AddEventHandler('fa-jobs:returningDodo', function()
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Return back to the Dodo dock.')
    exports['fa-interface']:hideInteraction()
    isToDropLocation = false
    pOnWayDodo = true
    RemoveBlip(pDeliveryLoc)
    
    pReturnBack = AddBlipForCoord(-448.30, -2787.41, 6.07)
    SetBlipSprite(pReturnBack, 457)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Location")
    EndTextCommandSetBlipName(pReturnBack)
    SetBlipRoute(pReturnBack, 2)
    SetBlipRouteColour(pReturnBack, 3)
    SetBlipColour(pReturnBack, 3)

    local setCoords = vector3(-448.30, -2787.41, 6.07)
    Citizen.CreateThread(function()
    while pOnWayDodo do
        Citizen.Wait(1000)
        local plped = PlayerPedId()
        local coordA = GetEntityCoords(plped)
        local aDist = GetDistanceBetweenCoords(setCoords, coordA)
            if aDist < 15.0 then
                pOnWayDodo = false
                RemoveBlip(pReturnBack)
                DeleteEntity(pVeh)
                if exports['fa-hud']:MoneyBuff() then
                    RPC.execute('fa-jobs:givePayout', math.random(878, 927), "bank", '[Dodo Logistics | With Buff]')
                else
                    RPC.execute('fa-jobs:givePayout', math.random(650, 778), "bank", '[Dodo Logistics | Without Buff]')
                end
                Citizen.Wait(2500)
                TriggerEvent('fa-phone:JobNotifyClose')
            end
        end
    end)
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

--// Spawn vehicle

RegisterNetEvent('fa-jobs:sendDodoNoti')
AddEventHandler('fa-jobs:sendDodoNoti', function()
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Get into the delivery truck')
end)

RegisterNetEvent("fa-jobs:spawn-truck")
AddEventHandler("fa-jobs:spawn-truck", function()
    local hash = GetHashKey("pounder")

    if not IsModelAVehicle(hash) then return end
    if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
    
    RequestModel(hash)

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(hash, vector3(-448.30, -2787.41, 6.07), 46.68, true)
    pVeh = vehicle

    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerEvent("keys:addNew",vehicle,plate)
    SetModelAsNoLongerNeeded(hash)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleWindowTint(vehicle, 0)
    RPC.execute('fa-jobs:dodoStarted')
    waitingGetInVeh = true
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Get into the delivery truck')

    Citizen.CreateThread(function()
        while waitingGetInVeh do
            Citizen.Wait(1000)
            if GetVehiclePedIsIn(PlayerPedId()) == vehicle then
                waitingGetInVeh = false
                RPC.execute('fa-jobs:getADeliveryLocationDodo', math.random(1, 7))
            end
        end
    end)
end)

function findclosestspawn(pCurrentPosition)
	local coords = vector3(-448.30, -2787.41, 6.07)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

exports["fa-polyzone"]:AddBoxZone("sign_in_dodo", vector3(-438.02, -2795.2, 7.29), 1.6, 2.0, {
    name="sign_in_dodo",
    heading=45,
    --debugPoly=false,
    minZ=4.69,
    maxZ=8.69
})

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "sign_in_dodo" then
        dodoSignInLoc = true
        if exports['isPed']:isPed('myjob') == 'dodologistics' then
            exports['fa-interface']:showInteraction('[E] Sign Out', 'error')

            Citizen.CreateThread(function()
                while dodoSignInLoc do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        exports['fa-interface']:hideInteraction()
                        TriggerServerEvent("jobssystem:jobs", "unemployed")
                        RPC.execute('fa-phone:group_CheckOut')
                        exports['fa-phone']:phoneNotification('jobactivity', 'Clocked Out.', 'Job Center')
                        dodoSignInLoc = false
                    end
                end
            end)
        else
            exports['fa-interface']:showInteraction('[E] Sign In')

            Citizen.CreateThread(function()
                while dodoSignInLoc do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("jobssystem:jobs", "dodologistics")
                        exports['fa-phone']:phoneNotification('jobactivity', 'Signed in as Dodo Logistics.', 'Job Center')
                        exports['fa-interface']:hideInteraction()
                        dodoSignInLoc = false
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "sign_in_dodo" then
        dodoSignInLoc = false
        exports['fa-interface']:hideInteraction()
    end
end)