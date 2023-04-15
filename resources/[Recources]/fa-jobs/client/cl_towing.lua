local EndlessRP = {}
local towedavehicle = false
local CanImp = false
local SentNotiBack = false
local setimpoundveh = ""
local pHi = true
local UpdatedNoti = false
local towing_duty = false
local pVeh = nil

local towingLocations = {
	[1] =  { ['x'] = 1780.4293212891, ['y'] = 3347.5656738281, ['z'] = 40.598194122314, ['h'] = 29.283344268799 },
	[2] =  { ['x'] = 1913.896484375, ['y'] = 2509.1208496094, ['z'] = 54.544578552246, ['h'] = 142.74772644043 },
	[3] =  { ['x'] = 1401.9534912109, ['y'] = 717.19586181641, ['z'] = 78.307861328125, ['h'] = 142.46832275391 },
	[4] =  { ['x'] = 878.08532714844, ['y'] = 282.68029785156, ['z'] = 86.619430541992, ['h'] = 141.57322692871 },
	[5] =  { ['x'] = 839.71820068359, ['y'] = -98.327613830566, ['z'] = 80.399070739746, ['h'] = 240.2437286377 },
	[6] =  { ['x'] = 1160.0949707031, ['y'] = -559.45196533203, ['z'] = 64.362022399902, ['h'] = 185.07582092285 },
	[7] =  { ['x'] = 789.85327148438, ['y'] = -840.5517578125, ['z'] = 43.122009277344, ['h'] = 91.725814819336 },
	[8] =  { ['x'] = 80.740493774414, ['y'] = -1028.9412841797, ['z'] = 29.276815414429, ['h'] = 159.46659851074 },
}

local function crowdedPrevention(pCurrentPosition)
	local coords = vector3(-209.5658, -1169.601, 23.134445)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

RegisterNetEvent('fa-jobs:getFlatbed')
AddEventHandler('fa-jobs:getFlatbed', function()
	RequestModel("flatbed")
	while not HasModelLoaded("flatbed") do
		Citizen.Wait(0)
	end
	local spawnCar = crowdedPrevention(GetEntityCoords(PlayerPedId()))
	local getVehicleArea = GetClosestVehicle(spawnCar, 3.000, 0, 70)
	if DoesEntityExist(getVehicleArea) then
		TriggerEvent("DoLongHudText", "The area is crowded", 2)
		return
	end
	local veh = CreateVehicle("flatbed", vector3(-209.5658, -1169.601, 23.134445), 179.87483, true)
	local vehplate = "TOW"..math.random(10000, 99999) 
	SetVehicleNumberPlateText(veh, vehplate)
	Citizen.Wait(100)
	TriggerEvent("keys:addNew", veh, vehplate)
	SetModelAsNoLongerNeeded(model)
end)

RegisterNetEvent('fa-jobs_tow_trucker_off_duty')
AddEventHandler('fa-jobs_tow_trucker_off_duty', function()
	if exports['isPed']:isPed('myjob') == 'towtrucker' then
		TriggerEvent('DoLongHudText', 'Clocked Out!', 2)
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

--###################################################
function deleteVeh(ent)
	SetVehicleHasBeenOwnedByPlayer(ent, true)
	NetworkRequestControlOfEntity(ent)
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(ent))
	DeleteEntity(ent)
	DeleteVehicle(ent)
	SetEntityAsNoLongerNeeded(ent)
end

