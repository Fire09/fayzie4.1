local guiEnabled = false
local hasOpened = false
local lstMsgs = {}
local lstContacts = {}
local inPhone = false
local radioChannel = math.random(1,999)
local usedFingers = false
local dead = false
local onhold = false
local YellowPageArray = {}
local YellowPages = {}
local PhoneBooth = GetEntityCoords(PlayerPedId())
local phoneNotifications = true
local insideDelivers = false
local curhrs = 9
local curmins = 2
local allowpopups = true
local vehicles = {}
local isDead = false
local wallPaper = ""
local pPhoneOpen = false
local unReadMsg = 0
local unReadTwt = 0
local unReadEmail = 0
local serverSpawn = false
local sanitation = true
local rentEnabled = true
local canSpawnVehs = false
local canSpawnDist = 0
local vehSpawnPlate = 0
local spawningVeh = 0
local enablePassword = true
local passWifi = 0
local selfie_Discord = "https://discordapp.com/api/webhooks/xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-M"
local wifipass1 = ""
local wifipass2 = "pass2"
local wifipass3 = "pass3"
local wifipass4 = "pass4"
local wifipass5 = "pass5"
local wifipass6 = "pass6"
local wifipass7 = "pass7"


function pOpen()
  return pPhoneOpen
end

function phasPhone()
  return hasPhone()
end

function pNotify()
  return phoneNotifications
end

CreateThread(function ()
  while true do
    Wait(0)
      if guiEnabled == true then 
        DisableAllControlActions(0)
        DisableAllControlActions(2)
             
        EnableControlAction(0, 32, true)
        EnableControlAction(0, 34, true)
        EnableControlAction(0, 31, true)
        EnableControlAction(0, 30, true)
        EnableControlAction(0, 22, true)
        EnableControlAction(0, 21, true)

        -- car
        EnableControlAction(0, 71, true)
        EnableControlAction(0, 72, true)
        EnableControlAction(0, 59, true)

        -- push to talk
        EnableControlAction(0, 249, true)
      end
    end
end)


RegisterNetEvent('fa-base:playerSpawned')
AddEventHandler('fa-base:playerSpawned', function()
  Wait(1000)
  local model = GetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel")
  local twat = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat")
  local call = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall")
  if model == 1 then
    SendNUIMessage({
      pModel = true,
      setModel = true,
    })
  else
    SendNUIMessage({
      pModel = true,
      setModel = false,
    })
  end
  Wait(5000)
  TriggerEvent('setPhoneLicense')
end)

RegisterCommand('renten', function()
  TriggerEvent('fa-housing:rent_activate_cl')
end)

RegisterNetEvent('fa-housing:rent_activate_cl')
AddEventHandler('fa-housing:rent_activate_cl', function()
    local rank = exports['isPed']:GroupRank("real_estate")
    if not rentEnabled then
        if rank > 0 then
            TriggerEvent('DoLongHudText', "Rent is Enabled.")
        end
        rentEnabled = true
        enabledRentSelling()
    else
        if rank > 0 then
            TriggerEvent('DoLongHudText', "Rent is Disabled.",2)
        end
        rentEnabled = false
    end
end)

AddEventHandler('fa-phone:sanitationIn', function()
  -- print("SANITATION SIGN IN")
  sanitation = true
end)

RegisterNetEvent("fa-phone:grabBackground")
AddEventHandler("fa-phone:grabBackground", function(link)
    wallPaper = link
end)

RegisterNetEvent("fa-jobmanager:playerBecameJob")
AddEventHandler("fa-jobmanager:playerBecameJob", function(job)
    if job == "trucker" then
        trucker = true
    end
end)

AddEventHandler('addUnreadMsg', function()
  unReadMsg = unReadMsg + 1
end)

AddEventHandler('msgReads', function()
  unReadMsg = 0
end)

AddEventHandler('addUnreadTwt', function()
  unReadTwt = unReadTwt + 1
end)

AddEventHandler('twtReads', function()
  unReadTwt = 0
end)

AddEventHandler('addUnreadEmail', function()
  unReadEmail = unReadEmail + 1
end)

AddEventHandler('emailReads', function()
  unReadEmail = 0
end)

RegisterNUICallback('emailReads', function(data)
  unReadEmail = 0
end)

function SetCustomNuiFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse

  SetNuiFocus(hasKeyboard, hasMouse)
  SetNuiFocusKeepInput(HasNuiFocus)

  TriggerEvent("erp:voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
end

RegisterNUICallback('btnNotifyToggle', function(data, cb)
    allowpopups = not allowpopups
    if allowpopups then
      TriggerEvent("DoLongHudText","Popups Enabled", 1)
    else
      TriggerEvent("DoLongHudText","Popups Disabled", 2)
    end
end)

RegisterNUICallback('wallpaper', function(data, cb)
  wallPaper = ""
  Wait(5)
  local wallPaperSelecionado = data.wallpaper
  TriggerEvent('fa-phone:grabBackground', wallPaperSelecionado)
  TriggerServerEvent("phone:saveWallpaper", exports['isPed']:isPed('cid'), wallPaperSelecionado)
end)

activeNumbersClient = {}

RegisterNetEvent('phone:reset')
AddEventHandler('phone:reset', function(cidsent)
    closeGui()
    guiEnabled = false
    hasOpened = false
    lstMsgs = {}
    lstContacts = {}
    vehicles = {}
    radioChannel = math.random(1,999)
    dead = false
    onhold = false
    inPhone = false
    wallPaper = ""
    Wait(1)
    TriggerServerEvent('fa-phone:grabWallpaper')
end)

RegisterNUICallback('sendThePM', function(data, cb)
  local thePM = data.thePM
  RPC.execute("fa-phone:sendThePM", thePM)
end)

RegisterCommand("fuckmeintheasdasvf", function()
  RPC.execute("fa-phone:sendThePM", 'f')
end)

RegisterNetEvent('Yougotpaid')
AddEventHandler('Yougotpaid', function(cidsent)
    if tonumber(cid) == tonumber(cidsent) then
      TriggerEvent("DoLongHudText","Life Invader Payslip Generated.", 1)
    end
end)

RegisterNetEvent('checkingLicense')
AddEventHandler('checkingLicense', function(zeb)
    print(zeb)
end)

-- Citizen.CreateThread(function()
--   TriggerServerEvent('checkingLicense')
-- end)

RegisterNetEvent("phone:listunpaid")
AddEventHandler("phone:listunpaid", function(outstandingArray)

  SendNUIMessage({
    openSection = "showOutstandingPayments",
    outstandingPayments = outstandingArray
  })
end)
           
RegisterNetEvent('Payment:Successful')
AddEventHandler('Payment:Successful', function()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Payment Processed.",
    })     
end)

RegisterNetEvent('warrants:AddInfo')
AddEventHandler('warrants:AddInfo', function(name, charges)

    openGuiNow()

    SendNUIMessage({
      openSection = "enableoutstanding",
    })
    for i = 1, #charges do

      SendNUIMessage({
        openSection = "inputoutstanding",
        textmessage = charges[i],
      })
    end
    
end)

RegisterNetEvent("phone:activeNumbers")
AddEventHandler("phone:activeNumbers", function(activePhoneNumbers)
  activeNumbersClient = activePhoneNumbers
  hasOpened = false
end)



RegisterNetEvent("gangTasks:updateClients")
AddEventHandler("gangTasks:updateClients", function(newTasks)
  activeTasks = newTasks
end)

TaskState = {
  [1] = "Ready For Pickup",
  [2] = "In Process",
  [3] = "Successful",
  [4] = "Failed",
  [5] = "Delivered with Damaged Goods",
}

TaskTitle = {
  [1] = "Ordering 'Take-Out'",
  [2] = "Ordering 'Disposal Service'",
  [3] = "Ordering 'Postal Delivery'",
  [4] = "Ordering 'Hot Food Room Service'",
}

function findTaskIdFromBlockChain(blockchain)
  local retnum = 1
  for i = 1, #activeTasks do
    if activeTasks[i]["BlockChain"] == blockchain then
      retnum = i
    end
  end
  return retnum
end

-- real estate nui app responses

function loading()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })  
end

RegisterNetEvent("phone:setServerTime")
AddEventHandler("phone:setServerTime", function(time)
  SendNUIMessage({
    openSection = "server-time",
    serverTime = time
  })
end)

RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(hrs,mins)


  if hrs < 10 then
    hrs = "0"..hrs
  end
  if mins < 10 then
    mins = "0"..mins
  end
  curhrs = hrs
  curmins = mins

  local timesent = curhrs .. ":" .. curmins
  if guiEnabled then
    SendNUIMessage({
      openSection = "timeheader",
      timestamp = timesent,
    })   
  end
end)


function doTimeUpdate()
  hour = GetClockHours()
  minute = GetClockMinutes()

  if minute <= 9 then
		minute = "0" .. minute
  end

  local timesent = hour .. ":" .. minute
  if guiEnabled then
    SendNUIMessage({
      openSection = "timeheader",
      timestamp = timesent,
    })   
  end
end

RegisterNUICallback('btnGiveKey', function(data, cb)
  TriggerEvent("houses:GiveKey")
end)
RegisterNetEvent("returnPlayerKeys")
AddEventHandler("returnPlayerKeys", function(ownedkeys,sharedkeys)
  
      if not guiEnabled then
        return
      end
      SendNUIMessage({
        openSection = "keys",
        keys = {
          sharedKeys = sharedkeys,
          ownedKeys = ownedkeys
        }
      })
end)

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

local selfieMode = false
local isCamera, frontCam = false, false
RegisterNUICallback('phone:selfie', function()
  selfieMode = not selfieMode
  closeGui()
  ToggleCamera()
end)

RegisterNUICallback('submitSettings', function(data, cb)
  local bg = data.bg
  local model = data.model
  local twatNotify = data.twat
  local callNotify = data.call
  wallPaper = ""
  Wait(5)
  if bg ~= "" then
    TriggerEvent('fa-phone:grabBackground', bg)
    TriggerEvent('changeBG', bg)
    SetResourceKvp(exports['isPed']:isPed('cid').."-bg", bg)
  end
 
  TriggerEvent('setModel', model)

  SetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel", model)
  SetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat", twatNotify)
  SetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall", callNotify)
end)

RegisterNetEvent("fa-phone:setSomeShit", function(bg, model, twatNotify, callNotify)
  SetResourceKvp(exports['isPed']:isPed('cid').."-bg", bg)
  SetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel", model)
  SetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat", twatNotify)
  SetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall", callNotify)

  Citizen.Wait(1000)
  TriggerEvent('fa-hud:SetValues', exports['isPed']:isPed('cid'))
end)

RegisterNetEvent('setModel', function(bg)
  SendNUIMessage({
    openSection = "setModelPhone",
    android = bg
  })
  setBackground()
end)

RegisterNetEvent('changeBG', function(bg)
  SendNUIMessage({
    openSection = "phoneBg",
    phoneBg = bg
  })
end)

RegisterNUICallback('checkModel', function()
  local nModel = false
  local model = GetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel")
  if model == 1 then
    nModel = true
  end
  SendNUIMessage({
    openSection = "setModelPhone",
    android = nModel
  })
  setBackground()
end)

