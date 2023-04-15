RegisterServerEvent("raid_clothes:list_outfits")
AddEventHandler("raid_clothes:list_outfits",function()
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id 
    if not cid then return end

    local outfits = MySQL.query.await([[
        SELECT name, slot
        FROM characters_outfits
        WHERE cid = ?
        ORDER BY slot
    ]],
    { cid })

    TriggerClientEvent("raid_clothes:ListOutfits", src, outfits)
end)

RegisterServerEvent("raid_clothes:set_outfit")
AddEventHandler("raid_clothes:set_outfit", function(slot, name, data)
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

    local exist =  MySQL.scalar.await([[
        SELECT slot
        FROM characters_outfits
        WHERE cid = ? AND slot = ?
    ]],
    { cid, slot })

    if exist then
        MySQL.update.await([[
            UPDATE characters_outfits
            SET name = ?, model = ?, drawables = ?, props = ?, drawtextures = ?, proptextures = ?, hairColor = ?, fadeStyle = ?, headBlend = ?, headStructure = ?, headOverlay = ?
            WHERE cid = ? AND slot = ?
        ]],
        { name, data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, cid, slot })
    else
        MySQL.insert.await([[
            INSERT INTO characters_outfits (cid, name, slot, model, drawables, props, drawtextures, proptextures, hairColor, fadeStyle, headBlend, headStructure, headOverlay)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, name, slot, data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay })
    end

    TriggerClientEvent("DoLongHudText", src, name .. " stored in slot " .. slot)
end)

RegisterServerEvent("raid_clothes:remove_outfit")
AddEventHandler("raid_clothes:remove_outfit", function(slot)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    MySQL.query.await([[
        DELETE FROM characters_outfits
        WHERE cid = ? AND slot = ?
    ]],
    { cid, slot })

    TriggerClientEvent("DoLongHudText", src, "Removed slot " .. slot)
end)

RegisterServerEvent("raid_clothes:get_outfit")
AddEventHandler("raid_clothes:get_outfit", function(slot)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    local clothes = MySQL.single.await([[ 
        SELECT *
        FROM characters_outfits
        WHERE cid = ? and slot = ?
    ]],
    { cid, slot })

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
        }

        TriggerClientEvent("fa-clothes:setClothes", src, data)

        MySQL.update([[
            UPDATE characters_clothes
            SET model = ?, drawables = ?, props = ?, drawtextures = ?, proptextures = ?, hairColor = ?, fadeStyle = ?, headBlend = ?, headStructure = ?, headOverlay = ?
            WHERE cid = ?
        ]],
        { clothes.model, clothes.drawables, clothes.props, clothes.drawtextures, clothes.proptextures, clothes.hairColor, clothes.fadeStyle, clothes.headBlend, clothes.headStructure, clothes.headOverlay, cid })

        Citizen.Wait(2000)

        TriggerEvent("fa-clothes:getTattoos", src)
    else
        TriggerClientEvent("DoLongHudText", src, "No outfit on slot " .. slot, 2)
    end
end)