--###################################################
RegisterNetEvent('fa-jobs:clockIntoTowing')
AddEventHandler('fa-jobs:clockIntoTowing', function(towingLocation)
	RPC.execute('fa-jobs:towtruckingGetJob', towingLocation)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
			if EndlessRP.Looking then
				if #(vector3(towingLocations[towingLocation]["x"], towingLocations[towingLocation]["y"], towingLocations[towingLocation]["z"]) - GetEntityCoords(PlayerPedId())) <= 120 then
					if not SentNotiBack then
						SentNotiBack = true
						TriggerEvent('fa-phone:JobNotify', 'CURRENT', "Get the vehicle on the back of the flatbed.")
					end
					local vehicle = exports['fa-vehicles']:GetVehicleTable()
					local vehiclehash = vehicle[math.random(1, #vehicle)].model
					isAbleImp = 1
					RequestModel(vehiclehash)
					while not HasModelLoaded(vehiclehash) do
						Citizen.Wait(0)
					end
					CanImp = true
					EndlessRP.VehicleID = CreateVehicle(vehiclehash, towingLocations[towingLocation]["x"], towingLocations[towingLocation]["y"], towingLocations[towingLocation]["z"], true, false)
					SetEntityHeading(EndlessRP.VehicleID, towingLocations[towingLocation]["h"])
					local plate = GetVehicleNumberPlateText(EndlessRP.VehicleID)
					RPC.execute('fa-jobs:syncVehiclePlateImpound', plate)
					SetVehicleOnGroundProperly(EndlessRP.VehicleID)
					SetModelAsNoLongerNeeded(vehiclehash)
					Citizen.Wait(100)
					local netid = NetworkGetNetworkIdFromEntity(EndlessRP.VehicleID)
					SetNetworkIdCanMigrate(netid, true)
					NetworkRegisterEntityAsNetworked(VehToNet(EndlessRP.VehicleID))	
					SetEntityVisible(EndlessRP.VehicleID, true)
					SetVehicleEngineHealth(EndlessRP.VehicleID, 850)
					SmashVehicleWindow(EndlessRP.VehicleID, 0)
					SmashVehicleWindow(EndlessRP.VehicleID, 1)
					SmashVehicleWindow(EndlessRP.VehicleID, 2)
					SmashVehicleWindow(EndlessRP.VehicleID, 3)
					SmashVehicleWindow(EndlessRP.VehicleID, 4)
					SetVehicleDoorBroken(EndlessRP.VehicleID, math.random(1,2), true)
					SetVehicleDoorBroken(EndlessRP.VehicleID, math.random(3,4), true)
					SetVehicleDoorBroken(EndlessRP.VehicleID, math.random(5,6), true)
					SetVehicleTyreBurst(EndlessRP.VehicleID, 1, false, 990.0)
					SetVehicleTyreBurst(EndlessRP.VehicleID, 2, false, 990.0)
					SetVehicleTyreBurst(EndlessRP.VehicleID, 3, false, 990.0)
					SetVehicleTyreBurst(EndlessRP.VehicleID, 4, false, 990.0)
					EndlessRP.Looking = false
				end
			end
		end
	end)
end)

RegisterNetEvent('fa-jobs:towTruckPlateSync')
AddEventHandler('fa-jobs:towTruckPlateSync', function(vehiclePlate)
	setimpoundveh = vehiclePlate
end)

RegisterNetEvent('fa-jobs:towingGetJob')
AddEventHandler('fa-jobs:towingGetJob', function(pLoc)
	TriggerEvent('fa-phone:JobNotify', 'CURRENT', "Make your way over to the vehicle.")
	pGoToCar = AddBlipForCoord(towingLocations[pLoc]["x"], towingLocations[pLoc]["y"], towingLocations[pLoc]["z"])
	SetBlipSprite(pGoToCar, 227)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Tow Vehicle")
	EndTextCommandSetBlipName(pGoToCar)
	SetBlipRoute(pGoToCar, 2)
	SetBlipRouteColour(pGoToCar, 3)
	SetBlipColour(pGoToCar, 3)
	EndlessRP.Chosen = false
	towedavehicle = true
	while not EndlessRP.Chosen do
		Citizen.Wait(1000)
		EndlessRP.Chosen = true
		EndlessRP.Looking = true
	end
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
			if EndlessRP.Looking then
				if #(vector3(towingLocations[pLoc]["x"], towingLocations[pLoc]["y"], towingLocations[pLoc]["z"]) - GetEntityCoords(PlayerPedId())) <= 120 then
					TriggerEvent('fa-phone:JobNotify', 'CURRENT', "Get the vehicle on the back of the flatbed.")
					isAbleImp = 1
					CanImp = true
				end
			end
		end
	end)
end)

