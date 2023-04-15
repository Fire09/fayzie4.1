SirenProperty, PresetProperty = 'SirenFlags', 'SirenPreset'

local PendingUpdates = {}

EmergencyVehicles = {}

Citizen.CreateThread(function()
    while true do
        local timer = GetGameTimer()

        for vehicle, active in pairs(EmergencyVehicles) do
            if active and timer - active['lastCheck'] > 1000 then
                UpdateSirenState(vehicle)
            end
        end

        Citizen.Wait(2000)
    end
end)

function StartEmergencyDriverThread()
    if IsEmergencyThreadActive then return end

    IsEmergencyThreadActive = true

    Citizen.CreateThread(function()
        while IsDriving and IsEmergencyVehicle do
            DisableControlAction(0, 86, true) -- INPUT_VEH_HORN
            DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
            DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
            DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL
            DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
            DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM

            Citizen.Wait(0)
        end

        IsEmergencyThreadActive = false
    end)
end

function GetModelSirenPreset(pModel)
    return ModelPreset[pModel] or 1
end

function GetSirenPreset(pVehicle, pPreset)
    local preset = not pPreset and DecorGetInt(pVehicle, PresetProperty) or pPreset

    return SirenPresets[preset]
end

function SetVehicleSirenPreset(pVehicle, pPreset)
    if not SirenPresets[pPreset] then return end

    DecorSetInt(pVehicle, PresetProperty, pPreset)
end

function HasSirenPreset(pVehicle)
    return DecorExistOn(pVehicle, PresetProperty)
end

function GetSirenFlags(pVehicle, pSirenState)
    return GetFlags(Flags.SirenFlags, pSirenState or SirenProperty, pVehicle)
end

function SetSirenFlag(pVehicle, pFlag, pEnabled)
    local mask = Flags.SirenFlags[pFlag]

    if mask == nil then return end

    SetFlag(mask, SirenProperty, pVehicle, pEnabled)
end

function HasSirenFlag(pVehicle, pFlag)
    local mask = Flags.SirenFlags[pFlag]

    if mask == nil then return false end

    return HasFlag(mask, SirenProperty, pVehicle)
end

function PlaySirenSound(pVehicle, pSiren, pPreset)
    local preset = pPreset

    if not preset then return end

    local soundName = preset[pSiren]

    CreateEntitySound(pVehicle, soundName)
end

function StopSirenSound(pVehicle, pSiren, pPreset)
    local preset = pPreset

    if not preset then return end

    local soundName = preset[pSiren]

    DeleteEntitySound(pVehicle, soundName)
end

function IsVehicleSirenActive(pVehicle)
    return HasSirenFlag(pVehicle, 'sirenActive')
end

function TurnOnSiren(pVehicle)
    SetSirenFlag(CurrentVehicle, 'sirenActive', true)
    SetSirenFlag(CurrentVehicle, 'sirenNormal', true)
end

function TurnOffSiren(pVehicle)
    SetSirenFlag(CurrentVehicle, 'sirenActive', false)
    SetSirenFlag(CurrentVehicle, 'sirenNormal', false)
    SetSirenFlag(CurrentVehicle, 'sirenAltern', false)
    SetSirenFlag(CurrentVehicle, 'sirenWarning', false)
end

function CycleSirenSound(pVehicle)
    local preset = GetSirenPreset(pVehicle)
    local flags = GetSirenFlags(pVehicle)

    if not preset then return end

    if flags['sirenWarning'] then
        SetSirenFlag(pVehicle, 'sirenWarning', false)
        SetSirenFlag(pVehicle, 'sirenNormal', true)
    elseif flags['sirenNormal'] then
        SetSirenFlag(pVehicle, 'sirenNormal', false)
        SetSirenFlag(pVehicle, 'sirenAltern', true)
    elseif flags['sirenAltern'] then
        SetSirenFlag(pVehicle, 'sirenAltern', false)
        SetSirenFlag(pVehicle, 'sirenWarning', true)
    end

    RequestSirenStateUpdate(pVehicle)

    FeedbackSound(true)
end

function ToggleSiren(pVehicle)
    local hasSirenLights = IsVehicleSirenOn(pVehicle)
    local isSirenActive = IsVehicleSirenActive(pVehicle)

    if not hasSirenLights and not isSirenActive then return end

    if hasSirenLights and not isSirenActive then
        TurnOnSiren(pVehicle)
    elseif isSirenActive then
        TurnOffSiren(pVehicle)
    end

    RequestSirenStateUpdate(pVehicle)

    FeedbackSound(not isSirenActive)
end

function ToggleSirenLights(pVehicle)
    local hasSirenLights = IsVehicleSirenOn(pVehicle)
    local isSirenActive = IsVehicleSirenActive(pVehicle)

    if not hasSirenLights then
        SetSirenFlag(pVehicle, 'sirenMuted', true)
    else
        SetSirenFlag(pVehicle, 'sirenMuted', false)
    end

    if hasSirenLights and isSirenActive then
        TurnOffSiren(pVehicle)
    end

    RequestSirenStateUpdate(pVehicle)

    FeedbackSound(not hasSirenLights)
