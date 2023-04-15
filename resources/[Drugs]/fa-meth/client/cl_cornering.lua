local inCorner = false
local inCornerId = nil
local menuSellButtonActive = false
local currentTarget = nil
local playerCornering = false
local lastCornerSale

local function randomizeBlipLocation(pOrigin)
  local x = pOrigin.x
  local y = pOrigin.y
  local z = pOrigin.z
  local luck = math.random(2)
  y = math.random(35) + y
  if luck == 1 then
      x = math.random(35) + x
  end
  return {x = x, y = y, z = z}
end

local function uuid()
  math.randomseed(GetCloudTimeAsInt())
  local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function (c)
      local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
      return string.format('%x', v)
  end)
end
function GetStreetAndZone()
  local plyPos = GetEntityCoords(PlayerPedId(), true)
  local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
  local street1 = GetStreetNameFromHashKey(s1)
  local street2 = GetStreetNameFromHashKey(s2)
  local zone = GetLabelText(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
  local street = street1 .. ", " .. zone
  return street
end

AddEventHandler("meth:drugsale", function()
  Citizen.CreateThread(function()
    Citizen.Wait(math.random(10000, 20000))
    local street1 = GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    local gender = IsPedMale(PlayerPedId())
    local dispatchCode = "10-37"
    local eventId = uuid()
  
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = dispatchCode,
      firstStreet = street1,
      gender = gender,
      eventId = eventId,
      blipArea = 20,
      origin = randomizeBlipLocation(plyPos),
    })
  end)
end)

AddEventHandler("fa-meth:cornerSellProduct", function(pArgs, pEntity)
    local gameTimer = GetGameTimer()

    if lastCornerSale and (gameTimer - lastCornerSale) <= 4000 then
        return TriggerEvent('fa-meth:cleanAttempt', lastCornerSale - gameTimer)
    end

    lastCornerSale = gameTimer

    if not exports["fa-inventory"]:hasEnoughOfItem("methlabproduct", 1, false, true) then
        TriggerEvent("DoLongHudText", "No product...", 2)
        return
    end
    function loadAnimDict(dict)
        while ( not HasAnimDictLoaded(dict) ) do
            RequestAnimDict(dict)
            Citizen.Wait(0)
        end
    end
    loadAnimDict('anim@narcotics@trash')
    TaskPlayAnim(PlayerPedId(), 'anim@narcotics@trash', 'drop_front',0.9, -8, 1500, 49, 3.0, 0, 0, 0)
    local success = RPC.execute("fa-meth:attemptCornerSale", NetworkGetNetworkIdFromEntity(pEntity), inCornerId)
    if success then
        TriggerEvent("money:clean")
        TriggerServerEvent("fa-heists:generateSafeCrackingTool")
    end
    if success and math.random() < 0.1 then
        TriggerEvent("meth:drugsale")
    end
end)

AddEventHandler("fa-meth:cornerStartSelling", function()
    local result = RPC.execute("fa-meth:startCornering", inCornerId)
    if not result then return end
    TriggerEvent("fa-meth:showSellDrugsMenuItem", "cancorner", false)
    playerCornering = true
end)

AddEventHandler("fa-polyzone:enter", function(name, data)
    if name ~= "meth_corner" then return end
    if not exports["fa-inventory"]:hasEnoughOfItem("methlabproduct", 1, false) then return end
    inCorner = true
    inCornerId = 1
    -- inCornerId = data.id
    TriggerEvent("DoLongHudText", "Looks like a good spot to sell...")
    TriggerEvent("fa-meth:showSellDrugsMenuItem", "cancorner", true)
end)
AddEventHandler("fa-polyzone:exit", function(name, data)
    if name ~= "meth_corner" then return end
    if not inCorner then return end
    if playerCornering then
        RPC.execute("fa-meth:stopCornering")
        TriggerEvent("DoLongHudText", "No longer selling...", 2)
    end
    inCorner = false
    inCornerId = nil
    TriggerEvent("fa-meth:showSellDrugsMenuItem", "cancorner", false)
end)

local IgnoredClasses = {
  [10] = true,
  [11] = true,
  [14] = true,
  [15] = true,
  [16] = true,
  [17] = true,
  [18] = true,
  [19] = true,
  [20] = true,
  [21] = true,
}

function IsValidCandidate(pVehicle)
  local vehicleClass = GetVehicleClass(pVehicle)
  return not IgnoredClasses[vehicleClass]
end

local usedNetIds = {}

RegisterNetEvent("fa-meth:findCandidateVehicle")
AddEventHandler("fa-meth:findCandidateVehicle", function(pCornerId, pSrc)
  PopulateNow()
  Wait(0)
  local vehicles = GetGamePool('CVehicle')

  local cornerVehicle, cornerPed

  for _, vehicle in ipairs(vehicles) do
      if IsValidCandidate(vehicle) then
          local ped = GetPedInVehicleSeat(vehicle, -1)

          if DoesEntityExist(ped) and
            not IsPedAPlayer(ped)
            and not IsPedDeadOrDying(ped)
            and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) < 210
          then
              cornerVehicle = NetworkGetNetworkIdFromEntity(vehicle)
              if not usedNetIds[cornerVehicle] then
                usedNetIds[cornerVehicle] = true
                cornerPed = NetworkGetNetworkIdFromEntity(ped)

                SetEntityAsMissionEntity(vehicle, true, true)
                SetEntityAsMissionEntity(ped, true, true)
                break
              end
          end
      end
  end

  TriggerServerEvent("fa-meth:corneringFoundVehicle", pCornerId, pSrc, { vehicle = cornerVehicle, driver = cornerPed })
end)

RegisterNetEvent('fa-meth:findCandidate', function()
  PopulateNow()
  Wait(0)
  local vehicles = GetGamePool('CVehicle')

  local cornerVehicle, cornerPed

  for _, vehicle in ipairs(vehicles) do
      if IsValidCandidate(vehicle) then
          local ped = GetPedInVehicleSeat(vehicle, -1)

          if DoesEntityExist(ped) and
            not IsPedAPlayer(ped)
            and not IsPedDeadOrDying(ped)
            and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) < 210
          then
              cornerVehicle = NetworkGetNetworkIdFromEntity(vehicle)
              if not usedNetIds[cornerVehicle] then
                usedNetIds[cornerVehicle] = true
                cornerPed = NetworkGetNetworkIdFromEntity(ped)

                SetEntityAsMissionEntity(vehicle, true, true)
                SetEntityAsMissionEntity(ped, true, true)
                break
              end
          end
      end
  end

  return { vehicle = cornerVehicle, driver = cornerPed }
end)
