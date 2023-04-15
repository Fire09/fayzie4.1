RPC.register("fa-gopros:addSecCamera", function(pSource, pName, pCoords, pRotation)
    local user = exports['fa-base']:getModule("Player"):GetUser(pSource)
    local cid = user:getCurrentCharacter().id
    local cidTable = {
        ["cid"] = cid
    }
    local result = MySQL.query.await([[
        INSERT INTO _cameras (name, coords, rotation, cid, ownerCid) VALUES (?,?,?,?,?)
    ]], {pName, json.encode(pCoords), json.encode(pRotation), "["..json.encode(cidTable).."]", cid})
    --json.encode(print("["..json.encode(cidTable).."]"))
    if result then 
        return true, "Placed Camera!" 
    end
    return false, "Camera could not be placed."
end)

RPC.register("fa-gopros:getSecurityCameraById", function(pSource, pCameraID)
    local result = MySQL.query.await([[
        SELECT * FROM _cameras WHERE id = ?
    ]], {pCameraID})
    local cameraTable = {
        ["coords"] = result[1].coords,
        ["heading"] = json.decode(result[1].rotation),
        ["blurred"] = false
    }
    return cameraTable
end)

RPC.register("fa-gopros:getSecurityCameraByStateID", function(pSource, pCid)
    local cameraCidTable = {}
    local user = exports['fa-base']:getModule("Player"):GetUser(pSource)
    local myCid = user:getCurrentCharacter().id
    local result = MySQL.query.await([[
        SELECT * FROM _cameras
    ]], {})
    if result[1] then
        for k,v in pairs(result) do
            local jsondecodecid = json.decode(v.cid) or {}
            for j,s in pairs(jsondecodecid) do
                if tonumber(s.cid) == tonumber(myCid) or tonumber(myCid) == tonumber(v.ownerCid) then
                    cameraCidTable[#cameraCidTable+1] = {
                        ["heading"] = json.decode(v.rotation),
                        ["blurred"] = false,
                        ["name"] = v.name,
                        ["id"] = v.id,
                        ["isOwner"] = tonumber(v.ownerCid) == tonumber(myCid) and true or false
                    }
                end
            end
        end
    end
    return cameraCidTable
end)

RPC.register("fa-gopros:getSecurityCameraAccessByCameraID", function(pSource, pCamera)
    local securityAccess = {}
    local camera = MySQL.query.await([[
        SELECT * FROM _cameras WHERE id = ?
    ]], {pCamera})

    for k,v in pairs(camera) do
        local decodedCidString = json.decode(v.cid) or {}
        for j,s in pairs(decodedCidString) do
            securityAccess[#securityAccess+1] = {
                name = getNameFromCid(s.cid),
                cid = s.cid
            }
        end
    end
    return securityAccess
end)

RPC.register("fa-gopros:addUserToCamera", function(pSource, pCamera, pCid)
    local camera = MySQL.query.await([[
        SELECT * FROM _cameras WHERE id = ?
    ]], {pCamera})

    print(pCid)
    local pCid = exports['fa-phone']:getCIDFromPhoneNumber(pCid)
    print(pCid)

    local validCameraCids = json.decode(camera[1].cid) or {}
    for k,v in pairs(validCameraCids) do
        if tonumber(v.cid) == tonumber(pCid) or tonumber(v.ownerCid) == tonumber(pCid) or tonumber(v.cid) == tonumber(pCid) then 
            return TriggerClientEvent("DoLongHudText",pSource,"You cannot add this person because they are already in the camera programming.",2) 
        end
    end
    local cameraAdditionCids = {
        ["cid"] = pCid
    }
    table.insert(validCameraCids, cameraAdditionCids)
    local reencodedCids = json.encode(validCameraCids)
    print(reencodedCids)
    local finished = MySQL.query.await([[
        UPDATE _cameras SET cid = ? WHERE id = ?
    ]], {reencodedCids, pCamera})
end)

RPC.register("fa-gopros:removeUserFromCamera", function(pSource, pCamera, pCid)
    local camera = MySQL.query.await([[
        SELECT * FROM _cameras WHERE id = ?
    ]], {pCamera})

    local validCameraCids = json.decode(camera[1].cid) or {}
    local cameraAdditionCids = {
        ["cid"] = pCid
    }
    table.remove(validCameraCids, cameraAdditionCids)
    local reencodedCids = json.encode(validCameraCids)
    print(reencodedCids)
    local finished = MySQL.query.await([[
        UPDATE _cameras SET cid = ? WHERE id = ?
    ]], {reencodedCids, pCamera})
end)

getNameFromCid = function(cid)
    local player = MySQL.query.await([[
        SELECT * FROM characters WHERE id = ?
    ]], {cid})

    return player[1].first_name .. " " .. player[1].last_name
end