RegisterServerEvent('aspect-casino:takeMoneyCasinoCard')
AddEventHandler('aspect-casino:takeMoneyCasinoCard', function(pMoneyAmount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local steamName = GetPlayerName(src)

    local identifiers = GetPlayerIdentifiers(src)

    local pDiscord = 'None'
    local pSteam = 'None'

    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end
    
    user:removeMoney(tonumber(pMoneyAmount))
    TriggerClientEvent('fa-casino:addBalance', src, pMoneyAmount)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Byte Development [Casino] | Purchase Membership **",
          ["description"] = "Character Name: "..character.first_name.." "..character.last_name.." \n State ID: "..character.id.." \n Steam Name: "..steamName.. "\n Discord ID: "..pDiscord.. " \n Steam Identifier: "..identifiers[1].." \n Purchased Casino Membership Card for $"..pMoneyAmount,
        }
      }
    PerformHttpRequest("YOUR-WEBHOOK-GOES-HERE", function(err, text, headers) end, 'POST', json.encode({username = "Byte Development | Casino", embeds = connect, avatar_url = "YOUR-AVATAR-URL-HERE"}), { ['Content-Type'] = 'application/json' })
end)