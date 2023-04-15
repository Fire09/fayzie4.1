RegisterNetEvent("fa-police:impoundVehicle")
AddEventHandler("fa-police:impoundVehicle", function(pArgs, pEntity, pContext)
  TriggerServerEvent("fa-police:impoundVehicle", VehToNet(pEntity))
end)

	local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), 0) == playerPed then
				if GetIsTaskActive(playerPed, 165) then
					SetPedIntoVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityUpsidedown(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end 
        end
    end
end)


RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it

	RegisterNetEvent('car:engine')
	AddEventHandler('car:engine', function()
		local targetVehicle = GetVehiclePedIsUsing(PlayerPedId())
		TriggerEvent("keys:hasKeys", 'engine', targetVehicle)
	end)


local engineStartedText = "Engine Started"
local engineHaltedText = "Engine Halted"


RegisterNetEvent('car:engineHasKeys')
local engineOn = false

AddEventHandler('car:engineHasKeys', function(targetVehicle, allow)
    if not debouncing then
        debouncing = true
        if engineOn then
            SetVehicleEngineOn(targetVehicle, false, 1, 1)
            SetVehicleUndriveable(targetVehicle, true)
            TriggerEvent("DoShortHudText", engineHaltedText, 1)
            engineOn = false

        else
            TriggerEvent("keys:startvehicle")
            TriggerEvent("DoShortHudText", engineStartedText, 1)
            engineOn = true
        end

        SetTimeout(300, function()
            debouncing = false
        end)
    end
end)
