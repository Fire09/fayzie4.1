RegisterNetEvent('fa-garbage:payGroupAndMembers', function()
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-garbage:payClients', v)
                end
            end
        end)
        return
    end
end)

RegisterNetEvent('fa-garbage:sendReturnBack', function(selectedZone, pStarting)
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-garbage:StartJob_CL', v, selectedZone)
                end
            end
        end)
        return
    end
end)

RegisterNetEvent('fa-garbage:StartJob_SV', function(selectedZone, pStarting)
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-garbage:StartJob_CL', v, selectedZone)
                end
            end
        end)
        return
    end
end)

RegisterNetEvent('fa-garbage:RemoveTrash', function()
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local otherSrc = user:getCurrentCharacter().source
        local groupId = exports['fa-phone']:GetMyGroupID(otherSrc)
        local currentGroupID
        
        if exports['fa-phone']:GetMyGroupID(pSrc) ~= 0 then
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        else
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        end

        Wait(1)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {currentGroupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-garbage:RemovePickedUpTrash', v)
                end
            end
        end)
        return
    end
end)

RegisterNetEvent('fa-garbage:SetState', function(tStatus)
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local otherSrc = user:getCurrentCharacter().source
        local groupId = exports['fa-phone']:GetMyGroupID(otherSrc)
        local currentGroupID
        
        if exports['fa-phone']:GetMyGroupID(pSrc) ~= 0 then
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        else
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        end

        Wait(1)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {currentGroupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    if not tStatus then
                        TriggerClientEvent('fa-garbage:ToggleTrunkStatus', v, tStatus)
                    end
                end
            end
        end)
        return
    end
end)

RegisterNetEvent('fa-garbage:ResetState', function()
    local pSrc = source

    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local otherSrc = user:getCurrentCharacter().source
        local groupId = exports['fa-phone']:GetMyGroupID(otherSrc)
        local currentGroupID
        
        if exports['fa-phone']:GetMyGroupID(pSrc) ~= 0 then
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        else
            currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
        end

        Wait(1)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {currentGroupID}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-garbage:ToggleTrunkStatus', v, false)
                end
            end
        end)
        return
    end
end)