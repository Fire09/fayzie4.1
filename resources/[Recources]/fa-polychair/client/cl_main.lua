Citizen.CreateThread(function()
    --Chair stuff
    for idx,polyTarget in ipairs(ChairZones) do
        exports['fa-interact']:AddPeekEntryByPolyTarget('fa-polychair:chair_' .. tostring(idx) .. "-".. tostring(polyTarget[4].name), {{
            event = "fa-polychair:chairSit",
            id = "poly_chair_" .. tostring(idx) .. "_" .. tostring(polyTarget[4].name),
            icon = "chair",
            label = "sit",
            parameters = {chairPosition = idx, chairName = polyTarget[4].name}
        }}, { distance = { radius = 3.0 }})
    end
end)

local previousPosition = nil
local isSitting = false
function chairSit(chairPosition, cancel)
    local ped = PlayerPedId()
    if isSitting then
        if cancel then
            TriggerEvent("animation:cancel")
        end

        Wait(1500)
        if previousPosition ~= nil and IsPedUsingScenario(ped, 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT') then
            SetEntityCoords(ped, previousPosition.x, previousPosition.y, previousPosition.z, 0, 0, 0, false)
        end
        previousPosition = nil
        isSitting = false
        TriggerEvent('fa-polychair:stopSitting')
    else
        if chairPosition == nil then return end
        --Save old location
        previousPosition = GetEntityCoords(ped)
        --Set player position to chair
        local zone = ChairZones[chairPosition]
        local pos = zone[1]
        local heading = (zone[4].heading) * 1.0
        SetEntityHeading(ped, heading)

        isSitting = true

        local zOffset = zone[4].zOffset
        if zone[4].data then
            local dict = zone[4].data.dict
            local anim = zone[4].data.anim
            loadAnimDict(dict)
            TaskPlayAnimAdvanced(ped, dict, anim, pos.x, pos.y, pos.z - zOffset, 0.0, 0.0, heading + 0.0, 8.0, 8.0, -1, 1, 0, 1, 0)
        else
            TaskStartScenarioAtPosition(ped, 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT', pos.x, pos.y, pos.z - zOffset, heading, -1, true, true)
        end
        TriggerEvent('fa-polychair:startSitting')
    end
    exports["fa-flags"]:SetPedFlag(ped, 'isSittingOnChair', isSitting)
end

AddEventHandler('fa-polychair:chairSit', function(pParameters, pEntity, pContext)
    chairSit(pParameters.chairPosition, true)
end)

RegisterNetEvent("fa-emotes:sitOnChair")
AddEventHandler("fa-emotes:sitOnChair", function(pArgs, pEntity, pContext)
    chairSit(nil, true)
end)

RegisterNetEvent("turnoffsitting")
AddEventHandler("turnoffsitting", function()
	chairSit(nil, false)
end)
