local Groups = {}
local GroupInvite = {}

RPC.register("fa-phone:getIdleGroup", function(source, cJob)
    local src = source
    local idle = {}
    local g = MySQL.query.await([[
        SELECT * FROM job_group WHERE status = 0 AND job = ?
    ]],{cJob})
    for i, v in pairs(g) do
        table.insert(idle, {
            id = v.id,
            src = v.src,
            name = v.name,
            members = json.decode(v.members),
            status = v.status,
            leader = v.leader
        })
    end
    return idle
end)

RPC.register("fa-phone:getBusyGroup", function(source, cJob)
    local src = source
    local busy = {}
    local g = MySQL.query.await([[
        SELECT * FROM job_group WHERE status = 1 AND job = ?
    ]],{cJob})
    for i,v in pairs(g) do
        table.insert(busy, {
            id = v.id,
            src = v.src,
            name = v.name,
            members = json.decode(v.members),
            status = v.status,
            leader = v.leader
        })
    end
    return busy
end)

RPC.register('fa-phone:getGroupLeader', function(source)
    local gLeader = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]],{source})
    return gLeader[1].leader
end)

RPC.register("fa-phone:getMyGroup", function(source)
    local src = source
    local myGroup = {}
    local g = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]],{src})
    for i,v in pairs(g) do
        table.insert(myGroup, {
            id = v.id,
            src = v.src,
            name = v.name,
            members = json.decode(v.members),
            status = v.status,
            leader = v.leader
        })
    end
    return myGroup
end)

RPC.register("fa-phone:c_group", function(source)
    local src = source    
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    
    local cid = user:getCurrentCharacter().id
    local name = getFullName(cid)
    local group = {src}
    local job = user:getVar("job")

    local result = MySQL.query.await([[
         INSERT INTO job_group 
         (src, leader , name, members, status, job)
         VALUES
         (?, ?, ?, ?, ?, ?) ]],
          {src, cid, name, json.encode(group), 0, job})
    Wait(100)
    TriggerClientEvent('refreshJobCenter', -1)
end)

--TO DO could move to characters on fw  
function getFullName(cid)
    local name = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],{cid})

    return name[1].first_name.." "..name[1].last_name
end

RPC.register("fa-phone:getGroupsCount", function(source)
    local groups = MySQL.query.await([[
        SELECT job
        FROM job_group
    ]])
    return groups
end)

RPC.register("fa-phone:joinGroup_Accepted", function(source, pSrc, id, jCount)
    local src = source
    local user = exports['fa-base']:getModule('Player'):GetUser(pSrc)
    local cid = user:getCurrentCharacter().id
    local gId = id
    local group = getMembers(gId)
    local name = user:getCurrentCharacter().first_name .. ' '.. user:getCurrentCharacter().last_name

    exports.oxmysql:execute("SELECT COUNT(group_id) FROM group_members WHERE group_id = ?", {gId}, function(result)
        if result ~= jCount then
            if existInGroup(cid) then 
                return
            end

            for k,v in pairs(GroupInvite) do
                if(tonumber(v.StateID) == src) then
                    GroupInvite[k] = nil
                end
            end
        
            for i=1, #group do
                local mem = Groups[i]
                table.insert(group[i]['members'], pSrc)
                local inMember = group[i]['members']
                updateGroup(gId,inMember)
            end
            insertMember(pSrc,gId,cid,name)
        
            Wait(1)
        
            for k, v in pairs(GetPlayers()) do
                local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
                local cid = user:getCurrentCharacter().id
                local groupId = id
                local currentGroupID
                
                if exports['fa-phone']:GetGroupID(pSrc) ~= 0 then
                    currentGroupID = exports['fa-phone']:GetGroupID(pSrc)
                else
                    currentGroupID = exports['fa-phone']:GetMyGroupID(pSrc)
                end
        
                Wait(1)
        
                exports.oxmysql:execute("SELECT members, src FROM job_group WHERE id = ?", {currentGroupID}, function(result)
                    if result[1] ~= nil then
                        local jobMembers = json.decode(result[1].members)
                        for k,v in ipairs(jobMembers) do
                            TriggerClientEvent('refreshJobCenter', v)
                            TriggerClientEvent('refreshJobCentertwo', pSrc)
                        end
                    end
                end)
                return
            end
        else
            TriggerClientEvent('DoLongHudText', src, 'Your group is already full!', 2)
        end
    end)
end)

