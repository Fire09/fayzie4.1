local activeDashcams = {}
local currentVehicleNetId = 0
local clonedPedNetId = 0
local currentCoords = nil
local currentDashcam = nil
local goProActivated = false
local staticCam = nil
local goProCameraItems = {
  ["dashcamracing"] = { name = "dashcamracing", type = "racing" },
  ["dashcampd"] = { name = "dashcampd", type = "pd" },
}

RegisterNetEvent("fa-gopros:updateRegisteredCams")
AddEventHandler("fa-gopros:updateRegisteredCams", function(pDashcams)
  activeDashcams = pDashcams
  exports["fa-interface"]:sendAppEvent("gopros", { dashcams = activeDashcams })
end)
-- AddEventHandler("playerSpawned", function()
--   Wait(5550)
--   RPC.execute("fa-gopros:playerSpawnedSendCams")
-- end)

RegisterCommand("fa-gopros:addUserToCamera", function()
  RPC.execute("fa-gopros:addUserToCamera",1,868)
  
  end)
  

--[[
RegisterUICallback("fa-interface:goproChangeSelectedPov", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = 'done' }})
  local activateGoPro = activateGoPro(tonumber(data.netId))
  Wait(600)
  exports["fa-interface"]:sendAppEvent("gopros", { switchingViews = false })
end)
]]

AddEventHandler("fa-interface:application-closed", function(name)
  if name ~= "gopros" then return end
  DoScreenFadeOut(400)
  Wait(400)
  TriggerEvent("fa-casino:inVRHeadset", false)
  deactivateGoPro()
  SetEntityCoords(PlayerPedId(), myDuringChairCoords)
  local clonedPed = 0
  while clonedPed == 0 do
    clonedPed = NetworkGetEntityFromNetworkId(clonedPedNetId)
    Wait(100)
  end
  Sync.DeleteEntity(clonedPed)
  FreezeEntityPosition(PlayerPedId(), false)
  SetEntityCollision(PlayerPedId(), true, true)
  SetEntityCoords(PlayerPedId(), myPreChairCoords)
  exports["fa-interface"]:sendAppEvent("hud", { display = true })
  DoScreenFadeIn(1000)
end)

function prepareCameraSelf(activating, coords)
  local me = PlayerPedId()
  DetachEntity(me, 1, 1)
  SetEntityCollision(me, not activating, not activating)
  SetEntityInvincible(me, activating)
  -- SetEntityAlpha(me, activating and 0 or 255, 0)
  if activating then
    NetworkFadeOutEntity(me, activating, false)
  else
    NetworkFadeInEntity(me, 0, false)
  end
  SetEntityCoords(me, coords)
end

function deactivateGoPro()
  if not goProActivated then return end
  goProActivated = false
  prepareCameraSelf(false, currentCoords)
  RenderScriptCams(false, false, 0, 1, 0)
end

-- RegisterCommand("activategopro", function(src, args)
--   local netId = tonumber(args[1])
--   print(netId, src, json.encode(args))
--   activateGoPro(netId)
-- end, false)
-- RegisterCommand("deactivategopro", function()
--   deactivateGoPro()
-- end)

local currentSecCamCoords = nil
local currentSecCamHeading = nil
local listening = false
local destinationSelected = false
local function listenForKeypress()
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              listening = false
              if destinationSelected then
                exports["fa-selector"]:deselect()
                exports["fa-interface"]:hideInteraction()
                currentSecCamHeading = GetEntityHeading(PlayerPedId()) + GetGameplayCamRelativeHeading()
                exports['fa-interface']:openApplication('textbox', {
                  callbackUrl = 'fa-interface:goProRegisterSecCam',
                  key = 1,
                  items = {
                    {
                      icon = "pencil-alt",
                      label = "Security Camera Stream Name",
                      name = "name",
                    },
                  },
                  show = true,
                })
              else
                local camPos = exports["fa-selector"]:getCurrentSelection()
                currentSecCamCoords = vector3(camPos["selectedCoords"][1], camPos["selectedCoords"][2], camPos["selectedCoords"][3])
                local distance = #(GetEntityCoords(PlayerPedId()) - currentSecCamCoords)
                exports["fa-selector"]:deselect()
                if distance > 4 then
                  TriggerEvent("DoLongHudText", "Not close enough", 2)
                  exports["fa-interface"]:hideInteraction()
                  return
                end
                Wait(100)
                exports["fa-interface"]:showInteraction(("[E] %s"):format("View Here"))
                destinationSelected = true
                listenForKeypress()
                exports["fa-selector"]:startSelecting(1, 1, function()
                  return false
                end)
              end
          end
          Wait(0)
      end
  end)
