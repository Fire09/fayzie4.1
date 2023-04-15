
--boostin plate system to no bug yeye

--bosting plate system
--BLIPS SYSTEM INFINITY 

local pVeh = nil

local colors = {
  ['0'] = "Metallic Black",
  ['1'] = "Metallic Graphite Black",
  ['2'] = "Metallic Black Steal",
  ['3'] = "Metallic Dark Silver",
  ['4'] = "Metallic Silver",
  ['5'] = "Metallic Blue Silver",
  ['6'] = "Metallic Steel Gray",
  ['7'] = "Metallic Shadow Silver",
  ['8'] = "Metallic Stone Silver",
  ['9'] = "Metallic Midnight Silver",
  ['10'] = "Metallic Gun Metal",
  ['11'] = "Metallic Anthracite Grey",
  ['12'] = "Matte Black",
  ['13'] = "Matte Gray",
  ['14'] = "Matte Light Grey",
  ['15'] = "Util Black",
  ['16'] = "Util Black Poly",
  ['17'] = "Util Dark silver",
  ['18'] = "Util Silver",
  ['19'] = "Util Gun Metal",
  ['20'] = "Util Shadow Silver",
  ['21'] = "Worn Black",
  ['22'] = "Worn Graphite",
  ['23'] = "Worn Silver Grey",
  ['24'] = "Worn Silver",
  ['25'] = "Worn Blue Silver",
  ['26'] = "Worn Shadow Silver",
  ['27'] = "Metallic Red",
  ['28'] = "Metallic Torino Red",
  ['29'] = "Metallic Formula Red",
  ['30'] = "Metallic Blaze Red",
  ['31'] = "Metallic Graceful Red",
  ['32'] = "Metallic Garnet Red",
  ['33'] = "Metallic Desert Red",
  ['34'] = "Metallic Cabernet Red",
  ['35'] = "Metallic Candy Red",
  ['36'] = "Metallic Sunrise Orange",
  ['37'] = "Metallic Classic Gold",
  ['38'] = "Metallic Orange",
  ['39'] = "Matte Red",
  ['40'] = "Matte Dark Red",
  ['41'] = "Matte Orange",
  ['42'] = "Matte Yellow",
  ['43'] = "Util Red",
  ['44'] = "Util Bright Red",
  ['45'] = "Util Garnet Red",
  ['46'] = "Worn Red",
  ['47'] = "Worn Golden Red",
  ['48'] = "Worn Dark Red",
  ['49'] = "Metallic Dark Green",
  ['50'] = "Metallic Racing Green",
  ['51'] = "Metallic Sea Green",
  ['52'] = "Metallic Olive Green",
  ['53'] = "Metallic Green",
  ['54'] = "Metallic Gasoline Blue Green",
  ['55'] = "Matte Lime Green",
  ['56'] = "Util Dark Green",
  ['57'] = "Util Green",
  ['58'] = "Worn Dark Green",
  ['59'] = "Worn Green",
  ['60'] = "Worn Sea Wash",
  ['61'] = "Metallic Midnight Blue",
  ['62'] = "Metallic Dark Blue",
  ['63'] = "Metallic Saxony Blue",
  ['64'] = "Metallic Blue",
  ['65'] = "Metallic Mariner Blue",
  ['66'] = "Metallic Harbor Blue",
  ['67'] = "Metallic Diamond Blue",
  ['68'] = "Metallic Surf Blue",
  ['69'] = "Metallic Nautical Blue",
  ['70'] = "Metallic Bright Blue",
  ['71'] = "Metallic Purple Blue",
  ['72'] = "Metallic Spinnaker Blue",
  ['73'] = "Metallic Ultra Blue",
  ['74'] = "Metallic Bright Blue",
  ['75'] = "Util Dark Blue",
  ['76'] = "Util Midnight Blue",
  ['77'] = "Util Blue",
  ['78'] = "Util Sea Foam Blue",
  ['79'] = "Uil Lightning blue",
  ['80'] = "Util Maui Blue Poly",
  ['81'] = "Util Bright Blue",
  ['82'] = "Matte Dark Blue",
  ['83'] = "Matte Blue",
  ['84'] = "Matte Midnight Blue",
  ['85'] = "Worn Dark blue",
  ['86'] = "Worn Blue",
  ['87'] = "Worn Light blue",
  ['88'] = "Metallic Taxi Yellow",
  ['89'] = "Metallic Race Yellow",
  ['90'] = "Metallic Bronze",
  ['91'] = "Metallic Yellow Bird",
  ['92'] = "Metallic Lime",
  ['93'] = "Metallic Champagne",
  ['94'] = "Metallic Pueblo Beige",
  ['95'] = "Metallic Dark Ivory",
  ['96'] = "Metallic Choco Brown",
  ['97'] = "Metallic Golden Brown",
  ['98'] = "Metallic Light Brown",
  ['99'] = "Metallic Straw Beige",
  ['100'] = "Metallic Moss Brown",
  ['101'] = "Metallic Biston Brown",
  ['102'] = "Metallic Beechwood",
  ['103'] = "Metallic Dark Beechwood",
  ['104'] = "Metallic Choco Orange",
  ['105'] = "Metallic Beach Sand",
  ['106'] = "Metallic Sun Bleeched Sand",
  ['107'] = "Metallic Cream",
  ['108'] = "Util Brown",
  ['109'] = "Util Medium Brown",
  ['110'] = "Util Light Brown",
  ['111'] = "Metallic White",
  ['112'] = "Metallic Frost White",
  ['113'] = "Worn Honey Beige",
  ['114'] = "Worn Brown",
  ['115'] = "Worn Dark Brown",
  ['116'] = "Worn straw beige",
  ['117'] = "Brushed Steel",
  ['118'] = "Brushed Black steel",
  ['119'] = "Brushed Aluminium",
  ['120'] = "Chrome",
  ['121'] = "Worn Off White",
  ['122'] = "Util Off White",
  ['123'] = "Worn Orange",
  ['124'] = "Worn Light Orange",
  ['125'] = "Metallic Securicor Green",
  ['126'] = "Worn Taxi Yellow",
  ['127'] = "police car blue",
  ['128'] = "Matte Green",
  ['129'] = "Matte Brown",
  ['130'] = "Worn Orange",
  ['131'] = "Matte White",
  ['132'] = "Worn White",
  ['133'] = "Worn Olive Army Green",
  ['134'] = "Pure White",
  ['135'] = "Hot Pink",
  ['136'] = "Salmon pink",
  ['137'] = "Metallic Vermillion Pink",
  ['138'] = "Orange",
  ['139'] = "Green",
  ['140'] = "Blue",
  ['141'] = "Mettalic Black Blue",
  ['142'] = "Metallic Black Purple",
  ['143'] = "Metallic Black Red",
  ['144'] = "hunter green",
  ['145'] = "Metallic Purple",
  ['146'] = "Metaillic V Dark Blue",
  ['147'] = "MODSHOP BLACK1",
  ['148'] = "Matte Purple",
  ['149'] = "Matte Dark Purple",
  ['150'] = "Metallic Lava Red",
  ['151'] = "Matte Forest Green",
  ['152'] = "Matte Olive Drab",
  ['153'] = "Matte Desert Brown",
  ['154'] = "Matte Desert Tan",
  ['155'] = "Matte Foilage Green",
  ['156'] = "DEFAULT ALLOY COLOR",
  ['157'] = "Epsilon Blue",
}

