local currentJob = nil
--[[

    Functions

]]

function createPendingRace(id, options)
    print('curRace',curRace)
    if curRace then 
        print("CUR RACE IS RETURN")
        return 
    end

    RPC.execute("fa-racing:createPendingRace", id, options)
end

function previewRace(id)
    if previewEnabled then
        previewEnabled = false
        return
    end

    local race = races[id]
    if race == nil then return end

    previewEnabled = false
    SetWaypointOff()
    race.start.pos = tableToVector3(race.start.pos)

    for i=1, #race.checkpoints do
        race.checkpoints[i].pos = tableToVector3(race.checkpoints[i].pos)
    end

    local checkpoints = race.checkpoints
    for i=1, #checkpoints do
        addCheckpointBlip(checkpoints, i)
    end

    if race.type == "Point" then
        addBlip(race.start.pos, 0, true)
    end

    previewEnabled = true

    -- Thread to continously render the route
    Citizen.CreateThread(function()
        while previewEnabled do
            -- If a race has been started, or waypoint has been placed, preview is disabled and cleared
            if IsWaypointActive() or curRace then
                previewEnabled = false
            end
            Citizen.Wait(0)
        end

        clearBlips()
    end)
end

function locateRace(id)
    local race = races[id]
    if race == nil then return end

    previewEnabled = false
    local start = race.start.pos
    SetNewWaypoint(start.x, start.y, start.z)
end

function startRace(countdown)
    local characterId = getCharacterId()
    print("StART RACE", characterId)
    for k, v in pairs(pendingRaces) do
        print(v.owner,v.owner == characterId)
        if v.owner == characterId then
            print("SENDING StART RACE")
            RPC.execute("fa-racing:startRace", v.id, countdown or v.countdown, v.owner)
            return
        end
    end
end

function endRace()
    print("MAIN FUCKING END RACE",curRace)
    if curRace then
        RPC.execute("fa-racing:endRace")
        print("ENDING RACE 1")
    else
        RPC.execute("fa-racing:leaveRace")
    end
end

function joinRace(id, alias, characterId)
    RPC.execute("fa-racing:joinRace", id, alias, characterId)
end

function leaveRace()
    SendNUIMessage({
        showHUD = false
    })

    if curRace then
        RPC.execute("fa-racing:dnfRace", curRace.id)
        cleanupRace()
    else
        RPC.execute("fa-racing:leaveRace")
    end
end

function getAllRaces()
    if races then
        return {
            races = races,
            pendingRaces = pendingRaces,
            activeRaces = activeRaces,
            finishedRaces = finishedRaces,
        }
    end
    local res = RPC.execute("fa-racing:getAllRaces")
    races = res.races
    pendingRaces = res.pendingRaces
    activeRaces = res.activeRaces
    finishedRaces = res.finishedRaces
    return res
end


RegisterNetEvent("fa-jobmanager:playerBecameJob")
AddEventHandler("fa-jobmanager:playerBecameJob", function(job, name, notify)
  currentJob = job
end)


function getHasRaceUsbAndAlias()
    local characterId = exports["isPed"]:isPed("cid")
    local racingCreateUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb0")
    local racingUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb2")
    local pdRacingUsbItem = exports["fa-inventory"]:GetInfoForFirstItemOfName("racingusb3")
    local has_usb_racing = racingUsbItem ~= nil and racingUsbItem.quality > 0
    local has_usb_racing_create = racingCreateUsbItem ~= nil and racingCreateUsbItem.quality > 0
    local has_usb_pd_racing = pdRacingUsbItem ~= nil and currentJob == "police"
    local usbMetadata = has_usb_racing and json.decode(racingUsbItem.information) or {}
    local usbCreateMetadata = has_usb_racing_create and json.decode(racingCreateUsbItem.information) or {}
    has_usb_racing = has_usb_racing and characterId == usbMetadata.characterId
    has_usb_racing_create = has_usb_racing_create and characterId == usbCreateMetadata.characterId
    local racingAlias = has_usb_racing and usbMetadata.Alias or nil
    return { has_usb_racing = has_usb_racing, has_usb_racing_create = has_usb_racing_create, has_usb_pd_racing = has_usb_pd_racing, racingAlias = racingAlias }
end

function canJoinOrStartRace(expectedVehicleClass)
    -- print("CAN JOIN OR WHAT")
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return "Must be in vehicle" end
    local driver = GetPedInVehicleSeat(veh, -1)
    if ped ~= driver then return "Must be the driver" end
    return true
end

--[[

    Exports

]]

exports("getHasRaceUsbAndAlias", getHasRaceUsbAndAlias)
exports("canJoinOrStartRace", canJoinOrStartRace)
exports("createPendingRace", createPendingRace)
exports("previewRace", previewRace)
exports("locateRace", locateRace)
exports("startRace", startRace)
exports("endRace", endRace)
exports("joinRace", joinRace)
exports("leaveRace", leaveRace)
exports("getAllRaces", getAllRaces)