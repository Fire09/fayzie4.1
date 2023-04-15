local lastValues = {}
local currentValues = {
  ["hunger"] = 100,
  ["thirst"] = 100,
  ["oxy"] = 100,
  ["stress"] = 100,
  ["crosshair"] = false,
  ["radio"] = false,
}

local flyingCars = {
  [`oppressor`] = true,
  [`oppressor2`] = true,
  [`deluxo`] = true,
  [`rcbandito`] = true,
  [`ruiner2`] = true,
}

local isBlocked = false
hasStarted = false

exports('HasStarted', function()
  return hasStarted
end)

function getArmorAndStressData()
  --print("getArmorAndStressData")
  local meta = RPC.execute("police:getMeta")
  if meta == nil then return end
  if meta.thirst == nil then 
    currentValues["thirst"] = 100 
  else 
    currentValues["thirst"] = meta.thirst 
  end
  if meta.hunger == nil then 
    currentValues["hunger"] = 100 
  else 
    currentValues["hunger"] = meta.hunger 
  end
  if meta.health < 110.0 then
    SetEntityHealth(PlayerPedId(),110.0)
  else
    SetEntityHealth(PlayerPedId(),meta.health)
  end
  if meta.armour == nil then
    --print("meta.armor is nil")
    SetPlayerMaxArmour(PlayerId(), 60)
    SetPedArmour(PlayerPedId(),0)
  else
    --print("meta.armor is not nil")
    SetPlayerMaxArmour(PlayerId(), 60)
    SetPedArmour(PlayerPedId(),meta.armour)
  end
  if stresslevel == 0 then
      stresslevel = RPC.execute("police:getStress")
  end
  if dstamina == 0 then
      RevertToStressMultiplier()
  end
  hasStarted = true
end

exports('getArmorAndStressData', getArmorAndStressData)

RegisterNetEvent("fa-spawn:characterSpawned")
AddEventHandler("fa-spawn:characterSpawned", function()
    charSpawned = true
    Citizen.CreateThread(function()
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(0)
        Citizen.Wait(0)
        -- sendAppEvent("hud", {
        --     display = true,
        -- })
        -- startHealthArmorUpdates()
    end)
end)

RegisterNetEvent("fa-hud:initHud")
AddEventHandler("fa-hud:initHud", function()
  print("[fa-hud] Init hud...")
  getArmorAndStressData()
  if not hasStarted then
    --print("HASNT STARTED WAIT 1 SECOND")
    Wait(1000)
  end
  if hasStarted then
    print("[fa-hud] Fully started, and init.")
    --Wait(100)
    local initialHudSettings = exports["fa-hud"]:GetPreferences()
    if initialHudSettings ~= "{}" then
      exports["fa-hud"]:sendAppEvent("preferences", initialHudSettings)
      exports["fa-interface"]:sendAppEvent('preferences', initialHudSettings)
      TriggerEvent("fa-preferences:setPreferences", initialHudSettings)
    end
    --TriggerEvent("fa-spawn:characterSpawned")
    exports["fa-hud"]:startHealthArmorUpdates()
    exports["fa-hud"]:sendAppEvent("hud", {
      display = true,
    })
  end
  --print("Has started: " .. tostring(hasStarted))
end)

function initHud()
  print("[fa-hud] Init hud...")
  getArmorAndStressData()
  if not hasStarted then
    --print("HASNT STARTED WAIT 1 SECOND")
    Wait(1000)
  end
  if hasStarted then
    print("[fa-hud] Fully started, and init.")
    --Wait(100)
    local initialHudSettings = exports["fa-hud"]:GetPreferences()
    if initialHudSettings ~= "{}" then
      exports["fa-hud"]:sendAppEvent("preferences", initialHudSettings)
      exports["fa-interface"]:sendAppEvent('preferences', initialHudSettings)
      TriggerEvent("fa-preferences:setPreferences", initialHudSettings)
    end
    --TriggerEvent("fa-spawn:characterSpawned")
    exports["fa-hud"]:startHealthArmorUpdates()
    exports["fa-hud"]:sendAppEvent("hud", {
      display = true,
    })
  end
  --print("Has started: " .. tostring(hasStarted))
end

stresslevel = 0
dstamina = 0

