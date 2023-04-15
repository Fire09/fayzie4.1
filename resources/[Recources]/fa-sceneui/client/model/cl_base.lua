-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
--  HasNuiFocus = hasKeyboard or hasMouse

  SetNuiFocus(hasKeyboard, hasMouse)

  -- TriggerEvent("fa-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
  -- TriggerEvent("fa-binds:should-execute", not HasNuiFocus)
end

exports('SetUIFocus', SetUIFocus)

RegisterNUICallback("fa-ui:closeApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("fa-ui:applicationClosed", function(data, cb)
    TriggerEvent("fa-ui:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("fa-ui:force-close", function()
    SendUIMessage({source = "fa-nui", app = "", show = false});
    SetUIFocus(false, false)
end, false)

-- SMALL MAP
--[[RegisterCommand("fa-ui:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendUIMessage({ source = "fa-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("fa-ui:restarted")
  SendUIMessage({ app = "hud", data = { display = true }, source = "fa-nui" })
  local cj = exports["police"]:getCurrentJob()
  if cj ~= "unemployed" then
    TriggerEvent("fa-jobmanager:playerBecameJob", cj)
    TriggerServerEvent("fa-jobmanager:fixPaychecks", cj)
  end
  loadPublicData()
end
RegisterCommand("fa-ui:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("fa-ui:server-restart")
AddEventHandler("fa-ui:server-restart", restartUI)

RegisterCommand("fa-ui:debug:show", function()
    SendUIMessage({ source = "fa-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("fa-ui:debug:hide", function()
    SendUIMessage({ source = "fa-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("fa-ui:resetApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    sendCharacterData()
end)

RegisterNetEvent("fa-ui:server-relay")
AddEventHandler("fa-ui:server-relay", function(data)
    SendUIMessage(data)
end)

RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
  sendAppEvent("character", { job = "judge" })
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
  sendAppEvent("character", { job = "unemployed" })
end)

RegisterNetEvent("fa-jobmanager:playerBecameJob")
AddEventHandler("fa-jobmanager:playerBecameJob", function(job)
  sendAppEvent("character", { job = job })
end)
]]