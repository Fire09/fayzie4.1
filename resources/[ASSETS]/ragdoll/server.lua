local lastDamageTaken = {
    hash = "",
    source = -1,
    melee = false,
}

RegisterServerEvent('police:isDead')
AddEventHandler('police:isDead', function(pDeathHash)
    local src = source
    local ped = GetPlayerPed(src)

    lastDamageTaken.hash = pDeathHash
    local deathSource = GetPedSourceOfDeath(player)
    if not deathSource or deathSource == 0 then deathSource = lastDamageTaken.source end

end)

RegisterServerEvent('reviveGranted')
AddEventHandler('reviveGranted', function(t)
	local src = source
    if t then src = t end

	TriggerClientEvent('reviveFunction', t)
end)

RegisterServerEvent('serverCPR')
AddEventHandler('serverCPR', function()
	TriggerClientEvent('revive', source)
end)

RegisterServerEvent('ragdoll:dead')
AddEventHandler('ragdoll:dead', function(state)
    local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    MySQL.update.await([[
        UPDATE characters
        SET is_dead = ?
        WHERE id = ?
    ]],
    { state, cid })
end)

RegisterServerEvent('ragdoll:emptyInventory')
AddEventHandler('ragdoll:emptyInventory', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    TriggerEvent("fa-inventory:clear", src, cid)
end)

RPC.register('fa-ragdoll:fetchDeaths', function(src)
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    return GetDeathCount(cid)
end)

RPC.register('fa-ragdoll:addDeath', function(src, pMinor)
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    if not pMinor then
        local count = GetDeathCount(cid)

        local deaths = MySQL.update.await([[
            UPDATE characters
            SET deathes = ?
            WHERE id = ?
        ]],
        { count + 1, cid })

        return GetDeathCount(cid)
    else
        return GetDeathCount(cid)
    end
end)


function GetDeathCount(cid)
    local deaths = MySQL.scalar.await([[
        SELECT deathes
        FROM characters
        WHERE id = ?
    ]],
    { cid })

    return deaths
end

function isDead(cid)
    local data = MySQL.scalar.await([[
        SELECT is_dead
        FROM characters
        WHERE id = ?
    ]],
    { cid })

    return data
end

exports("GetDeathCount", GetDeathCount)
exports("isDead", isDead)