BoostingClientBlips = {
  ActivePlayers = {}, 
  distant = {},
}

function BoostingClientBlips:UpdateBlips(playerID, x, y, z)
  local player = nil

  player = GetPlayerFromServerId(playerID)
  if IsPoliceAllowed() then
    if BoostingClientBlips.ActivePlayers[playerID] == nil then
        BoostingClientBlips.ActivePlayers[playerID] = AddBlipForCoord(x, y, z)
        SetBlipScale(BoostingClientBlips.ActivePlayers[playerID], 1.2)
        SetBlipSprite(BoostingClientBlips.ActivePlayers[playerID], 225)
        SetBlipColour(BoostingClientBlips.ActivePlayers[playerID], 1)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('[Boosting] - Stolen Vehicle')
        EndTextCommandSetBlipName(BoostingClientBlips.ActivePlayers[playerID])
    elseif BoostingClientBlips.ActivePlayers[playerID] and x ~= 0.0  then
        SetBlipCoords(BoostingClientBlips.ActivePlayers[playerID], x, y, z)
    end
  end
end

function BoostingClientBlips:remove(playerID)
  if BoostingClientBlips.ActivePlayers[playerID] then
      RemoveBlip(BoostingClientBlips.ActivePlayers[playerID])
      BoostingClientBlips.ActivePlayers[playerID] = nil
  end
end

function BoostingClientBlips:Update(info)
  for k, v in pairs(info) do
      BoostingClientBlips.UpdateBlips(k, k, v.coords.x, v.coords.y, v.coords.z)
  end
end

RegisterNetEvent('boosting:RemoveBlip')
AddEventHandler('boosting:RemoveBlip',function(playerID)
  BoostingClientBlips:remove(playerID)
end)

--BLIPS SYSTEM INFINITY 

local tabletObject, isInTablet, VehicleStoled = nil, false, nil
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local anim = "machinic_loop_mechandplayer"
local flags = 49
local Circle
local placa
local DropZoneBlip
local itemBlip
local IdToRemove
local IsInQueue = false
local isVin = false
local CanChangePlate = false
local AlredyVinScratch = false
local IsAllOk = false
local isPoliceBlip = false
local AlredyContract = false
local gne = 0
local login = false
local pendingDelivery = false
local cooldown = false
local ACTIVE_EMERGENCY_PERSONNEL = {}
local hacks = {
  number1 = false,
  number2 = false,
  number3 = false,
  number4 = false,
  number5 = false,
  number6 = false,
  number7 = false,
  number8 = false,
  number9 = false,
  number10 = false,
}
Contracts = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------FUNCTIONS------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HackingStage(number)
  if number == 1 then
    hacks.number1 = true
  elseif number == 2 then
    hacks.number1 = true
    hacks.number2 = true
  elseif number == 3 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
  elseif number == 4 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
  elseif number == 5 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
  elseif number == 6 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
    hacks.number6 = true
  elseif number == 7 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
    hacks.number6 = true
    hacks.number7 = true
  elseif number == 8 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
    hacks.number6 = true
    hacks.number7 = true
    hacks.number8 = true
  elseif number == 9 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
    hacks.number6 = true
    hacks.number7 = true
    hacks.number8 = true
    hacks.number9 = true
  elseif number == 10 then
    hacks.number1 = true
    hacks.number2 = true
    hacks.number3 = true
    hacks.number4 = true
    hacks.number5 = true
    hacks.number6 = true
    hacks.number7 = true
    hacks.number8 = true
    hacks.number9 = true
    hacks.number10 = true
  end
end

RegisterNetEvent('boosting:updateBlips')
AddEventHandler('boosting:updateBlips',function(info)
  if GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())) == placa then
    BoostingClientBlips:Update(info)
  end
end)

