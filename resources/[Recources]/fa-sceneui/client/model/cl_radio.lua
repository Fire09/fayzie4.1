--[[RegisterNUICallback("fa-ui:hudUpdateRadioSettings", function(data, cb)
    exports["fa-base"]:getModule("SettingsData"):setSettingsTableGlobal({ ["tokovoip"] = data.settings }, true)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("fa-ui:hudUpdateKeybindSettings", function(data, cb)
    exports["fa-base"]:getModule("DataControls"):encodeSetBindTable(data.controls)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)]]