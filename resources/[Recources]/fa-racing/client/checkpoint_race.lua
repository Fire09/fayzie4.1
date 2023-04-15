curRace = nil
handleCheckpoints = false
props = {}
checkpointObjects = {}
totalDist = 0.0
races = nil
pendingRaces = {}
activeRaces = {}
finishedRaces = {}

function initRace(race)
    totalDist = 0.0
    curRace = race

    SendNUIMessage({
        curRace = curRace,
        showHUD = true,
    })

    if race.props then
        spawnProps()
    end

    for i = 1, #curRace.checkpoints do
        curRace.checkpoints[i].pos = tableToVector3(curRace.checkpoints[i].pos)
    end

    curRace.start.pos = tableToVector3(curRace.start.pos)

    startCheckpointsHandler()
end

function startCheckpointsHandler()
    Citizen.CreateThread(function()
        handleCheckpoints = true

        local startTime = GetGameTimer()
        local startLapTime = GetGameTimer()
        local bestLapTime = math.maxinteger
        local curLap = 1
        local checkpoints = curRace.checkpoints
        local numOfCheckpoints = #checkpoints
        local curCheckpointIndex = 1
        local curCheckpoint = checkpoints[curCheckpointIndex]
        local heading = getHeadingToNextCheckpoint(curCheckpoint.pos, checkpoints[curCheckpointIndex + 1].pos)
        local straightDistToCheckpoint = #(checkpoints[#checkpoints].pos - checkpoints[1].pos)
        local updateDelay = 10

        TriggerServerEvent("fa-racing:updatePositionInfo", curRace.id, totalDist, straightDistToCheckpoint, curCheckpointIndex)

        addWaypointAndBlip(checkpoints, curCheckpointIndex, config.checkpointBlipLookahead, curLap >= curRace.laps)
        spawnCheckpointObjects(curCheckpoint, config.checkpointObjectHash)

        while curRace and handleCheckpoints do
            local plyPed = PlayerPedId()
            local plyPos = GetEntityCoords(plyPed)
            local dist = #(plyPos - curCheckpoint.pos)


            if config.nui.hud.showPosition then
                local distToServer = (totalDist + (straightDistToCheckpoint - dist))

                if updateDelay == 10 then
                    TriggerServerEvent("fa-racing:updatePositionInfo", curRace.id, distToServer)
                    updateDelay = 0
                else
                    updateDelay = updateDelay + 1
                end
            end

            -- Hit checkpoint
            local checkpointRadius = curCheckpoint.rad or config.checkpointRadius
            if dist < checkpointRadius and (not config.vehicleOnlyCheckpoints or isInVehicle()) then
                local pastCheckpointIndex = curCheckpointIndex
                curCheckpointIndex = curCheckpointIndex + 1
                if curCheckpointIndex > numOfCheckpoints then -- If finish checkpoint is hit
                    curCheckpointIndex = 1
                    curLap = curLap + 1
                    local time = GetGameTimer() - startLapTime
                    if time < bestLapTime then
                        bestLapTime = time
                    end

                    SendNUIMessage({
                        HUD = {
                            lap = math.min(curLap, curRace.laps),
                            bestLapTime = bestLapTime
                        }
                    })

                    if curLap > curRace.laps then -- race finished
                        local totalTime = GetGameTimer() - startTime
                        RPC.execute("fa-racing:finishedRace", curRace.id, bestLapTime, totalTime)
                        break
                    end

                    startLapTime = GetGameTimer()
                end

                SendNUIMessage({
                    HUD = {
                        checkpoint = curCheckpointIndex
                    }
                })

                totalDist = totalDist + straightDistToCheckpoint
                straightDistToCheckpoint = #(checkpoints[pastCheckpointIndex].pos - checkpoints[curCheckpointIndex].pos)

                -- if config.nui.hud.showPosition then
                --     TriggerServerEvent("fa-racing:updatePositionInfo", curRace.id, totalDist, straightDistToCheckpoint, curCheckpointIndex)
                -- end

                curCheckpoint = checkpoints[curCheckpointIndex]
                heading = getHeadingToNextCheckpoint(curCheckpoint.pos, checkpoints[curCheckpointIndex % #checkpoints + 1].pos)

                addWaypointAndBlip(checkpoints, curCheckpointIndex, config.checkpointBlipLookahead, curLap >= curRace.laps)
                spawnCheckpointObjects(curCheckpoint, config.checkpointObjectHash)
            end

            if config.drawCheckpointMarkers then
                -- Current checkpoint is the finish line and you're on the final lap
                local isFinish = curCheckpointIndex == numOfCheckpoints and curLap >= curRace.laps
                drawCheckpointMarkers(curCheckpoint.pos, checkpointRadius, heading, isFinish)
            end

            Citizen.Wait(1)
        end

        SetWaypointOff()
        cleanupRace()
    end)
end

function drawCheckpointMarkers(checkpointPos, checkpointRadius, heading, isFinish)
    local checkpointDiameter = checkpointRadius * 2.0
    local x, y, z = checkpointPos.x, checkpointPos.y, checkpointPos.z

    if isFinish then
        DrawMarker(4, x, y, z + 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0, 255, 255, 255, 200, false, true, 2, nil, nil, false)
        DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, checkpointDiameter, checkpointDiameter, 3.0, 245, 255, 142, 100, false, false, 2, nil, nil, false)
    else
        DrawMarker(21, x, y, z + 4.0, 0.0, 0.0, 0.0, heading, 270.0, 0.0, 6.0, 3.0, 7.0, 255, 128, 0, 130, false, false, 2, nil, nil, false)
        DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, checkpointDiameter, checkpointDiameter, 3.0, 245, 255, 142, 100, false, false, 2, nil, nil, false)
    end