function getVehicleInDirection(coordFrom, coordTo)
  local offset = 0
  local rayHandle
  local vehicle

  for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1

      if vehicle ~= 0 then break end
  end
  
  local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
  
  if distance > 25 then vehicle = nil end

  return vehicle ~= nil and vehicle or 0
end

function HackingIsCompleted()
  if hacks.number1 == false and hacks.number2 == false and hacks.number3 == false and hacks.number4 == false and hacks.number5 == false and hacks.number6 == false and hacks.number7 == false and hacks.number8 == false and hacks.number9 == false and hacks.number10 == false then
    return true
  else
    return false
  end
end 

function FinishPolice() 
  if isVin then
    TriggerEvent("fa-hud:boosting_value", 0)
    sendAppEvent('BoostingNotification', {notify = {msg = "Go to the marked place and scratch the vin.", time = "3/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
    TriggerEvent('DoLongHudText', 'Go to the marked place and scratch the vin', 1)
    isPoliceBlip = false
    RemoveCopBlip()
    TriggerServerEvent("boosting:SendRemovePoliceBlip", VehicleStoled)
  else
    isPoliceBlip = false
    RemoveCopBlip()
    TriggerServerEvent("boosting:SendRemovePoliceBlip", VehicleStoled)
  end
end

function DoHackingStagesCOP()
  if hacks.number1 == true then
    hacks.number1 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 1', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 2)
    end
  elseif hacks.number2 == true then
    hacks.number2 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 2', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 3)
    end
  elseif hacks.number3 == true then
    hacks.number3 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 3', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 4)
    end
  elseif hacks.number4 == true then
    hacks.number4 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 4', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 5)
    end
  elseif hacks.number5 == true then
    hacks.number5 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 5', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 6)
    end
  elseif hacks.number6 == true then
    hacks.number6 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 6', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 7)
    end
  elseif hacks.number7 == true then
    hacks.number7 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 7', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 8)
    end
  elseif hacks.number8 == true then
    hacks.number8 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 8', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 9)
    end
  elseif hacks.number9 == true then
    hacks.number9 = false
    TriggerEvent('DoLongHudText', 'You finish hack number: 9', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 10)
    end
  elseif hacks.number10 == true then
    hacks.number10 = false
    TriggerEvent('DoLongHudText', 'You finish the final hack!', 1)
    if HackingIsCompleted() then
      FinishPolice() 
      TriggerEvent("fa-hud:boosting_value", 0)
    end
  end
  return true
end

function DoHackingStages()
  if hacks.number1 == true then
    if CustomMinigameHack() then
      hacks.number1 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number2 == true then
    if CustomMinigameHack() then
      hacks.number2 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number3 == true then
    if CustomMinigameHack() then
      hacks.number3 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number4 == true then
    if CustomMinigameHack() then
      hacks.number4 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number5 == true then
    if CustomMinigameHack() then
      hacks.number5 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number6 == true then
    if CustomMinigameHack() then
      hacks.number6 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number7 == true then
    if CustomMinigameHack() then
      hacks.number7 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number8 == true then
    if CustomMinigameHack() then
      hacks.number8 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number9 == true then
    if CustomMinigameHack() then
      hacks.number9 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  elseif hacks.number10 == true then
    if CustomMinigameHack() then
      hacks.number10 = false
      TriggerEvent('DoLongHudText', 'Hack Success!', 1)
      TriggerEvent('boosting:addcooldownHack')
      return true
    else
        TriggerEvent('DoLongHudText', 'Hack Failed!', 2)
      TriggerEvent('boosting:addcooldownHack')
      return false
    end
  end
  return true
end

function NumberOfContractsByLevel(level)
  if level == "D" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.D..'x', 1)
    return Config.NumberOfHacks.D
  elseif level == "C" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.C..'x', 1)
    return Config.NumberOfHacks.C
  elseif level == "B" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.B..'x', 1)
    return Config.NumberOfHacks.B
  elseif level == "A" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.A..'x', 1)
    return Config.NumberOfHacks.A
  elseif level == "S" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.S..'x', 1)
    return Config.NumberOfHacks.S
  elseif level == "S+" then
    TriggerEvent('DoLongHudText', 'You will have to hack the vehicle '..Config.NumberOfHacks.SPLUS..'x', 1)
    return Config.NumberOfHacks.SPLUS
  end
end

function randomChange(percent)
  local re = percent >= math.random(1, 100)  
  return re
end

function CreateBlip(v)
    Circle = Citizen.InvokeNative(0x46818D79B1F7499A,v.x + math.random(0.0,150.0), v.y + math.random(0.0,80.0), v.z + math.random(0.0,5.0) , 300.0) -- you can use a higher number for a bigger zone
    SetBlipHighDetail(Circle, true)
    SetBlipColour(Circle, 18)
    SetBlipAlpha (Circle, 128)
end

function DeleteCircle()
    if DoesBlipExist(Circle) then
        RemoveBlip(Circle)
    end
end

function DeleteBlip()
	if DoesBlipExist(Circle) then
		RemoveBlip(Circle)
	end
end

function addBlip(coords, sprite, colour, text)
  local blip = AddBlipForCoord(coords)
  SetBlipSprite(blip, sprite)
  SetBlipColour(blip, colour)
  SetBlipScale(blip, 1.0)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
  return blip
end

function RemoveCopBlip()
  TriggerServerEvent("boosting:SendRemovePoliceBlip")
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function CreateVeh(model , coord, id)
  pVeh = tostring(model)
  local Hash = tostring(model)
  if not IsModelInCdimage(Hash) then return end
  RequestModel(Hash)
  while not HasModelLoaded(Hash) do
      Citizen.Wait(10)
  end

  veh = CreateVehicle(Hash, coord.x, coord.y , coord.z, 0.0, true, false)
  SetModelAsNoLongerNeeded(Hash) 
  SetVehicleEngineOn(veh, false, false)
  SetVehicleDoorsLocked(veh, 2)

  return veh, GetVehicleNumberPlateText(veh)
