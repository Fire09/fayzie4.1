--[[

    Variables

]]

local weedPlants = {}
local activeZones = {}
local inZone = false

--[[

    Functions

]]

function addPlant(pPlant)
    exports["fa-polyzone"]:AddCircleZone("fa-weed:plant", pPlant.coords, 50, {
        --debugPoly = true,
        data = pPlant,
    })

    weedPlants[pPlant.id] = pPlant
end

function createWeedStageAtCoords(pStage, pCoords)
    local model = PlantConfig.GrowthObjects[pStage].hash
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local plantObject = CreateObject(model, pCoords.x, pCoords.y, pCoords.z + PlantConfig.GrowthObjects[pStage].zOffset, 0, 0, 0)
    FreezeEntityPosition(plantObject, true)
    -- SetEntityHeading(plantObject, math.random(0, 360) + 0.0)
    return plantObject
end

function getStageFromPercent(pPercent)
    local growthObjects = #PlantConfig.GrowthObjects - 1
    local percentPerStage = 100 / growthObjects
    return math.floor((pPercent / percentPerStage) + 1.5)
end

function getPlantGrowthPercent(pPlant)
    local timeDiff = (GetCloudTimeAsInt() - pPlant.timestamp) / 60
    local genderFactor = (pPlant.gender == 1 and PlantConfig.MaleFactor or 1)
    local fertilizerFactor = pPlant.strain.n >= 0.9 and PlantConfig.FertilizerFactor or 1.0
    local growthFactors = (PlantConfig.GrowthTime * genderFactor * fertilizerFactor)
    return math.min((timeDiff / growthFactors) * 100, 100.0)
end

function playPourAnimation()
    RequestAnimDict("weapon@w_sp_jerrycan")
    while (not HasAnimDictLoaded("weapon@w_sp_jerrycan")) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
end

function showPlantMenu(pPlantId)
    local plant = weedPlants[pPlantId]
    local growth = getPlantGrowthPercent(plant)
    local water = plant.strain.water * 100.0
    local myjob = exports["isPed"]:isPed("myjob")
    local context = {}

    local context = {}
    context[#context+1] = {
        title = 'Growth: ' .. string.format("%.2f", growth) .. "%",
        description = 'Gender: ' .. (plant.gender == 1 and 'Male' or 'Female'),
    }

    --Only allow adding water/fertilzier before harvest time
    if growth < PlantConfig.HarvestPercent then
        context[#context+1] = {
            title = 'Add Water',
            description = 'Water: ' .. string.format("%.2f", water) .. "%",
            key = { id = pPlantId },
            action = 'fa-weed:addWater',
            disabled = not exports["fa-inventory"]:hasEnoughOfItem("water", 1, false),
        }

        context[#context+1] = {
            title  = 'Add Fertilizer',
            disabled = not exports["fa-inventory"]:hasEnoughOfItem("fertilizer", 1, false),
            description = "",
            children = {
                {
                    title = 'Add Fertilizer' .. ' (N)',
                    key = { id = pPlantId, type = "n" }, 
                    action = 'fa-weed:addFertilizer',
                },
                {
                    title = 'Add Fertilizer' .. ' (P)',
                    key = { id = pPlantId, type = "p" },
                    action = 'fa-weed:addFertilizer',
                },
                {
                    title = 'Add Fertilizer' .. ' (K)',
                    key = { id = pPlantId, type = "k" },
                    action = 'fa-weed:addFertilizer',
                }
            }
        }
    end

    --Only allow changing gender in the first 2~ stages
    if getStageFromPercent(growth) < 3 and plant.gender == 0 then
        context[#context+1] = {
            title = 'Add Male Seed',
            key = { id = pPlantId },
            action = 'fa-weed:addMaleSeed',
            description = 'Make the plant preggies',
            disabled = not exports["fa-inventory"]:hasEnoughOfItem("maleseed", 1, false)
        }
    end

    if myjob == "police" or myjob == "state" or myjob == "judge" then
        context[#context+1] = {
            title = 'Destroy Plant',
            description = "", 
            key = { id = pPlantId },
            action = 'fa-weed:removePlant',
        }
    end

    exports["fa-interface"]:showContextMenu(context);
end

