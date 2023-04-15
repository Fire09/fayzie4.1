
local CooldownTimer = true

local pIsAvailable = true

RegisterServerEvent('fa-heists:start_hitting_upper_vangelico')
AddEventHandler('fa-heists:start_hitting_upper_vangelico', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if CooldownTimer then
        print('[fa-heists] Someone Robbing Vangelico')
        CooldownTimer = false
        pIsAvailable = false
        TriggerClientEvent('fa-jewelry:open_doors', src)
        print('^3[fa-heists]: ^2Cooldown started^0')
        Citizen.Wait(3600000)
        print('[fa-heists] Vangelico No Longer On Cooldown')
        TriggerClientEvent('fa-heists:lock_vangelico_doors_cooldown', src)
        CooldownTimer = true
        pIsAvailable = true
    else
        print('[fa-heists] Someone Trying to Rob Vangelico But Already Been Robbed')
        TriggerClientEvent('DoLongHudText', src, 'This Jewelry Store was recently robbed.', 2)
    end
end)

RegisterServerEvent('fa-heists:vangelico_loot')
AddEventHandler('fa-heists:vangelico_loot', function()
    local src = source
    local EvanVangelicoLoot = math.random(1, 3)

    if EvanVangelicoLoot == 1 then
        TriggerClientEvent('player:receiveItem', src,'valuablegoods', math.random(5, 10))
        TriggerClientEvent('player:receiveItem', src,'goldbar', math.random(1, 5))
        TriggerClientEvent('player:receiveItem', src,'rolexwatch', math.random(10, 20))
    elseif EvanVangelicoLoot == 2 then
        TriggerClientEvent('player:receiveItem', src,'goldcoin', math.random(15, 30))
        TriggerClientEvent('player:receiveItem', src,'stolen8ctchain', math.random(3, 10))
    elseif EvanVangelicoLoot == 3 then
        TriggerClientEvent('player:receiveItem', src,'valuablegoods', math.random(5, 14))
        TriggerClientEvent('player:receiveItem', src,'goldcoin', math.random(15, 50))
        TriggerClientEvent('player:receiveItem', src,'rolexwatch', math.random(15, 30))
    end
end)

RegisterServerEvent('fa-heists:get_vangelico_availability')
AddEventHandler('fa-heists:get_vangelico_availability', function()
    local src = source

    if pIsAvailable then
        TriggerClientEvent('fa-heists:vangelico_available', src)
    else
        TriggerClientEvent('fa-heists:vangelico_unavailable', src)
    end
end)

RegisterServerEvent('fa-heists:vangelicoRobberyLog')
AddEventHandler('fa-heists:vangelicoRobberyLog', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** faye [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing Jewelry Store",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082975451648030/6EAdeVVE9lAdehzU61vnej2K13GR-h14f-aMuHbi6xY6yWbTlkBf0oEhkSlL3WwXX86x", function(err, text, headers) end, 'POST', json.encode({username = "faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)