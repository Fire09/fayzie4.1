Citizen.CreateThread(function()
    while true do
        DistantCopCarSirens(false)
        CancelCurrentPoliceReport()
        Citizen.Wait(400)
    end
end)