--[[

    Events

]]

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for id, plant in pairs(activeZones) do
        DeleteObject(plant)
    end
end)

AddEventHandler("fa-polyzone:enter", function(zone, data)
    if zone == "fa-weed:area" then
        inZone = true
    elseif zone == "fa-weed:plant" then
        if activeZones[data.id] == nil then
            local plantGrowth = getPlantGrowthPercent(data)
            local curStage = getStageFromPercent(plantGrowth)
            local object = createWeedStageAtCoords(curStage, data.coords)
            if weedPlants[data.id] then
                weedPlants[data.id]["stage"] = curStage
                activeZones[data.id] = object
            end
        end
    end
end)

AddEventHandler("fa-polyzone:exit", function(zone, data)
    if zone == "fa-weed:area" then
        inZone = false
    elseif zone == "fa-weed:plant" then
        if activeZones[data.id] ~= nil then
            DeleteObject(activeZones[data.id])
            activeZones[data.id] = nil
        end
    end
end)

AddEventHandler("fa-inventory:itemUsed", function(item)
    if item == "femaleseed" then
        inZone = true
        if inZone == true then
            local plyCoords = GetEntityCoords(PlayerPedId())
            local offsetCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.7, 0)
            local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(offsetCoords.x, offsetCoords.y, offsetCoords.z, offsetCoords.x, offsetCoords.y, offsetCoords.z - 2, 1, 0, 4)
            local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
            if hit then
                local foundHash = false
                for matHash,matType in pairs(MaterialHashes) do
                    if materialHash == matHash then
                        local typeMod = PlantConfig.TypeModifiers[matType]
                        foundHash = true
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        local finished = exports["fa-taskbar"]:taskBar(15000, 'Planting Seed', false, true, false, false, nil, 5.0, PlayerPedId())
                        ClearPedTasks(PlayerPedId())
                        if finished == 100 then
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                            RPC.execute("fa-weed:plantSeed", endCoords, typeMod)
                            
                            TriggerEvent("inventory:removeItem", item, 1)
                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    end
                end
                if not foundHash then
                    TriggerEvent("DoLongHudText", 'I should find better soil to plant this')
                end
            end
        else
            TriggerEvent("DoLongHudText",'I should find a better area to plant this')
        end
    end
end)

RegisterNetEvent("fa-weed:trigger_zone", function (type, pData)
    --New plant being added
    if type == 1 then
        addPlant(pData)
    end

    --Plant being harvested/updated
    if type == 2 then
        weedPlants[pData.id] = pData

        if activeZones[pData.id] ~= nil then
            local plantGrowth = getPlantGrowthPercent(pData)
            local curStage = getStageFromPercent(plantGrowth)
            local object = createWeedStageAtCoords(curStage, pData.coords)
            DeleteObject(activeZones[pData.id])
            activeZones[pData.id] = object
        end
    end

    --Plant being removed
    if type == 3 then
        if activeZones[pData.id] ~= nil then
            DeleteObject(activeZones[pData.id])
            activeZones[pData.id] = nil
        end

        weedPlants[pData.id] = nil
    end
end)

AddEventHandler("fa-weed:checkPlant", function(pContext, pEntity)
    local plantId = false

    for id, plant in pairs(activeZones) do
        if pEntity == plant then
            plantId = id
            break
        end
    end

    if not plantId then return end

    showPlantMenu(plantId)
end)

