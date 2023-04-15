showroomOpen = false

local vehicle
local vehiclesTable = {}
local shopWorker = false
local staticCam
local staticLargeCam
local showLargeCam = false
local isLargeCamActive = false
local camTimer = 0
local sr

function CreateShowroomVehicle(showroom, vehicleName)
    if vehicle then DeleteEntity(vehicle) end
    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do Citizen.Wait(0) end
    SetModelAsNoLongerNeeded(vehicleName)

    local vehicle = 0
    if showroom == 'pdm' then
        CalculateCamPos(vehicleName, 15.5)
        vehicle = CreateVehicle(vehicleName, -37.26872, -1054.309, -43.37314, 32.1, false, false)
        -- return CreateVehicle(vehicleName, -43.9, -1097.14, -42.45, 141.23, false, false)
    elseif showroom == 'tuner' then
        CalculateCamPos(vehicleName, 18)
        vehicle = CreateVehicle(vehicleName, 935.63, -968.52, -43.99, 181.74, false, false)
    elseif showroom == 'fastlane' then
        CalculateCamPos(vehicleName, 15.5)
        vehicle = CreateVehicle(vehicleName, -794.1, -226.18, -43.38, 78.68, false, false)
    end

    local preset = CarPresets[vehicleName]
    if preset then
        exports["fa-vehicles"]:SetVehicleMods(vehicle, preset.mods and preset.mods or {})
        exports["fa-vehicles"]:SetVehicleAppearance(vehicle,  preset.appearance and preset.appearance or {})
        if preset.fitment and preset.fitment.w_width then
            DecorSetBool(vehicle, "fa-wheelfitment_applied", true)
            DecorSetFloat(vehicle, "fa-wheelfitment_w_width", preset.fitment.w_width)
            DecorSetFloat(vehicle, "fa-wheelfitment_w_fl", preset.fitment.w_fl)
            DecorSetFloat(vehicle, "fa-wheelfitment_w_fr", preset.fitment.w_fr)
            DecorSetFloat(vehicle, "fa-wheelfitment_w_rl", preset.fitment.w_rl)
            DecorSetFloat(vehicle, "fa-wheelfitment_w_rr", preset.fitment.w_rr)
        end
    end
    return vehicle
end

function RenderStaticCam(showroom)
    if not showroomOpen then return end
    staticCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    if (showroom == 'pdm') then -- if (showroom == 'fastlane') then
        SetCamCoord(staticCam, -41.36324, -1052.294, -43.01)
        SetCamRot(staticCam, -15.0, 0.0, 252.063)
        SetFocusPosAndVel(-37.26872, -1054.309, -43.37314, 0.0, 0.0, 0.0)
    elseif showroom == 'pdm' then
        SetCamCoord(staticCam, -43.66, -1103.23, -41.08)
        SetCamRot(staticCam, -15.0, 0.0, 19.67)
        SetFocusPosAndVel(-43.66, -1103.23, -41.08, 0.0, 0.0, 0.0)
    elseif showroom == 'tuner' then
        SetCamCoord(staticCam, 938.49, -972.12, -43.0)
        SetCamRot(staticCam, -15.0, 0.0, 47.45)
        SetFocusPosAndVel(938.49, -972.12, -41.3, 0.0, 0.0, 0.0)
    end
    SetCamFov(staticCam, 50.0)
    RenderScriptCams(true, false, 0, 1, 0)
end

function CalculateCamPos(model, largeCamSize)
    local minDim, maxDim = GetModelDimensions(model)
    local modelSize = maxDim - minDim
    local modelVolume = modelSize.x * modelSize.y * modelSize.z
    showLargeCam = modelVolume > largeCamSize
    camTimer = 1000
end

