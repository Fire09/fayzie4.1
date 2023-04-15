local firstCall = true

RegisterNUICallback("fa-hud:setKVPValue", function(data, cb)
  SetResourceKvp(data.key, json.encode(data.value))

  if firstCall then
    firstCall = false
    Wait(30000)
  end
  TriggerEvent("fa-hud:settings", data.key, data.value)
  cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("fa-hud:getKVPValue", function(data, cb)
  local result = GetResourceKvpString(data.key)
  local value = json.decode(result or "{}")
  cb({ data = { value = value }, meta = { ok = true, message = 'done' } })
end)

function GetPreferences()
  local result = GetResourceKvpString('fa-preferences')
  return json.decode(result or "{}")
end

exports('GetPreferences', GetPreferences)