AddEventHandler('onClientResourceStart', function(resourceName)

  --TriggerEvent("fa-spawn:characterSpawned")
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  initHud()
  -- getArmorAndStressData()
  -- if hasStarted then
  --   print("hasStarted")
  --   --Wait(100)
  --   local initialHudSettings = GetPreferences()
  --   sendAppEvent("preferences", initialHudSettings)
  --   exports["fa-interface"]:sendAppEvent('preferences', initialHudSettings)
  --   TriggerEvent("fa-preferences:setPreferences", initialHudSettings)
  --   TriggerEvent("fa-spawn:characterSpawned")
  --   sendAppEvent("hud", {
  --     display = true,
  --   })
  -- end
end)

CreateThread(function()
    SetPedMinGroundTimeForStungun(pedId, 5000)
    SetEntityProofs(pedId, false, false, false, false, false, true, false, false)
    SetPlayerHealthRechargeMultiplier(plyId, 0.0)
    while true do
        if PlayerPedId() ~= PlayerPedId() then
            pedId = PlayerPedId()
            SetPedMinGroundTimeForStungun(pedId, 5000)
            SetEntityProofs(pedId, false, false, false, false, false, true, false, false)
        end
        SetRadarBigmapEnabled(false, false)
        Wait(2000)
    end
end)

-- DISABLE BLIND FIRING
Citizen.CreateThread(function()
    while true do
        if IsPedInCover(PlayerPedId(), 0) and not IsPedAimingFromCover(PlayerPedId()) then
            DisablePlayerFiring(PlayerPedId(), true)
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('fa-admin:maxstats')
AddEventHandler('fa-admin:maxstats', function()
    currentValues["thirst"] = 100
    currentValues["hunger"] = 100 
    TriggerEvent("heal", PlayerPedId())
    TriggerEvent("Hospital:HealInjuries", PlayerPedId(),true) 
    TriggerServerEvent("fa-death:reviveSV", source)
    TriggerServerEvent("reviveGranted", source)
    TriggerServerEvent("ems:healplayer", source)
    SetPlayerMaxArmour(PlayerPedId(), 100)
    SetPedArmour(PlayerPedId(), 100)
    TriggerEvent("hud:saveCurrentMeta")
end)

local stressDisabled = false
RegisterNetEvent("client:disableStress")
AddEventHandler("client:disableStress",function(stressNew)
  stressDisabled = stressNew
end)

local stressMultiplier = 0
AddEventHandler("client:stressMultiplier", function(pStressMultiplier)
  stressMultiplier = pStressMultiplier
end)
RegisterNetEvent("client:newStress")
AddEventHandler("client:newStress",function(positive, alteredValue, skipHudText)
  if stressDisabled and positive then
    return
  end

  local nAlteredValue = alteredValue
  if stressMultiplier > 0 then
    nAlteredValue = (nAlteredValue / 2) + ((nAlteredValue / 2) * (1 - stressMultiplier))
  end

  TriggerServerEvent("server:alterStress", positive, math.ceil(nAlteredValue))
  if skipHudText then
    return
  end

  if positive then
    TriggerEvent("DoShortHudText", 'Stress Gained', 6)
  else
    TriggerEvent("DoShortHudText",'Stress Relieved', 6)
  end
end)

Citizen.CreateThread(function()
  while true do
      if not isBlocked then
          if currentValues["stress"] >= 100 then
              TriggerScreenblurFadeIn(1000.0)
              Wait(3000)
              TriggerScreenblurFadeOut(1000.0)
          elseif currentValues["stress"] <= 99 and currentValues["stress"] >=45 then
              TriggerScreenblurFadeIn(1000.0)
              Wait(100)
              TriggerScreenblurFadeOut(1000.0)
          end
      end 
      Citizen.Wait(2000)
  end
end)

RegisterNetEvent("fa-admin:currentDevmode")
AddEventHandler("fa-admin:currentDevmode", function(devmode)
  isBlocked = devmode
end)

RegisterNetEvent("stress:timed")
AddEventHandler("stress:timed",function(alteredValue,scenario)
  local removedStress = 0
  Wait(1000)

  TriggerEvent("DoShortHudText",'Stress is being relieved',6)
  SetPlayerMaxArmour(PlayerId(), 60 )
  while true do
    removedStress = removedStress + 100
    if removedStress >= alteredValue then
      break
    end

    local armor = GetPedArmour(PlayerPedId())
    SetPedArmour(PlayerPedId(),armor+3)

    if scenario ~= "None" then
      if not IsPedUsingScenario(PlayerPedId(),scenario) then
        TriggerEvent("animation:cancel")
        break
      end
    end
    Citizen.Wait(1000)
  end
  TriggerServerEvent("server:alterStress",false,removedStress)
end)

currentValues["oxy"] = 25.0

opacity = 0
fadein = false


exports('getStressLevel', function()
  return stresslevel
end)

RegisterNetEvent("status:needs:restore")
AddEventHandler("status:needs:restore", function ()
  currentValues["hunger"] = 100
  currentValues["thirst"] = 100
end)

-- stress, 10000 is maximum, 0 being lowest.
RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
  stresslevel = newStress
  if dstamina == 0 then
    RevertToStressMultiplier()
  end
end)
sitting = false

