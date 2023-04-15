RegisterNetEvent('fa-heists:bay_city:first_door')
AddEventHandler('fa-heists:bay_city:first_door', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-1305.37, -820.69, 17.15) - player)
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        if distance < 1.5 then
            if exports["fa-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
                firstDoorBC()
                TriggerServerEvent('fa-heists:bayCityLog')
                exports["fa-dispatch"]:dispatchadd('10-90', "Bay City Bank", "500")
                TriggerEvent("inventory:removeItem", "thermitecharge", 1)
                exports['fa-thermite']:OpenThermiteGame(function(success)
                    if success then
                        TriggerServerEvent('pSendSecondDoor')
                        TriggerServerEvent('fa-doors:change-lock-state', 555, false) 
                        Citizen.Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
                end, 5, 3, 10)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'Not enough cops on duty.', 2)
    end
end)

function firstDoorBC() -- FRONT DOOR ANIMATION
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 39.02)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-1305.61, -820.4, 17.15, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -1305.61, -820.4, 17.15,  true,  true, false)

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

RegisterNetEvent('fa-heists:bay_city:second_door')
AddEventHandler('fa-heists:bay_city:second_door', function()
    local pd = exports["fa-duty"]:LawAmount()
    if pd >= 4 then
        exports["fa-dispatch"]:dispatchadd('10-90', "Bay City Bank", "500")
        FreezeEntityPosition(PlayerPedId(), true)
        local finished = exports['fa-taskbar']:taskBar(15000, 'Opening Door.')
        if finished == 100 then
            TriggerEvent('aspect:createTrolleys')
            TriggerServerEvent('pStopSecondDoor')
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('fa-doors:change-lock-state', 556, false) 
            -- Create Trolleys.
        end
    end
end)

RegisterNetEvent('fa-heists:bay_city:second_door:sv')
AddEventHandler('fa-heists:bay_city:second_door:sv', function()
    TriggerServerEvent('fa-heists:second_door:cl')
end)

exports["fa-polytarget"]:AddCircleZone("faye_baycity_unlock", vector3(-1309.13, -815.79, 17.7), 0.45, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("faye_baycity_unlock", {{
    event = "fa-heists:bay_city:second_door:sv",
    id = "faye_baycity_unlock",
    icon = "warehouse",
    label = "Open Door.",
    parameters = {},
}}, {
    distance = { radius = 1.5 },
});

RegisterNetEvent('aspect:createTrolleys')
AddEventHandler('aspect:createTrolleys', function(toggle)
    Trolley = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -1309.52, -809.86, 16.16, true,  true, true)
    CreateObject(Trolley)
    SetEntityHeading(Trolley, 214.28)
    FreezeEntityPosition(Trolley, true)

    Trolley3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -1309.64, -813.99, 16.13, true,  true, true)
    CreateObject(Trolley3)
    SetEntityHeading(Trolley3, 309.79)
    FreezeEntityPosition(Trolley3, true) 
end)

AddEventHandler("fa-inventory:itemUsed", function(item)
    if item == "thermitecharge" then
        TriggerServerEvent('fa-heists:first_door:cl')
    end
end)