RegisterServerEvent('fa-civjobs:errorlog')
AddEventHandler('fa-civjobs:errorlog', function(pErrorCode)
    local timeout = os.time()
    if (os.time() - timeout) < 5 then
        print(("[TIMEOUT] %s is spamming the event (%s)"):format(source, "fa-civjobs:errorlog"))
        timeout = os.time()
        return
    end
    if pErrorCode == 0x66 then
        exports["fa-log"]:AddLog("Civ Jobs", 
            source, 
            "Pressed Alt (KEY-19) while in Inventory trying to open menu", 
            { message = tostring(message) })
    end

    timeout = os.time()
    return
end)

RPC.register('fa-jobs:givePayout', function(source, amount, pType, text)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    TriggerClientEvent('fa-phone:paymentNoti', src, amount, pType)
    if pType == "cash" then
        user:addMoney(amount)
    elseif pType == "bank" then
        user:addBank(amount)
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Endless RP [Jobs] | Payout Log **",
          ["description"] = "Job Payout Log | Amount: $"..amount.." | Type: "..pType.." | Job Type (Buff / No Buff): "..text.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1040840915763335208/9t9z_FcFbm1qeanDYo2HXB6ksHldivZmynndK_7E2IbjBOK1h5cqQOqu1Y_JQZJeUNeP", function(err, text, headers) end, 'POST', json.encode({username = "Endless RP | Job Payout Log", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/476423150817771526/1026844730488787045/Endless-2.png"}), { ['Content-Type'] = 'application/json' })
end)