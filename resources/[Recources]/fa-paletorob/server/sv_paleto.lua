Doors = {
    ["P1"] = {{loc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), txtloc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), state = nil, locked = true}},
}

RegisterServerEvent("fa-paleto:startcheck")
AddEventHandler("fa-paleto:startcheck", function(bank)
    local src = source

    if not Paleto.Banks[bank].onaction == true then
        if (os.time() - Paleto.cooldown) > Paleto.Banks[bank].lastrobbed then
            Paleto.Banks[bank].onaction = true
            TriggerClientEvent("fa-paleto:outcome", src, true, bank)
            TriggerClientEvent("fa-paleto:policenotify", -1, bank)
        else
            TriggerClientEvent("fa-paleto:outcome", src, false, "This bank recently robbed. You need to wait "..math.floor((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("fa-paleto:outcome", src, false, "This bank is currently being robbed.")
    end
end)

RegisterCommand("testy", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
        -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
    else
        if Paleto.blackmoney then
            TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
            -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
        end
    end
end)

RegisterServerEvent("fa-paleto:lootup")
AddEventHandler("fa-paleto:lootup", function(var, var2)
    TriggerClientEvent("fa-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("fa-paleto:toggleVault")
AddEventHandler("fa-paleto:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("fa-paleto:toggleVault", -1, key, state)
end)

RegisterServerEvent("fa-paleto:updateVaultState")
AddEventHandler("fa-paleto:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("fa-paleto:startLoot")
AddEventHandler("fa-paleto:startLoot", function(data, name, players)
    local src = source

    for i = 10, #players, 10 do
        TriggerClientEvent("fa-paleto:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("fa-paleto:startLoot_c", src, data, name)
end)

RegisterServerEvent("fa-paleto:stopHeist")
AddEventHandler("fa-paleto:stopHeist", function(name)
    TriggerClientEvent("fa-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("fa-paleto:rewardCash")
AddEventHandler("fa-paleto:rewardCash", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 250)
    else
        TriggerClientEvent("player:receiveItem", src, "markedbills", 425)
    end
end)

RegisterServerEvent("fa-paleto:setCooldown")
AddEventHandler("fa-paleto:setCooldown", function(name)
    Paleto.Banks[name].lastrobbed = os.time()
    Paleto.Banks[name].onaction = false
    TriggerClientEvent("fa-paleto:resetDoorState", -1, name)
end)

RPC.register("fa-paleto:getBanks", function(source)
    return Paleto.Banks, Doors
end)

 RegisterCommand("aan", function()
     TriggerClientEvent('fa-paleto:UseGreenLapTop', source)
 end)

-- RegisterServerEvent('rick:removeLaptop')
-- AddEventHandler('rick:removeLaptop', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem('green-laptop', 1)
-- end)


local doorCheckPaleto = false

RegisterServerEvent("fa-paleto:getGetDoorStateSV")
AddEventHandler("fa-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('fa-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("fa-paleto:getGetDoorStateSVSV")
AddEventHandler("fa-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)

RegisterServerEvent("fa-paleto:openDoor")
AddEventHandler("fa-paleto:openDoor", function(coords, method)
    TriggerClientEvent("fa-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("fa-paleto:closeDoor")
AddEventHandler("fa-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("fa-paleto:ClosePaletoDoor", -1)
end)