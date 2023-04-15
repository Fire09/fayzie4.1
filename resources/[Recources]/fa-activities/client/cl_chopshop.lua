isCop, PlayerPed, PlayerCoords, CurrentChopShop, IsNearChopShop, AlreadyNearChopShop = false
local nocontrols = false
local allowedchop = false
local cooldown = false
local chopstarted = false
local station = false
local IsNearChopShop = false
local IsInChopZone = false
local CoolDownActive = false

CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("chop_zone", vector3(1359.1, -2097.81, 52.0), 15, 15, {
        heading=40,
        minZ=51.0,
        maxZ=55.0
    })
end)

AddEventHandler("fa-polyzone:enter", function(zone)
    if zone == "chop_zone" and GetVehiclePedIsIn(PlayerPedId(), false) == aspectChopCar then
        IsInChopZone = true
        RPC.execute('fa-activities:updateChopNoti')
    end
end)

RegisterNetEvent('fa-activities:StartTheChop')
AddEventHandler('fa-activities:StartTheChop', function()
	RPC.execute('fa-activities:updateChopBones')
end)

RegisterNetEvent('fa-activities:StartTheChopCL')
AddEventHandler('fa-activities:StartTheChopCL', function()
	local coordA = GetEntityCoords(PlayerPedId(), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)

    RemoveBlip(blipDropOff)
    IsInChopZone = false
    InteractiveChopping(getVehicleInDirection(coordA, coordB))
    aspectChopCar = nil
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Chop the vehicle parts.')
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "chop_zone" then
        IsInChopZone = false
    end
end)


ChopCarLocation = {
	[1] = { Chop = vector3(1359.1, -2097.81, 52.0), Sell = vector3(2341.53, 3128.55, 48.21)}
}

chopdoors = {
	[1] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_lf",   PartLabel = "Roda", 		PartProp = "prop_wheel_tyre", 	 PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[2] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_rf",   PartLabel = "Roda", 		PartProp = "prop_wheel_tyre",	 PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[3] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_lr",   PartLabel = "Roda", 		PartProp = "prop_wheel_tyre", 	 PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[4] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_rr",   PartLabel = "Roda", 		PartProp = "prop_wheel_tyre", 	 PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[5] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "engine", 	   PartLabel = "Bateria", 	PartProp = "prop_car_battery_01",PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[6] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "engine", 	   PartLabel = "Motor", 	PartProp = "prop_car_engine_01", PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0}
}

CreateThread(function()
	while true do
		for i=1, #ChopCarLocation, 1 do
            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)
            local dist = #(pCoords - ChopCarLocation[i].Chop)
			if dist <= 10 then
				station = i
			end
			if station ~= nil and dist >= 10 then
				station = nil
			end
		end
		if station ~= nil then
            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)
            local dist2 = #(pCoords - ChopCarLocation[station].Chop)
			if dist2 >= 50 and chopstarted then 
				away()
			end
		end
		Wait(1500)
	end
end)

function away()
	local vehchopping = GetClosestVehicle(ChopCarLocation[station].Chop, 4.001, 0, 70)
	chopstarted = false
	station = nil
	DeleteEntity(vehchopping)
end

local _i, _f, _v, _r, _ri, _rf, _rl, _s, _rv, _ro, _in, _ii, _fi =
Citizen.PointerValueInt(), Citizen.PointerValueFloat(), Citizen.PointerValueVector(),
Citizen.ReturnResultAnyway(), Citizen.ResultAsInteger(), Citizen.ResultAsFloat(), Citizen.ResultAsLong(), Citizen.ResultAsString(), Citizen.ResultAsVector(), Citizen.ResultAsObject(),
Citizen.InvokeNative, Citizen.PointerValueIntInitialized, Citizen.PointerValueFloatInitialized

local string_len = string.len
local inv_factor = 1.0 / 370.0