function getModelForHud()
  local nModel = 'iOS'
  local model = GetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel")
  if model == 1 then
    nModel = 'Android'
  end
  return nModel
end

exports('getModelForHud',getModelForHud)

function getBackgroundForHud()
  local bg = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")
  return bg
end

exports('getBackgroundForHud',getBackgroundForHud)

function getTwatForHud()
  local nTwat = false
  local twat = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat")
  if twat == 1 then
    nTwat = true
  end
  return nTwat
end

exports('getTwatForHud',getTwatForHud)

function getCallForHud()
  local nCall = false
  local call = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall")
  if call == 1 then
    nCall = true
  end
  return nCall
end

exports('getCallForHud',getCallForHud)

RegisterNUICallback('openSettings', function()
  local nModel = false
  local nTwat = false
  local nCall = false
  local model = GetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel")
  local twat = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat")
  local call = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall")
  if model == 1 then
    nModel = true
  end
  if twat == 1 then
    nTwat = true
  end
  if call == 1 then
    nCall = true
  end
  SendNUIMessage({
    openSection = "openSettings",
    model = nModel,
    twat = nTwat,
    call = nCall
  })
end)

local takePhoto = false
local time = 0

function setBackground()
  SendNUIMessage({
    openSection = "phoneBg",
    phoneBg = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")
  })
end

function CellFrontCamActivate(activate) return Citizen.InvokeNative(0x2491A93618B7D838, activate) end

function ToggleCamera()

  CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takePhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) and takePhoto then -- TAKE.. PIC
        if time == 0 then
          time = 10
            exports['screenshot-basic']:requestScreenshotUpload(selfie_Discord, 'files[]', function(data)
              local resp = json.decode(data)

              TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.5, "photo-capture1", 0.03)
              
              DestroyMobilePhone()
              CellCamActivate(false, false)
              SetTimeout(2000, function()
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.5, "phone-notify", 0.10)

                SetNuiFocus(true,true)
                SendNUIMessage({
                  selfiebox = true,
                  openSection = "selfiebox",
                  imgLink = resp.attachments[1].proxy_url,
                  img = resp.attachments[1].proxy_url
                })
              end)
              
            takePhoto = false
            
          end)
        else
        end
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
end

Citizen.CreateThread(function()
  while true do
    Wait(1000)
      if time > 0 then
        time = time - 1
        if time == 0 then
          time = 0
        end
      end
    end
end)

RegisterNUICallback('closeSelfieBox', function()
  SendNUIMessage({
    openSection = "selfieboxClose",
  })
  SetNuiFocus(false, false)
end)

RegisterNUICallback('closeSelfi', function()
  SetNuiFocus(false, false)
end)

RegisterNUICallback('trackTaskLocation', function(data, cb)
    local taskID = findTaskIdFromBlockChain(data.TaskIdentifier)
    TriggerEvent("DoLongHudText","Location Set", 1)

    SetNewWaypoint(activeTasks[taskID]["Location"]["x"],activeTasks[taskID]["Location"]["y"])
end)

RegisterNetEvent("phone:error")
AddEventHandler("phone:error", function()
      SendNUIMessage({
        openSection = "error",
        textmessage = "<b>Network Error</b> <br><br> Please contact support if this error persists, thank you for using Syko's Phone Services.",
      })   
end)

-- RegisterNUICallback('manageGroup', function(data)
--   local groupid = data.GroupID
  
--   local rank = GroupRank(groupid)
--   if rank < 2 then
--     SendNUIMessage({
--       openSection = "error",
--       textmessage = "Permission Error",
--     })   
--     return
--   end

--   SendNUIMessage({
--       openSection = "error",
--       textmessage = "Loading, please wait.",
--   })   

--   TriggerServerEvent("group:pullinformation",groupid,rank)

-- end)

RegisterNUICallback('btnProperty', function(data, cb)
  loading()
  local realEstateRank = GroupRank("real_estate")
  if realEstateRank > 0 then
    SendNUIMessage({
        openSection = "RealEstate",
        RERank = realEstateRank
    })        
  end
end)



RegisterNUICallback('wenmo', function(data, cb)
  SendNUIMessage({
    openSection = "bankManage",
    groupData = {
      groupName = 'poop',
      bank = 'poop',
      groupId = 'poop',
      employees = 'poop',
    }
  })  
  loading()
end)


RegisterNUICallback('btnProperty2', function(data, cb)
  loading()
  TriggerServerEvent("ReturnHouseKeys", exports['isPed']:isPed('cid'))
end)

RegisterNUICallback('btnPayMortgage', function(data, cb)
  loading()
  TriggerEvent("housing:attemptpay")
end)

RegisterNUICallback('retrieveHouseKeys', function(data, cb)
  TriggerEvent("houses:retrieveHouseKeys")
  cb('ok')
end)

RegisterNUICallback('btnFurniture', function(data, cb)
  closeGui()
  SendNUIMessage({
    openSection = "forceclose"
  })
  --TriggerEvent("DoLongHudText", "Coming soon.", 2)
  TriggerEvent("openFurniture")
end)

RegisterNUICallback('btnPropertyModify', function(data, cb)
TriggerEvent("housing:info:realtor","modify")
end)

RegisterNUICallback('removeHouseKey', function(data, cb)
  TriggerEvent("houses:removeHouseKey", data.targetId)
  cb('ok')
end)


RegisterNUICallback('removeSharedKey', function(data, cb)
  local cid = exports["isPed"]:isPed("cid")
  TriggerServerEvent("houses:removeSharedKey", data.house_id, cid)
  cb('ok')
end)

RegisterNUICallback('btnPropertyReset', function(data, cb)
TriggerEvent("housing:info:realtor","reset")
end)

RegisterNUICallback('btnPropertyClothing', function(data, cb)
TriggerEvent("housing:info:realtor","setclothing")
end)

RegisterNUICallback('btnPropertyStorage', function(data, cb)
TriggerEvent("housing:info:realtor","setstorage")
end)

RegisterNUICallback('btnPropertySetGarage', function(data, cb)
TriggerEvent("housing:info:realtor","setgarage")
end)

RegisterNUICallback('btnPropertyWipeGarages', function(data, cb)
TriggerEvent("housing:info:realtor","wipegarages")
end)

RegisterNUICallback('btnPropertySetBackdoorInside', function(data, cb)
TriggerEvent("housing:info:realtor","backdoorinside")
end)

RegisterNUICallback('btnPropertySetBackdoorOutside', function(data, cb)
TriggerEvent("housing:info:realtor","backdooroutside")
end)

RegisterNUICallback('btnPropertyUpdateHouse', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnRemoveSharedKey', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnPropertyOutstanding', function(data, cb)
  TriggerEvent("housing:info:realtor","PropertyOutstanding")
  end)

RegisterNUICallback('btnPropertyUnlock', function(data, cb)
  TriggerEvent("housing:info:realtor","unlock")
end)

RegisterNUICallback('btnPropertyUnlock2', function(data, cb)
  TriggerEvent("housing:info:realtor","unlock2")
end)

RegisterNUICallback('btnPropertyHouseCreationPoint', function(data, cb)
TriggerEvent("housing:info:realtor","creationpoint")
end)
RegisterNUICallback('btnPropertyStopHouse', function(data, cb)
TriggerEvent("housing:info:realtor","stop")
end)
RegisterNUICallback('btnAttemptHouseSale', function(data, cb)
TriggerEvent("housing:findsalecid",data.cid,data.price)
end)
RegisterNUICallback('btnTransferHouse', function(data, cb)
TriggerEvent("housing:transferHouseAttempt", data.cid)
end)
RegisterNUICallback('btnEvictHouse', function(data, cb)
TriggerEvent("housing:evictHouseAttempt")
end)
RegisterNUICallback('btnGiveKey', function(data, cb)
  TriggerEvent("houses:GiveKey")
end)
RegisterNUICallback('btnFurniture', function(data, cb)
  closeGui()
  TriggerEvent("openFurniture")
end)


-- real estate nui app responses end

RegisterNUICallback('btnHousing', function()
  -- print("HOUSE BUTTON")
  newHouses = {}
  allNewHouses = {}
  myAccessHouse = {}
  --local apt = RPC.execute("fa-phone:apt")
  local housing = exports['fa-housing']:housingForPhone()
  local apartment = exports['fa-apartments']:getMyCurrentApartment()
  myHousess = RPC.execute("fa-phone:getCurrentOwned")
  accessHouse = RPC.execute('fa-phone:getAccessHouse_2')
  TriggerServerEvent('checkKeys')
  local cid = exports["isPed"]:isPed("cid")
  for i,v in pairs(myHousess) do
    print("STATUS", v.status)
    table.insert(newHouses, {
      hid = v.hid,
      cid = v.cid,
      status = v.status,
      cat = exports['fa-housing']:getHousingCatFromPropertID(v.hid),
    })
  end
  for l,s in pairs(accessHouse) do
      table.insert(myAccessHouse, {
        house = s.house,
        cid = s.cid,
        status = s.status,
        cat = exports['fa-housing']:getHousingCatFromPropertID(s.house),
      })
  end
  SendNUIMessage({
    openSection = "housing",
    apId = apartment.apartmentNumber,
    sName = apartment.apartmentType,
    myHouse = newHouses,
    houses = housing,
    accessHouse = myAccessHouse,
  })
end)

RegisterNUICallback('upgradeApt', function(data,cb)
  if data.type == 2 then
    TriggerEvent('apartment:upgrades2')
    phoneNotification("email", "You have purchased the tier 2 apartment!", "Maze Bank")
  elseif data.type == 3 then
    TriggerEvent('apartment:upgrades3')
    phoneNotification("email", "You have purchased the tier 3 apartment!", "Maze Bank")
  end
end)

RegisterNUICallback('btnKeyHolders', function(data, cb)
  local myKittens = {}
  print(data.hid)
  local keys = RPC.execute('fa-housing:getKeyHolderz', data.hid)
  SendNUIMessage({
    openSection = "keyHolders",
    accessKeys = keys
  })
end)

RegisterNUICallback('whatthefuckdoesthisshitwork', function(data,cb)
  local cid = data.cid
  local hid = data.hid
  local success,msg = RPC.execute('fa-housing:removeKey:phone',cid, hid)
  if success then
    TriggerEvent("DoLongHudText",msg,1)
  end

  local myKittens = {}
  print(data.hid)
  local keys = RPC.execute('fa-housing:getKeyHolderz', data.hid)
  SendNUIMessage({
    openSection = "keyHolders",
    accessKeys = keys
  })
end)

RegisterNUICallback('OpenCamera', function(data,cb)
  RPC.execute('fa-phone:openCamera', data.cameraId)
end)

