local enabled = true
local blackoutStatus = true
local callStatus = 0
local eventStarted = false
local vehicle = 0
local dinghy = 0
local blip = 0
local dropCoords = {}
local jobStarted = false

RegisterNetEvent("weather:blackout")
AddEventHandler("weather:blackout", function(status)
    blackoutStatus = status
end)

RegisterNetEvent("cocaine-search", function()
	local ped = PlayerPedId()
    ExecuteCommand('e search')
    FreezeEntityPosition(ped,true)
    exports['fa-taskbar']:Progress({
        duration = 3500,
        label = "Searching Vehicle",
    }, function(cancelled)
         if not cancelled then
        TriggerEvent('player:receiveItem', "cocainebrick" , 1)
        TriggerEvent('DoLongHudText', 'You found it .. onto the next location!')
        FreezeEntityPosition(ped,false)
    else
        FreezeEntityPosition(ped,false)
    end
  end)
end)

RegisterNetEvent("heists:cocaine_payment")
AddEventHandler("heists:cocaine_payment", function ()
    if not enabled or eventStarted then
        TriggerEvent("DoLongHudText", "The man says - 'Get outta here!' and looks at you up and down.")
        return
    end
    -- make them pay 50k then call this event for 100k of drug drop off, if successful with numbers
    eventStarted = RPC.execute('heists:cocaine_paynow')
    if eventStarted then
        callStatus = 1
        TriggerEvent("DoLongHudText", "The man says 'Thanks' and hands you a list of phone numbers.")
        TriggerEvent("heists:cocaine_payment_accepted")
    else
        TriggerEvent("DoLongHudText", "The man says 'Not enough money' and motions you to move on.")
    end
end)

RegisterNetEvent("heists:cocaine_payment_accepted")
AddEventHandler("heists:cocaine_payment_accepted", function ()
    eventStarted = true
    EventLocation(129.2166,244.865,107.45)
end)

RegisterNetEvent("fa-heists:cocaine:failure")
AddEventHandler("fa-heists:cocaine:failure", function ()

    RemoveBlip(blip)
    TriggerEvent('InteractSound_CL:PlayOnOne','payphoneend', 1.0)
    blackoutStatus = false
    callStatus = 0
    eventStarted = false
    vehicle = 0
    dinghy = 0
    blip = 0
    dropCoords = {}
end)

RegisterNetEvent("fa-heists:cocaine:begin_start")
AddEventHandler("fa-heists:cocaine:begin_start", function ()
    print('Here 3')
    if not enabled or not eventStarted then
        return
    end
    blackoutStatus = false
    callStatus = 2
    TriggerEvent('InteractSound_CL:PlayOnOne','payphoneend', 1.0)
    EventLocation(187.6109,-1043.832,29.33)   
end)

RegisterNetEvent("fa-heists:cocaine:success:2")
AddEventHandler("fa-heists:cocaine:success:2", function ()
    print('Here 2')
    if not enabled or not eventStarted then
        return
    end
    blackoutStatus = false
    callStatus = 3
    EventLocation(-523.91,-299.72,35.24)
    TriggerEvent('InteractSound_CL:PlayOnOne','payphoneend', 1.0)
end)

RegisterNetEvent("fa-heists:cocaine:success:3")
AddEventHandler("fa-heists:cocaine:success:3", function ()
    print('Here 1')
    if not enabled or not eventStarted then
        return
    end
    blackoutStatus = false
    callStatus = 4
    
    EventLocation(-559.2529,-275.29,35.2)
    TriggerEvent('InteractSound_CL:PlayOnOne','payphoneend', 1.0)
end)

RegisterNetEvent("fa-heists:cocaine:success:4")
AddEventHandler("fa-heists:cocaine:success:4", function ()
    print('Here should be success')
    jobStarted = true
    blackoutStatus = false
    callStatus = 0
    TriggerEvent('InteractSound_CL:PlayOnOne','payphoneend', 1.0)  
    StartEvent()
    CreateDropCoords()
    MainEvents(1)
    MainEvents(2)
    MainEvents(3)
    MainEvents(4)
end)