function Draw3DText(x,y,z, text)
    local factor = string_len(text) * inv_factor
    local onScreen,_x,_y = _in(0x34E82F05DF2974F5, x, y, z, _f, _f, _r) -- GetScreenCoordFromWorldCoord
    if onScreen then
        _in(0x07C837F9A01C34C9, 0.35, 0.35) -- SetTextScale
        _in(0x66E0276CC5F6B9DA, 4) -- SetTextFont
        _in(0x038C1F517D7FDCF8, 1) -- SetTextProportional
        _in(0xBE6B23FFA53FB442, 255, 255, 255, 215) -- SetTextColour
        _in(0x25FBB336DF1804CB, "STRING") -- SetTextEntry
        _in(0xC02F4DBFB51D988B, 1) -- SetTextCentre
        _in(0x6C188BE134E074AA, text) -- AddTextComponentString, assumes "text" is of type string
        _in(0xCD015E5BB0D96A57, _x, _y) -- DrawText
        _in(0x3A618A217E5154F0, _x,_y+0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68) -- DrawRect
    end
end

function GetHeadingFromCoords(targetCoords)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local prX, prY = playerCoords.x * math.pi / 180, playerCoords.y * math.pi / 180
    local trX, trY = playerCoords.x * math.pi / 180, playerCoords.y * math.pi / 180
    local y = math.sin(trX - prX) * math.cos(trY)
    local x = math.cos(prY) * math.sin(trY) - math.sin(prY) * math.cos(trY) * math.cos(trX - prX)
    local bearing = math.atan2(y, x)
    local heading = bearing * 100 / math.pi
    return heading
end

function PedFaceCoord(pPed, pCoords)
    TaskTurnPedToFaceCoord(pPed, pCoords.x, pCoords.y, pCoords.z)
    Wait(100)
    while GetScriptTaskStatus(pPed, 0x574bb8f5) == 1 do
        Wait(0)
    end
end

function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

function conditional(condition, trueExpr, falseExpr)
    if condition then
        return trueExpr
    else
        return falseExpr
    end
end

local Throttles = {}

function Throttled(name, time)
    if not Throttles[name] then
        Throttles[name] = true
        SetTimeout(time or 500, function() Throttles[name] = false end)
        return false
    end
    return true
end

local VehicleChopBones = {
    {name = "wheel_lf", index = 0, type = "tyre"},
    {name = "wheel_rf", index = 1, type = "tyre"},
    {name = "wheel_lm", index = 2, type = "tyre"},
    {name = "wheel_rm", index = 3, type = "tyre"},
    {name = "wheel_lr", index = 4, type = "tyre"},
    {name = "wheel_rr", index = 5, type = "tyre"},
    {name = "wheel_lm1", index = 2, type = "tyre"},
    {name = "wheel_rm1", index = 3, type = "tyre"},
    {name = "door_dside_f", index = 0, type = "door"},
    {name = "door_pside_f", index = 1, type = "door"},
    {name = "door_dside_r", index = 2, type = "door"},
    {name = "door_pside_r", index = 3, type = "door"},
    {name = "bonnet", index = 4, type = "hood"},
    {name = "boot", index = 5, type = "trunk"},
}

IsUsingInteractiveChopping = false

function AnimationTask(entity, coordsType, coordsOrigin, coordsDist, animationType, animDict, animName, animFlag)
    local self = {}
    self.active = true
    CreateThread(function()
        local playerPed = PlayerPedId()
        local playerCoords, coords = GetEntityCoords(playerPed)
        if animationType == "scenario" then
            TaskStartScenarioInPlace(playerPed, animDict, 0, true)
        elseif animationType == "normal" then
            LoadAnimationDict(animDict)
        end
        while self.active do
            local idle = 100
            playerCoords = GetEntityCoords(playerPed)
            if coordsType == "bone" then
                coords = GetWorldPositionOfEntityBone(entity, coordsOrigin)
            else
                coords = GetEntityCoords(entity)
            end
            if animationType == "normal" and not IsEntityPlayingAnim(playerPed, animDict, animName, 3) then
                TaskPlayAnim(playerPed, animDict, animName, -8.0, -8.0, -1, animFlag, 0, 0, 0, 0)
            end
            if #(coords - playerCoords) > coordsDist then
                self.abort()
            end
            Wait(idle)
        end
        if animationType == "scenario" then
            ClearPedTasks(playerPed)
        else
            StopAnimTask(playerPed, animDict, animName, 1.5)
        end
    end)
    self.abort = function()
        self.active = false
    end
    return self
end

