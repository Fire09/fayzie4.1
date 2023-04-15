local hackAnimDict = "anim@heists@ornate_bank@hack"

local function loadDicts()
    RequestAnimDict(hackAnimDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(hackAnimDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(0)
    end
end

AddEventHandler("fa-inventory:itemUsed", function(pItem)
    if pItem == "thermitecharge" then
        TriggerEvent('fa-vault:firstdoor')
        TriggerEvent('fa-vault:seconddoor')
        TriggerEvent('fa-vault:lowerfirstdoor')
        TriggerEvent('fa-vault:lowerseconddoor')
    elseif pItem == "heistlaptop4" then
        TriggerEvent('fa-vault:startlowervault')
        TriggerEvent('fa-vault:startvault')
    end
end)

RegisterNetEvent('fa-vault:firstdoor')
AddEventHandler('fa-vault:firstdoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(256.84341, 220.15713, 106.28618) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
                TriggerServerEvent('fa-heists:vaultRobberyLog')
                exports["fa-dispatch"]:dispatchadd('10-90', "Pacific Bank Robbery", "429")
                TriggerEvent("client:newStress",true, 150)
                frontdoorvault()
                TriggerEvent('fa-dispatch:bankrobbery')
                exports['fa-thermite']:OpenThermiteGame(function(success)
                    if success then
                        TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                        TriggerServerEvent('fa-doors:change-lock-state', 46, false) 
                        Citizen.Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
                    end
                end, 5, 3, 10)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not enough cops on duty', 2)
    end
end)

RegisterNetEvent('fa-vault:seconddoor')
AddEventHandler('fa-vault:seconddoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(261.68984, 222.0194, 106.28388) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
                exports["fa-dispatch"]:dispatchadd('10-90', "Pacific Bank Robbery", "429")
                TriggerEvent("client:newStress",true, 150)
                seconddoorvault()
                TriggerEvent('fa-dispatch:bankrobbery')
                exports['fa-thermite']:OpenThermiteGame(function(success)
                    if success then
                        TriggerEvent('phone:addJobNotify', "Good Shit head down stairs and hack the vault")
                        TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                        TriggerServerEvent('fa-doors:change-lock-state', 48, false) 
                        Citizen.Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
                    end
                end, 5, 3, 10)
            else
                TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
    end
end)


RegisterNetEvent('fa-vault:startvault')
AddEventHandler('fa-vault:startvault', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(253.25254, 228.45343, 101.68377) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("heistlaptop4", 1) then
                exports["fa-dispatch"]:dispatchadd('10-90', "Pacific Bank Robbery", "429")
                StartVaultKid()
                TriggerEvent('fa-dispatch:bankrobbery')
                TriggerEvent("client:newStress",true, 150)
                exports['fa-hacking']:hacking(
                function()
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('fa-heists:vault_door')
                    DeleteObject(bag)
                    DeleteObject(laptop)
                    FreezeEntityPosition(ped, false)
                end,
                function()
                    ClearPedTasksImmediately(PlayerPedId())
                end)
                TriggerEvent("inventory:removeItem", "heistlaptop4", 1)
                Citizen.Wait(1000)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
    end
end)


RegisterNetEvent('fa-heists:vault_door')
AddEventHandler('fa-heists:vault_door', function()
    TriggerEvent('vault:success:panel', closestBank, true)
    CreatenBrakeCrates()
end)

RegisterNetEvent('fa-vault:lowerfirstdoor')
AddEventHandler('fa-vault:lowerfirstdoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(252.56506, 221.22116, 101.68394) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
                exports["fa-dispatch"]:dispatchadd('10-90', "Pacific Bank Robbery", "429")
                TriggerEvent("client:newStress",true, 150)
                thirddoorvault()
                exports['fa-thermite']:OpenThermiteGame(function(success)
                    if success then
                        TriggerEvent('phone:addJobNotify', "Great Job Get through those doors and grab the money")
                        TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                        TriggerServerEvent('fa-doors:change-lock-state', 49, false) 
                        Citizen.Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
                    end
                end, 5, 3, 10)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
    end
end)

RegisterNetEvent('fa-vault:lowerseconddoor')
AddEventHandler('fa-vault:lowerseconddoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(261.23635, 215.26144, 101.68384) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
                exports["fa-dispatch"]:dispatchadd('10-90', "Pacific Bank Robbery", "429")
                TriggerEvent("client:newStress",true, 150)
                fourthdoorvault()
                exports['fa-thermite']:OpenThermiteGame(function(success)
                    if success then
                        TriggerEvent('phone:addJobNotify', "Grab the cash and thermite the door")
                        TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                        TriggerServerEvent('fa-doors:change-lock-state', 50, false) 
                        Citizen.Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
                    end
                end, 5, 3, 10)
            else
                TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not Enough Cops on Duty', 2)
    end
end)


                
---- animations lol


function frontdoorvault() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 333.24514)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(256.84, 220.21, 106.29, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 256.84, 220.21, 106.29,  true,  true, false)

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
    ClearPedTasksImmediately(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end

function seconddoorvault() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 248.24514)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(261.73904, 221.86761, 106.28404, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 261.73904, 221.86761, 106.28404,  true,  true, false)

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
    ClearPedTasksImmediately(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end


function thirddoorvault() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 160.62071)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(252.79815, 221.04006, 101.68394, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 252.79815, 221.04006, 101.68394,  true,  true, false)

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
    ClearPedTasksImmediately(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end


function fourthdoorvault() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 249.56549)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(261.23635, 215.26144, 101.68384, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 261.23635, 215.26144, 101.68384,  true,  true, false)

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
    ClearPedTasksImmediately(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end


function StartVaultKid()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, 253.60346984863, 228.20530700684, 101.68351745605-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 71.801795959473)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", 253.60346984863, 228.20530700684, 101.68351745605 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 71.801795959473)
    while IsEntityPlayingAnim(ply, "anim@heists@ornate_bank@hack", "hack_enter", 3) do
        Wait(0)
    end
    laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)

