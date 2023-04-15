RegisterServerEvent("fa-baycity:getGetDoorStateSV")
AddEventHandler("fa-baycity:getGetDoorStateSV", function()
    TriggerClientEvent('fa-baycity:getDoorCheckCL', -1, doorCheckbaycity)
end)

RegisterServerEvent("fa-particleserverbaycity")
AddEventHandler("fa-particleserverbaycity", function(method)
    TriggerClientEvent("fa-ptfxparticlebaycity", -1, method)
end)

RegisterServerEvent("fa-particleserverbaycity1")
AddEventHandler("fa-particleserverbaycity1", function(method)
    TriggerClientEvent("fa-ptfxparticlebaycity1", -1, method)
end)