RegisterNetEvent('fa-jobs:sendClientReturnImpound')
AddEventHandler('fa-jobs:sendClientReturnImpound', function()
	SentWaypoint = true
	RemoveBlip(pGoToCar)
	pImpLotGoTo = AddBlipForCoord(-240.50, -1180.94, 23.04)
	SetBlipSprite(pImpLotGoTo, 50)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Impound Lot")
	EndTextCommandSetBlipName(pImpLotGoTo)
	SetBlipRoute(pImpLotGoTo, 2)
	SetBlipRouteColour(pImpLotGoTo, 3)
	SetBlipColour(pImpLotGoTo, 3)
	UpdatedNoti = false
	TriggerEvent('fa-phone:JobNotify', 'CURRENT', "Go back to the impound and drop off the vehicle.")
end)

-- Imp Veh --
RegisterNetEvent('fa-jobs:towing_imp')
AddEventHandler('fa-jobs:towing_imp', function()
	CoordX = GetEntityCoords(PlayerPedId(), 1)
	CoordY = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	veh = getVehicleInDirection(CoordX, CoordY)
	if DoesEntityExist(veh) and NetworkHasControlOfEntity(veh) then
		licensePlate = GetVehicleNumberPlateText(veh)
		if licensePlate == setimpoundveh then
			if CanImp then
				TriggerEvent('fa-jobs_tow_menu')
			end
		else
			TriggerEvent('DoLongHudText', 'Wrong vehicle', 2)
		end
	end
end)

RegisterNetEvent('fa-jobs_tow_menu')
AddEventHandler('fa-jobs_tow_menu', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
	local TowMenu = {
		{
			title = "Impound | Plate: "..GetVehicleNumberPlateText(targetVehicle),
			Description = "Impound Offer"
		},
		{
			title = "Accept",
			action = "fa-jobs:accept_impound_req",
		},
		{
			title = "Decline",
			action = "fa-jobs:decline_impound_req",
		},
	}
	exports["fa-interface"]:showContextMenu(TowMenu)
end)

RegisterInterfaceCallback('fa-jobs:accept_impound_req', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	coordA = GetEntityCoords(PlayerPedId(), 1)
	coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
	vehicle = getVehicleInDirection(coordA, coordB)
	SentReturnNoti = false
	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		licensePlate = GetVehicleNumberPlateText(vehicle)
		if licensePlate == setimpoundveh then
			isAbleImp = 0
			CanImp = false
			DeleteEntity(vehicle)
			RPC.execute('fa-jobs:towTruckingAcceptImpoundOffer')
			RemoveBlip(pGoToCar)
		else
			TriggerEvent('DoLongHudText', 'Incorrect Vehicle.', 2)
		end
	end
end)

RegisterNetEvent('fa-jobs:acceptImpoundOffer')
AddEventHandler('fa-jobs:acceptImpoundOffer', function()
	exports['fa-phone']:phoneNotification('jobactivity', 'Job Complete.', 'Job Center')
	SentWaypoint = false
	SentNotiBack = false
	if exports['fa-hud']:MoneyBuff() then
		RPC.execute('fa-jobs:givePayout', math.random(1076, 1554), "cash", '[24/7 Delivery Job | With Buff]')
	else
		RPC.execute('fa-jobs:givePayout', math.random(652, 886), "cash", '[24/7 Delivery Job | Without Buff]')
	end
	RemoveBlip(pImpLotGoTo)
	Citizen.Wait(2500)
	TriggerEvent('fa-phone:JobNotifyClose')
end)

