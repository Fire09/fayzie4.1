local ActivePlayers = {}

function DoesSourceExist(pPlayerId)
    return ActivePlayers[pPlayerId]
end

RegisterServerEvent("fa-base:spawnInitialized")
AddEventHandler("fa-base:spawnInitialized",function()
    local src = source

    ActivePlayers[src] = true
    TriggerClientEvent("onPlayerJoining", src, src)
end)

AddEventHandler("playerDropped", function()
    local src = source
    ActivePlayers[src] = nil
end)

function GetPlayerCoords(pServerId)
    return exports['fa-infinity']:GetPlayerCoords(pServerId)
end

function GetNearbyPlayers(pCoords, pRadius)
    local pData = exports["fa-infinity"]:CurrentPlayers()
    local returnData = {}

    for k, v in pairs(pData) do
        if #(vector3(pCoords.x, pCoords.y, pCoords.z) - vector3(v.x, v.y, v.z)) < pRadius then
            table.insert(returnData, k)
        end
    end
    return returnData
end