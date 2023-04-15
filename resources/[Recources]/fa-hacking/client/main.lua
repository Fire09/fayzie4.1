local successCb
local failCb
local resultReceived = false

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        successCb()
    else
        failCb()
    end
    cb('ok')
end)


exports('hacking', function(success, fail)
    resultReceived = false
    successCb = success
    failCb = fail
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open"
    })
end)