end

function StartLowerVaultKid()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, 271.96, 230.85, 97.68 -0.9, 2.0, -1, 0.0)  
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 341.11935)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", 271.96, 230.85, 97.68 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 341.11935)
    while IsEntityPlayingAnim(ply, "anim@heists@ornate_bank@hack", "hack_enter", 3) do
        Wait(0)
    end
    laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)

end


---------------------------------------------------------------- vault open i think


 -- VAULT DOOR SHIT NOBODY REALLY CARES
 RegisterNetEvent("utk_oh:openvault_c")
 AddEventHandler("utk_oh:openvault_c", function(method)
     TriggerEvent("utk_oh:vault", method)
     TriggerEvent("utk_oh:vaultsound")
 end)
 RegisterNetEvent("utk_oh:vault")
 AddEventHandler("utk_oh:vault", function(method)
     local obj = GetClosestObjectOfType(UTK.vault.x, UTK.vault.y, UTK.vault.z, 2.0, GetHashKey(UTK.vault.type), false, false, false)
     local count = 0
 
     if method == 1 then
         repeat
             local rotation = GetEntityHeading(obj) - 1.00
 
             SetEntityHeading(obj, 1.00)
             count = count + 1
             Citizen.Wait(10)
         until count == 3600000
     else
         repeat
             local rotation = GetEntityHeading(obj) + 1.00
 
             SetEntityHeading(obj, 1.00)
             count = count + 1
             Citizen.Wait(10)
         until count == 3600000
     end
     FreezeEntityPosition(obj, true)
 end)

 UTK = {
    doorchecks = {
        {x = 253.92, y = 224.56, z = 101.88, he = 160.000, h = GetHashKey("v_ilev_bk_vaultdoor"), status = 0,}
    },
    disableinput = false, -- don't change anything else unless you know what you are doing
    info = {},
    vault = {x = 253.92, y = 224.56, z = 101.88, type = "v_ilev_bk_vaultdoor"},
    cur = 7,
}

