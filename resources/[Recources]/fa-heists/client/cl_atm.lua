local rope = nil
local atm = false
local vehicle = nil
local ATMRobbery = false
local RopeAttachedToVehicle = false
local VehicleClose = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)

Citizen.CreateThread(function()
    loadExistModel("loq_atm_02_console")
    loadExistModel("loq_atm_02_des")
    loadExistModel("loq_atm_03_console")
    loadExistModel("loq_atm_03_des")
    loadExistModel("loq_fleeca_atm_console")
    loadExistModel("loq_fleeca_atm_des")
end)


local models = {
    GetHashKey("loq_fleeca_atm_console"), 
    GetHashKey("loq_atm_02_console"), 
    GetHashKey("loq_atm_03_console")
}

exports["fa-interact"]:AddPeekEntryByModel(models, {{
    event = "fa-pettycrime:atm:crack",
    id = "petty_crime_atm",
    icon = "money-bill-wave",
    label = "Search atm for cash",
    parameters = {},
  }}, {
    distance = { radius = 1.6 },
  })
exports["fa-interact"]:AddPeekEntryByModel(models, {{ 
    event = "fa-pettycrime:atm:pickup",
    id = "petty_crime_atm_pickup",
    icon = "level-up-alt",
    label = "Pick up broken ATM",
    parameters = {},
  }}, {
    distance = { radius = 1.5 },
  })

local ATMInteract = {
    data = {
        {
            id = 'atm_attach_to_object',
            label = 'Attach rope to ATM',
            icon = 'bahai',
            event = 'fa-pettycrime:attach:rope',
            parameters = {},
        }
    },   
    options = {
        distance = { radius = 2.5 },
        isEnabled = function()
            return ATMRobbery
        end
    }
}

local AttachRope = {
    group = { 2 },
    data = {
        {
            id = 'atm_attach_to_truck',
            label = 'Attach rope to Vehicle',
            icon = 'bahai',
            event = 'fa-pettycrime:atm:userope', 
            parameters = {},
        }
    },   
    options = {
        distance = { radius = 3.5 },
        isEnabled = function(pEntity, pContext)
            return not ATMRobbery and exports['fa-inventory']:hasEnoughOfItem('towrope', 1, false) and DoesVehicleHaveDoor(pEntity, 5) and isCloseToBoot(pEntity, PlayerPedId(), 1.9, pContext.model)
        end
    }
}

local DetachRope = {
    group = { 2 },
    data = {
        {
            id = 'pettycrime_atm_detachveh',
            label = 'Detach rope from Vehicle',
            icon = 'bahai',
            event = 'fa-pettycrime:atm:detach',
            parameters = {},
        }
    },   
    options = {
        distance = { radius = 3.5 },
        isEnabled = function(pEntity, pContext)
            return RopeAttachedToVehicle and DoesVehicleHaveDoor(pEntity, 5) and isCloseToBoot(pEntity, PlayerPedId(), 1.9, pContext.model)
        end
    }
}

Citizen.CreateThread(function()
    exports['fa-interact']:AddPeekEntryByFlag({'isATM'}, ATMInteract.data, ATMInteract.options)
    exports['fa-interact']:AddPeekEntryByEntityType(AttachRope.group, AttachRope.data, AttachRope.options)
    exports['fa-interact']:AddPeekEntryByEntityType(DetachRope.group, DetachRope.data, DetachRope.options)
end)

RegisterNetEvent("fa-pettycrime:attach:rope")
AddEventHandler("fa-pettycrime:attach:rope", function()
    ATMAttach()
end)

RegisterNetEvent("fa-pettycrime:atm:detach")
AddEventHandler("fa-pettycrime:atm:detach", function ()
    if RopeAttachedToVehicle then
    ATMAttachCancel()
    RopeAttachedToVehicle = false
    end
end)

