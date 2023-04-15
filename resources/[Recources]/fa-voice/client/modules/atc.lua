AtcChannels, IsAtcOn, IsTalkingOnAtc, AtcVolume, CurrentChannel = {}, true, false, Config.settings.atcVolume

local inHelicopter = false

function SetAtcFrequency()
    --if CanUseFrequency(pFrequency, true) then
--[[          exports["fa-interface"]:sendAppEvent("hud", {
             displayAtcChannel = true,
         })

         Citizen.SetTimeout(5000, function()
             exports["fa-interface"]:sendAppEvent("hud", {
                 displayAtcChannel = false, 
             })
         end)

         exports["fa-interface"]:sendAppEvent("game", {
             atcChannel = tostring(118.0)
         }) ]]

        if true then
            TriggerEvent("ChannelSet", 118.0)
        end

        if IsTalkingOnAtc then
            Citizen.Await(StopTransmission(true))
        end

        TriggerServerEvent("AddPlayerToAtc", 118.0, GetPlayerServerId(PlayerId()))

        Debug("[atc] Connected | atc ID: %s", 118.0)

        return true
end 

function CycleAtcChannels()
    if not IsAtcOn then return end

    local firstEntry, lastEntry, nextChannel

    if IsTalkingOnAtc then
        Citizen.Await(StopTransmission(true))
    end

    for atcID, _ in pairs(AtcChannels) do
        if firstEntry == nil then
            firstEntry = atcID
        end

        if CurrentChannel == nil then
            nextChannel = atcID
            break
        elseif lastEntry == CurrentChannel.id then
            nextChannel = atcID
            break
        end

        lastEntry = atcID
    end

    local atcID = _C(nextChannel ~= nil, nextChannel, firstEntry)

    if atcID then
        SetAtcChannel(atcID)
    else
        CurrentChannel = nil
    end
end
RegisterNetEvent("fayzie:voice:atc:connect")
AddEventHandler('fayzie:voice:atc:connect', function (atcID, subscribers)
    print("WORK")
    if AtcChannels[atcID] then return end

    local channel = AtcChannel:new(atcID)

    for _, subscriber in ipairs(subscribers) do
        channel:addSubscriber(subscriber)
    end

    AtcChannels[atcID] = channel

    SetAtcChannel(atcID)

    Debug("[atc] Connected | atc ID: %s", atcID)
end)

RegisterNetEvent("fayzie:voice:atc:disconnect")
AddEventHandler('fayzie:voice:atc:disconnect', function (atcID)
    print("disconnect")
    if not AtcChannels[atcID] then return end

    AtcChannels[atcID] = nil

    if CurrentChannel.id == atcID then
        CycleAtcChannels()
    end

    Debug("[atc] Disconnected | ID %s", atcID)
end)

RegisterNetEvent("fayzie:voice:atc:added")
AddEventHandler('fayzie:voice:atc:added', function (atcID, serverID)

    if not AtcChannels[atcID] then return end

    local channel = AtcChannels[atcID]
    if not channel:subscriberExists(serverID) then
        channel:addSubscriber(serverID)

        if IsTalkingOnAtc and CurrentChannel.id == atcID then
            AddPlayerToTargetList(serverID, "atc", true)
        end

        Debug("[atc] Subscriber Added | atc ID: %s | Player: %s ", atcID, serverID)
    end

end)


RegisterNetEvent("fayzie:voice:atc:removed")
AddEventHandler('fayzie:voice:atc:removed', function (atcID, serverID)
    print("attempting remove ")
    if not AtcChannels[atcID] then return end


    local channel = AtcChannels[atcID]

        channel:removeSubscriber(serverID)

        RemovePlayerFromTargetList(serverID, "atc", true, true)

        Debug("[atc] Subscriber Removed | atc ID: %s | Player: %s ", atcID, serverID)

end)

function SetAtcChannel(atcID)
    CurrentChannel = AtcChannels[atcID]
    -- exports["fa-ui"]:sendAppEvent("game", { atcChannel = tostring(atcID) })

    Debug("[atc] Channel Changed | atc ID: %s", atcID)
end

local function playAtcClick(transmitting, setting, type, pDistortion)
    if transmitting and Settings[setting] then
        SendNUIMessage({ type = type, state = transmitting, distortion = pDistortion})
    end
    if not transmitting and Settings[setting] then
        SendNUIMessage({ type = type, state = transmitting, distortion = pDistortion })
    end
