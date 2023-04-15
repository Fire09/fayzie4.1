-- RegisterCommand("add-dispatch", function(source,args)
--     exports["fa-dispatch"]:dispatchadd(args[1], args[2], args[3])
-- end)

RegisterCommand("runplate", function(source,args)
    exports["fa-dispatch"]:dispatchadd("Flagged Vehicle:" .. args[1])
end)

RegisterNetEvent("police:deademergencyA", function()
    local icon = 280 -- https://docs.fivem.net/docs/game-references/blips/
    exports["fa-dispatch"]:policedead("10-13A", "OfficerDown Emergency", icon)
end)

RegisterNetEvent("police:deademergencyB", function()
    local icon = 280 -- https://docs.fivem.net/docs/game-references/blips/
    exports["fa-dispatch"]:policedead("10-13B", "OfficerDown Urgent", icon)
end)

RegisterNetEvent("police:panic", function()
    local icon = 280 -- https://docs.fivem.net/docs/game-references/blips/
    exports["fa-dispatch"]:policedead("10-78", "Officer need help", icon)
end)

RegisterCommand("callsign", function(source, args)
    local job = exports["isPed"]:isPed("myjob")
    if job == 'police' then 
        -- local item = exports["et-inventory"]:hasEnoughOfItem('gps',1,false)
        -- if item then
            exports["fa-dispatch"]:callsign_command(args[1], args[2])
        -- else
        --     exports["mythic_notify"]:SendAlert("error", "Üzerinde GPS yok.", 5000)
        -- end
    else
        -- exports["mythic_notify"]:SendAlert("inform", "Mesaiye girmen lazım.", 5000)
    end
end)

RegisterCommand("map", function()
    SendNUIMessage({
        action = "map"
    })
end)

RegisterCommand('open-dp', function()
    TriggerEvent('fa-dispatch:openFull')
end)

Citizen.CreateThread(function()
    RegisterKeyMapping("map", "Open the map", "keyboard", "M")
    RegisterKeyMapping("open-dp", "open the menu", "keyboard", "O")
end)