RegisterNetEvent('updateUIHousing', function()
  -- print("HOUSE BUTTON")
  newHouses = {}
  allNewHouses = {}
  myAccessHouse = {}
  local apt = RPC.execute("fa-phone:apt")
  local housing = exports['fa-housing']:housingForPhone()
  myHousess = RPC.execute("fa-phone:getCurrentOwned")
  accessHouse = RPC.execute('fa-phone:getAccessHouse_2')
  TriggerServerEvent('checkKeys')
  local cid = exports["isPed"]:isPed("cid")
  for i,v in pairs(myHousess) do
    -- print("STATUS", v.status)
    table.insert(newHouses, {
      hid = v.hid,
      cid = v.cid,
      status = v.status,
      cat = exports['fa-housing']:getHousingCatFromPropertID(v.hid),
      
    })
  end
  for l,s in pairs(accessHouse) do
    -- print("STATUS", v.status)
    if tonumber(cid) ==  tonumber(s.cid) then
      table.insert(myAccessHouse, {
        house = s.house,
        cid = s.cid,
        status = s.status,
         name = s.name,
        cat = exports['fa-housing']:getHousingCatFromPropertID(s.house),
        
      })
    end
  end
  SendNUIMessage({
    openSection = "updhousing",
    apId = apt.id,
    sName = 'Alta St',
    myHouse = newHouses,
    houses = housing,
    accessHouse = myAccessHouse,
  })
end)

RegisterNetEvent('updateHousing')
AddEventHandler('updateHousing', function()
  -- print("HOUSE BUTTON")
  newHouses = {}
  allNewHouses = {}
  myAccessHouse = {}
  local apt = RPC.execute("fa-phone:apt")
  local housing = exports['fa-housing']:housingForPhone()
  myHousess = RPC.execute("fa-phone:getCurrentOwned")
  accessHouse = RPC.execute('fa-phone:getAccessHouse_2')
  TriggerServerEvent('checkKeys')
  local cid = exports["isPed"]:isPed("cid")
  for i,v in pairs(myHousess) do
    -- print("STATUS", v.status)
    table.insert(newHouses, {
      hid = v.hid,
      cid = v.cid,
      status = v.status,
      cat = exports['fa-housing']:getHousingCatFromPropertID(v.hid),
      
    })
  end
  for l,s in pairs(accessHouse) do
    -- print("STATUS", v.status)
    if tonumber(cid) ==  tonumber(s.cid) then
      table.insert(myAccessHouse, {
        house = s.house,
        cid = s.cid,
        status = s.status,
         name = s.name,
        cat = exports['fa-housing']:getHousingCatFromPropertID(s.house),
        
      })
    end
  end
  SendNUIMessage({
    openSection = "housing",
    apId = apt.id,
    sName = 'Alta St',
    myHouse = newHouses,
    houses = housing,
    accessHouse = myAccessHouse,
  })
end)

-- Citizen.CreateThread(function()
--   while true do
--     Wait(3000)
--     local myHouse = RPC.execute("fa-phone:getCurrentOwned")
--     print("MY HOUSE", myHouse.hid,json.encode(myHouse))
--   end
-- end)

local pcs = {
  [1] = 1333557690,
  [2] = -1524180747, 
}


function IsNearPC()
  for i = 1, #pcs do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 0.75, pcs[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
      return true
    end
  end

  if #(GetEntityCoords(PlayerPedId()) - vector3(1272.27, -1711.91, 54.78)) < 1.0 then
    SetEntityHeading(PlayerPedId(),14.0)
    return true
  end
  if #(GetEntityCoords(PlayerPedId()) - vector3(1275.4, -1710.52, 54.78)) < 5.0 then
    SetEntityHeading(PlayerPedId(),300.0)
    return true
  end


  return false
end

RegisterNetEvent("open:deepweb")
AddEventHandler("open:deepweb", function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
  guiEnabled = true
  SendNUIMessage({
    openSection = "deepweb" 
  })
end)

RegisterNetEvent("gangTasks:updated")
AddEventHandler("gangTasks:updated", function()
  local taskObject = {}
  for i = 1, #activeTasks do

    if activeTasks[i]["Gang"] ~= 0 and gang ~= 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then
      if gang == activeTasks[i]["Gang"] then
        taskObject[#taskObject + 1 ] = {
          name = TaskTitle[activeTasks[i]["TaskType"]],
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 0,
        }
      end
    elseif activeTasks[i]["Gang"] == 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then
      
      local passes = exports["isPed"]:isPed("passes")
      for z = 1, #passes do

        local passType = activeTasks[i]["Group"]
        if passes[z].pass_type == passType and (passes[z].rank == 2 or passes[z].rank > 3) then
          taskObject[#taskObject + 1 ] = {
            name = activeTasks[i]["TaskNameGroup"],
            assignedTo = activeTasks[i]["taskOwnerCid"],
            status = TaskState[activeTasks[i]["TaskState"]],
            identifier = activeTasks[i]["BlockChain"],
            groupId = passType,
            retrace = 0,
          }
        end

      end

    else
      if tonumber(activeTasks[i]["taskOwnerCid"]) == cid then

        local TaskName = ""
        if activeTasks[i]["Gang"] == 0 then
          TaskName = activeTasks[i]["TaskNameGroup"]
        else
          TaskName = TaskTitle[activeTasks[i]["TaskType"]]
        end
        taskObject[#taskObject + 1 ] = {
          name = TaskName,
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 1
        }
      end
    end
  end

  SendNUIMessage({
    openSection = "addTasks",
    tasks = taskObject
  })
end)

RegisterNetEvent("purchasePhone")
AddEventHandler("purchasePhone", function()
  TriggerServerEvent("purchasePhone")
end)

RegisterNUICallback('btnMute', function()
  if phoneNotifications then
    TriggerEvent("DoLongHudText","Notifications Disabled.", 2)
  else
    TriggerEvent("DoLongHudText","Notifications Enabled.", 1)
  end
  phoneNotifications = not phoneNotifications
end)

function isDudeQuallied(name)
  if exports['isPed']:isPed("myjob") == name then
    return true
  end
  return false
end

RegisterInterfaceCallback("fa-phone:signInHandler", function(data, cb)
  if data.key.sign_in then
    RPC.execute("fa-phone:addDOJ", data.key.job)
  else
    RPC.execute("fa-phone:removeDOJ", data.key.job)
  end
  cb({ data = {}, meta = { ok = true, message = '' } })
end)


RegisterNUICallback('getActiveDOJ', function(data,cb)
      SendNUIMessage({
        openSection = "getDOJNow",
        penisinmybuttholefuckshit = RPC.execute("fa-phone:getDOJ")
      })
end)


RegisterNUICallback('abdulSignIn', function(data,cb)
    local taxiStatus = data.status
    if taxiStatus then
      RPC.execute("fa-phone:addAbdulTaxi")
      addAbdulTaxi()
      local availableDrivers = getAbdulTaxi()
      SendNUIMessage({
        openSection = "addTaxi",
        currentDrivers = availableDrivers
      })
    elseif not taxiStatus then
      RPC.execute("fa-phone:removeAbdulTaxi")
      removeAbdulTaxi()
      local availableDrivers = getAbdulTaxi()
      SendNUIMessage({
        openSection = "addTaxi",
        currentDrivers = availableDrivers
      })
--      print('JOB ENDED LETS REVOKE DATA')
    end
end)

RegisterNetEvent("fa-phone:manualUpdateAbdulTaxies", function(availableDrivers)
  addAbdulTaxi()
  local availableDrivers = getAbdulTaxi()
  SendNUIMessage({
    openSection = "addTaxi",
    currentDrivers = availableDrivers
  })
end)

local currenttable = {}
function addAbdulTaxi () 
  currenttable = {}
  local table = RPC.execute("fa-phone:getAbdulTaxies")
--  local currenttable = {}
  for k,v in pairs(table) do
    currenttable[#currenttable+1] = {
      name = v.name,
      cid = v.cid,
      phonenumber = v.phonenumber
    }
  end
end

function removeAbdulTaxi ()
  currenttable = {}
  local table = RPC.execute("fa-phone:getAbdulTaxies")
--  local currenttable = {}
  for k,v in pairs(table) do
    currenttable[#currenttable+1] = {
      name = v.name,
      cid = v.cid,
      phonenumber = v.phonenumber
    }
  end
end

function getAbdulTaxi()
  return currenttable
end

RegisterNetEvent("tryTweet")
AddEventHandler("tryTweet", function(tweetinfo,message,user)
  if hasPhone() then
    TriggerServerEvent("AllowTweet",tweetinfo,message)
  end
end)

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)



