RegisterNetEvent('fa-heists:door_thermite')
AddEventHandler('fa-heists:door_thermite', function()
    TriggerServerEvent('fa-heists:thermite_var')
end)

exports["fa-polytarget"]:AddBoxZone("var_heist1",  vector3(-209.03, -302.76, 74.48), 1, 1, {
    heading=340,
    --debugPoly=false,
    minZ=71.68,
    maxZ=75.68
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_heist1", {{
    event = "fa-heists:door_thermite",
    id = "var_heist1",
    icon = "circle",
    label = "Blow me...", 
    parameters = {},
}}, {
    distance = { radius = 2.5 },
}); 

RegisterNetEvent('fa-heists:var_door_to_lobby')
AddEventHandler('fa-heists:var_door_to_lobby', function()
    local player = GetEntityCoords(PlayerPedId()) 
    local distance = #(vector3(-209.2301, -303.5382, 74.482246) - player)
    if distance < 1.5 then
        if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
            TriggerEvent('fa-hud:show_hackerman')
            LobbyDoor()
            exports['fa-thermite']:OpenThermiteGame(function(success)
                if success then
                    TriggerServerEvent('fa-heists:var_thermite')
                    TriggerEvent('fa-hud:hide_hackerman')
                    TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                    TriggerServerEvent('fa-doors:change-lock-state', 573, false) 
                    Citizen.Wait(3000)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    TriggerEvent('fa-hud:hide_hackerman')
                    TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
                end
            end, 5, 3, 10)
        end
    end
end)

-- Anim --