RegisterInterfaceCallback('fa-jobs:decline_impound_req', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	RPC.execute('fa-jobs:towTruckingDeclineImpoundOffer')
end)

RegisterNetEvent('fa-jobs:rejectImpoundRequest')
AddEventHandler('fa-jobs:rejectImpoundRequest', function()
	TriggerEvent('DoLongHudText', 'Impound Offer Declined')
	isAbleImp = 0
	CanImp = false
    SentWaypoint = false
    RemoveBlip(pImpLotGoTo)
end)

-- export --
function IsAbleImp()
    if isAbleImp == 1 then
        impPogShit = true
    elseif isAbleImp == 0 then
        impPogShit = false
    end
    return impPogShit
end

function isTowing()
    if exports['isPed']:isPed('myjob') == 'towtrucker' then
        clockedon = true
    elseif not clockedon then
        clockedon = false
    end
    return clockedon
end

-- Start/Stop Towing Job --
exports["fa-polyzone"]:AddBoxZone("towing_clock_in_zone", vector3(-191.63, -1166.46, 23.67), 2, 2, {
	name="towing_clock_in_zone",
	heading=0,
	--debugPoly=false,
	minZ=21.27,
	maxZ=25.27
})

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
	if name == "towing_clock_in_zone" then
		towing_duty = true
        if exports['isPed']:isPed('myjob') == 'towtrucker' then
            exports['fa-interface']:showInteraction('[E] Sign Out', 'error')
            Citizen.CreateThread(function()
                while towing_duty do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("jobssystem:jobs", "unemployed")
						RPC.execute('fa-phone:group_CheckOut')
                        exports['fa-phone']:phoneNotification('jobactivity', 'Clocked Out.', 'Job Center')
                        towing_duty = false
						exports['fa-interface']:hideInteraction()
                    end
                end
            end)
        else
            exports['fa-interface']:showInteraction('[E] Sign In')
            Citizen.CreateThread(function()
                while towing_duty do
                    Citizen.Wait(5)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("jobssystem:jobs", "towtrucker")
						exports['fa-phone']:phoneNotification('jobactivity', 'Signed in as Tow Truck driver.', 'Job Center')
                        exports['fa-interface']:hideInteraction()
                        towing_duty = false
						local needATruck = {
							{
								title = "Yes I need a towtruck",
								action = 'fa-jobs:getTowtruck',
							},
							{
								title = "Nah I have my own or im in another group.",
								action = 'fa-jobs:declineTowtruck',
							},
						}
						exports["fa-interface"]:showContextMenu(needATruck)
                    end
                end
            end)
        end
	end
end)

RegisterInterfaceCallback('fa-jobs:getTowtruck', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-jobs:getFlatbed')
end)

RegisterInterfaceCallback('fa-jobs:declineTowtruck', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "towing_clock_in_zone" then
        towing_duty = false
        exports['fa-interface']:hideInteraction()
    end
end)

-- Tow Command Shit --
local currentlyTowedVehicle
local pickUplocation
local mypaytruck = 0

local towVehicles = {
	"towtruck",
	"towtruck2",
	"flatbed",
	"flatbed2",	
	"flatbed3"
}

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

local function deleteVehicle(vehicle)
	if IsAnEntity(vehicle) and IsEntityAVehicle(vehicle) then
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			SetEntityAsMissionEntity(vehicle,false,true)
			DeleteVehicle(vehicle)
			SetEntityAsNoLongerNeeded(vehicle)
			return
		end)
	end
end

local function isTowVehicle(vehicle)
	for k,v in pairs(towVehicles) do
		if IsVehicleModel(vehicle, GetHashKey(v)) then return v end
	end
	return false
end

local function getVehicleInDirection(coordFrom, coordTo)
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

