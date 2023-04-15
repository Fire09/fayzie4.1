local liftState = "down"
local otherModel = GetHashKey("denis3d_carlift_02")
local maxHeight = 0
local liftMoving = true

function liftUp()
    local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
    if isEmployed then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local liftModel = GetHashKey("denis3d_carlift_01")
        local liftObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, liftModel)
        local otherObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, otherModel)

        -- Check if lift object exists
        if DoesEntityExist(liftObject) and DoesEntityExist(otherObject) then
            local liftCoords = GetEntityCoords(liftObject)
            local otherCoords = GetEntityCoords(otherObject)
            local newCoords = liftCoords
            local liftSpeed = 0.005
            local targetHeight = otherCoords.z + 2.86
            maxHeight = targetHeight
            PlaySoundFromEntity(-1, 'OPENED', liftObject, 'EXILE_1', true, 0, 0, 0)
            while liftCoords.z < targetHeight and liftMoving do
                newCoords = vector3(liftCoords.x, liftCoords.y, liftCoords.z + liftSpeed)
                SetEntityCoords(liftObject, newCoords)
                Wait(10)
                liftCoords = GetEntityCoords(liftObject)
            end
            liftState = "up"
        end
    else
        TriggerEvent('DoLongHudText', "I Don't know how to use this.", 2)
    end
end

function liftDown()
    local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
    if isEmployed then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local liftModel = GetHashKey("denis3d_carlift_01")
        local liftObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, liftModel)
        local otherObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, otherModel)

        -- Check if lift object exists
        if DoesEntityExist(liftObject) and DoesEntityExist(otherObject) then
            local liftCoords = GetEntityCoords(liftObject)
            local otherCoords = GetEntityCoords(otherObject)
            local newCoords = liftCoords
            local liftSpeed = 0.005
            local targetHeight = otherCoords.z
            PlaySoundFromEntity(-1, 'OPENED', liftObject, 'EXILE_1', true, 0, 0, 0)
            while liftCoords.z > targetHeight and liftMoving do
                newCoords = vector3(liftCoords.x, liftCoords.y, liftCoords.z - liftSpeed)
                SetEntityCoords(liftObject, newCoords)
                Wait(10)
                liftCoords = GetEntityCoords(liftObject)
            end
            liftState = "down"
        end
    else
        TriggerEvent('DoLongHudText', "I Don't know how to use this.", 2)
    end
end

function stopLift()
    liftMoving = false
end

exports["fa-interact"]:AddPeekEntryByModel({ `denis3d_carlift_03` }, {
    {
    event = "lift:up",
    id = "denis3d_carlift_up",
    icon = "level-up-alt",
    label = "Move Lift Up",
    parameters = {},
  },
  {
    event = "lift:down",
    id = "denis3d_carlift_down",
    icon = "level-down-alt",
    label = "Move Lift Down",
    parameters = {},
  },
  {
    event = "lift:stop",
    id = "denis3d_carlift_stop",
    icon = "pause-circle",
    label = "Stop",
    parameters = {},
  }}, {
    distance = { radius = 6 },
  })

AddEventHandler("lift:up", function()
    if liftState == "down" then
        liftMoving = true
        liftUp()
    else
        TriggerEvent('DoLongHudText', "Lift is already in the up position.", 2)
    end
end)

AddEventHandler("lift:down", function()
    if liftState == "up" then
        liftMoving = true
        liftDown()
    else
        TriggerEvent('DoLongHudText', "Lift is already in the down position.", 2)
    end
end)

AddEventHandler("lift:stop", function()
    stopLift()
end)


