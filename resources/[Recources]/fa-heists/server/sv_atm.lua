RegisterServerEvent('fa-pettycrime:atm:moneyreward')
AddEventHandler('fa-pettycrime:atm:moneyreward', function(money)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	if user:getCash() >= money then
        user:addMoney(money)
	end
end)

RegisterServerEvent("fa-pettycrime:atm:clrspawn")
AddEventHandler("fa-pettycrime:atm:clrspawn", function()
    TriggerClientEvent("fa-pettycrime:atm:clrspawn", -1)
end)

RegisterServerEvent("fa-pettycrime:atm:attachRope")
AddEventHandler("fa-pettycrime:atm:attachRope", function(pr1, pr2)
    TriggerClientEvent("fa-pettycrime:atm:attachRope", -1, pr1, pr2)
end)

RegisterServerEvent("fa-pettycrime:atm:attachRope2")
AddEventHandler("fa-pettycrime:atm:attachRope2", function(dpratm, atmco1, atmco2, atmco3, netveh, propsdad)
    TriggerClientEvent("fa-pettycrime:atm:attachRope2", -1, dpratm, atmco1, atmco2, atmco3, netveh, propsdad)
end)

RegisterServerEvent("fa-pettycrime:atm:prop")
AddEventHandler("fa-pettycrime:atm:prop", function(ObjNet)
    TriggerClientEvent("fa-pettycrime:atm:prop", -1, ObjNet)
end)

RegisterServerEvent("fa-pettycrime:atm:delete")
AddEventHandler("fa-pettycrime:atm:delete", function(ATMObjectDelete)
    TriggerClientEvent("fa-pettycrime:atm:delete", -1, ATMObjectDelete)
end)

RegisterServerEvent("fa-fa-pettycrime:atm:deleteRope")
AddEventHandler("fa-fa-pettycrime:atm:deleteRope", function(rope)
    TriggerClientEvent("fa-fa-pettycrime:atm:deleteRope", -1, rope)
end)