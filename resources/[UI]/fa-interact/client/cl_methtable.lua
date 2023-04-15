local Entries = {}
local MethInformation = {}
local Meth = {}
local KnownTables = {}
local PeekEntries = { ['model'] = {}, ['flag'] = {}, ['entity'] = {}, ['polytarget'] = {} }
EntryCount, ListCount, UpdateRequired, RefreshingList = 0, 0, false, false
local MethbenchID = 0 
local ConCoords = 0
local PlacedTable = false

RegisterNetEvent('fa-meth:place_table')
AddEventHandler('fa-meth:place_table', function()
    PlacedTable = true
    TriggerEvent('inventory:removeItem', 'methtable', 1)
    TriggerEvent("fa-drugs:place-meth", `bkr_prop_meth_table01a`)
end)

RegisterNetEvent("fa-drugs:place-meth-bench")
AddEventHandler("fa-drugs:place-meth-bench", function(model, coords)
    RequestModel(model)
    CreatedObjects = CreateObject(model, coords)
    FreezeEntityPosition(CreatedObjects, true)
    TriggerServerEvent("fa-drugs:new-meth-bench", model, coords)
end)

function MethTarget(distance)
    local Cam = GetGameplayCamCoord()
    local _, Hit, Coords, _, Entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(Cam, GetCoordsFromCam(7.0, Cam), -1, PlayerPedId(), 4))
    return Coords
end