function RevertToStressMultiplier()
  local factor = (stresslevel / 2) / 10000
  local factor = 1.0 - factor
  
  if factor > 0.1 then
    SetSwimMultiplierForPlayer(PlayerId(), factor)
    SetRunSprintMultiplierForPlayer(PlayerId(), factor)
  else
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
  end
end

exports('revertToStress', RevertToStressMultiplier)

imdead = 0


RegisterNetEvent('setToMaxHungerThrist')
AddEventHandler('setToMaxHungerThrist', function()
  currentValues["thirst"] = 100
  currentValues["hunger"] = 100
end)

local buffStartTime = 0
local buffItems = {
  ["craftedgemjade"] = true,
}
AddEventHandler("buffs:triggerBuff", function(item)
  if not buffItems[item] then return end
  if buffStartTime ~= 0 then return end
  buffStartTime = GetGameTimer()
  TriggerEvent("fa-buffs:addUIBuff", { buffedHunger = true, buffedThirst = true })
  Citizen.CreateThread(function()
    Citizen.Wait(60000 * 60 * 6) -- 6hr
    buffStartTime = 0
    TriggerEvent("fa-buffs:addUIBuff", { buffedHunger = false, buffedThirst = false })
  end)
end)

local buffHungerMultiplier = 0
AddEventHandler("carhud:slowHunger", function(percent)
  buffHungerMultiplier = percent
end)

local citrineStartTime = 0
local citrineBuffItems = {
  ["craftedgemcitrine"] = true,
}
AddEventHandler("buffs:triggerBuff", function(item)
  if not citrineBuffItems[item] then return end
  if citrineStartTime ~= 0 then return end
  citrineStartTime = GetGameTimer()
  TriggerEvent("fa-buffs:addUIBuff", { buffedHealth = true, buffedArmor = true })
  Citizen.CreateThread(function()
    Citizen.Wait(60000 * 60 * 6) -- 3hr
    citrineStartTime = 0
    TriggerEvent("fa-buffs:addUIBuff", { buffedHealth = false, buffedArmor = false })
  end)
end)

Citizen.CreateThread(function()
  while true do
    if currentValues["hunger"] > 0 then
      --print("DECREASE HUNGER")
      currentValues["hunger"] = currentValues["hunger"] - math.random(3)
    end
    if currentValues["thirst"] > 0 then
      --print("DECREASE THIRST")
      currentValues["thirst"] = currentValues["thirst"] - 3
    end	
    
    if currentValues["thirst"] < 20 or currentValues["hunger"] < 20 then
      local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
      SetEntityHealth(PlayerPedId(), newhealth)
    end
    
    if not hasStarted then 
      --print("HAS NOT STARTED")
      Citizen.Wait(1000)
    end

    --print("HAS STARTED")

    TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
    local hungerDecayTimer = 300000
    Citizen.Wait(hungerDecayTimer)
    if buffStartTime ~= 0 then
      Citizen.Wait(hungerDecayTimer / 2)
    elseif buffHungerMultiplier > 0 then
      Citizen.Wait(hungerDecayTimer / (2 + (1 - buffHungerMultiplier)))
    end
  end
end)

RegisterNetEvent('lowerthirst')
AddEventHandler('lowerthirst', function()
  currentValues["thirst"] = currentValues["thirst"] - 1

  if currentValues["thirst"] < 0 then
    currentValues["thirst"] = 0
  end

  if currentValues["thirst"] > 100 then
    currentValues["thirst"] = 100
  end
end)

