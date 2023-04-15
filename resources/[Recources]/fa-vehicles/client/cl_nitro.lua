local nitroactive = false
local nitroflowrate = 0.3
local nitroseviye = 0
local nitroveh
local nitrobastimi = false

local ELECTRIC_VEHICLES = {
    [GetHashKey("AIRTUG")] = true,
    [GetHashKey("CYCLONE")] = true,
    [GetHashKey("CADDY")] = true,
    [GetHashKey("CADDY2")] = true,
    [GetHashKey("CADDY3")] = true,
    [GetHashKey("DILETTANTE")] = true,
    [GetHashKey("IMORGON")] = true,
    [GetHashKey("KHAMEL")] = true,
    [GetHashKey("NEON")] = true,
    [GetHashKey("RAIDEN")] = true,
    [GetHashKey("SURGE")] = true,
    [GetHashKey("VOLTIC")] = true,
    [GetHashKey("TEZERACT")] = true,
}


RegisterNetEvent("fa-nitro:client:placeNitro")
AddEventHandler("fa-nitro:client:placeNitro", function() 
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply)
	local closestVeh = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 0)
	if IsPedInVehicle(ply, GetVehiclePedIsIn(ply, false), false) and not IsThisModelAHeli(GetVehiclePedIsIn(ply, false)) and not IsThisModelABoat(GetVehiclePedIsIn(ply, false)) and not IsThisModelABike(GetVehiclePedIsIn(ply, false)) then
		if not GetIsVehicleEngineRunning(GetVehiclePedIsIn(ply, false)) then
			 local finished = exports['fa-taskbar']:taskBar(7500, 'Hooking up Nitrous.')
			 if finished == 100 then
				if not status then
					TriggerEvent("inventory:removeItem","nitrous", 1)
					nitroactive = true
					nitroveh = GetVehiclePedIsIn(ply, false)
					nitroseviye = 100
				end
			end
		else
			TriggerEvent('DoLongHudText', 'You cant hook up nitrous with your engine on.', 2)
		end
	end
end)

RegisterNetEvent('fa-nitro:client:particlefx')
AddEventHandler('fa-nitro:client:particlefx', function (veh)	
	local exhaustNames = {
		"exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
		"exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
		"exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
		"exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
	}
	for _, exhaustName in pairs(exhaustNames) do
		local boneIndex = GetEntityBoneIndexByName(veh, exhaustName)
		if boneIndex ~= -1 then
			local pos = GetWorldPositionOfEntityBone(veh, boneIndex)
			local off = GetOffsetFromEntityGivenWorldCoords(veh, pos.x, pos.y, pos.z)
			if not HasNamedPtfxAssetLoaded("core") then
				RequestNamedPtfxAsset("core")
				while not HasNamedPtfxAssetLoaded("core") do
					Wait(1)
				end
			end
		
			UseParticleFxAssetNextCall("core")
			StartParticleFxNonLoopedOnEntity('veh_backfire', veh, off.x, off.y, off.z, 0.0, 0.0, 0.0, 0.7, false, false, false)
		end
	end
end)

RegisterNetEvent('fa-nitro:client:particlefisfis')
AddEventHandler('fa-nitro:client:particlefisfis', function (type, veh)
	if type == 'fisfisac' then
		SetVehicleNitroPurgeEnabled(veh, true)
	elseif type == 'fisfiskapat' then
		SetVehicleNitroPurgeEnabled(veh, false)
	end
end)

local vehicles = {}
local particles = {}

function IsVehicleNitroPurgeEnabled(vehicle)
  return vehicles[vehicle] == true
end

function SetVehicleNitroPurgeEnabled(vehicle, enabled)
	if IsVehicleNitroPurgeEnabled(vehicle) == enabled then
	  return
	end
	if enabled then
	 	local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
	 	local pos = GetWorldPositionOfEntityBone(vehicle, bone)
	 	local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
	 	local ptfxs = {}
  
	 	for i=0,3 do
			local leftPurge = CreateVehiclePurgeSpray(vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0)
			local rightPurge = CreateVehiclePurgeSpray(vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0)
			
			table.insert(ptfxs, leftPurge)
			table.insert(ptfxs, rightPurge)
	 	end
  
	 	SetVehicleBoostActive(vehicle, 1)
	 	vehicles[vehicle] = true
	 	particles[vehicle] = ptfxs
	else
		if particles[vehicle] and #particles[vehicle] > 0 then
			for _, particleId in ipairs(particles[vehicle]) do
			  SetVehicleBoostActive(vehicle, 0)
			  StopParticleFxLooped(particleId)
			end
		end
  
	  vehicles[vehicle] = nil
	  particles[vehicle] = nil
	end