function GetCoordsFromCam(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local hidden = false
scenes = {}
local voidDrugsMethB = false
local coords = {}

RegisterNetEvent("fa-drugs:place-meth")
AddEventHandler("fa-drugs:place-meth", function(model)
    exports['fa-interface']:showInteraction('[E] Confirm Placement')
    local placement = MethTarget()
    coords = {}
    voidDrugsMethB = true

    while voidDrugsMethB do
        RequestModel(model)
        DisableControlAction(0, 200, true)
        placement = MethTarget()
        if placement ~= nil then
            Object = model
            local objTypeKey = GetHashKey(Object)
            curObject = CreateObject(Object,placement,false,false,false)
            Citizen.Wait(0)
            DeleteObject(curObject)
            SetModelAsNoLongerNeeded(objTypeKey)
            SetEntityCollision(curObject, false)
            SetEntityCompletelyDisableCollision(curObject, false, false)
            SetEntityAlpha(Object, 0)
        end
        if IsControlJustReleased(0, 46) then
            exports['fa-interface']:hideInteraction()
            TriggerEvent("animation:PlayAnimation","mechanic3")
            local finished = exports['fa-taskbar']:taskBar(7000, 'Placing')
            if finished == 100 then
                TriggerEvent("fa-drugs:place-meth-bench", model, placement)
                TriggerEvent('DoLongHudText', 'You placed the meth bench use the eye to interact', 1)
                return
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        TriggerServerEvent("ReceiveCoords")
    break
    end
end)

-- Script

local StartedCook = false
local PreparedGoods = false
local CombinedGoods = false
local MixedInWater = false
local AddedSolvent = false
local Crystalized = false
local Packed = false

local CooldownCook = false

-- Start Cook Interact 3rd eye

RegisterNetEvent('fa-meth:start_cook')
AddEventHandler('fa-meth:start_cook', function()
    if PlacedTable and not CooldownCook then
        StartedCook = true
        -- Minigame
        TriggerEvent('DoLongHudText', 'Cook Started', 1)
    else
        print('[DEBUG] - [VOIDRP] - WAIT 1 HOUR COOLDOWN PER METH COOK!')
    end
end)

-- Prepare Good interact 3rd eye

RegisterNetEvent('fa-meth:prepare-goods')
AddEventHandler('fa-meth:prepare-goods', function()
    if StartedCook and not PreparedGoods then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        TriggerEvent("animation:PlayAnimation","browse")
        local finished = exports['fa-taskbar']:taskBar(30000, 'Preparing Goods')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            PreparedGoods = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Combine Goods 3rd Eye Interact

RegisterNetEvent('fa-meth:combine-goods')
AddEventHandler('fa-meth:combine-goods', function()
    if StartedCook and PreparedGoods and not CombinedGoods then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        TriggerEvent("animation:PlayAnimation","type")
        local finished = exports['fa-taskbar']:taskBar(60000,'Combine Goods')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            CombinedGoods = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Mix In Water

RegisterNetEvent('fa-meth:mix_in_water')
AddEventHandler('fa-meth:mix_in_water', function()
    if StartedCook and PreparedGoods and CombinedGoods and not MixedInWater then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        RequestAnimDict("weapon@w_sp_jerrycan")
        while ( not HasAnimDictLoaded( "weapon@w_sp_jerrycan" ) ) do
            Wait(10)
        end
        Wait(50)
        TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
        Wait(50)
        TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
        local finished = exports['fa-taskbar']:taskBar(45000,'Mix In Water')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            MixedInWater = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Add Solvent

RegisterNetEvent('fa-meth:add_solvent')
AddEventHandler('fa-meth:add_solvent', function()
    if StartedCook and PreparedGoods and CombinedGoods and MixedInWater and not AddedSolvent then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        RequestAnimDict("weapon@w_sp_jerrycan")
        while ( not HasAnimDictLoaded( "weapon@w_sp_jerrycan" ) ) do
            Wait(10)
        end
        Wait(50)
        TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
        Wait(50)
        TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
        local finished = exports['fa-taskbar']:taskBar(50000,'Adding Solvent')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            ClearPedTasks(PlayerPedId())
            AddedSolvent = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Crystalize Product

RegisterNetEvent('fa-meth:crystalize_product')
AddEventHandler('fa-meth:crystalize_product', function()
    if StartedCook and PreparedGoods and CombinedGoods and MixedInWater and AddedSolvent and not Crystalized then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        TriggerEvent("animation:PlayAnimation","browse")
        local finished = exports['fa-taskbar']:taskBar(120000,'Crystalizing Product')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Crystalized = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Pack Product

RegisterNetEvent('fa-meth:pack-product')
AddEventHandler('fa-meth:pack-product', function()
    if StartedCook and PreparedGoods and CombinedGoods and MixedInWater and AddedSolvent and Crystalized and not Packed then
        FreezeEntityPosition(GetPlayerPed(-1), true)
        TriggerEvent("animation:PlayAnimation","browse")
        local finished = exports['fa-taskbar']:taskBar(170000,'Packing Product')
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Packed = true
            TriggerEvent('DoLongHudText', 'Step completed.', 1)
            TriggerEvent('player:receiveItem', 'methlabcured', 1)
            TriggerEvent('fa-meth:cooldown')
        else
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end
end)

-- Delete Bench

RegisterNetEvent('fa-methtable:pick_up')
AddEventHandler('fa-methtable:pick_up', function()
    if PlacedTable then
        TriggerEvent("animation:PlayAnimation","mechanic3")
        FreezeEntityPosition(PlayerPedId(), true)
        local finished = exports['fa-taskbar']:taskBar(10000 ,'Picking Up Table')
        if finished == 100 then
            TriggerEvent('player:receiveItem', 'methtable', 1)
            FreezeEntityPosition(PlayerPedId(), false)
            DeleteEntity(CreatedObjects)
            PlacedTable = false
        end
    else
        print('NOT PLACED A TABLE')
    end
end)

RegisterNetEvent('fa-meth:cooldown')
AddEventHandler('fa-meth:cooldown', function()
    CooldownCook = true
    Citizen.Wait(3.6e+6)
    StartedCook = false
    PreparedGoods = false
    CombinedGoods = false
    MixedInWater = false
    AddedSolvent = false
    Crystalized = false
    Packed = false
    CooldownCook = false
end)

-- Target

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)

-- Start Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'start_cooking',
            label = "Start Cook",
            icon = "temperature-high",
            event = "fa-meth:start_cook",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return not StartedCook
        end,
    }
}

-- Prepare Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'prepare_meth_goods',
            label = "Preparing Goods",
            icon = "temperature-high",
            event = "fa-meth:prepare-goods",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and not PreparedGoods
        end,
    }
}

-- Combine Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
    
        {
            id = 'combine_meth_goods',
            label = "Combine Goods",
            icon = "temperature-high",
            event = "fa-meth:combine-goods",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and PreparedGoods and not CombinedGoods
        end,
    }
}

-- Mix In Water Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'mix_in_water',
            label = "Mix in water",
            icon = "temperature-high",
            event = "fa-meth:mix_in_water",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and PreparedGoods and CombinedGoods and not MixedInWater
        end,
    }
}

-- Add Solvent Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'add_solvent',
            label = "Add Solvent",
            icon = "temperature-high",
            event = "fa-meth:add_solvent",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and PreparedGoods and CombinedGoods and MixedInWater and not AddedSolvent
        end,
    }
}

-- Crystalize Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'crystalize_product',
            label = "Crystalize Product",
            icon = "temperature-high",
            event = "fa-meth:crystalize_product",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and PreparedGoods and CombinedGoods and MixedInWater and AddedSolvent and not Crystalized
        end,
    }
}

-- Pack Product Eye

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'pack_product',
            label = "Pack Product",
            icon = "temperature-high",
            event = "fa-meth:pack-product",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function()
            return StartedCook and PreparedGoods and CombinedGoods and MixedInWater and AddedSolvent and Crystalized and not Packed
        end,
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { 538990259 },
    data = {
        {
            id = 'pick_up_table',
            label = "Pickup table",
            icon = "arrow-up",
            event = "fa-methtable:pick_up",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
    }
}

-- Animations