function openShowroom(showroom, worker)
    showroomOpen = true
    sr = showroom
    local categorys = getVehiclesTable(sr)

    local isWorker = exports["fa-business"]:IsEmployedAt(showroom)
    print("isWorker", isWorker)
    shopWorker = isWorker

    exports["fa-ui"]:hideInteraction()
    Citizen.CreateThread(function()
        Wait(1000)
        exports["fa-hud"]:sendAppEvent("hud", {display = false})
        if sr == "pdm" then TriggerEvent("inhotel", true) end
        RenderStaticCam(sr)
    end)
    -- Large Cam Timer
    Citizen.CreateThread(function()
        while showroomOpen do
            if camTimer > 0 then
                camTimer = camTimer - 500
            elseif showLargeCam then
                if not isLargeCamActive then
                    staticLargeCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                    SetCamCoord(staticLargeCam, GetCamCoord(staticCam))
                    SetCamRot(staticLargeCam, GetCamRot(staticCam, 2))
                    SetCamFov(staticLargeCam, 70.0)
                    SetCamActiveWithInterp(staticLargeCam, staticCam, 1000, 100, 0)
                    isLargeCamActive = true
                end
            elseif isLargeCamActive then
                SetCamActiveWithInterp(staticCam, staticLargeCam, 1000, 100, 0)
                isLargeCamActive = false
            end
            Wait(500)
        end
    end)

    Wait(250)
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "display",
        showBuy = shopWorker,
        categorys = categorys
    })
end

local function getField(field)
    return GetVehicleHandlingFloat(vehicle, 'CHandlingData', field)
end

