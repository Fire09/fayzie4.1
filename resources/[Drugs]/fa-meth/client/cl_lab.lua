local insideLab = nil
local carryingIngredient = false
local myWallet = nil


local animationMap = {
    PICKUP_INGREDIENTS = {
        time = 10000,
        dictionary = "anim@heists@prison_heiststation@",
        name = "pickup_bus_schedule",
        flag = 1,
        text = "Picking up stuff"
    },
    FRIDGE_TEMPERATURE = {
        time = 60000,
        dictionary = "random@train_tracks",
        name = "idle_e",
        flag = 1,
        text = "Adjusting temperature"
    },
    DISTIL_STEAM = {
        time = 60000,
        dictionary = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
        name = "look_around_v5_monitor",
        flag = 49,
        text = "Adjusting steam levels"
    },
    DISTIL_SETTINGS = {
        time = 60000,
        dictionary = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
        name = "look_around_v5_monitor",
        flag = 49,
        text = "Adjusting settings"
    },
    MIXER_TEMPERATURE = {
        time = 60000,
        dictionary = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
        name = "look_around_v5_monitor",
        flag = 1,
        text = "Adjusting temperature"
    },
    MIXER_INGREDIENTS = {
        time = 45000,
        dictionary = "weapon@w_sp_jerrycan",
        name = "fire",
        flag = 49,
        text = "Adding ingredients"
    },
    MIXER_HARDWARE = {
        time = 60000,
        dictionary = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
        name = "look_around_v5_monitor",
        flag = 49,
        text = "Adjusting settings"
    }
}

local function processAction(action, pEntity, fnCb)
    local animSettings = animationMap[action]
    if animSettings then
        TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, -1)
        Wait(50)
        local animation = AnimationTask:new(PlayerPedId(), 'normal', animSettings.text, animSettings.time, animSettings.dictionary, animSettings.name, animSettings.flag)
        local result = animation:start()
        result:next(function (data)
            if data == 100 then
                RPC.execute("fa-meth:doAction", insideLab, action)
                if fnCb then
                  fnCb()
                end
            else
                TriggerEvent("DoLongHudText", "Stopped?", 2)
            end
            ClearPedTasksImmediately(PlayerPedId())
        end)
    end
end

--[[ RegisterUICallback("fa-ui:submitRangeValues", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    ClearPedTasksImmediately(PlayerPedId())
    Wait(100)
    exports["fa-ui"]:closeApplication("range-picker")
    
    local result = RPC.execute("fa-meth:doAction", insideLab, "START_COOKING", data)

    if not result then return end

    RPC.execute("phone:adjustCryptoBalance", 1, getConfig())
end) ]]

local skipKeyChecks = {
  ["Bonecrusher"] = true,
  ["Jazz"] = true,
  ["Megatron"] = true,
}
AddEventHandler("fa-meth:startCooking", function()
    if not skipKeyChecks[insideLab] and not exports["fa-inventory"]:hasEnoughOfItem("methlabkey", 1, false, true) then
        TriggerEvent("DoLongHudText", "No key...", 2)
        print("1")
        return
    end

    local wallet, message = RPC.execute("phone:adjustCryptoBalance", 1, getConfig())
    myWallet = wallet
    if not wallet then
        print("2")
        TriggerEvent("DoLongHudText", message, 2)
        return
    end

    print("3")
    exports["fa-ui"]:openApplication("range-picker")
end)

AddEventHandler("fa-meth:pickupIngredient", function(pArgs, pEntity)
    processAction("PICKUP_INGREDIENTS", pEntity, function()
      carryingIngredient = true
    end)
end)

-- actions

AddEventHandler("fa-meth:adjustFridgeTemp", function(pArgs, pEntity)
    processAction("FRIDGE_TEMPERATURE", pEntity)
end)

AddEventHandler("fa-meth:adjustSteamLevel", function(pArgs, pEntity)
    processAction("DISTIL_STEAM", pEntity)
end)

AddEventHandler("fa-meth:adjustDistilSettings", function(pArgs, pEntity)
    processAction("DISTIL_SETTINGS", pEntity)
end)

AddEventHandler("fa-meth:adjustMixerTemp", function(pArgs, pEntity)
    processAction("MIXER_TEMPERATURE", pEntity)
end)

AddEventHandler("fa-meth:addIngredient", function(pArgs, pEntity)
    if not carryingIngredient then
        TriggerEvent("DoLongHudText", "Not carrying anything?", 2)
        return
    end
    carryingIngredient = false
    processAction("MIXER_INGREDIENTS", pEntity)
end)

AddEventHandler("fa-meth:adjustMixerSettings", function(pArgs, pEntity)
    processAction("MIXER_HARDWARE", pEntity)
end)

-- end actions

-- AddEventHandler("fa-inventory:itemUsed", function(item, info)
--     if item ~= "methlabkey" then return end
--     if not info then return end
--     RPC.execute("fa-meth:useDoorKey", NetworkGetNetworkIdFromEntity(PlayerPedId()), info)
-- end)

AddEventHandler("fa-meth:purchaseMethLabKey", function()
    local wallet, message = RPC.execute("phone:adjustCryptoBalance", 1, getConfig())
    if not wallet then
        TriggerEvent("DoLongHudText", message, 2)
        return
    end
    local result = RPC.execute("fa-meth:purchaseLabKey")
end)

-- local foundObject = nil
-- AddEventHandler("np:target:changed", function(pEntity, pEntityType)
--   if not pEntity or pEntityType ~= 3 then
--     if foundObject then
--         foundObject = nil
--         TriggerEvent("fa-menu:updateMethObject", foundObject)
--     end
--     return
--   end
--   for k, v in pairs(INTERACT_OBJECTS) do
--     if k == GetEntityModel(pEntity) then
--         foundObject = INTERACT_OBJECTS[k].name
--     end
--   end
--   if foundObject then
--     TriggerEvent("fa-menu:updateMethObject", foundObject)
--   end
-- end)

AddEventHandler("fa-polyzone:enter", function(name, data)
    if name ~= "methlab" then return end
    insideLab = data.id
end)
AddEventHandler("fa-polyzone:exit", function(name, data)
    if name ~= "methlab" then return end
    insideLab = nil
end)

RegisterNetEvent("fa-meth:keyPurchasedEmail")
AddEventHandler("fa-meth:keyPurchasedEmail", function()
  TriggerEvent(
    "phone:emailReceived",
    "Dark Market",
    "Lab Information",
    "Be responsible with our key. We change locks and locations frequently. We don't like heat, keep the cops away. If a cook gets seen in prison, we'll change the locks. If you don't produce enough, we'll change the locks."
  )
end)
