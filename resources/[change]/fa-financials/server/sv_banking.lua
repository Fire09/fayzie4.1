RPC.register("GetAccounts", function(pSource)
    local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local cid = char.id

    local getPlayerBank = Await(SQL.execute("SELECT bank, cash, bank_id FROM characters WHERE id = @id", {
        ["id"] = cid
    }))

    local PlayerBank = tonumber(getPlayerBank[1].bank)
    local PlayerCash = tonumber(getPlayerBank[1].cash)
    local PlayerBankId = tonumber(getPlayerBank[1].bank_id)
    local PlayerName = char.first_name .. " " .. char.last_name

    if PlayerBankId == nil or tonumber(PlayerBankId) == 0 then
        math.randomseed(os.time())
        local newBankId = math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9)
        local updatePlayerData = Await(SQL.execute("UPDATE characters SET bank_id = @bank_id WHERE id = @id", {
            ["bank_id"] = newBankId,
            ["id"] = cid
        }))

        PlayerBankId = newBankId
    end

    local tbl = {}

--[[     tbl[1] = {
        type = "personal",
        amount = PlayerBank,
        bank_id = PlayerBankId,
        id = "personal"
    } ]]

    tbl[1] = {
        type = "personal",
        id = "personal",
        name = PlayerName,
        amount = PlayerBank,
        bank_id = PlayerBankId
    }

    local getBusinessData = Await(SQL.execute("SELECT * FROM businesses", {}))

    if getBusinessData[1] then
        for k,v in pairs(getBusinessData) do
            local business_id = getBusinessData[k].business_id
            local business_name = getBusinessData[k].business_name
            local bank_id = getBusinessData[k].bank_id
            local employees = json.decode(getBusinessData[k].employees) or {}
            local roles = json.decode(getBusinessData[k].roles) or {}
            local bank = getBusinessData[k].bank
            for i,u in pairs(employees) do
                if tonumber(u.cid) == cid then
                    for p,l in pairs(roles) do
                        if tostring(l.name) == tostring(u.role) then
                            if l.bank_access == true then
                                tbl[#tbl + 1] = {
                                    type = "business",
                                    id = business_id,
                                    name = business_name,
                                    amount = bank or 0,
                                    bank_id = bank_id
                                }
                            end
                        end
                    end
                end
            end
        end
    end

    --print(json.encode(tbl))

    return tbl, PlayerCash, PlayerName
end)

RPC.register("GetTransactionLogs", function(pSource, pId)
    local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local cid = char.id
    local id = pId
    if id == "personal" then
        local result = Await(SQL.execute("SELECT id, sender, target, label, amount, iden, type, date, business_id, transaction_id FROM bank_transactions WHERE identifier = ? ORDER BY id DESC", {cid}))

        local getPlayerBank = Await(SQL.execute("SELECT bank, cash, bank_id FROM characters WHERE id = @id", {
            ["id"] = cid
        }))

        local transactions = {}

        for i = 1, #result do
            transactions[#transactions + 1] = {
                id = result[tonumber(i)].id,
                identifier = result[tonumber(i)].identifier,
                sender = result[tonumber(i)].sender,
                target = result[tonumber(i)].target,
                label = result[tonumber(i)].label,
                amount = result[tonumber(i)].amount,
                iden = result[tonumber(i)].iden,
                type = result[tonumber(i)].type,
                date = result[tonumber(i)].date,
                business_id = result[tonumber(i)].business_id,
                transaction_id = result[tonumber(i)].transaction_id,
                bank_id = getPlayerBank[1].bank_id,
                business_name = "Personal Account"
            }
        end

        return transactions
    else
        local result = Await(SQL.execute("SELECT id, sender, target, label, amount, iden, type, date, business_id, transaction_id FROM bank_transactions WHERE business_id = ? ORDER BY id DESC", {id}))
        
        local transactions = {}

        for i = 1, #result do
            local getBizData = Await(SQL.execute("SELECT business_name, bank_id FROM businesses WHERE business_id = ?", {result[tonumber(i)].business_id}))

            local mybizname = getBizData[1].business_name
            local mybankid = getBizData[1].bank_id

            transactions[#transactions + 1] = {
                id = result[tonumber(i)].id,
                identifier = result[tonumber(i)].identifier,
                sender = result[tonumber(i)].sender,
                target = result[tonumber(i)].target,
                label = result[tonumber(i)].label,
                amount = result[tonumber(i)].amount,
                iden = result[tonumber(i)].iden,
                type = result[tonumber(i)].type,
                date = result[tonumber(i)].date,
                business_id = result[tonumber(i)].business_id,
                transaction_id = result[tonumber(i)].transaction_id,
                business_name = mybizname,
                bank_id = mybankid
            }
        end

        return transactions
    end
end)

