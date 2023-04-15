local carBombTable = {}

RegisterNetEvent("fa-miscscripts:carbombs:removeBomb", function(pNetId)
    carBombTable[pNetId] = nil
end)

RegisterNetEvent("fa-usableprops:defusePhoneBomb", function(pNetId)
    carBombTable[pNetId] = nil
end)

RegisterNetEvent("fa-miscscripts:carbombs:foundBomb", function(pNetId, pMetaData)
    TriggerClientEvent("fa-miscscripts:carbombs:foundBombAll", -1, carBombTable[pMetaData.netId])
end)

RPC.register("fa-miscscripts:carbombs:addCarBomb", function(pSource, netId, minSpeed, ticksBeforeExplode, ticksForRemoval, gridSize, coloredSquares, timeToComplete)
    print(netId, minSpeed, ticksBeforeExplode, ticksForRemoval, gridSize, coloredSquares, timeToComplete)
    carBombTable[netId] = {
        carBombData = {
            minSpeed = minSpeed, 
            ticksBeforeExplode = ticksBeforeExplode, 
            ticksForRemoval = ticksForRemoval, 
            gridSize = gridSize, 
            coloredSquares = coloredSquares, 
            timeToComplete = timeToComplete,
            netId = netId,
            hasCarBomb = true,
        }
    }
end)

RPC.register("fa-miscscripts:carbombs:getCarBombDataFromNetID", function(pSource, netId)
    return carBombTable[netId]
end)

--[[ RPC.register("fa-usableprops:hasPhoneBomb", function(pSource, pNetId)
    print(pNetId)
    if carBombTable[pNetId] then
        return true
    end
    return false
end) ]]