function ATMAttach()
    local ped = PlayerPedId()
    local obj = GetATM()

    TaskTurnPedToFaceEntity(ped, obj.atmprope, 1000)
    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.8, 1.8, -1, 31, 0, false, false, false)

    local finished = exports["fa-taskbar"]:taskBar(5000, "Attaching rope to ATM...")
    if finished == 100 then
        TriggerEvent("inventory:removeItem", "towrope", 1)
        ATMRobbery = true
        ClearPedTasks(ped)
        local propo1 = nil
        local propo2 = nil
        local atmcoords = GetEntityCoords(obj.atmprope)
        local atmheading = GetEntityHeading(obj.atmprope)

        if obj.type == "prop_atm_02" then
            propo1 = CreateObject("loq_atm_02_des", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.35), true)
            propo2 = CreateObject("loq_atm_02_console", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.55), true)
            SetEntityHeading(propo1, atmheading)
            SetEntityHeading(propo2, atmheading)
            FreezeEntityPosition(propo1, true)
            FreezeEntityPosition(propo2, true)
        elseif obj.type == "prop_atm_03" then
            propo1 = CreateObject("loq_atm_03_des", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.35), true)
            propo2 = CreateObject("loq_atm_03_console", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.65), true)
            SetEntityHeading(propo1, atmheading)
            SetEntityHeading(propo2, atmheading)
            FreezeEntityPosition(propo1, true)
            FreezeEntityPosition(propo2, true)
        elseif obj.type == "prop_fleeca_atm" then
            propo1 = CreateObject("loq_fleeca_atm_des", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.35), true)
            propo2 = CreateObject("loq_fleeca_atm_console", vector3(atmcoords.x, atmcoords.y, atmcoords.z + 0.65), true)
            SetEntityHeading(propo1, atmheading)
            SetEntityHeading(propo2, atmheading)
            FreezeEntityPosition(propo1, true)
            FreezeEntityPosition(propo2, true)
        end

        atm = false    

        Citizen.Wait(200)

        print(json.encode(obj.atmprope))
        print(json.encode(propo2))
        local dpratm = ObjToNet(obj.atmprope)
        local netveh = VehToNet(vehicle)
        local propsdad = ObjToNet(propo2)
        TriggerServerEvent("fa-pettycrime:atm:attachRope2", dpratm, atmcoords.x, atmcoords.y, atmcoords.z, netveh, propsdad)
        SetEntityCoords(obj.atmprope, atmcoords.x, atmcoords.y, atmcoords.z - 10.0)

        local car = true
        while car do
            if IsPedInAnyVehicle(ped) then
                Citizen.Wait(math.random(25000, 45000))
                local ObjectNet = ObjToNet(propo2)
                TriggerServerEvent("fa-pettycrime:atm:prop", ObjectNet)
                car = false
                end
                Citizen.Wait(0)
            end
        else
            ATMAttachCancel()
        end
    end

function ATMAttachCancel()
    atm = false
    TriggerServerEvent("fa-fa-pettycrime:atm:deleteRope", rope)
end


RegisterNetEvent("fa-pettycrime:atm:userope")
AddEventHandler("fa-pettycrime:atm:userope", function()
    local ped = PlayerPedId()
    local veh = getVehicleClosestToMe()
    vehicle = veh
    TaskTurnPedToFaceEntity(ped, vehicle, 1000)
    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.8, 1.8, -1, 31, 0, false, false, false)
    local finished = exports["fa-taskbar"]:taskBar(5000, "Attaching rope to vehicle...")

    if finished == 100 then
        RopeAttachedToVehicle = true
        ATMRobbery = true
        ClearPedTasks(ped)
        TriggerServerEvent("fa-pettycrime:atm:clrspawn")
        atm = true
        local networkveh = VehToNet(vehicle)
        local metworkped = PedToNet(ped)
        while atm do
            local plrcoords = GetEntityCoords(ped)
            TriggerServerEvent("fa-pettycrime:atm:attachRope", networkveh, metworkped)
            Citizen.Wait(0)
        end
    end
end)

RegisterNetEvent("fa-pettycrime:atm:clrspawn")
AddEventHandler("fa-pettycrime:atm:clrspawn", function()
    RopeLoadTextures()
    rope = AddRope(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1, 7.0, 1.0, 0, 0, 0, 0, 0, 0)
end)

RegisterNetEvent("fa-pettycrime:atm:attachRope")
AddEventHandler("fa-pettycrime:atm:attachRope", function(obh1, obj1)
    local obo1 = NetToEnt(obh1)
    local obo2 = NetToEnt(obj1)
    local ocoords = GetEntityCoords(obo2)
    AttachEntitiesToRope(rope, obo1, obo2, GetOffsetFromEntityInWorldCoords(obo1, 0, -2.3, 0.5), GetPedBoneCoords(obo2, 6286, 0.0, 0.0, 0.0), 7.0, 0, 0, "rope_attach_a", "rope_attach_b")
    SlideObject(rope, ocoords.x, ocoords.y, ocoords.z, 1.0, 1.0, 1.0, true)
end)

