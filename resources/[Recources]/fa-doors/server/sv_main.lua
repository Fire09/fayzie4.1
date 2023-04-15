local doors = {}
local elevators = {}

RegisterNetEvent('fa-doors:request-lock-state')
AddEventHandler('fa-doors:request-lock-state', function()
    local src = source
    TriggerClientEvent('fa-doors:initial-lock-state', src, doors)
end)

RegisterNetEvent('fa-doors:change-lock-state')
AddEventHandler('fa-doors:change-lock-state', function(pDoorId, pDoorLockState)
    if doors[pDoorId] then
        doors[pDoorId].lock = pDoorLockState
        TriggerClientEvent('fa-doors:change-lock-state', -1, pDoorId, pDoorLockState)
    end
end)

-- CreateThread(function()
--     for _, door in pairs(Void.Doors) do
--         local doorModelHash = (type(door.model) == "string" and GetHashKey(door.model) or door.model)
--         local generatedDoorId = GetMapObjectId(doorModelHash, door.coords)
--         doors[generatedDoorId] = {
--             id = generatedDoorId,
--             active = door.active,
--             access = door.access,
--             coords = door.coords,
--             automatic = door.automatic,
--             forceUnlocked = door.forceUnlocked,
--             lock = door.lock,
--             info = door.info,
--             model = doorModelHash,
--             hidden = door.hidden,
--             cellNumber = door.cellNumber
--         }
--     end
-- end)

Citizen.CreateThread(function()
    for _,door in ipairs(DOOR_CONFIG) do
        doors[#doors + 1] = door
    end
end)

-- RegisterNetEvent("fa-doors:save-config")
-- AddEventHandler("fa-doors:save-config", function(pDoorData)
--     if pDoorData ~= nil then
--         local fileHandle = io.open("doorCoords.log", "a")
--         if fileHandle then
--             fileHandle:write(json.encode(pDoorData))
--         end
--         fileHandle:close()
--     end
-- end)

-- RPC.register("fa-doors:elevators:fetch", function()
--     return Void.Elevators or {}
-- end)
