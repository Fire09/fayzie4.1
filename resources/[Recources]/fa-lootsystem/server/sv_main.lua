LootTables = {}

Citizen.CreateThread(function()
    LootTables = GetLootTables(LootData)
    TriggerEvent("Faye:loot:system:ready")
end)

function DrawFromLootTable(pServerId, pTableName, pDraws)
    local loot = LootTables[pTableName]
    local player = exports["fa-base"]:getModule("Player"):GetUser(pServerId)

    if loot and player then
        for i = 1, pDraws, 1 do
            local item = loot:draw() --Result 1 item
            local success, obtained = loot:obtain(item, 1.0, nil, true) --result true / false , quantity Get

            if success then
                TriggerClientEvent('player:receiveItem', pServerId, item, obtained)
            end
        end
    elseif not loot then
        error(('Loot table with the name of "%s" does not exists.'):format(pTableName or 'N/A'))
    elseif not player then
        error(('Unable to find any player with the ID of "%s".'):format(pServerId or 'N/A'))
    end
end

exports('DrawFromLootTable',DrawFromLootTable)

AddEventHandler("Faye:loot:system:draw", DrawFromLootTable)

RegisterNetEvent('loot:useItem')
AddEventHandler("loot:useItem", function(itemId)
    local src = source

    if itemId == 'Bankbox' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_group6', math.random(3, 4))
    end

    if itemId == 'Securebriefcase' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_briefcase', 1)
    end

    if itemId == 'Largesupplycrate' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_largesupplycrate', 5)
    end

    if itemId == 'xmasgiftcoal' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_xmasgiftcoal', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_xmasgiftcoal_2', 1)
    end

    if itemId == 'Smallsupplycrate' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_smallsupplycrate', 5)
    end

    if itemId == 'Mediumsupplycrate' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_mediumsupplycrate', 5)
    end

    if itemId == 'bodygarbagebag' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_bodytrashbag', math.random(4, 7))
    end

    if itemId == 'chopchop' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_chopchop', 1)
    end

    if itemId == 'chopchop2' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_chopchop2', 1)
    end

    if itemId == 'chopchoprare' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_chopchop', 2)
    end

    if itemId == 'deliveryjob' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_delivery', 5)
    end

    if itemId == 'houserobbery' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_delivery', math.random(3, 5))
    end

    if itemId == 'fishingtacklebox' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_fishingtacklebox', 1)
    end

    if itemId == 'newaccountbox' then
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox2', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox3', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox4', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox5', 1)
        TriggerEvent("Faye:loot:system:draw", src, 'event_newaccountbox6', 1)
    end
end)