RegisterNUICallback('btnGarage', function()
  local LocalPlayer = exports["fa-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  TriggerServerEvent("garages:CheckGarageForVeh", Player.id)
end)


RegisterNUICallback('btnHelp', function()
  closeGui()
  TriggerEvent("openWiki")
end)

RegisterNUICallback('carpaymentsowed', function()
  TriggerEvent("car:carpaymentsowed")
end)

local sellCarPlate = 0 

RegisterNUICallback('sellVeh', function(data)
  TriggerEvent('DoLongHudText', 'Coming Soon')
  TriggerServerEvent('fa-phone:sendVehBill', data.paypal, data.plate, data.amount)
end)

RegisterNetEvent('fa-phone:sellCar')
AddEventHandler('fa-phone:sellCar', function(plate,amount,sId)
  sellCarPlate = plate
  local title = "Purchase Vehicle"
  data = {amount = amount, sellerID = sId}
  phoneBillNotification("carsale",data,title)  
end)

RegisterNUICallback('purchaseCar', function(data)
  TriggerServerEvent('fa-phone:purchasedCar', sellCarPlate, data.amount,data.senderID)
end)

RegisterNUICallback('purchase_gas', function(data)
  TriggerEvent('fa-fuel:OfferAccepted')
end)

RegisterNetEvent('fa-hud:send_fuel_bill', function(pCost)
  local title = "Gas Station"
  data = {amount = pCost, sellerID = '1', pType = 'gas_station'}
 -- phoneBillNotification("gas", data, "Gas Station")

  phoneBillNotification("gas", data, title)
end)

RegisterCommand("dothenotif", function()
  local title = "Mali McFarland's Corner Side Services"
  data = {amount = 100, sellerID = '1', pType = 'gas_station', targetCID = 867, companyID = "ace_industries", companyName = title}
 -- phoneBillNotification("gas", data, "Gas Station")

  phoneBillNotification("charge", data, title)
end)

RegisterNUICallback("acceptBusinessCharge", function(data)
  print(data.pBID, data.pAmount, data.pTargetID)
  local success, msg, msgtype = RPC.execute("acceptBusinessCharge", data.pBID, data.pAmount, data.pTargetID)
  TriggerEvent("DoLongHudText",msg,msgtype)
  if not success then return end
end)

local timeSpawn = 0
RegisterNUICallback('vehspawn', function(data)
  local payload = RPC.execute("phone:attempt:sv", data.vehplate)
  canSpawnVehs = false


  if timeSpawn == 0 then
    timeSpawn = 30


    if payload.vehicle_state == "Out" then
      local decode = json.decode(payload.coords)
      local coords = vector3(decode[1], decode[2], decode[3])
      local createdVehicle = CreateVehicle(payload.model, coords, true, true)

      payload.netId = createdVehicle
      payload.vehicleHash = payload


      exports['erp_garages']:setVehicleProps(payload)
      startSpawnTime()
    else
      TriggerEvent('DoLongHudText', "Check you car in phone, its not yet out in garage.")
    end


  else
    TriggerEvent('DoLongHudText', "Please wait "..timeSpawn.." to use spawn again.")
  end
end)

function startSpawnTime()
  while true do
    Wait(1000)
    timeSpawn = timeSpawn-1
    if timeSpawn == 0 then
      break
    end
  end
end
RegisterNUICallback('vehtrack', function(data)
  TriggerServerEvent("get:vehicle:coords", data.vehplate)
end)


RegisterNUICallback('vehiclePay', function(data)
  TriggerServerEvent('car:dopayment', data.vehiclePlate)
end)

RegisterNetEvent("phone:carspawn", function(data,coords,state)
  for ind, value in pairs(data) do
    if state == "Out" then
      if #(vector3(coords[1],coords[2],coords[3]) - GetEntityCoords(PlayerPedId())) < 10.0 then
       -- DeleteBlip()
        trackVehicle = false
        SpawnVehicle(value.model, coords[1],coords[2],coords[3], value.fuel, value.data, value.license_plate, true,value.engine_damage,value.body_damage)
      else
        TriggerEvent("DoLongHudText","Nao podes tirar o veiculo de tao longe.", 2)
      end
    else
      TriggerEvent("DoLongHudText","Veiculo esta numa garagem.", 2)
    end
  end
end)

CurrentDisplayVehicle, ParkingSpot = nil, nil

function SpawnVehicle(vehicle, x,y,z, Fuel, customized, plate, IsViewing, enginehealth, bodyhealth)
  if DoesEntityExist(spawningVeh) then
    DeleteEntity(spawningVeh)
  end
	local car = GetHashKey(vehicle)
	local customized = json.decode(customized)
	Citizen.CreateThread(function()			
		Citizen.Wait(100)
        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end
        spawningVeh = CreateVehicle(car, x, y, z, true, false)
        SetModelAsNoLongerNeeded(car)
        DecorSetBool(spawningVeh, "PlayerVehicle", true)
        SetVehicleOnGroundProperly(spawningVeh)
        SetVehicleDirtLevel(spawningVeh, 0.0)
        SetEntityInvincible(spawningVeh, false) 
        SetVehicleNumberPlateText(spawningVeh, plate)
        SetVehicleProps(spawningVeh, customized)
        TriggerEvent("keys:addNew",spawningVeh, plate)
        SetVehicleHasBeenOwnedByPlayer(spawningVeh,true)
        local id = NetworkGetNetworkIdFromEntity(spawningVeh)
        SetNetworkIdCanMigrate(id, true)
        if not IsViewing then    
            CurrentDisplayVehicle = nil
        end
    end)
end

function SetVehicleProps(veh, customized)
  SetVehicleModKit(veh, 0)
  if customized then
      
      SetVehicleWheelType(veh, customized.wheeltype)
      SetVehicleNumberPlateTextIndex(veh, 3)

      for i = 0, 16 do
          SetVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 17, 22 do
          ToggleVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 23, 24 do
          local isCustom = customized.mods[tostring(i)]
          if (isCustom == nil or isCustom == "-1" or isCustom == false or isCustom == 0) then
              isSet = false
          else
              isSet = true
          end
          SetVehicleMod(veh, i, customized.mods[tostring(i)], isCustom)
      end

      for i = 23, 48 do
          SetVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 0, 3 do
          SetVehicleNeonLightEnabled(veh, i, customized.neon[tostring(i)])
      end

      if customized.extras ~= nil then
          for i = 1, 12 do
              local onoff = tonumber(customized.extras[i])
              if onoff == 1 then
                  SetVehicleExtra(veh, i, 0)
              else
                  SetVehicleExtra(veh, i, 1)
              end
          end
      end

      if customized.oldLiveries ~= nil and customized.oldLiveries ~= 24  then
          SetVehicleLivery(veh, customized.oldLiveries)
      end

      if customized.plateIndex ~= nil and customized.plateIndex ~= 4 then
          SetVehicleNumberPlateTextIndex(veh, customized.plateIndex)
      end

      -- Xenon Colors
      SetVehicleXenonLightsColour(veh, (customized.xenonColor or -1))
      SetVehicleColours(veh, customized.colors[1], customized.colors[2])
      SetVehicleExtraColours(veh, customized.extracolors[1], customized.extracolors[2])
      SetVehicleNeonLightsColour(veh, customized.lights[1], customized.lights[2], customized.lights[3])
      SetVehicleTyreSmokeColor(veh, customized.smokecolor[1], customized.smokecolor[2], customized.smokecolor[3])
      SetVehicleWindowTint(veh, customized.tint)
      SetVehicleInteriorColour(veh, customized.dashColour)
      SetVehicleDashboardColour(veh, customized.interColour)
  else

      SetVehicleColours(veh, 0, 0)
      SetVehicleExtraColours(veh, 0, 0)

  end
end

function findVehFromPlateAndLocate(plate)

  for ind, value in pairs(vehicles) do

    vehPlate = value.license_plate
  if vehPlate == plate then
    coordlocation = value.coords
    SetNewWaypoint(coordlocation[1], coordlocation[2], coordlocation[3])
    end
  end
end



function Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end



local recentspawnrequest = false
function findVehFromPlateAndSpawn(plate)

  if IsPedInAnyVehicle(PlayerPedId(), false) then
    return
  end

  for ind, value in pairs(vehicles) do

    vehPlate = value.license_plate
    if vehPlate == plate then
      state = value.vehicle_state
      coordlocation = value.coords

      if #(vector3(coordlocation[1],coordlocation[2],coordlocation[3]) - GetEntityCoords(PlayerPedId())) < 10.0 and state == "Out" then

        local DoesVehExistInProximity = CheckExistenceOfVehWithPlate(vehPlate)

        if not DoesVehExistInProximity and not recentspawnrequest then
          recentspawnrequest = true
          TriggerServerEvent("garages:phonespawn",vehPlate)
          Wait(10000)
          recentspawnrequest = false
        else
          print("Found vehicle already existing!")
        end

      end

    end

  end

end

RegisterNetEvent("phone:SpawnVehicle")
AddEventHandler('phone:SpawnVehicle', function(vehicle, plate, customized, state, Fuel, coordlocation)
  TriggerEvent("garages:SpawnVehicle", vehicle, plate, customized, state, Fuel, coordlocation)
end)




Citizen.CreateThread(function()
  local invehicle = false
  local plateupdate = "None"
  local vehobj = 0
  while true do
      Wait(1000)
      if not invehicle and IsPedInAnyVehicle(PlayerPedId(), false) then
        local playerPed = PlayerPedId()
        local veh = GetVehiclePedIsIn(playerPed, false)
          if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            vehobj = veh
            local checkplate = GetVehicleNumberPlateText(veh)
            invehicle = true
            plateupdate = checkplate
            local coords = GetEntityCoords(vehobj)
            coords = { coords["x"], coords["y"], coords["z"] }
            TriggerServerEvent("vehicle:coords",plateupdate,coords)
          end
      end
      if invehicle and not IsPedInAnyVehicle(PlayerPedId(), false) then
        local coords = GetEntityCoords(vehobj)
        coords = { coords["x"], coords["y"], coords["z"] }
        TriggerServerEvent("vehicle:coords",plateupdate,coords)
        invehicle = false
        plateupdate = "None"
        vehobj = 0
      end  
  end
end)



function CheckExistenceOfVehWithPlate(platesent)
  local playerped = PlayerPedId()
  local playerCoords = GetEntityCoords(playerped)
  local handle, scannedveh = FindFirstVehicle()
  local success
  local rped = nil
  local distanceFrom
  repeat
      local pos = GetEntityCoords(scannedveh)
      local distance = #(playerCoords - pos)
        if distance < 50.0 then
          local checkplate = GetVehicleNumberPlateText(scannedveh)
          if checkplate == platesent then
            return true
          end
        end
      success, scannedveh = FindNextVehicle(handle)
  until not success
  EndFindVehicle(handle)
  return false
end

local currentVehicles = {}

RegisterNetEvent("phone:Garage")
AddEventHandler("phone:Garage", function(vehs)
  vehicles = vehs
  local showCarPayments = false
  local rankCarshop = exports["isPed"]:GroupRank("car_shop")
  local rankImport = exports["isPed"]:GroupRank("illegal_carshop")
  local job = exports["isPed"]:isPed("myjob")


  if rankCarshop > 0 or rankImport > 0 or job == "judge" or job == "police" or job == "sheriff" or job == "state"then
    showCarPayments = true
  end

  local parsedVehicleData = {}
  for ind, value in pairs(vehs) do
    enginePercent = value.engine_damage / 10
    bodyPercent = value.body_damage / 10
    vehName = value.name
    vehPlate = value.license_plate
    currentGarage = value.current_garage
    state = value.vehicle_state
    fuel = value.fuel
    model = value.model
 
    table.insert(parsedVehicleData, {
      name = vehName,
      plate = vehPlate,
      garage = currentGarage,
      state = state,
      enginePercent = enginePercent,
      bodyPercent = bodyPercent,
      payments = value.payments_left, -- total payments left
      lastPayment = value.last_payment, -- Days left
      amountDue = value.financed, -- amount due
      coordlocation = coordlocation,
      fuel = fuel,
      model = model
    })

    for i = 1, #parsedVehicleData do
      if parsedVehicleData[i].plate == vehSpawnPlate and canSpawnVehs and canSpawnDist < 5 then
        parsedVehicleData[i] = {
          name = parsedVehicleData[i].name,
          plate = parsedVehicleData[i].plate,
          garage = parsedVehicleData[i].garage,
          state = parsedVehicleData[i].state,
          enginePercent = parsedVehicleData[i].enginePercent,
          bodyPercent = parsedVehicleData[i].bodyPercent,
          payments = parsedVehicleData[i].payments,
          lastPayment = parsedVehicleData[i].lastPayment,
          amountDue = parsedVehicleData[i].amountDue,
          coordlocation = parsedVehicleData[i].coordlocation,
          fuel = parsedVehicleData[i].fuel,
          model = parsedVehicleData[i].model,
          canSpawn = 1 
      }
      end
      
      
    end
  end
  
  SendNUIMessage({ openSection = "Garage", showCarPaymentsOwed = showCarPayments, vehicleData = parsedVehicleData})
end)



local pickuppoints = {
  [1] =  { ['x'] = 923.94,['y'] = -3037.88,['z'] = 5.91,['h'] = 270.81, ['info'] = ' Shipping Container BMZU 822693' },
  [2] =  { ['x'] = 938.02,['y'] = -3026.28,['z'] = 5.91,['h'] = 265.85, ['info'] = ' Shipping Container BMZU 822693' },
  [3] =  { ['x'] = 1006.17,['y'] = -3028.94,['z'] = 5.91,['h'] = 269.31, ['info'] = ' Shipping Container BMZU 822693' },
  [4] =  { ['x'] = 1020.42,['y'] = -3044.91,['z'] = 5.91,['h'] = 87.37, ['info'] = ' Shipping Container BMZU 822693' },
  [5] =  { ['x'] = 1051.75,['y'] = -3045.09,['z'] = 5.91,['h'] = 268.37, ['info'] = ' Shipping Container BMZU 822693' },
  [6] =  { ['x'] = 1134.92,['y'] = -2992.22,['z'] = 5.91,['h'] = 87.9, ['info'] = ' Shipping Container BMZU 822693' },
  [7] =  { ['x'] = 1149.1,['y'] = -2976.06,['z'] = 5.91,['h'] = 93.23, ['info'] = ' Shipping Container BMZU 822693' },
  [8] =  { ['x'] = 1121.58,['y'] = -3042.39,['z'] = 5.91,['h'] = 88.49, ['info'] = ' Shipping Container BMZU 822693' },
  [9] =  { ['x'] = 830.58,['y'] = -3090.46,['z'] = 5.91,['h'] = 91.15, ['info'] = ' Shipping Container BMZU 822693' },
  [10] =  { ['x'] = 830.81,['y'] = -3082.63,['z'] = 5.91,['h'] = 271.61, ['info'] = ' Shipping Container BMZU 822693' },
  [11] =  { ['x'] = 909.91,['y'] = -2976.51,['z'] = 5.91,['h'] = 271.02, ['info'] = ' Shipping Container BMZU 822693' },
}


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
blip = 0

function CreateBlip(location)
    DeleteBlip()
    blip = AddBlipForCoord(location["x"],location["y"],location["z"])
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pick Up")
    EndTextCommandSetBlipName(blip)
end
function DeleteBlip()
  if DoesBlipExist(blip) then
    RemoveBlip(blip)
  end
end

function refreshmail()
    lstnotifications = {}
    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }
        lstnotifications[#lstnotifications+1]= message2
    end
    SendNUIMessage({openSection = "notifications", list = lstnotifications})
end

local weaponList = {
  [1] = 324215364,
  [2] = 736523883,
  [3] = 4024951519,
  [4] = 1627465347,
}

local weaponListSmall = {
  [1] = 2017895192,
  [2] = 584646201,
  [3] = 3218215474,
}

local luckList = {
  [1] =  "extended_ap",
  [2] =  "extended_sns",
  [3] =  "extended_micro",
  [4] =  "rifleammo",
  [5] =  "heavyammo",
  [6] =  "lmgammo",
}

-- RegisterNUICallback('btnDelivery', function()
--   TriggerEvent("trucker:confirmation")
-- end)

-- RegisterNUICallback('btnPackages', function()
--   insideDelivers = true
--   TriggerEvent("Trucker:GetPackages")
-- end)

-- RegisterNUICallback('btnTrucker', function()
--   TriggerEvent("Trucker:GetJobs")
-- end)

-- RegisterNUICallback('resetPackages', function()
--   insideDelivers = false
-- end)


-- RegisterNetEvent("phone:trucker")
-- AddEventHandler("phone:trucker", function(jobList)

--   local deliveryObjects = {}
--   for i, v in pairs(jobList) do
--     local nameTag = ""
--     local itemTag
--     local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(v.pickup[1], v.pickup[2], v.pickup[3], currentStreetHash, intersectStreetHash)
--     local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
--     local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)

--     local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
--     local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
--     local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)
--     if v.active == 0 then
--         table.insert(deliveryObjects, {
--           targetStreet = currentStreetName2,
--           jobId = v.id,
--           jobType = v.JobType
--         })
--     end
--   end 
--   SendNUIMessage({
--     openSection = "deliveryJob",
--     deliveries = deliveryObjects
--   })
    
