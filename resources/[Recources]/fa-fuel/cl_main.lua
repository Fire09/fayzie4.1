local isNearGasStation = false
local isFueling = false
local hasNozle = false
local canReturnNozle = true
local canRefillVehicle = true
local canPayBill = false
local zoneData = nil
local GallonPrice = 3
local paid = false
attachedProp = 0

local FuelClasses = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 0.8, -- SUVs
	[3] = 1.2, -- Coupes
	[4] = 1.1, -- Muscle
	[5] = 1.3, -- Sports Classics
	[6] = 1.2, -- Sports
	[7] = 1.2, -- Super
	[8] = 0.8, -- Motorcycles
	[9] = 1.0, -- Off-road
	[10] = 0.8, -- Industrial
	[11] = 0.8, -- Utility
	[12] = 0.8, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.2, -- Service
	[18] = 1.2, -- Emergency
	[19] = 1.2, -- Military
	[20] = 1.2, -- Commercial
	[21] = 1.0, -- Trains
}

local FuelUsage = {
	[1.0] = 0.4,
	[0.9] = 0.4,
	[0.8] = 0.3,
	[0.7] = 0.3,
	[0.6] = 0.2,
	[0.5] = 0.2,
	[0.4] = 0.1,
	[0.3] = 0.1,
	[0.2] = 0.1,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

local GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

exports["fa-polyzone"]:AddBoxZone("gas_station", vector3(49.4187, 2778.793, 58.043), 30.0, 30.0, {
    name="gas_station",
    heading=0,
})
 
exports["fa-polyzone"]:AddBoxZone("gas_station1", vector3(263.894, 2606.463, 44.983), 30.0, 30.0, {
    name="gas_station1",
    heading=0,
})

exports["fa-polyzone"]:AddBoxZone("gas_station2", vector3(1039.958, 2671.134, 39.550), 30.0, 30.0, {
    name="gas_station2",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station3", vector3(1207.260, 2660.175, 37.899), 30.0, 30.0, {
    name="gas_station3",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station4", vector3(2539.685, 2594.192, 37.944), 30.0, 30.0, {
    name="gas_station4",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station5", vector3(2679.858, 3263.946, 55.240), 30.0, 30.0, {
    name="gas_station5",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station6", vector3(2005.055, 3773.887, 32.403), 30.0, 30.0, {
    name="gas_station6",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station7", vector3(1687.156, 4929.392, 42.078), 30.0, 30.0, {
    name="gas_station7",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station8", vector3(1701.314, 6416.028, 32.763), 30.0, 30.0, {
    name="gas_station8",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station9", vector3(179.857, 6602.839, 31.868), 30.0, 30.0, {
    name="gas_station9",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station10", vector3(-94.4619, 6419.594, 31.489), 30.0, 30.0, {
    name="gas_station10",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station11", vector3(-2554.996, 2334.40, 33.078), 30.0, 30.0, {
    name="gas_station11",
    heading=0,
})

exports["fa-polyzone"]:AddBoxZone("gas_station12", vector3(-1800.375, 803.661, 138.651), 30.0, 30.0, {
    name="gas_station12",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station13", vector3(-1437.622, -276.747, 46.207), 30.0, 30.0, {
    name="gas_station13",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station14", vector3(-2096.243, -320.286, 13.168), 30.0, 30.0, {
    name="gas_station14",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station15", vector3(-724.619, -935.1631, 19.213), 30.0, 30.0, {
    name="gas_station15",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station16", vector3(-526.019, -1211.003, 18.184), 30.0, 30.0, {
    name="gas_station16",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station17", vector3(-70.2148, -1761.792, 29.534), 30.0, 30.0, {
    name="gas_station17",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station18", vector3(265.648, -1261.309, 29.292), 30.0, 30.0, {
    name="gas_station18",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station19", vector3(819.653, -1028.846, 26.403), 30.0, 30.0, {
    name="gas_station19",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station20", vector3(1208.951, -1402.567,35.224), 30.0, 30.0, {
    name="gas_station20",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station21", vector3(1181.381, -330.847, 69.316), 30.0, 30.0, {
    name="gas_station21",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station22", vector3(620.843, 269.100, 103.089), 30.0, 30.0, {
    name="gas_station22",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station23", vector3(2581.321, 362.039, 108.468), 30.0, 30.0, {
    name="gas_station23",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station24", vector3(176.631, -1562.025, 29.263), 30.0, 30.0, {
    name="gas_station24",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station25", vector3(-319.292, -1471.715, 30.549), 30.0, 30.0, {
    name="gas_station25",
    heading=0,
})
exports["fa-polyzone"]:AddBoxZone("gas_station26", vector3(1784.324, 3330.55, 41.253), 30.0, 30.0, {
    name="gas_station26",
    heading=0,
})

function getVehicleClosestToMe()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
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
	
	if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

local function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function SetVehicleFuel(sentVeh, sentFuel)
	if not DoesEntityExist(sentVeh) then return end;
	if type(sentFuel) == 'number' and sentFuel >= 0 and sentFuel <= 100 then
		local fuel = sentFuel + 0.0
		Entity(sentVeh).state:set('fuel', fuel, true)
		SetVehicleFuelLevel(sentVeh, fuel)
	end
end

local function GetVehicleFuel(sentVeh)
	if not DoesEntityExist(sentVeh) then return end;
	return Entity(sentVeh).state.fuel or -1.0
end

local function doFuel(sentVeh)
	local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))

	if DoesEntityExist(sentVeh) then
		local currFuel = GetVehicleFuel(sentVeh)
		if currFuel == -1.0 then
			TriggerServerEvent('fa-fuel:initFuel', VehToNet(sentVeh))
		elseif IsVehicleEngineOn(sentVeh) then
			if GetDisplayNameFromVehicleModel(model) == "savanna" then
				return
			else
				SetVehicleFuel(sentVeh, currFuel - FuelUsage[Round(GetVehicleCurrentRpm(sentVeh), 1)] * (FuelClasses[GetVehicleClass(sentVeh)] or 1.0) / 10) -- From LegacyFuel
			end
		end
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