end

function PlayRemoteAtcClick(transmitting, pDistortion)
    if transmitting then
        playAtcClick(transmitting, "remoteClickOn", "remoteClick", pDistortion)
    else
        playAtcClick(transmitting, "remoteClickOff", "remoteClick", pDistortion)
    end
end

function PlayLocalAtcClick(transmitting)
    if transmitting then
        playAtcClick(transmitting, "localClickOn", "localClick")
    else
        playAtcClick(transmitting, "localClickOff", "localClick")
    end
end

function StartTransmissionATC()
    if not IsAtcOn or not CurrentChannel or Throttled("atc:transmit") or IsTransmissionDisabled("atc") then return end

    if not inHelicopter then
        return false
    end

    if not IsTalkingOnAtc then
        IsTalkingOnAtc = true

        local currentCam = GetCamActiveViewModeContext()
        local isInVehicle = currentCam == 1 or currentCam == 2

        AddGroupToTargetList(CurrentChannel.subscribers, "atc", isInVehicle) 

        PlayLocalAtcClick(true)

        TriggerEvent("fayzie:voice:transmissionStarted", { atc = true })

        Debug("[atc] Transmission | Sending: %s | atc ID: %s", IsTalkingOnAtc, CurrentChannel.id)
    end

    if AtcTimeout then
        AtcTimeout:resolve(false)
    end
end

function StopTransmissionATC(forced)
    if not IsTalkingOnAtc or AtcTimeout then return end

    AtcTimeout = TimeOut(300):next(function (continue)
        AtcTimeout = nil

        if forced ~= true and not continue then return end

        IsTalkingOnAtc = false

        RemoveGroupFromTargetList(CurrentChannel.subscribers, "atc")

        PlayLocalAtcClick(false)

        Throttled("atc:transmit", 300)

        Debug("[atc] Transmission | Sending: %s | atc ID: %s", IsTalkingOnAtc, CurrentChannel.id)
    end)

    return AtcTimeout
end

function IncreaseAtcVolume()
    local currentVolume = AtcVolume * 10
    SetAtcVolume(currentVolume + 1)
end

function DecreaseAtcVolume()
    local currentVolume = AtcVolume * 10
    SetAtcVolume(currentVolume - 1)
end

function SetAtcVolume(volume, pDisableNotification)
    if volume <= 0 then return end

    AtcVolume = _C(volume > 10, 1.0, volume * 0.1)

    if almostEqual(0.0, volume, 0.01) then AtcVolume = 0.0 end

    if IsAtcOn then
      UpdateContextVolume("atc", AtcVolume)
    end

    if not pDisableNotification then
      TriggerEvent("DoLongHudText", ("New volume %s"):format(AtcVolume))
    end

    Debug("[atc] Volume Changed | Current: %s", AtcVolume)
end

function SetAtcPowerState(state)
    if Throttled("atc:transmit") then return end
    IsAtcOn = state

    local volume = _C(IsAtcOn, AtcVolume, -1.0)

    UpdateContextVolume("atc", volume)

    if not IsAtcOn and IsTalkingOnAtc then 
        StopTransmission(true)
    end

    TriggerEvent("DoLongHudText", ("Radio Power State = %s"):format(IsAtcOn))

    UpdateAtcPowerState(IsAtcOn)

    Throttled("atc:powerState", 500)

    Debug("[atc] Power State | Powered On: %s", IsAtcOn)
end

function StartAtcTask(pIsInVehicle)
    Citizen.CreateThread(function()
        local lib = "random@arrests"
        local anim = "generic_atc_chatter"
        local playerPed = PlayerPedId()

        LoadAnimDict("random@arrests")

        local isInVehicleAndFirstPersonDriver = pIsInVehicle and GetCamViewModeForContext(isInVehicle) == 4 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId()

        -- Don"t play atc anim if driving in first person
        while IsTalkingOnAtc do
            if not isInVehicleAndFirstPersonDriver and not IsEntityPlayingAnim(playerPed, lib, anim, 3) then
                TaskPlayAnim(playerPed, lib, anim, 8.0, 0.0, -1, 49, 0, false, false, false)
            end

            SetControlNormal(0, 249, 1.0)

            Citizen.Wait(0)
        end

        StopAnimTask(playerPed, lib, anim, 3.0)
    end)
