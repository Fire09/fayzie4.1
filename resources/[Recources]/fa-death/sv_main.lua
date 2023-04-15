RegisterServerEvent('fa-death:reviveSV')
AddEventHandler('fa-death:reviveSV', function(t)
	TriggerClientEvent('fa-death:revive', t)
    TriggerClientEvent('fa-hospital:client:RemoveBleed', t) 
    TriggerClientEvent('fa-hospital:client:ResetLimbs', t)
end)

RegisterServerEvent('fa-death:reviveSV2')
AddEventHandler('fa-death:reviveSV2', function()
	TriggerClientEvent('fa-death:revive', source)
end)

RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killerId, data)
    local src = source
    local pSteamName = GetPlayerName(src)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports['fa-admin']:addPlayerLog('Player Died', GetPlayerIdentifier(src, 0), pSteamName..' ['..char.first_name..' '..char.last_name..'] died to '..killerId, char.id, 'None')
end)

RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
    local src = source
    local pSteamName = GetPlayerName(src)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    print(json.encode(data))
    exports['fa-admin']:addPlayerLog('Player Killed', GetPlayerIdentifier(src, 0), pSteamName..' ['..char.first_name..' '..char.last_name..'] died to '..data.weaponhash, char.id, 'None')
end)