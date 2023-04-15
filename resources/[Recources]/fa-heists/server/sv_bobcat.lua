pCanBlow = false
canloot = false

RegisterServerEvent("fa-bobcat:effect")
AddEventHandler("fa-bobcat:effect", function(method)
    TriggerClientEvent("lumo:effectoutside", -1, method)
end)

RegisterServerEvent("fa-bobcat:effect2")
AddEventHandler("fa-bobcat:effect2", function(method)
    TriggerClientEvent("lumo:effectinside", -1, method)
end)

RegisterServerEvent("fa-bobcat:bubbles")
AddEventHandler("fa-bobcat:bubbles", function()
    canloot = true
    TriggerClientEvent("fa-bobcat:bubbles", -1)
end)

local searched1 = false
local searched2 = false
local searched3 = false

RegisterServerEvent("fa-bobcat:search_crate_1")
AddEventHandler("fa-bobcat:search_crate_1", function()
    local source = source
    
    if searched1 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("fa-bobcat:search_crate_1", source)
        searched1 = true
    end
end)

RegisterServerEvent("fa-bobcat:search_crate_2")
AddEventHandler("fa-bobcat:search_crate_2", function()
    local source = source
    
    if searched2 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("fa-bobcat:search_crate_2", source)
        searched2 = true
    end
end)

RegisterServerEvent("fa-bobcat:search_crate_3")
AddEventHandler("fa-bobcat:search_crate_3", function()
    local source = source
    
    if searched3 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("fa-bobcat:search_crate_3", source)
        searched3 = true
    end
end)

RegisterServerEvent("aspect:particleserver")
AddEventHandler("aspect:particleserver", function(method)
    TriggerClientEvent("aspect:ptfxparticle", -1, method)
end)

RegisterServerEvent('fa-bobcat:blow_door')
AddEventHandler('fa-bobcat:blow_door', function()
    if not pCanBlow then
        pCanBlow = true
        TriggerClientEvent('fa-heists:explosion_ped_walk', source)
    end
end)

RegisterServerEvent('fa-heists:bobcatLog')
AddEventHandler('fa-heists:bobcatLog', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** faye [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing Bobcat Security",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012083045362315294/zediHwvM85za47VQMbE2pFzan7E0FGKScelN0ue9s2CTYTXSRsXhJ1kPA1EQwHUc4rnQ", function(err, text, headers) end, 'POST', json.encode({username = "faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)