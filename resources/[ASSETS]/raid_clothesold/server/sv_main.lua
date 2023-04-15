--[[

    Variables

]]

RPC.register("getCurrentCashPlayer",function(pSource)
    local src = pSource
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = user:getCash()
    return cash
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(askingPrice)
    local src = source
    local target = exports["fa-base"]:getModule("Player"):GetUser(src)

    if not askingPrice then
        askingPrice = 0
    end

    if (tonumber(target:getCash()) >= askingPrice) then
        target:removeMoney(askingPrice)
        TriggerClientEvent("DoShortHudText", src, "You Paid $"..askingPrice, 8)
        TriggerClientEvent("clothing:close", src)
    else
        TriggerClientEvent("DoShortHudText", src, "You need $"..askingPrice, 2)
    end
end)

databaseFormat = {
    "model",
    "drawables",
    "props",
    "drawtextures",
    "proptextures",
    "hairColor",
    "fadeStyle",
    "headBlend",
    "headStructure",
    "headOverlay",
}

--[[

    Events

]]

RegisterServerEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    TriggerEvent("fa-clothes:getClothes", src)
end)

RegisterServerEvent("fa-clothes:getClothes")
AddEventHandler("fa-clothes:getClothes", function(_src)
    local src = (not _src and source or _src)

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    local clothes = MySQL.single.await([[
        SELECT *
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if clothes then
        local data = {
            model = clothes.model,
            drawables = json.decode(clothes.drawables),
            props = json.decode(clothes.props),
            drawtextures = json.decode(clothes.drawtextures),
            proptextures = json.decode(clothes.proptextures),
            hairColor = json.decode(clothes.hairColor),
            fadeStyle = clothes.fadeStyle,
            headBlend = json.decode(clothes.headBlend),
            headStructure = json.decode(clothes.headStructure),
            headOverlay = json.decode(clothes.headOverlay),
            tattoos = json.decode(clothes.tattoos),
        }

        TriggerClientEvent("fa-clothes:setClothes", src, data)
    end
end)

RegisterServerEvent("fa-clothes:updateClothes")
AddEventHandler("fa-clothes:updateClothes",function(data, tats)
    if not data then return end
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    for i, v in ipairs(databaseFormat) do
        if v == "model" then
            data[v] = tostring(data[v])
        elseif v == "fadeStyle" then
            data[v] = tonumber(data[v])
        else
            if data[v] then
                data[v] = json.encode(data[v])
            else
                data[v] = json.encode({})
            end
        end
    end

    if type(tats) ~= "table" then tats = {} end
    local tattoos = json.encode(tats) 

    local exist = MySQL.scalar.await([[
        SELECT cid
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if exist then 
        MySQL.update([[
            UPDATE characters_clothes
            SET model = ?, drawables = ?, props = ?, drawtextures = ?, proptextures = ?, hairColor = ?, fadeStyle = ?, headBlend = ?, headStructure = ?, headOverlay = ?, tattoos = ?
            WHERE cid = ?
        ]],
        { data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos, cid })
    else
        MySQL.insert([[
            INSERT INTO characters_clothes (cid, model, drawables, props, drawtextures, proptextures, hairColor, fadeStyle, headBlend, headStructure, headOverlay, tattoos)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos })
    end
end)

RegisterServerEvent("fa-clothes:getTattoos")
AddEventHandler("fa-clothes:getTattoos", function(_src)
    local src = (not _src and source or _src)

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id

    local tattoos = MySQL.scalar.await([[
        SELECT tattoos
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if tattoos then
        TriggerClientEvent("raid_clothes:settattoos", src, json.decode(tattoos))
    else
        TriggerClientEvent("raid_clothes:settattoos", src, {})
    end
end)

RegisterServerEvent("raid_clothes:list_outfits")
AddEventHandler("raid_clothes:list_outfits",function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local slot = slot
    local name = name
    if not cid then return end

    exports.oxmysql:execute("SELECT slot, name FROM characters_outfits WHERE cid = @cid", {['cid'] = cid}, function(skincheck)
    	TriggerClientEvent("raid_clothes:ListOutfits",src, skincheck) 
	end)
end)

--[[

    RPCs

]]

RPC.register("fa-clothes:purchase", function(src, price, tax, paymentType)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    if not cid then return false end

    local src = source
    local target = exports["fa-base"]:getModule("Player"):GetUser(src)

    if not price then
        price = 0 
    end
    if paymentType == "cash" then
        local cash = tonumber(target:getCash())
        if price > cash then
            return false
        end
        if (tonumber(target:getCash()) >= price) then
            target:removeMoney(price)  
            TriggerClientEvent("DoShortHudText", src, "You Paid $"..price, 8)
            TriggerClientEvent("clothing:close", src)
        else
            TriggerClientEvent("DoShortHudText", src, "You need $"..price, 2)
        end
    else
        local bank = tonumber(target:getBank())
        if price > bank then
            return false
        end
        if (tonumber(target:getBank()) >= price) then
            target:removeBank(price)
            TriggerClientEvent("DoShortHudText", src, "You Paid $"..price, 8)
        else
            TriggerClientEvent("DoShortHudText", src, "You need $"..price, 2)
        end

    end 
    return true
end)

RegisterServerEvent("raid_clothes:insert_character_current")
AddEventHandler("raid_clothes:insert_character_current",function(data)
    if not data then return end
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["cid"] = characterId,
            ["model"] = json.encode(data.model),
            ["drawables"] = json.encode(data.drawables),
            ["props"] = json.encode(data.props),
            ["drawtextures"] = json.encode(data.drawtextures),
            ["proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "cid, model, drawables, props, drawtextures, proptextures"
            local vals = "@cid, @model, @drawables, @props, @drawtextures, @proptextures"

            exports.oxmysql:execute("INSERT INTO character_current ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        exports.oxmysql:execute("UPDATE character_current SET "..set.." WHERE cid = @cid", values)
    end)
end)

RegisterServerEvent("raid_clothes:insert_character_face")
AddEventHandler("raid_clothes:insert_character_face",function(data)
    print(json.encode(data.fadeStyle))
    if not data then return end
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id

    if not characterId then return end

    checkExistenceFace(characterId, function(exists)
        if data.headBlend == "null" or data.headBlend == nil then
            data.headBlend = '[]'
        else
            data.headBlend = json.encode(data.headBlend)
        end
        local values = {
            ["cid"] = characterId,
            ["hairColor"] = json.encode(data.hairColor),
            ["headBlend"] = data.headBlend,
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
            ["headFade"] = json.encode(data.fadeStyle),
        }

        if not exists then
            local cols = "cid, hairColor, headBlend, headOverlay, headStructure, headFade"
            local vals = "@cid, @hairColor, @headBlend, @headOverlay, @headStructure, @headFade"

            exports.oxmysql:execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor,headBlend = @headBlend, headOverlay = @headOverlay,headStructure = @headStructure,headFade = @headFade"
        exports.oxmysql:execute("UPDATE character_face SET "..set.." WHERE cid = @cid", values )
    end)
end)



