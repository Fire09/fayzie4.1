DPX.SpawnManager = {}

RegisterServerEvent('fa-base:spawnInitialized')
AddEventHandler('fa-base:spawnInitialized', function()
    local src = source
    TriggerClientEvent('fa-base:spawnInitialized', src)
end)