RPC.register("fa-phone:j_group_decline", function(source)
    local src = source
    for k,v in pairs(GroupInvite) do
        if(tonumber(v.StateID) == src) then
            GroupInvite[k] = nil
        end
    end
end)

RPC.register("fa-phone:j_group", function(source, id, cid)
    local pSrc = source
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local name = user:getCurrentCharacter().first_name .. ' '.. user:getCurrentCharacter().last_name

    exports.oxmysql:execute("SELECT src FROM job_group WHERE id = ?", {id}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(GroupInvite) do
                if v.StateID == tonumber(result[1].src) then
                    TriggerClientEvent('DoLongHudText', pSrc, 'The group you are trying to join has a pending invite please wait!', 2)
                    return
                end
            end

            TriggerClientEvent('fa-phone:CreateGroupInvite', tonumber(result[1].src), 'Group Request', name .. ' Accept?', pSrc, id)
            table.insert(GroupInvite, {StateID = tonumber(result[1].src)})
        end
    end)
end)

existInGroup = function(cid)
    local result = MySQL.query.await([[
        SELECT group_id
        FROM group_members 
        WHERE cid = ?
    ]], {cid})

    return (result[1] ~= null ) or false
end


function updateGroup(gId,inMember) 
    local updatedGroupJob = MySQL.query.await([[
        UPDATE job_group
        SET members = ?
        WHERE id = ?
    ]],
    { json.encode(inMember),gId })

    if not updatedGroupJob.affectedRows or updatedGroupJob.affectedRows < 1 then
        return false, "affectedRows ~= 1"
    end
end

function getMembers(gId)
    local mems = {}
    local result = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE id = ?
    ]],{gId})
    for i=1, #result do
        local Group = {}
        Group['id'] = tonumber(result[i]['id'])
        Group['src'] = result[i]['src']
        Group['name'] = result[i]['name']
        Group['members'] = json.decode(result[i]['members'])
        Group['status'] = tonumber(result[i]['status'])
        table.insert(mems, Group)
    end

    return mems
end

function GetGroupId(src)
    result = 0
    local group = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]], {src})

    local memgrp = MySQL.query.await([[
        SELECT * FROM group_members
        WHERE src = ?
    ]], {src})

    if group[1] ~= nil then 
        result = group[1].id
    else
        result = memgrp[1].group_id
    end
    
    local connect = {
        {
          ["color"] = color,
          ["title"] = "** [ASPECT TESTING] | GROUPED JOBS **",
          ["title"] = "Group ID: "..result.." \n Group Members: "..group[1].members
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1045841843939721216/suw_TBSKpMTuhJHaLH9vUjEX_-PM7UOuBOU6Zo2Z-D-J9RDGE6HcDAKQiAWwKxzUvSmh", function(err, text, headers) end, 'POST', json.encode({username = "Endless RP", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/476423150817771526/1026844730488787045/Endless-2.png"}), { ['Content-Type'] = 'application/json' })

    return result
end

groupInfo = function(cid) 

    local leader = MySQL.query.await([[
      SELECT * FROM job_group
      WHERE leader = ?
    ]], {cid})


    if leader[1] ~= nil then return leader[1] end

    
    local result = MySQL.query.await([[
        SELECT *
        FROM group_members m
        INNER JOIN job_group g 
        on g.id = m.group_id
        WHERE cid = ?
    ]], {cid})

    if result[1] ~= nil then return result[1] end 

    print("ERROR")
  
end

RPC.register('fa-phone:setGroupStatus', function(source, status, charName)
    exports.oxmysql:execute('SELECT * FROM job_group WHERE name = @nom', {
        ['nom'] = charName
    }, function(result)
        MySQL.query.await([[
        UPDATE job_group
        SET status = ? 
        WHERE id = ?
    ]], {status, result[1].id})
    end)
end)