end

RegisterNetEvent("fuckaduck")
AddEventHandler('fuckaduck', function ()
    SetAtcFrequency(118.0, true)
    Citizen.Wait(1000)
end)

function LoadAtcModule()
    RegisterModuleContext("atc", 2)
    UpdateContextVolume("atc", -1.0)

    exports["fa-keybinds"]:registerKeyMapping("", "atc", "Push-To-Talk", "+transmitToAtc", "-transmitToAtc", "CAPITAL")
    RegisterCommand("+transmitToAtc", StartTransmissionATC, false) 
    RegisterCommand("-transmitToAtc", StopTransmissionATC, false) 

    exports["fa-keybinds"]:registerKeyMapping("", "atc", "Push-To-Talk (Secondary)", "+secondaryTransmitToAtc", "-secondaryTransmitToAtc")
    RegisterCommand("+secondaryTransmitToAtc", StartTransmissionATC, false)
    RegisterCommand("-secondaryTransmitToAtc", StopTransmissionATC, false)

    exports["fa-keybinds"]:registerKeyMapping("", "atc", "Volume Up", "+increaseAtcVolume", "-increaseAtcVolume")
    RegisterCommand("+increaseAtcVolume", IncreaseAtcVolume, false)
    RegisterCommand("-increaseAtcVolume", function() end, false)

    exports["fa-keybinds"]:registerKeyMapping("", "atc", "Volume Down", "+decreaseAtcVolume", "-decreaseAtcVolume")
    RegisterCommand("+decreaseAtcVolume", DecreaseAtcVolume, false)
    RegisterCommand("-decreaseAtcVolume", function() end, false)

    --[[ exports["fa-keybinds"]:registerKeyMapping("", "atc", "On / Off", "+toggleAtcState", "-toggleAtcState")
    RegisterCommand("+toggleAtcState", function() SetAtcPowerState(not IsAtcOn) end, false)
    RegisterCommand("-toggleAtcState", function() end, false) ]]


    RegisterNetEvent("fayzie:voice:atc:power")
    AddEventHandler("fayzie:voice:atc:power", SetAtcPowerState)

    RegisterNetEvent("fayzie:voice:atc:volume")
    AddEventHandler("fayzie:voice:atc:volume", SetAtcVolume)

    exports("SetAtcPowerState", SetAtcPowerState)
    exports("SetAtcVolume", SetAtcVolume)
    exports("SetAtcFrequency", SetAtcFrequency)
    exports("IncreaseAtcVolume", IncreaseAtcVolume)
    exports("DecreaseAtcVolume", DecreaseAtcVolume)

    if Config.enableSubmixes and Config.enableFilters.atc then
        for submixName, submix in pairs(Config.atcVoiceRanges) do
            RegisterContextSubmix(submixName)
            SetFilterParameters(submixName, submix.filters)
        end
    end

    TriggerEvent("fayzie:voice:atc:ready")

    Debug("[atc] Module Loaded")
end


CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(),false) and not inHelicopter then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local class = GetVehicleClass(veh)
            if class == 15 or class == 16 then
                inHelicopter = true
                SetAudioSubmixEffectParamInt(0, 0, `enabled`, 1)
            end
        end
        if not IsPedInAnyVehicle(PlayerPedId(), false) and inHelicopter then
            inHelicopter = false
            SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
        end
        Wait(500)
    end
end)

local currentAircraft = nil

AddEventHandler('baseevents:enteredVehicle', function (pVehicle, pSeat, pName, pClass, pModel)
    print("ENTERED")
    if pClass ~= 15 and pClass ~= 16 then return end

    currentAircraft = pVehicle

    if pSeat ~= -1 and pSeat ~= 0 then return end
    TriggerEvent('fuckaduck') 
end)

AddEventHandler('baseevents:leftVehicle', function (pVehicle, pSeat, pName, pClass, pModel)
    if pClass ~= 15 and pClass ~= 16 or pSeat ~= -1 and pSeat ~= 0 then return end

    currentAircraft = nil

    TriggerServerEvent('RemovePlayerFromAtc', source)
    TriggerEvent('fayzie:voice:atc:disconnect', 118.0)
end)