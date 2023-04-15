local activeChannels = {}
local channelSubscribers = {}

function addPlayerToAtc(pServerId, pFrequency)
    print(pFrequency)
    print("aDDING")
    if channelSubscribers[pServerId] then
        print("Removed server side")
        removePlayerFromAtc(pServerId, channelSubscribers[pServerId])
    end

    if activeChannels[pFrequency] == nil then
        print("Making data")
        activeChannels[pFrequency] = {}
        activeChannels[pFrequency]["subscribers"] = {}
    end

    for _, subscriber in ipairs(activeChannels[pFrequency]["subscribers"]) do
        print("Add to clint radio")
        TriggerClientEvent("fayzie:voice:atc:added", subscriber, pFrequency, pServerId)
    end

    table.insert(activeChannels[pFrequency]["subscribers"], pServerId)

    channelSubscribers[pServerId] = pFrequency
    
    print("Connect ")
    TriggerClientEvent("fayzie:voice:atc:connect", pServerId, pFrequency, activeChannels[pFrequency]["subscribers"])
end

function removePlayerFromAtc(pServerId, pFrequency)
    local pFrequency = 118.0
    if not activeChannels[pFrequency] then return end

    for index, subscriber in ipairs(activeChannels[pFrequency]["subscribers"]) do
        if pServerId == subscriber then
            table.remove(activeChannels[pFrequency]["subscribers"], index)
        end
    end

    if #activeChannels[pFrequency]["subscribers"] == 0 then
        activeChannels[pFrequency] = nil
    else
        for _, subscriber in ipairs(activeChannels[pFrequency]["subscribers"]) do
            print("SDFGsfdgsdjkfgbisdfbg ksfdgiusfiughsifhrgi sf hg")
            TriggerClientEvent("fayzie:voice:atc:removed", subscriber, pFrequency, pServerId)
        end
    end

    channelSubscribers[pServerId] = nil
end

RegisterNetEvent("AddPlayerToAtc")
AddEventHandler("AddPlayerToAtc", function(pFrequency, pServerId)
    print("HELLO")
    if pFrequency > 0 then
        addPlayerToAtc(pServerId, pFrequency)
    else
        if channelSubscribers[pServerId] then
            removePlayerFromAtc(pServerId, channelSubscribers[pServerId])
        end
    end
end)

RegisterNetEvent("RemovePlayerFromAtc")
AddEventHandler("RemovePlayerFromAtc", function(pServerId)
    removePlayerFromAtc(pServerId, channelSubscribers[pServerId])
end)

AddEventHandler("playerDropped", function(source, reason)
    if channelSubscribers[source] then
        removePlayerFromAtc(source, channelSubscribers[source])
    end
end)

RegisterCommand("activeChannels", function(src, args, raw)
    print(DumpTable(activeChannels))
end, true)

RegisterCommand("channelSubscribers", function(src, args, raw)
    print(DumpTable(channelSubscribers))
end, true)