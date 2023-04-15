local legionactive = false
local delperroactive = false
local greatoceanactive = false
local pinkcageactive = false
local hawickactive = false
local route68active = false

Citizen.CreateThread(function()    
    TriggerServerEvent("robbery:get:config")
    ResetBankDoors()
end)

RegisterNetEvent("robbery:get:config", function(pConfig)
    Config = pConfig
end)

RegisterInterfaceCallback('fa-fleeca:email_1', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail1')
end)

RegisterNetEvent("aspect:bankemail1", function()
    if Config.SmallBanks[2]["isOpened"] == false then
      TriggerServerEvent('charge:fleeca', 10000, 'Legion Square')

        TriggerServerEvent('ready:legion')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterInterfaceCallback('fa-fleeca:email_2', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail2')
end)

RegisterNetEvent("aspect:bankemail2", function()
    if Config.SmallBanks[4]["isOpened"] == false then
        TriggerServerEvent('charge:fleeca', 10000, 'Boulevard Del Perro')

        TriggerServerEvent('ready:boulevarddelperro')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterInterfaceCallback('fa-fleeca:email_3', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail3')
end)

RegisterNetEvent("aspect:bankemail3", function()
    if Config.SmallBanks[5]["isOpened"] == false then
        TriggerServerEvent('charge:fleeca', 10000, 'Great Ocean Highway')

        TriggerServerEvent('ready:greatoceanready')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterInterfaceCallback('fa-fleeca:email_4', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail5')
end)

RegisterNetEvent("aspect:bankemail5", function()
    if Config.SmallBanks[1]["isOpened"] == false then
        TriggerServerEvent('charge:fleeca', 10000, 'Pink Cage')

        TriggerServerEvent('ready:pinkcageready')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterInterfaceCallback('fa-fleeca:email_5', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail6')
end)

RegisterNetEvent("aspect:bankemail6", function()
    if Config.SmallBanks[3]["isOpened"] == false then
        TriggerServerEvent('charge:fleeca', 10000, 'Hawick Avenue')
        TriggerServerEvent('ready:hawickeaveready')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterInterfaceCallback('fa-fleeca:email_6', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('aspect:bankemail7')
end)

RegisterNetEvent("aspect:bankemail7", function()
    if Config.SmallBanks[6]["isOpened"] == false then
        TriggerServerEvent('charge:fleeca', 10000, 'Route 68')
        TriggerServerEvent('ready:route68ready')
    else
        TriggerEvent("DoLongHudText", "Somebody already took that information, Come back later.", 2)
    end
end)

RegisterNetEvent("aspect:bankemail", function(bankname)
    local username = "FLEECA"..(math.random (10000,99999))
    local password = math.random (1000000,9999999)

    TriggerServerEvent('aspect:usernamestore', bankname, username, password)

    TriggerServerEvent('aspect:fleecalogin', bankname, username, password)

    TriggerEvent("addEmail", {title = "Fleeca Informant.", subject = "Fleeca Bank", message = "Here's the details you need to gain access to the panel, You're on your own after that. | USERNAME: "..username.." | PASSWORD: "..password})
end)

-- RegisterCommand('queer', function()
--     TriggerEvent('aspect:listfleeca')
-- end)

-- Code
local closestBank = nil
local inRange
local laptop = 0

Citizen.CreateThread(function()
    Citizen.Wait(1)
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dist
            inRange = false
            for k, v in pairs(Config.SmallBanks) do
                dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"])
                if dist < 15 then
                    closestBank = k
                    inRange = true
                end
            end
            if not inRange then
                Citizen.Wait(1000)
                closestBank = nil
            end

        Citizen.Wait(3)
    end
end)

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

RegisterNetEvent("isRobberyActive:fleeca")
AddEventHandler("isRobberyActive:fleeca", function(pBusy)
    isBusy = pBusy
end)

RegisterNetEvent('fa-robbery:usb')
AddEventHandler('fa-robbery:usb', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local Police = exports["fa-duty"]:LawAmount()
    if closestBank ~= nil then
        TriggerServerEvent("isRobberyActive")
        Citizen.Wait(500)
        if not isBusy then
            if closestBank ~= nil then
                local dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z)
                if dist < 1.5 then				
                    if not Config.SmallBanks[closestBank]["isOpened"] then 
                        if Police >= -1 then
                            TriggerServerEvent('fa-heists:fleecaBankLog')
                            TriggerServerEvent("fa-heists:availabilty")
                            exports["fa-dispatch"]:dispatchadd('10-90', "Fleeca Bank Robbery", "108")
                            TriggerServerEvent('aspect:retrievelogindata', closestBank)
                            TriggerEvent("client:newStress",true,100)
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            StartHeistFleecaPanel()
                            Citizen.Wait(5000)
                            exports['fa-hacking']:hacking(
                            function()
                                ClearPedTasksImmediately(PlayerPedId())
                                TriggerEvent('fleeca:success:panel')
                                FreezeEntityPosition(PlayerPedId(), false)
                            end,
                            function()
                                TriggerEvent('inventory:removeItem', 'heistlaptop3', 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                ClearPedTasksImmediately(PlayerPedId())
                            end)
                        else
                            TriggerEvent("DoLongHudText", "Not enough cops on duty...", 2)
                        end
                    else
                        TriggerEvent('DoLongHudText', "The bank is already open.", 2)
                    end
                end
            end
        end
    else
        TriggerEvent('DoLongHudText', "The security lock is active, opening the door is currently not possible.", 2)
    end
end)

RegisterNetEvent('fa-robbery:client:setBankState')
AddEventHandler('fa-robbery:client:setBankState', function(bankId, state)
    if bankId == "pacific" then
        print('QUEER')
    else
        Config.SmallBanks[bankId]["isOpened"] = state
        if state then
            OpenBankDoor(bankId)
        end
        print(bankId)
    end
end)

RegisterNetEvent('fa-robbery:client:enableAllBankSecurity')
AddEventHandler('fa-robbery:client:enableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = true
    end
end)

RegisterNetEvent('fa-robbery:client:disableAllBankSecurity')
AddEventHandler('fa-robbery:client:disableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = false
    end
end)

RegisterNetEvent('fa-robbery:client:BankSecurity')
AddEventHandler('fa-robbery:client:BankSecurity', function(key, status)
    Config.SmallBanks[key]["alarm"] = status
end)

function StartHeistFleecaPanel()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, Config.SmallBanks[closestBank].player_heading)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, Config.SmallBanks[closestBank].player_heading)
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

function loadDicts()
    RequestAnimDict("anim@heists@ornate_bank@hack")
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@hack")
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(0)
    end
end

function OpenBankDoor(bankId)
    local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.SmallBanks[bankId]["heading"].closed

    if object ~= 0 then
        Citizen.CreateThread(function()
            while true do

                if entHeading ~= Config.SmallBanks[bankId]["heading"].open then
                    SetEntityHeading(object, entHeading - 10)
                    entHeading = entHeading - 0.5
                else
                    break
                end

                Citizen.Wait(10)
            end
        end)
    end
end

function ResetBankDoors()
    for k, v in pairs(Config.SmallBanks) do
        local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]["isOpened"] then
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
        else
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
        end
    end
end

RegisterNetEvent('fa-robbery:client:setLockerState')
AddEventHandler('fa-robbery:client:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "pacific" then	
        print('[QUEER]')
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end
end)

RegisterNetEvent('fa-robbery:client:ResetFleecaLockers')
AddEventHandler('fa-robbery:client:ResetFleecaLockers', function(BankId)
    Config.SmallBanks[BankId]["isOpened"] = false
    for k,_ in pairs(Config.SmallBanks[BankId]["lockers"]) do
        Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
        Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ResetBankDoors()
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent("fleeca:success:panel", function()
    TriggerEvent('inventory:removeItem', 'heistlaptop3', 1)
    TriggerEvent('phone:addnotification', 'Anonymous', 'Wait 5 Minutes for the door to open')
    Citizen.Wait(100)
    TriggerEvent('phone:addnotification', 'Anonymous', 'Door open! Check out the back and loot the trolleys.')
    exports["fa-dispatch"]:dispatchadd('10-90', "Fleeca Bank Robbery", "108")
    TriggerServerEvent('fa-robbery:server:setBankState', closestBank, true)

     if closestBank == 1 then
        print('[fa-heists] CREATE FLEECA PINK CAGE TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:pink:cage:bank')
     elseif closestBank == 2 then
        print('[fa-heists] CREATE FLEECA LEGION SQUARE TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:legion:sqaure:bank')
     elseif closestBank == 3 then
        print('[fa-heists] CREATE FLEECA HAWICK AVE TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:hawick:ave:bank')
     elseif closestBank == 4 then
        print('[fa-heists] CREATE FLEECA DEL PERRO TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:del:perrro:blvd')
     elseif closestBank == 5 then
        print('[fa-heists] CREATE FLEECA GREAT OCEAN TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:great:ocean:highway')
     elseif closestBank == 6 then
        print('[fa-heists] CREATE FLEECA ROUTE 68 TROLLEYS')
        TriggerEvent('faye:create:props:trolleys:route:68:bank')
     end
     DeleteObject(laptop)
 end)

RegisterNetEvent("fleeca:fail", function()
    TriggerEvent("DoLongHudText", "Hacking sequence failed!", 2)
end)

RegisterNetEvent("fleeca:loot")
AddEventHandler("fleeca:loot", function()
    local card = exports["fa-taskbar"]:taskBar(40000,"Taking cash...")
    if card == 100 then
        TriggerEvent("player:receiveItem", "markedbills", math.random(10, 20))
    end
end)

function bankdoor(success, timeremaining)
    if success then
        TriggerEvent('DoLongHudText', "Success!", 1)
        exports["fa-dispatch"]:dispatchadd('10-90', "Fleeca Bank Robbery", "108")
        TriggerServerEvent('fa-robbery:server:setBankState', closestBank, true)
        DeleteObject(laptop)
    else
        TriggerServerEvent("inventory:deg:item", "heistlaptop3")
        TriggerEvent('DoLongHudText', "Failed", 2)
        exports["fa-dispatch"]:dispatchadd('10-90', "Fleeca Bank Robbery", "108")
        DeleteObject(laptop)
    end
end

-- Trolleys --

RegisterNetEvent('faye:create:props:trolleys:legion:sqaure:bank')
AddEventHandler('faye:create:props:trolleys:legion:sqaure:bank', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 150.31228637695, -1045.9461669922, 28.371044158936, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 107.77)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 147.08638000488, -1049.7965087891, 28.409341812134, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 289.74)
    FreezeEntityPosition(loottable2, true) 
end)

RegisterNetEvent('faye:create:props:trolleys:del:perrro:blvd')
AddEventHandler('faye:create:props:trolleys:del:perrro:blvd', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -1208.3375244141, -333.60223388672, 36.880027770996, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 145.19)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -1208.0318603516, -338.85507202148, 36.854415893555, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 338.42)
    FreezeEntityPosition(loottable2, true) 

