RegisterNetEvent("fa-npcs:set:ped")
AddEventHandler("fa-npcs:set:ped", function(pNPCs)
  if type(pNPCs) == "table" then
    for _, ped in ipairs(pNPCs) do
      RegisterNPC(ped, 'fa-npcs')
      EnableNPC(ped.id)
    end
  else
    RegisterNPC(ped, 'fa-npcs')
    EnableNPC(ped.id)
  end
end)

RegisterNetEvent("fa-npcs:ped:giveStolenItems")
AddEventHandler("fa-npcs:ped:giveStolenItems", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local npcCoords = GetEntityCoords(pEntity)
  exports['fa-taskbar']:Progress({
      duration = 3000,
      label = "Preparing to exchange material, don't move.",
  }, function(cancelled)
      if not cancelled then
        if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
          TriggerEvent("server-inventory-open", "1", "Stolen-Goods-1")
        else
          TriggerEvent("DoLongHudText", "You moved too far you idiot.", 2)
        end
      end
  end)
end)

RegisterNetEvent("fa-npcs:ped:exchangeRecycleMaterial")
AddEventHandler("fa-npcs:ped:exchangeRecycleMaterial", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local npcCoords = GetEntityCoords(pEntity)
  exports['fa-taskbar']:Progress({
      duration = 3000,
      label = "Preparing to exchange material, don't move.",
  }, function(cancelled)
      if not cancelled then
        if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
          TriggerEvent("server-inventory-open", "141", "Craft");
        else
          TriggerEvent("DoLongHudText", "You moved too far you idiot.", 2)
        end
      end
  end)
end)

RegisterNetEvent("fa-npcs:ped:signInJob")
AddEventHandler("fa-npcs:ped:signInJob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  if #pArgs == 0 then
    local npcId = DecorGetInt(pEntity, 'NPC_ID')
    if npcId == `news_reporter` then
      TriggerServerEvent("jobssystem:jobs", "news")
    elseif npcId == `head_stripper` then
      TriggerServerEvent("jobssystem:jobs", "entertainer")
    end
  else
    TriggerServerEvent("jobssystem:jobs", "unemployed")
  end
end)

RegisterNetEvent("fa-npcs:ped:paycheckCollect")
AddEventHandler("fa-npcs:ped:paycheckCollect", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerServerEvent("server:paySlipPickup")
end)

RegisterNetEvent("fa-npcs:ped:receiptTradeIn")
AddEventHandler("fa-npcs:ped:receiptTradeIn", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    local user = exports["fa-base"]:GetModule("LocalPlayer")
    local cid = user.id
    RPC.execute("ab-inventory:tradeInReceipts", cid, accountTarget)
end)

RegisterNetEvent("fa-npcs:ped:sellStolenItems")
AddEventHandler("fa-npcs:ped:sellStolenItems", function()
  RPC.execute("ab-inventory:sellStolenItems")
end)

RegisterNetEvent("fa-npcs:ped:keeper")
AddEventHandler("fa-npcs:ped:keeper", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerEvent("server-inventory-open", pArgs[1], "Shop");
end)


TriggerServerEvent("fa-npcs:location:fetch")

AddEventHandler("fa-npcs:ped:weedSales", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local result, message = RPC.execute("fa-npcs:weedShopOpen")
  if not result then
    TriggerEvent("DoLongHudText", message, 2)
    return
  end
  TriggerEvent("server-inventory-open", "44", "Shop");
end)

AddEventHandler("fa-npcs:ped:licenseKeeper", function()
  RPC.execute("fa-npcs:purchaseDriversLicense")
end)

AddEventHandler("fa-npcs:ped:openDigitalDenShop", function()
  TriggerEvent("server-inventory-open", "42073", "Shop")
end)
RegisterNetEvent("fa-npcs:ped:giveidcard")
AddEventHandler("fa-npcs:ped:giveidcard", function()
  RPC.execute("fa-npcs:idcard")
end)

RegisterNetEvent("fa-npcs:ped:garbagejob")
AddEventHandler("fa-npcs:ped:garbagejob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  RPC.execute("fa-npcs:GarbageVals")
end)