-- end)

-- local requestHolder = 0

-- RegisterNetEvent("phone:packages")
-- AddEventHandler("phone:packages", function(packages)
--   while insideDelivers do
--     if requestHolder ~= 0 then
--       SendNUIMessage({
--         openSection = "packagesWith"
--       })
--     else
--       SendNUIMessage({
--         openSection = "packages"
--       })
--     end
    
    
--     for i, v in pairs(packages) do
--       if GetPlayerServerId(PlayerId()) == v.source then
--         local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
--         local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
--         local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)

--         SendNUIMessage({openSection = "addPackages", street2 = currentStreetName2, jobId = v.id ,distance = getDriverDistance(v.driver , v.drop)})
--       end
--     end 
--     Wait(4000)
--   end
-- end)


-- RegisterNetEvent("phone:OwnerRequest")
-- AddEventHandler("phone:OwnerRequest", function(holder)
--   requestHolder = holder
-- end)

-- RegisterNUICallback('btnRequest', function()
--   TriggerServerEvent("trucker:confirmRequest",requestHolder)
--   requestHolder = 0
-- end)




-- function getDriverDistance(driver , drop)
--   local dist = 0

--   local ped = GetPlayerPed(value)
--   if driver ~= 0 then
--     local current = #(vector3(drop[1],drop[2],drop[3]) - GetEntityCoords(ped))
--     if current < 15 then
--       dist = "Driver at store"
--     else
--       dist = current
--       dist = math.ceil(dist)
--     end
    
--   else
--     dist = "Waiting for driver"
--   end

--   return dist
-- end

RegisterNUICallback('selectedJob', function(data, cb)
    TriggerEvent("Trucker:SelectJob",data)
end)



-- gurgleList = {}
-- RegisterNetEvent('websites:updateClient')
-- AddEventHandler('websites:updateClient', function(passedList)
--   gurgleList = passedList

--   local gurgleObjects = {}

--   if not guiEnabled then
--     return
--   end

--   for i = 1, #gurgleList do
--     table.insert(gurgleObjects, {
--       webTitle = gurgleList[i]["Title"], 
--       webKeywords = gurgleList[i]["Keywords"], 
--       webDescription = gurgleList[i]["Description"] 
--     })
--   end

--   SendNUIMessage({ openSection = "gurgleEntries", gurgleData = gurgleObjects})
-- end)

function DrawRadioChatter(x,y,z, text,opacity)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if opacity > 215 then
      opacity = 215
    end
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, opacity)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
local activeMessages = 0

RegisterNetEvent('radiotalkcheck')
AddEventHandler('radiotalkcheck', function(args,senderid)

  if hasRadio() and radioChannel ~= 0 then
    randomStatic(true)

    local ped = GetPlayerPed( -1 )

      if ( DoesEntityExist( ped ) and not IsEntityDead( ped )) then

        loadAnimDict( "random@arrests" )

        TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )

        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
      end


    TriggerServerEvent("radiotalkconfirmed",args,senderid,radioChannel)
    Citizen.Wait(2500)
    ClearPedSecondaryTask(PlayerPedId())
  end

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function randomStatic(loud)
  local vol = 0.05
  if loud then
    vol = 0.9
  end
  local pickS = math.random(4)
  if pickS == 4 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic1",vol)
  elseif pickS == 3 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic2",vol)
  elseif pickS == 2 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic3",vol)
  else
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",vol)
  end

end

RegisterNetEvent('radiotalk')
AddEventHandler('radiotalk', function(args,senderid,channel)

    local senderid = tonumber(senderid)

    table.remove(args,1)
    local radioMessage = ""
    for i = 1, #args do
        radioMessage = radioMessage .. " " .. args[i]
    end

    if channel == radioChannel and hasRadio() and radioMessage ~= nil then
      -- play radio click sound locally.
      TriggerEvent('chatMessage', "RADIO #" .. channel, 3, radioMessage, 5000)
      randomStatic(true)

      local radioMessage = ""
      for i = 1, #args do
        if math.random(50) > 25 then
          radioMessage = radioMessage .. " " .. args[i]
        else
          radioMessage = radioMessage .. " **BZZZ** "
        end
      end
      TriggerServerEvent("radiochatter:server",radioMessage)
    end
end)

RegisterNetEvent('radiochatter:client')
AddEventHandler('radiochatter:client', function(radioMessage,senderid)

    local senderid = tonumber(senderid) 
    local location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
    local dst = #(GetEntityCoords(PlayerPedId()) - location)
    activeMessages = activeMessages + 0.1
    if dst < 5.0 then
      -- play radio static sound locally.
      local counter = 350
      local msgZ = location["z"]+activeMessages
      if PlayerPedId() ~= GetPlayerPed(GetPlayerFromServerId(senderid)) then
        randomStatic(false)
        while counter > 0 and dst < 5.0 do
          location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
          dst = #(GetEntityCoords(PlayerPedId()) - location)
          DrawRadioChatter(location["x"],location["y"],msgZ, "Radio Chatter: " .. radioMessage, counter)
          counter = counter - 1
          Citizen.Wait(1)
        end
      end
    end
    activeMessages = activeMessages - 0.1 
end)


RegisterNetEvent('radiochannel')
AddEventHandler('radiochannel', function(chan)
  local chan = tonumber(chan)
  if hasRadio() and chan < 1000 and chan > -1 then
    radioChannel = chan
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.4)
    -- TriggerEvent('chatMessage', "RADIO CHANNEL " .. radioChannel, 3, "Active", 5000)
  end
end)

RegisterNetEvent('canPing')
AddEventHandler('canPing', function(target)
  if hasPhone() and not isDead then
    local crds = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("requestPing", target, crds["x"],crds["y"],crds["z"])
  else
    TriggerEvent("DoLongHudText","You need a phone to use GPS!",2)
  end
end)

local pingcount = 0
local currentblip = 0
local currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
RegisterNetEvent('allowedPing')
AddEventHandler('allowedPing', function(x,y,z,src,name)
  if pingcount > 0 then
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you already have one in process!",2)
    return
  end
  
  if hasPhone() and not isDead then
    pingcount = 5
    currentping = { ["x"] = x,["y"] = y,["z"] = z, ["src"] = src }
    while pingcount > 0 do
      TriggerEvent("DoLongHudText",name .. " has given you a ping location, type /pingaccept to accept",1)
      Citizen.Wait(5000)
      pingcount = pingcount - 1
    end
  else
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you have no phone!",2)
  end
  pingcount = 0
  currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
end)


RegisterNetEvent("phoneEnabled")
AddEventHandler("phoneEnabled", function(phoneopensent)
  phoneopen = phoneopensent
end)

RegisterNUICallback('sethGps', function(data)
 local house = exports["fa-housing"]:retrieveHousingTableMapped()
  for i,k in pairs(house) do

    if k.id == data.hid then
      if DoesBlipExist(currentblip) then
        RemoveBlip(currentblip)
      end
      currentblip = AddBlipForCoord(k.coords["x"], k.coords["y"], k.coords["z"])
      SetBlipSprite(currentblip, 40)
      SetBlipAsShortRange(currentblip, false)
      BeginTextCommandSetBlipName("STRING")
      SetBlipColour(currentblip, 4)
      SetBlipScale(currentblip, 1.2)
      AddTextComponentString("House GPS")
      EndTextCommandSetBlipName(currentblip)
      TriggerEvent("DoLongHudText","House GPS Set to your map.", 1)
      pingcount = 0
      Citizen.Wait(60000)
      if DoesBlipExist(currentblip) then
        RemoveBlip(currentblip)
      end
    end
  end
 
end)

RegisterNUICallback('unlockHouses', function(data)
  print('HID',data.hid, data.penisfuck)
  local hId = data.hid
  local statuus = data.penisfuck
  if statuus == "Unlock" then
    --TriggerEvent('fa-phone:h-Lock', hId,"Lock")
  else
    --TriggerEvent('fa-phone:h-Lock', hId,"Unlock")
  end
  TriggerServerEvent('fa-phone:house:status',hId,statuus)
  Wait(200)
  TriggerEvent('updateUIHousing')
end)

RegisterNetEvent("fa-phone:h-Lock", function(hId, status)
  TriggerServerEvent("fa-phone:h-Lock:sv", hId, status)

end)

RegisterNUICallback('apartment:2', function()
  print('apartment:upgrades2')
  TriggerEvent('apartment:upgrades2')
end)