StatsCache = {}
local function calculateStats()
    local info = {}

    local model = GetEntityModel(vehicle)
    if StatsCache[model] then
        return StatsCache[model].info, StatsCache[model].vehClass
    end

    local isMotorCycle = IsThisModelABike(model)

    local fInitialDriveMaxFlatVel = getField("fInitialDriveMaxFlatVel")
    local fInitialDriveForce = getField("fInitialDriveForce")
    local fDriveBiasFront = getField("fDriveBiasFront")
    local fInitialDragCoeff = getField("fInitialDragCoeff")
    local fTractionCurveMax = getField("fTractionCurveMax")
    local fTractionCurveMin = getField("fTractionCurveMin")
    local fSuspensionReboundDamp = getField("fSuspensionReboundDamp")
    local fBrakeForce = getField("fBrakeForce")

    -- Acceleration: (fInitialDriveMaxFlatVel x fInitialDriveForce)/10
    -- If the fDriveBiasFront is greater than 0 but less than 1, multiply fInitialDriveForce by 1.1.
    local force = fInitialDriveForce
    if fInitialDriveForce > 0 and fInitialDriveForce < 1 then
        force = force * 1.1
    end
    local accel = (fInitialDriveMaxFlatVel * force) / 10
    info[#info + 1] = {name = "Acceleration", value = accel}

    -- Speed:
    -- ((fInitialDriveMaxFlatVel / fInitialDragCoeff) x (fTractionCurveMax + fTractionCurveMin))/40
    local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
    if isMotorCycle then speed = speed * 2 end
    info[#info + 1] = {name = "Speed", value = speed}

    -- Handling:
    -- (fTractionCurveMax + fSuspensionReboundDamp) x fTractionCurveMin
    local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
    if isMotorCycle then handling = handling / 2 end
    info[#info + 1] = {name = "Handling", value = handling}

    -- Braking:
    -- ((fTractionCurveMin / fInitialDragCoeff) x fBrakeForce) x 7
    local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7
    info[#info + 1] = {name = "Braking", value = braking}

    -- Overall Performance Bracket:
    -- ((Acceleration x 5) + Speed + Handling + Braking) * 15
    -- X Class: >1000
    -- S Class: >650
    -- A Class: >500
    -- B Class: >400
    -- C Class: >325
    -- D Class: =<325
    local perfRating = ((accel * 5) + speed + handling + braking) * 15
    local vehClass = "F"
    if isMotorCycle then
        vehClass = "M"
    elseif perfRating > 900 then
        vehClass = "X"
    elseif perfRating > 700 then
        vehClass = "S"
    elseif perfRating > 550 then
        vehClass = "A"
    elseif perfRating > 400 then
        vehClass = "B"
    elseif perfRating > 325 then
        vehClass = "C"
    else
        vehClass = "D"
    end
    StatsCache[model] = {info = info, vehClass = vehClass}
    return info, vehClass
end

function getVehiclesTable(shop)
    local _vehicles = RPC.execute("fa-carshop:getVehicles", shop)

    local categorys = {}
    for i, v in ipairs(_vehicles) do
        if not has_value(categorys, v.category) then
            table.insert(categorys, v.category)
        end
    end

    local tempTable = {}
    for i, v in ipairs(categorys) do tempTable[v] = {} end

    for i, v in ipairs(_vehicles) do
        local brandName = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, GetHashKey(v.model), Citizen.ResultAsString()))
        if brandName == "NULL" then brandName = "Custom" end

        local vehicleName =
            GetLabelText(GetDisplayNameFromVehicleModel(v.model))
        if vehicleName == "NULL" then
            vehicleName = GetDisplayNameFromVehicleModel(v.model)
        end

        local provisoryObject = {
            brand = brandName,
            name = vehicleName,
            price = v.price,
            model = v.model,
            qtd = v.stock
        }

        table.insert(tempTable[v.category], provisoryObject)
    end

    vehiclesTable = {}

    for k, v in pairs(tempTable) do
        local _temp = {}

        for k2, v2 in spairs(v, function(t, a, b)
            return t[a].name < t[b].name
        end) do table.insert(_temp, v2) end

        vehiclesTable[k] = _temp
    end

    return categorys
end

function updateSelectedVehicle(showroom, model)
    vehicle = CreateShowroomVehicle(showroom, model)
    SetVehicleDirtLevel(vehicle, 0.0)

    local vehicleData = {}

    vehicleData.traction = GetVehicleMaxTraction(vehicle)

    vehicleData.breaking = GetVehicleMaxBraking(vehicle) * 0.9650553
    if vehicleData.breaking >= 1.0 then vehicleData.breaking = 1.0 end

    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(vehicle) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then vehicleData.maxSpeed = 50.0 end

    vehicleData.acceleration = GetVehicleAcceleration(vehicle) * 2.6
    if vehicleData.acceleration >= 1.0 then vehicleData.acceleration = 1.0 end

    SendNUIMessage({data = vehicleData, type = "updateVehicleInfos"})
end

function rotation(dir)
    local entityRot = GetEntityHeading(vehicle) + dir
    SetEntityHeading(vehicle, entityRot % 360)
end

function CloseNui()
    Citizen.CreateThread(function()
        SendNUIMessage({type = "hide"})
        showroomOpen = false
        if sr == "pdm" then TriggerEvent("inhotel", false) end
        DoScreenFadeOut(0)
        Wait(400)
        DoScreenFadeIn(1000)
        SetNuiFocus(false, false)
        ClearFocus()
        RenderScriptCams(false, false, 0, 1, 0)
        DeleteEntity(vehicle)
    end)
end

RegisterNUICallback("rotate", function(data, cb)
    if (data["key"] == "left") then
        rotation(2)
    else
        rotation(-2)
    end
    cb("ok")
end)

RegisterNUICallback("SpawnVehicle", function(data, cb)
    local ShowCurr = sr
    updateSelectedVehicle(ShowCurr, data.modelcar)
end)

RegisterNUICallback("Buy", function(data, cb)
    CloseNui()
    print("model", data.modelcar)
    TriggerServerEvent("fa-carshop:change", currentLocation, currentVehicle, data.modelcar)
end)

RegisterNUICallback("menuSelected", function(data, cb)
    local categoryVehicles

    if data.menuId ~= "all" then
        categoryVehicles = vehiclesTable[data.menuId]
    else
        SendNUIMessage({
            type = "display",
            data = vehiclesTable,
            showBuy = shopWorker
        })
        return
    end

    SendNUIMessage({type = "menu", data = categoryVehicles})
end)

RegisterNUICallback("Close", function(data, cb)
    exports["fa-hud"]:sendAppEvent("hud", {display = true})
    CloseNui() 
end)
