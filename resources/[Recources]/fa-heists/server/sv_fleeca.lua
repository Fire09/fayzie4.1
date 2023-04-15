cooldownglobal = 0
Available = true

RegisterServerEvent("fa-fleeca:startcheck")
AddEventHandler("fa-fleeca:startcheck", function(bank)
    local _source = source
    globalonaction = true
    TriggerClientEvent('inventory:removeItem', _source, 'hacklaptop', 1)
    TriggerClientEvent("fa-fleeca:outcome", _source, true, bank)
end)

RegisterServerEvent("fa-fleeca:TimePoggers")
AddEventHandler("fa-fleeca:TimePoggers", function()
    local _source = source
    TriggerClientEvent("fa-fleeca:outcome", _source, false, "A bank as been recently robbed. You need to wait "..math.floor((fleeca.cooldown - (os.time() - cooldownglobal)) / 60)..":"..math.fmod((fleeca.cooldown - (os.time() - cooldownglobal)), 60))
end)

RegisterServerEvent("fa-fleeca:DoorAccessPoggers")
AddEventHandler("fa-fleeca:DoorAccessPoggers", function()
    local _source = source
    TriggerClientEvent("fa-fleeca:outcome", _source, false, "There is a bank currently being robbed.")
end)

RegisterServerEvent("fa-fleeca:lootup")
AddEventHandler("fa-fleeca:lootup", function(var, var2)
    TriggerClientEvent("fa-fleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("fa-fleeca:openDoor")
AddEventHandler("fa-fleeca:openDoor", function(coords, method)
    TriggerClientEvent("fa-fleeca:openDoor_c", -1, coords, method)
end)

RegisterServerEvent("fa-fleeca:startLoot")
AddEventHandler("fa-fleeca:startLoot", function(data, name)
    TriggerClientEvent("fa-fleeca:startLoot_c", -1, data, name)
end)

RegisterServerEvent("fa-fleeca:stopHeist")
AddEventHandler("fa-fleeca:stopHeist", function(name)
    TriggerClientEvent("fa-fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("fa-fleeca:rewardCash")
AddEventHandler("fa-fleeca:rewardCash", function()
    local reward = math.random(1, 2)
    local mathfunc = math.random(200)
    local rare = math.random(1,1)
    
    if mathfunc == 15 then
      TriggerClientEvent('fa-user:receiveItem', source, 'heistusb4', 1)
    end
    TriggerClientEvent("fa-user:receiveItem", source, "band", reward)
end)

RegisterServerEvent("fa-fleeca:setCooldown")
AddEventHandler("fa-fleeca:setCooldown", function(name)
    cooldownglobal = os.time()
    globalonaction = false
    TriggerClientEvent("fa-fleeca:resetDoorState", -1, name)
end)

RegisterServerEvent("fa-fleeca:getBanksSV")
AddEventHandler("fa-fleeca:getBanksSV", function()
    local banks = fleeca.Banks
    TriggerClientEvent('fa-fleeca:getBanks', -1, fleeca.Banks)
end)

local cooldownAttempts = 5

RegisterServerEvent("fa-fleeca:getHitSV")
AddEventHandler("fa-fleeca:getHitSV", function()
    TriggerClientEvent('fa-fleeca:getHit', -1, cooldownAttempts)
end)

RegisterServerEvent("fa-fleeca:getHitSVSV")
AddEventHandler("fa-fleeca:getHitSVSV", function(fleecaBanksTimes)
    cooldownAttempts = fleecaBanksTimes
end)

local doorCheckFleeca = false

RegisterServerEvent("fa-fleeca:getGetDoorStateSV")
AddEventHandler("fa-fleeca:getGetDoorStateSV", function()
    TriggerClientEvent('fa-fleeca:getDoorCheckCL', -1, doorCheckFleeca)
end)

RegisterServerEvent("fa-fleeca:getGetDoorStateSVSV")
AddEventHandler("fa-fleeca:getGetDoorStateSVSV", function(fleecaBanksDoors)
    doorCheckFleeca = fleecaBanksDoors
end)


RegisterServerEvent("fa-fleeca:getTimeSV")
AddEventHandler("fa-fleeca:getTimeSV", function()
    TriggerClientEvent('fa-fleeca:GetTimeCL', -1, cooldownglobal)
end)

RegisterServerEvent("fa-fleeca:getTime2SV")
AddEventHandler("fa-fleeca:getTime2SV", function()
    TriggerClientEvent('fa-fleeca:GetTime2CL', -1, (os.time() - fleeca.cooldown))
end)

RegisterServerEvent("fa-fleeca:getDoorAccessSV")
AddEventHandler("fa-fleeca:getDoorAccessSV", function()
    TriggerClientEvent('fa-fleeca:GetDoorAccessCL', -1, globalonaction)
end)

RegisterServerEvent('charge:fleeca')
AddEventHandler('charge:fleeca', function(amount, bankname)
  local _source = source
  local user = exports["fa-base"]:getModule("Player"):GetUser(source)

    if user:getCash() >= amount then
        user:removeMoney(amount)
        TriggerClientEvent('aspect:bankemail', source, bankname)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough money!', 2)
    end
end)

RegisterServerEvent('fa-robbery:server:setBankState')
AddEventHandler('fa-robbery:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
       print('[QUEER]')
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('fa-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('fa-robbery:server:SetSmallbankTimeout', bankId)
            TriggerEvent('aspect:bankstore', bankId, state)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('fa-robbery:server:SetSmallbankTimeout')
 AddEventHandler('fa-robbery:server:SetSmallbankTimeout', function(BankId)
     if not robberyBusy then
        Citizen.Wait(3600000)
        Config.SmallBanks[BankId]["isOpened"] = false
        timeOut = false
        robberyBusy = false
        TriggerClientEvent('fa-robbery:client:ResetFleecaLockers', -1, BankId)
        TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
     end
 end)


local Loot = false

RegisterServerEvent('fa-fleeca:tut_tut')
AddEventHandler('fa-fleeca:tut_tut', function()
    local src = source
    if not Loot then
        Loot = true
        TriggerClientEvent('fa-fleeca:grab', src)
        Citizen.Wait(40000)
        Loot = false
    end
end)

RegisterServerEvent('voidrp-heists:fleeca_availability')
AddEventHandler('voidrp-heists:fleeca_availability', function()
    local src = source
    
    if Available then
        TriggerClientEvent('fa-heists:fleeca_available', src)
    else
        TriggerClientEvent('fa-heists:fleeca_unavailable', src)
    end
end)

RegisterServerEvent('fa-heists:fleecaBankLog')
AddEventHandler('fa-heists:fleecaBankLog', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Fayzie [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing a Fleeca Bank",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1061288479553749002/U2-X0X6mUJnO2AVQMFdEjXhJEwclKOlWua_Ucjv-sxxmld8Fo6W4MpV4fwCSD42aezdL", function(err, text, headers) end, 'POST', json.encode({username = "faye | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/M7iUngJ.png"}), { ['Content-Type'] = 'application/json' })
end)