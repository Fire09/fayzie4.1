--[[

    Variables

]]

local isRadioOpen = false

--[[

    Functions

]]

function pChannelActive()
    return pRadioChannel
  end
  
  exports('pChannel', function()
    return pChannelActive()
  end)

function toggleRadioAnimation(pState)
    
    local isInTrunk = exports['isPed']:isPed("intrunk")
    local isDead = exports['isPed']:isPed("dead")

    if isInTrunk or isDead then return end

    LoadAnimationDic("cellphone@")

    if pState then
        TriggerEvent("attachItemRadio","radio01")
        TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
    else
        StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
        TriggerEvent("destroyPropRadio")
    end
end

function LoadAnimationDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

function hasRadio()
    return exports["fa-inventory"]:hasEnoughOfItem("radio", 1, false) or exports["fa-inventory"]:hasEnoughOfItem("civradio", 1, false)
end

function formattedChannelNumber(number)
    local power = 10 ^ 1
    return math.floor(number * power) / power
end

function handleConnectionEvent(pChannel)
    local newChannel = formattedChannelNumber(pChannel)

    if type(newChannel) ~= "number" then return end

    local result = exports["fa-voice"]:SetRadioFrequency(newChannel)

    return result
end

function openRadio()
    local currentJob = exports['isPed']:isPed("myJob")

    --[[ if exports["fa-base"]:getVar("call") then
        TriggerEvent("DoShortHudText", "You cannot do this while on a call!", 2)
        return
    end ]]

    if not hasRadio() then
        TriggerEvent("DoShortHudText", "you need a radio.", 2)
        toggleRadioAnimation(false)
        return
    end

    if currentJob == 'police' or currentJob == 'ems' then
        job = true
    end

    if not isRadioOpen then
        SetNuiFocus(true, true)
        SendNUIMessage({
            open = true,
            emergency = job, 
        })

        toggleRadioAnimation(true)
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            close = true,
            emergency = job,
        })

        toggleRadioAnimation(false)
    end

    isRadioOpen = not isRadioOpen
end

--[[

    Events

]]

RegisterNetEvent("fa-radio:setChannel", function(params)
    handleConnectionEvent(params[1])

    SendNUIMessage({
        setChannel = params[1],
    })
end)

RegisterNetEvent("ChannelSet", function(chan)
    SendNUIMessage({
        setChannel = chan,
    })
end)

RegisterNetEvent("fa-radio:updateRadioState", function (frequency, powered)
    SendNUIMessage({
        setChannel = frequency,
        setState = powered,
    })
end)

AddEventHandler("fa-inventory:itemUsed", function(item)
    if item ~= "radio" and item ~= "civradio" then return end

    openRadio()
end)

AddEventHandler("fa-inventory:itemCheck", function (item, state, quantity)
    if item ~= "civradio" and item ~= "radio" then return end
    if state or quantity > 0 then return end

    exports["fa-voice"]:SetRadioPowerState(false)
 
    SendNUIMessage({
        setChannel = 0,
        setState = false,
    })

    TriggerEvent("DoLongHudText", "You have been disconnected from the radio.")
end)

--[[

    NUI

]]

RegisterNUICallback("poweredOn", function(data, cb)
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    exports["fa-voice"]:SetRadioPowerState(true)
end)

RegisterNUICallback("poweredOff", function(data, cb)
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    exports["fa-voice"]:SetRadioPowerState(false)
end)

RegisterNUICallback("setRadioChannel", function(data, cb)
    TriggerEvent("InteractSound_CL:PlayOnOne", "radioclick", 0.6)
    local success = handleConnectionEvent(data.channel)
    cb(success)
end)

RegisterNUICallback("volumeUp", function(data, cb)
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    exports["fa-voice"]:IncreaseRadioVolume()
end)

RegisterNUICallback("volumeDown", function(data, cb)
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    exports["fa-voice"]:DecreaseRadioVolume()
end)

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        close = true,
    })

    isRadioOpen = false

    toggleRadioAnimation(false)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["fa-keybinds"]:registerKeyMapping("", "Radio", "Open", "+handheld", "-handheld", "")
    RegisterCommand("+handheld", openRadio, false)
    RegisterCommand("-handheld", function() end, false)
end)