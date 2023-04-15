local hmm = vehicleBaseRepairCost

RegisterServerEvent('fa-bennys:attemptPurchase')
AddEventHandler('fa-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)

            exports["fa-log"]:AddLog("Bennys", 
                src, 
                "Repair", 
                { amount = tostring(hmm) })
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])

            exports["fa-log"]:AddLog("Bennys", 
                src, 
                "Performance", 
                { amount = tostring(vehicleCustomisationPrices[type].prices[upgradeLevel]) })
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].price)

            exports["fa-log"]:AddLog("Bennys", 
                src, 
                "Other", 
                { type = tostring(type), amount = tostring(vehicleCustomisationPrices[type].price) })
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('fa-bennys:updateRepairCost')
AddEventHandler('fa-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('fa-bennys:repairciv')
AddEventHandler('fa-bennys:repairciv', function(amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", src)

        exports["fa-log"]:AddLog("Bennys", 
            src, 
            "Repair Civ", 
            { amount = tostring(amount) })
    end
end)

RegisterServerEvent('fa-bennys:payPublicBennys')
AddEventHandler('fa-bennys:payPublicBennys', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)

    if user:getCash() >= 250 then
        user:removeMoney(250)
        TriggerClientEvent('fa-bennys:repairVeh', src)
        TriggerEvent('DoLongHudText', "You Have Been Charged For: $750!", 2)
    else
        TriggerClientEvent('DoLongHudText', src, 'You need $750', 2)
    end
end)
