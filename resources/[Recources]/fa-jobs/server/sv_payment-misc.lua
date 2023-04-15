RegisterServerEvent('server:GroupPayment')
AddEventHandler('server:GroupPayment', function( gangid, cashamount, sauce)
  local src = sauce

  if sauce == nil then
    src = source
  end
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)

    exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @gangid", {['gangid'] = gangid}, function(result)

      if result[1] ~= nil then

        local curbank = result[1].bank
        curbank = curbank + cashamount
        exports.oxmysql:execute("UPDATE group_banking SET bank = @bank WHERE group_type = @gangid", { ['gangid'] = gangid, ['bank'] = curbank})
      end
    end)
  end)

RegisterServerEvent('fa-weedbox:payout')
AddEventHandler('fa-weedbox:payout', function(money)
    local source = source
    local player = GetPlayerName(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
	end
end)

RegisterServerEvent("white_widow:retreive:receipt")
AddEventHandler("white_widow:retreive:receipt", function(regID)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if Registers[regID] then
        for i = 1, #Registers[regID] do
            if Registers[regID][i].regID == regID then
                local amount = Registers[regID][i].price
                if (tonumber(user:getCash()) >= tonumber(amount)) then
                    user:removeMoney(tonumber(amount))
                    local owner = exports["fa-base"]:getModule("Player"):GetUser(Registers[regID][i].owner)
                    local char = owner:getCurrentCharacter()
                    information = {
                        ["Price"] = tonumber(amount),
                        ["Creator"] = char.first_name .. " " ..char.last_name,
                        ["Comment"] = Registers[regID][i].comment
                    }

                    TriggerClientEvent("player:receiveItem", Registers[regID][i].owner, "ownerreceipt", 1, true, information)
                    TriggerClientEvent("player:receiveItem", src, "receipt", 1, true, {["Comment"] = "Thanks for your order at Cosmic Cannabis"})
                    TriggerEvent("white_widow:update:registers", regID)
                else
                    TriggerClientEvent("DoLongHudText", src, "You cant afford this payment", 2)
                end
            end
        end
    else
        TriggerClientEvent("DoLongHudText", src, "Payment not ready..", 2)
    end
end) 

RegisterServerEvent("white_widow:update:registers")
AddEventHandler("white_widow:update:registers", function(regID)
    for k, v in pairs(Registers[regID]) do
        table.remove(Registers[regID], k)
    end
end)

RegisterServerEvent('white_widow:OrderComplete')
AddEventHandler("white_widow:OrderComplete", function(regID, price, comment)
    local insert = {
        owner = source, 
        price = price, 
        comment = comment,
        regID = regID
    }
    Registers[regID] = {}
    table.insert(Registers[regID], insert)
end)

RegisterServerEvent("fa-jobs:white_widow:update:pay")
AddEventHandler("fa-jobs:white_widow:update:pay", function(cid)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    local invname = 'ply-'..characterId
    exports.oxmysql:execute("SELECT `slot`, `information` FROM user_inventory2 WHERE name = ? AND `item_id` = ? ORDER BY slot DESC", {invname, "ownerreceipt"}, function(data)
        if data[1] then
            local slot = data[1].slot
            local jsonparse = json.decode(data[1].information)
            TriggerClientEvent('white_widow:pay', src, jsonparse["Price"])
            local pPayment = jsonparse["Price"] / 50
            user:addMoney(pPayment)
            exports.oxmysql:execute('DELETE FROM user_inventory2 WHERE `name`= ? AND `item_id`= ? AND `slot`= ?', {invname, "ownerreceipt", slot})
        else
            TriggerClientEvent("DoLongHudText", src, "You dont have any work receipts to cash in")
        end
    end)
end)