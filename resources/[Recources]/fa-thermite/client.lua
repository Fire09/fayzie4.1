RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    cb('ok')
end)

function OpenThermiteGame(callback, size, starttime, endtime)
  Callbackk = callback
  SetNuiFocus(true, true)
  if not exports['fa-hud']:IntelegenceBuff() then
    SendNUIMessage({type = "open", size = (6), starttime = (2), endtime = (20)})
  else
    SendNUIMessage({type = "open", size = (5), starttime = (2), endtime = (20)})
  end
end

function OpenThermiteGameBuff(callback, size, starttime, endtime)
  Callbackk = callback
  SetNuiFocus(true, true)
  SendNUIMessage({type = "open", size = (4), starttime = (2), endtime = (20)})
end

function OpenThermiteGameMeth(callback, size, starttime, endtime)
  Callbackk = callback
  SetNuiFocus(true, true)
  SendNUIMessage({type = "open", size = (6), starttime = (4), endtime = (40)})
end