function GetValidBones(entity, list)
    local bones = {}
    for _, bone in ipairs(list) do
        local boneID = GetEntityBoneIndexByName(entity, bone.name)
        if boneID ~= -1 then
            if bone.type == "door" and not IsVehicleDoorDamaged(entity, bone.index) or bone.type == "tyre" and not IsVehicleTyreBurst(entity, bone.index, 1) or bone.type == "hood" and not IsVehicleDoorDamaged(entity, bone.index) or bone.type == "trunk" and not IsVehicleDoorDamaged(entity, bone.index) then
                bone.id = boneID
                bones[#bones + 1] = bone
            end
        end
    end
    return bones
end

function GetClosestBone(entity, list)
    local playerCoords, bone, coords, distance = GetEntityCoords(PlayerPedId())
    for _, element in pairs(list) do
        local boneCoords = GetWorldPositionOfEntityBone(entity, element.id or element)
        local boneDist = #(playerCoords - boneCoords)
        if not coords then
            bone, coords, distance = element, boneCoords, boneDist
        elseif distance > boneDist then
            bone, coords, distance = element, boneCoords, boneDist
        end
    end
    if not bone then
        bone = {id = GetEntityBoneIndexByName(entity, "bodyshell"), type = "remains", name = "bodyshell"}
        coords = GetWorldPositionOfEntityBone(entity, bone.id)
        distance = #(coords - playerCoords)
    end
    return bone, coords, distance
end

function ChopVehicleTyre(vehicle, boneID, tyreIndex)
    if IsVehicleTyreBurst(vehicle, tyreIndex, 1) then return end
    local task = AnimationTask(vehicle, "bone", boneID, 1.2, "normal", "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1)
    FreezeEntityPosition(PlayerPedId(),true)
    local finished = exports["fa-taskbar"]:taskBar(10000,"Slicing Vehicle Tires")
    local success = finished == 100 and task.active == true
    task.abort()
    if success then
        SetVehicleTyreBurst(vehicle, tyreIndex, true, 1000.0)
        FreezeEntityPosition(PlayerPedId(),false)
    end
    return success
end

function ChopVehicleDoor(vehicle, boneID, doorIndex)
    if IsVehicleDoorDamaged(vehicle, doorIndex) then return end
    SetVehicleDoorOpen(vehicle, doorIndex, 0, 1)
    local task = AnimationTask(vehicle, "bone", boneID, 1.6, "scenario", "WORLD_HUMAN_WELDING")
    FreezeEntityPosition(PlayerPedId(),true)
    local finished = exports["fa-taskbar"]:taskBar(14000,"Messing With Door")
    local success = finished == 100 and task.active == true
    task.abort()
    if success then
        SetVehicleDoorBroken(vehicle, doorIndex, 1)
        FreezeEntityPosition(PlayerPedId(),false)
    end
    return success
end

function ChopVehicleTrunk(vehicle, boneID, doorIndex)
    if IsVehicleDoorDamaged(vehicle, doorIndex) then return end
    SetVehicleDoorOpen(vehicle, doorIndex, 0, 1)
    local task = AnimationTask(vehicle, "bone", boneID, 1.6, "scenario", "WORLD_HUMAN_WELDING")
    FreezeEntityPosition(PlayerPedId(),true)
    local finished = exports["fa-taskbar"]:taskBar(14000,"Messing With Trunk")
    local success = finished == 100 and task.active == true
    task.abort()
    if success then
        SetVehicleDoorBroken(vehicle, doorIndex, 1)
        FreezeEntityPosition(PlayerPedId(),false)
    end
end

function ChopVehicleHood(vehicle, boneID, doorIndex)
    if IsVehicleDoorDamaged(vehicle, doorIndex) then return end
    SetVehicleDoorOpen(vehicle, doorIndex, 0, 1)
    local task = AnimationTask(vehicle, "bone", boneID, 1.6, "scenario", "WORLD_HUMAN_WELDING")
    FreezeEntityPosition(PlayerPedId(),true)
    local finished = exports["fa-taskbar"]:taskBar(14000,"Messing With Hood")
    local success = finished == 100 and task.active == true
    task.abort()
    if success then
        SetVehicleDoorBroken(vehicle, doorIndex, 1)
        FreezeEntityPosition(PlayerPedId(),false)
    end
end

function ChopVehicleRemains(vehicle, boneID)
    local task = AnimationTask(vehicle, "bone", boneID, 1.8, "normal", "mp_car_bomb", "car_bomb_mechanic", 17)
    FreezeEntityPosition(PlayerPedId(),true)
    local finished = exports["fa-taskbar"]:taskBar(25000,"Seeing Whats Left ..")
    local success = finished == 100 and task.active == true
    task.abort()
    if success then
        TriggerEvent('DoLongHudText', 'I will look for another job for you keep an eye on your phone !', 1)
        DeleteEntity(vehicle)
        FreezeEntityPosition(PlayerPedId(),false)
    end
    return success
end

function ChopVehiclePart(vehicle)
    if not DoesEntityExist(vehicle) then return end
    if CoolDownActive then return end
    local vehicleModel = GetEntityModel(vehicle)
    local boneList = GetValidBones(vehicle, VehicleChopBones)
    local bone, coords, distance = GetClosestBone(vehicle, boneList)
    local success = false
    PedFaceCoord(PlayerPed, coords)
    if bone.type == "tyre" and distance < 1.2 then
        success = ChopVehicleTyre(vehicle, bone.id, bone.index)
    elseif bone.type == "door" and distance < 1.6 then
        success = ChopVehicleDoor(vehicle, bone.id, bone.index)
    elseif bone.type == "hood" and distance < 1.6 then
        success = ChopVehicleHood(vehicle, bone.id, bone.index)
    elseif bone.type == "trunk" and distance < 1.6 then
        success = ChopVehicleTrunk(vehicle, bone.id, bone.index)
    elseif bone.type == "remains" and distance < 1.8 then
        success = ChopVehicleRemains(vehicle)
        TriggerEvent('fa-phone:JobNotifyClose')
        RPC.execute('fa-activities:chopComplete')
        Citizen.Wait(2500)
        exports['fa-phone']:phoneNotification('jobactivity', 'Job Complete.', 'Job Center')
    end
    if success then
        TriggerServerEvent("fa-chopshop:vehicle_loot", bone.type)
    end
end

-- TODO: fix heading formula
function InteractiveChopping(vehicle)
    if IsUsingInteractiveChopping then return end
    IsUsingInteractiveChopping = true
    local boneList = GetValidBones(vehicle, VehicleChopBones)
    CreateThread(function()
        while IsUsingInteractiveChopping do
            local idle = 500
            local bone, coords, distance = GetClosestBone(vehicle, boneList)
            if exports['isPed']:isPed('myjob') == 'chopshop' then
                print('[CAN INTERACT WITH CHOP VEH.] '..vehicle)
                boneList = GetValidBones(vehicle, VehicleChopBones)
                if bone.type == "door" and distance <= 1.6 then
                    Draw3DText(coords.x, coords.y, coords.z, "Press ~w~~g~[E]~w~ to Chop Vehicle Door")
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(blipDropOff)
                        if CoolDownActive then
                            TriggerEvent('DoLongHudText', 'You recently chopped come back later', 2)
                        else
                            ChopVehiclePart(vehicle)
                        end
                    end
                elseif bone.type == "hood" and distance <= 1.6 then
                    Draw3DText(coords.x, coords.y, coords.z, "Press ~w~~g~[E]~w~ to Chop Vehicle Hood")
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(blipDropOff)
                        if CoolDownActive then
                            TriggerEvent('DoLongHudText', 'You recently chopped come back later', 2)
                        else
                            ChopVehiclePart(vehicle)
                        end
                    end
                elseif bone.type == "trunk" and distance <= 1.6 then
                    Draw3DText(coords.x, coords.y, coords.z, "Press ~w~~g~[E]~w~ to Chop Vehicle Trunk")
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(blipDropOff)
                        if CoolDownActive then
                            TriggerEvent('DoLongHudText', 'You recently chopped come back later', 2)
                        else
                            ChopVehiclePart(vehicle)
                        end
                    end
                elseif bone.type == "tyre" and distance <= 1.6 then
                    Draw3DText(coords.x, coords.y, coords.z, "Press ~w~~g~[E]~w~ to Chop Vehicle Tires")
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(blipDropOff)
                        if CoolDownActive then
                            TriggerEvent('DoLongHudText', 'You recently chopped come back later', 2)
                        else
                            ChopVehiclePart(vehicle)
                        end
                    end
                elseif bone.type == "remains" and distance <= 1.8 then
                    Draw3DText(coords.x, coords.y, coords.z, "Press ~w~~g~[E]~w~ to Chop Vehicle Remains")
                    if IsControlJustReleased(0, 38) then
                        RemoveBlip(blipDropOff)
                        if CoolDownActive then
                            TriggerEvent('DoLongHudText', 'You recently chopped come back later', 2)
                        else
                            ChopVehiclePart(vehicle)
                        end
                    end
                end
                idle = 0
            end
            if not distance or distance > 10.0 then
                IsUsingInteractiveChopping = false
            end
            Wait(idle)
        end
    end)
end

--// Car Spawns Chopshop

local ChopCarSpawns = {		
	[1] =  { ['x'] = -16.87911605835, ['y'] = -1408.8527832031, ['z'] = 28.656372070312, ['h'] = 269.29135131836, ['info'] = 'Chop Pickup 1' },
    [2] =  { ['x'] = 164.76922607422, ['y'] = -1511.0241699219, ['z'] = 28.487915039062, ['h'] = 317.48031616211, ['info'] = 'Chop Pickup 2' },
    [3] =  { ['x'] = 385.71429443359, ['y'] = -1652.4527587891, ['z'] = 47.646118164062, ['h'] = 323.14959716797, ['info'] = 'Chop Pickup 3' },
    [4] =  { ['x'] = 603.61315917969, ['y'] = -1866.4219970703, ['z'] = 24.090087890625, ['h'] = 323.14959716797, ['info'] = 'Chop Pickup 4' },
    [5] =  { ['x'] = 1074.7912597656, ['y'] = -2322.7121582031, ['z'] = 29.650512695312, ['h'] = 85.039367675781, ['info'] = 'Chop Pickup 5' },
    [6] =  { ['x'] = 1566.6724853516, ['y'] = -2172.1450195312, ['z'] = 76.93115234375, ['h'] = 167.24407958984, ['info'] = 'Chop Pickup 6' },
    [7] =  { ['x'] = 1482.0395507812, ['y'] = -1917.4813232422, ['z'] = 70.76416015625, ['h'] = 31.181102752686, ['info'] = 'Chop Pickup 7' },
}

local ChopCars = {
	[1] = 'Intruder',   
	[2] = 'Buffalo',
	[3] = 'Huntley',
	[4] = 'Sultan',	
	[5] = 'Primo',
	[6] = 'MiniVan',	
	[7] = 'Asterope',
    [8] = 'Superd',    
	[9] = 'Asea',	
}

function CreatePickupCarBlip(x, y ,z)
    blipPickup = AddBlipForCoord(x, y, z)
    SetBlipHighDetail(blipPickup, true)
    SetBlipColour(blipPickup, 1)
    SetBlipScale(blipPickup, 0.75)
    SetBlipAlpha(blipPickup, 250)
    SetBlipDisplay(blipPickup, 2)
    SetBlipSprite(blipPickup, 227)
    AddTextEntry("Pickup", "Pickup Chop Vehicle")
    BeginTextCommandSetBlipName("Pickup")
    SetBlipCategory(blipPickup, 2)
    EndTextCommandSetBlipName(blipPickup)
    SetBlipRoute(blipPickup, true)
	SetBlipRouteColour(blipPickup, 29)
  end

RegisterNetEvent('fa-chopshop:acceptOffer')
AddEventHandler('fa-chopshop:acceptOffer', function()
   TriggerServerEvent("fa-chopshop:startJob")
end)

RegisterNetEvent("fa-activities:startJobChop")
AddEventHandler("fa-activities:startJobChop", function(Location)
    if DoesEntityExist(aspectChopCar) then
        SetVehicleHasBeenOwnedByPlayer(aspectChopCar, false)
        SetEntityAsNoLongerNeeded(aspectChopCar)
        DeleteEntity(aspectChopCar)
    end

    local aspectChopVehicle = GetHashKey(ChopCars[math.random(#ChopCars)])
    RequestModel(aspectChopVehicle)
    while not HasModelLoaded(aspectChopVehicle) do
        Wait(0)
    end

    aspectChopCar = CreateVehicle(aspectChopVehicle, ChopCarSpawns[Location]["x"], ChopCarSpawns[Location]["y"], ChopCarSpawns[Location]["z"], ChopCarSpawns[Location]["h"], true, false)

    RPC.execute('fa-activities:updateChopNotiAndBlip', aspectChopCar, ChopCarSpawns[Location]["x"], ChopCarSpawns[Location]["y"], ChopCarSpawns[Location]["z"])
end)

RegisterNetEvent('fa-activities:createBlipLocationChopshop')
AddEventHandler('fa-activities:createBlipLocationChopshop', function(xLocation, yLocation, zLocation, chopVehicle)
    CreatePickupCarBlip(xLocation, yLocation, zLocation)
    goingChopLoc = true
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Pick the vehicle up at the location on the GPS. (Make sure the leader is the one driving the chop vehicle)')

    CreateThread(function()
        while goingChopLoc do
            Wait(500)

            if IsPedInAnyVehicle(PlayerPedId(), true) then
                if GetVehiclePedIsUsing(PlayerPedId()) == chopVehicle then
                    RPC.execute('fa-activities:updateChopDriveDropOff')
                    goingChopLoc = false
                end
            end
        end
    end)
end)

RegisterNetEvent('fa-activities:syncDriveDropLocation')
AddEventHandler('fa-activities:syncDriveDropLocation', function()
    headingChopLocation = true
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Head over to the Chop Location.')
    blipDropOff = AddBlipForCoord(1360.2725830078, -2095.0549316406, 51.993408203125)
    SetBlipHighDetail(blipDropOff, true)
    SetBlipColour(blipDropOff, 1)
    SetBlipScale(blipDropOff, 0.75)
    SetBlipAlpha(blipDropOff, 250)
    SetBlipDisplay(blipDropOff, 2)
    SetBlipSprite(blipDropOff, 227)
    AddTextEntry("Pickup", "Chop Vehicle")
    BeginTextCommandSetBlipName("Pickup")
    SetBlipCategory(blipDropOff, 2)
    EndTextCommandSetBlipName(blipDropOff)
    SetBlipRoute(blipDropOff, true)
    SetBlipRouteColour(blipDropOff, 29)
    RemoveBlip(blipPickup)
end)

exports["fa-polyzone"]:AddBoxZone("chop_shop_clockin", vector3(-218.9, -1368.77, 31.26), 2.0, 1.8, {
    name="chop_shop_clockin",
    heading=30,
    --debugPoly=false,
    minZ=28.46,
    maxZ=32.46
})

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "chop_shop_clockin" then
        chopShopSignIn = true
        if exports['isPed']:isPed('myjob') == 'chopshop' then
            exports['fa-interface']:showInteraction('[E] Sign Out', 'error')

            Citizen.CreateThread(function()
                while chopShopSignIn do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("jobssystem:jobs", "unemployed")
                        RPC.execute('fa-phone:group_CheckOut')
                        exports['fa-phone']:phoneNotification('jobactivity', 'Clocked Out.', 'Job Center')
                        chopShopSignIn = false
                    end
                end
            end)
        elseif exports['fa-inventory']:hasEnoughOfItem('vpnxj', 1) then
            exports['fa-interface']:showInteraction('[E] Sign In')

            Citizen.CreateThread(function()
                while chopShopSignIn do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("jobssystem:jobs", "chopshop")
                        exports['fa-phone']:phoneNotification('jobactivity', 'Signed in as Chop Shop.', 'Job Center')
                        exports['fa-interface']:hideInteraction()
                        chopShopSignIn = false
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "chop_shop_clockin" then
        chopShopSignIn = false
        exports['fa-interface']:hideInteraction()
    end
end)

function canStartChop()
    if IsInChopZone then
        chopLocation = true
    elseif not IsInChopZone then
        chopLocation = false
    end
    return chopLocation
end

RegisterNetEvent('sendUpdatedNoti2Chop')
AddEventHandler('sendUpdatedNoti2Chop', function()
    TriggerEvent('fa-phone:JobNotify', 'CURRENT', 'Get out of the vehicle and begin to Chop.')
end)