end

function doTablet()
  local playerPed = PlayerPedId()
  local dict = "amb@world_human_seat_wall_tablet@female@base"
  RequestAnimDict(dict)
  if tabletObject == nil then
    tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
    AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
  end
  while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
  if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
    TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
  end
end

function DoTimer(pisInTablet)
  isInTablet = pisInTablet
  if not isInTablet then
      return
  end
  Citizen.CreateThread( function()
    while isInTablet do
      Citizen.Wait(100)
      local year = GetClockYear()
      local month = GetClockMonth()
      local day = GetClockDayOfMonth()
      local hour = GetClockHours()
      local minute = GetClockMinutes()
      if hour < 9 then
        hour = '0'..hour
      end
      if minute < 9 then
        minute = '0'..minute
      end
      local time = ''..hour..':'..minute..' '..day..'/'..month..'/'..year..''
      sendAppEvent('BoostingApp', {
        time = time
      })
    end
  end)
end

function getClock()
  local hour = GetClockHours()
  local minute = GetClockMinutes()
  if hour < 9 then
    hour = '0'..hour
  end
  if minute < 9 then
    minute = '0'..minute
  end
  
  return hour..":"..minute
end

local min = 60000

Citizen.CreateThread(function()
  while true do
    if IsInQueue then
      Citizen.Wait(math.random(Config.QueueTimeMin*min, Config.QueueTimeMax*min))
      if IsInQueue then
        if not AlredyContract then
          TriggerServerEvent("boosting:CreateContract", getClock())
        end
      end
    end
    Citizen.Wait(1000)
  end
end)

local notEmailed = false

function MakeDropZoneThread(IsInWay)
  local setCoords = Config.DropZones[math.random(1, Config.NumberDropZones)].coords
  dropZoneblip = addBlip(setCoords, 225, 2, "Dropzone")
  Citizen.CreateThread(function()
    while IsInWay do
      Citizen.Wait(1000)
      local plped = PlayerPedId()
      local coordA = GetEntityCoords(plped)
      local veh = GetVehiclePedIsIn(plped)
      if(veh ~= 0) then
        if(GetVehicleNumberPlateText(veh) == placa) then
          local aDist = GetDistanceBetweenCoords(setCoords, coordA)
          if aDist < 10.0 and HackingIsCompleted() then
            if not notEmailed then
              notEmailed = true
              TriggerEvent('phone:addnotification', 'Anonymous', 'Leave the vehicle and get out of the area.')
            end
            sendAppEvent('SetDisableButtons', {enableButtons = false})
            sendAppEvent("RemoveContractInfo", {IdToRemove = IdToRemove})
            TriggerServerEvent("boosting:completeNormalContract", IdToRemove)
            IdToRemove = nil
            AlredyContract = false
            TriggerServerEvent("boosting:IsInContract", false)
            Citizen.CreateThread(function()
                while notEmailed do
                  Wait(150)
                  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), setCoords) >= 100.0 then
                    DeleteEntity(veh)
                    RemoveBlip(dropZoneblip)
                    TriggerEvent('phone:addnotification', 'Anonymous', 'Boost Complete, thankyou hopefully I will see you again.')
                    TriggerServerEvent('fa-boosting:pay_gne')
                    notEmailed = false
                  end
                end
              end)
            break
          end
        end
      end
    end
  end)
end

function TrimValue(val)
  if not val then return nil end
  return (string.gsub(val, '^%s*(.-)%s*$', '%1'))
end




function MakeDropZoneThreadVin(IsInWay)
  local setCoords = Config.VinDropZones[math.random(1, Config.NumberVinDropZones)].coords
  dropZoneblip = addBlip(setCoords, 225, 2, "Vin Scratch")
  Citizen.CreateThread(function()
    while IsInWay do
      Citizen.Wait(1000)
      local plped = PlayerPedId()
      local coordA = GetEntityCoords(plped)
      local veh = GetVehiclePedIsIn(plped)
        if(veh ~= 0) then
          if(GetVehicleNumberPlateText(veh) == placa) then
            if HackingIsCompleted() and not recentlyScratched then
              local aDist = GetDistanceBetweenCoords(setCoords, coordA)
              if aDist < 10.0 then
                CanScratchVehicle = true
              else
                CanScratchVehicle = false
              end 
            end
          end
        end
      end
  end)
end

function DropItemZone(data, pay)
  local setCoords = Config.DropBennysZones[math.random(1, Config.NumberDropBennysZones)].coords
  itemBlip = addBlip(setCoords, 440, 5, "Bennys Drop")
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
      pendingDelivery = true
      local plped = PlayerPedId()
      local coordA = GetEntityCoords(plped)
      local aDist = GetDistanceBetweenCoords(setCoords, coordA)
      if aDist < 5.0 then
        TriggerServerEvent("boosting:bennysitem", data, pay)
        RemoveBlip(itemBlip)
        pendingDelivery = false
        break
      end
    end
  end)
end

function generateStringNumber(format) 
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i=1,#format do
    local char = string.sub(format, i,i)
    if char == "D" then number = number..string.char(zbyte+math.random(0,9))
    elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
    else number = number..char end
  end

  return number
end

