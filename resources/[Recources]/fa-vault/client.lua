RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    cb('ok')
end)

function OpenVaultGame(callback, lenght, time)
  Callbackk = callback
	SetNuiFocus(true, true)
	SendNUIMessage({type = "open", lenght = lenght, time = time})
end

-- /vault [lenght] [full time]
-- RegisterCommand("vault",function(source, args, raw)
--   exports['arp-vault']:OpenVaultGame(function(success)
--     if success then
--       print("basarili")
--     else
--       print("basarisiz")
--     end
--   end, tonumber(args[1]), tonumber(args[2]))
-- end)