end

local lastItemUsed = nil
local staticCamItems = {
  ["dashcamstatic"] = true,
  ["dashcamstaticpd"] = true,
}
AddEventHandler("fa-inventory:itemUsed", function(item)
  if not staticCamItems[item] then return end
  lastItemUsed = item
  currentSecCamCoords = nil
  destinationSelected = false
  TriggerEvent('DoLongHudText', "[E] Place, [MouseWheel] Rotate")
  local result = exports["fa-objects"]:PlaceObject(
    `prop_spycam`,
    {
      collision = false,
      groundSnap = false,
      forceGroundSnap = false,
      useModelOffset = false,
      zOffset = -0.05,
      distance = 4.5,
    },
    function(pCoords, pMaterial, pEntity)
      local forward = GetOffsetFromEntityInWorldCoords(pEntity, 0.0, -0.5, 0.0)
      DrawLine(pCoords.x, pCoords.y, pCoords.z, forward.x, forward.y, forward.z, 0, 255, 0, 255)
      return true
    end
  )

  if not result[1] then
    return
  end

  local prompt = exports["fa-interface"]:OpenInputMenu({
    {
      name = 'name',
      label = 'Security Camera Stream Name',
      icon = 'pencil-alt'
    }
  }, function(values)
    return values.name and values.name:len() > 2
  end)

  if not prompt then
    return
  end
  local success = RPC.execute("fa-gopros:addSecCamera", prompt.name, result[2].coords, result[2].rotation)
  if success then
    TriggerEvent("inventory:removeItem", lastItemUsed, 1)
  end
end)

local securityCamera = nil
local secCamX = 0.0
local secCamZ = 0.0
local secCamY = 0.0
local function activateSecurityCameraById(pId)
  local cam = RPC.execute("fa-gopros:getSecurityCameraById", pId)
  if not cam then return end
  print(cam.heading)
  local newCamCoords = json.decode(cam.coords)
  DoScreenFadeOut(400)
  Wait(400)
  FreezeEntityPosition(PlayerPedId(), true)
  securityCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
  SetCamFov(securityCamera, 60.0)
  SetCamCoord(securityCamera, newCamCoords.x, newCamCoords.y, newCamCoords.z + 0.2)
  secCamZ = cam.heading.z
  secCamY = cam.heading.y
  SetCamRot(securityCamera, secCamX, 0.0, cam.heading.x, cam.heading.y, cam.heading.z, 2)
  SetFocusPosAndVel(newCamCoords.x, newCamCoords.y, newCamCoords.z, 0.0, 0.0, 0.0)
  RenderScriptCams(true, false, 0, 1, 0)
  if cam.blurred then
    SetTimecycleModifier("CAMERA_secuirity_FUZZ")
    SetTimecycleModifierStrength(1.5)
  else
    SetTimecycleModifier("heliGunCam")
    SetTimecycleModifierStrength(1.0)
  end
  exports["fa-interface"]:sendAppEvent("hud", { display = false })
  DoScreenFadeIn(1000)
end

exports('activateSecurityCameraById', activateSecurityCameraById)


local function deactivateSecurityCamera()
  if not securityCamera then return end
  DestroyCam(securityCamera, true)
  securityCamera = nil
  ClearFocus()
  RenderScriptCams(false, false, 0, 1, 0)
  exports["fa-interface"]:sendAppEvent("hud", { display = true })
  ClearTimecycleModifier()
  ClearExtraTimecycleModifier()
  FreezeEntityPosition(PlayerPedId(), false)
end
--[[
RegisterUICallback("fa-interface:gopros:getSecurityCameras", function(data, cb)
  local cid = exports["isPed"]:isPed("cid")
  local cams = RPC.execute("fa-gopros:getSecurityCameraByCid", cid)
  cb({ data = cams, meta = { ok = true, message = "done" } })
end)

RegisterUICallback("fa-interface:gopros:viewCameraById", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  Wait(500)
  exports["fa-interface"]:closeApplication("phone")
  activateSecurityCameraById(data.id)
end)
]]
local securityCamChanging = false
local function securityCameraLookEnd()
  securityCamChanging = false