RegisterNetEvent('changethirst')
AddEventHandler('changethirst', function(pNewValue)
  --("CHANGETHIRST", pNewValue)
  local value = (pNewValue and pNewValue > 0) and pNewValue or 10
  currentValues["thirst"] = currentValues["thirst"] + value

  if currentValues["thirst"] < 0 then
    currentValues["thirst"] = 0
  end

  if currentValues["thirst"] > 100 then
    currentValues["thirst"] = 100
  end

end)

RegisterNetEvent('addThirst')
AddEventHandler('addThirst', function(value)
  currentValues["thirst"] = currentValues["thirst"] + value

  if currentValues["thirst"] < 0 then
    currentValues["thirst"] = 0
  end

  if currentValues["thirst"] > 100 then
    currentValues["thirst"] = 100
  end

end)



RegisterNetEvent('coffee:drink')
AddEventHandler('coffee:drink', function()
  currentValues["thirst"] = currentValues["thirst"] + 45

  if currentValues["thirst"] < 0 then
    currentValues["thirst"] = 0
  end

  if currentValues["thirst"] > 100 then
    currentValues["thirst"] = 100
  end
end)

RegisterNetEvent('changehunger')
AddEventHandler('changehunger', function(pNewValue)
  local newValue = pNewValue or 10
  currentValues["hunger"] = currentValues["hunger"] + newValue

  if currentValues["hunger"] < 0 then
    currentValues["hunger"] = 0
  end

  if currentValues["hunger"] > 100 then
    currentValues["hunger"] = 100
  end
end)

local colorblind = false
RegisterNetEvent('option:colorblind')
AddEventHandler('option:colorblind',function()
    colorblind = not colorblind
end)

local lastDamageTrigger = 0

RegisterNetEvent("fire:damageUser")
AddEventHandler("fire:damageUser", function(Reqeuester)
  local attacker = GetPlayerFromServerId(Reqeuester)
  local Attackerped = GetPlayerPed(attacker)

  if IsPedShooting(Attackerped) then
    local name = GetSelectedPedWeapon(Attackerped)
    if name == `WEAPON_FIREEXTINGUISHER` and not exports["isPed"]:isPed("dead") then
      lastDamageTrigger = GetGameTimer()
      currentValues["oxy"] = currentValues["oxy"] - 15
    end
  end
end)

local swimSpeedIncreased = false
AddEventHandler("carhud:increaseSwimSpeed", function(pIncrease)
  swimSpeedIncreased = pIncrease
  SetSwimMultiplierForPlayer(PlayerId(), pIncrease and 1.05 or 1.0)
end)

local hasChanged = false
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local plyPed = PlayerPedId()

    if IsPedSwimmingUnderWater(plyPed) then
      if currentValues["oxy"] > 0 then
        SetPedDiesInWater(plyPed, false)
        if not hasChanged then
          SetAudioSubmixEffectParamInt(0, 0, `enabled`, 1)
          hasChanged = true
        end
        if currentValues["oxy"] > 25.0 then
          currentValues["oxy"] = currentValues["oxy"] - 0.003125
        else
          currentValues["oxy"] = currentValues["oxy"] - (swimSpeedIncreased and 0.33 or 0.5)
        end
      else
        SetPedDiesInWater(plyPed, true)
      end
    end

    if (not IsPedSwimmingUnderWater(plyPed)) and hasChanged then
      SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
      hasChanged = false
    end

    if not IsPedSwimmingUnderWater( plyPed ) and currentValues["oxy"] < 25.0 then
      if GetGameTimer() - lastDamageTrigger > 3000 then
        currentValues["oxy"] = currentValues["oxy"] + 1
        if currentValues["oxy"] > 25.0 then
          currentValues["oxy"] = 25.0
        end
      else
        if currentValues["oxy"] <= 0 then

          if exports["isPed"]:isPed("dead") then
            lastDamageTrigger = -7000
            currentValues["oxy"] = 25.0
          else
            SetEntityHealth(plyPed, GetEntityHealth(plyPed) - 20)
          end
        end
      end
    end

    if currentValues["oxy"] > 25.0 and (not oxyOn) and (useBlackOxy) then
      oxyOn = true
      attachProp("p_s_scuba_tank_s_black", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s_black", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif currentValues["oxy"] > 25.0 and not oxyOn then
      oxyOn = true
      attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif oxyOn and currentValues["oxy"] <= 25.0 then
      oxyOn = false
      removeAttachedProp()
      removeAttachedProp2()
      useBlackOxy = false
    end
    if not oxyOn then
      if IsPedSwimming(plyPed) then
        ResetPlayerStamina(plyPed)
      end
      Wait(200)
    else
      if (IsPedRunning(plyPed) or IsPedSprinting(plyPed)) and not IsPedSwimming(plyPed) then
        DisableControlAction(0, 21, true)
      end
    end
  end
end)