function LobbyDoor() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 341.47308)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-209.5017, -303.0804, 74.485626, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -209.5017, -303.0804, 74.485626,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("lumo:particleserver", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end

-- Poly Targets --

-- 1

exports["fa-polytarget"]:AddCircleZone("var_computer_1",  vector3(-212.7, -298.21, 74.49), 0.35, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_computer_1", {
    {
        event = "fa-heists:var_event_1",
        id = "var_computer_1",
        icon = "user-secret",
        label = "Access VAR Environment",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-heists:var_event_1')
AddEventHandler('fa-heists:var_event_1', function()
    TriggerServerEvent('fa-heists:in_var_1_srv')
end)

RegisterNetEvent('fa-heists:enter_var_location_1')
AddEventHandler('fa-heists:enter_var_location_1', function()
    if exports['fa-inventory']:hasEnoughOfItem('varhelmet', 1) then
        isPlayerInVar = 1
        DoScreenFadeOut(1)
        SetEntityCoords(PlayerPedId(), 2154.5913, 2921.1772, -81.07546)
        SetEntityHeading(PlayerPedId(), 260.2741)
        DoScreenFadeIn(1000)
        TriggerEvent('phone:addnotification', 'VAR', "You have entered a VAR environment. Please note due to headset calibrations you may only enter once per 4 hours. A terminal can only be used by a single user at a time. You may exit at any time using your F1 console. Contraband will be confiscated upon leaving.")
    end
end)

-- 2

exports["fa-polytarget"]:AddCircleZone("var_computer_2",  vector3(-211.2, -301.14, 74.49), 0.45, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_computer_2", {
    {
        event = "fa-heists:var_event_2",
        id = "var_computer_2",
        icon = "user-secret",
        label = "Access VAR Environment",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-heists:var_event_2')
AddEventHandler('fa-heists:var_event_2', function()
    TriggerServerEvent('fa-heists:in_var_2_srv')
end)

RegisterNetEvent('fa-heists:enter_var_location_2')
AddEventHandler('fa-heists:enter_var_location_2', function()
    if exports['fa-inventory']:hasEnoughOfItem('varhelmet', 1) then
        isPlayerInVar = 1
        DoScreenFadeOut(1)
        SetEntityCoords(PlayerPedId(), 2154.5913, 2921.1772, -81.07546)
        SetEntityHeading(PlayerPedId(), 260.2741)
        DoScreenFadeIn(1000)
        TriggerEvent('phone:addnotification', 'VAR', "You have entered a VAR environment. Please note due to headset calibrations you may only enter once per 4 hours. A terminal can only be used by a single user at a time. You may exit at any time using your F1 console. Contraband will be confiscated upon leaving.")
    end
end)

-- 3

exports["fa-polytarget"]:AddCircleZone("var_computer_3",  vector3(-206.6, -297.19, 74.49), 0.45, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_computer_3", {
    {
        event = "fa-heists:var_event_3",
        id = "var_computer_3",
        icon = "user-secret",
        label = "Access VAR Environment",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-heists:var_event_3')
AddEventHandler('fa-heists:var_event_3', function()
    TriggerServerEvent('fa-heists:in_var_3_srv')
end)

RegisterNetEvent('fa-heists:enter_var_location_3')
AddEventHandler('fa-heists:enter_var_location_3', function()
    if exports['fa-inventory']:hasEnoughOfItem('varhelmet', 1) then
        isPlayerInVar = 1
        DoScreenFadeOut(1)
        SetEntityCoords(PlayerPedId(), 2154.5913, 2921.1772, -81.07546)
        SetEntityHeading(PlayerPedId(), 260.2741)
        DoScreenFadeIn(1000)
        TriggerEvent('phone:addnotification', 'VAR', "You have entered a VAR environment. Please note due to headset calibrations you may only enter once per 4 hours. A terminal can only be used by a single user at a time. You may exit at any time using your F1 console. Contraband will be confiscated upon leaving.")
    end
end)

-- 4

exports["fa-polytarget"]:AddCircleZone("var_computer_4",  vector3(-207.02, -294.14, 74.49), 0.5, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_computer_4", {
    {
        event = "fa-heists:var_event_4",
        id = "var_computer_4",
        icon = "user-secret",
        label = "Access VAR Environment",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-heists:var_event_4')
AddEventHandler('fa-heists:var_event_4', function()
    TriggerServerEvent('fa-heists:in_var_4_srv')
end)

RegisterNetEvent('fa-heists:enter_var_location_4')
AddEventHandler('fa-heists:enter_var_location_4', function()
    if exports['fa-inventory']:hasEnoughOfItem('varhelmet', 1) then
        isPlayerInVar = 1
        DoScreenFadeOut(1)
        SetEntityCoords(PlayerPedId(), 2154.5913, 2921.1772, -81.07546)
        SetEntityHeading(PlayerPedId(), 260.2741)
        DoScreenFadeIn(1000)
        TriggerEvent('phone:addnotification', 'VAR', "You have entered a VAR environment. Please note due to headset calibrations you may only enter once per 4 hours. A terminal can only be used by a single user at a time. You may exit at any time using your F1 console. Contraband will be confiscated upon leaving.")
    end
end)

-- 5

exports["fa-polytarget"]:AddCircleZone("var_computer_5",  vector3(-209.4, -293.28, 74.49), 0.4, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_computer_5", {
    {
        event = "fa-heists:var_event_5",
        id = "var_computer_5",
        icon = "user-secret",
        label = "Access VAR Environment",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-heists:var_event_5')
AddEventHandler('fa-heists:var_event_5', function()
    TriggerServerEvent('fa-heists:in_var_5_srv')
end)

RegisterNetEvent('fa-heists:enter_var_location_5')
AddEventHandler('fa-heists:enter_var_location_5', function()
    if exports['fa-inventory']:hasEnoughOfItem('varhelmet', 1) then
        isPlayerInVar = 1
        DoScreenFadeOut(1)
        SetEntityCoords(PlayerPedId(), 2154.5913, 2921.1772, -81.07546)
        SetEntityHeading(PlayerPedId(), 260.2741)
        DoScreenFadeIn(1000)
        TriggerEvent('phone:addnotification', 'VAR', "You have entered a VAR environment. Please note due to headset calibrations you may only enter once per 4 hours. A terminal can only be used by a single user at a time. You may exit at any time using your F1 console. Contraband will be confiscated upon leaving.")
    end
end)



  --- hack 1/3

  RegisterNetEvent('varhack:1')
AddEventHandler('varhack:1', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "Head to C6 and download the data be careful there might be guards 0/3")
            TriggerEvent('voidrp:varcreateped')
            TriggerServerEvent('fa-heists:hackfalse')
        else
            TriggerEvent('voidrp:varcreatepedfail1')
        end
      end, 8, 5)
end)


RegisterNetEvent('varhack:1unoptimized')
AddEventHandler('varhack:1unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack1')
end)


exports["fa-polytarget"]:AddCircleZone("var_hack1",  vector3(2167.94, 2925.92, -81.38), 0.5, {
    useZ = true
})


exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack1", {
    {
        event = "varhack:1unoptimized",
        id = "var_hack1",
        icon = "user-secret",
        label = "Read Computer Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('varhack:2')
AddEventHandler('varhack:2', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "Head back to the HQ and start the second task 1/3")
            TriggerEvent('voidrp:varcreateped2')
            TriggerServerEvent('fa-heists:hackfalse2')
          print("working?")
        else
            TriggerEvent('voidrp:varcreatepedfail1')
          print("lol")
        end
      end, 8, 5)
end)

RegisterNetEvent('varhack:2unoptimized')
AddEventHandler('varhack:2unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack2')
end)

exports["fa-polytarget"]:AddCircleZone("var_hack2",  vector3(2135.66, 2901.72, -84.27), 0.53, {
    useZ = true
})


exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack2", {
    {
        event = "varhack:2unoptimized",
        id = "var_hack2",
        icon = "user-secret",
        label = "Download Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});



---------------------------------------------- 1/3 done


RegisterNetEvent('varhack:3')
AddEventHandler('varhack:3', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "Head to D19 and download the data 1/3")
            TriggerEvent('voidrp:varcreateped3')
            TriggerServerEvent('fa-heists:hackfalse3')
        else
            TriggerEvent('voidrp:varcreatepedfail2')
        end
      end, 7, 6)
end)

RegisterNetEvent('varhack:3unoptimized')
AddEventHandler('varhack:3unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack3')
end)

exports["fa-polytarget"]:AddCircleZone("var_hack3",  vector3(2171.24, 2927.76, -81.38), 0.41, {
    useZ = true
})


exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack3", {
    {
        event = "varhack:3unoptimized",
        id = "var_hack3",
        icon = "user-secret",
        label = "Read Computer Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});


RegisterNetEvent('varhack:4')
AddEventHandler('varhack:4', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "Head back to HQ and regroup yourself 2/3")
            TriggerEvent('voidrp:varcreateped')
            TriggerServerEvent('fa-heists:hackfalse4')
        else
            TriggerEvent('voidrp:varcreatepedfail2')
        end
      end, 7, 6)
end)

RegisterNetEvent('varhack:4unoptimized')
AddEventHandler('varhack:4unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack4')
end)

exports["fa-polytarget"]:AddCircleZone("var_hack4",  vector3(2087.82, 2946.72, -84.22), 0.53, {
    useZ = true
})


exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack4", {
    {
        event = "varhack:4unoptimized",
        id = "var_hack4",
        icon = "user-secret",
        label = "Download Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

----- 2/3 done


RegisterNetEvent('varhack:5')
AddEventHandler('varhack:5', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "Head to A35 and download the data.")
            TriggerEvent('voidrp:varcreateped2')
            TriggerServerEvent('fa-heists:hackfalse5')
        else
            TriggerEvent('voidrp:varcreatepedfail')
        end
      end, 8, 7)
end)

RegisterNetEvent('varhack:5unoptimized')
AddEventHandler('varhack:5unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack5')
end)

