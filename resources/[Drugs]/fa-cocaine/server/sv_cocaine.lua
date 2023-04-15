RPC.register('heists:cocaine_paynow', function()
    local src = source
    if exports['fa-base']:GetModule('GetBalance')(src) >= 100000 then
        exports['fa-base']:GetModule('RemoveBank')(src, 100000)
    return true
    else
        return false
    end
end)

RPC.register('heists:cocaine_start_vehicle', function()
    local src = source
    TriggerClientEvent('fa-heists:doVehicle', src, "dinghy",2004.4, 4007.85, 29.22)
    print('Spawn Dinghy At:  ',2004.4, 4007.85, 29.22)
    return 
end)

RPC.register('heists:cocaine_dump_vehicle', function(x,y,z)
    local src = source
    TriggerClientEvent('fa-heists:doVehicle', src, "sultan",x,y,z)
    print('Spawn Sultan Suken At:  ',x,y,z)
end)

RegisterServerEvent("fx:spell:target")
AddEventHandler("fx:spell:target", function(x,y,z,pTimesent)
    print(x,y,z,pTimesent)
    TriggerClientEvent("fx:do:Effect", -1, x,y,z ,pTimesent)

end)