exports('SetVehicleFuel', SetVehicleFuel) -- exports['fa-fuel']:SetVehicleFuel(veh, fuel)
exports('GetVehicleFuel', GetVehicleFuel)-- exports['fa-fuel']:GetVehicleFuel(veh)

CreateThread(function()
	--[[ for i=1, #GasStations do
		local blip = AddBlipForCoord(GasStations[i])    
		SetBlipSprite(blip, 361)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Gas Station")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip, true)
	end ]]
	GasStations = nil
	while true do
		Wait(1000)
		local plyPed = PlayerPedId()
		local plyVeh = GetVehiclePedIsIn(plyPed, false)
		if plyVeh ~= 0 then
			local plySeat = GetPedInVehicleSeat(plyVeh, -1) == plyPed
			if plySeat then
				doFuel(plyVeh)
			end
		end
	end
end)

--[[ Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		print(isNearGasStation)
	end
end) ]]

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name, data)
    if name == "gas_station" or name == "gas_station1" or name == "gas_station2" or name == "gas_station3" or name == "gas_station4" or name == "gas_station5" or name == "gas_station6" or name == "gas_station7" or name == "gas_station8" or name == "gas_station9" or name == "gas_station10" or name == "gas_station11" or name == "gas_station12" or name == "gas_station13" or name == "gas_station14" or name == "gas_station15" or name == "gas_station16" or name == "gas_station17" or name == "gas_station18" or name == "gas_station19" or name == "gas_station20" or name == "gas_station21" or name == "gas_station22" or name == "gas_station23" or name == "gas_station24" or name == "gas_station25" or name == "gas_station26"  then
        isNearGasStation = true
		zoneData = data 
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
	if name == "gas_station" or name == "gas_station1" or name == "gas_station2" or name == "gas_station3" or name == "gas_station4" or name == "gas_station5" or name == "gas_station6" or name == "gas_station7" or name == "gas_station8" or name == "gas_station9" or name == "gas_station10" or name == "gas_station11" or name == "gas_station12" or name == "gas_station13" or name == "gas_station14" or name == "gas_station15" or name == "gas_station16" or name == "gas_station17" or name == "gas_station18" or name == "gas_station19" or name == "gas_station20" or name == "gas_station21" or name == "gas_station22" or name == "gas_station23" or name == "gas_station24" or name == "gas_station25" or name == "gas_station26"  then
        isNearGasStation = false
		zoneData = nil
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		if playerVeh ~= 0 and hasNozle then
			Citizen.Wait(500)
			TriggerEvent("fa-fuel:ReturnNozel")
			NetworkExplodeVehicle(playerVeh, true, false, 0)
			hasNozle = false
		end 
    end
end)

RegisterNetEvent('fa-fuel:SelectFuel', function()
	local menuData = {
		{
            title = "Gas Pump",
            description = "Select the kind of fuel you want to use",
			icon = 'info-circle',
            key = "EVENTS.GAS",
        },
		{
            title = "Regular",
            description = "Octane: 87 | Price: $".. GallonPrice,
			icon = 'gas-pump',
            key = "EVENTS.REFUEL",
			action = 'fa-fuel:FuelSelected'
        },
    }
    exports["fa-interface"]:showContextMenu(menuData)
end)

