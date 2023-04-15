RegisterServerEvent("updateJailTime")
AddEventHandler("updateJailTime", function(minutes)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    if minutes == 0 then
        TriggerClientEvent('endJailTime', src)
    else
        exports.oxmysql:execute("UPDATE `characters` SET `jail_time` = '" .. tonumber(minutes) .. "' WHERE `id` = '" .. char.id .. "'")
    end
end)



RegisterServerEvent("updateJailTimeMobster")
AddEventHandler("updateJailTimeMobster", function(minutes)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.oxmysql:execute("UPDATE `characters` SET `jail_time_mobster` = '" .. minutes .. "' WHERE `id` = '" .. char.id .. "'")
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(60000)
        exports.oxmysql:execute("SELECT * FROM `characters` ", {}, function(result)
            for k, v in ipairs(result) do 
                if v.jail_time >= 1 then
                    exports.oxmysql:execute("UPDATE `characters` SET `jail_time` = @time WHERE `id` = @cid", {['time'] = v.jail_time - 1, ['cid'] = v.id } )
                end
            end
        end)
    end
end)

RegisterServerEvent("updateJailTimeMobster")
AddEventHandler("updateJailTimeMobster", function(minutes)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    if minutes == 0 then
        TriggerClientEvent('endJailTime', src)
    else
        exports.oxmysql:execute("UPDATE `characters` SET `jail_time_mobster` = @time WHERE `id` = @cid", {['time'] = tonumber(minutes), ['cid'] = char.id})
    end
end)


RegisterServerEvent('jail:charecterFullySpawend')
AddEventHandler('jail:charecterFullySpawend', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    local playerName = character.first_name .. ' ' .. character.last_name
    
    exports.oxmysql:execute("SELECT `jail_time` FROM `characters` WHERE id = @cid", {['cid'] = character.id}, function(result)
        TriggerClientEvent('beginJail', src, true,result[1].jail_time, playerName, character.id, date)
    end)
end)

RegisterServerEvent("checkJailTime")
AddEventHandler("checkJailTime", function(sendmessage)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.oxmysql:execute("SELECT `jail_time` FROM `characters` WHERE id = @cid", {['cid'] = char.id}, function(result)

        if tonumber(result[1].jail_time) <= 0 then
            TriggerClientEvent("TimeRemaining", src, tonumber(result[1].jail_time), true)
        elseif tonumber(result[1].jail_time) >= 1 then
            TriggerClientEvent("TimeRemaining", src, tonumber(result[1].jail_time), false)
        end
	end)
end)

RegisterCommand('unjail', function(source, args)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local target = exports["fa-base"]:getModule("Player"):GetUser(args[1])

    if user:getVar("job") == 'police' or user:getVar("job") == 'state' or user:getVar("job") == 'police' or user:getVar("job") == 'doc' or user:getVar("job") == 'judge' then
        if args[1] and exports["fa-base"]:getModule("Player"):GetUser(tonumber(args[1])) then
            TriggerClientEvent("endJailTime", (args[1]))
            exports.oxmysql:execute("UPDATE `characters` SET `jail_time` = @time WHERE `id` = @cid", {['time'] = 0, ['cid'] = char.id})
        else
            TriggerClientEvent("DoLongHudText", src, 'There are no player with this ID.', 2)
        end
    end
end)

RegisterCommand('jail', function(source, args)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()

    if user:getVar("job") == 'police' or user:getVar("job") == 'state' or user:getVar("job") == 'sheriff' or user:getVar("job") == 'doc' or user:getVar("job") == 'judge' then
        TriggerClientEvent("police:jailing", src, args)
    end
end)

RegisterServerEvent('fa-jail:pJailedLog')
AddEventHandler('fa-jail:pJailedLog', function(months, jailed_player)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local user2 = exports["fa-base"]:getModule("Player"):GetUser(jailed_player)
    local charInfo = user:getCurrentCharacter()
    local charInfo2 = user2:getCurrentCharacter()

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Faye [Jail] | Log **",
          ["description"] = "Officer Name: "..charInfo.first_name.. ' '..charInfo.last_name .."\n Months: "..months.."\n Jailed Player: "..charInfo2.first_name.. ' '..charInfo2.last_name,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082729698988063/Yd3XLReL_0vOnrVm0TSM-hIVg4ZHbXeyuTwNY_7M9rSmMVF0w1wuHow9rh56lNhWfY_o", function(err, text, headers) end, 'POST', json.encode({username = "Faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('fa-jail:pBilledLog')
AddEventHandler('fa-jail:pBilledLog', function(pFineAmount, fined_player)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local user2 = exports["fa-base"]:getModule("Player"):GetUser(fined_player)
    local charInfo = user:getCurrentCharacter()
    local charInfo2 = user2:getCurrentCharacter()

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Faye [Jail] | Log **",
          ["description"] = "Officer Name: "..charInfo.first_name.. ' '..charInfo.last_name .."\n Fine Amount: $"..pFineAmount.."\n Billed Player: "..charInfo2.first_name.. ' '..charInfo2.last_name,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082458130383039/saKe3jMeCWz_Mwbh13U2oHywvlbf43E8uwHznsTyF75SYICNcvuAOX2ZGH4J-lR-Pd7p", function(err, text, headers) end, 'POST', json.encode({username = "Faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)