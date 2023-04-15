RegisterNUICallback('getDiamondSportsEvents', function(data,cb)
    local returnEvents = RPC.execute("fa-phone:getDiamondSportsEvents")
    SendNUIMessage({
        openSection = "diamondSportsAppend",
        diamondSports = returnEvents,
        canMakeDiamondEvents = exports['fa-business']:IsEmployedAt('the_diamond')
    })
end)

RegisterNUICallback('submitNewEventDiamondSports', function(data, cb)
    RPC.execute("fa-phone:submitNewEventDiamondSports", data.pEventName, data.pEventLocation, data.pTimeZone, data.pEventTimeHr, data.pEventTimeMin, data.pEventDate)
end)

RegisterNUICallback('deleteDiamondEvent', function(data, cb)
    RPC.execute("fa-phone:deleteDiamondEvent", data.diamondEventID)
end)