RegisterNetEvent("fx:do:Effect", function(x,y,z ,pTime) -- Use this next time - Ghost pretty straight forward..
    local ptfx
    RequestNamedPtfxAsset("scr_xm_ht")
    while not HasNamedPtfxAssetLoaded("scr_xm_ht") do
        Citizen.Wait(1)
    end
    ptfx = vector3(x,y,z)
    SetPtfxAssetNextCall("scr_xm_ht")
    local effect = StartParticleFxLoopedAtCoord("scr_xm_ht_package_flare", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(pTime)
    StopParticleFxLooped(effect, 0)
end)

function CreatePhoneNumber(number,wanted)
    local length = 7
    local phoneNumber = "696-"
    local wantedFlag = false
    while length > 0 do
        Wait(1)
        local nGen = math.random(0,9)
        if not wanted then
            if nGen ~= number then
                if length == 3 then
                    phoneNumber = phoneNumber .. "-"
                end
                phoneNumber = phoneNumber .. nGen
                length = length - 1
            end
        end

        if wanted then
            if nGen == number then
                wantedFlag = true
            end
            if length == 3 then
                phoneNumber = phoneNumber .. "-"
            end
            phoneNumber = phoneNumber .. nGen
            length = length - 1
            if length == 2 and not wantedFlag then
                phoneNumber = phoneNumber .. "" .. number
                length = length - 1
            end
        end
    end
    return phoneNumber
end

function CreateDropCoords()
    local rand = 0
    for i=1, 4 do
        dropCoords[i] = { ["x"] = -3374.06, ["y"] = math.random(1,2184) + 1.00, ["z"] = -1.0 }
    end
end

function BlipEvent(x,y,z)
    RemoveBlip(blip)
    blip = AddBlipForCoord(x,y,z)
    SetBlipSprite(blip, 306)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Current Task")
    EndTextCommandSetBlipName(blip)
    SetNewWaypoint(x, y)
end

function EventLocation(x,y,z)
	BlipEvent(x,y,z)
    local timeout = 1200
    local success = false
    while timeout > 0 do
        timeout = timeout - 1
        Wait(1000)
        if ( GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z) < 350.0 ) then
            success = true
            timeout = 0
        end 
    end
    return success
end

function StartEvent()
    TriggerEvent("DoLongHudText","Check the map!")
    EventLocation(1997.296, 4008.251, 31.3)
    vehicle = RPC.execute("heists:cocaine_start_vehicle")
end

function MainEvents(n)
    local timer = 300000
    TriggerEvent("DoLongHudText","GPS updated.")
    
    TriggerServerEvent("fx:spell:target",dropCoords[n]["x"],dropCoords[n]["y"],dropCoords[n]["z"] ,0)
    Wait(1000)

    local success = EventLocation(dropCoords[n]["x"],dropCoords[n]["y"],dropCoords[n]["z"])
    if success then
        local vector = vector3(dropCoords[n]["x"],dropCoords[n]["y"],dropCoords[n]["z"])
        TriggerServerEvent("fx:spell:target",dropCoords[n]["x"],dropCoords[n]["y"],dropCoords[n]["z"] ,timer)
        dinghy = RPC.execute("heists:cocaine_dump_vehicle",dropCoords[n]["x"],dropCoords[n]["y"],dropCoords[n]["z"])
        print('Dingy status' ,dinghy)
    end
end


