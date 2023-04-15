toggled = false
toggledReport = false

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

Conditions = {
    ["ALL"] = function(src, params, infos)
        return true
    end,
    ["JOB"] = function(src, params, infos)
        if has_value(params["jobs"], infos["job"]) then
            return true
        else
            return false
        end
    end,
    ["ADMIN"] = function(src, params, infos)
        local user = exports["fa-base"]:getModule("Player"):GetUser(src)
        local userRank = exports["fa-lib"]:getUserRank(src)
        local defaultPower = exports["fa-admin"]:getRank("user");
        local userPower = exports["fa-admin"]:getRank(userRank);
        if infos["rank"] then
            if (userPower > defaultPower) then
                return true
            else
                return false
            end
        else
            return false
        end
    end,
}

AddEventHandler('_chat:messageEntered', function(author, color, message, data)
    local src = source
    local isCmd = string.sub(message, 1, 1) == "/" and true or false
    
    if not message or not author then
        return
    end
    
    TriggerEvent('chatMessage', src, author, message)
    
    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author, {255, 255, 255}, message)
    end
    
    local args = {}
    for word in string.gmatch(string.gsub(message, "/", ""), "%S+") do
        table.insert(args, word)
    end
    
    if not args[1] then return end
    
    local cmd = string.lower(args[1])
    table.remove(args, 1)
    
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    
    if not user then return end
    
    if Commands[cmd] then
        local infos = {
            ["rank"] = user:getVar("rank"),
            ["job"] = user:getVar("job"),
        }
        
        if Conditions[Commands[cmd]["condition"]["type"]](src, Commands[cmd]["condition"]["params"], infos) then
            Commands[cmd]["function"](src, args)
        end
    else
        TriggerClientEvent("chatMessage", src, "SYSTEM ", {255, 0, 0}, 'Invalid Command "' .. "/" .. cmd .. '"')
    end
end)

AddEventHandler("chatMessage", function(source, args, raw)
    CancelEvent()
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)
    
    TriggerEvent('chatMessage', source, name, '/' .. command)
    
    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, {255, 255, 255}, '/' .. command)
    end
    
    CancelEvent()
end)

-- command suggestions for clients
RegisterNetEvent("fa-commands:buildCommands")
AddEventHandler("fa-commands:buildCommands", function()
    local _src = source
    if _src then src = _src end
    
    local user = exports["fa-base"]:getModule("Player"):GetUser(_src)
    local suggestions = {}
    local infos = {
        ["rank"] = user:getVar("rank"),
        ["job"] = user:getVar("job"),
    }
    
    local suggestions = {}
    for k, v in pairs(Commands) do
        if v["condition"] then
            if v["suggestion"] then
                v["suggestion"]["name"] = "/" .. k
                table.insert(suggestions, v["suggestion"])
            end
        end
    end
    
    TriggerClientEvent("chat:addSuggestions", _src, suggestions)
end)

local function refreshCommands(player)
    local user = exports["fa-base"]:getModule("Player"):GetUser(player)
    local suggestions = {}
    local infos = {
        ["rank"] = user:getVar("rank"),
        ["job"] = user:getVar("job"),
    }
    
    local suggestions = {}
    for k, v in pairs(Commands) do
        if v["condition"] then
            if v["suggestion"] then
                v["suggestion"]["name"] = "/" .. k
                table.insert(suggestions, v["suggestion"])
            end
        end
    end
    
    TriggerClientEvent("chat:addSuggestions", player, suggestions)
end

RegisterServerEvent('fa-admin:server:SendReport')
AddEventHandler('fa-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local userRank = exports["fa-lib"]:getUserRank(src)
    local defaultPower = exports["fa-admin"]:getRank("user");
    local userPower = exports["fa-admin"]:getRank(userRank);
    if (userPower > defaultPower) then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            args = {"Report - ( Name  " .. name .. ' ) ( Id : ' .. targetSrc .. ' ) ( Msg : ' .. msg .. ' ) '},
            system = 'SYSTEM',
            multiline = true
        })
    end
end)

RegisterServerEvent('fa-admin:server:StaffChatMessage')
AddEventHandler('fa-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local userRank = exports["fa-lib"]:getUserRank(src)
    local defaultPower = exports["fa-admin"]:getRank("user");
    local userPower = exports["fa-admin"]:getRank(userRank);
    if (userPower > defaultPower) then
        TriggerClientEvent('chat:addMessage', src, {
            color = {0, 0, 255},
            args = {"Staff - " .. name, msg}
        })
    end
end)

-- AddEventHandler('chat:init', function()
--     local source = source
--     refreshCommands(source)
-- end)
-- AddEventHandler('onServerResourceStart', function(resName)
--     Wait(500)
--     for _, player in ipairs(GetPlayers()) do
--         refreshCommands(player)
--     end
-- end)
RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, Coords)
    TriggerClientEvent('Do3DText', -1, text, source, Coords)
    if logEnabled then
        setLog(text, source)
    end
end)
