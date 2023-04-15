RegisterServerEvent('aspect-casino:takeMoneyChips')
AddEventHandler('aspect-casino:takeMoneyChips', function(pMoneyAmount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    user:removeMoney(tonumber(pMoneyAmount))
end)

RegisterServerEvent('aspect-casino:giveCashoutCashChips')
AddEventHandler('aspect-casino:giveCashoutCashChips', function(pMoneyAmount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    user:addMoney(tonumber(pMoneyAmount))

    local character = user:getCurrentCharacter()
    local steamName = GetPlayerName(src)

    local identifiers = GetPlayerIdentifiers(src)

    local pDiscord = 'None'
    local pSteam = 'None'

    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Byte Development [Casino] | Cashout Chips Cash **",
          ["description"] = "Character Name: "..character.first_name.." "..character.last_name.." \n State ID: "..character.id.." \n Steam Name: "..steamName.. "\n Discord ID: "..pDiscord.. " \n Steam Identifier: "..identifiers[1].." \n Traded Out "..pMoneyAmount.. "x Casino Chips for $"..pMoneyAmount.." In there cash balance.",
        }
      }
    PerformHttpRequest("YOUR-WEBHOOK-GOES-HERE", function(err, text, headers) end, 'POST', json.encode({username = "ByteDevelopment | Casino", embeds = connect, avatar_url = "AVATAR-IMG"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('aspect-casino:giveCashoutBankChips')
AddEventHandler('aspect-casino:giveCashoutBankChips', function(pMoneyAmount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    user:addBank(tonumber(pMoneyAmount))

    local character = user:getCurrentCharacter()
    local steamName = GetPlayerName(src)

    local identifiers = GetPlayerIdentifiers(src)

    local pDiscord = 'None'
    local pSteam = 'None'

    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Byte Development [Casino] | Cashout Chips Bank **",
          ["description"] = "Character Name: "..character.first_name.." "..character.last_name.." \n State ID: "..character.id.." \n Steam Name: "..steamName.. "\n Discord ID: "..pDiscord.. " \n Steam Identifier: "..identifiers[1].." \n Traded Out "..pMoneyAmount.. "x Casino Chips for $"..pMoneyAmount.." In there bank balance.",
        }
      }
    PerformHttpRequest("YOUR-WEBHOOK-GOES-HERE", function(err, text, headers) end, 'POST', json.encode({username = "Byte Development | Casino", embeds = connect, avatar_url = "AVATAR-URL-HERE"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('fa-casino:newGiveChips')
AddEventHandler('fa-casino:newGiveChips', function()
  local src = source
  local user = exports["fa-base"]:getModule("Player"):GetUser(src)

  user:addChips(500)
end)