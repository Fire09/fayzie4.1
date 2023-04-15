recentCalls = {}

RegisterNetEvent("fa-phone:sendRecentCalls", function(pRecentCalls, pCid)
    recentCalls[pCid] = pRecentCalls
end)

RPC.register("fa-phone:getRecentCallsByCid", function(pSource, pCid)
    return recentCalls[pCid]
end)

RPC.register("fa-phone:getRecentCallsByNumber", function(pSource, pNum)
    for k,v in pairs(recentCalls) do
        -- todo
    end
end)

RPC.register('fa-phone:getTextsFromNumber', function(pSource, pCid)
    local src = source
    local myNumber = getNumber(pCid)
    return getSMS(myNumber), myNumber
end)