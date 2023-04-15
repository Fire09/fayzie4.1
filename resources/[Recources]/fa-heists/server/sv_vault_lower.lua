AddEventHandler("explosionEvent", function(sender, ev)
    TriggerClientEvent('fa-vaultrob:lower:vaultdoor', sender)
end)