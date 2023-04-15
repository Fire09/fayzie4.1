local wingsuiting = false
local usedSuperBoost = false
local superBoostActive = false
AddEventHandler("fa-inventory:itemUsed", function(pItem)
  if pItem ~= "wingsuit" then return end
  if wingsuiting then return end
  local playerPed = PlayerPedId()
  local veh = GetVehiclePedIsIn(playerPed, false)
  if veh ~= 0 then return end
  if GetEntityHeightAboveGround(playerPed) < 3 then return end
  wingsuiting = true
  usedSuperBoost = false
  Citizen.CreateThread(function()
    TriggerEvent("inventory:removeItem", pItem, 1)
    Wait(200)
    TriggerEvent("fa-props:attachProp", "np_wingsuit_open", 24817, 0.1, -0.15, 0.0, 0.0, 90.0, 0.0, true, true, "np_wingsuit_open")
  end)
  Citizen.CreateThread(function()
    SetPlayerParachuteModelOverride(PlayerId(), `p_parachute1_mp_s`)
    SetPedParachuteTintIndex(playerPed, 6)
    GiveWeaponToPed(playerPed, -72657034, 1, 0, 1)
    --Setup for your Hud
    TriggerEvent("hud:equipParachute")
  end)
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      Wait(500)
    end
    TriggerEvent("fa-props:removePropByName", "np_wingsuit_open")
    wingsuiting = false
  end)
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      if IsControlPressed(0, 8) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 30.0, 2.5, 0.0, 0.0, 0.0, 0, true, false, false, false, true)
      elseif IsControlPressed(0, 32) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 80.0, 75.0, 0.0, 0.0, -75.0, 0, true, false, false, false, true)
      end
      if IsControlPressed(0, 22) and (not usedSuperBoost) then
        usedSuperBoost = true
        Citizen.CreateThread(function()
          superBoostActive = true
          while superBoostActive do
            ApplyForceToEntity(playerPed, 1, 0.0, 200.0, 400.0, 0.0, 0.0, -300.0, 0, true, false, false, false, true)
            Wait(0)
          end
        end)
        Citizen.CreateThread(function()
          Wait(1500)
          superBoostActive = false
        end)
      end
      Wait(0)
    end
  end)
end)

AddEventHandler("fa-inventory:itemUsed", function(pItem)
  if pItem ~= "wingsuitb" then return end
  if wingsuiting then return end
  local playerPed = PlayerPedId()
  local veh = GetVehiclePedIsIn(playerPed, false)
  if veh ~= 0 then return end
  if GetEntityHeightAboveGround(playerPed) < 3 then return end
  wingsuiting = true
  usedSuperBoost = false
  Citizen.CreateThread(function()
    TriggerEvent("inventory:removeItem", pItem, 1)
    Wait(200)
    TriggerEvent("fa-props:attachProp", "np_wingsuit_b_open", 24817, 0.1, -0.15, 0.0, 0.0, 90.0, 0.0, true, true, "np_wingsuit_b_open")
  end)
  Citizen.CreateThread(function()
    SetPlayerParachuteModelOverride(PlayerId(), `p_parachute1_mp_s`)
    SetPedParachuteTintIndex(playerPed, 6)
    GiveWeaponToPed(playerPed, -72657034, 1, 0, 1)
    TriggerEvent("hud:equipParachute")
  end)
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      Wait(500)
    end
    TriggerEvent("fa-props:removePropByName", "np_wingsuit_b_open")
    wingsuiting = false
  end)
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      if IsControlPressed(0, 8) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 30.0, 2.5, 0.0, 0.0, 0.0, 0, true, false, false, false, true)
      elseif IsControlPressed(0, 32) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 80.0, 75.0, 0.0, 0.0, -75.0, 0, true, false, false, false, true)
      end
      if IsControlPressed(0, 22) and (not usedSuperBoost) then
        usedSuperBoost = true
        Citizen.CreateThread(function()
          superBoostActive = true
          while superBoostActive do
            ApplyForceToEntity(playerPed, 1, 0.0, 200.0, 400.0, 0.0, 0.0, -300.0, 0, true, false, false, false, true)
            Wait(0)
          end
        end)
        Citizen.CreateThread(function()
          Wait(1500)
          superBoostActive = false
        end)
      end
      Wait(0)
    end
  end)
end)

AddEventHandler("fa-inventory:itemUsed", function(pItem, pInfo)
  if pItem ~= "wingsuitc" then return end
  if wingsuiting then return end
  if not pInfo then return end
  local info = json.decode(pInfo)
  local cid = exports["isPed"]:isPed("cid")
  if info.cid ~= cid then return end
  local playerPed = PlayerPedId()
  local veh = GetVehiclePedIsIn(playerPed, false)
  if veh ~= 0 then return end
  if GetEntityHeightAboveGround(playerPed) < 3 then return end
  wingsuiting = true
  usedSuperBoost = false
  Citizen.CreateThread(function()
    Wait(200)
    TriggerEvent("fa-props:attachProp", "np_wingsuit_b_open", 24817, 0.1, -0.15, 0.0, 0.0, 90.0, 0.0, true, true, "np_wingsuit_b_open")
  end)
  Citizen.CreateThread(function()
    SetPlayerParachuteModelOverride(PlayerId(), `p_parachute1_mp_s`)
    SetPedParachuteTintIndex(playerPed, 6)
    GiveWeaponToPed(playerPed, -72657034, 1, 0, 1)
    TriggerEvent("hud:equipParachute")
  end)
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      Wait(500)
    end
    TriggerEvent("fa-props:removePropByName", "np_wingsuit_b_open")
    wingsuiting = false
  end)  
  Citizen.CreateThread(function()
    while not IsPedInParachuteFreeFall(playerPed) do
      Wait(0)
    end
    while (GetEntityHeightAboveGround(playerPed) > 1) and (GetPedParachuteState(PlayerPedId()) < 1) do
      if IsControlPressed(0, 8) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 30.0, 2.5, 0.0, 0.0, 0.0, 0, true, false, false, false, true)
      elseif IsControlPressed(0, 32) and (not superBoostActive) then
        ApplyForceToEntity(playerPed, 1, 0.0, 80.0, 75.0, 0.0, 0.0, -75.0, 0, true, false, false, false, true)
      end
      if IsControlPressed(0, 22) and (not usedSuperBoost) then
        usedSuperBoost = true
        Citizen.CreateThread(function()
          superBoostActive = true
          while superBoostActive do
            ApplyForceToEntity(playerPed, 1, 0.0, 200.0, 400.0, 0.0, 0.0, -300.0, 0, true, false, false, false, true)
            Wait(0)
          end
        end)
        Citizen.CreateThread(function()
          Wait(1500)
          superBoostActive = false
          Wait(10000)
          usedSuperBoost = false
        end)
      end
      Wait(0)
    end
  end)
end)

local isDead = false
AddEventHandler("pd:deathcheck", function()
  isDead = not isDead
  if not isDead then return end
  wingsuiting = false
  usedSuperBoost = false
  TriggerEvent("fa-props:removePropByName", "np_wingsuit_open")
  TriggerEvent("fa-props:removePropByName", "np_wingsuit_b_open")
end)
