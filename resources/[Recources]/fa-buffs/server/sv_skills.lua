

RPC.register("fa-skills:server:adjustSkill", function(src, _type, value, state)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    exports.ghmattimysql:execute("SELECT * FROM progression WHERE cid = @cid", {["cid"] = tonumber(cid)}, function(result)
        if result[1] ~= nil then
            local skills = json.decode(result[1].skills)
            local currentVal = skills[_type]
            if state == "add" then
                skills[_type] = currentVal + value
                print(skills[_type], "add")
                exports.ghmattimysql:execute("UPDATE progression SET `skills` = @skills WHERE `cid` = @id", {
                    ['@skills'] = json.encode(skills),
                    ['@id'] = cid
                })
            else
                skills[_type] = currentVal - value
                print(skills[_type], "remove")
                exports.ghmattimysql:execute("UPDATE progression SET `skills` = @skills WHERE `cid` = @id", {
                    ['@skills'] = json.encode(skills),
                    ['@id'] = cid
                })
            end
        end
    end)
end)


-- {"strength":0, "intelligence":0} -- skills
-- {"stressblock":0, "stressgain":0, "fullness":0, "jobluck":0, "alert":0, "swimming":0, "stamina":0} -- buffs
-- {"hackexp":0,"streetrep":0,"craftingrep":0,"guncrafting":0} -- rep