RPC.register('fa-jobs:towtruckingGetJob', function(source, jobLocation)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:towingGetJob', v, jobLocation)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:towtruckingReturnImpound', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)
        
        exports.oxmysql:execute('SELECT members FROM job_group WHERE id = ?', {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do 
                    TriggerClientEvent('fa-jobs:sendClientReturnImpound', v)
                end
            end
        end)
    end
end)

RPC.register('fa-jobs:syncVehiclePlateImpound', function(source, pPlate)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)
        
        exports.oxmysql:execute('SELECT members FROM job_group WHERE id = ?', {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do 
                    TriggerClientEvent('fa-jobs:towTruckPlateSync', v, pPlate)
                end
            end
        end)
    end
end)

RPC.register('fa-jobs:towTruckingAcceptImpoundOffer', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)
        
        exports.oxmysql:execute('SELECT members FROM job_group WHERE id = ?', {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do 
                    TriggerClientEvent('fa-jobs:acceptImpoundOffer', v)
                end
            end
        end)
    end
end)

RPC.register('fa-jobs:towTruckingDeclineImpoundOffer', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)
        
        exports.oxmysql:execute('SELECT members FROM job_group WHERE id = ?', {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do 
                    TriggerClientEvent('fa-jobs:rejectImpoundRequest', v)
                end
            end
        end)
    end
end)