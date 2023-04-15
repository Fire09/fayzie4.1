--[ Start Of Electrical Job ]--

local ElectricalJobInProgress = false
local ElectricalJob1 = false
local ElectricalJob2 = false
local ElectricalJob3 = false
local ElectricalJob4 = false
local ElectricalJob5 = false
local ElectricalJob6 = false
local ElectricalJob7 = false
local ElectricalJob8 = false


exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_1", vector3(1695.93,2536.057,45.55283), 1, 1.8, {
    heading=270,
    minZ=41.77,
    maxZ=45.77
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_1", {
{
    event = "fa-jail:work-box-1",
    id = "faye_electrical_job_1",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob1
    end,
});

RegisterNetEvent('fa-jail:work-box-1')
AddEventHandler('fa-jail:work-box-1', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob1 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip1)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 2 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_2", vector3(1652.62, 2565.13, 45.56), 2, 3.4, {
    heading=0,
    minZ=42.96,
    maxZ=46.96
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_2", {
{
    event = "fa-jail:work-box-2",
    id = "faye_electrical_job_2",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob2
    end,
});

RegisterNetEvent('fa-jail:work-box-2')
AddEventHandler('fa-jail:work-box-2', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob2 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip2)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 3 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_3", vector3(1630.0, 2565.25, 45.56), 2, 3.8, {
    heading=0,
    minZ=43.16,
    maxZ=47.16
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_3", {
{
    event = "fa-jail:work-box-3",
    id = "faye_electrical_job_3",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob3
    end,
});

RegisterNetEvent('fa-jail:work-box-3')
AddEventHandler('fa-jail:work-box-3', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob3 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip3)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 4 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_4", vector3(1617.3387, 2578.6164, 45.552791), 2, 2.2, {  
    heading=270,
    minZ=43.36,
    maxZ=47.36
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_4", {
{
    event = "fa-jail:work-box-4",
    id = "faye_electrical_job_4",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob4
    end,
});

RegisterNetEvent('fa-jail:work-box-4')
AddEventHandler('fa-jail:work-box-4', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob4 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip4)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 5 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_5", vector3(1630.5155, 2527.2539, 45.552795), 1, 1, {
    heading=315,
    minZ=42.77,
    maxZ=46.77
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_5", {
{
    event = "fa-jail:work-box-5",
    id = "faye_electrical_job_5",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob5
    end,
});

RegisterNetEvent('fa-jail:work-box-5')
AddEventHandler('fa-jail:work-box-5', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob5 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip5)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 6 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_6", vector3(1655.8526, 2489.7385, 45.552795), 1, 1, {
    heading=315,
    minZ=42.77,
    maxZ=46.77
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_6", {
{
    event = "fa-jail:work-box-6",
    id = "faye_electrical_job_6",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob6
    end,
});

RegisterNetEvent('fa-jail:work-box-6')
AddEventHandler('fa-jail:work-box-6', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob6 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip6)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 7 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_7", vector3(1657.6341, 2489.0827, 45.552795), 1, 1, {
    heading=315,
    minZ=42.76,
    maxZ=46.76
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_7", {
{
    event = "fa-jail:work-box-7",
    id = "faye_electrical_job_7",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob7
    end,
});

RegisterNetEvent('fa-jail:work-box-7')
AddEventHandler('fa-jail:work-box-7', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob7 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip7)
        TriggerServerEvent("checkJailTime",true)
    end
end)