RPC.register("fa-phone:get_groupsMem", function(source)
    local src = source
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local cid = user:getCurrentCharacter().id

    local mem = MySQL.query.await([[
        SELECT k.id, k.cid, k.group_id, k.src, k.name, h.name, h.src, h.status
        FROM group_members k
        INNER JOIN job_group h ON h.id = k.group_id
        WHERE k.cid = ?
    ]],{cid})
    
    if mem[1] == nil or mem[1] == null then
        local gId = getLGroup(src)
            local members = MySQL.query.await([[
                SELECT * FROM
                group_members
                WHERE group_id = ?
            ]],{gId})
        return groupers(members)
    end
    if mem[1].src ~= src then
        local members = {}
        local gStuff = MySQL.query.await([[
            SELECT * FROM group_members
            WHERE group_id = ?
        ]],{mem[1].group_id})

        if gStuff[1] ~= nil then

            for i, v in pairs(gStuff) do
                table.insert(members, {
                    id = v.id,
                    src = v.src,
                    name = v.name,
                    cid = v.cid,
                    group_id = v.group_id
                })
            end
        end
        return members   
    end
    return groupers(mem)
end)

function getLGroup(src)
    local group = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]],{src})

    if group[1] ~= nil then
        return group[1].id
    end
end

function groupers(group)
    groups = {}

    for i,k in pairs(group) do
        table.insert(groups,{
            id = k.id,
            cid = k.cid,
            gid = k.group_id,
            src = k.src,
            name = k.name
        })
    end
 
    return groups
end

function insertMember(src,gid,cid,name)
    if existInGroup(cid) then 
        return
    end

    MySQL.query.await([[
        INSERT INTO group_members
        (cid, group_id, src, name)
        VALUES
        (?, ?, ?, ?)
    ]], {cid, gid, src, name})
end

RPC.register('fa-phone:getGroupTask', function(source)
    local src = source 
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local cid = user:getCurrentCharacter().id
    local groupinfo = groupInfo(cid) 
    if groupinfo == 0 then 
        return nil -- not ready state
    end
    return groupinfo.task_id
end)

RPC.register('fa-phone:updateGroupTask', function(source, tsk)
    local src = source 
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local cid = user:getCurrentCharacter().id
    local groupinfo = groupInfo(cid) 
    if groupinfo.status == 0 then 
        return 
    end
    MySQL.query.await([[
        UPDATE job_group
        SET task_id = ?
        WHERE id = ?
    ]], {tsk, groupinfo.id})

end)

RPC.register('fa-phone:leave_group', function(source, id)
    local src = source
    local gId = id

    local getLeader = MySQL.query.await([[
        SELECT src FROM job_group
        WHERE src = ?
    ]],{src})

    if getLeader[1] ~= nil then

        for k, v in pairs(GetPlayers()) do
            local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
            local cid = user:getCurrentCharacter().id
            local groupId = id
            local currentGroupID
            
            if exports['fa-phone']:GetGroupID(src) ~= 0 then
                currentGroupID = exports['fa-phone']:GetGroupID(src)
            else
                currentGroupID = exports['fa-phone']:GetMyGroupID(src)
            end
    
            Wait(1)
    
            exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {currentGroupID}, function(result)
                if result[1] ~= nil then
                    local jobMembers = json.decode(result[1].members)
                    for k,v in ipairs(jobMembers) do
                        TriggerClientEvent('refreshJobCenter', v)
                        TriggerClientEvent('fa-phone:CancelJob', v, 1)
                    end

                    Wait(1000)

                    local affectedRows = MySQL.query.await([[
                        DELETE FROM job_group
                        WHERE src = ?
                    ]],
                    {src})
                    local affectedRows = MySQL.query.await([[
                        DELETE FROM group_members
                        WHERE group_id = ?
                    ]],
                    {gId})
                    Wait(100)
                    TriggerClientEvent('refreshJobCenter', -1)
                end
            end)
            return
        end
    else
        for k, v in pairs(GetPlayers()) do
            local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
            local cid = user:getCurrentCharacter().id
            local groupId = id
            local currentGroupID
            
            if exports['fa-phone']:GetGroupID(src) ~= 0 then
                currentGroupID = exports['fa-phone']:GetGroupID(src)
            else
                currentGroupID = exports['fa-phone']:GetMyGroupID(src)
            end
    
            Wait(1)
    
            exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {currentGroupID}, function(result)
                if result[1] ~= nil then
                    local jobMembers = json.decode(result[1].members)
                    for k,v in ipairs(jobMembers) do
                        TriggerClientEvent('refreshJobCenter', v)
                    end

                    TriggerClientEvent('fa-phone:CancelJob', src, 0)
                    Wait(1000)
                    local affectedRows = MySQL.query.await([[
                        DELETE FROM group_members
                        WHERE src = ?
                    ]],
                    {src})
                    removeMember(gId,src)
                    Wait(100)
                    TriggerClientEvent('refreshJobCenter', -1)
                end
            end)
            return
        end
    end
