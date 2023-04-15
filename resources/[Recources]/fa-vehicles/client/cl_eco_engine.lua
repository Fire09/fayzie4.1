function enableEcoSoundMode()
  local finished = 0
  local cancelNos = false
  local veh = GetVehiclePedIsIn(PlayerPedId(), false)
  if veh == 0 then return end

  -- if isCopVehicle(veh) then return end
  
  Citizen.CreateThread(function()
    while finished ~= 100 and not cancelNos do
      Citizen.Wait(100)
      if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) > 11 then
        exports["fa-taskbar"]:closeGuiFail()
        cancelNos = true
      end
    end
  end)
  finished = exports["fa-taskbar"]:taskBar(15000, "Eco Mode")
  if (finished == 100 and not cancelNos) then
    local data = {
      netId = NetworkGetNetworkIdFromEntity(GetVehiclePedIsIn(PlayerPedId(), false)),
      type = "ecoMode",
    }
    TriggerServerEvent("fa-mdt:changeVehicleData", data, true)
  else
    TriggerEvent("DoLongHudText", "You can't drive and enable eco mode at the same time.", 2)
  end
end

RegisterCommand("+toggleEcoMode", function()
  enableEcoSoundMode()
end, false)
RegisterCommand("-toggleEcoMode", function() end, false)

Citizen.CreateThread(function()
  exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Toggle Eco Mode", "+toggleEcoMode", "-toggleEcoMode")
end)

function isCopVehicle(pVehicle)
  local policeVehicles = exports["fa-config"]:GetModuleConfig("fa-police").policeVehicles
  local isCopCar = false
  for carModel, _ in pairs(policeVehicles) do
    if GetHashKey(carModel) == GetEntityModel(pVehicle) then
      isCopCar = true
    end
  end
  return isCopCar
end
