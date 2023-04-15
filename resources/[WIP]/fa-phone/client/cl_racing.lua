local racing = false


local currentMap = {}
local customMaps = {}
local dst = 30.0
local creatingMap = false
local SetBlips = {}
local particleList = {}
local currentRaces = {}
local JoinedRaces = {}
local racesStarted = 0
local mylastid = "NA"
local newPendingRace = {}
local creating = false

RegisterNUICallback('racing:event:start', function(data)
  local canJoinOrErr = exports["fa-racing"]:canJoinOrStartRace()
  if canJoinOrErr ~= true then
    phoneNotification("racen",canJoinOrErr,"RACING", 3000)
    return
  end
  print(data.id, json.encode(data))
    exports["fa-racing"]:createPendingRace(data.id, data)
    Wait(100)
    SendNUIMessage({
      openSection = "racing:event:update",
      canJoin = false,
      joinedRace = true
    })
    Wait(200)
    openRacingApp()
end)
-- Fix
RegisterNUICallback("racing:event:join", function(data)
  local canJoinOrErr = exports["fa-racing"]:canJoinOrStartRace()
  local id = data.id
  if canJoinOrErr ~= true then
    phoneNotification("racen",canJoinOrErr,"RACING", 3000)
    return
  end
  if not id then return end

  id = tostring(id)

  local cid = exports["isPed"]:isPed("cid")
  local alias = RPC.execute("GetAlias")
  print(alias)
  if not cid or not alias then
    phoneNotification("racen", "Use your dongle and set your alias.", "RACING")
    return
  end
  
  exports["fa-racing"]:joinRace(id, alias, cid)
  Wait(100)
  SendNUIMessage({
    openSection = "racing:event:update",
    canJoin = false,
    joinedRace = true
  })
  openRacingApp()
end)


RegisterNetEvent("fa-racing:removedActiveRaced")
AddEventHandler("fa-racing:removedActiveRaced", function(id)
  -- print("PUTANG INA")
    openRacingApp()
    -- TriggerEvent("fa-racing:api:updatedState", { activeRaces = activeRaces })
end)


local globalRaces = {}
RegisterNUICallback('racing-app', function(data)
  openRacingApp()
end)

function openRacingApp()
  local alias = RPC.execute("GetAlias")
  print(alias)
  local _races = exports["fa-racing"]:getAllRaces()
  local races = formatRaces(_races)
  local _newRaces = {}
  for k, v in pairs(_races["finishedRaces"]) do
    v["state"] = "close"
    table.insert(_newRaces, v)
  end

  for k, v in pairs(_races["activeRaces"]) do
      v["state"] = "active"
      table.insert(_newRaces, v)
  end

  for k, v in pairs(_races["pendingRaces"]) do
      v["state"] = "open"
      table.insert(_newRaces, v)
  end
  -- print("RACING ALIAS HERE",alias,creating,rank)
  print(json.encode(_newRaces))
  SendNUIMessage({
      openSection = "racing-app",
      races = _races,
      creating = creating,
      raceCreated = _newRaces,
      racingAlias = alias,
      scid = exports["isPed"]:isPed("cid"),
      canMakeMap = true,
  })
end

AddEventHandler("fa-racing:api:updatedState", function()
  -- print("UPDATING STATE RACE")
  if not pPhoneOpen then return end

  local rank = exports["isPed"]:GroupRank("ug_racing")

  local _races = exports["fa-racing"]:getAllRaces()
  local _newRaces = {}
  for k, v in pairs(_races["finishedRaces"]) do
    v["state"] = "close"
    table.insert(_newRaces, v)
  end

  for k, v in pairs(_races["activeRaces"]) do
      v["state"] = "active"
      table.insert(_newRaces, v)
  end

  for k, v in pairs(_races["pendingRaces"]) do
      v["state"] = "open"
      table.insert(_newRaces, v)
  end

  SendNUIMessage({
      openSection = "racing:event:update",
      raceCreated = _newRaces,
      scid = exports["isPed"]:isPed("cid"),
      canMakeMap = (rank >= 1)
  })
end)

function formatRaces(races)
  local _races = {}
  for k, v in pairs(races["finishedRaces"]) do
      v["state"] = "close"
      table.insert(_races, v)
  end

  for k, v in pairs(races["activeRaces"]) do
      v["state"] = "active"
      table.insert(_races, v)
  end

  for k, v in pairs(races["pendingRaces"]) do
      v["state"] = "open"
      table.insert(_races, v)
  end

  return _races
end

function Round(num, dp)
  --[[
  round a number to so-many decimal of places, which can be negative, 
  e.g. -1 places rounds to 10's,  
  
  examples
      173.2562 rounded to 0 dps is 173.0
      173.2562 rounded to 2 dps is 173.26
      173.2562 rounded to -1 dps is 170.0
  ]]--
  local mult = 10^(dp or 0)
  return math.floor(num * mult + 0.5)/mult
end

-- Fix this

RegisterNUICallback('racing:event:start', function()
  exports["fa-racing"]:startRace()
end)

RegisterNUICallback("racing:event:end", function()
  exports["fa-racing"]:endRace()
end)

RegisterNUICallback("racing:event:leave", function()
  exports["fa-racing"]:leaveRace()
end)