RegisterNUICallback('apartment:3', function()
  print('apartment:upgrades3')
  TriggerEvent('apartment:upgrades3')
end)

RegisterNUICallback('editHousingOwn', function()
  -- if exports['fa-housing']:isNearProperty() then
    if exports["fa-housing"]:canEdit() then
      print("HELLO!")
      local isComplete, _propertyID, dist, zone = exports['fa-housing']:findClosetedPerson()
      TriggerEvent("fa-housing:editOptions",{action = "enter", propertyId = _propertyID})
    else
      SendNUIMessage({
        openSection = "noProperty"
      })
    end
  -- end
end)

RegisterNUICallback('giveAccess', function(data)
  local complete = RPC.execute('fa-phone:GiveAccess', data.hid,data.cid)
   
  if not complete then
    TriggerEvent("DoLongHudText", "You already gave a key to this person",2)
    return
  end
  TriggerEvent('DoLongHudText', 'You successfully give a key')
end)

RegisterNUICallback('houseAccess', function(data)
  print("DATA HID HERE", data.hid)
  local access = RPC.execute('fa-phone:getAccessHouse', data.hid)
  local data = {
      {
        title = "Close",
        action = "fa-housing:close_access",
        key = {},
    },
  }
  local player = {}
  for i,k in pairs(access) do
    data[#data + 1] = {
          title = k.name,
          description = "House: "..k.house.." CID:"..k.cid,
          key = {"lockdown"},
          -- action = "fa-ui:apartmentsContext"
          children = {
            {
                title = "Remove Key",
                description = "Remove Access.",
                params = {k.cid, k.house},
                action = "fa-ui:apartmentsContext"
            }
          }
      }
  end
  exports["fa-contexts"]:showContext(data)
end)

AddEventHandler("fa-housing:close_access", function()
  exports["fa-contexts"]:hideContext()
end)

AddEventHandler('fa-ui:apartmentsContext', function(data)
  RPC.execute("fa-phone:removeKeys",data[2],data[1])
  exports["fa-ui"]:hideContext(data)
end)

RegisterNetEvent('acceptPing')
AddEventHandler('acceptPing', function()
  if pingcount > 0 then
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
    currentblip = AddBlipForCoord(currentping["x"], currentping["y"], currentping["z"])
    SetBlipSprite(currentblip, 280)
    SetBlipAsShortRange(currentblip, false)
    BeginTextCommandSetBlipName("STRING")
    SetBlipColour(currentblip, 4)
    SetBlipScale(currentblip, 1.2)
    AddTextComponentString("Accepted GPS Marker")
    EndTextCommandSetBlipName(currentblip)
    TriggerEvent("DoLongHudText","Their GPS ping has been marked on the map", 1)
    TriggerServerEvent("pingAccepted",currentping["src"])
    pingcount = 0
    Citizen.Wait(60000)
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
  end
end)

function isRealEstateAgent()
  if GroupRank("real_estate") > 0 then
    return true
  else
    return false
  end
end

function hasDecrypt2()
    if exports["fa-inventory"]:hasEnoughOfItem("vpnxj",1,false,true) then
      return true
    else
      return false
    end
end

function hasTrucker()
    if exports["fa-base"]:getModule("LocalPlayer"):getVar("job") == "trucker"  then
      return true
    else
      return false
    end
end

function hasDecrypt()
    if exports["fa-inventory"]:hasEnoughOfItem("decrypterenzo",1,false) or exports["fa-inventory"]:hasEnoughOfItem("decryptersess",1,false) or exports["fa-inventory"]:hasEnoughOfItem("decrypterfv2",1,false) and not exports["isPed"]:isPed("disabled") or exports["fa-inventory"]:hasEnoughOfItem(80,1,false) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function hasDevice()
    if exports["fa-inventory"]:hasEnoughOfItem("mk2usbdevice",1,false) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function hasPhone()
    if
      (
      (exports["fa-inventory"]:hasEnoughOfItem("mobilephone",1,false) or 
      exports["fa-inventory"]:hasEnoughOfItem("stoleniphone",1,false) or 
      exports["fa-inventory"]:hasEnoughOfItem("stolens8",1,false) or
      exports["fa-inventory"]:hasEnoughOfItem("stolennokia",1,false) or
      exports["fa-inventory"]:hasEnoughOfItem("stolenpixel3",1,false) or
      exports["fa-inventory"]:hasEnoughOfItem("assphone",1,false) or
      exports["fa-inventory"]:hasEnoughOfItem("boomerphone",1,false))
      and not exports["isPed"]:isPed("disabled") and not exports["isPed"]:isPed("handcuffed")
      ) 
    then
      return true
    else
      return false
    end
end

function hasRadio()
    if (exports["fa-inventory"]:hasEnoughOfItem("radio",1,false) or exports["fa-inventory"]:hasEnoughOfItem("pdradio",1,false)) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function isThisPM() 
  if exports['isPed']:isPed("cid") == 867 then
    return true
  end
  return false
end

local isBurner, pCitizenID
function openGui(isBurner, cid)

   TriggerEvent("fa-spawn:phonerefresh") --Refreshes jobs
    if isBurner == nil then isBurner = false else isBurner = true end
    if cid == nil then pCitizenID = exports['isPed']:isPed("cid") else pCitizenID = cid end

    

    if not isBurner then
      toggleBurnerMode(false)
    else
      toggleBurnerMode(true)
    end
  pPhoneOpen = true
  if hasPhone() then
    GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
    guiEnabled = true
    SetNuiFocus(false,false)
    SetNuiFocus(true,true)

    local isREAgent = false
    if isRealEstateAgent() then
      isREAgent = true
    end

    local device = false
    if hasDevice() then
      device = true
    end

    local decrypt = false
    if hasDecrypt() then
      decrypt = true
    end

    local decrypt2 = false
    if hasDecrypt2() then
      decrypt2 = true
    end

    local trucker = false
    if hasTrucker() then
      trucker = true
    end 
    local canCreateRaces = false
    local hasUsbRaces = false
    local hasAlias = false
    if canCreateRace() then
      canCreateRaces = true
    end

    if canOpenRaceApp() then
      hasUsbRaces = true
    end
    
    if canJoinRaces() then
      hasAlias = true
    end
    TriggerServerEvent('bank:get:balance')
    local near = exports['fa-housing']:isNearProperty()
    local house = RPC.execute("fa-phone:getHouses")
    -- print("NEAR HOUSE?",near,json.encode(house))
    local phoneBGrep = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")

    if phoneBGrep == " " or phoneBGrep =="" or phoneBGrep == nil then
      phoneBGrep = ""
    else
      phoneBGrep = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")
    end
    
    local model = GetResourceKvpInt(exports['isPed']:isPed('cid').."-pmodel")
    if model == 1 then
      SendNUIMessage({
        pModel = true,
        setModel = true,
      })
    else
      SendNUIMessage({
        pModel = true,
        setModel = false,
      })
    end

    SendNUIMessage({
      openPhone = true,
      wifiZone = nearWifiZone, 
      pOpenPhone = true, 
      hasDevice = device, 
      hasDecrypt = decrypt, 
      pNum = RPC.execute("fa-phone:getPhoneNumber"),
      hasDecrypt2 = decrypt2,
      isPM = isThisPM(),
      hasTrucker = trucker, 
      bgPhone = phoneBG, 
      isRealEstateAgent = isREAgent, 
      playerId = GetPlayerServerId(PlayerId()),
      wallpaper = phoneBGrep,
      unrmsg = unReadMsg, 
      unrTwat = unReadTwt, 
      unrEmail = unReadEmail, 
      isBurner = isBurner,
      citizenID = pCitizenID,
      sanitation = sanitation,
      housing = house,
      nearProperty = near,
      hasUsbRace = hasUsbRaces,
      canCreateRace = exports["fa-inventory"]:hasEnoughOfItem("racingusb0", 1),
      hasAlias = hasAlias
    })
    TriggerEvent('phoneEnabled',true)
    TriggerEvent('animation:sms',true)
    -- TriggerServerEvent('fa-phone:grabWallpaper')
        --TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1)
        
    -- If this is the first time we've opened the phone, load all contacts
    
    lstContacts = {}
    if isBurner then
        TriggerServerEvent('phone:getContactsBurner', pCitizenID)
    else
        TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
    end
    doTimeUpdate()
  else
    closeGui()
    if not exports["isPed"]:isPed("disabled") then
      TriggerEvent("DoLongHudText","You do not have a phone.",2)
    else
      TriggerEvent("DoLongHudText","You cannot use your phone right now.",2)
    end
  end
  SendNUIMessage({
    openSection = "checkJobAbdul",
    isTaxiDriver = isDudeQuallied("taxi")
  })
end

RegisterNUICallback('btnPagerType', function(data, cb)
  TriggerServerEvent("secondaryjob:ServerReturnDate")
end)
local jobnames = {
  ["taxi"] = "Taxi Driver",
  ["towtruck"] = "Tow Truck Driver",
  ["trucker"] = "Delivery Driver",
}

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)


function miTrabajo()
    return exports['isPed']:isPed('job')
end


function canCreateRace()
  local racingCreateUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb0")
  local has_usb_racing_create = racingCreateUsbItem ~= nil and racingCreateUsbItem.quality > 0
  if has_usb_racing_create then
    return true
  else
    return false
  end
end

function canOpenRaceApp()
  local racingUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb2")
  local has_usb_racing = racingUsbItem ~= nil and racingUsbItem.quality > 0
  -- print("FUCKING MOTHER SHIT", has_usb_racing)
  if has_usb_racing then
    return true
  else
    return false
  end
end

function canJoinRaces()
  local hasRaceUsbAndAlias = exports["fa-racing"]:getHasRaceUsbAndAlias()
  -- print("CAN JOIN",hasRaceUsbAndAlias.racingAlias)
  if hasRaceUsbAndAlias.racingAlias ~= nil then
    hasAlias = true
  end
end

-- Close Gui and disable NUI
function closeGui()
  TriggerEvent("closeInventoryGui")
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  TriggerEvent('animation:sms',false)
  TriggerEvent('phoneEnabled',false)
  -- TriggerEvent('fa-phone:UpdateStatePhone')
  pPhoneOpen = false
  insideDelivers = false
end

-- RegisterNetEvent('fa-phone:UpdateStatePhone')
-- AddEventHandler('fa-phone:UpdateStatePhone', function()
--     Wait(5)
--     print(callStatus, isCallInProgress)
--     if callStatus == isCallInProgress then 
--       print("PHONE MEDIO 3")
--       SendNUIMessage({openSection = "phonemedio"}) 
--     end
-- end)

function getCardinalDirectionFromHeading()
  local heading = GetEntityHeading(PlayerPedId())
  if heading >= 315 or heading < 45 then
      return "North Bound"
  elseif heading >= 45 and heading < 135 then
      return "West Bound"
  elseif heading >= 135 and heading < 225 then
      return "South Bound"
  elseif heading >= 225 and heading < 315 then
      return "East Bound"
  end
end

function closeGui2()
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
end

local mousenumbers = {
  [1] = 1,
  [2] = 2,
  [3] = 3, 
  [4] = 4, 
  [5] = 5, 
  [6] = 6, 
  [7] = 12, 
  [8] = 13, 
  [9] = 66, 
  [10] = 67, 
  [11] = 95, 
  [12] = 96,   
  [13] = 97,   
  [14] = 98,
  [15] = 169,
   [16] = 170,
}



