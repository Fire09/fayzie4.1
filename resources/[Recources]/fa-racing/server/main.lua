--[[

    Variables

]]

Races = {}
PendingRaces = {}
ActiveRaces = {}
FinishedRaces = {}

--[[

    Functions

]]

function formatRace(race)
    local id = tostring(race.id)

    local checkpoints = race.checkpoints
    if type(checkpoints) == "string" then
        checkpoints = json.decode(checkpoints)
    end

    local index = 0
    local start = {}
    if race.type == "Lap" then
        index = #checkpoints
        start = checkpoints[index]
    else
        index = 1
        start = checkpoints[index]
    end

    Races[id] = {
        id = id,
        name = race.name,
        creator = race.creator,
        distance = race.distance,
        type = race.type,
        thumbnail = race.thumbnail,
        start = start,
        checkpoints = checkpoints,
        fastest_time = race.fastest_time,
        fastest_name = race.fastest_name,
        races = race.races,
    }
end

--[[

    RPCs

]]

RPC.register("fa-racing:getAllRaces", function(pSrc)
    local src = pSrc
    
    local allRaces = {
        races = Races,
        pendingRaces = PendingRaces,
        activeRaces = ActiveRaces,
        finishedRaces = FinishedRaces,
    }
    -- print("HELLO",json.encode(allRaces))
    return allRaces
end)

RegisterNetEvent('fa-racing:allRaces')
AddEventHandler('fa-racing:allRaces', function()
    local allRaces = {
        races = Races,
        pendingRaces = PendingRaces,
        activeRaces = ActiveRaces,
        finishedRaces = FinishedRaces,
    }
    TriggerEvent('fa-phone:allRaces', allRaces) 
end)

--[[

    Threads

]]

RPC.register("fa-racing:awardPlayer", function(pSrc, pAmt)
    local user = exports['fa-base']:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    local nos = MySQL.query.await([[
        SELECT * FROM boosting_users WHERE identifier = ?
    ]], {char.id})

    print(pAmt)

    if nos[1] then
        local newGNE = tonumber(nos[1].gne) + pAmt

        local nitrous = MySQL.query.await([[
            UPDATE boosting_users SET gne = ? WHERE identifier = ?
        ]], {newGNE, char.id})
    end
end)

Citizen.CreateThread(function()
    local races = MySQL.query.await([[
        SELECT *
        FROM racing_races
    ]])
    for i, v in ipairs(races) do
        formatRace(v)
    end
    Wait(100)
    TriggerEvent('fa-racing:allRaces')
end)

RPC.register('fa-racing:setAlias', function(src, usedItemIds, usedItemSlots, aliass)
    print("i am here")
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local name = "ply-"..char.id
    local usedItemId = usedItemIds
    local usedItemSlot =usedItemSlots
    local alias = aliass
    print(usedItemId,usedItemSlot,alias)
    --local aliasQ = MySQL.query.await([[
     ---   SELECT *
      --  FROM user_inventory2
     --   WHERE item_id = ? 
     --   AND slot = ?
      --  AND name = ?
    --]], {usedItemId, usedItemSlot, name})
    
    if alias ~= nil then
        local newAlias = '{'..'"Alias":"'..alias..'","characterId":"'..char.id..'"}'
        MySQL.update([[
            UPDATE user_inventory2
            SET information = ?
            WHERE slot = ?
            AND name = ?
        ]],
        { newAlias, usedItemSlot, name })
        MySQL.update([[
            UPDATE characters
            SET alias = ?
            WHERE id = ?
        ]],
        { alias, char.id})
        TriggerClientEvent('updateAlias', src, alias)
        return true
    else
        return false
    end
end)

RPC.register('fa-racing:giveRacingUSB', function(pSource)
    local user = exports['fa-base']:getModule("Player"):GetUser(pSource)
    information = {
        ["characterId"] = user:getCurrentCharacter().id,
      }
      TriggerClientEvent("player:receiveItem",pSource,"racingusb2",1,true,information)

end)



function getAlias(cid)
    local alias = MySQL.scalar.await([[
        SELECT alias
        FROM characters
        WHERE id = ?
    ]],{cid})
    print("GET ALIAS",alias)
    return alias
end

exports("getAlias", getAlias)