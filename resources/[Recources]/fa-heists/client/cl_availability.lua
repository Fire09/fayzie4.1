RegisterNetEvent('fa-heists:checkAvailability')
AddEventHandler('fa-heists:checkAvailability', function() 

    if Config.SmallBanks[2]["isOpened"] then
        pFleeca1Text = "Unavailable"
    else
        pFleeca1Text = "Available"
    end

    if Config.SmallBanks[4]["isOpened"] then
        pFleeca2Text = "Unavailable"
    else
        pFleeca2Text = "Available"
    end
    
    if Config.SmallBanks[5]["isOpened"] then
        pFleeca3Text = "Unavailable"
    else
        pFleeca3Text = "Available"
    end

    if Config.SmallBanks[1]["isOpened"] then
        pFleeca4Text = "Unavailable"
    else
        pFleeca4Text = "Available"
    end

    if Config.SmallBanks[3]["isOpened"] then
        pFleeca5Text = "Unavailable"
    else
        pFleeca5Text = "Available"
    end

    if Config.SmallBanks[6]["isOpened"] then
        pFleeca6Text = "Unavailable"
    else
        pFleeca6Text = "Available"
    end

    local FatCunt = {
		{
            title = "Fleeca: Legion Square",
            description = pFleeca1Text,
            disabled = Config.SmallBanks[2]["isOpened"],
        },
        {
            title = "Fleeca: Lifeinvader",
            description = pFleeca2Text,
            disabled = Config.SmallBanks[4]["isOpened"],
        }, 
        {
            title = "Fleeca: Great Ocean",
            description = pFleeca3Text,
            disabled = Config.SmallBanks[5]["isOpened"],
        }, 
        {
            title = "Fleeca: Pink Cage",
            description = pFleeca4Text,
            disabled = Config.SmallBanks[1]["isOpened"],
        }, 
        {
            title = "Fleeca: Hawick",
            description = pFleeca5Text,
            disabled = Config.SmallBanks[3]["isOpened"],
        }, 
        {
            title = "Fleeca: Harmony",
            description = pFleeca6Text,
            disabled = Config.SmallBanks[6]["isOpened"],
        }, 
    }
    exports["fa-interface"]:showContextMenu(FatCunt)
end)

RegisterNetEvent('fa-heists:purchaseHeistEquipment')
AddEventHandler('fa-heists:purchaseHeistEquipment', function()
    local HeistEquipment = {
		{
            title = "Fleeca Laptop",
            description = "Purchase a laptop for a fleeca bank.",
            children = {
                title = "Green Laptop",
                description = "Requirements: 1x Green Dongle.",
                action = "fa-heists:purchaseGreenLaptop",
            },
        },
        {
            title = "Paleto Laptop",
            description = "Purchase a laptop for paleto bank.",
            children = {
                title = "Blue Laptop",
                description = "Requirements: 1x Blue Dongle.",
                action = "fa-heists:purchaseBlueLaptop",
            },
        },
    }
    exports["fa-interface"]:showContextMenu(HeistEquipment)
end)

RegisterInterfaceCallback('fa-heists:purchaseGreenLaptop', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-inventory']:hasEnoughOfItem('heistusb5', 1) then
        TriggerEvent('inventory:removeItem', 'heistusb5', 1)
        TriggerEvent("player:receiveItem", "heistlaptop3", 1)
    end
end)

RegisterInterfaceCallback('fa-heists:purchaseBlueLaptop', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-inventory']:hasEnoughOfItem('heistusb1', 1) then
        TriggerEvent('inventory:removeItem', 'heistusb1', 1)
        TriggerEvent("player:receiveItem", "heistlaptop2", 1)
    end
end)

--         {
--             title = "Paleto Bank",
--             description = "",
--             disabled = EXPORT FOR THE SHIT.,
--         },
--         {
--             title = "Upper Vault (City Bank)",
--             description = "",
--             disabled = EXPORT FOR THE SHIT.,
--         },
--         {
--             title = "Lower Vault (City Bank)",
--             description = "",
--             disabled = EXPORT FOR THE SHIT.,
--         },
--         {
--             title = "Bay City Bank",
--             description = "",
--             disabled = EXPORT FOR THE SHIT.,
--         },