end

function cleanupProps()
    for i=1, #props do
        DeleteObject(props[i])
    end

    props = {}

    for i=1, #checkpointObjects do
        DeleteObject(checkpointObjects[i])
    end

    checkpointObjects = {}
end

function cleanupRace()
    handleCheckpoints = false

    if curRace ~= nil then
        curRace = nil
        SendNUIMessage({
            curRace = json.null
        })
    end

    cleanupProps()
    SetWaypointOff()
    ClearGpsMultiRoute()
    clearBlips()
end

function spawnProps()
    Citizen.CreateThread(function()
        local models = curRace.props.models
        local positions = curRace.props.positions
        local headings = curRace.props.headings
        local vrots = curRace.props.vrots

        for i=1, #models do
            local prophash = models[i]
            local proppos = positions[i]
            local propheading = headings[i]

            RequestModelAndLoad(prophash)
            local prop = CreateObjectNoOffset(prophash, proppos.x + 0.0, proppos.y + 0.0, proppos.z + 0.0, false, false, false)
            while not DoesEntityExist(prop) do
                Citizen.Wait(0)
            end

            props[#props + 1] = prop

            SetEntityRotation(prop, vrots[i].x + 0.0, vrots[i].y + 0.0, vrots[i].z + 0.0, 2, true)
            SetModelAsNoLongerNeeded(prophash)
        end
    end)
end

local checkpointObjectLimit = 2
function spawnCheckpointObjects(checkpoint, objectHash)
    if checkpoint.rad == nil or checkpoint.hdg == nil then return end

    if #checkpointObjects == checkpointObjectLimit * 2 then
        DeleteObject(table.remove(checkpointObjects, 1))
        DeleteObject(table.remove(checkpointObjects, 1))
    end

    RequestModelAndLoad(objectHash)

    local leftPos, rightPos = getCheckpointObjectPositions(checkpoint.pos, checkpoint.rad, checkpoint.hdg)
    leftObject = CreateObjectNoOffset(objectHash, leftPos, false, false, false)
    rightObject = CreateObjectNoOffset(objectHash, rightPos, false, false, false)
    checkpointObjects[#checkpointObjects + 1] = leftObject
    checkpointObjects[#checkpointObjects + 1] = rightObject

    PlaceObjectOnGroundProperly(leftObject)
    PlaceObjectOnGroundProperly(rightObject)
    SetEntityHeading(leftObject, checkpoint.hdg)
    SetEntityHeading(rightObject, checkpoint.hdg + 90.0)

    if objectHash == config.startObjectHash then
        SetEntityCollision(leftObject, false)
        SetEntityCollision(rightObject, false)
    end

    SetModelAsNoLongerNeeded(objectHash)
end