Citizen.CreateThread(function()
    local function statusCheck(result)
        if eventStarted and callStatus == 1 and result == 1 then
            return true
        elseif result == callStatus then
            return true
        end
        return false
    end
    -- START EVENT
    exports["fa-polytarget"]:AddBoxZone(
        "heist_cocaine_phonecall",
        vector3(129.2166,244.865,107.45), 1.2, 1.0,
        {
          minZ = 106.64,
          maxZ = 108.04
        }
    );

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall', {{
        event = "fa-heists:cocaine:failure",
        id = "heist_cocaine_begin_1",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(1)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall', {{
        event = "fa-heists:cocaine:failure",
        id = "heist_cocaine_begin_2",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(1)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall', {{
        event = "fa-heists:cocaine:begin_start",
        id = "heist_cocaine_begin_3",
        icon = "phone",
        label = CreatePhoneNumber(0,false),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(1)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall', {{
        event = "fa-heists:cocaine:failure",
        id = "heist_cocaine_begin_4",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(1)
            return status
        end,
    });


    -- SECOND EVENT

    exports["fa-polytarget"]:AddBoxZone(
        "heist_cocaine_phonecall_second",
        vector3(187.6109,-1043.832,29.33), 1.2, 1.0,
        {
          minZ = 28.64,
          maxZ = 30.44
        }
    );

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_second', {{
        event = "fa-heists:cocaine:success:2",
        id = "heist_cocaine_phonecall_second_1",
        icon = "phone",
        label = CreatePhoneNumber(7,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(2)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_second', {{
        event = "fa-heists:cocaine:success:2",
        id = "heist_cocaine_phonecall_second_2",
        icon = "phone",
        label = CreatePhoneNumber(7,false),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(2)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_second', {{
        event = "fa-heists:cocaine:success:2",
        id = "heist_cocaine_phonecall_second_3",
        icon = "phone",
        label = CreatePhoneNumber(7,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(2)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_second', {{
        event = "fa-heists:cocaine:success:2",
        id = "heist_cocaine_phonecall_second_4",
        icon = "phone",
        label = CreatePhoneNumber(7,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(2)
            return status
        end,
    });



    -- third event


    exports["fa-polytarget"]:AddBoxZone(
        "heist_cocaine_phonecall_third",
        vector3(-523.91,-299.72,35.24), 1.2, 1.0,
        {
          minZ = 34.64,
          maxZ = 36.04
        }
    );

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_third', {{
        event = "fa-heists:cocaine:success:3",
        id = "heist_cocaine_phonecall_third_1",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(3)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_third', {{
        event = "fa-heists:cocaine:success:3",
        id = "heist_cocaine_phonecall_third_2",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(3)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_third', {{
        event = "fa-heists:cocaine:success:3",
        id = "heist_cocaine_phonecall_third_3",
        icon = "phone",
        label = CreatePhoneNumber(0,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(3)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_third', {{
        event = "fa-heists:cocaine:success:3",
        id = "heist_cocaine_phonecall_third_4",
        icon = "phone",
        label = CreatePhoneNumber(0,false),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(3)
            return status
        end,
    });    




    -- fourth event

    exports["fa-polytarget"]:AddBoxZone(
        "heist_cocaine_phonecall_four",
        vector3(-559.2529,-275.29,35.2), 1.2, 1.0,
        {
          minZ = 34.64,
          maxZ = 36.04
        }
    );

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_four', {{ -- THIS IS FUCKING SUCCESSSSSSSS
        event = "fa-heists:cocaine:success:4",
        id = "heist_cocaine_phonecall_four_1",
        icon = "phone",
        label = CreatePhoneNumber(9,false),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(4)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_four', {{
        event = "fa-heists:cocaine:success:4",
        id = "heist_cocaine_phonecall_four_2",
        icon = "phone",
        label = CreatePhoneNumber(9,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(4)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_four', {{
        event = "fa-heists:cocaine:success:4",
        id = "heist_cocaine_phonecall_four_3",
        icon = "phone",
        label = CreatePhoneNumber(9,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(4)
            return status
        end,
    });

    exports["fa-interact"]:AddPeekEntryByPolyTarget('heist_cocaine_phonecall_four', {{
        event = "fa-heists:cocaine:success:4",
        id = "heist_cocaine_phonecall_four_4",
        icon = "phone",
        label = CreatePhoneNumber(9,true),
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function()
            local status = statusCheck(4)
            return status
        end,
    });    
end)

RegisterNetEvent("fa-heists:doVehicle", function(pVehicle, x,y,z)
    print(pVehicle)
    local model = pVehicle
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    SetModelAsNoLongerNeeded(model)
    local cocaineVehicle = CreateVehicle(model, vector3(x,y,z), true, false)
    Citizen.Wait(100)
    SetEntityAsMissionEntity(cocaineVehicle, true, true)
    SetModelAsNoLongerNeeded(model)
    SetVehicleNumberPlateText(cocaineVehicle, "XCJKX"..tostring(math.random(1000, 9999)))
    local plateText = GetVehicleNumberPlateText(cocaineVehicle)
    TriggerEvent("keys:addNew",cocaineVehicle, plateText)
end)

exports('isonMission' ,function () -- leave it alone cunt
return jobStarted end)

RegisterCommand('cocaine', function()
    TriggerEvent('heists:cocaine_payment')
    jobStarted = true -- turn to false
    Wait(5500)
    TriggerEvent('fa-heists:cocaine:success:4')
end)