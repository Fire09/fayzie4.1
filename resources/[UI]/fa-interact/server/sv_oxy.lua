RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)

	if user:getCash() >= money then
        user:removeMoney(money)

		TriggerClientEvent("oxydelivery:startDealing", src)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough for this', 2)
	end
end)

RegisterServerEvent('fa-illegalactivities:oxy_payment')
AddEventHandler('fa-illegalactivities:oxy_payment', function(PaymentAmount)
    local src = source
    local user = exports['fa-base']:getModule("Player"):GetUser(src)

    user:addMoney(PaymentAmount)
end)