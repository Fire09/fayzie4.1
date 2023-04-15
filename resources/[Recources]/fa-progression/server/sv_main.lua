
RPC.register("np:progression:character:init", function(src)
    print("[Progression] - Progression Init")
    local progression = {}

    local user = exports["fa-base"]:getModule("Player"):GetUser(src) 
    local cid = user:getCurrentCharacter().id

    exports.oxmysql:execute("SELECT * FROM progression WHERE cid = @cid", {["cid"] = cid}, function(result)
        if result[1] ~= nil then
            progression = {
                rep = json.decode(result[1].rep),
                buffs = json.decode(result[1].buffs),
                skills = json.decode(result[1].skills),
            }
        end
    end)

    Citizen.Wait(250)
    return progression
end)

RPC.register("np:progression:update", function(src, pSystem, pValue)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src) 
    local cid = user:getCurrentCharacter().id
    if pSystem == "rep" then
        local affectedRows = MySQL.update.await([[
            UPDATE progression
            SET rep = ?
            WHERE cid = ?
        ]],
        { pValue, cid })
        return true
    elseif pSystem == "buffs" then
        affectedRows = MySQL.update.await([[
            UPDATE progression
            SET buffs = ?
            WHERE cid = ?
        ]],
        { pValue, cid })
        return true
    elseif pSystem == "skills" then
        affectedRows = MySQL.update.await([[
            UPDATE progression
            SET skills = ?
            WHERE cid = ?
        ]],
        { pValue, cid })
        return true
    end
    return false
end)