RPC.register("BankWithdraw", function(pSource, pId, pAmount, pComment, pTransId, pDate)
    local id = pId
    if id == "personal" then
    local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local result = Await(SQL.execute("SELECT first_name, last_name FROM characters WHERE id = ?", {char.id}))
    local firstname = result[1].first_name lastname = result[1].last_name
    local ply = char.id
    local type = "neg"
    local iden = "WITHDRAW"
    local sender = firstname.. " " ..lastname
    local target = sender
    local amount = tonumber(pAmount)

    if amount < 0 then
        return false, "Only positive values!"
    end

    if amount > tonumber(char.bank) then
        return false, "Not enough money in the bank."
    end

    --print("Cur Cash: " .. user:getCash())
    --print("Cur Bank: " .. user:getBalance())

    user:removeBank(amount)
    --local newbankamount = tonumber(char.bank) - tonumber(amount)
    --TriggerClientEvent("fa-financials:transferUpdate", pSource, ply, newbankamount)
    --local remove = Await(SQL.execute("UPDATE characters SET bank = bank - ? WHERE id = ?", {amount, ply}))
    user:addMoney(amount)

    --print("New Cash: " .. user:getCash())
    --print("New Bank: " .. user:getBalance())

    --TriggerClientEvent('isPed:UpdateCash', pSource, user:getCash())

    local insert = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @transaction_id)", {
        ["cid"] = ply,
        ["sender"] = sender,
        ["target"] = target,
        ["label"] = pComment,
        ["amount"] = amount,
        ["iden"] = iden,
        ["type"] = type,
        ["date"] = pDate,
        ["transaction_id"] = pTransId
    }))

    if not insert then return false, "Contact governent." end

    return true
    else
        -- biz
        local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
        local char = user:getCurrentCharacter()
        local result = Await(SQL.execute("SELECT first_name, last_name FROM characters WHERE id = ?", {char.id}))
        local firstname = result[1].first_name lastname = result[1].last_name
        local ply = char.id
        local type = "neg"
        local iden = "WITHDRAW"
        local sender = firstname.. " " ..lastname
        local target = sender
        local amount = tonumber(pAmount)

        if amount < 0 then
            return false, "Only positive values!"
        end
    
        local getBizBank = Await(SQL.execute("SELECT bank FROM businesses WHERE business_id = ?", {id}))

        local bank = tonumber(getBizBank[1].bank)

        if amount > tonumber(bank) then
            return false, "Not enough money in the bank."
        end

        local updateBizBank = Await(SQL.execute("UPDATE businesses SET bank = bank - ? WHERE business_id = ?", {amount, id}))

        if not updateBizBank then
            return false, "Contact government."
        end

        user:addMoney(amount)

        TriggerClientEvent('isPed:UpdateCash', pSource, user:getCash()) -- not needed?

        --print(user:getCash())
    
        local insert = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, business_id, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @business_id, @transaction_id)", {
            ["cid"] = 0,
            ["sender"] = sender,
            ["target"] = target,
            ["label"] = pComment,
            ["amount"] = amount,
            ["iden"] = iden,
            ["type"] = type,
            ["date"] = pDate,
            ["business_id"] = id,
            ["transaction_id"] = pTransId,
        }))
    
        if not insert then return false, "Contact governent." end
    
        return true
    end
end)

