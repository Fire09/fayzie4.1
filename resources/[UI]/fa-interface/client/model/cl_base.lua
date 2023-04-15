-- CLOSE APP
function SetInterfaceFocus(hasKeyboard, hasMouse)
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetInterfaceFocus', SetInterfaceFocus)

RegisterNUICallback("fa-interface:closeApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("fa-interface:applicationClosed", function(data, cb)
    TriggerEvent("fa-interface:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("fa-interface:force-close", function()
    SendInterfaceMessage({source = "fa-nui", app = "", show = false});
    SetInterfaceFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("fa-interface:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendInterfaceMessage({ source = "fa-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("fa-interface:restarted")
  SendInterfaceMessage({ app = "hud", data = { display = true }, source = "fa-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("fa-interface:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("fa-interface:server-restart")
AddEventHandler("fa-interface:server-restart", restartUI)

RegisterCommand("fa-interface:debug:show", function()
    SendInterfaceMessage({ source = "fa-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("fa-interface:debug:hide", function()
    SendInterfaceMessage({ source = "fa-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("fa-interface:resetApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("fa-interface:server-relay")
AddEventHandler("fa-interface:server-relay", function(data)
    SendInterfaceMessage(data)
end)