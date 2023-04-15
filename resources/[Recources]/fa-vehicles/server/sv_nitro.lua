
RegisterServerEvent('fa-nitro:server:particlefx')
AddEventHandler('fa-nitro:server:particlefx', function(veh)
     TriggerClientEvent('fa-nitro:client:particlefx', -1, veh)
end)

RegisterServerEvent('fa-nitro:server:particlefisfis')
AddEventHandler('fa-nitro:server:particlefisfis', function(type, veh)
     if type == 'fisfisacc' then
          TriggerClientEvent('fa-nitro:client:particlefisfis', -1, 'fisfisac', veh)
     elseif type == 'fisfiskapatt' then
          TriggerClientEvent('fa-nitro:client:particlefisfis', -1, 'fisfiskapat', veh)
     end
end)