RegisterNetEvent("fa-pettycrime:atm:attachRope2")
AddEventHandler("fa-pettycrime:atm:attachRope2", function(atmo, atmco1, atmco2, atmco3, obh1, obj1)
    NetworkRequestControlOfEntity(atmo)
    local obo1 = NetToEnt(obh1)
    local obo2 = NetToEnt(obj1)
    local obo3 = NetToEnt(atmo)
    local propocoord = GetEntityCoords(obo2)
    SetEntityCoords(obo3, atmco1, atmco2, atmco3 - 10.0)
    AttachEntitiesToRope(rope, obo1, obo2, GetOffsetFromEntityInWorldCoords(obo1, 0, -2.3, 0.5), propocoord.x, propocoord.y, propocoord.z + 1.0, 7.0, 0, 0, "rope_attach_a", "rope_attach_b")
end)

RegisterNetEvent("fa-pettycrime:atm:prop")
AddEventHandler("fa-pettycrime:atm:prop", function(obh)
    local ATMProp = NetToEnt(obh)
    FreezeEntityPosition(ATMProp, false)
    SetObjectPhysicsParams(ATMProp, 170.0, -1.0, 30.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0)
end)

RegisterNetEvent("fa-pettycrime:atm:crack")
AddEventHandler("fa-pettycrime:atm:crack", function()
    local prop = GetProp()
    local ATMObject = ObjToNet(prop)
    TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_KNEEL', 0, false)
    local finished = exports["fa-taskbar"]:taskBar(30000, "Searching...")
    if finished ~= 100 then
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("fa-pettycrime:atm:delete", ATMObject)
        TriggerServerEvent("fa-fa-pettycrime:atm:deleteRope", rope)
        TriggerEvent("fa-pettycrime:atm:reward")
    end
end)

RegisterNetEvent("fa-pettycrime:atm:pickup")
AddEventHandler("fa-pettycrime:atm:pickup", function ()
    local prop = GetProp()
    local ATMObject = ObjToNet(prop)
    TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_KNEEL', 0, false)
    local finished = exports["fa-taskbar"]:taskBar(60000, "Picking up...")
    if finished == 100 then
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent("fa-fa-pettycrime:atm:deleteRope", rope)
    TriggerServerEvent("fa-pettycrime:atm:delete", ATMObject)
    TriggerEvent("player:receiveItem", "atmblackbox", 1)
    end
end)

RegisterNetEvent("fa-pettycrime:pickup:crack")
AddEventHandler("fa-pettycrime:pickup:crack", function ()
    local finished = exports["fa-interface"]:taskBarSkill(3000,20)
    if finished ~= 100 then
        return
    end
    local finished = exports["fa-interface"]:taskBarSkill(3000,8)
    if finished ~= 100 then
        return
    end
    local finished = exports["fa-interface"]:taskBarSkill(3000,10)
    if finished ~= 100 then
        return
    end
    local finished = exports["fa-interface"]:taskBarSkill(3000,5)
    if finished ~= 100 then
        return
    end
    local finished = exports["fa-interface"]:taskBarSkill(3000,3)
    if finished ~= 100 then
        return
    end
    TriggerEvent("inventory:removeItem", "atmblackbox", 1)
    TriggerEvent("fa-pettycrime:atm:reward")

end)

RegisterNetEvent("fa-pettycrime:atm:reward")
AddEventHandler("fa-pettycrime:atm:reward", function ()
    local reward = math.random(2)
        if reward == 1 then
            TriggerServerEvent("fa-pettycrime:atm:moneyreward", math.random(1000, 3000))
        elseif reward == 2 then
            TriggerEvent("player:receiveItem", "markedbills", math.random(10, 20))
            TriggerEvent("player:receiveItem", "phonedongle", 1)
    end
end)

RegisterNetEvent("fa-pettycrime:atm:delete")
AddEventHandler("fa-pettycrime:atm:delete", function(obh)
    local obo = NetToEnt(obh)
    DeleteEntity(obo)
end)

RegisterNetEvent("fa-fa-pettycrime:atm:deleteRope")
AddEventHandler("fa-fa-pettycrime:atm:deleteRope", function(rope)
    DeleteRope(rope)
    rope = nil
end)

function GetATM()
    for k,v in pairs({"prop_atm_02", "prop_atm_03", "prop_fleeca_atm"}) do 
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v))
        if DoesEntityExist(obj) then
            local ahio = {
                atmprope = obj,
                type = v
            }
            return ahio
        end
    end
    return nil
end

function GetProp()
    for k,v in pairs({"loq_fleeca_atm_console", "loq_atm_02_console", "loq_atm_03_console"}) do 
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v))
        if DoesEntityExist(obj) then
            return obj
        end
    end
    return nil
end

function loadExistModel(hash)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end
    end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

AddEventHandler("fa-inventory:itemUsed", function(item)
    if item == "atmblackbox" then
        TriggerEvent("fa-pettycrime:pickup:crack")
    end
end)