function filterLevel(number)
  local boomer = tonumber(number)
  if boomer >= 0 and boomer <= 100 then
    return boomer, 'D', 'C'
  elseif boomer >= 100 and boomer <= 200 then
    return boomer -100, 'C', 'B'
  elseif boomer >= 200 and boomer <= 300 then
    return boomer -200, 'B', 'A'
  elseif boomer >= 200 and boomer <= 400 then
    return boomer -300, 'A', 'S'
  elseif boomer >= 200 and boomer <= 500 then
    return boomer -400, 'S', 'S+'
  else 
    return 100, 'S', 'S+'
  end
end



function getNearestPlayer(radius)
  local p = nil
  local players = GetNearestSource(radius)
  local min = radius+10.0
  for k,v in pairs(players) do
    if v < min then
      min = v
      p = k
    end
  end
  return p
end

function GetNearestSource(radius) 
  local r = {}

  local ped = PlayerPedId()
  local pid = PlayerId()
  local px,py,pz = table.unpack(GetEntityCoords(ped))

  for k in pairs(GetActivePlayers()) do
    local player = GetPlayerFromServerId(k)

    if player ~= pid and NetworkIsPlayerConnected(player) then
      local oped = GetPlayerPed(player)
      local x,y,z = table.unpack(GetEntityCoords(oped,true))
      local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
      if distance <= radius then
        r[GetPlayerServerId(player)] = distance
      end
    end
  end

  return r
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------HANDLERS-------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("boosting:qbSpawn")
AddEventHandler("boosting:qbSpawn", function(gne)
  login = true
  sendAppEvent('UpdateGnes', {gne = gne})
  sendAppEvent('SetConsumableItems', {ConsumableItems = Config.ConsumableItems, enable = Config.ConsumableItemsEnable})
  sendAppEvent('SetPerformanceObject', {PerformanceObject = Config.PerformanceObject, enable = Config.PerformanceObjectEnable})
  sendAppEvent('SetCosmeticObject', {CosmeticObject = Config.CosmeticObject, enable = Config.CosmeticObjectEnable})
  sendAppEvent('SetExtraVin', {ExtraVin = Config.ExtraVinGne})
  sendAppEvent('EnableApps', {BennysApp = Config.BennysApp, BuyApp = Config.BuyApp})
end)

RegisterNetEvent("boosting:CreateContractFromServer")
AddEventHandler("boosting:CreateContractFromServer", function(contract, extra)
  sendAppEvent('ContractsBoosting', {contracts = contract})
  sendAppEvent('BoostingNotification', {notify = extra})
end)

RegisterNetEvent("boosting:CreateContractFromServer2")
AddEventHandler("boosting:CreateContractFromServer2", function(contract, extra)
  sendAppEvent('ContractsBoosting', {contracts = contract})
end)

RegisterNetEvent("boosting:updateTime")
AddEventHandler("boosting:updateTime", function(id, time)
  sendAppEvent('UpdateTime', {id = id, expires = time})
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60*1000)
    TriggerServerEvent("update:boostings")
  end
end)

RegisterNetEvent("boosting:setlevel")
AddEventHandler("boosting:setlevel", function(level, newgne)
  local level, type1, type2 = filterLevel(level)
  gne = tonumber(newgne)
  sendAppEvent('SetBoostingLevel', {level = level, type1 = type1, type2 = type2, gne = gne})
end)

