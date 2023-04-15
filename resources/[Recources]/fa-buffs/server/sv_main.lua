Citizen.CreateThread(function()
    print("[BUFFS] - Checking DB progression ")
    print("[BUFFS] - Progression Loaded")
end)


RegisterNetEvent("fa-buffs:setBuffValue")
AddEventHandler("fa-buffs:setBuffValue", function(_type, _Multiplier)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    
    exports.ghmattimysql:execute("SELECT * FROM progression WHERE cid = @cid", {["cid"] = tonumber(cid)}, function(result)
        if result[1] ~= nil then
            local buffs = json.decode(result[1].buffs)
            local currentVal = buffs[_type]
            buffs[_type] = currentVal + _Multiplier
            exports.ghmattimysql:execute("UPDATE progression SET `buffs` = @buffs WHERE `cid` = @id", {
                ['@buffs'] = json.encode(buffs),
                ['@id'] = cid
            })
            local data = {
                display = true,
                buffName = _type,
                progressColor = Config.Buffs[_type].progressColor,
                iconColor = Config.Buffs[_type].iconColor,
                maxTime = Config.Buffs[_type].maxTime,
                iconName = Config.Buffs[_type].iconName,
                progressValue = buffs[_type] / _Multiplier,
            } 
            TriggerClientEvent("fa-buffs:applyBuff", src, data)
        end
    end)
end)

RegisterNetEvent("buffs:triggerBuff")
AddEventHandler("buffs:triggerBuff", function(itemid)
    print("[BUFFS] - Triggered")
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    
    print(json.encode(itemid))
end)