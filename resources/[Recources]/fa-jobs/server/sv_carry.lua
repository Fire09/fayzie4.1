RegisterServerEvent('CarryPeople:sync')
AddEventHandler('CarryPeople:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)

    -- exports["fa-log"]:AddLog("Civ Jobs", 
    --     source, 
    --     "Carry Player", 
    --     { targetPlayer = GetPlayerName(target) })
end)

RegisterServerEvent('CarryPeople:stop')
AddEventHandler('CarryPeople:stop', function(targetSrc)
	TriggerClientEvent('CarryPeople:cl_stop', targetSrc)

    -- exports["fa-log"]:AddLog("Civ Jobs", 
    --     source, 
    --     "Stop Carry Player", 
    --     { targetPlayer = GetPlayerName(targetSrc) })
    -- Why would you log the carry?
    -- Wanna kill the SQL? its slow enough.
end)

RegisterServerEvent('fa-jobs:galleryPayout')
AddEventHandler('fa-jobs:galleryPayout', function(amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    user:addMoney(amount)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Endless RP [Gallery] | Payout Log **",
          ["description"] = "Gallery Payout Log | Amount: $"..amount.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1040840915763335208/9t9z_FcFbm1qeanDYo2HXB6ksHldivZmynndK_7E2IbjBOK1h5cqQOqu1Y_JQZJeUNeP", function(err, text, headers) end, 'POST', json.encode({username = "Endless RP | Job Payout Log", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/476423150817771526/1026844730488787045/Endless-2.png"}), { ['Content-Type'] = 'application/json' })
end)