RegisterNUICallback("racing:map:save", function(data)
  if creating then
      TriggerEvent("fa-racing:cmd:racecreatedone")
      creating = false
  else
      local ped = PlayerPedId()
      local veh = GetVehiclePedIsIn(PlayerPedId(), false)

      if veh ~= 0 and GetPedInVehicleSeat(veh, -1) == ped then
          local options = {
              raceName = data.name,
              raceType = data.type,
              raceThumbnail = "none",
          }
          TriggerEvent("fa-racing:cmd:racecreate", options)
          closeGui()
          creating = true
      else
          TriggerEvent("You are not driving a vehicle", 2)
      end
  end
end)

RegisterNUICallback('racing:map:cancel', function()
  creating = false
  TriggerEvent('fa-racing:cmd:racecreatecancel')
  openRacingApp()
end)


RegisterNetEvent('racing:addPending')
AddEventHandler('racing:addPending', function(data)
  print("SENDING TO ALL?")
  newPendingRace[data.eventId] = data.data
end)

RegisterNetEvent('racing:clearFinishedRaces')
AddEventHandler('racing:clearFinishedRaces', function(id)
  if(JoinedRaces[id] ~= nil) then
    JoinedRaces[id] = nil
    ClearBlips()
    RemoveCheckpoints()
  end
end)

RegisterNUICallback('fa-phone:racing:setGPS', function(data)
  local mapID = data.mID
  exports["fa-racing"]:locateRace(mapID)
  phoneNotification("racen","GPS Set to your map.","RACING")
end)

RegisterNUICallback('fa-phone:racing:seePreview', function(data)
  local mapID = data.mID
  if not mapID then return end
  id = tostring(mapID)
  exports["fa-racing"]:previewRace(mapID)
  phoneNotification("racen","Preview Set to your map.","RACING")
end)


local setGpsTrack = false
local setGPSVectpr = {}
local currentblip = 0
function setGPS(name,x,y,z)
  currentblip = AddBlipForCoord(x,y,z)
  SetBlipAsFriendly(currentblip, true)
  SetBlipSprite(currentblip, 315)
  setGpsTrack = true
  BeginTextCommandSetBlipName("STRING");
  setGPSVectpr = {x,y,z}
  -- AddTextComponentString(tostring("Checkpoint " .. key))
  EndTextCommandSetBlipName(name)
  Wait(60000)
  if DoesBlipExist(currentblip) then
    RemoveBlip(currentblip)
  end
end

Citizen.CreateThread(function()
  local gpsTime = 5000
  while true do
    if setGpsTrack then
      gpsTime = 100
      local distance = #(GetEntityCoords(PlayerPedId()) - vector3(setGPSVectpr[1],setGPSVectpr[2],setGPSVectpr[3]))
      if(distance < 30.0) then
        Wait(1000)
        setGpsTrack = false
        gpsTime = 10000
        if DoesBlipExist(currentblip) then
          RemoveBlip(currentblip)
        end
      end
    end
    Wait(gpsTime)
  end
end)

RegisterNUICallback('fa-phone:r-users', function(data, cb)
  local raceID = data.raceID
  -- print("GETTING RACER",raceID,newPendingRace[raceID],json.encode(newPendingRace[raceID]))
  local race = newPendingRace[raceID]
  if race ~= nil then
    print("RACERS",json.encode(race.racers))
    local racer = RPC.execute('fa-phone:racing:getRacer', raceID)
    cb(racer)
  end
  print(json.encode(newPendingRace[raceID]))
end)

AddEventHandler("fa-racing:api:startingRace", function(startTime)
  TriggerEvent("DoLongHudText", "Starting race in " .. tostring(startTime / 1000) .. " seconds")
end)

AddEventHandler("fa-racing:api:playerJoinedYourRace", function(characterId, name)
  TriggerEvent("chatMessage", "", {255, 0, 0}, "^1" .. name .. " joined your race")
end)

AddEventHandler("fa-racing:api:playerLeftYourRace", function(characterId, name)
  TriggerEvent("chatMessage", "", {255, 0, 0}, "^1" .. name .. " left your race")
end)

RegisterNetEvent('fa-racing:pendingRacenotif')
AddEventHandler("fa-racing:pendingRacenotif", function(race)
  -- if not race.sendNotification then return end

  local racingUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb2")
  local usbMetadata = has_usb_racing and json.decode(racingUsbItem.information) or {}
  local isAlias = json.decode(racingUsbItem.information)
  local has_usb_racing = racingUsbItem ~= nil and racingUsbItem.quality > 0
  local racingAlias = has_usb_racing and isAlias.Alias or nil
  -- print("GETTTING NOTIFICATION FOR RACE?",has_usb_racing,racingAlias)
  if not has_usb_racing or not isAlias.Alias then return end

  exports["fa-phone"]:phoneNotification("racen","Pending race available...","From the PM", 12000)
end)
-- Citizen.CreateThread(function()
--   while true do
--     Wait(5000)
--     print('JoinedRaces',JoinedRaces,json.encode(JoinedRaces))
--     print("WTF",json.encode(newPendingRace))
--     print("WTF",json.encode(currentRaces))
--   end
-- end)

