function Login.decode(tablestring)
    if tablestring == nil or tablestring == "" then
        return {}
    else
        return json.decode(tablestring)
    end
end

RegisterServerEvent("login:getCharModels")
AddEventHandler("login:getCharModels", function(charlist,isReset)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)

    local list = ""
    for i=1,#charlist do
        if i == #charlist then
            list = list..charlist[i]
        else
            list = list..charlist[i]..","
        end
    end

    if charlist == nil or json.encode(charlist) == "[]" then
        TriggerClientEvent("login:CreatePlayerCharacterPeds", src, nil, isReset)
        return
    end

    exports.oxmysql:execute("SELECT cc.*, cf.* FROM character_face cf LEFT JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid IN ("..list..")",{},function(result)
        if result then
            local temp_data = {}

            for k,v in pairs(result) do
                temp_data[v.cid] = {
                    model = v.model,
                    drawables = Login.decode(v.drawables),
                    props = Login.decode(v.props),
                    drawtextures = Login.decode(v.drawtextures),
                    proptextures = Login.decode(v.proptextures),
                    hairColor = Login.decode(v.hairColor),
                    headBlend = Login.decode(v.headBlend),
                    headOverlay = Login.decode(v.headOverlay),
                    headStructure = Login.decode(v.headStructure),
                    tattoos = Login.decode(v.tattoos),
                }
            end

            for i=1,#charlist do
                if temp_data[charlist[i]] == nil then
                    temp_data[charlist[i]] = nil
                end
            end

            TriggerClientEvent("login:CreatePlayerCharacterPeds",src,temp_data,isReset)
        end
    end)
end)

RegisterServerEvent("fa-login:disconnectPlayer")
AddEventHandler("fa-login:disconnectPlayer", function()
    local src = source
    DropPlayer(src, "You DisConnected")
end)

RegisterServerEvent("fa-base:playerSessionStarted")
AddEventHandler("fa-base:playerSessionStarted", function()
    local src = source
    Citizen.CreateThread(function()
        Citizen.Wait(600000 * 3)
        local user = exports["fa-base"]:getModule("Player"):GetUser(src)
        if not user or not user:getVar("characterLoaded") then
            DropPlayer(src, "You timed out while choosing a character")
            return
        end
    end)
end)

-- RPC.register("playercoords",function(coords)
--     local src = source
--     local user = exports["fa-base"]:getModule("Player"):GetUser(src)
--     local cid = user:getCurrentCharacter()
--     local sql = SQL('SELECT `coords` FROM characters WHERE id = @id', {['id'] = cid})
--     if sql[1] then
--         return coords
--     end
-- end)

RegisterServerEvent("fa-spawn:licenses")
AddEventHandler("fa-spawn:licenses", function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Weapon",['@cid'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid, status) VALUES (@type, @cid, @status)", {['@type'] = "Driver", ['@cid'] = char.id, ['@status'] = "1"})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Hunting",['@cid'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Fishing",['@cid'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Pilot",['@cid'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Business",['@cid'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, cid) VALUES (@type, @cid)", {['@type'] = "Bar",['@cid'] = char.id})
end)

RegisterServerEvent("fa-spawn:initBoosting")
AddEventHandler("fa-spawn:initBoosting", function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    exports.oxmysql:execute("INSERT INTO boosting_users (identifier, level, gne, cooldown) VALUES (@identifier, @level, @gne, @cooldown)",
    {
        ['@identifier'] = char.id,
        ['@level'] = '0',
        ['@gne'] = '0',
        ['@cooldown'] ='0',
    })
end)

-- Instanced Creating Char First Time --

RegisterServerEvent('fa-spawn:SetNewRouting')
AddEventHandler('fa-spawn:SetNewRouting', function(pRoutingNum)
    local src = source
    SetPlayerRoutingBucket(src, pRoutingNum)
    print('Spawn routing bucket: '..pRoutingNum)
end)

RegisterServerEvent('fa-spawn:GetRouting')
AddEventHandler('fa-spawn:GetRouting', function()
    local src = source
    GetPlayerRoutingBucket(src)
end)

RegisterServerEvent('fa-spawn:SetOldRouting')
AddEventHandler('fa-spawn:SetOldRouting', function()
    local src = source
    SetPlayerRoutingBucket(src, 0)
    print('Setting Routing Bucket Back To Normal.')
end)

-- log --

RegisterServerEvent('fa-spawn:createCharacter:log')
AddEventHandler('fa-spawn:createCharacter:log', function(pFirstName, pSecondName, pDOB, pGender)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local sid = GetPlayerIdentifiers(src)[1]

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** faye [fa-spawn] | Create Character Log **",
          ["description"] = "First Name: "..pFirstName.."\n Second Name: "..pSecondName.."\n DOB: "..pDOB.."\n Gender: "..pGender.." \n Steam ID: "..sid,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082909533982720/spQhZlo5XmZS--PtwxMUPr_ix1jWvmLktUMkTPEJl-IjGorxS2IvlxHQ1dLI1BrFzKD9", function(err, text, headers) end, 'POST', json.encode({username = "faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)