end

function UseSirenAirHorn(pVehicle, pEnabled)
    SetSirenFlag(pVehicle, 'sirenAirhorn', pEnabled)

    RequestSirenStateUpdate(pVehicle)
end

function RequestSirenStateUpdate(pVehicle)
    if PendingUpdates[pVehicle] then return end

    PendingUpdates[pVehicle] = true

    Citizen.SetTimeout(50, function()
        local sirenPreset = DecorGetInt(pVehicle, PresetProperty)
        local sirenState = DecorGetInt(pVehicle, SirenProperty)
        local netId = (not CurrentNetworkId or CurrentNetworkId == 0) and NetworkGetNetworkIdFromEntity(pVehicle) or CurrentNetworkId

        PendingUpdates[pVehicle] = nil

        TriggerServerEvent('fa-vehicleSync:updateSirenState', netId, sirenState, sirenPreset)
    end)
end

function UpdateSirenState(pVehicle, pSirenState, pSirenPreset)
    if not pVehicle then return end

    local flags = GetSirenFlags(pVehicle, pSirenState)
    local preset = GetSirenPreset(pVehicle, pSirenPreset)
    local previous = EmergencyVehicles[pVehicle] or {}

    SetVehicleHasMutedSirens(pVehicle, flags['sirenMuted'])

    if flags['sirenNormal'] and not previous['sirenNormal'] then
        PlaySirenSound(pVehicle, 'sirenNormal', preset)
    elseif not flags['sirenNormal'] and previous['sirenNormal'] then
        StopSirenSound(pVehicle, 'sirenNormal', preset)
    end

    if flags['sirenAltern'] and not previous['sirenAltern'] then
        PlaySirenSound(pVehicle, 'sirenAltern', preset)
    elseif not flags['sirenAltern'] and previous['sirenAltern'] then
        StopSirenSound(pVehicle, 'sirenAltern', preset)
    end

    if flags['sirenWarning'] and not previous['sirenWarning'] then
        PlaySirenSound(pVehicle, 'sirenWarning', preset)
    elseif not flags['sirenWarning'] and previous['sirenWarning'] then
        StopSirenSound(pVehicle, 'sirenWarning', preset)
    end

    if flags['sirenAirhorn'] and not previous['sirenAirhorn'] then
        PlaySirenSound(pVehicle, 'sirenAirhorn', preset)
    elseif not flags['sirenAirhorn'] and previous['sirenAirhorn'] then
        StopSirenSound(pVehicle, 'sirenAirhorn', preset)
    end

    flags['lastCheck'] = GetGameTimer()

    EmergencyVehicles[pVehicle] = flags
end

RegisterNetEvent('fa-vehicleSync:updateSirenState')
AddEventHandler('fa-vehicleSync:updateSirenState', function(pNetId, pSirenState, pSirenPreset)
    local vehicle = NetworkGetEntityFromNetworkId(pNetId)

    if not vehicle then return end

    local flags = GetSirenFlags(vehicle, pSirenState)

    UpdateSirenState(vehicle, pSirenState, pSirenPreset)

    if not IsDriving or pNetId ~= CurrentNetworkId then return end

    SetVehicleSiren(CurrentVehicle, flags['sirenMuted'])
end)

RegisterCommand('+sirenAirHorn', function()
    if not IsDriving or not IsEmergencyVehicle then return end

    UseSirenAirHorn(CurrentVehicle, true)
end, false)

RegisterCommand('-sirenAirHorn', function()
    if not IsDriving or not IsEmergencyVehicle then return end

    UseSirenAirHorn(CurrentVehicle, false)
end, false)

RegisterCommand('+toggleSirenLights', function() end, false)
RegisterCommand('-toggleSirenLights', function()
    if not IsDriving or not IsEmergencyVehicle then return end

    ToggleSirenLights(CurrentVehicle)
end, false)

RegisterCommand('+toggleSiren', function() end, false)
RegisterCommand('-toggleSiren', function()
    if not IsDriving or not IsEmergencyVehicle then return end

    ToggleSiren(CurrentVehicle)
end, false)

RegisterCommand('+cycleSiren', function()
    if not IsDriving or not IsEmergencyVehicle then return end

    if not IsVehicleSirenActive(CurrentVehicle) then
        BlipSiren(CurrentVehicle)
        FeedbackSound(true)
    else
        CycleSirenSound(CurrentVehicle)
    end
end, false)

RegisterCommand('-cycleSiren', function() end, false)

Citizen.CreateThread(function()
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Siren Turn On/Off Lights", "+toggleSirenLights", "-toggleSirenLights", "Q")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Siren Turn On/Off Sound", "+toggleSiren", "-toggleSiren", "LMENU")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Siren Cycle Sound", "+cycleSiren", "-cycleSiren", "R")
    exports["fa-keybinds"]:registerKeyMapping("", "Vehicle", "Siren AirHorn", "+sirenAirHorn", "-sirenAirHorn", "E")
end)