RPC.register("BankDeposit", function(pSource, pId, pAmount, pComment, pTransId, pDate)
    local id = pId
    if id == "personal" then
    local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
    local result = Await(SQL.execute("SELECT first_name, last_name FROM characters WHERE id = ?", {char.id}))
    local firstname = result[1].first_name lastname = result[1].last_name
    local ply = char.id
    local type = "pos"
    local iden = "DEPOSIT"
    local sender = firstname.. " " ..lastname
    local target = sender
    local amount = tonumber(pAmount)

    if amount < 0 then
        return false, "Only positive values!"
    end

    if amount > tonumber(char.cash) then
        return false, "Not enough money on you."
    end

    --print("Cur Cash: " .. user:getCash())
    --print("Cur Bank: " .. user:getBalance())
    user:removeMoney(amount) -- should show update
    user:addBank(amount)
    --local newbankamount = tonumber(char.bank) + tonumber(amount)
    --TriggerClientEvent("fa-financials:transferUpdate", pSource, ply, newbankamount)
    --local remove = Await(SQL.execute("UPDATE characters SET bank = bank + ? WHERE id = ?", {amount, ply}))
    --if remove then
    --end

    --print("New Cash: " .. user:getCash())
    --print("New Bank: " .. user:getBalance())

    TriggerClientEvent('isPed:UpdateCash', pSource, user:getCash()) -- not needed? double take away?

    local insert = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @transaction_id)", {
        ["cid"] = ply,
        ["sender"] = sender,
        ["target"] = target,
        ["label"] = pComment,
        ["amount"] = amount,
        ["iden"] = iden,
        ["type"] = type,
        ["date"] = pDate,
        ["transaction_id"] = pTransId
    }))

    if not insert then return false, "Contact governent." end

    return true
    else
        -- biz
        local user = exports["fa-base"]:getModule("Player"):GetUser(pSource)
        local char = user:getCurrentCharacter()
        local result = Await(SQL.execute("SELECT first_name, last_name FROM characters WHERE id = ?", {char.id}))
        local firstname = result[1].first_name lastname = result[1].last_name
        local ply = char.id
        local type = "pos"
        local iden = "DEPOSIT"
        local sender = firstname.. " " ..lastname
        local target = sender
        local amount = tonumber(pAmount)
        if amount < 0 then
            return false, "Only positive values!"
        end
    
        if amount > tonumber(char.cash) then
            return false, "Not enough money on you."
        end
    
        --user:removeMoney(amount)

        --print("Cur Cash: " .. user:getCash())

        --TriggerClientEvent('isPed:UpdateCash', pSource, user:getCash())

        local updateBizBank = Await(SQL.execute("UPDATE businesses SET bank = bank + ? WHERE business_id = ?", {amount, id}))

        if updateBizBank then
            user:removeMoney(amount) -- should update cash cache aswell as show NUI
            --print("New Cash: " .. user:getCash())
        end

        if not updateBizBank then
            return false, "Contact government."
        end
        
        local insert = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, business_id, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @business_id, @transaction_id)", {
            ["cid"] = 0,
            ["sender"] = sender,
            ["target"] = target,
            ["label"] = pComment,
            ["amount"] = amount,
            ["iden"] = iden,
            ["type"] = type,
            ["date"] = pDate,
            ["business_id"] = id,
            ["transaction_id"] = pTransId
        }))
    
        if not insert then return false, "Contact governent." end
    
        return true
    end
end)