end)

RegisterNetEvent('faye:create:props:trolleys:great:ocean:highway')
AddEventHandler('faye:create:props:trolleys:great:ocean:highway', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -2957.8352050781, 485.29113769531, 14.748895645142, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 202.93)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -2953.1164550781, 482.79040527344, 14.763164520264, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 32.85)
    FreezeEntityPosition(loottable2, true) 

end)

RegisterNetEvent('faye:create:props:trolleys:pink:cage:bank')
AddEventHandler('faye:create:props:trolleys:pink:cage:bank', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 314.80725097656, -284.326171875, 53.264915466309, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 99.78)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 311.23284912109, -288.22537231445, 53.19066619873, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 285.61)
    FreezeEntityPosition(loottable2, true) 

end)

RegisterNetEvent('faye:create:props:trolleys:hawick:ave:bank')
AddEventHandler('faye:create:props:trolleys:hawick:ave:bank', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -349.94314575195, -55.052867889404, 48.086811065674, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 101.84)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), -353.52963256836, -58.877403259277, 48.029510498047, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 289.95)
    FreezeEntityPosition(loottable2, true) 

end)

RegisterNetEvent('faye:create:props:trolleys:route:68:bank')
AddEventHandler('faye:create:props:trolleys:route:68:bank', function()
    local loottable1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 1172.3402099609, 2711.1115722656, 37.153461456299, true,  true, true)
    CreateObject(loottable1)
    SetEntityHeading(loottable1, 305.25)
    FreezeEntityPosition(loottable1, true)

    local loottable2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), 1174.6026611328, 2716.3208007812, 37.130180358887, true,  true, true)
    CreateObject(loottable2)
    SetEntityHeading(loottable2, 129.43)
    FreezeEntityPosition(loottable2, true) 

end)

RegisterNetEvent("fa-fleeca:grab")
AddEventHandler("fa-fleeca:grab", function()
    local chance = math.random(120)
    Loot()
    if chance < 25 then
		TriggerEvent("player:receiveItem",'heistusb1', 1)
        TriggerEvent('fa-mining:get_gem')
	end
    TriggerEvent("player:receiveItem", "inkset",math.random(25, 50))
    TriggerEvent("player:receiveItem", "inkedmoneybag",math.random(1, 2))
end)

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
    end
end