-- Electrical Job 8 
exports["fa-polytarget"]:AddBoxZone("faye_electrical_job_8", vector3(1666.4895, 2487.8957, 45.552833), 2, 2.2, {
    heading=275,
    minZ=43.36,
    maxZ=47.36
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_electrical_job_8", {
{
    event = "fa-jail:work-box-8",
    id = "faye_electrical_job_8",
    icon = "circle",
    label = "Fix Electrical",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return ElectricalJob8
    end,
});

RegisterNetEvent('fa-jail:work-box-8')
AddEventHandler('fa-jail:work-box-8', function()
    TriggerEvent("animation:PlayAnimation","welding")
    FreezeEntityPosition(PlayerPedId(), true)
    ElectricalJob8 = false
    local finished = exports['fa-taskbar']:taskBar(7500, 'Repairing Electrical Box')
    if finished == 100 then
        ElectricalJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('fa-jail:removeTime', math.random(1, 3))
        RemoveBlip(ElectricalJobBlip8)
        TriggerServerEvent("checkJailTime",true)
    end
end)

----------------------------------------------------------------------------------------

RegisterNetEvent('fa-jail:electrical-get-job')
AddEventHandler('fa-jail:electrical-get-job', function()
    local roll = math.random(1, 8)
    if roll == 1 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob1 = true
        ElectricalJobBlip1 = AddBlipForCoord(1695.93,2536.057,45.55283)
        SetBlipSprite(ElectricalJobBlip1, 1)
        SetBlipSprite(ElectricalJobBlip1, 466)
        SetBlipScale(ElectricalJobBlip1, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip1)
    elseif roll == 2 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob2 = true
        ElectricalJobBlip2 = AddBlipForCoord(1652.62, 2565.13, 45.56)
        SetBlipSprite(ElectricalJobBlip2, 1)
        SetBlipSprite(ElectricalJobBlip2, 466)
        SetBlipScale(ElectricalJobBlip2, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip2)
    elseif roll == 3 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob3 = true
        ElectricalJobBlip3 = AddBlipForCoord(1630.0, 2565.25, 45.56)
        SetBlipSprite(ElectricalJobBlip3, 1)
        SetBlipSprite(ElectricalJobBlip3, 466)
        SetBlipScale(ElectricalJobBlip3, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip3)
    elseif roll == 4 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob4 = true
        ElectricalJobBlip4 = AddBlipForCoord(1617.3387, 2578.6164, 45.552791)
        SetBlipSprite(ElectricalJobBlip4, 1)
        SetBlipSprite(ElectricalJobBlip4, 466)
        SetBlipScale(ElectricalJobBlip4, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip4)
    elseif roll == 5 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob5 = true
        ElectricalJobBlip5 = AddBlipForCoord(1630.5155, 2527.2539, 45.552795)
        SetBlipSprite(ElectricalJobBlip5, 1)
        SetBlipSprite(ElectricalJobBlip5, 466)
        SetBlipScale(ElectricalJobBlip5, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip5)
    elseif roll == 6 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob6 = true
        ElectricalJobBlip6 = AddBlipForCoord(1655.8526, 2489.7385, 45.552795)
        SetBlipSprite(ElectricalJobBlip6, 1)
        SetBlipSprite(ElectricalJobBlip6, 466)
        SetBlipScale(ElectricalJobBlip6, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip6)
    elseif roll == 7 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob7 = true
        ElectricalJobBlip7 = AddBlipForCoord(1657.6341, 2489.0827, 45.552795)
        SetBlipSprite(ElectricalJobBlip7, 1)
        SetBlipSprite(ElectricalJobBlip7, 466)
        SetBlipScale(ElectricalJobBlip7, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip7)
    elseif roll == 8 and not ElectricalJobInProgress then
        ElectricalJobInProgress = true
        TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
        ElectricalJob8 = true
        ElectricalJobBlip8 = AddBlipForCoord(1666.4895, 2487.8957, 45.552833)
        SetBlipSprite(ElectricalJobBlip8, 1)
        SetBlipSprite(ElectricalJobBlip8, 466)
        SetBlipScale(ElectricalJobBlip8, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Electrical Job")
        EndTextCommandSetBlipName(ElectricalJobBlip8)
    end
end)

--[ End Of Electrical JOb ]--

--[ Start Of Gardening Job ]--

local pGarden1 = false
local pGarden2 = false
local pGarden3 = false
local pGarden4 = false
local pGarden5 = false

RegisterNetEvent('fa-jail:startWatering')
AddEventHandler('fa-jail:startWatering', function()
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('attachItem', 'wateringcan2')
    playPourAnimation(PlayerPedId())
    exports['fa-interface']:hideInteraction()
    local finished = exports['fa-taskbar']:taskBar(15000, 'Watering...')
    if finished == 100 then
        TriggerEvent('propattach:destroyCurrent')
        FreezeEntityPosition(PlayerPedId(), false)

        TriggerServerEvent('fa-jail:removeTime', math.random(1, 5))
        TriggerServerEvent("checkJailTime",true)
    else
        TriggerEvent('propattach:destroyCurrent')
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent('DoLongHudText', 'You did a really shit job and the DOC didn\'t take off any time.', 2)
    end
end)

RegisterNetEvent('fa-jail:getGardeningJob')
AddEventHandler('fa-jail:getGardeningJob', function()
    local aspect = math.random(1, 5)

    if aspect == 1 then
        pGarden1 = true
        TriggerEvent('DoLongHudText', 'Go and water the designated area marked on your GPS.', 1)

        pGardening1 = AddBlipForCoord(1707.39, 2482.55, 45.55)
        SetBlipSprite(pGardening1, 1)
        SetBlipSprite(pGardening1, 464)
        SetBlipScale(pGardening1, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Designated Area")
        EndTextCommandSetBlipName(pGardening1)
    elseif aspect == 2 then
        pGarden2 = true
        TriggerEvent('DoLongHudText', 'Go and water the designated area marked on your GPS.', 1)

        pGardening2 = AddBlipForCoord(1720.26, 2497.27, 45.55)
        SetBlipSprite(pGardening2, 1)
        SetBlipSprite(pGardening2, 464)
        SetBlipScale(pGardening2, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Designated Area")
        EndTextCommandSetBlipName(pGardening2)
    elseif aspect == 3 then
        pGarden3 = true
        TriggerEvent('DoLongHudText', 'Go and water the designated area marked on your GPS.', 1)

        pGardening3 = AddBlipForCoord(1734.79, 2506.41, 45.55)
        SetBlipSprite(pGardening3, 1)
        SetBlipSprite(pGardening3, 464)
        SetBlipScale(pGardening3, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Designated Area")
        EndTextCommandSetBlipName(pGardening3)
    elseif aspect == 4 then
        pGarden4 = true
        TriggerEvent('DoLongHudText', 'Go and water the designated area marked on your GPS.', 1)

        pGardening4 = AddBlipForCoord(1756.29, 2508.69, 45.55)
        SetBlipSprite(pGardening4, 1)
        SetBlipSprite(pGardening4, 464)
        SetBlipScale(pGardening4, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Designated Area")
        EndTextCommandSetBlipName(pGardening4)
    elseif aspect == 5 then
        pGarden5 = true
        TriggerEvent('DoLongHudText', 'Go and water the designated area marked on your GPS.', 1)

        pGardening5 = AddBlipForCoord(1707.99, 2550.01, 45.55)
        SetBlipSprite(pGardening5, 1)
        SetBlipSprite(pGardening5, 464)
        SetBlipScale(pGardening5, 1.2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Designated Area")
        EndTextCommandSetBlipName(pGardening5)
    end
end)

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("gardening_zone_1", vector3(1707.39, 2482.55, 45.55), 5, 5, {
        name="gardening_zone_1",
        heading=45,
        minZ=43.15,
        maxZ=47.15
	})

    exports["fa-polyzone"]:AddBoxZone("gardening_zone_2", vector3(1720.26, 2497.27, 45.55), 5, 5, {
        name="gardening_zone_2",
        heading=30,
        minZ=43.35,
        maxZ=47.35
	})

    exports["fa-polyzone"]:AddBoxZone("gardening_zone_3", vector3(1734.79, 2506.41, 45.55), 5, 5, {
        name="gardening_zone_3",
        heading=345,
        minZ=43.75,
        maxZ=47.75
	})

    exports["fa-polyzone"]:AddBoxZone("gardening_zone_4", vector3(1756.29, 2508.69, 45.55), 8, 5, {
        name="gardening_zone_4",
        heading=345,
        minZ=42.95,
        maxZ=46.95
	})

    exports["fa-polyzone"]:AddBoxZone("gardening_zone_5", vector3(1707.99, 2550.01, 45.55), 10, 10, {
        name="gardening_zone_5",
        heading=10,
        minZ=43.75,
        maxZ=47.75
	})
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "gardening_zone_1" then
        pInZone1 = true
        if pGarden1 then
            CanWater()
            exports['fa-interface']:showInteraction('[E] Begin Watering.')
        end
    elseif name == "gardening_zone_2" then
        pInZone2 = true
        if pGarden2 then
            CanWater()
            exports['fa-interface']:showInteraction('[E] Begin Watering.')
        end
    elseif name == "gardening_zone_3" then
        pInZone3 = true
        if pGarden3 then
            CanWater()
            exports['fa-interface']:showInteraction('[E] Begin Watering.')
        end
    elseif name == "gardening_zone_4" then
        pInZone4 = true
        if pGarden4 then
            CanWater()
            exports['fa-interface']:showInteraction('[E] Begin Watering.')
        end
    elseif name == "gardening_zone_5" then
        pInZone5 = true
        if pGarden5 then
            CanWater()
            exports['fa-interface']:showInteraction('[E] Begin Watering.')
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "gardening_zone_1" then
        pInZone1 = false
        exports['fa-interface']:hideInteraction()
    elseif name == "gardening_zone_2" then
        pInZone2 = false
        exports['fa-interface']:hideInteraction()
    elseif name == "gardening_zone_3" then
        pInZone3 = false
        exports['fa-interface']:hideInteraction()
    elseif name == "gardening_zone_4" then
        pInZone4 = false
        exports['fa-interface']:hideInteraction()
    elseif name == "gardening_zone_5" then
        pInZone5 = false
        exports['fa-interface']:hideInteraction()
    end
end)

function CanWater()
	Citizen.CreateThread(function()
        while pInZone1 or pInZone2 or pInZone3 or pInZone4 or pInZone5 do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if pGarden1 or pGarden2 or pGarden3 or pGarden4 or pGarden5 then
                    pGarden1 = false
                    pGarden2 = false
                    pGarden3 = false
                    pGarden4= false
                    pGarden5 = false
                    RemoveBlip(pGardening1)
                    RemoveBlip(pGardening2)
                    RemoveBlip(pGardening3)
                    RemoveBlip(pGardening4)
                    RemoveBlip(pGardening5)

                    TriggerEvent('fa-jail:startWatering')
                end
            end
		end
	end)
end

--[ End Of Gardening Job ]--

-- Context Menu | Jobs --

RegisterNetEvent('fa-jobs:jail-jobs:menu')
AddEventHandler('fa-jobs:jail-jobs:menu', function()
    local JailJobs = {
        {
            title = "Jail Jobs",
            key = "EVENTS.JAIL",
            children = {
                { title = "Start Electrical Job", action = "fa-jail:electrical", key = "EVENTS.JAIL" },
                { title = "Start Gardening Job", action = "fa-jail:getGardeningJob", key = "EVENTS.JAIL" },
            },
        },
    }
    exports["fa-interface"]:showContextMenu(JailJobs)
end)

RegisterInterfaceCallback('fa-jail:getGardeningJob', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' }})
    TriggerEvent('fa-jail:getGardeningJob')
end)

RegisterInterfaceCallback('fa-jail:electrical', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jail:electrical-get-job')
end)

-- [ Functions / Events] --

function playPourAnimation(pedId)
    loadAnimDict('weapon@w_sp_jerrycan')
    TaskTurnPedToFaceEntity(pedId, "wateringcan2", 0);
    Wait(100)
    TriggerEvent('attachItem', 'wateringcan2');
    TaskPlayAnim(pedId, 'weapon@w_sp_jerrycan', 'fire', 8.0, -8.0, -1, 49, 0, false, false, false);
end

-- { Start Jobs } --

exports["fa-polytarget"]:AddCircleZone("start_jail_jobs",  vector3(1775.71, 2553.75, 45.55), 1.0, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("start_jail_jobs", {{
    event = "fa-jobs:jail-jobs:menu",
    id = "start_jail_jobs",
    icon = "circle",
    label = "Jail Jobs",
    parameters = {},
}}, {
    distance = { radius = 5 },
});