end

function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end

    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, nitroflowrate, 0.0, 0.0, 0.0)
end

local fisfismode = false
local nitromode = true
Citizen.CreateThread(function()
	while true do 
		local sleep = 1500
		if nitroactive and nitroseviye > 0 and IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
			sleep = 1
			if fisfismode then
				if IsControlPressed(0, 21) and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then
					TriggerServerEvent('fa-nitro:server:particlefisfis', 'fisfisacc', nitroveh)
					SetVehicleBoostActive(nitroveh, 5) --Boost Sound
					nitrobastimi = true
					nitroseviye = nitroseviye - 0.05
				elseif IsControlPressed(0, 121) and nitroflowrate <= 0.5 then -- home
					nitroflowrate = nitroflowrate + 0.05
					TriggerEvent('DoLongHudText', 'Purge Spray Flowrate: ' ..nitroflowrate)
					Wait(500)
				elseif IsControlPressed(0, 214) and nitroflowrate >= 0.2 then -- delete
					nitroflowrate = nitroflowrate - 0.05
					TriggerEvent('DoLongHudText', 'Purge Spray Flowrate: ' ..nitroflowrate)
					Wait(500)
				else
					nitrobastimi = false
					TriggerServerEvent('fa-nitro:server:particlefisfis', 'fisfiskapatt', nitroveh)
				end
			elseif nitromode then
				if IsControlPressed(0, 21) and nitroveh == GetVehiclePedIsIn(PlayerPedId(), false) then -- nitro
					TriggerServerEvent('fa-nitro:server:particlefx', nitroveh)
					SetVehicleBoostActive(nitroveh, 5) --Boost Sound
					nitrobastimi = true
					nitroseviye = nitroseviye - 0.05
					Citizen.InvokeNative(0xB59E4BD37AE292DB, nitroveh, 2.0)
					Citizen.InvokeNative(0x93A3996368C94158, nitroveh, 7.0)
				else
					Citizen.InvokeNative(0xB59E4BD37AE292DB, nitroveh, 1.0)
                    Citizen.InvokeNative(0x93A3996368C94158, nitroveh, 1.0)
					nitrobastimi = false 
				end
			end
		elseif nitroseviye <= 0 then
			nitroseviye = 0
			nitroactive = false
			nitrobastimi = false 
			TriggerServerEvent('fa-nitro:server:particlefisfis', 'fisfiskapatt', nitroveh)
		end
		Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    exports["fa-keybinds"]:registerKeyMapping("", "Nitrous", "Change Mode", "+changeMode", "X")
    TriggerServerEvent("inv:playerSpawned")
    TriggerEvent("closeInventoryGui")
end)

RegisterCommand('+changeMode', function()
	if not fisfismode and nitromode and IsPedInAnyVehicle(PlayerPedId(), true) and nitroactive then
		fisfismode = true
		nitromode = false
		TriggerEvent('DoLongHudText', 'Nitro Mode: Purge')
		--exports['mythic_notify']:SendAlert('inform', 'INSERT tuşuna basarak dumanı arttırabilir, DELETE tuşuna basarak dumanı azaltabilirsiniz', 5000)
	elseif not nitromode and fisfismode then
		nitromode = true
		fisfismode = false
		TriggerEvent('DoLongHudText', 'Nitro Mode: Nitro', 2)
	end
end)

exports('noslevel', function()
	return nitroseviye
end)

exports('nitroaktifmi', function()
	return nitrobastimi
end)

AddEventHandler('onResourceStart', function (resource)
	nitroseviye = 0
	nitroactive = false
	TriggerServerEvent('fa-nitro:server:particlefisfis', 'fisfiskapatt')
	nitroveh = nil
	nitrobastimi = false 
end)

function IsVehicleElectric(model)
    return ELECTRIC_VEHICLES[model] or false
end

exports("IsVehicleElectric", IsVehicleElectric)