RegisterInterfaceCallback("fa-weed:addWater", function (pParams)
    if not exports["fa-inventory"]:hasEnoughOfItem("water", 1, true, true) then return end

    playPourAnimation()
    local finished = exports["fa-taskbar"]:taskBar(2000, "Adding Water", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local success = RPC.execute("fa-weed:addWater", pParams.key.id)
        if not success then
            TriggerEvent("DoLongHudText", "[ERRO]: Could not add water", 2)
        else
            TriggerEvent("inventory:removeItem", "water", 1)
        end
    end
    showPlantMenu(pParams.key.id)
end)

RegisterInterfaceCallback("fa-weed:addFertilizer", function (pParams)
    if not exports["fa-inventory"]:hasEnoughOfItem("fertilizer", 1, true, true) then return end

    playPourAnimation()
    local finished = exports["fa-taskbar"]:taskBar(2000, "Adding Fertilizer", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
            local success = RPC.execute("fa-weed:addFertilizer", pParams.key.id, pParams.key.type)
        if not success then
            TriggerEvent("DoLongHudText", "[ERRO]: Could not add fertilizer.")
        else
            TriggerEvent("inventory:removeItem", "fertilizer", 1)
        end
    end
    showPlantMenu(pParams.key.id)
end)

RegisterInterfaceCallback("fa-weed:addMaleSeed", function (pParams)
    if not exports["fa-inventory"]:hasEnoughOfItem("maleseed", 1, true, true) then return end

    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    local finished = exports["fa-taskbar"]:taskBar(3000, "Adding Male Seed", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("fa-weed:addMaleSeed", pParams.key.id)
        TriggerEvent("inventory:removeItem", "maleseed", 1)
    end
    showPlantMenu(pParams.key.id)
end)

RegisterInterfaceCallback("fa-weed:removePlant", function (pParams)
    TriggerEvent("animation:PlayAnimation","layspike")
    local finished = exports["fa-taskbar"]:taskBar(3000, "Removing", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local getFertilizer = getPlantGrowthPercent(weedPlants[pParams.key.id]) > 20.0
        local success = RPC.execute("fa-weed:removePlant", pParams.key.id, getFertilizer)
        if not success then
            print("[ERRO]: Could not remove. pid:", pParams.key.id)
        end
    end
end)

AddEventHandler("fa-weed:pickPlant", function(pContext, pEntity)
    local plantId = false

    for id, plant in pairs(activeZones) do
        if pEntity == plant then
            plantId = id
            break
        end
    end

    if not plantId then return end

    local plant = weedPlants[plantId]
    if getPlantGrowthPercent(plant) < PlantConfig.HarvestPercent then
        TriggerEvent("DoLongHudText", "This plant is not ready yet.", 2)
        return
    end

    local timeSinceHarvest = GetCloudTimeAsInt() - plant.last_harvest
    if timeSinceHarvest <= (PlantConfig.TimeBetweenHarvest * 60) then
        TriggerEvent("DoLongHudText", "This plant has been harvested recently! Better come back later to try to re-up again.", 2)
        return
    end

    local plyWeight = exports["fa-inventory"]:getCurrentWeight()
    if plyWeight + 35.0 > 250.0 and plant.gender == 0 then
        TriggerEvent("DoLongHudText", "You can't carry that much weight.", 2)
        return
    end

    TriggerEvent("animation:PlayAnimation", "layspike")
    local finished = exports["fa-taskbar"]:taskBar(10000, "Harvesting", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("fa-weed:harvestPlant", plantId)
    end
end)

--[[

    Threads

]]

--Creates da weed
--TODO: cache close plants
Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddPolyZone("fa-weed:area", {
        vector2(-342.00247192383, -1253.5378417969),
        vector2(84.262420654297, -1242.6663818359),
        vector2(520.96197509766, -1240.0241699219),
        vector2(1258.8310546875, -1228.4302978516),
        vector2(1407.0397949219, -1121.8983154297),
        vector2(1649.0086669922, -976.5205078125),
        vector2(1924.1279296875, -822.08416748047),
        vector2(2068.68359375, -1006.6109008789),
        vector2(2859.5693359375, -1742.0363769531),
        vector2(2648.7900390625, -2252.2673339844),
        vector2(1814.0902099609, -2787.0224609375),
        vector2(1344.9066162109, -2808.6821289062),
        vector2(1001.0428466797, -2734.3996582031),
        vector2(618.41564941406, -2574.2868652344),
        vector2(388.52581787109, -2406.0385742188),
        vector2(66.28978729248, -2305.4445800781),
        vector2(31.951961517334, -2045.0936279297),
        vector2(-192.29954528809, -1838.7125244141),
        vector2(-405.87139892578, -1651.3764648438)
    }, {
        --debugGrid = true,
        gridDivisions = 25,
        minZ = 10.0,
        maxZ = 500.0,
    })

    Citizen.Wait(1000)

    local _plants = RPC.execute("fa-weed:getPlants")
    for idx, plant in pairs(_plants) do
        addPlant(plant)
    end
end)