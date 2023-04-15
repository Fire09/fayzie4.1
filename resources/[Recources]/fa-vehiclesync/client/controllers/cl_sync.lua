SyncProperty = 'SyncFlags'

local PendingUpdates = {}

SyncVehicles, DefaultEngines = {}, {}

Citizen.CreateThread(function()
    while true do
        local timer = GetGameTimer()

        for vehicle, active in pairs(SyncVehicles) do
            if active and not DoesEntityExist(vehicle) then
                VehicleCleanUp(vehicle)
            elseif active and timer - active['lastCheck'] > 1000 then
                UpdateSyncState(vehicle)
            end
        end

        Citizen.Wait(2000)
    end
end)

function HasSyncState(pVehicle)
    return DecorExistOn(pVehicle, SyncProperty)
end

function GetSyncFlags(pVehicle, pSyncState)
    return GetFlags(Flags.SyncFlags, pSyncState or SyncProperty, pVehicle)
end

function SetSyncFlag(pVehicle, pFlag, pEnabled)
    local mask = Flags.SyncFlags[pFlag]

    if mask == nil then return end

    SetFlag(mask, SyncProperty, pVehicle, pEnabled)
end

function HasSyncFlag(pVehicle, pFlag)
    local mask = Flags.SyncFlags[pFlag]

    if mask == nil then return false end

    return HasFlag(mask, SyncProperty, pVehicle)
end

function SetEngineSound(pVehicle)
    local sound = exports['fa-vehicles']:GetVehicleAfterMarket(pVehicle, 'engineSound')

    if not sound then end

    ForceVehicleEngineAudio(pVehicle, sound)
end

function VehicleHasNeonLights(pVehicle)
    for i = 0, 4, 1 do
        if IsVehicleNeonLightEnabled(pVehicle, i) then
            return true
        end
    end
end

function ToggleNeonLights(pVehicle)
    local hasLightsEnabled = HasSyncFlag(pVehicle, 'neonLights')

    SetSyncFlag(pVehicle, 'neonLights', not hasLightsEnabled)

    RequestSyncStateUpdate(pVehicle)

    FeedbackSound(not hasLightsEnabled)
end

function SetLightIndicators(pVehicle, pMode)
    local flags = GetSyncFlags(pVehicle)

    if pMode == 1 then
        SetSyncFlag(pVehicle, 'hazardIndicator', not flags['hazardIndicator'])
    elseif pMode == 2 then
        SetSyncFlag(pVehicle, 'rightIndicator', not flags['rightIndicator'])
        SetSyncFlag(pVehicle, 'leftIndicator', false)
        SetSyncFlag(pVehicle, 'hazardIndicator', false)
    elseif pMode == 3 then
        SetSyncFlag(pVehicle, 'leftIndicator', not flags['leftIndicator'])
        SetSyncFlag(pVehicle, 'rightIndicator', false)
        SetSyncFlag(pVehicle, 'hazardIndicator', false)
    end

    RequestSyncStateUpdate(pVehicle)

    FeedbackSound(true)
end

function RequestSyncStateUpdate(pVehicle)
    if PendingUpdates[pVehicle] then return end

    PendingUpdates[pVehicle] = true

    Citizen.SetTimeout(50, function()
        local syncState = DecorGetInt(pVehicle, SyncProperty)
        local netId = (not CurrentNetworkId or CurrentNetworkId == 0) and NetworkGetNetworkIdFromEntity(pVehicle) or CurrentNetworkId

        PendingUpdates[pVehicle] = nil

        TriggerServerEvent('fa-vehicleSync:updateSyncState', netId, syncState)
    end)
end

function UpdateSyncState(pVehicle, pSyncState)
    if not pVehicle then return end

    local flags = GetSyncFlags(pVehicle, pSyncState)
    local previous = SyncVehicles[pVehicle] or {}

    if flags['engineSound'] and not previous['engineSound'] then
        SetEngineSound(pVehicle)
    elseif not flags['engineSound'] and previous['engineSound'] then
        -- TODO: Add a way to get the original engine sound
    end

    if flags['neonLights'] ~= previous['neonLights'] then
        DisableVehicleNeonLights(pVehicle, not flags['neonLights'])
    end

    if flags['rightIndicator'] ~= previous['rightIndicator'] then
        SetVehicleIndicatorLights(pVehicle, 0, flags['rightIndicator'])
    end
    
    if flags['leftIndicator'] ~= previous['leftIndicator'] then
        SetVehicleIndicatorLights(pVehicle, 1, flags['leftIndicator'])
    end

    if flags['hazardIndicator'] ~= previous['hazardIndicator'] then
        SetVehicleIndicatorLights(pVehicle, 0, flags['hazardIndicator'] or flags['rightIndicator'])
        SetVehicleIndicatorLights(pVehicle, 1, flags['hazardIndicator'] or flags['leftIndicator'])
    end

    flags['lastCheck'] = GetGameTimer()

    SyncVehicles[pVehicle] = flags
end

RegisterNetEvent('fa-vehicleSync:updateSyncState')
AddEventHandler('fa-vehicleSync:updateSyncState', function(pNetId, pSyncState)
    local vehicle = NetworkGetEntityFromNetworkId(pNetId)

    if not vehicle then return end

    UpdateSyncState(vehicle, pSyncState)
end)

RegisterNetEvent('fa-vehicles:spawnedGarageVehicle')
AddEventHandler('fa-vehicles:spawnedGarageVehicle', function(pNetId, pModel)
    Citizen.Wait(1000)

    local vehicle = NetworkGetEntityFromNetworkId(pNetId)

    if not vehicle then return end

    local afterMarkets = exports['fa-vehicles']:GetVehicleAfterMarket(vehicle)

    if not afterMarkets then return end

    if afterMarkets['engineSound'] then
        SetSyncFlag(vehicle, 'engineSound', true)
    end

    RequestSyncStateUpdate(vehicle)
end)

RegisterCommand('+toggleNeonLights', function() end, false)

RegisterCommand('-toggleNeonLights', function()
    if not IsDriving or not VehicleHasNeonLights(CurrentVehicle) then return end

    ToggleNeonLights(CurrentVehicle)
end, false)

RegisterCommand('+toggleHazardLights', function() end, false)
RegisterCommand('-toggleHazardLights', function()
    if not IsDriving then return end

    SetLightIndicators(CurrentVehicle, 1)
end, false)


RegisterCommand('+toggleRightIndicator', function() end, false)
RegisterCommand('-toggleRightIndicator', function()
    if not IsDriving then return end

    SetLightIndicators(CurrentVehicle, 2)
end, false)

RegisterCommand('+toggleLeftIndicator', function() end, false)
RegisterCommand('-toggleLeftIndicator', function()
    if not IsDriving then return end

    SetLightIndicators(CurrentVehicle, 3)
end, false)

Citizen.CreateThread(function()
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Toggle Neon Lights", "+toggleNeonLights", "-toggleNeonLights")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Toggle Light Indicator (Right)", "+toggleRightIndicator", "-toggleRightIndicator")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Toggle Light Indicator (Left)", "+toggleLeftIndicator", "-toggleLeftIndicator")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Toggle Light Indicator (Hazard)", "+toggleHazardLights", "-toggleHazardLights")
end)