local defaultHash, defaultHash2, defaultHash3, defaultHash4, defaultHash5, defaultHash6, defaultHash7 = "npolvette","npolstang", "npolchal","npolmm", "npolchar", "chr20"

local pursuitEnabled = false
local InPursuitModeAPlus = false
local InPursuitModeB = false

RegisterNetEvent("fa-hud:pursuit_mode_a")
AddEventHandler("fa-hud:pursuit_mode_a",function()
	local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
		local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local First = 'A +'
		if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) or IsVehicleModel(veh,defaultHash6) then
			SetVehicleModKit(veh, 0)
			SetVehicleMod(veh, 46, 4, true)
			SetVehicleMod(veh, 11, 4, true)
			SetVehicleMod(veh, 12, 4, false)
			SetVehicleMod(veh, 13, 4, false)
			ToggleVehicleMod(veh,  18, false)          
			TriggerEvent('PursuitModeIcon:Enable:A+') -- Turns on pursuit mode icon on HUD 
			TriggerEvent('DoLongHudText', 'New Mode : ' ..First)
			PursuitEnabled = true
			SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.3970000)
			SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

			SelectedPursuitMode = 70
            inPursuitVehicle = true
            currentPursuitMode = 2
		else
            inPursuitVehicle = false
			TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
		end
	end
end)

RegisterNetEvent("fa-hud:pursuit_mode_b") -- Second Pursuit Mode
AddEventHandler("fa-hud:pursuit_mode_b",function()
	local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
		local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode1 = 'B +'
		
		if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) or IsVehicleModel(veh,defaultHash6) or IsVehicleModel(veh,defaultHash7) then
			SetVehicleModKit(veh, 0)
			SetVehicleMod(veh, 46, 4, true)
			SetVehicleMod(veh, 11, 4, true)
			SetVehicleMod(veh, 12, 4, true)
			SetVehicleMod(veh, 13, 4, true)
			ToggleVehicleMod(veh,  18, true)          
			TriggerEvent('PursuitModeIcon:Enable:B+') -- Turns on pursuit mode icon on HUD 
			TriggerEvent('DoLongHudText', 'New Mode : ' ..mode1)
			PursuitEnabled = true
			SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4270000)
			SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

			SelectedPursuitMode = 35
            inPursuitVehicle = true
            currentPursuitMode = 1
		else
            inPursuitVehicle = false
			TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
		end
	end
end)
	
RegisterNetEvent("fa-hud:pursuit_mode_s")  -- Final Pursuit Mode for now anyways 0_o
AddEventHandler("fa-hud:pursuit_mode_s",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode2 = 'S +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) or IsVehicleModel(veh,defaultHash6) or IsVehicleModel(veh,defaultHash7) then
			SetVehicleModKit(veh, 0)
			SetVehicleMod(veh, 46, 4, true)
			SetVehicleMod(veh, 11, 4, true)
			SetVehicleMod(veh, 12, 4, true)
			SetVehicleMod(veh, 13, 4, true)
			ToggleVehicleMod(veh,  18, true)          
			TriggerEvent('PursuitModeIcon:Enable:S+') -- Turns on pursuit mode icon on HUD
			TriggerEvent('DoLongHudText', 'New Mode : ' ..mode2)
			PursuitEnabled = true
			SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4970000)
			SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.100000)

			SelectedPursuitMode = 100
            inPursuitVehicle = true
            currentPursuitMode = 3
		else
            inPursuitVehicle = false
			TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
		end
	end
end)

RegisterNetEvent("fa-hud:pursuit_mode_off")
AddEventHandler("fa-hud:pursuit_mode_off",function()
local ped = PlayerPedId()
if (IsPedInAnyVehicle(PlayerPedId(), true)) then
	local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
	local Driver = GetPedInVehicleSeat(veh, -1)
	local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
	if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) or IsVehicleModel(veh,defaultHash6) or IsVehicleModel(veh,defaultHash7) then
			TriggerEvent('PursuitModeIcon:Disable')
			SetVehicleModKit(veh, 0)
			SetVehicleMod(veh, 46, 4, false)
			SetVehicleMod(veh, 13, 4, false)
			SetVehicleMod(veh, 12, 4, false)
			SetVehicleMod(veh, 11, 4, false)
			ToggleVehicleMod(veh,  18, false)

			TriggerEvent("DoLongHudText","Pursuit Mode Disabled",2 )                
			InPursuitModeAPlus = false
			pursuitEnabled = false
			InPursuitModeB = false
			SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.305000)
			SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 0.850000)
			SelectedPursuitMode = 0
            inPursuitVehicle = false
		else
			TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
		end
	end
end)

RegisterCommand('+evan_shift_pursuit_mode', function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
	if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) or IsVehicleModel(veh,defaultHash6) or IsVehicleModel(veh,defaultHash7) then
		if not pursuitEnabled and not passedFirstMode then
			passedFirstMode = true
			pursuitEnabled = true
			TriggerEvent('fa-hud:pursuit_mode_b')
		elseif pursuitEnabled and not passedSecondMode then
			passedSecondMode = true
			InPursuitModeAPlus = true
			pursuitEnabled = false
			TriggerEvent('fa-hud:pursuit_mode_a') 
		elseif InPursuitModeAPlus and not passedThirdMode then
			passedThirdMode = true
			InPursuitModeB = true
			InPursuitModeAPlus = false
			TriggerEvent('fa-hud:pursuit_mode_s')
		elseif InPursuitModeB then
			passedFirstMode = false
			passedSecondMode = false
			passedThirdMode = false
			InPursuitModeAPlus = false
			TriggerEvent('fa-hud:pursuit_mode_off')
		end
	end
end)

Citizen.CreateThread(function()
    exports["fa-keybinds"]:registerKeyMapping("", "Pursuit Modes", "Change Mode", "+evan_shift_pursuit_mode", "")
end)


RegisterCommand('sharlock', function(source, args, RawCommand)
	local ped = PlayerPedId()
	local cid = exports["isPed"]:isPed("cid")
	if cid == 70 then
	  	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			local Driver = GetPedInVehicleSeat(veh, -1)
			local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
			local mode2 = 'S +'
			SetVehicleModKit(veh, 0)
			SetVehicleMod(veh, 46, 4, true)
			SetVehicleMod(veh, 11, 4, true)
			SetVehicleMod(veh, 12, 4, true)
			SetVehicleMod(veh, 13, 4, true)
			ToggleVehicleMod(veh,  18, true)          
			TriggerEvent('PursuitModeIcon:Enable:S+') -- Turns on pursuit mode icon on HUD
			TriggerEvent('DoLongHudText', 'New Mode : ' ..mode2)
			PursuitEnabled = true
			SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.1970000)
			SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.100000)

			SelectedPursuitMode = 100
			inPursuitVehicle = true
			currentPursuitMode = 3
		end
	  end
  end)