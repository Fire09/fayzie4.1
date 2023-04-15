RegisterServerEvent("fa-base:sv:player_control_set")
AddEventHandler("fa-base:sv:player_control_set", function(controlsTable)
    local src = source
    DPX.DB:UpdateControls(src, controlsTable, function(UpdateControls, err)
            if UpdateControls then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("fa-base:sv:player_controls")
AddEventHandler("fa-base:sv:player_controls", function()
    local src = source
    DPX.DB:GetControls(src, function(loadedControls, err)
        if loadedControls ~= nil then 
            TriggerClientEvent("fa-base:cl:player_control", src, loadedControls) 
        else 
            TriggerClientEvent("fa-base:cl:player_control",src, nil) print('controls fucked') 
        end
    end)
end)