RegisterNetEvent("vault:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerServerEvent("utk_oh:openvault", 1)
    DeleteObject(laptop)
end)

--- money trays


RegisterNetEvent('aspect:createCrates')
AddEventHandler('aspect:createCrates', function(toggle)
    if toggle == true then
     weaponbox = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 259.64764404297, 214.68962097168, 100.68382263184, true,  true, true)
    CreateObject(weaponbox)
    SetEntityHeading(weaponbox, 186.12)
    FreezeEntityPosition(weaponbox, true)

     weaponbox3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 262.24865722656, 213.46434020996, 100.68383026123, true,  true, true)
    CreateObject(weaponbox3)
    SetEntityHeading(weaponbox3, 219.52)
    FreezeEntityPosition(weaponbox3, true) 

     weaponbox4 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 263.57299804688, 215.60986328125, 100.68383026123, true,  true, true)  -- 259.64764404297, 214.68962097168, 101.68382263184 Heading: 186.15272521973
    CreateObject(weaponbox4)
    SetEntityHeading(weaponbox4, 291.02)
    FreezeEntityPosition(weaponbox4, true)


    elseif toggle == false then
        DeleteObject(weaponbox)
        DeleteObject(weaponbox4)
        DeleteObject(weaponbox3)
    end
end)

function CreatenBrakeCrates()
    local ped = PlayerPedId()

    TriggerEvent('aspect:CleanClientVaultD')
    TriggerEvent("aspect:createCrates" ,true)

    ClearPedTasksImmediately(PlayerPedId())
  end

  function Loot()
    Grab2clear = false
    Grab3clear = false
    Trolley = nil
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
    Trolley = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, `hei_prop_hei_cash_trolly_01`, false, false, false)
    local CashAppear = function()
        local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)
        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(0)
        end
        local grabobj = CreateObject(grabmodel, pedCoords, true)
        FreezeEntityPosition(grabobj, true)
        SetEntityInvincible(grabobj, true)
        SetEntityNoCollisionEntity(grabobj, ped)
        SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local startedGrabbing = GetGameTimer()
        Citizen.CreateThread(function()
            while GetGameTimer() - startedGrabbing < 37000 do
                Citizen.Wait(0)
                DisableControlAction(0, 73, true)
                if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
                    if not IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, true, false)
                    end
                end
                if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                    end
                end
            end
            DeleteObject(grabobj)
        end)
    end
    local emptyobj = `ch_prop_gold_trolly_01c_empty`
    if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")
    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(0)
    end
    while not NetworkHasControlOfEntity(Trolley) do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(Trolley)
    end
    GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(Grab1)
    Citizen.Wait(1500)
    CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(0)
            DeleteEntity(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
        SetEntityAsMissionEntity(NewTrolley, 1, 1)
        Citizen.SetTimeout(5000, function()
            DeleteObject(NewTrolley)
            while DoesEntityExist(NewTrolley) do
              Citizen.Wait(0)
              DeleteEntity(NewTrolley)
            end
        end)
    end
    Citizen.Wait(1800)
    if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    TriggerServerEvent("zyloz-pacificbank:giveMoney")
    TriggerServerEvent("zyloz-pacificbank:startCoolDown")
end

function LootGold()
    Grab2clear = false
    Grab3clear = false
    Trolley = nil
    local ped = PlayerPedId()
    local model = "prop_gold_bar"
    Trolley = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, `ch_prop_gold_trolly_01c`, false, false, false)
    local CashAppear = function()
        local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)
        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(0)
        end
        local grabobj = CreateObject(grabmodel, pedCoords, true)
        FreezeEntityPosition(grabobj, true)
        SetEntityInvincible(grabobj, true)
        SetEntityNoCollisionEntity(grabobj, ped)
        SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local startedGrabbing = GetGameTimer()
        Citizen.CreateThread(function()
            while GetGameTimer() - startedGrabbing < 37000 do
                Citizen.Wait(0)
                DisableControlAction(0, 73, true)
                if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
                    if not IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, true, false)
                    end
                end
                if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                    end
                end
            end
            DeleteObject(grabobj)
        end)
    end
    local emptyobj = `ch_prop_gold_trolly_01c_empty`
    if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")
    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(0)
    end
    while not NetworkHasControlOfEntity(Trolley) do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(Trolley)
    end
    GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(Grab1)
    Citizen.Wait(1500)
    CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(0)
            DeleteEntity(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
        SetEntityAsMissionEntity(NewTrolley, 1, 1)
        Citizen.SetTimeout(5000, function()
            DeleteObject(NewTrolley)
            while DoesEntityExist(NewTrolley) do
              Citizen.Wait(0)
              DeleteEntity(NewTrolley)
            end
        end)
    end
    Citizen.Wait(1800)
    if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    TriggerServerEvent("zyloz-pacificbank:giveMoney")
    TriggerServerEvent("zyloz-pacificbank:startCoolDown")
end

RegisterNetEvent("fa-vault:grab", function()
    local chance = math.random(120)
    LootGold()
    if chance < 25 then
		TriggerEvent("player:receiveItem",'goldbar', 3)
	end
    TriggerEvent("player:receiveItem", "goldbar",math.random(4,15))
end)

-- Interact --

exports["fa-polytarget"]:AddCircleZone("faye_vault_lower_interact_1",  vector3(289.29, 227.55, 98.24), 0.25, {
    useZ = true
})

exports["fa-polytarget"]:AddCircleZone("faye_vault_lower_interact_2",  vector3(286.92, 227.39, 98.29), 0.2, {
    useZ = true
})

exports["fa-polytarget"]:AddCircleZone("faye_vault_lower_interact_3", vector3(284.69, 221.64, 98.24), 0.2, {
    useZ = true
})

exports["fa-polytarget"]:AddCircleZone("faye_vault_lower_interact_4", vector3(286.52, 220.06, 98.29), 0.25, {
    useZ = true
})


exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_vault_lower_interact_1", {{
    event = "fa-vaultrob:lower:firstpindoor",
    id = "faye_vault_lower_interact_1",
    icon = "circle",
    label = "Code?",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_vault_lower_interact_2", {{
    event = "fa-vaultrob:lower:secpindoor",
    id = "faye_vault_lower_interact_2",
    icon = "circle",
    label = "Code?",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_vault_lower_interact_3", {{
    event = "fa-vaultrob:lower:thirdpindoor",
    id = "faye_vault_lower_interact_3",
    icon = "circle",
    label = "Code?",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_vault_lower_interact_4", {{
    event = "fa-vaultrob:lower:fourthpindoor",
    id = "faye_vault_lower_interact_4",
    icon = "circle",
    label = "Code?",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});

RegisterNetEvent('fa-loot_gold_tray')
AddEventHandler('fa-loot_gold_tray', function()
    TriggerServerEvent('fa-heists:loot_tray')
end)

RegisterNetEvent('fa-loot_cash_tray')
AddEventHandler('fa-loot_cash_tray', function()
    TriggerServerEvent('fa-heists:cash_tray')
end)

RegisterNetEvent("fa-heists:grab_from_tray")
AddEventHandler("fa-heists:grab_from_tray", function()
    local chance = math.random(120)
    Loot()
    if chance < 25 then
		TriggerEvent("player:receiveItem",'heistusb1', 1)
        TriggerEvent('fa-mining:get_gem')
	end
    TriggerEvent("player:receiveItem", "inkset",math.random(25, 50))
    TriggerEvent("player:receiveItem", "inkedmoneybag",math.random(1, 2))
end)