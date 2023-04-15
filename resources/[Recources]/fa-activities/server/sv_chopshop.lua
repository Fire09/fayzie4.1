RegisterServerEvent("fa-chopshop:vehicle_loot")
AddEventHandler("fa-chopshop:vehicle_loot", function(string)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local Reward= math.random(1500, 2000)
    if string == "tyre" then
        TriggerClientEvent("player:receiveItem", src, "recyclablematerial", math.random(8, 15), false)
    elseif string == "door" then
        TriggerClientEvent("player:receiveItem", src, "recyclablematerial", math.random(8, 15), false)
    end
end)

RPC.register('fa-activities:updateChopNotiAndBlip', function(source, chopVeh, x, y, z)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:createBlipLocationChopshop', v, x, y, z, chopVeh)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:updateChopDriveDropOff', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:syncDriveDropLocation', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:updateChopBones', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:StartTheChopCL', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:updateChopNoti', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('sendUpdatedNoti2Chop', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:chopComplete', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    local roll = math.random(1, 2)
                    if roll == 1 then
                        TriggerClientEvent('player:receiveItem', src, 'recyclablematerial', math.random(2, 8))
                    elseif roll == 2 then
                        TriggerClientEvent('player:receiveItem', src, 'recyclablematerial', math.random(20, 35))
                    end

                    Citizen.Wait(2500)
                    TriggerClientEvent('player:receiveItem', src, 'rollcash', math.random(5, 20))
                end
            end
        end)
        return
    end
end)