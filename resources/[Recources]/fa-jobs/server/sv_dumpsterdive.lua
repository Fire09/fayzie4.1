-- Dumpster Diving --

local dumpsterItems = {
    [1] = {chance = 2, id = 'sandwich', quantity = math.random(1,2)},
    [2] = {chance = 2, id = 'water', quantity = math.random(1,2)},
    [3] = {chance = 7, id = 'lockpick', quantity = math.random(1,1)},
    [4] = {chance = 5, id = 'plastic', quantity = math.random(2,9)},
    [5] = {chance = 80, id = 'bdiamond', quantity = 1},
    [6] = {chance = 8, id = 'oxy', quantity = math.random(1,5)},
    [7] = {chance = 5, id = 'aluminium', quantity = math.random(5,10)},
    [8] = {chance = 5, id = 'steel', quantity = math.random(6,8)},
    [9] = {chance = 5, id = 'rubber', quantity = math.random(2,7)},
    [10] = {chance = 5, id = 'scrapmetal', quantity = math.random(2,7)},
    [11] = {chance = 15, id = 'advlockpick', quantity = math.random(1,2)},
    [12] = {chance = 3, id = 'bandage', quantity = math.random(1,4)},
    [13] = {chance = 2, id = 'cigarette', quantity = math.random(1,5)},
    [14] = {chance = 4, id = 'rollingpaper', quantity = math.random(1,5)},
    [15] = {chance = 9, id = 'coke5g', quantity = math.random(2,3)},
    [16] = {chance = 7, id = '1gcrack', quantity = math.random(2,4)},
    [17] = {chance = 6, id = 'maleseed', quantity = math.random(1,2)},
    [18] = {chance = 6, id = 'femaleseed', quantity = math.random(1,2)},
    [19] = {chance = 15, id = 'femaleseed', quantity = math.random(1,2)},
    [20] = {chance = 9, id = 'bandage', quantity = math.random(1,2)},
    [21] = {chance = 60, id = 'bodybag', quantity = 1},
    [22] = {chance = 30, id = 'bodygarbagebag', quantity = 1},
    [23] = {chance = 30, id = 'humanhead', quantity = 1},
    [24] = {chance = 40, id = 'humantorso', quantity = 1},
    [25] = {chance = 20, id = 'humanarm', quantity = 1},
    [26] = {chance = 15, id = 'humanhand', quantity = 1},
    [27] = {chance = 20, id = 'humanleg', quantity = 1},
    [28] = {chance = 15, id = 'humanfinger', quantity = 1},
    [29] = {chance = 15, id = 'humanear', quantity = 1},
    [30] = {chance = 17, id = 'humanbones', quantity = 1},
    [31] = {chance = 30, id = 'humanheart', quantity = 1},
    [32] = {chance = 21, id = 'humaneye', quantity = 1},
    [33] = {chance = 40, id = 'humankidney', quantity = 1},
    [34] = {chance = 50, id = 'humanlungs', quantity = 1},
    [35] = {chance = 14, id = 'humannail', quantity = 1},
    [36] = {chance = 20, id = 'humanpancreas', quantity = 1},
    [37] = {chance = 17, id = 'humantongue', quantity = 1},
    [38] = {chance = 16, id = 'humantooth', quantity = 1},
    [39] = {chance = 10, id = 'humannail', quantity = 1},
    [40] = {chance = 9, id = 'rolexwatch', quantity = math.random(1,2)},
    [41] = {chance = 19, id = 'stoleniphone', quantity = math.random(1,2)},
    [42] = {chance = 8, id = 'stolennokia', quantity = math.random(2,3)},
    [43] = {chance = 8, id = 'stolen5ctchain', quantity = math.random(1,2)},
    [44] = {chance = 8, id = 'stolencasiowatch', quantity = math.random(2,5)},
    [45] = {chance = 15, id = 'xscondom', quantity = 1},
    [46] = {chance = 33, id = 'zebra', quantity = 1},
    [47] = {chance = 10, id = 'cigar', quantity = 1},
}

RegisterServerEvent('erp:startDumpsterTimer')
AddEventHandler('erp:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('erp:giveDumpsterReward')
AddEventHandler('erp:giveDumpsterReward', function()
    local source = tonumber(source)
    local item = {}
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)
    local gotID = {}

    item = dumpsterItems[math.random(1, #dumpsterItems)]
    if math.random(1, 75) >= item.chance then
        if tonumber(item.id) == 0 and not gotID[item.id] then
            gotID[item.id] = true
            user:addMoney(item.quantity)
            TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
        elseif not gotID[item.id] then
            gotID[item.id] = true
            TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
            TriggerClientEvent('DoLongHudText', source, 'You found '..item.id, 1)
        end
    else
        TriggerClientEvent('DoLongHudText', source, 'You found nothing!', 2)
    end
end)

function startTimer(id, object)
    local timer = 10 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('erp:removeDumpster', id, object)
        end
    end
end