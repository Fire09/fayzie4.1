local debugmodeToggle = false
function devDebugToggle()
    if not DebugMode then
    DebugMode = true
    TriggerEvent('DoLongHudText', 'Dev Debug Enabled!', 1)
    debugmodeToggle = true
    else
    DebugMode = false
    TriggerEvent('DoLongHudText', 'Dev Debug Disabled!', 1)
    debugmodeToggle = false
    end

    TriggerEvent("fa-admin:currentDebug", debugmodeToggle)
end

Citizen.CreateThread( function()
    local accel = 0
    local braking = 0
    local sixty = 0
    local hundred = 0
    local thirty = 0
    local hundredtwenty = 0
    local timestart = 0
    local timestartbraking = 0
    local airtime = 0
    local lastairtime = 0
    local airTimeStart = 0
    local vehicleAir = false
    local vehicleSuspensionStress = false
    local vehicleSuspensionStressRear = false
    local suspensionTimeStart = 0
    local suspensionTimeStartRear = 0
    local susTime = 0
    local susRearTime = 0
    
    while true do 
        
        Citizen.Wait(1)
        
        if debugmodeToggle then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped,false)
            local pos = GetEntityCoords(ped)

            local forPos = GetOffsetFromEntityInWorldCoords(ped, 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(ped, 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(ped, 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(ped, -1.0, 0.0, 0.0) 

            local forPos2 = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(ped, 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(ped, 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(ped, -2.0, 0.0, 0.0)    

            local x, y, z = table.unpack(GetEntityCoords(ped, true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            local zone = tostring(GetNameOfZone(x, y, z))
            if not zone then
                zone = "UNKNOWN"
            else
                zone = GetLabelText(zone)
            end

            drawTxt(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxt(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.58, 0.4,0.4,0.30, "Veh Engine Health: " .. GetVehicleEngineHealth(veh), 55, 155, 55, 255)
            drawTxt(0.8, 0.60, 0.4,0.4,0.30, "Veh Body Health: " .. GetVehicleBodyHealth(veh), 55, 155, 55, 255)
            drawTxt(0.8, 0.62, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.64, 0.4,0.4,0.30, "Model: " .. GetEntityModel(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.66, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(ped), 55, 155, 55, 255)
            drawTxt(0.8, 0.68, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxt(0.8, 0.70, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
            drawTxt(0.8, 0.72, 0.4,0.4,0.30, "Hood: " .. zone, 55, 155, 55, 255)

            



            -- car debugging
            -- s 8
            -- w 32


            if IsDisabledControlPressed(0, 37) then
                accel = 0
                braking = 0
                sixty = 0
                hundred = 0
                thirty = 0
                hundredtwenty = 0
                timestart = 0
                timestartbraking = 0
                airtime = 0
                lastairtime = 0
                airTimeStart = 0
                vehicleAir = false
                vehicleSuspensionStress = false
                vehicleSuspensionStressRear = false
                suspensionTimeStart = 0
                suspensionTimeStartRear = 0
                susTime = 0
                susRearTime = 0
                timestart = GetGameTimer()
            end

            if veh ~= 0 and veh ~= nil then
                local mph = math.ceil(GetEntitySpeed(ped) * 2.236936)

                if (IsControlJustPressed(0, 32) and not IsControlPressed(0, 18)) or IsControlJustReleased(0, 18) then
                    thirty = 0
                    sixty = 0
                    hundred = 0
                    hundredtwenty = 0
                    accel = 0
                    vehicleAir = false
                    timestart = GetGameTimer()
                end

                if IsControlPressed(0, 32) then
                    accel = GetGameTimer() - timestart
                end

                if IsControlJustPressed(0, 8) and GetEntitySpeed(ped) > 0.0 then
                    braking = 0
                    timestartbraking = GetGameTimer()
                end

                if IsControlPressed(0, 8) and GetEntitySpeed(ped) > 5 then
                    braking = GetGameTimer() - timestartbraking
                end     

                if mph == 30 and IsControlPressed(0, 32) and thirty == 0 then
                    thirty = accel / 1000
                end
                if mph == 60 and IsControlPressed(0, 32) and sixty == 0 then
                    sixty = accel / 1000
                end
                if mph == 90 and IsControlPressed(0, 32) and hundred == 0 then
                    hundred = accel / 1000
                end
                if mph == 100 and IsControlPressed(0, 32) and hundredtwenty == 0 then
                    hundredtwenty = accel / 1000
                end

                if IsEntityInAir(veh) and mph > 0 and not vehicleAir then
                    vehicleAir = true
                    airTimeStart = GetGameTimer()
                elseif vehicleAir and not IsEntityInAir(veh) and mph > 0 then
                    airtime = airtime + (GetGameTimer() - airTimeStart)
                    vehicleAir = false
                end

                local frontSusLost = (GetVehicleWheelSuspensionCompression(veh,0) < 0.1 or GetVehicleWheelSuspensionCompression(veh,1) < 0.1)
                local rearSusLost = (GetVehicleWheelSuspensionCompression(veh,2) < 0.1 or GetVehicleWheelSuspensionCompression(veh,3) < 0.1)

                if mph > 0 and not vehicleSuspensionStress and frontSusLost then
                    vehicleSuspensionStress = true
                    suspensionTimeStart = GetGameTimer()
                elseif vehicleSuspensionStress and mph > 0 and not frontSusLost then
                    susTime = susTime + (GetGameTimer() - suspensionTimeStart)
                    vehicleSuspensionStress = false
                end
            --  print(GetVehicleWheelSuspensionCompression(veh,0),GetVehicleWheelSuspensionCompression(veh,1),GetVehicleWheelSuspensionCompression(veh,2),GetVehicleWheelSuspensionCompression(veh,3))

                if mph > 0 and not vehicleSuspensionStressRear and rearSusLost then
                    vehicleSuspensionStressRear = true
                    suspensionTimeStartRear = GetGameTimer()
                elseif vehicleSuspensionStressRear and mph > 0 and not rearSusLost then
                    susRearTime = susRearTime + (GetGameTimer() - suspensionTimeStartRear)
                    vehicleSuspensionStressRear = false
                end
            end

            --airtime
            -- math.floor(GetVehicleWheelSuspensionCompression(veh,0)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,1)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,2)*100) / 100 .." | ".. math.floor(GetVehicleWheelSuspensionCompression(veh,3)*100) / 100

            drawTxt(1.0, 0.80, 0.4,0.4,0.80, "Time Accelerating: " .. accel / 1000, 55, 155, 55, 255)
            drawTxt(1.0, 0.82, 0.4,0.4,0.80, "Time Braking: " .. braking / 1000, 155, 55, 55, 255)

            drawTxt(1.0, 0.84, 0.4,0.4,0.80, "30mph: " .. thirty, 155, 155, 155, 255)
            drawTxt(1.0, 0.86, 0.4,0.4,0.80, "60mph: " .. sixty, 155, 155, 155, 255)
            drawTxt(1.0, 0.88, 0.4,0.4,0.80, "90mph: " .. hundred, 155, 155, 155, 255)
            drawTxt(1.0, 0.90, 0.4,0.4,0.80, "120mph: " .. hundredtwenty, 155, 155, 155, 255)

            drawTxt(1.0, 0.92, 0.4,0.4,0.80, "Air Time: " .. airtime/1000, 155, 155, 155, 255)
            drawTxt(1.0, 0.96, 0.4,0.4,0.80, "Suspension F Stress " .. susTime/1000 , 155, 155, 155, 255)
            drawTxt(1.0, 0.98, 0.4,0.4,0.80, "Suspension R Stress " .. susRearTime/1000 , 155, 155, 155, 255)
            

            -- car debugging end


            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)

            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)           

            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)

            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)     

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("DoShortHudText",'Freeze Disabled',3)          
                else
                    inFreeze = true             
                    TriggerEvent("DoShortHudText",'Freeze Enabled',3)               
                end
            end

            if IsControlJustReleased(0, 47) then
                if lowGrav then
                    lowGrav = false
                    TriggerEvent("DoShortHudText",'Low Grav Disabled',3)            
                else
                    lowGrav = true              
                    TriggerEvent("DoShortHudText",'Low Grav Enabled',3)                 
                end
            end

        else
            Citizen.Wait(5000)
        end
    end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
        DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
        else
        DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
        end

            FreezeEntityPosition(ped, inFreeze)
            if lowGrav then
            SetPedToRagdoll(ped, 511, 511, 0, 0, 0, 0)
            SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        -- FreezeEntityPosition(ped, inFreeze)
        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
        DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
        else
        DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
        end
            if lowGrav then
            SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+5.0)
            end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
        if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
        DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
        else
        DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
        end

            if lowGrav then
            --ActivatePhysics(ped)
            SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
            FreezeEntityPosition(ped, false)
            end
        end

        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

RegisterNetEvent('fa-admin:select-spawn', function()
    exports['fa-adminUI']:hideMenu()
    exports['fa-adminUI']:exitNUI()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    TriggerServerEvent("jobssystem:jobs", "unemployed")
    exports["fa-build"]:getModule("func").CleanUpArea()
    TriggerEvent("insideShell", false)
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("fa-jobmanager:onCharSwap", cid)
    Citizen.Wait(1000)
    TriggerEvent("fa-base:clearStates")
    exports["fa-hud"]:sendAppEvent("hud", { display = false })
    TriggerServerEvent("apartments:cleanUpRoom")
    exports["fa-base"]:getModule("SpawnManager"):Initialize()
    TriggerEvent("hud:saveCurrentMeta")
    Citizen.Wait(1000)
end)

  
exports('devDebugToggle', devDebugToggle)