end
local function securityCameraLook(dir)
  if securityCamera == nil then return end
  securityCamChanging = true
  Citizen.CreateThread(function()
    while securityCamChanging do
      if dir == "up" then
        secCamX = secCamX + 0.1
        if secCamX > 30 then
          secCamX = 30.0
        end
      end
      if dir == "down" then
        secCamX = secCamX - 0.1
        if secCamX < -30 then
          secCamX = -30.0
        end
      end
      if dir == "left" then
        if math.abs(secCamY - secCamZ) <= 30 then
          secCamY = secCamY + 0.1
          if math.abs(secCamY - secCamZ) > 30 then
            secCamY = secCamY - 0.5
            securityCameraLookEnd()
          end
        end
      end
      if dir == "right" then
        if math.abs(secCamY - secCamZ) <= 30 then
          secCamY = secCamY - 0.1
          if math.abs(secCamY - secCamZ) > 30 then
            secCamY = secCamY + 0.5
            securityCameraLookEnd()
          end
        end
      end
      SetCamRot(securityCamera, secCamX, 0.0, secCamY, 2)
      Wait(0)
    end
  end)
end

Citizen.CreateThread(function()
  exports["fa-keybinds"]:registerKeyMapping("", "Camera", "Look Up", "+securityCamLookUp", "-securityCamLookUp", "PAGEUP")
  exports["fa-keybinds"]:registerKeyMapping("", "Camera", "Look Down", "+securityCamLookDown", "-securityCamLookDown", "PAGEDOWN")
  exports["fa-keybinds"]:registerKeyMapping("", "Camera", "Look Left", "+securityCamLookLeft", "-securityCamLookLeft", "HOME")
  exports["fa-keybinds"]:registerKeyMapping("", "Camera", "Look Right", "+securityCamLookRight", "-securityCamLookRight", "END")
  exports["fa-keybinds"]:registerKeyMapping("", "Camera", "Turn Off", "+securityCamOff", "-securityCamOff", "ESCAPE")
  RegisterCommand('+securityCamLookUp', function() securityCameraLook("up") end, false)
	RegisterCommand('-securityCamLookUp', function() securityCameraLookEnd() end, false)
  RegisterCommand('+securityCamLookDown', function() securityCameraLook("down") end, false)
	RegisterCommand('-securityCamLookDown', function() securityCameraLookEnd() end, false)
  RegisterCommand('+securityCamLookLeft', function() securityCameraLook("left") end, false)
	RegisterCommand('-securityCamLookLeft', function() securityCameraLookEnd() end, false)
  RegisterCommand('+securityCamLookRight', function() securityCameraLook("right") end, false)
	RegisterCommand('-securityCamLookRight', function() securityCameraLookEnd() end, false)
  RegisterCommand('+securityCamOff', function() deactivateSecurityCamera() end, false)
	RegisterCommand('-securityCamOff', function() end, false)

  exports["fa-interact"]:AddPeekEntryByModel({ `prop_spycam` }, {
    {
      id = "cam_blur_action",
      event = "fa-gopro:blurCamera",
      icon = "fingerprint",
      label = "Smudge",
    },
  }, { distance = { radius = 5.0 }, isEnabled = function(pEntity, pContext)
    return pContext.meta and pContext.meta.data and pContext.meta.data.metadata.id and not pContext.meta.data.metadata.blurred
  end })
end)

AddEventHandler('fa-gopro:blurCamera', function(pArgs, pEntity, pContext)
  local object = exports["fa-objects"]:GetObjectByEntity(pEntity)
  if not object then
    return
  end

  local function loopSkill(count)
    local loopCount = 0
    while loopCount < count do
        Wait(100)
        loopCount = loopCount + 1
        local finished = exports["fa-ui"]:taskBarSkill(math.random(1400, 2000), math.random(7, 12))
        if finished ~= 100 then
            return false
        end
    end
    return true
  end

  local success = loopSkill(math.random(3, 5))
  if not success then
    return
  end

  exports["fa-objects"]:UpdateObject(object.id, { blurred = true })
end)

AddEventHandler('fa-objects:objectCreated', function(pObject, pEntity)
  if pObject.data.model == `prop_spycam` then
    SetEntityCollision(pEntity, false, false)
  end
end)
--[[
RegisterUICallback("fa-interface:gopros:addUserToCamera", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  RPC.execute("fa-gopros:addUserToCamera", data.camera, data.cid)
end)

]]

-- RegisterCommand("activatecam", function()
--   activateSecurityCameraById(1)
-- end)
-- RegisterCommand("deactivatecam", function()
--   deactivateSecurityCamera()
-- end)
