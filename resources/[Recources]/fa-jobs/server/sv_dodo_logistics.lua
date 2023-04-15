RegisterServerEvent('fa-jobs:dodoLogisticsPayout')
AddEventHandler('fa-jobs:dodoLogisticsPayout', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local payment = math.random(250, 325)

    user:addBank(payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)
end)

RPC.register('fa-jobs:dodoStarted', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:sendDodoNoti', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:getADeliveryLocationDodo', function(source, location)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:dodoLogisticsGetJob', v, location)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:returnBackDodoDock', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:returningDodo', v)
                end
            end
        end)
        return
    end
end)