RPC.register("DoTransaction", function(pSource, pId, pAmount, pComment, pTransId, pDate, pTarget)
    local id = pId
    local target = tonumber(pTarget)

    if id == "personal" then
        -- get sender user, and char information
        local userSender = exports["fa-base"]:getModule("Player"):GetUser(pSource)
        local charSender = userSender:getCurrentCharacter()

        if not userSender then return false, "can't get userSender" end
        
        -- get receiver user, and char information
        local userReceiver = exports["fa-base"]:getModule("Player"):GetUser(target)
        local charReceiver = userReceiver:getCurrentCharacter()

        if not userReceiver then return false, "can't get userReceiver" end

        -- types
        local sendertype = "neg"
        local receivertype = "pos"
        local iden = "TRANSFER"
        local sender = charSender.first_name .. " " .. charSender.last_name
        local receiver = charReceiver.first_name .. " " .. charReceiver.last_name
        local amount = tonumber(pAmount)
        local comment = pComment
        if amount < 0 then
            return false, "Only positive values!"
        end
        if tonumber(amount) > tonumber(charSender.bank) then
            return false, "Not enough money in the bank."
        end
        if tonumber(pSource) == target then
            return false, "You can't transfer money to yourself!"
        end
        if pComment == nil then
            comment = ""
        end

        userSender:removeBank(amount)
        userReceiver:addBank(amount)

        local insert1 = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @transaction_id)", {
            ["cid"] = charSender.id,
            ["sender"] = sender,
            ["target"] = receiver,
            ["label"] = comment,
            ["amount"] = amount,
            ["iden"] = iden,
            ["type"] = sendertype,
            ["date"] = pDate,
            ["transaction_id"] = pTransId
        }))

        local insert2 = Await(SQL.execute("INSERT INTO bank_transactions (identifier, sender, target, label, amount, iden, type, date, transaction_id) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date, @transaction_id)", {
            ["cid"] = charReceiver.id,
            ["sender"] = sender,
            ["target"] = receiver,
            ["label"] = comment,
            ["amount"] = amount,
            ["iden"] = iden,
            ["type"] = receivertype,
            ["date"] = pDate,
            ["transaction_id"] = pTransId
        }))

        return true, "success"
    end
    -- biz shit here...
end)

-- RegisterCommand("genbankidbiz", function()
--     local businesses = Await(SQL.execute("SELECT * FROM businesses", {}))

--     for k,v in pairs(businesses) do
--         if v.bank_id == nil or tonumber(v.bank_id) == 0 then
--         local id = v.business_id
--         print(id)
--         Wait(1000)
--         math.randomseed(os.time())
--         local bankid = math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9)
--         print(bankid)
--         local result = Await(SQL.execute("UPDATE businesses SET bank_id = ? WHERE business_id = ?", {bankid, id}))
--         end
--     end
-- end)