function lerp(min, max, amt)
  return (1 - amt) * min + amt * max
end

function rangePercent(min, max, amt)
  return (((amt - min) * 100) / (max - min)) / 100
end

-- this should just use nui instead of drawrect - it literally ass fucks usage.
Citizen.CreateThread(function()
  local counter = 0
  local get_ped = PlayerPedId() -- current ped
  local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
  local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
  local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
  local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage
  local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
  local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
  local thespeed = GetEntitySpeed(get_ped_veh) * 3.6
  currentValues["parachute"] = HasPedGotWeapon(get_ped, `gadget_parachute`, false)

  local huntingRifleHash = `weapon_sniperrifle2` -- -646649097

  while true do
    if sleeping then
      if IsControlJustReleased(0,38) then
        sleeping = false
        DetachEntity(PlayerPedId(), 1, true)
      end
      if IsControlJustReleased(0,75) then
        showInteraction = false
      end
    end

    if not hasStarted then
      Citizen.Wait(100)
    end

    Citizen.Wait(0)
    
    if counter == 0 then
      get_ped = PlayerPedId()
      SetPedSuffersCriticalHits(get_ped,true)
      get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
      plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
      veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
      veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage
      veh_body_health = GetVehicleBodyHealth(get_ped_veh)
      veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
      thespeed = GetEntitySpeed(get_ped_veh) * 3.6
      currentValues["stress"] = math.ceil(stresslevel / 100)
      currentValues["parachute"] = HasPedGotWeapon(get_ped, `gadget_parachute`, false)

      local pRadio = exports['radio']:pChannel()

      exports["fa-hud"]:sendAppEvent("hud", {
        hasRadio = pRadio
      })

      currentValues["radio"] = pRadio

      if currentValues["stress"] > 100 then currentValues["stress"] = 100 end

      if currentValues["hunger"] < 0 then
        currentValues["hunger"] = 0
      end
      if currentValues["thirst"] < 0 then
        currentValues["thirst"] = 0
      end

      if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end

      if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end
      local valueChanged = false

      if currentValues["oxy"] <= 0 then currentValues["oxy"] = 0 end

      for k,v in pairs(currentValues) do
        if lastValues[k] == nil or lastValues[k] ~= v then
          valueChanged = true
          lastValues[k] = v
        end
      end
      if valueChanged then
        exports["fa-hud"]:sendAppEvent("hud", {
            hunger = currentValues["hunger"],
            oxygen = currentValues["oxy"],
            stress = currentValues["stress"],
            thirst = currentValues["thirst"],
            hasRadio = currentValues["radio"]
        })
      end

      counter = 360

    end

    counter = counter - 1

    if get_ped_veh ~= 0 then
      local model = GetEntityModel(get_ped_veh)
      local roll = GetEntityRoll(get_ped_veh)

      if not IsThisModelABoat(model)
        and not IsThisModelAHeli(model)
        and not IsThisModelAPlane(model)
        and not IsThisModelABicycle(model)
        and not IsThisModelABike(model)
        and not IsThisModelAJetski(model)
        and not IsThisModelAQuadbike(model)
        and not flyingCars[model]
        and (IsEntityInAir(get_ped_veh) or (roll < -50 or roll > 50)) then
          DisableControlAction(0, 59) -- leaning left/right
          DisableControlAction(0, 60) -- leaning up/down
      end

      if GetPedInVehicleSeat(GetVehiclePedIsIn(get_ped, false), 0) == get_ped then
        if GetIsTaskActive(get_ped, 165) then
          SetPedIntoVehicle(get_ped, GetVehiclePedIsIn(get_ped, false), 0)
        end
      end
    end
  end
end)

RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
  --print("saving current meta", GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
  TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
end)

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if pStress ~= nil then
    if pStress == 0 or pStress < 0 then
     TriggerScreenblurFadeOut(1000.0)
    end
    end
  end
end)