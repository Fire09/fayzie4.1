
RegisterNetEvent("fa-hud:openSettings")
AddEventHandler("fa-hud:openSettings", function()
    SetNuiFocus(true, true)
    SendReactMessage('toggleSettings', {
        show = true
    })
end)

RegisterNUICallback('hideFrame', function()
    SetNuiFocus(false, false)
end)