-- Opens our phone
RegisterNetEvent('phoneGui2')
AddEventHandler('phoneGui2', function()
  openGui()
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('phone:close')
AddEventHandler('phone:close', function(number, message)
  closeGui()
end)



function testfunc()

end
RegisterNetEvent("TokoVoip:UpVolume");
AddEventHandler("TokoVoip:UpVolume", setVolumeUp);

RegisterNUICallback('updateMyWallpaper', function(data, cb)
  wallPaper = ""
  Wait(5)
  TriggerEvent('fa-phone:grabBackground', data.name .."?auto=compress&cs=tinysrgb&h=350")
  -- TriggerServerEvent("phone:saveWallpaper",exports['isPed']:isPed('cid'), data.name .."?auto=compress&cs=tinysrgb&h=350")
  -- SetResourceKvp(exports['isPed']:isPed('cid')"-bg"
  cb('ok')
end)

RegisterNetEvent("pass:coords:vehicle")
AddEventHandler("pass:coords:vehicle", function(plate,coords)
  -- print(coords,plate)
  vehSpawnPlate = plate
  vehCoords = coords
  local VehicleCoords = coords
  local car = AddBlipForCoord(VehicleCoords[1],VehicleCoords[2],VehicleCoords[3])
  SetBlipSprite(car, 225)
  SetBlipScale(car, 1.2)
  SetBlipAsShortRange(car, false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Lost Vehicle")
  EndTextCommandSetBlipName(car)
  TriggerEvent("DoLongHudText", "Vehicle marked on the map!")
  trackVehicle = true
  Citizen.CreateThread(function()
    while trackVehicle do
      
      local dist = #(vector3(VehicleCoords[1],VehicleCoords[2],VehicleCoords[3]) - GetEntityCoords(PlayerPedId()))
      canSpawnVehs = true
      canSpawnDist = dist
      drawMarker = false
      -- spawnStatus = true
      -- spawnStatus(true)
      if dist <= 10 and drawMarker == false and canSpawnVehs then
        -- print("DRAW MARKER")
        drawMarker = true
        DrawMarker(36,VehicleCoords[1],VehicleCoords[2],VehicleCoords[3]+0.5, 0, 0, 0, 0, 0, 0, 1.000,2.5001,1.3001, 125, 218, 19, 200, 1, 0, 0, 0)
      end
      Wait(1)
      if dist < 5.0 then
        RemoveBlip(car)
        insideTrack = true
      end
      if dist > 10.0 and insideTrack then
        canSpawnVehs = false
        insideTrack = false
        return
      end
      if dist > 10 and insideTrack then
        drawMarker = false
        canSpawnVehs = false
      end
    end
  end)
  -- if displaymarker then
  --   print("OK")
  -- else
  --   print("NOK")
  -- end
end)

curNotifications = {}
casinoNotification = {}

RegisterNetEvent('phone:casino_paid')
AddEventHandler('phone:casino_paid', function(message)
  if exports['fa-phone']:pOpen() == false then 
    SendNUIMessage({openSection = "emailnotify", pEHandle = 'Payment Received.', pEMessages = message})
    SendNUIMessage({openSection = "phonemedio", timeout = "5200", pOpen = exports['fa-phone']:pOpen()}) 
  end
  casinoNotification[#casinoNotification+1] = { ["name"] = name, ["message"] = message, ['time'] = time }
end)

RegisterNetEvent("phone:sendThePM", function(name, msg)
  if exports["fa-inventory"]:hasEnoughOfItem("thepmdongle",1,false,true) then
    TriggerEvent("phone:addnotification", name, msg)
  end
end)

RegisterNetEvent('phone:addnotification')
AddEventHandler('phone:addnotification', function(name, message)
  TriggerEvent('addUnreadEmail')
    -- SendNUIMessage({openSection = "emailnotify", pEHandle = 'Email Received.', pEMessages = message})
    if phasPhone() then
      phoneNotification("email",message,"Email Received")
    end
    curNotifications[#curNotifications+1] = { ["name"] = name, ["message"] = message, ['time'] = time }
end)

function createGeneralAreaBlip(alertX, alertY, alertZ)
  local genX = alertX + math.random(-50, 50)
  local genY = alertY + math.random(-50, 50)
  local alertBlip = AddBlipForRadius(genX,genY,alertZ,75.0) 
  SetBlipColour(alertBlip,1)
  SetBlipAlpha(alertBlip,80)
  SetBlipSprite(alertBlip,9)
  Wait(60000)
  RemoveBlip(alertBlip)
end

local lastTime = 0;
RegisterNetEvent('phone:triggerPager')
AddEventHandler('phone:triggerPager', function()
  local job = exports["isPed"]:isPed("myjob")
  if job == "doctor" or job == "ems" then
    local currentTime = GetGameTimer()
    if lastTime == 0 or lastTime + (5 * 60 * 1000) < currentTime then
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'pager', 0.4)
      SendNUIMessage({
        openSection = "newpager"
      })
      lastTime = currentTime
    end
  end
end)


local customGPSlocations = {
  [1] = { ["x"] = -318.71209716797, ["y"] = -982.94506835938, ["z"] = 30.644653320312, ["info"] = "Garage C"},
  [2] = { ["x"] = 397.78021240234, ["y"] = -1341.3758544922, ["z"] = 30.947998046875,  ["info"] = "Garage D"},
  [3] = { ["x"] = 637.56024, ["y"] = 178.66734, ["z"] = 96.59333, ["info"] = "Garage F"},
  [4] = { ["x"] = 82.359413146973, ["y"] = 6418.9575195313, ["z"] = 31.479639053345, ["info"] = "Garage G"},
  [5] = { ["x"] = -606.86322021484, ["y"] = -2236.7624511719, ["z"] = 6.0779848098755, ["info"] = "Garage J"},
  [6] = { ["x"] = -70.179389953613, ["y"] = -2004.4139404297, ["z"] = 18.016941070557, ["info"] = "Garage M"},
  [7] = { ["x"] = -70.179389953613, ["y"] = -2004.4139404297, ["z"] = 18.016941070557, ["info"] = "Garage O"},
  [8] = { ["x"] = -338.31619262695, ["y"] = 266.79782104492, ["z"] = 85.741966247559, ["info"] = "Garage P"},
  [9] = { ["x"] = 282.38442, ["y"] = -335.2105, ["z"] =45.043964, ["info"] = "Garage Q"},
  [10] = { ["x"] = 66.215492248535, ["y"] = 13.700443267822, ["z"] = 69.047248840332, ["info"] = "Garage R"},
  [11] = { ["x"] = 217.73326110840, ["y"] = -796.49499511719, ["z"] = 30.780157089233, ["info"] = "Garage T"},
  [12] = { ["x"] = -460.9086, ["y"] = 6028.155, ["z"] = 31.4898, ["info"] = "Garage Sandy Shores"},
  [13] = { ["x"] = 390.263, ["y"] = -1592.808, ["z"] = 28.471, ["info"] = "Garage State Police HQ"},
  [14] = { ["x"] = 447.65, ["y"] = -1021.23, ["z"] = 28.45, ["info"] = "Police Department"},
  [15] = { ["x"] = 570.81, ["y"] = 2729.85, ["z"] = 42.07, ["info"] = "Harmony Garage"},
  [16] = { ["x"] = -1579.01, ["y"] = -889.11, ["z"] = 9.38, ["info"] = "Pier Garage"},
  [17] = { ["x"] = -1312.341, ["y"] = 268.55822, ["z"] = 63.509788, ["info"] = "Richman Garage"},
  [18] = { ["x"] = 332.8747253418, ["y"] = -590.58459472656, ["z"] = 28.369995117188, ["info"] = "Pillbox Garage"},
  [19] = { ["x"] = -589.6055, ["y"] = -230.4849, ["z"] = 36.357944, ["info"] = "Courthouse Garage"},
  [20] = { ["x"] = 886.14569, ["y"] = -0.883835, ["z"] = 78.764961, ["info"] = "Casino Garage"},
  [21] = { ["x"] = -178.99780273438, ["y"] = -1161.1779785156, ["z"] = 80.37109375, ["info"] = "Full Impound Garage"},
  [22] = { ["x"] = -183.688, ["y"] = -1174.41, ["z"] = 22.367254, ["info"] = "Normal Impound Garage"},
  [23] = { ["x"] = -1918.3345, ["y"] = 2056.5771, ["z"] = 140.4659, ["info"] = "Garage Winery"},
  [24] = { ["x"] = -16.4277, ["y"] = -1113.7234, ["z"] = 26.6792, ["info"] = "PDM Garage"},
  [25] = { ["x"] = -1073.61, ["y"] = -1244.61, ["z"] = 5.43, ["info"] = "Hayes Garage"},
  [26] = { ["x"] = -1374.82, ["y"] = -447.65, ["z"] = 34.48, ["info"] = "Car Garage"},
  [27] = { ["x"] = -1165.9855, ["y"] = -888.1172, ["z"] = 14.1170, ["info"] = "BurgerShot Garage"},
  [28] = { ["x"] = 141.2283, ["y"] = -245.1088, ["z"] = 51.5157, ["info"] = "Car Garage"},
  [29] = { ["x"] = 529.3930, ["y"] = -174.7057, ["z"] = 54.4743, ["info"] = "AutoExotics Garage"},
}

local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,houses,rented)

  

  SendNUIMessage({openSection = "GPS"})

  if loadedGPS then

    return

  end

  for i = 1, #customGPSlocations do

    SendNUIMessage({openSection = "AddGPSLocation", info = customGPSlocations[i]["info"], house_id = i, house_type = 69})

    Citizen.Wait(1)

  end



  loadedGPS = true

end)



RegisterNetEvent('GPSLocations')

AddEventHandler('GPSLocations', function()

	if GPSblip ~= nil then

		RemoveBlip(GPSblip)

		GPSblip = nil

	end	

	TriggerEvent("GPSActivated",false)

	TriggerEvent("openGPS",robberycoordsMansions,robberycoords,rentedOffices)

end)



RegisterNUICallback('loadUserGPS', function(data)

     TriggerEvent("GPS:SetRoute",data.house_id,data.house_type)

end)



-- RegisterNUICallback('btnCamera', function()

--   SetNuiFocus(true,true)

-- end)



local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,house,rented)

  -- THIS IS FUCKING PEPEGA TOO.....





  if loadedGPS then

    SendNUIMessage({openSection = "GPS"})

    return

  end

  local mapLocationsObject = {

    custom = { info = customGPSlocations, houseType = 69 },

    mansions = { info = mansions, houseType = 2 },

    houses = { info = house, houseType = 1 },

    rented = { info = rented, houseType = 3 }

  }

  SendNUIMessage({openSection = "GPS", locations = mapLocationsObject })

  loadedGPS = true

end)



RegisterNUICallback('loadGPS', function()

  TriggerEvent("GPSLocations")

end)

RegisterNUICallback('pinger', function()

  SendNUIMessage({openSection = "pinger"})
end)


RegisterNUICallback('btnCamera', function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
end)

RegisterNUICallback('notifications', function()

    lstnotifications = {}

    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }

        lstnotifications[#lstnotifications+1]= message2
    end

    
  SendNUIMessage({openSection = "notifications", list = lstnotifications})

end)


