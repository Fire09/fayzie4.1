RPC.register('fa-activities:syncOxyStart', function(source, location)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:startOxy', v, location)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:syncPackageCollect', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:collectPackageSync', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:syncGenCornerLoc', function(source, location)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:generateFirstOxyDropoff', v, location)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:sendHandoffGroupMembers', function(source, location)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:syncHandoff', v, location)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:generateNewCornerLoc', function(source, location)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:generateSecondOxyDropoff', v, location)
                end
            end
        end)
        return
    end
end)