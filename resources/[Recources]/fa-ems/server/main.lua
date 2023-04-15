RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('fa-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('fa-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('fa-ems:heal')
AddEventHandler('fa-ems:heal', function(target)
	TriggerClientEvent('fa-ems:heal', target) 	
end)

RegisterServerEvent('fa-ems:heal2')
AddEventHandler('fa-ems:heal2', function(target)
	TriggerClientEvent('fa-ems:big', target)
end)