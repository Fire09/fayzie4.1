RegisterServerEvent("receipts:update:pay")
AddEventHandler("receipts:update:pay", function(cid)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    local invname = 'ply-'..characterId
    exports.oxmysql:execute("SELECT `slot`, `information` FROM user_inventory2 WHERE name = ? AND `item_id` = ? ORDER BY slot DESC", {invname, "ownerreceipt"}, function(data)
        if data[1] then
            local slot = data[1].slot
            local jsonparse = json.decode(data[1].information)
            exports.oxmysql:execute("SELECT `paycheck` FROM characters WHERE id = ?", {characterId}, function(old)
                local before = old[1].paycheck
                exports.oxmysql:execute("UPDATE characters SET `paycheck` = @paycheck WHERE `id` = @id", {
                    ['@paycheck'] = old[1].paycheck + jsonparse["Price"],
                    ['@id'] = characterId
                })
                TriggerClientEvent("Yougotpaid", src, characterId)
                exports.oxmysql:execute('DELETE FROM user_inventory2 WHERE `name`= ? AND `item_id`= ? AND `slot`= ?', {invname, "ownerreceipt", slot})
                TriggerClientEvent('DoLongHudText', src, 'You got paid $' ..jsonparse["Price"].. ' From your work receipt.')
            end)
        else
            TriggerClientEvent("DoLongHudText", src, "You dont have any work receipts to cash in")
        end
    end)
end)