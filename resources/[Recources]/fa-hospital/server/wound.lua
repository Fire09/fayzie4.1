local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('fa-hospital:server:SyncInjuries')
AddEventHandler('fa-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)