end)

function removeMember(gId,pSrc)
    exports.oxmysql:execute("SELECT `members` FROM job_group WHERE id = @id", {['id'] = gId}, function(result)
        local update_members = json.decode(result[1].members)
        local index = {}

        for k,v in pairs(update_members) do
            index[v] = k
        end

        table.remove(update_members, index[pSrc])

        exports.oxmysql:execute("UPDATE job_group SET `members` = @members WHERE `id` = @id", {
            ['@members'] = json.encode(update_members),
            ['@id'] = gId
        })
    end)
end

RPC.register('fa-phone:hasJobOffered', function(source) 
    -- We have an job ?  
    return true
end)

function GetGroupIdOther(src)
   
    local group = MySQL.query.await([[
        SELECT * FROM group_members
        WHERE src = ?
    ]],{src})

    local result = 0;

    if group[1] ~= nil then 
        result = group[1].group_id
    end
    
    return result
end

function GetGroupOwner(info)
    local ownerSrc = 0
    exports.oxmysql:execute("SELECT src FROM job_group WHERE id = ?", {info}, function(result)
        if result[1] ~= nil then
            ownerSrc = result[1].src
        else
            ownerSrc = info 
        end
    end)
    Wait(1)
    return ownerSrc
end

exports('GetGroupOwner', function(info)
    return GetGroupOwner(tonumber(info))
end)

exports('GetGroupID', function(info)
    return GetGroupIdOther(tonumber(info))
end)

exports('GetMyGroupID', function(info)
    return GetGroupId(tonumber(info))
end)

RPC.register('fa-phone:group_CheckOut', function(source)
    local pSrc = source
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local job = user:getVar("job")

    Wait(100)
    TriggerClientEvent('refreshJobCenter', pSrc)

    exports.oxmysql:execute('DELETE FROM job_group WHERE src = @Sauce', {
        ['Sauce'] = pSrc
    })
end)

AddEventHandler("playerDropped", function(reason)
    local pSrc = source

    exports.oxmysql:execute("SELECT `src`, `id` FROM job_group WHERE src = @src", {['src'] = pSrc}, function(result)
        if result[1] ~= nil then
            local affectedRows = MySQL.query.await([[
                DELETE FROM job_group
                WHERE src = ?
            ]],
            {pSrc})
            local affectedRows = MySQL.query.await([[
                DELETE FROM group_members
                WHERE group_id = ?
            ]],
            {result[1].id})
        else
            exports.oxmysql:execute("SELECT `group_id` FROM group_members WHERE src = @src", {['src'] = pSrc}, function(data)
                if data[1] ~= nil then
                    exports.oxmysql:execute("SELECT `members` FROM job_group WHERE id = @id", {['id'] = data[1].group_id}, function(jobinfo)
                        local update_members = json.decode(jobinfo[1].members)
                        local index = {}
                
                        for k,v in pairs(update_members) do
                            index[v] = k
                        end
                
                        table.remove(update_members, index[pSrc])
                
                        exports.oxmysql:execute("UPDATE job_group SET `members` = @members WHERE `id` = @id", {
                            ['@members'] = json.encode(update_members),
                            ['@id'] = data[1].group_id
                        })

                        local affectedRows = MySQL.query.await([[
                            DELETE FROM group_members
                            WHERE src = ?
                        ]],
                        {pSrc})
                    end)
                end
            end)
        end
    end)
end)

Citizen.CreateThread(function()
    exports.oxmysql:execute('DELETE FROM job_group', function(deleteGroups) end)
    exports.oxmysql:execute('DELETE FROM group_members', function(deleteGroupMembers) end)
end)