function CleanDetachedVehicles()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, vehicleFound = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(vehicleFound)
        local distance = #(playerCoords - pos)
        if distance < 15.0 then

      		if IsEntityAttached(vehicleFound) then
        		DetachEntity(vehicleFound, true, true)
				local drop = GetOffsetFromEntityInWorldCoords(vehicleFound, 0.0,-5.5,0.0)
				DetachEntity(vehicleFound, true, true)
				SetEntityCoords(vehicleFound,drop)
			end
			--SetEntityCoords(vehicleFound,drop)
        end
        success, vehicleFound = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
end

Citizen.CreateThread(function()
	--TriggerEvent("pv:tow")
	CleanDetachedVehicles()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, true)
		local pay = true
		if onJob and onJob == 1 and (isTowVehicle(vehicle) == "towtruck" or isTowVehicle(vehicle) == "towtruck2")  then
			local targetVehicle = GetEntityAttachedToTowTruck(vehicle)
			if currentlyTowedVehicle then
				if GetEntityAttachedToTowTruck(vehicle) ~= currentlyTowedVehicle then currentlyTowedVehicle = nil end
			end
			if targetVehicle ~= 0 or not targetVehicle then
				currentlyTowedVehicle = targetVehicle
				pickUplocation = pickUplocation and pickUplocation or GetEntityCoords(targetVehicle, true)
				local distance = CalculateTravelDistanceBetweenPoints(pickUplocation, 549.47204589844,-55.185947418213,71.188438415527)
				local pickUpToTowYard = Vdist2(pickUplocation, 549.47204589844,-55.185947418213,71.188438415527)
				local distToTowYard = Vdist2(GetEntityCoords(targetVehicle, true), 549.47204589844,-55.185947418213,71.188438415527)
				if pickUpToTowYard < 500.0 then pay = false end
				local payAmt = math.ceil(distance * 0.43)
				if payAmt > 400 then
					payAmt = 400
				end
				if distToTowYard < 120.0 then
					if pay then 
						TriggerServerEvent("server:givepayJob", "Tow Truck Car Delivery Payment", math.random(75,100)) 
					end
					DetachVehicleFromTowTruck(vehicle, targetVehicle)
					SetEntityAsNoLongerNeeded(targetVehicle)
					deleteVehicle(targetVehicle)
					targetVehicle = false
				end
			else
				targetVehicle = false
				currentlyTowedVehicle = false
				pickUplocation = false
				pay = false
				distance = false
			end
		end
	end
end)

