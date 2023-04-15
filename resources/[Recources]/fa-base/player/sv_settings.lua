RegisterServerEvent("fa-base:sv:player_settings_set")
AddEventHandler("fa-base:sv:player_settings_set", function(settingsTable)
    local src = source
    DPX.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
            if UpdateSettings then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("fa-base:sv:player_settings")
AddEventHandler("fa-base:sv:player_settings", function()
    local src = source
    DPX.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then 
            TriggerClientEvent("fa-base:cl:player_settings", src, loadedSettings) 
        else 
            TriggerClientEvent("fa-base:cl:player_settings",src, nil) 
        end
    end)
end)
