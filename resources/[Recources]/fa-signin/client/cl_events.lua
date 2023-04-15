local listening = false
local lastPlate = nil

RegisterNetEvent('nowCopGarage')
AddEventHandler('nowCopGarage', function(job)
  TriggerServerEvent("AddPlayerToRadio", 1.0, GetPlayerServerId(PlayerId()))
  TriggerEvent('nowCopDeath')

  if job == "police" then
    TriggerEvent('nowCopSpawn')
  end

  SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
  SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
  SetPoliceIgnorePlayer(PlayerPedId(),true)
end)

RegisterNetEvent("hasSignedOnEms")
AddEventHandler("hasSignedOnEms", function()
  SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
  SetPoliceIgnorePlayer(PlayerPedId(),true)
end)


RegisterInterfaceCallback("fa-signin:handler", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  local eventData = data.key
  if eventData.sign_in then
    if eventData.job == "police" then
      TriggerEvent("fa-duty:OnDuty")
    else
      TriggerServerEvent("fa-signin:duty", eventData.job)
    end
    elseif eventData.sign_off then
    TriggerEvent ("fa-duty:OffDuty")
  end
  cb({ data = {}, meta = { ok = true, message = "done" } })
end)

RegisterInterfaceCallback("fa-signin:spawnVehicle", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  local eventData = data.key
  if eventData == VOLUNTEER_VEHICLES.STANDARD then
    local currentJob = exports["isPed"]:isPed("myjob")
    if currentJob == "ems" then
      spawnVehicle("emsnspeedo")
    end
  elseif eventData == VOLUNTEER_VEHICLES.FIRETRUCK then
    local currentJob = exports["isPed"]:isPed("myjob")
    if currentJob == "ems" then
      spawnVehicle("firetruk")
    end
  end
  cb({ data = {}, meta = { ok = true, message = "done" } })
end)

function spawnVehicle(pVehicle)
  local spawnLocation = findClosestSpawnPoint(GetEntityCoords(PlayerPedId()))
  local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
  if DoesEntityExist(getVehicleInArea) then
    TriggerEvent("DoLongHudText", "The area is crowded", 2)
    return
  end

  if lastPlate ~= nil then
    TriggerEvent("keys:remove",lastPlate)
  end

  local vehicle = GetHashKey(pVehicle)
  RequestModel(vehicle)
  while not HasModelLoaded(vehicle) do
    Wait(0)
  end

  local plate = "EMS ".. GetRandomIntInRange(1000, 9000)
  local spawned_car = CreateVehicle(vehicle, spawnLocation, -20.0, true, false)

  SetVehicleNumberPlateText(spawned_car, plate)
  TriggerEvent("keys:addNew",spawned_car,plate)
  TriggerServerEvent('garages:addJobPlate', plate)
  SetPedIntoVehicle(PlayerPedId(), spawned_car, - 1)
  lastPlate = plate
  Wait(250)
end

AddEventHandler("fa-signin:peekAction", function(pArgs, pEntity, pContext)
  if not pArgs.name then return end

    local name = ("%s_sign_in"):format(pArgs.name)
    print(name)

  if name ~= "officer_sign_in" and name ~= "ems_sign_in" and name ~= "ems_volunteer_sign_in" and name ~= "fire_dept_sign_in" and name ~= "public_services_sign_in" and name ~= "driving_instructor_sign_in" and name ~= "phone_doj_sign_in"  then return end
  print(MenuData[name])
  exports["fa-interface"]:showContextMenu(MenuData[name])
end)

AddEventHandler('fa-island:hideBlips', function(pState)
  for _, item in pairs(Blips) do
    if DoesBlipExist(item.blip) then
      if pState then
        SetBlipAlpha(item.blip, 0)
        SetBlipHiddenOnLegend(item.blip, true)
      else
        SetBlipAlpha(item.blip, 255)
        SetBlipHiddenOnLegend(item.blip, false)
      end
    end
  end
end)