exports["fa-polytarget"]:AddCircleZone("var_hack5",  vector3(2174.89, 2927.76, -81.38), 0.4, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack5", {
    {
        event = "varhack:5unoptimized",
        id = "var_hack5",
        icon = "user-secret",
        label = "Read Computer Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('varhack:6')
AddEventHandler('varhack:6', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "You have recieved 2x usbs upload the data to the cloud and gtfo.")
            TriggerEvent('voidrp:varcreateped3')
            TriggerEvent('player:receiveItem', 'varusb', 2)
            TriggerServerEvent('fa-heists:hackfalse6')
        else
            TriggerEvent('voidrp:varcreatepedfail')
        end
      end, 8, 7)
end)

RegisterNetEvent('varhack:6unoptimized')
AddEventHandler('varhack:6unoptimized', function() -- varhack 1 server sided
TriggerServerEvent('fa-heists:hack6')
end)

exports["fa-polytarget"]:AddCircleZone("var_hack6",  vector3(2327.77, 2945.95, -84.47), 0.55, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack6", {
    {
        event = "varhack:6unoptimized",
        id = "var_hack6",
        icon = "user-secret",
        label = "Download Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('varhack:7')
AddEventHandler('varhack:7', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "You have upload 1/2 files HURRY UP.")
            TriggerEvent('voidrp:varcreateped2')
            TriggerServerEvent('fa-heists:hackfalse7')
            TriggerEvent("inventory:removeItem", "varusb", 1)
          print("working?")
        else
            TriggerEvent('voidrp:varcreatepedfail')
          print("basarisiz")
        end
      end, 15, 10)
end)

RegisterNetEvent('varhack:7unoptimized')
AddEventHandler('varhack:7unoptimized', function() -- varhack 1 server sided
if exports["fa-inventory"]:hasEnoughOfItem("varusb", 1) then
TriggerServerEvent('fa-heists:hack7')
end 
end)

