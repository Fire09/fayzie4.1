RPC.register('fa-jobs:setNotificiationForGroupMembersDelivery', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-phone:setNotiGroupJobDeliveries', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:getStoreForJobDeliveries', function(source, storeNum)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:getDeliveryJobDeliveries', v, storeNum)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:grabGoodsDelivieries', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-phone:groupedJobsGrabGoodsDelivieries', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:grabbedGoodsDeliveries', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    print('fa-jobs:dropGoodsInStoreDeliveries | Should be sent for the group members.')
                    TriggerClientEvent('fa-jobs:dropGoodsInStoreDeliveries', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:returnDepoDeliveries', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:deliveryReturnToDepoDeliveries', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:dropGoodsDelivieries', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:groupSyncDropGoods', v)
                end
            end
        end)
        return
    end
end)