PlayerPed, CurrentTarget, IsInVehicle = nil, nil, false


local CurrentTarget = nil 
local IsInVehicle = false



RegisterNetEvent('baseevents:enteredVehicle', function()
    IsInVehicle = true
end)

RegisterNetEvent('baseevents:leftVehicle', function()
    IsInVehicle = false
end)

function GetForwardVector(rotation)
    local rot = (math.pi / 180.0) * rotation
    return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

function RayCast(origin, target, options, ignoreEntity, radius)
    local handle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, options, ignoreEntity, 0)
    return GetShapeTestResult(handle)
end

function GetEntityPlayerIsLookingAt(pDistance, pRadius, pFlag, pIgnore)
    local distance = pDistance or 3.0
    local originCoords = GetPedBoneCoords(PlayerPedId(), 31086)
    local forwardVectors = GetForwardVector(GetGameplayCamRot(2))
    local forwardCoords = originCoords + (forwardVectors * (IsInVehicle and distance + 1.5 or distance))

    if not forwardVectors then return end

    local _, hit, targetCoords, _, targetEntity = RayCast(originCoords, forwardCoords, pFlag or 286, pIgnore, pRadius or 0.2)

    if not hit and targetEntity == 0 then return end

    local entityType = GetEntityType(targetEntity)

    return targetEntity, entityType, targetCoords
end

function GetEntityInFrontOfEntity(pEntity, pDistance, pRadius, pFlag)
    local forwardVector = GetEntityForwardVector(pEntity)
    local originCoords = GetEntityCoords(pEntity)
    local targetCoords = originCoords + (forwardVector * pDistance)

    local _, hit, _, _, targetEntity = RayCast(originCoords, targetCoords, pFlag or 286, pEntity, pRadius or 0.2)

    return targetEntity
end

Citizen.CreateThread(function()
    while true do
        local entity, entityType, entityCoords = GetEntityPlayerIsLookingAt(3.0, 0.2, 286, PlayerPedId())

        if entity and entityType ~= 0 then
            if entity ~= CurrentTarget then
                CurrentTarget = entity
                TriggerEvent('fa-target:changed', CurrentTarget, entityType, entityCoords)
            end
        elseif CurrentTarget then
            CurrentTarget = nil
            TriggerEvent('fa-target:changed', CurrentTarget)
        end

        Wait(250)
    end
end)

exports('GetCurrentEntity', function()
    return CurrentTarget
end)

exports('GetEntityInFrontOfEntity', GetEntityInFrontOfEntity)

exports('GetEntityPlayerIsLookingAt', GetEntityPlayerIsLookingAt)
