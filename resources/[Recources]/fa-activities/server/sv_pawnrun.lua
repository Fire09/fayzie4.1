RegisterServerEvent('rolexdelivery:server')
AddEventHandler('rolexdelivery:server', function(money)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)

	if user:getCash() >= 500 then
        user:removeMoney(500)

		TriggerClientEvent("rolexdelivery:startDealing", src)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough for this', 2)
	end
end)

RegisterServerEvent('fa-activities:pawnPayout')
AddEventHandler('fa-activities:pawnPayout', function(amount, text)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    user:addMoney(amount)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Endless RP [Activities] | Payout Log **",
          ["description"] = "Pawn Run Payout Log | Amount: $"..amount.." | (Buff / No Buff): "..text.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1040840915763335208/9t9z_FcFbm1qeanDYo2HXB6ksHldivZmynndK_7E2IbjBOK1h5cqQOqu1Y_JQZJeUNeP", function(err, text, headers) end, 'POST', json.encode({username = "Endless RP | Job Payout Log", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/476423150817771526/1026844730488787045/Endless-2.png"}), { ['Content-Type'] = 'application/json' })
end)