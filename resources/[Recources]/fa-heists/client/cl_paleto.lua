

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

function PaletoStep1() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 224.24514)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-109.5068, 6483.3657, 31.460279, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)   -- vector3(-109.5068, 6483.3657, 31.460279)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -109.5068, 6483.3657, 31.460279,  true,  true, false)

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

RegisterNetEvent('fa-paleto:box')
AddEventHandler('fa-paleto:box', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-109.7645, 6483.5034, 31.46849) - player)
    if distance < 1.5 then
        if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
            TriggerEvent("client:newStress",true, 10)
            PaletoStep1()
            exports["fa-dispatch"]:dispatchadd('10-90', "Paleto Bank Robbery", "108")
            exports['fa-thermite']:OpenThermiteGame(function(success)
                if success then
                    TriggerServerEvent('step1enable')
                    TriggerEvent('phone:addnotification', 'Anonymous', 'The Firewall is down. Go inside and complete the capta.')
                    TriggerEvent("inventory:removeItem", "thermitecharge", 1)
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
end)

function StartPaleto()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, -102.145932, 6463.17232332, 31.634124232-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 233.03924)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", -102.145932, 6463.17232332, 31.634124232 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 233.03924)
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

RegisterNetEvent('faye:createpaletomoney')
AddEventHandler('faye:createpaletomoney', function(toggle)
    if toggle == true then
     Money = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -97.69409, 6463.3803, 30.634134, true,  true, true)    
    CreateObject(Money)
    SetEntityHeading(Money, 130.72283)
    FreezeEntityPosition(Money, true)

    Money2 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), -99.88224, 6460.9506, 30.63412, true,  true, true)  
    CreateObject(Money2)
    SetEntityHeading(Money2, 342.40374)
    FreezeEntityPosition(Money2, true) 

    
    Money3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -97.07391, 6460.1889, 30.634119, true,  true, true)    
    CreateObject(Money3)
    SetEntityHeading(Money3, 226.40374)
    FreezeEntityPosition(Money3, true) 



    elseif toggle == false then
        DeleteObject(money)
        DeleteObject(money2)
        DeleteObject(money3)
    end
end)

function CreateMoney()
    local ped = PlayerPedId()

    TriggerEvent('faye:CleanClientVaultD')
    TriggerEvent("faye:createpaletomoney" ,true)
    Citizen.Trace("Crates Spawned :  Sucess")
    Citizen.Wait(240000)
    Citizen.Wait(60000)
    TriggerEvent("faye:createpaletomoney" ,false)
end


RegisterNetEvent('fa-paleto:startpaleto')
AddEventHandler('fa-paleto:startpaleto', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-102.1473, 6463.0869, 31.634153) - player)
    if distance < 1.5 then
        local Police = exports["fa-duty"]:LawAmount()
        if Police >= 4 then
            if exports["fa-inventory"]:hasEnoughOfItem("heistlaptop2", 1) then
                StartPaleto()
                exports["fa-dispatch"]:dispatchadd('10-90', "Paleto Bank Robbery", "108")
                TriggerEvent("client:newStress",true, 10)
                exports['fa-hacking']:hacking(
                function()
                    ClearPedTasksImmediately(PlayerPedId())
                    OnHackSuccess()
                    DeleteObject(bag)
                    DeleteObject(laptop)
                    FreezeEntityPosition(ped, false)
                    TriggerEvent('inventory:removeItem', 'heistlaptop2', 1)
                end,
                function()
                    TriggerEvent('inventory:removeItem', 'heistlaptop2', 1)
                    FreezeEntityPosition(ped, false)
                    ClearPedTasksImmediately(PlayerPedId())
                end)
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'Not enough police.', 2)
        end 
    end
end)

function OnHackSuccess()
    TriggerEvent('fa-hud:hide_hackerman')
    TriggerEvent("inventory:removeItem", "heistlaptop2", 1)
    TriggerServerEvent('fa-paleto:startCoolDown')
    loadDicts()
    TriggerEvent('phone:addnotification', 'Anonymous', 'You Passed the CAPTA Wait 10 minutes for the door to open.')
    Citizen.Wait(600000)
    TriggerEvent('phone:addnotification', 'Anonymous', 'The Door is Open.')
    TriggerServerEvent('fa-doors:change-lock-state', 45, false) 
    CreateMoney()
end

RegisterNetEvent('fa-paletogold')
AddEventHandler('fa-paletogold', function()
    print('called 2?')
    TriggerServerEvent('fa-paleto:tut_tut')
end)

AddEventHandler("fa-inventory:itemUsed", function(pItem)
    if pItem == "thermitecharge" then
        TriggerEvent('fa-paleto:box')
    elseif pItem == "heistlaptop2" then
        TriggerServerEvent("fa-paleto:hacklaptop")
    end
end)