local towingProcess = false
RegisterNetEvent('animation:tow')
AddEventHandler('animation:tow', function()
	towingProcess = true
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    while towingProcess do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('pv:tow')
AddEventHandler('pv:tow', function()
	local playerped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerped, true)
	local towmodel = `towtruck`
	local isVehicleTow = isTowVehicle(vehicle)
	if isVehicleTow then
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
		if not currentlyTowedVehicle then
			CleanDetachedVehicles()
			local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
			local back = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-1.0,0.0)
			local aDist = #(back - GetEntityCoords(targetVehicle))
	        if aDist > 3.5 then
	        	local count = 1000
		        while count > 0 do
		            Citizen.Wait(1)
		            count = count - 1
		            DrawText3Ds(back["x"],back["y"],back["z"],"Vehicle must be here to tow.")
		        end
		        return
		    end
		    local aDist = #(back - GetEntityCoords(targetVehicle))
		    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
		    TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 1.0)
		    Citizen.Wait(1000)
		    TriggerEvent("animation:tow")
		    local finished = exports["fa-taskbar"]:taskBar(15000,"Hooking up vehicle.")
        	if finished == 100 and aDist < 5.0 then
                hasVehicleHookedUp = true
				if hasVehicleHookedUp and not SentWaypoint then
					RPC.execute('fa-jobs:towtruckingReturnImpound')
				end
				if targetVehicle ~= 0 then
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck2', 0.5)
					local part2 = exports["fa-taskbar"]:taskBar(7000,"Towing Vehicle")
					local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
					if not IsPedInAnyVehicle(playerped, true) and not DoesEntityExist(driverPed) then
						if vehicle ~= targetVehicle and #(GetEntityCoords(targetVehicle) - GetEntityCoords(vehicle)) < 15.0 and GetEntitySpeed(targetVehicle < 3.0) then
							SetEntityAsMissionEntity(targetVehicle, true, true)
							NetworkRequestControlOfEntity(targetVehicle)
							local timeout = 0
							while timeout < 1000 and not NetworkHasControlOfEntity(targetVehicle) do
								timeout = timeout + 100
								NetworkRequestControlOfEntity(targetVehicle)
								Citizen.Wait(100)
							end
							if isVehicleTow == "flatbed3" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -3.3, 1.0, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							elseif isVehicleTow == "flatbed2" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -1.9, 0.5, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							elseif isVehicleTow == "flatbed" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), -0.25, -2.8, 1.1, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							end 
							currentlyTowedVehicle = targetVehicle
							local location = GetEntityCoords(targetVehicle, 0)
							mypaytruck = CalculateTravelDistanceBetweenPoints( location, 408.957, -1638.664, 28.81 )
							if CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < mypaytruck then
								mypaytruck = CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 )
							end
							if CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < mypaytruck then
								mypaytruck = CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 )
							end
						    mypaytruck = mypaytruck * 0.05
						    mypaytruck = math.ceil(mypaytruck)
					    	-- Don't pay people who are towing within the tow truck area
							if (CalculateTravelDistanceBetweenPoints( location, 549.47204589844,-55.185947418213,71.188438415527 ) < 155) then
								mypaytruck = 0
							end
							if (CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < 155) then
								mypaytruck = 0
							end
							if (CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < 155) then
								mypaytruck = 0
							end
				            if mypaytruck > 300 then
				                mypaytruck = 300
				            end			    
						else
							TriggerEvent("DoLongHudText","You can't tow that vehicle", 2)
						end
					else
						if DoesEntityExist(driverPed) then
							TriggerEvent("DoLongHudText","It appears someone is in the vehicle, you can not do this.", 2)
						end
					end
				else
					TriggerEvent("DoLongHudText","No vehicle found", 2)
				end
			end
		else
			local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
			local back = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.5,0.0)
			local drop = GetOffsetFromEntityInWorldCoords(vehicle, 1.5,d1["y"]-5.5,0.0)
			local aDist = #(back - GetEntityCoords(PlayerPedId()))
	        if aDist > 1.5 then
	        	local count = 1500
		        while count > 0 and aDist > 1.5 do
		        	back = GetOffsetFromEntityInWorldCoords(vehicle, 1.5,d1["y"]-0.5,0.0)
		        	aDist = #(GetEntityCoords(PlayerPedId()) - back)
		            Citizen.Wait(1)
		            count = count - 1
		            DrawText3Ds(back["x"],back["y"],back["z"]," Move here to untow the vehicle.")
		        end
		        if count < 1 then
		        	return
		        end
		    end
		    TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 1.0)
		    Citizen.Wait(1000)
		    TriggerEvent("animation:tow")
		    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
		    local finished = exports["fa-taskbar"]:taskBar(7000,"Untowing Vehicle")
        	if finished == 100 and aDist < 2.0 then
                hasVehicleHookedUp = false
        		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck2', 0.5)
        		local part2 = exports["fa-taskbar"]:taskBar(7000,"Unhooking Vehicle")
				CleanDetachedVehicles()
				local location = GetEntityCoords(playerped, 0)
				calc = CalculateTravelDistanceBetweenPoints( location, 549.47204589844,-55.185947418213,71.188438415527 )
				if CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < calc then
					calc = CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 )
				end
				if CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < calc then
					calc = CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 )
				end
					TriggerServerEvent("paytheuglytowpeople") 
					currentlyTowedVehicle = nil
				end
			end
		end
	towingProcess = false
end)