RegisterInterfaceCallback("fa-fuel:FuelSelected", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	if not hasNozle then
		hasNozle = true
		canReturnNozle = false
		TriggerEvent("attachItemRadio","fuel_nozle")
		-- attachedProp = CreateObject(GetHashKey("prop_cs_fuel_nozle"), 0, 0, 0, true, true, true)
		-- AttachEntityToEntity(attachedProp, currentPed, GetPedBoneIndex(currentPed, 0xDEAD), 0.13, 0.04, -0.03, 80.0, 100.0, 190.0, true, true, false, true, 1, true)
	end
end)

RegisterNetEvent('fa-fuel:ReturnNozel', function()
	if hasNozle then
		TriggerEvent("destroyPropRadio")
		hasNozle = false
		canReturnNozle = true
	end
end)

RegisterNetEvent('fa-fuel:RefillVehicle', function()
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice

	local menuData = {
		{
			title = "Refuel Vehicle",
			description = "Fuel Amount: ".. math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh)) .. " | Total Cost: $".. FuelCost .. ".0",
			icon = 'info-circle',
			key = "EVENTS.GAS",
		},
		{
			title = "Start Refueling",
			icon = 'gas-pump',
			key = "EVENTS.REFUEL",
			action = 'fa-fuel:RefuelVehicle',
			disabled = not canPayBill
		},
		{
			title = "Send Bill",
			icon = 'credit-card',
			key = "EVENTS.CARD",
			action = 'fa-fuel:pay_bank',
			disabled = canPayBill
		},
		{
			title = "Self Serve",
			icon = 'address-card',
			key = "EVENTS.CARD",
			action = 'fa-fuel:send_billSelf',
			disabled = canPayBill
		},
	}
	exports["fa-interface"]:showContextMenu(menuData)
end)

RegisterInterfaceCallback('fa-fuel:pay_bank', function(data, cb, pParams)
	cb({ data = {}, meta = { ok = true, message = '' } })
	exports['fa-interface']:openApplication('textbox', {
		callbackUrl = 'fa-fuel:send_bill',
		key = 1,
		items = {
		  {
			icon = "address-card",
			label = "Paypal ID",
			name = "pPaypalID",
		  },
		},
	  show = true,
	})
end)

RegisterInterfaceCallback('fa-fuel:send_bill', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice
	TriggerServerEvent("fa-phone:send_gas_bill", data.values.pPaypalID, FuelCost)
end) 

RegisterInterfaceCallback('fa-fuel:send_billSelf', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice
	TriggerServerEvent("fa-fuel:testing", FuelCost)
end) 


RegisterNetEvent('fa-fuel:send_billSelf2', function(data)
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh)) 
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice

	TriggerServerEvent("fa-phone:send_gas_bill", data, FuelCost)
end)
	 
 
RegisterNetEvent('fa-fuel:SendBillToBank', function(fCost)
	TriggerEvent('fa-phone:client:gasOffer', 'Fuel Cost: $' .. fCost)
end)
 
RegisterNetEvent('fa-fuel:cl:phone:offer:accepted', function()
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice
	if not paid then
		paid = true
		canPayBill = RPC.execute('fa-fuel:PurchaseSuccessful', FuelCost)
	end
	canRefillVehicle = false
end)

RegisterInterfaceCallback('fa-fuel:RefuelVehicle', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['fa-vehicles']:GetVehicleFuel(veh))
	local timer = (100 - vehicleCurrentFuel) * 400
	local math = math.random(1, 100)

	loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@","idle_a",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)

	SetUIFocus(false, false)
	-- exports['fa-taskbar']:Progress({
	-- 	duration = timer,
	-- 	label = "Refueling",
	-- }, function(cancelled)
	local finished = exports['fa-taskbar']:taskBar(timer, 'Refueling')
	if finished == 100 then
		paid = false
		exports['fa-vehicles']:SetVehicleFuel(veh, 100)
		canRefillVehicle = true
		canPayBill = false
		ClearPedTasks(PlayerPedId())
		if GetIsVehicleEngineRunning(veh) then
			if math <= 26 then
				NetworkExplodeVehicle(veh, true, false, 0)
				TriggerEvent("destroyPropRadio")
			end
		end
	else
		canRefillVehicle = true
		canPayBill = false
		ClearPedTasks(PlayerPedId())
	end
end)

exports("hasNozle", function()
	return hasNozle
end)

exports("NearGasFn", function()
	return isNearGasStation
end)

exports("gasZoneData", function()
	return zoneData
end)