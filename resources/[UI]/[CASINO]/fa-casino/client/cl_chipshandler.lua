RegisterNetEvent('fa-casino:giveChipsCL')
AddEventHandler('fa-casino:giveChipsCL', function(pAmt)
    TriggerServerEvent('fa-casino:giveChips', pAmt)
end)

RegisterNetEvent('fa-casino:removeChipsCL')
AddEventHandler('fa-casino:removeChipsCL', function(removeAmt)
    TriggerServerEvent('fa-casino:removeChips', removeAmt)
end)