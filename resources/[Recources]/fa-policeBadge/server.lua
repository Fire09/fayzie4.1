RegisterServerEvent("fa-policeBadge:showBadge")
AddEventHandler("fa-policeBadge:showBadge", function()
  local src = source
  local src = source
  local user = exports['fa-base']:GetModule('GetPlayer')(src)
  local cid = user["PlayerData"]["id"] 

  local name = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
  exports.oxmysql:execute('SELECT * FROM characters WHERE id = ?', {cid}, function(result)
    local imgLink = result[1].profilepic
    exports.oxmysql:execute('SELECT * FROM character_jobwhitelist WHERE cid = ?', {cid}, function(result)
      local callsign = result[1].callsign
      if result[1].job == "police" or result[1].job == 'state' or result[1].job == 'sheriff' then
        TriggerClientEvent('icemallow-badge:badgeanim', src)
        TriggerClientEvent('icemallow-badge:open', -1, name, imgLink, callsign, src)
      else
        TriggerClientEvent("DoLongHudText", src, 'This is not your badge',1)
      end
    end)
  end)  
end)