RegisterNUICallback('btnPagerToggle', function()
  TriggerEvent("togglePager")
end)

RegisterNetEvent("house:returnKeys")
AddEventHandler("house:returnKeys", function(pSharedKeys)
  SendNUIMessage({
    openSection = "manageKeys",
    sharedKeys = pSharedKeys
  })
end)


RegisterNetEvent('phone:deleteSMS')
AddEventHandler('phone:deleteSMS', function(id)
  table.remove( lstMsgs, tablefindKeyVal(lstMsgs, 'id', tonumber(id)))
  phoneMsg("Message Removed!")
end)

RegisterNetEvent('fa-spawn:confirm_spawned')
AddEventHandler('fa-spawn:confirm_spawned', function()
  serverSpawn = true
end)



function tablefind(tab,el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end

function tablefindKeyVal(tab,key,val)
  for index, value in pairs(tab) do
    if value ~= nil  and value[key] ~= nil and value[key] == val then
      return index
    end
  end
end


RegisterNetEvent('resetPhone')
AddEventHandler('resetPhone', function()
     SendNUIMessage({
      emptyContacts = true
    })

end)

local weather = ""
RegisterNetEvent("kWeatherSync")
AddEventHandler("kWeatherSync", function(pWeather)
  weather = pWeather
end)

RegisterNUICallback('getWeather', function(data, cb)
  SendNUIMessage({openSection = "weather", weather = weather})
  cb("ok")
end)

function MyPlayerId()
  for i=0,256 do
    if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == PlayerPedId()) then return i end
  end
  return nil
end



function Voip(intPlayer, boolSend)
end

RegisterNetEvent('sendMessagePhoneN')
AddEventHandler('sendMessagePhoneN', function(phonenumberlol)
  TriggerServerEvent('message:tome', phonenumberlol)

  local closestPlayer, closestDistance = GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 5.0 then
    TriggerServerEvent('message:inDistanceZone', GetPlayerServerId(closestPlayer), phonenumberlol)
  else    
  end
end)
function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end
		return closestPlayer, closestDistance, closestPed
	end
end
local wifiPassw = {
  ["wifi1"] = wifipass1,
  ["wifi2"] = wifipass2,
  ["wifi3"] = wifipass3,
  ["wifi4"] = wifipass4,
  ["wifi5"] = wifipass5,
  ["wifi6"] = wifipass6,
  ["wifi7"] = wifipass7
}
Citizen.CreateThread(function()
  while true do
      if nearWifiZone then
        Wait(1000)
          SendNUIMessage({wifiZone = nearWifiZone, enablePassword = enablePassword, materials = materials, wifiPassword = wifiPassw})
      else
        Wait(1000)
        SendNUIMessage({wifiZone = nearWifiZone})
      end
  end
end)

function getBuying()
  return materials
end
exports('getBuying', getBuying)

connectedWifi = false
RegisterNUICallback('connectWifi', function(data, cb)
  connectedWifi = true
    SendNUIMessage({
      darkMarket = true
    })
end)

AddEventHandler("fa-polyzone:enter", function(zone, data)
  if zone == "wifi1" then
    nearWifiZone = true
    materials = zone
    passWifi = 1
  elseif zone == "wifi2" then
    nearWifiZone = true
    materials = zone
    passWifi = 2
  elseif zone == "wifi3" then
    nearWifiZone = true
    materials = zone
    passWifi = 3
  elseif zone == "wifi4" then
    nearWifiZone = true
    materials = zone
    passWifi = 4
  elseif zone == "wifi5" then
    nearWifiZone = true
    materials = zone
    passWifi = 5
  elseif zone == "wifi6" then
    nearWifiZone = true
    materials = zone
    passWifi = 6
  elseif zone == "wifi7" then
    nearWifiZone = true
    materials = zone
    passWifi = 7
  end
end)

AddEventHandler("fa-polyzone:exit", function(zone)
  if zone == "wifi1" or zone == "wifi2" or zone == "wifi3" or zone == "wifi4" or zone == "wifi5" or zone == "wifi6" or zone == "wifi7" then
     nearWifiZone = false
     connectedWifi = false
     SendNUIMessage({darkMarket = false})
  end
end)

RegisterCommand('getcoords',function()
  print(GetEntityCoords(PlayerPedId()))
end)

RegisterNUICallback('jobcenter-setgps', function(data)	
  print('GPSDATA',json.encode(data))
  if data.item == "sanitation" then	
    SetNewWaypoint(-351.433, -1544.22)	
    TriggerEvent("DoLongHudText", "GPS Set!")	
  elseif data.item == "fishing" then	
    SetNewWaypoint(-334.482, 6104.787)	
    TriggerEvent("DoLongHudText", "GPS Set!")	
  elseif data.item == "impound" then	
    SetNewWaypoint(-190.598, -1165.37)	
    TriggerEvent("DoLongHudText", "GPS Set!")	
  elseif data.item == "pdimpound" then	
    SetNewWaypoint(413.7117, -1024.08)	
    TriggerEvent("DoLongHudText", "GPS Set!")	
  elseif data.item == "dodo" then	
    SetNewWaypoint(-439.848, -2795.62)	
    TriggerEvent("DoLongHudText", "GPS Set!")	
    elseif data.item =='darkmarket' then
      SetNewWaypoint(-225.95, -1329.81)	
      TriggerEvent("DoLongHudText", "GPS Set!")	
  end	
  	
  if data.item == "oxy" then	
    TriggerEvent("DoLongHudText", "GPS Set!")  	
    SetNewWaypoint(-1564.08, -440.30)	
    TriggerServerEvent("fa-deliveries:JobCenter")	
  elseif data.item == "chopshop" then	
    SetNewWaypoint(-219.36, -1368.19)	
    TriggerEvent("DoLongHudText", "GPS Set!")  	
  end	
end)

-- RegisterCommand('phone', function(source,args)
--   print('PHONE')
--   SendNUIMessage({
--     openSection = "android"
--   })
-- end)

RegisterCommand('house', function()
  local isComplete, propertyID, dist, zone = exports['fa-housing']:findClosetedPerson()
  print("HOUSING",isComplete, propertyID, dist, zone)
end)
RegisterNUICallback('checkHouse', function()
  
 -- if exports["fa-housing"]:canEdit() then
    TriggerEvent('fa-housing:phone:check')
 -- else
 --   SendNUIMessage({
 --     openSection = "noProperty"
 --   })
  --end
end)

RegisterNUICallback('leaveEditMode', function()
  print("LEAVING EDIT")
  TriggerEvent('fa-housing:editOptions', { action = "exit" })
end)

RegisterNUICallback('openFurnitureUI', function()
  print("OPEN FURNITURE")
  closeGui()
  SendNUIMessage({
    openSection = "forceclose"
  })
  TriggerEvent('fa-housing:editOptions', { action = "furniture" })
end)

RegisterNUICallback('setBackdoorUI', function()
  print("SET BACKDOOR")
  TriggerEvent('fa-housing:editOptions', { action = "backdoor" })
end)

RegisterNUICallback('setWardrobeUI', function()
  print("SET WARDROBE")
  TriggerEvent('fa-housing:editOptions', { action = "wardrobe" })
end)

RegisterNUICallback('setCraftingUI', function()
  print("SET CRAFTING")
  TriggerEvent('fa-housing:editOptions', { action = "crafting" })
end)

RegisterNUICallback('setGarageUI', function()
  print("SET GARAGE")
  TriggerEvent('fa-housing:editOptions', { action = "garage" })
end)

RegisterNUICallback('setStashUI', function()
  print("SET STASH")
  TriggerEvent('fa-housing:editOptions', { action = "stash" })
end)

RegisterNUICallback('sellsHouse', function()
  print("EDITING")
  TriggerEvent('fa-housing:phone:check',"edit")
end)

AddEventHandler('fa-phone:sentHouse', function(hasPrice,id,street,price,category)
  print("SENT HOUSE",isRealEstateAgent(),id,street,price)
  SendNUIMessage({
    openSection = "nearHouse",
    realtor = isRealEstateAgent(),
    hasPrice = hasPrice,
    id = id,
    street = street,
    price = price,
    category = category,
  })
end)

AddEventHandler('fa-phone:editingHouse', function(id,street,price)
  print("EDITING HERE")
  SendNUIMessage({
    openSection = "sellsHouse",
    id = id,
    street = street,
    price = price,
  })
end)

RegisterNUICallback('purchaseHouse', function(data)
  print('data',data.name,data.price)
  if rentEnabled then
      print("can purchase")
   --   TriggerEvent('fa-phone:sentHouse')
      local success, msg = RPC.execute("fa-housing:buy", data.hid, data.price, 0, exports['isPed']:isPed("fullname"))
      TriggerEvent("DoLongHudText",msg,1)
     return
  end
  TriggerEvent('DoLongHudText','Purchasing is not enabled for this house',2)
end)

-- AddEventHandler('fa-phone:noProperty', function()
  
--     SendNUIMessage({
--       openSection = "noProperty"
--     })
-- end)

RegisterNUICallback('editHousePrice', function(data)
  TriggerServerEvent('fa-housing:editPrice', data.hid,data.price)
end)

AddEventHandler('fa-phone:EnableSellRent', function()
    exports['fa-ui']:openApplication('textbox', {
    callbackUrl = 'fa-phone:SellRentEnable',
    -- params = {key = pParams.propertyId},
    key = 1,
    items = {
        {
          icon = "fa-id-card",
          label = "Paypal (Enabled Sell/Rent)",
          name = "sell",
        },
    },
    show = true
  })
end)

RegisterNUICallback('checkNotify', function()
  SendNUIMessage({
    openSection = "checkNotify",
    msg = unReadMsg,
    twt = unReadTwt,
    eml = unReadEmail
  })
end)

RegisterInterfaceCallback("fa-phone:SellRentEnable", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  print('THIS IS ENABLED RENT/SALE FOR PLAYER', data[1].value,json.encode(data))
  TriggerServerEvent('fa-housing:rent_activate_sv', data[1].value)
  exports["fa-ui"]:hideContextMenu()
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

function checkGuiEnable()
  return guiEnabled
end

function GetClosestPlayers(targetVector,dist)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local plyCoords = targetVector
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(distance < dist) then
				valueID = GetPlayerServerId(value)
				closestplayers[#closestplayers+1]= valueID
				closestdistance[#closestdistance+1]= distance
				closestcoords[#closestcoords+1]= {targetCoords["x"], targetCoords["y"], targetCoords["z"]}
				
			end
		end
	end
	return closestplayers, closestdistance, closestcoords
end

-- Paycheck --

RegisterNetEvent('fa-phone:paymentNoti')
AddEventHandler('fa-phone:paymentNoti', function(pAmt, pType)
  phoneNotification("jobactivity", "$"..pAmt..".00 has been added to your "..pType.. " Balance", "Job Center")
end)

RegisterNetEvent('fa-phone:businessRegisterNoti')
AddEventHandler('fa-phone:businessRegisterNoti', function(pBusinessName, pText)
  phoneNotification("charge", pText, pBusinessName)
end)

RegisterNUICallback('phone:sellHouse', function(data)
  RPC.execute('phone:sellProperty', data.houseID)
end)