exports["fa-polytarget"]:AddCircleZone("var_hack7",  vector3(2185.9, 2913.24, -84.8), 0.5, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack7", {
    {
        event = "varhack:7unoptimized",
        id = "var_hack7",
        icon = "user-secret",
        label = "Upload Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('varhack:8')
AddEventHandler('varhack:8', function()
    exports['fa-slider']:OpenSliderGame(function(success)
        if success then
            TriggerEvent('phone:addnotification', 'VAR', "You have upload 2/2 files you can leave.")
            TriggerEvent('voidrp:varcreateped')
            TriggerServerEvent('fa-heists:hackfalse8')
            TriggerEvent("inventory:removeItem", "varusb", 1)
            TriggerEvent('player:receiveItem', 'heistusb1', 1)
        else
            TriggerEvent('voidrp:varcreatepedfail')
        end
      end, 15, 10)
end) 

RegisterNetEvent('varhack:8unoptimized')
AddEventHandler('varhack:8unoptimized', function() -- varhack 1 server sided
if exports["fa-inventory"]:hasEnoughOfItem("varusb", 1) then
TriggerServerEvent('fa-heists:hack8')
end 
end)

exports["fa-polytarget"]:AddCircleZone("var_hack8",  vector3(2185.94, 2928.69, -84.8), 0.5, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("var_hack8", {
    {
        event = "varhack:8unoptimized",
        id = "var_hack8",
        icon = "user-secret",
        label = "Upload Data.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});


exports["fa-polytarget"]:AddCircleZone("leave",  vector3(2156.4, 2922.22, -81.08), 0.5, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("leave", {
    {
        event = "varhack:leavesv",
        id = "leave",
        icon = "user-secret",
        label = "Leave.",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('varhack:leavesv')
AddEventHandler('varhack:leavesv', function() -- varhack 1 server sided
TriggerServerEvent('fa-leavevar2')
end)

---- PEDS
RegisterNetEvent('voidrp:varcreateped')
AddEventHandler('voidrp:varcreateped', function()
    local hashKey = `s_m_y_swat_01`

    local pedType = 30

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

    AddRelationshipGroup('lumo')
	ped = CreatePed(pedType, hashKey, 2126.529, 2925.3417, -84.79316, 264.17858, true, false)
    ped2 = CreatePed(pedType, hashKey, 2127.4477, 2916.1013, -84.8001, 272.48999, true, false)
    ped3 = CreatePed(pedType, hashKey, 2127.3618, 2936.7443, -84.80004, 259.94458, true, false) 
    ped4 = CreatePed(pedType, hashKey, 2142.53, 2938.1887, -84.71926, 252.25042, true, false) 
    ped5 = CreatePed(pedType, hashKey, 2138.9545, 2940.7253, -84.80004, 345.72964, true, false) 
    ped6 = CreatePed(pedType, hashKey, 2122.9829, 2934.3134, -84.80004, 4.3237037, true, false) 
    ped7 = CreatePed(pedType, hashKey, 2114.2133, 2936.5822, -84.80004, 358.14538, true, false) 
    ped8 = CreatePed(pedType, hashKey, 2119.9824, 2931.6677, -84.80005, 65.747825, true, false) 
    ped9 = CreatePed(pedType, hashKey, 2123.142, 2913.6821, -84.7936, 354.75503, true, false) 
    ped10 = CreatePed(pedType, hashKey, 2130.1835, 2897.9479, -84.80007, 279.74261, true, false) 

    SetPedArmour(ped, 500)
    SetPedAsEnemy(ped, true)
    SetPedRelationshipGroupHash(ped, 'lumo')
    GiveWeaponToPed(ped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetPedAccuracy(ped, 100)
    SetPedDropsWeaponsWhenDead(ped, false)

    SetPedArmour(ped2, 500)
    SetPedAsEnemy(ped2, true)
    SetPedRelationshipGroupHash(ped2, 'lumo')
    GiveWeaponToPed(ped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped2, GetPlayerPed(-1))
    SetPedAccuracy(ped2, 100)
    SetPedDropsWeaponsWhenDead(ped2, false)

    SetPedArmour(ped3, 500)
    SetPedAsEnemy(ped3, true)
    SetPedRelationshipGroupHash(ped3, 'lumo')
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped3, GetPlayerPed(-1))
    SetPedAccuracy(ped3, 100)
    SetPedDropsWeaponsWhenDead(ped3, false)
    
    SetPedArmour(ped4, 500)
    SetPedAsEnemy(ped4, true)
    SetPedRelationshipGroupHash(ped4, 'lumo')
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped4, GetPlayerPed(-1))
    SetPedAccuracy(ped4, 100)
    SetPedDropsWeaponsWhenDead(ped4, false)

    SetPedArmour(ped5, 500)
    SetPedAsEnemy(ped5, true)
    SetPedRelationshipGroupHash(ped5, 'lumo')
    GiveWeaponToPed(ped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped5, GetPlayerPed(-1))
    SetPedAccuracy(ped5, 100)
    SetPedDropsWeaponsWhenDead(ped5, false)

    SetPedArmour(ped6, 500)
    SetPedAsEnemy(ped6, true)
    SetPedRelationshipGroupHash(ped6, 'lumo')
    GiveWeaponToPed(ped6, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped6, GetPlayerPed(-1))
    SetPedAccuracy(ped6, 100)
    SetPedDropsWeaponsWhenDead(ped6, false)

    SetPedArmour(ped7, 500)
    SetPedAsEnemy(ped7, true)
    SetPedRelationshipGroupHash(ped7, 'lumo')
    GiveWeaponToPed(ped7, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped7, GetPlayerPed(-1))
    SetPedAccuracy(ped7, 100)
    SetPedDropsWeaponsWhenDead(ped7, false)

    SetPedArmour(ped8, 500)
    SetPedAsEnemy(ped8, true)
    SetPedRelationshipGroupHash(ped8, 'lumo')
    GiveWeaponToPed(ped8, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped8, GetPlayerPed(-1))
    SetPedAccuracy(ped8, 100)
    SetPedDropsWeaponsWhenDead(ped8, false)

    SetPedArmour(ped9, 500)
    SetPedAsEnemy(ped9, true)
    SetPedRelationshipGroupHash(ped9, 'lumo')
    GiveWeaponToPed(ped9, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped9, GetPlayerPed(-1))
    SetPedAccuracy(ped9, 100)
    SetPedDropsWeaponsWhenDead(ped9, false)

    SetPedArmour(ped10, 500)
    SetPedAsEnemy(ped10, true)
    SetPedRelationshipGroupHash(ped10, 'lumo')
    GiveWeaponToPed(ped10, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped10, GetPlayerPed(-1))
    SetPedAccuracy(ped10, 100)
    SetPedDropsWeaponsWhenDead(ped10, false)
end)

RegisterNetEvent('voidrp:varcreateped2')
AddEventHandler('voidrp:varcreateped2', function()
    local hashKey = `s_m_y_swat_01`

    local pedType = 30

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

    AddRelationshipGroup('lumo')
	ped = CreatePed(pedType, hashKey, 2209.0737, 2920.9702, -84.80446, 83.676605, true, false)
    ped2 = CreatePed(pedType, hashKey, 2208.0246, 2932.8737, -84.80005, 110.59226, true, false)
    ped3 = CreatePed(pedType, hashKey, 2207.2143, 2940.4287, -84.80004, 98.731613, true, false) 
    ped4 = CreatePed(pedType, hashKey, 2210.6013, 2943.5136, -84.80006, 17.459566, true, false) 
    ped5 = CreatePed(pedType, hashKey, 2202.978, 2944.1787, -84.80002, 101.83623, true, false) 
    ped6 = CreatePed(pedType, hashKey, 2218.4355, 2936.2143, -84.80006, 7.571773, true, false) 
    ped7 = CreatePed(pedType, hashKey, 2222.6757, 2927.2377, -84.80004, 132.28443, true, false) 
    ped8 = CreatePed(pedType, hashKey, 2221.4265, 2913.7766, -84.80004, 60.553932, true, false) 
    ped9 = CreatePed(pedType, hashKey, 2233.1459, 2913.6591, -84.80005, 186.66192, true, false) 
    ped10 = CreatePed(pedType, hashKey, 2232.2475, 2904.1799, -84.80004, 295.95202, true, false) 

    SetPedArmour(ped, 500)
    SetPedAsEnemy(ped, true)
    SetPedRelationshipGroupHash(ped, 'lumo')
    GiveWeaponToPed(ped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetPedAccuracy(ped, 100)
    SetPedDropsWeaponsWhenDead(ped, false)

    SetPedArmour(ped2, 500)
    SetPedAsEnemy(ped2, true)
    SetPedRelationshipGroupHash(ped2, 'lumo')
    GiveWeaponToPed(ped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped2, GetPlayerPed(-1))
    SetPedAccuracy(ped2, 100)
    SetPedDropsWeaponsWhenDead(ped2, false)

    SetPedArmour(ped3, 500)
    SetPedAsEnemy(ped3, true)
    SetPedRelationshipGroupHash(ped3, 'lumo')
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped3, GetPlayerPed(-1))
    SetPedAccuracy(ped3, 100)
    SetPedDropsWeaponsWhenDead(ped3, false)
    
    SetPedArmour(ped4, 500)
    SetPedAsEnemy(ped4, true)
    SetPedRelationshipGroupHash(ped4, 'lumo')
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped4, GetPlayerPed(-1))
    SetPedAccuracy(ped4, 100)
    SetPedDropsWeaponsWhenDead(ped4, false)

    SetPedArmour(ped5, 500)
    SetPedAsEnemy(ped5, true)
    SetPedRelationshipGroupHash(ped5, 'lumo')
    GiveWeaponToPed(ped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped5, GetPlayerPed(-1))
    SetPedAccuracy(ped5, 100)
    SetPedDropsWeaponsWhenDead(ped5, false)

    SetPedArmour(ped6, 500)
    SetPedAsEnemy(ped6, true)
    SetPedRelationshipGroupHash(ped6, 'lumo')
    GiveWeaponToPed(ped6, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped6, GetPlayerPed(-1))
    SetPedAccuracy(ped6, 100)
    SetPedDropsWeaponsWhenDead(ped6, false)

    SetPedArmour(ped7, 500)
    SetPedAsEnemy(ped7, true)
    SetPedRelationshipGroupHash(ped7, 'lumo')
    GiveWeaponToPed(ped7, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped7, GetPlayerPed(-1))
    SetPedAccuracy(ped7, 100)
    SetPedDropsWeaponsWhenDead(ped7, false)

    SetPedArmour(ped8, 500)
    SetPedAsEnemy(ped8, true)
    SetPedRelationshipGroupHash(ped8, 'lumo')
    GiveWeaponToPed(ped8, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped8, GetPlayerPed(-1))
    SetPedAccuracy(ped8, 100)
    SetPedDropsWeaponsWhenDead(ped8, false)

    SetPedArmour(ped9, 500)
    SetPedAsEnemy(ped9, true)
    SetPedRelationshipGroupHash(ped9, 'lumo')
    GiveWeaponToPed(ped9, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped9, GetPlayerPed(-1))
    SetPedAccuracy(ped9, 100)
    SetPedDropsWeaponsWhenDead(ped9, false)

    SetPedArmour(ped10, 500)
    SetPedAsEnemy(ped10, true)
    SetPedRelationshipGroupHash(ped10, 'lumo')
    GiveWeaponToPed(ped10, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped10, GetPlayerPed(-1))
    SetPedAccuracy(ped10, 100)
    SetPedDropsWeaponsWhenDead(ped10, false)
end)

RegisterNetEvent('voidrp:varcreateped3')
AddEventHandler('voidrp:varcreateped3', function()
    local hashKey = `s_m_y_swat_01`

    local pedType = 30

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

    AddRelationshipGroup('lumo')
	ped = CreatePed(pedType, hashKey, 2072.3735, 2949.8503, -84.80004, 261.04425, true, false)
    ped2 = CreatePed(pedType, hashKey, 2060.3461, 2948.3764, -84.80003, 88.245498, true, false)
    ped3 = CreatePed(pedType, hashKey, 2058.8872, 2938.4799, -84.80003, 93.161857, true, false) 
    ped4 = CreatePed(pedType, hashKey, 2059.0378, 2930.3767, -84.80003, 237.31123, true, false) 
    ped5 = CreatePed(pedType, hashKey, 2058.7241, 2926.9736, -84.80003, 268.31427, true, false) 
    ped6 = CreatePed(pedType, hashKey, 2060.4357, 2922.8002, -84.80003, 115.56433, true, false) 
    ped7 = CreatePed(pedType, hashKey, 2060.4082, 2918.7006, -84.80005, 125.66196, true, false) 
    ped8 = CreatePed(pedType, hashKey, 2063.9282, 2907.8481, -84.79992, 263.05737, true, false) 
    ped9 = CreatePed(pedType, hashKey, 2060.2573, 2902.5522, -84.80005, 44.762359, true, false) 
    ped10 = CreatePed(pedType, hashKey, 2060.1354, 2894.3129, -84.80005, 114.34681, true, false) 

    SetPedArmour(ped, 500)
    SetPedAsEnemy(ped, true)
    SetPedRelationshipGroupHash(ped, 'lumo')
    GiveWeaponToPed(ped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetPedAccuracy(ped, 100)
    SetPedDropsWeaponsWhenDead(ped, false)

    SetPedArmour(ped2, 500)
    SetPedAsEnemy(ped2, true)
    SetPedRelationshipGroupHash(ped2, 'lumo')
    GiveWeaponToPed(ped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped2, GetPlayerPed(-1))
    SetPedAccuracy(ped2, 100)
    SetPedDropsWeaponsWhenDead(ped2, false)

    SetPedArmour(ped3, 500)
    SetPedAsEnemy(ped3, true)
    SetPedRelationshipGroupHash(ped3, 'lumo')
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped3, GetPlayerPed(-1))
    SetPedAccuracy(ped3, 100)
    SetPedDropsWeaponsWhenDead(ped3, false)
    
    SetPedArmour(ped4, 500)
    SetPedAsEnemy(ped4, true)
    SetPedRelationshipGroupHash(ped4, 'lumo')
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped4, GetPlayerPed(-1))
    SetPedAccuracy(ped4, 100)
    SetPedDropsWeaponsWhenDead(ped4, false)

    SetPedArmour(ped5, 500)
    SetPedAsEnemy(ped5, true)
    SetPedRelationshipGroupHash(ped5, 'lumo')
    GiveWeaponToPed(ped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped5, GetPlayerPed(-1))
    SetPedAccuracy(ped5, 100)
    SetPedDropsWeaponsWhenDead(ped5, false)

    SetPedArmour(ped6, 500)
    SetPedAsEnemy(ped6, true)
    SetPedRelationshipGroupHash(ped6, 'lumo')
    GiveWeaponToPed(ped6, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped6, GetPlayerPed(-1))
    SetPedAccuracy(ped6, 100)
    SetPedDropsWeaponsWhenDead(ped6, false)

    SetPedArmour(ped7, 500)
    SetPedAsEnemy(ped7, true)
    SetPedRelationshipGroupHash(ped7, 'lumo')
    GiveWeaponToPed(ped7, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped7, GetPlayerPed(-1))
    SetPedAccuracy(ped7, 100)
    SetPedDropsWeaponsWhenDead(ped7, false)

    SetPedArmour(ped8, 500)
    SetPedAsEnemy(ped8, true)
    SetPedRelationshipGroupHash(ped8, 'lumo')
    GiveWeaponToPed(ped8, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped8, GetPlayerPed(-1))
    SetPedAccuracy(ped8, 100)
    SetPedDropsWeaponsWhenDead(ped8, false)

    SetPedArmour(ped9, 500)
    SetPedAsEnemy(ped9, true)
    SetPedRelationshipGroupHash(ped9, 'lumo')
    GiveWeaponToPed(ped9, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped9, GetPlayerPed(-1))
    SetPedAccuracy(ped9, 100)
    SetPedDropsWeaponsWhenDead(ped9, false)

    SetPedArmour(ped10, 500)
    SetPedAsEnemy(ped10, true)
    SetPedRelationshipGroupHash(ped10, 'lumo')
    GiveWeaponToPed(ped10, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped10, GetPlayerPed(-1))
    SetPedAccuracy(ped10, 100)
    SetPedDropsWeaponsWhenDead(ped10, false)
end)

RegisterNetEvent('voidrp:varcreatepedfail1')
AddEventHandler('voidrp:varcreatepedfail1', function()
    local hashKey = `s_m_y_swat_01`

    local pedType = 30

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

    AddRelationshipGroup('lumo')
	ped = CreatePed(pedType, hashKey, 2357.446, 2898.3159, -84.80004, 88.009696, true, false)
    ped2 = CreatePed(pedType, hashKey, 2357.852, 2906.7216, -84.80004, 90.864303, true, false)
    ped3 = CreatePed(pedType, hashKey, 2357.9694, 2913.2209, -84.80004, 89.421592, true, false) 
    ped4 = CreatePed(pedType, hashKey, 2357.7202, 2921.6198, -84.80005, 110.81566, true, false) 
    ped5 = CreatePed(pedType, hashKey, 2357.1835, 2933.5656, -84.79318, 87.276351, true, false) 


    SetPedArmour(ped, 500)
    SetPedAsEnemy(ped, true)
    SetPedRelationshipGroupHash(ped, 'lumo')
    GiveWeaponToPed(ped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetPedAccuracy(ped, 100)
    SetPedDropsWeaponsWhenDead(ped, false)

    SetPedArmour(ped2, 500)
    SetPedAsEnemy(ped2, true)
    SetPedRelationshipGroupHash(ped2, 'lumo')
    GiveWeaponToPed(ped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped2, GetPlayerPed(-1))
    SetPedAccuracy(ped2, 100)
    SetPedDropsWeaponsWhenDead(ped2, false)

    SetPedArmour(ped3, 500)
    SetPedAsEnemy(ped3, true)
    SetPedRelationshipGroupHash(ped3, 'lumo')
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped3, GetPlayerPed(-1))
    SetPedAccuracy(ped3, 100)
    SetPedDropsWeaponsWhenDead(ped3, false)
    
    SetPedArmour(ped4, 500)
    SetPedAsEnemy(ped4, true)
    SetPedRelationshipGroupHash(ped4, 'lumo')
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped4, GetPlayerPed(-1))
    SetPedAccuracy(ped4, 100)
    SetPedDropsWeaponsWhenDead(ped4, false)

    SetPedArmour(ped5, 500)
    SetPedAsEnemy(ped5, true)
    SetPedRelationshipGroupHash(ped5, 'lumo')
    GiveWeaponToPed(ped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped5, GetPlayerPed(-1))
    SetPedAccuracy(ped5, 100)
    SetPedDropsWeaponsWhenDead(ped5, false)
end)

RegisterNetEvent('voidrp:varcreatepedfail2')
AddEventHandler('voidrp:varcreatepedfail2', function()
    local hashKey = `s_m_y_swat_01`

    local pedType = 30

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

    AddRelationshipGroup('lumo')
	ped = CreatePed(pedType, hashKey, 1978.2264, 2925.2519, -84.79316, 268.59841, true, false)
    ped2 = CreatePed(pedType, hashKey, 1978.9382, 2933.8503, -84.79317, 276.24609, true, false)
    ped3 = CreatePed(pedType, hashKey, 1978.6809, 2942.0769, -84.79316, 269.94497, true, false) 
    ped4 = CreatePed(pedType, hashKey, 1978.7315, 2916.7595, -84.79317, 263.57073, true, false) 
    ped5 = CreatePed(pedType, hashKey, 1978.7618, 2908.0483, -84.79316, 265.20895, true, false) 


    SetPedArmour(ped, 500)
    SetPedAsEnemy(ped, true)
    SetPedRelationshipGroupHash(ped, 'lumo')
    GiveWeaponToPed(ped, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped, GetPlayerPed(-1))
    SetPedAccuracy(ped, 100)
    SetPedDropsWeaponsWhenDead(ped, false)

    SetPedArmour(ped2, 500)
    SetPedAsEnemy(ped2, true)
    SetPedRelationshipGroupHash(ped2, 'lumo')
    GiveWeaponToPed(ped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped2, GetPlayerPed(-1))
    SetPedAccuracy(ped2, 100)
    SetPedDropsWeaponsWhenDead(ped2, false)

    SetPedArmour(ped3, 500)
    SetPedAsEnemy(ped3, true)
    SetPedRelationshipGroupHash(ped3, 'lumo')
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped3, GetPlayerPed(-1))
    SetPedAccuracy(ped3, 100)
    SetPedDropsWeaponsWhenDead(ped3, false)
    
    SetPedArmour(ped4, 500)
    SetPedAsEnemy(ped4, true)
    SetPedRelationshipGroupHash(ped4, 'lumo')
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped4, GetPlayerPed(-1))
    SetPedAccuracy(ped4, 100)
    SetPedDropsWeaponsWhenDead(ped4, false)

    SetPedArmour(ped5, 500)
    SetPedAsEnemy(ped5, true)
    SetPedRelationshipGroupHash(ped5, 'lumo')
    GiveWeaponToPed(ped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(ped5, GetPlayerPed(-1))
    SetPedAccuracy(ped5, 100)
    SetPedDropsWeaponsWhenDead(ped5, false)
end)

RegisterNetEvent('exit:varcompleteheist')
AddEventHandler('exit:varcompleteheist', function()
  isPlayerInVar = 0
  DoScreenFadeOut(1000)
  Citizen.Wait(100)
  SetEntityCoords(PlayerPedId(),-208.6262, -298.5388, 74.486129)    
  DoScreenFadeIn(1000)
  removevarmedkits()
  removevpistolammo()
  removevsubammo()
  removevrifleammo()
  TriggerEvent('phone:addnotification', 'VAR', "You left VAR Environment.")
  TriggerEvent('faye:admin:ReviveInDistance')
  Citizen.Wait(1000)
end)

-- Leave Via F1 --

function GetVarStatus()
    if isPlayerInVar == 1 then
        POGVAR = true
    elseif isPlayerInVar == 0 then
        POGVAR = false
    end
    return POGVAR
end

-- Loot Peds -- 

RegisterNetEvent('fa-heists:loot_peds')
AddEventHandler('fa-heists:loot_peds', function()
    local EvanNNicxVar = math.random(5)

    if EvanNNicxVar == 1 then
        TriggerEvent('player:receiveItem', 'varmedkit', math.random(1, 5))
        TriggerEvent('player:receiveItem', 'pistolammo', 1)
        TriggerEvent('player:receiveItem', 'bandage', 4)
    elseif EvanNNicxVar == 2 then
        TriggerEvent('player:receiveItem', 'pistolammo', 1)
        TriggerEvent('player:receiveItem', 'varmedkit', 3)
        TriggerEvent('player:receiveItem', 'rifleammo', 1)
    elseif EvanNNicxVar == 3 then
        TriggerEvent('player:receiveItem', 'bandage', math.random(1, 10))
        TriggerEvent('player:receiveItem', 'pistolammo', 3)
    elseif EvanNNicxVar == 4 then 
        TriggerEvent('player:receiveItem', 'subammo', 1)
        TriggerEvent('player:receiveItem', 'pistolammo', 1)
        TriggerEvent('player:receiveItem', 'varmedkit', 2)
    elseif EvanNNicxVar == 5 then
        TriggerEvent('player:receiveItem', 'rifleammo', 1)
        TriggerEvent('player:receiveItem', 'varmedkit', 1)
    end
end)

RegisterNetEvent('fa-heists:var_loot_ped')
AddEventHandler('fa-heists:var_loot_ped', function()
    if isPlayerInVar == 1 then
        TriggerEvent('fa-heists:loot_peds')
        TriggerServerEvent('fa-var:lootcooldown')
    else
        print('cooldown')
    end
end) 

RegisterNetEvent('fa-heists:svclientloot')
AddEventHandler('fa-heists:svclientloot', function()
    TriggerServerEvent('fa-evannicxvar:varlootcooldown')
end)
 
function removevarmedkits()
    local qty = exports["fa-inventory"]:getQuantity("varmedkit")
    if qty and qty > 0 then
      TriggerEvent("inventory:removeItem", "varmedkit", qty)
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end 
end

function removevpistolammo()
    local qty = exports["fa-inventory"]:getQuantity("pistolammo")
    if qty and qty > 0 then
      TriggerEvent("inventory:removeItem", "pistolammo", qty)
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end

function removevsubammo()
    local qty = exports["fa-inventory"]:getQuantity("subammo")
    if qty and qty > 0 then
      TriggerEvent("inventory:removeItem", "subammo", qty)
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end

function removevrifleammo()
    local qty = exports["fa-inventory"]:getQuantity("rifleammo")
    if qty and qty > 0 then
      TriggerEvent("inventory:removeItem", "rifleammo", qty)
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end

function KneelMedic()
	local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( "amb@medic@standing@tendtodead@enter" )
		loadAnimDict( "amb@medic@standing@timeofdeath@enter" )
		loadAnimDict( "amb@medic@standing@tendtodead@idle_a" )
		loadAnimDict( "random@crash_rescue@help_victim_up" )
		TaskPlayAnim( player, "amb@medic@standing@tendtodead@enter", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
		Wait (1000)
		TaskPlayAnim( player, "amb@medic@standing@tendtodead@idle_a", "idle_b", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
		Wait (3000)
		TaskPlayAnim( player, "amb@medic@standing@tendtodead@exit", "exit_flee", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
		Wait (1000)
		TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "enter", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
		Wait (500)
		TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "helping_victim_to_feet_player", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
	end
end

AddEventHandler("np-heists:serverroom:revivePlayer", function(pEntity)
    local ped = PlayerPedId()
    KneelMedic()
    local finished = exports["fa-taskbar"]:taskBar(7500,"Helping Person Up...")
    if finished == 100 then
        TriggerEvent("revive_var", pEntity)
        TriggerEvent("inventory:removeItem", "varmedkit", 1)
        ClearPedTasks(ped)
    else
        ClearPedTasks(ped)
    end

end)

RegisterNetEvent('revive_var') 
AddEventHandler('revive_var', function(pEntity)
    local target = pEntity
    TriggerClientEvent('admin:revivePlayerClient', target)
    TriggerClientEvent('fa-hospital:client:RemoveBleed', target) 
    TriggerClientEvent('fa-hospital:client:ResetLimbs', target)
end) 

  -- bozo