RegisterNetEvent("lockpick:event")
AddEventHandler("lockpick:event", function()
  local Player = PlayerPedId()
  local pos = GetEntityCoords(Player)
  local entityWorld = GetOffsetFromEntityInWorldCoords(Player, 0.0, 20.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, Player, 0)
  local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
  playerped = PlayerPedId()
  targetVehicle = GetVehiclePedIsUsing(playerped)
  print(targetVehicle)
  if targetVehicle == 0 then
    if vehicleHandle ~= nil and vehicleHandle ~= 0 and IsEntityAVehicle(vehicleHandle) then
        if(GetVehicleNumberPlateText(vehicleHandle) == placa)then
        RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
        while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
            Citizen.Wait(0)
        end
        TaskPlayAnim(Player, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,8.0, -8.0, -1, 1, 0, false, false, false )
        if CustomMinigame() == true then
            ClearPedTasksImmediately(Player)
            vehicleUnlock(vehicleHandle)
            TriggerEvent('DoLongHudText', 'Lockpick Success !', 1)
            TriggerEvent("fa-hud:boosting_value", 1)
            print("lockpickdone-start hud")
            if(GetVehicleNumberPlateText(vehicleHandle) == placa)then
            if isVin then
                exports['fa-dispatch']:dispatchadd('10-99', 'Tracker Device Tampering - Grand Theft Auto', '227')
                sendAppEvent('BoostingNotification', {notify = {msg = "You need to disable gps before scratching", time = "2/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
                TriggerEvent('phone:addnotification', 'Anonymous', 'Disable the tracker then head to the scratch location.')
                MakeDropZoneThreadVin(true)
                DeleteBlip()
                TriggerServerEvent("Boosting:AddBlipsSystem")
                TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(vehicleHandle)), true)
                isPoliceBlip = true
            else
                exports['fa-dispatch']:dispatchadd('10-99', 'Tracker Device Tampering - Grand Theft Auto', '227')
                sendAppEvent('BoostingNotification', {notify = {msg = "You need to disable gps before dropoff", time = "2/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
                TriggerEvent('phone:addnotification', 'Anonymous', 'Disable the tracker then head to the drop off location.')
                isPoliceBlip = true
                DeleteBlip()
                TriggerServerEvent("Boosting:AddBlipsSystem")
                TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(vehicleHandle)), true)
                MakeDropZoneThread(true)
            end
            end
        else
            ClearPedTasksImmediately(Player)
            TriggerEvent('DoLongHudText', 'Lockpick Failed !', 2)
        end
        else
            print('USE REG LOCKPICK')
            TriggerEvent("inv:lockPick", false, inventoryName, slot, "lockpick")
            end
        end
    else
        print('IN VEH')
        TriggerEvent("inv:lockPick", false, inventoryName, slot, "lockpick")
    end
end)

if Config.CustomKeySystem then

  exports("SetOpenedDoors", function()
    if isVin then
      sendAppEvent('BoostingNotification', {notify = {msg = "Go to the marked place and scratch the vin.", time = "2/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
      TriggerEvent('DoLongHudText', 'Go to the marked place and scratch the vin.', 1)
      CustomNotification("Go to the marked place and scratch the vin.")
      TriggerEvent("setlockpicked:boosting")
      MakeDropZoneThreadVin(true)
      DeleteBlip()
      isPoliceBlip = true
    else
      isPoliceBlip = true
      TriggerEvent("setlockpicked:boosting")
      DeleteBlip()
      MakeDropZoneThread(true)
    end
  end)

end


RegisterNetEvent("boosting:addcooldownHack")
AddEventHandler("boosting:addcooldownHack", function()
  exports['fa-dispatch']:dispatchadd('10-99', 'Tracker Device Tampering - Grand Theft Auto', '227')

  cooldown = true
  TriggerEvent('DoLongHudText', 'You will have to wait 15 Seconds to do another hack.', 1)
  Citizen.Wait(15000)
  cooldown = false
end)

RegisterNetEvent("boosting:helpHack")
AddEventHandler("boosting:helpHack", function()
  DoHackingStagesCOP()
  if HackingIsCompleted() then
    if isVin then
      sendAppEvent('BoostingNotification', {notify = {msg = "Go to the marked place and scratch the vin", time = "3/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
      TriggerEvent('DoLongHudText', 'Go to the marked place and scratch the vin', 1)
      isPoliceBlip = false
      TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(VehicleStoled)), false)
      TriggerServerEvent("Boosting:RemoveBlipsSystem")
    else
      isPoliceBlip = false
      TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(VehicleStoled)), false)
      TriggerServerEvent("Boosting:RemoveBlipsSystem")
    end
  end
end)

RegisterNetEvent("boosting:antiPolice")
AddEventHandler("boosting:antiPolice", function()
  local veh = GetVehiclePedIsIn(PlayerPedId())
  if IsPedInAnyVehicle(PlayerPedId()) then
    local result = TriggerServerCallback{eventName = 'boosting:GetPlateState', args = {
      {
        plate = TrimValue(GetVehicleNumberPlateText(veh))
      }
    }}
    if result then
      local pedin =  GetPedInVehicleSeat(veh, -1)
      if pedin == PlayerPedId() then
        TriggerEvent('DoLongHudText', 'You can not hack the vehicle while driving', 2)
      else
        if isPoliceBlip then
          if cooldown then
            TriggerEvent('DoLongHudText', 'You have to wait for the cooldown to end so that the hack does not block you', 1)
          else
            DoHackingStages()
            if HackingIsCompleted() then
              if isVin then
                sendAppEvent('BoostingNotification', {notify = {msg = "Go to the marked place and scratch the vin.", time = "3/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
                TriggerEvent('DoLongHudText', 'Go to the marked location and scratch the vin', 1)
                isPoliceBlip = false
                TriggerServerEvent("Boosting:RemoveBlipsSystem")
                TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(veh)), false)
              else
                isPoliceBlip = false
                TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(veh)), false)
                TriggerServerEvent("Boosting:RemoveBlipsSystem")
              end
            end
          end
        else
          if cooldown then
            TriggerEvent('DoLongHudText', 'You have to wait for the cooldown to end so that the hack does not block you', 2)
          else
            if CustomMinigameHack() then
              exports['fa-dispatch']:dispatchadd('10-99', 'Tracker Device Tampering - Grand Theft Auto', '227')

              TriggerEvent('boosting:addcooldownHack')
              TriggerEvent('DoLongHudText', '!Wow you help the driver hacking his contract', 1)
              TriggerServerEvent('boosting:coop', GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(veh, -1))))
            else
              TriggerEvent('boosting:addcooldownHack')
              TriggerEvent('DoLongHudText', 'You fail helping to hack noob', 2)
            end
          end
        end
      end
    else
        TriggerEvent('DoLongHudText', 'You do not need to hack this vehicle ?', 1)
    end
  end
end)

RegisterNetEvent("boosting:copBoosting")
AddEventHandler("boosting:copBoosting", function()
  DoHackingStagesCOP()
  --TriggerEvent("fa-hud:boosting_value", 1)
end)


RegisterNetEvent("open:boostingApp")
AddEventHandler("open:boostingApp", function()
  openApplication("OpenBoostingApp")
  SetNuiFocus(true, true)
  DoTimer(true)
  doTablet()
end)

RegisterNetEvent("fa-boosting:open:boostingApp")
AddEventHandler('fa-boosting:open:boostingApp', function()
  TriggerServerEvent("boosting:getLevel")
  TriggerEvent("boosting:qbSpawn")
  TriggerEvent("open:boostingApp")
end)

RegisterNUICallback("fa-boosting:closeBoostingApp", function(data, cb)
  DoTimer(false)
  SetNuiFocus(false, false)
  DeleteEntity(tabletObject)
  ClearPedTasks(PlayerPedId())
  cb({})
end)

RegisterNetEvent("boosting:sendHowMuchGNEIHave", function(pGne)
    gne = pGne
end)

RegisterNUICallback("fa-boosting:startContract", function(data, cb) 
  if not AlredyContract then
    if data.IsVin then
      local units = tonumber(data.props.units)
      print(gne,units + tonumber(data.props.ExtraVin))
      if units + tonumber(data.props.ExtraVin) <= tonumber(gne) then
        if exports['fa-inventory']:hasEnoughOfItem('trackerdisabler', 1) then
            local mexico, minutes = InCoolDown()
            if mexico then
              HackingStage(NumberOfContractsByLevel(data.props.type))
              AlredyContract = true
              TriggerServerEvent("boosting:IsInContract", true)
              TriggerServerEvent("boosting:RemoveBNE", units + tonumber(data.props.ExtraVin))
              local vehicle, plate = CreateVeh(data.props.vehicle, data.props.coords)
              placa = plate
              isVin = data.IsVin
              VehicleStoled = vehicle
              sendAppEvent('BoostingNotification', {notify = {msg = 'Your contract has been started Information Plate: '..plate, time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
              IdToRemove = data.props.id
              CreateBlip(data.props.coords)
              sendAppEvent('SetDisableButtons', {enableButtons = true})
              sendAppEvent('BoostingNotification', {notify = {msg = "You need to find the car and lockpick it in zone marked in map", time = "1/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
              cb({Contract = true})
            else
              sendAppEvent('BoostingNotification', {notify = {msg = "You can't start this contract wait "..minutes.." minutes", time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
              cb({Contract = false})
            end
        else
            sendAppEvent('BoostingNotification', {notify = {msg = "You need to have a tracker disabler to start a contract !", time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
        end
    else
        sendAppEvent('BoostingNotification', {notify = {msg = "You cant start this contract, you have "..gne.." GNE, and you need "..units + tonumber(data.props.ExtraVin).." GNE.", time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
        AlredyContract = false
        cb({Contract = false})
    end
    else
      local units = tonumber(data.props.units)
      
      if units <= tonumber(gne) then
        if exports['fa-inventory']:hasEnoughOfItem('trackerdisabler', 1) then

            TriggerServerEvent("boosting:RemoveBNE", units)
            HackingStage(NumberOfContractsByLevel(data.props.type))
            AlredyContract = true
            TriggerServerEvent("boosting:IsInContract", true)
            local vehicle, plate = CreateVeh(data.props.vehicle, data.props.coords)
            placa = plate
            VehicleStoled = vehicle
            sendAppEvent('BoostingNotification', {notify = {msg = 'Your contract has been started Information Plate: '..plate, time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
            IdToRemove = data.props.id
            CreateBlip(data.props.coords)
            sendAppEvent('SetDisableButtons', {enableButtons = true})
            cb({Contract = true})
        else
            sendAppEvent('BoostingNotification', {notify = {msg = "You need to have a tracker disabler to start a contract !", time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
        end
      else
        sendAppEvent('BoostingNotification', {notify = {msg = "You cant start this contract, you have "..gne.." GNE, and you need "..units.." GNE.", time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
      end
    end
  else
    TriggerEvent('DoLongHudText', 'There is a contract in progress', 1)
  end
end)

RegisterNUICallback("fa-boosting:transferContract", function(data, cb) 
  sendAppEvent("RemoveContractInfo", {IdToRemove = data.props.id})
  TriggerServerEvent("boosting:TransferContract", data)
  cb({})
end)

RegisterNUICallback("fa-boosting:updateTime", function(data, cb) 
  local id = data.props.id
  local counter = data.counter
  TriggerServerEvent("boosting:updateTimer", id, counter)
  cb({})
end)

RegisterNUICallback("fa-boosting:DeclineContract", function(data, cb) 
  sendAppEvent("RemoveContractInfo", {IdToRemove = data.props.id})
  TriggerServerEvent("boosting:CancelContract", data)
  hacks = {
    number1 = false,
    number2 = false,
    number3 = false,
    number4 = false,
    number5 = false,
    number6 = false,
    number7 = false,
    number8 = false,
    number9 = false,
    number10 = false,
  }
  cb({})
end)

RegisterNUICallback("fa-boosting:cancelContract", function(data, cb) 
  TriggerEvent("fa-hud:boosting_value", 0)
  sendAppEvent("RemoveContractInfo", {IdToRemove = data.props.id})
  sendAppEvent('SetDisableButtons', {enableButtons = false})
  TriggerServerEvent("boosting:CancelContract", data)
  if data.IsInProgress then
    hacks = {
      number1 = false,
      number2 = false,
      number3 = false,
      number4 = false,
      number5 = false,
      number6 = false,
      number7 = false,
      number8 = false,
      number9 = false,
      number10 = false,
    }
    DeleteBlip()
    -- DeleteEntity(VehicleStoled)
    TriggerServerEvent('boosting:SetPlateInList', TrimValue(GetVehicleNumberPlateText(VehicleStoled)), false)
    IdToRemove = nil
    placa = nil
    VehicleStoled = nil
    isVin = false
    AlredyContract = false
    RemoveBlip(dropZoneblip or nil)
    TriggerServerEvent("boosting:IsInContract", false)
    TriggerServerEvent("Boosting:RemoveBlipsSystem")
    cb({})
  else
    cb({})
  end
end)

RegisterNUICallback("fa-boosting:JoinQueue", function(data, cb) 
  IsInQueue = data.queue
  if IsInQueue then
    sendAppEvent('BoostingNotification', {notify = {msg = 'You have joined the queue', time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
  else
    sendAppEvent('BoostingNotification', {notify = {msg = 'You have left the queue', time = getClock() , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
  end
  cb({})
end)

RegisterNUICallback("fa-boosting:BennysItem", function(data, cb) 
  if pendingDelivery == false then
    if data.ToPay <= tonumber(gne) then
      TriggerServerEvent('fa-boosting:removeGNE', data.ToPay, exports['isPed']:isPed('cid'))
      DropItemZone(data.CartItems, data.ToPay)
      sendAppEvent('BoostingNotification', {notify = {msg = "You have purchased items, in the amount of "..data.ToPay..' GNE', time = getClock() , app = 'Bennys Parts', img = 'https://imgur.com/kGxkXTk.png'}})
      sendAppEvent('BoostingNotification', {notify = {msg = "You have pending items to collect!", time = getClock() , app = 'Shop Delivery', img = 'https://i.imgur.com/vUJDqz7.png'}})
      cb({Continue = true})
    else
      sendAppEvent('BoostingNotification', {notify = {msg = "You do not have enough GNE.", time = getClock() , app = 'Bennys Parts', img = 'https://imgur.com/kGxkXTk.png'}})
      cb({Continue = false})
    end
  else
    cb({Continue = false})
    sendAppEvent('BoostingNotification', {notify = {msg = "You have to pick up a pending order before you can order more!", time = getClock() , app = 'Shop Delivery', img = 'https://i.imgur.com/vUJDqz7.png'}})
  end
end)

RegisterNUICallback("ps-purchaseGNE", function(data, cb) 
  local amount = tonumber(data.imputValue3)
  TriggerServerEvent("boosting:purchaseGNE", amount)
  cb({})
end)

RegisterNUICallback("ps:sendgne", function(data, cb)
  local player = data.player
  local GneToSend = tonumber(data.GneToSend)
  TriggerServerEvent("boosting:sendGNE", player, GneToSend)
  cb({})
end)

RegisterNetEvent("boosting:FinishGNE")
AddEventHandler("boosting:FinishGNE", function(pass, gne)
  if pass then
    sendAppEvent('BoostingNotification', {notify = {msg = 'You buy '..gne, time = getClock() , app = 'GNE Finance', img = 'https://imgur.com/O10Rx0A.png'}})
  else
    sendAppEvent('BoostingNotification', {notify = {msg = 'You cant buy this now', time = getClock() , app = 'GNE Finance', img = 'https://imgur.com/O10Rx0A.png'}})
  end
end)

RegisterNetEvent("boosting:updateGNE")
AddEventHandler("boosting:updateGNE", function(gne)
  sendAppEvent('UpdateGnes', {gne = gne})
end)

RegisterNetEvent("boosting:Notification")
AddEventHandler("boosting:Notification", function(data)
  sendAppEvent('BoostingNotification', {notify = data})
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------DEBUG----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Config.DevCommands then
  RegisterCommand(Config.CreateContractCommand, function()
    TriggerServerEvent("boosting:CreateContract", getClock())
  end)
end

-- Laptop Interact --

RegisterNetEvent("fa-boosting:client:UseComputer")
AddEventHandler("fa-boosting:client:UseComputer" , function()
  if exports['fa-boosting']:pCanUseLaptop() then
    CanScratchVehicle = false
    RemoveBlip(dropZoneblip)
    FreezeEntityPosition(PlayerPedId(),true)
    TriggerEvent("animation:PlayAnimation", 'type')
    local finished = exports['fa-taskbar']:taskBar(1500, 'Opening Laptop')
    if (finished == 100) then
      Citizen.Wait(250)
      TriggerEvent("animation:PlayAnimation", 'type')
      local finished = exports['fa-taskbar']:taskBar(7000, 'Connection to network...')
      if (finished == 100) then
        Citizen.Wait(250)
        TriggerEvent("animation:PlayAnimation", 'type')
        local finished = exports['fa-taskbar']:taskBar(13000, "Wiping Online Paperwork...")
        if finished == 100 then
          pCanWalkAndScratch = true
          TriggerEvent("DoLongHudText", 'Head to the vehicle and scratch off the vin!', 1)
          FreezeEntityPosition(PlayerPedId(),false)
          ClearPedTasks(PlayerPedId())
        end
      end
    end
  end
end)

RegisterNetEvent('fa-boosting:finish_scratch')
AddEventHandler('fa-boosting:finish_scratch', function()
  local veh = pVeh
  local playerped = PlayerPedId()
  local coordA = GetEntityCoords(playerped, 1)
  local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
  local targetVehicle = getVehicleInDirection(coordA, coordB)

  if GetVehicleNumberPlateText(targetVehicle) == placa then
  sendAppEvent('SetDisableButtons', {enableButtons = false})
  sendAppEvent("RemoveContractInfo", {IdToRemove = IdToRemove})
  TriggerEvent('animation:PlayAnimation', 'kneel')
    pCanWalkAndScratch = false
    local finished = exports['fa-taskbar']:taskBar(10000, 'Scratching Vin')
    if (finished == 100) then
      recentlyScratched = true
      TriggerServerEvent("boosting:completeVinContract", IdToRemove, placa)
      IdToRemove = nil
      AlredyContract = false
      TriggerServerEvent("boosting:IsInContract", false)
      sendAppEvent('BoostingNotification', {notify = {msg = "Get the fuck out of here!", time = "4/4" , app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}})
      pVeh = nil
      placa = nil
      Citizen.Wait(1800000)
      recentlyScratched = false
    end
  end
end)

function pCanUseLaptop()
  if CanScratchVehicle then
    CanScratchVehicle = true
  elseif not CanScratchVehicle then
    CanScratchVehicle = false
  end
  return CanScratchVehicle
end

function pCanFinishScratch()
  if pCanWalkAndScratch then
    pCanWalkAndScratch = true
  elseif not pCanWalkAndScratch then
    pCanWalkAndScratch = false
  end
  return pCanWalkAndScratch
end