function CreateVehicleExhaustBackfire(vehicle, scale)
    local exhaustNames = {
      "exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
      "exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
      "exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
      "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
    }
  
    for _, exhaustName in ipairs(exhaustNames) do
      local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)
  
      if boneIndex ~= -1 then
        local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
        local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
  
        UseParticleFxAssetNextCall('core')
        StartParticleFxNonLoopedOnEntity('veh_backfire', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale, false, false, false)
      end
    end
  end
  
  function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
  end

  local idx = 0

  local particles = {}

  local boostLoop = false
  local boostVeh = nil
  local purgeEnabled = false

  RegisterNetEvent("fx:nitrous")
  AddEventHandler("fx:nitrous", function(pVehicle)
    boostLoop = true
    boostVeh = pVehicle
  end)

  RegisterNetEvent("fx:purge")
  AddEventHandler("fx:purge", function(pVehicle)
        local bone = GetEntityBoneIndexByName(pVehicle, 'bonnet')
        local pos = GetWorldPositionOfEntityBone(pVehicle, bone)
        local off = GetOffsetFromEntityGivenWorldCoords(pVehicle, pos.x, pos.y, pos.z)
        local ptfxs = {}
    
        for i=0,3 do
          local leftPurge = CreateVehiclePurgeSpray(pVehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.5)
          local rightPurge = CreateVehiclePurgeSpray(pVehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.5)
    
          table.insert(ptfxs, leftPurge)
          table.insert(ptfxs, rightPurge)
        end
    
        particles[pVehicle] = ptfxs
  end)

  RegisterNetEvent("fx:stopToggle")
  AddEventHandler("fx:stopToggle", function(pVehicle)
    boostLoop = false
    if particles[pVehicle] and #particles[pVehicle] > 0 then
        for _, particleId in ipairs(particles[pVehicle]) do
            StopParticleFxLooped(particleId)
        end
    end
  end)

  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if boostLoop then
          CreateVehicleExhaustBackfire(boostVeh, 1.25)
        end
    end
  end)