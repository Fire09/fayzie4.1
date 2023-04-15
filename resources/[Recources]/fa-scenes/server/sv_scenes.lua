Citizen.CreateThread(function()
    local delete = Await(SQL.execute("DELETE FROM __scenes"))
end)

RegisterNetEvent("fa-scenes:getScenes")
AddEventHandler("fa-scenes:getScenes", function()
    local src = source
    local data = Await(SQL.execute("SELECT * FROM __scenes", {}))

    if not data then
        TriggerClientEvent("fa-scenes:allScenes", src, {})
        return
    end

    local scenes = {}

    for i = 1, #data do
        scenes[data[tonumber(i)].id] = {
            id = data[tonumber(i)].id,
            coords = data[tonumber(i)].coords,
            text = data[tonumber(i)].text,
            distance = data[tonumber(i)].distance,
            color = data[tonumber(i)].color,
            caret = data[tonumber(i)].caret,
            font = data[tonumber(i)].font,
            solid = data[tonumber(i)].solid,
            background = data[tonumber(i)].background,
        }
    end

    TriggerClientEvent("fa-scenes:allScenes", src, scenes)
end)

RegisterNetEvent("fa-scenes:addScene")
AddEventHandler("fa-scenes:addScene", function(pData)
    local src = source
    local insert = Await(SQL.execute("INSERT INTO __scenes (coords, text, distance, color, caret, font, solid, background) VALUES (@coords, @text, @distance, @color, @caret, @font, @solid, @background)", {
        ["coords"] = json.encode(pData.coords),
        ["text"] = pData.text,
        ["distance"] = pData.distance,
        ["color"] = pData.color,
        ["caret"] = pData.caret,
        ["font"] = pData.font,
        ["solid"] = pData.solid,
        ["background"] = json.encode(pData.background)
    }))

    if not insert then return end

    local data = Await(SQL.execute("SELECT * FROM __scenes WHERE text = @text AND distance = @distance AND color = @color AND caret = @caret AND font = @font AND solid = @solid", {
        ["text"] = pData.text,
        ["distance"] = pData.distance,
        ["color"] = pData.color,
        ["caret"] = pData.caret,
        ["font"] = pData.font,
        ["solid"] = pData.solid
    }))

    TriggerClientEvent("fa-scenes:refreshScenes", -1, data[1].id, data[1])
end)

RegisterNetEvent("fa-scenes:deleteScene")
AddEventHandler("fa-scenes:deleteScene", function(pCoords)
    local data = Await(SQL.execute("SELECT * FROM __scenes", {}))
    for k,v in pairs(data) do
        local coord = json.decode(v.coords)
        local acCoord = vector3(coord.x, coord.y, coord.z)
        if #(acCoord - pCoords) < 2.0 then
            local delete = Await(SQL.execute("DELETE FROM __scenes WHERE id = @id", {
                ["id"] = v.id
            }))
            if delete then
                TriggerClientEvent("fa-scenes:deleteScene", -1, v.id)
                return
            end
        end
    end
end)