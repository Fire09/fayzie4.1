function getCharacterId(serverId)
    local user = exports["fa-base"]:getModule("Player"):GetUser(serverId)

    if not user then
        return false, "Couldn't find a character"
    end

    return true, user.character.id
end

function getCharacterJob(serverId)
    local serverId = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(serverId)

    if not user then
        return false, "Couldn't find a job or a character"
    end

    return true, user:getVar("job")
end

function getUserRank(src)
    local user = exports["fa-base"]:getModule("Player"):GetUser(tonumber(src))

    if not user then
        return false, "Couldn't find a rank or a character"
    end

    local rank = user:getVar("rank")

    return rank
end

exports("getUserRank", getUserRank)

function getCharacterIdByPhoneNumber(pPhoneNumber)
    if not pPhoneNumber then
        return false, "Phone Number required."
    end

    local query = [[
        SELECT cid FROM _character_phone_number WHERE phone_number = ? AND is_burner = false
    ]]

    local characterId = Await(SQL.scalardynamicparam(query,pPhoneNumber))

    return characterId ~= nil and true or false, characterId or 'No Phone Number'
end

exports('getCharacter', function(pSource)
    local user = exports["fa-base"]:getModule("Player"):GetUser(tonumber(pSource))

    if not user then
        return false
    end

    return user:getCurrentCharacter()
end)

function getUserVar(src, pVar)
    local user = exports["fa-base"]:getModule("Player"):GetUser(tonumber(src))

    if not user then
        return false, "Couldn't find a rank or a character"
    end

    local currentVar = user:getVar(pVar)

    return currentVar
end

exports("getUserVar", getUserVar)