RegisterCommand('cash', function(source, args)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	local cash = char.cash
	TriggerClientEvent('banking:updateCash', source, cash, true)
	TriggerClientEvent('isPed:UpdateCash', src, cash)
  end)

  RegisterCommand('givecash', function(source, args)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cash = char.cash
    if tonumber(args[1]) == src or tonumber(args[2]) <= 0 then
      TriggerClientEvent('DoShortHudText', src, 'Invaild Action!', 2)
    else
      if tonumber(args[2]) then
        TriggerClientEvent("bank:givecash", src, args[1], tonumber(args[2]))
        local connect = {
            {
                ["color"] = "255",
                ["title"] = "Give Cash Log",
                ["description"] = "Character Name Giving Cash: "..char.first_name..'\n\n━━━━━━━━━━━━━━━━━━\n\n Steam Name Recieving Cash: '..GetPlayerName(args[1])..'\n\n━━━━━━━━━━━━━━━━━━\n\n Cash Amount: $'..args[2],
            }
        }
        PerformHttpRequest('https://discord.com/api/webhooks/972270759412133913/JSOcZmDJWqj6q0JJ2yTcLBdsYPaeASvEGnbuXz6yiJSh_WYGQdSFKctkU6loG8K4LJYe', function(err, text, headers) end, 'POST', json.encode({username = "faye",  avatar_url = "https://cdn.discordapp.com/attachments/991122949828530258/992926357413711872/unknown.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
       end
    end
  end)

  RegisterServerEvent('bank:givemecash')
AddEventHandler('bank:givemecash', function(reciever, amount)
  local src = source
  local user = exports["fa-base"]:getModule("Player"):GetUser(src)
  local player = exports["fa-base"]:getModule("Player"):GetUser(tonumber(reciever))
  if tonumber(amount) <= user:getCash() then
    user:removeMoney(amount)
    player:addMoney(amount)    
    local pSteam = 'None'
    local pDiscord = 'None'
    local pName = GetPlayerName(tonumber(receiver))
    local pIdentifiers = GetPlayerIdentifiers(tonumber(receiver))
    for k, v in pairs(pIdentifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    TriggerEvent('fa-base:bankgivecash', src, tonumber(receiver), pName, pSteam, pDiscord, amount, tonumber(user:getCash()), tonumber(user:getBalance()), amount, tonumber(player:getCash()), tonumber(player:getBalance()))
  else
    TriggerClientEvent('DoShortHudText', src, 'Not enough money', 2)
  end
end)

  RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(src, amount)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(tonumber(amount))
end)

RegisterServerEvent('fa-financials:addMoney')
AddEventHandler('fa-financials:addMoney', function(amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:addMoney(tonumber(amount))
end)

RegisterServerEvent('fa-financials:removeMoney')
AddEventHandler('fa-financials:removeMoney', function(amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(tonumber(amount))
end)

RegisterServerEvent("fa-financials:cash:get")
AddEventHandler('fa-financials:cash:get', function(amount)

    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = user:getCash()
    TriggerClientEvent("fa-financials:cash",cash)
end)

RegisterServerEvent("fa-financials:business_money", function(amt, account, case)
    local pAmount = tonumber(amt)
    if case == "remove" then
        exports.oxmysql:execute("SELECT `bank` FROM businesses WHERE business_id = ?", {account}, function(data)	
            local NewAmount = data[1].bank - pAmount
            exports.oxmysql:execute("UPDATE businesses SET `bank` = ? WHERE business_id = ?", {NewAmount, account})
        end)
    elseif case == "add" then
        exports.oxmysql:execute("SELECT `bank` FROM businesses WHERE business_id = ?", {account}, function(data)	
            local NewAmount = data[1].bank + pAmount
            exports.oxmysql:execute("UPDATE businesses SET `bank` = ? WHERE business_id = ?", {NewAmount, account})
            print(NewAmount)
        end)
    end
  end)

  -- // Logs // --

local Deposit_Log = "https://discord.com/api/webhooks/992926575295221832/ZY7R6hUfZ0Y26sZv9H6aWHhXD6wCbAVVQ91uw_rTffm4MsXJikfir-LWr18NUZQcb_8U"

RegisterServerEvent('fa-financials:deposit_log')
AddEventHandler('fa-financials:deposit_log', function(pDepositAmt, pDepositComment)
    local pName = GetPlayerName(source)
    local connect = {
        {
            ["color"] = "16777215",
            ["title"] = "User Deposited Money: ".. pName,
            ["description"] = "Amount: $"..pDepositAmt..'\n\n━━━━━━━━━━━━━━━━━━\n\n Comment: '..pDepositComment,
	        ["footer"] = {
                ["text"] = "[fa-financials]",
            },
        }
    }
    PerformHttpRequest(Deposit_Log, function(err, text, headers) end, 'POST', json.encode({username = "faye",  avatar_url = "https://cdn.discordapp.com/attachments/991122949828530258/992926357413711872/unknown.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

local Withdraw_Log = "https://discord.com/api/webhooks/992925241628176514/d_E4g6wRvJl7tAMkD2ko0L4xKvBU2ECsFbbz4B7zYcWPwrrbrGyABbXqmFtexRrs4wPM"

RegisterServerEvent('fa-financials:withdraw_log')
AddEventHandler('fa-financials:withdraw_log', function(pWithDrawAmt, pWithDrawComment)
    local pName = GetPlayerName(source)
    local connect = {
        {
            ["color"] = "16777215",
            ["title"] = "User Withdrew Money: ".. pName,
            ["description"] = "Amount: $"..pWithDrawAmt..'\n\n━━━━━━━━━━━━━━━━━━\n\n Comment: '..pWithDrawComment,
	        ["footer"] = {
                ["text"] = "[fa-financials]",
            },
        }
    }
    PerformHttpRequest(Withdraw_Log, function(err, text, headers) end, 'POST', json.encode({username = "faye",  avatar_url = "https://cdn.discordapp.com/attachments/991122949828530258/992926357413711872/unknown.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)