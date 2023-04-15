function moneyRemover(src, amount)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not user then return end
    user:removeMoney(tonumber(amount))
    return true
end

RegisterServerEvent("vehicleMod:applyHarness")
AddEventHandler("vehicleMod:applyHarness", function(pPlate, pDurability)
    local pSrc = source
    if pPlate and pDurability ~= nil then
        exports.oxmysql:execute('SELECT * FROM __vehiclemods WHERE license_plate = ?', {pPlate}, function(result) 
            if result[1] ~= nil then
                exports.oxmysql:execute('UPDATE __vehiclemods SET durability = 100 WHERE license_plate = ?', {pPlate})
                TriggerClientEvent("DoLongHudText", pSrc, "You Have Updated The Harness Durability", 1)
            else
                local cols = 'license_plate, durability'
                local val = '@license_plate, @durability'
                exports.oxmysql:execute('INSERT INTO __vehiclemods ( '..cols..' ) VALUES ( '..val..' )',{
                    ['@license_plate'] = pPlate,
                    ['@durability'] = pDurability
                })
                TriggerClientEvent("vehicleMod:setHarness", pSrc, pDurability, true)
                TriggerClientEvent("DoLongHudText", pSrc, "Harness Installed", 1)
            end
        end)
    else
        return
    end
end)


RegisterServerEvent("vehicleMod:getHarness")
AddEventHandler("vehicleMod:getHarness", function(pPlate)
    local pSrc = source
    if pPlate ~= nil then
        exports.oxmysql:execute('SELECT * FROM __vehiclemods WHERE license_plate = ?', {pPlate}, function(result) 
            if result[1] ~= nil then
                TriggerClientEvent("vehicleMod:setHarness", pSrc, result[1].durability, false)
                TriggerClientEvent("harness:dir", pSrc, result[1].durability)
            else
                return
            end
        end)
    end
end)


RegisterServerEvent("vehicleMod:updateHarness")
AddEventHandler("vehicleMod:updateHarness", function(pPlate, pDurability)
    local pSrc = source
    if pPlate ~= nil then
        exports.oxmysql:execute('SELECT * FROM __vehiclemods WHERE license_plate = ?', {pPlate}, function(result) 
            if result[1] ~= nil then
                TriggerClientEvent("harness:dir", pSrc, pDurability)
                exports.oxmysql:execute('UPDATE __vehiclemods SET durability = ? WHERE license_plate = ?', {pDurability, pPlate})
                Citizen.Wait(100)
                exports.oxmysql:execute('SELECT * FROM __vehiclemods WHERE license_plate = ?', {pPlate}, function(pAfterData) 
                    if pAfterData[1].durability == 0.0 then
                        exports.oxmysql:execute('DELETE FROM __vehiclemods WHERE license_plate = ?', {pPlate})
                    end
                end)
            else
                return
            end
        end)
    end
end)

RegisterServerEvent("transfer:attempt:send")
AddEventHandler("transfer:attempt:send", function(plate, target)
    local pSrc = source
    local pUser = exports["fa-base"]:getModule("Player"):GetUser(pSrc)
    local pChar = pUser:getCurrentCharacter().id
    local pSteam = GetPlayerIdentifiers(pSrc)[1]

    -- target shit
    local tUser = exports["fa-base"]:getModule("Player"):GetUser(target)
    local tChar = tUser:getCurrentCharacter().id
    local tSteam = GetPlayerIdentifiers(target)[1]

    exports.oxmysql:execute("SELECT * FROM characters_cars WHERE cid = ? AND license_plate = ?",{pChar, plate}, function(data)
        if data[1] then
            exports.oxmysql:execute("UPDATE characters_cars SET `cid` = @cid, `cid` = @cid WHERE license_plate = @license_plate", {
                ['cid'] = tChar, 
                ['owner'] = tSteam,
                ['license_plate'] = plate
            })
            TriggerClientEvent("DoLongHudText", pSrc, "You have successfully transfered this vehicle!")
            TriggerClientEvent("DoLongHudText", target, "You have successfully received keys to your new ride!")
            TriggerClientEvent("keys:addNew", target ,plate)
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You dont own this vehicle", 2)
        end

    end)
end)

exports("moneyRemover", moneyRemover)