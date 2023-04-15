function getCasinoChips()
    local src = source
    local user = exports['fa-base']:getModule("Player"):GetUser(src)
    local StateID = user:getCurrentCharacter().id

    exports.oxmysql:execute("SELECT chips FROM characters WHERE (id = @StateID)", {
        ['@StateID'] = StateID,
        }, function(result)
    end)
end

RegisterServerEvent('fa-casino:giveChips')
AddEventHandler('fa-casino:giveChips', function(amount)
    local src = source
    local user = exports['fa-base']:getModule("Player"):GetUser(src)
    local StateID = user:getCurrentCharacter().id

    exports.oxmysql:execute('SELECT chips FROM characters WHERE id = ?', {StateID}, function(pCharData)
        if pCharData[1] then
            exports.oxmysql:execute("UPDATE characters SET chips = @newChips WHERE id = @stateID", {
                ['newChips'] = pCharData[1].chips + amount, 
                ['stateID'] = StateID, 
            })
        else
            pExist = false
        end
    end)
end)

RegisterServerEvent('fa-casino:removeChips')
AddEventHandler('fa-casino:removeChips', function(pRemoveAmt)
    local src = source
    local user = exports['fa-base']:getModule("Player"):GetUser(src)
    local StateID = user:getCurrentCharacter().id

    exports.oxmysql:execute('SELECT chips FROM characters WHERE id = ?', {StateID}, function(pCharData)
        if pCharData[1] then
            exports.oxmysql:execute("UPDATE characters SET chips = @newChips WHERE id = @stateID", {
                ['newChips'] = pCharData[1].chips - pRemoveAmt, 
                ['stateID'] = StateID, 
            })
        else
            pExist = false
        end
    end)
end)

RPC.register("fa-casino:getChips", function(pSource)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id

    exports.oxmysql:execute("SELECT `chips` FROM characters WHERE id = @id",{['id'] = id}, function(data)
        chips = data[1].chips
    end)
    Wait(100)
    return chips
end)