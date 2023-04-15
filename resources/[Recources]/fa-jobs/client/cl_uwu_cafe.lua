-- Stash --

local Uwu_Cafe_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "Uwu_Cafe_Stash" then
        Uwu_Cafe_Stash = true
        UwuStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("uwu_cafe")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "Uwu_Cafe_Stash" then
        Uwu_Cafe_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function UwuStash()
	Citizen.CreateThread(function()
        while Uwu_Cafe_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("uwu_cafe")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'uwu-cafe-stash')
                end
			end
		end
	end)
end

Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("Uwu_Cafe_Stash", vector3(-585.62, -1055.82, 22.34), 1, 2.4, {
        name="Uwu_Cafe_Stash",
        heading=0,
        minZ=19.54,
        maxZ=23.54
    })
end)

-- Trays --

exports["fa-polytarget"]:AddCircleZone("uwu_cafe_tray_1", vector3(-583.97, -1059.3, 22.34), 0.4, {
    useZ=true,
})

exports["fa-polytarget"]:AddCircleZone("uwu_cafe_tray_2", vector3(-583.97, -1062.08, 22.34), 0.4, {
    useZ=true,
})

 -- Tray 1
 exports["fa-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_tray_1", {{
    event = "fa-jobs:UwuCafeTray1",
    id = "uwu_cafe_tray_1",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Tray 2
exports["fa-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_tray_2", {{
    event = "fa-jobs:UwuCafeTray2",
    id = "uwu_cafe_tray_2",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-jobs:UwuCafeTray1')
AddEventHandler('fa-jobs:UwuCafeTray1', function()
    TriggerEvent("server-inventory-open", "1", "traysz-Uwu Cafe Tray")
end)

RegisterNetEvent('fa-jobs:UwuCafeTray2')
AddEventHandler('fa-jobs:UwuCafeTray2', function()
    TriggerEvent("server-inventory-open", "1", "trays-Uwu Cafe Tray")
end)

-- Food Warmer --

exports["fa-polytarget"]:AddBoxZone("uwu_cafe_food_warmer", vector3(-587.08, -1059.68, 22.34), 1, 2.8, {
    heading=270,
    --debugPoly=false,
    minZ=19.94,
    maxZ=23.94
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_food_warmer", {{
    event = "fa-jobs:UwuFoodWarmer",
    id = "uwu_cafe_food_warmer",
    icon = "hand-holding",
    label = "Food Warmer",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["fa-interact"]:AddPeekEntryByPolyTarget("uwu_cafe_food_warmer", {{
    event = "fa-dispatch:uwuAlarm",
    id = "uwu_cafe_food_warmer1",
    icon = "bell",
    label = "Alert Police",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-dispatch:uwuAlarm')
AddEventHandler('fa-dispatch:uwuAlarm', function()
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        RPC.execute("dispatch:addCall", "10-31A", "UwU Cafe Panic Alarm", {{icon = "fa-traffic-light", info = "Need Assistance!"}}, {GetEntityCoords(PlayerPedId())[1], GetEntityCoords(PlayerPedId())[2], GetEntityCoords(PlayerPedId())[3]}, 103, 480, 0)
    end
end)

RegisterNetEvent('fa-jobs:UwuFoodWarmer')
AddEventHandler('fa-jobs:UwuFoodWarmer', function()
    TriggerEvent("server-inventory-open", "1", "uwuw-food-warmer")
end)

exports["fa-polytarget"]:AddBoxZone("np_uwu_make_food", vector3(-588.25, -1059.68, 22.36), 1, 2.4, {
    heading=270,
    --debugPoly=false,
    minZ=18.76,
    maxZ=22.76
})

 -- Food Shtuff
 exports["fa-interact"]:AddPeekEntryByPolyTarget("np_uwu_make_food", {{
    event = "fa-jobs:uwuCafeFood",
    id = "np_uwu_make_food",
    icon = "hand-holding",
    label = "Prepare Food",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Drinks --

-- Coffee
-- Booba Milk Tea

-- Bento Boxes

RegisterNetEvent('fa-jobs:uwuCafeFood')
AddEventHandler('fa-jobs:uwuCafeFood', function()
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        local pFoodMaker = {
            {
                title = "Main Dishes",
                description = "Here you can find a list of the main dishes.",
                children = {
                    {
                        title = "Rice Balls",
                        description = "Required Ingridients: 1x Nori | 1x Rice",
                        action = "fa-jobs:uwuMakeRiceBalls"
                    },
                    {
                        title = "Chicken Noodle Soup",
                        description = "Required Ingridients: 1x Noodles | 1x Chicken Breast",
                        action = "fa-jobs:uwuMakeNoodleSoup"
                    },
                    {
                        title = "Doki Doki Pancakes",
                        description = "Required Ingridients: 1x Strawberries | 1x Whipped Cream",
                        action = "fa-jobs:uwuMakePancakes"
                    },
                }
            },
            {
                title = "Deserts",
                description = "Here you can find a list of the deserts.",
                children = {
                    {
                        title = "Chocolate Cake", 
                        description = "Required Ingridients: 1x Chocolate Chips | 1x Flour",
                        action = "fa-jobs:uwuMakeCake"  
                    },
                    {
                        title = "Strawberry Shortcake",
                        description = "Required Ingridients: 1x Strawberries | 1x Flour",
                        action = "fa-jobs:uwuMakeShortcake"  
                    },
                }
            },
            {
                title = "Bento Box",
                description = "Grab a bento box to put the customers food in.",
                action = "fa-jobs:uwuGrabBentoBox"
            },
        }
        exports["fa-interface"]:showContextMenu(pFoodMaker)
    end
end)

RegisterInterfaceCallback('fa-jobs:uwuGrabBentoBox', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('player:receiveItem', 'bentobox', 1)
end)

RegisterInterfaceCallback('fa-jobs:uwuMakeRiceBalls', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        if exports['fa-inventory']:hasEnoughOfItem('rice', 1) and exports['fa-inventory']:hasEnoughOfItem('nori', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local finished = exports['fa-taskbar']:taskBar(5000, 'Preparing Rice Balls...')
            if finished == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'nori', 1)
                TriggerEvent('inventory:removeItem', 'rice', 1)
                TriggerEvent('player:receiveItem', 'riceballs', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('fa-jobs:uwuMakeNoodleSoup', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        if exports['fa-inventory']:hasEnoughOfItem('chickenbreast', 1) and exports['fa-inventory']:hasEnoughOfItem('noodles', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local chickenb = exports['fa-taskbar']:taskBar(2500, 'Preparing Chicken Breast...')
            if chickenb == 100 then
                Citizen.Wait(100)
                TriggerEvent('animation:PlayAnimation', 'cokecut')
                local noodles = exports['fa-taskbar']:taskBar(2500, 'Preparing Noodles')
                if noodles == 100 then
                    Citizen.Wait(100)
                    TriggerEvent('animation:PlayAnimation', 'cokecut')
                    local dish = exports['fa-taskbar']:taskBar(5000, 'Preparing Final Dish...')
                    if dish == 100 then
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerEvent('inventory:removeItem', 'chickenbreast', 1)
                        TriggerEvent('inventory:removeItem', 'noodles', 1)
                        TriggerEvent('player:receiveItem', 'chickennoodlesoup', 1)
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('fa-jobs:uwuMakePancakes', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        if exports['fa-inventory']:hasEnoughOfItem('whippedcream', 1) and exports['fa-inventory']:hasEnoughOfItem('strawberries', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['fa-taskbar']:taskBar(5000, 'Preparing Pancakes...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'whippedcream', 1)
                TriggerEvent('inventory:removeItem', 'strawberries', 1)
                TriggerEvent('player:receiveItem', 'dokidokipancakes', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

--// Deserts //--

RegisterInterfaceCallback('fa-jobs:uwuMakeCake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        if exports['fa-inventory']:hasEnoughOfItem('chocolatechips', 1) and exports['fa-inventory']:hasEnoughOfItem('flour', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['fa-taskbar']:taskBar(5000, 'Preparing Chocolate Cake...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'chocolatechips', 1)
                TriggerEvent('inventory:removeItem', 'flour', 1)
                TriggerEvent('player:receiveItem', 'chocolatecake', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterInterfaceCallback('fa-jobs:uwuMakeShortcake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        if exports['fa-inventory']:hasEnoughOfItem('strawberries', 1) and exports['fa-inventory']:hasEnoughOfItem('flour', 1) then
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'cokecut')
            local dish = exports['fa-taskbar']:taskBar(5000, 'Preparing Short Cake...')
            if dish == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('inventory:removeItem', 'strawberries', 1)
                TriggerEvent('inventory:removeItem', 'flour', 1)
                TriggerEvent('player:receiveItem', 'strawberryshortcake', 1)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

RegisterNetEvent('fa-jobs:uwuCafeFridge', function()
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        TriggerEvent("server-inventory-open", "999", "Shop")
    end
end)

exports["fa-polytarget"]:AddBoxZone("np_uwu_fridge", vector3(-590.96, -1058.51, 22.34), 1, 1, {
    heading=0,
    --debugPoly=false,
    minZ=19.54,
    maxZ=23.54
})

 -- Food Shtuff
 exports["fa-interact"]:AddPeekEntryByPolyTarget("np_uwu_fridge", {{
    event = "fa-jobs:uwuCafeFridge",
    id = "np_uwu_fridge",
    icon = "circle",
    label = "Fridge",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Drinks --

exports["fa-polytarget"]:AddCircleZone("np_uwu_drinks", vector3(-586.95, -1061.92, 22.39), 0.5, {
    useZ=true,
})

 exports["fa-interact"]:AddPeekEntryByPolyTarget("np_uwu_drinks", {{
    event = "fa-jobs:uwuCafeDrinks",
    id = "np_uwu_drinks",
    icon = "circle",
    label = "Drinks",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-jobs:uwuCafeDrinks')
AddEventHandler('fa-jobs:uwuCafeDrinks', function()
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        local pDrinkMachine = {
            {
                title = "Drinks",
                description = "Make a nice refreshing drink for the customer\'s.",
                children = {
                    {
                        title = "Make Bubble Tea",
                        action = "fa-jobs:MakeBubbleTea"
                    },
                    {
                        title = "Make Coffee",
                        action = "fa-jobs:MakeCoffee"
                    },
                    {
                        title = "Make Water",
                        action = "fa-jobs:MakeWater"
                    },
                }
            },
        }
        exports["fa-interface"]:showContextMenu(pDrinkMachine)
    end
end)

RegisterInterfaceCallback('fa-jobs:MakeBubbleTea', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['fa-taskbar']:taskBar(5000, 'Pouring Bubble Tea')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'bubbletea', 1)
        end
    end
end)

RegisterInterfaceCallback('fa-jobs:MakeCoffee', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['fa-taskbar']:taskBar(5000, 'Pouring Coffee')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'coffee', 1)
        end
    end
end)

RegisterInterfaceCallback('fa-jobs:MakeWater', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    if exports['fa-business']:IsEmployedAt('uwu_cafe') then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'cokecut')
        local finished = exports['fa-taskbar']:taskBar(5000, 'Pouring Water')
        if finished == 100 then
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'water', 1)
        end
    end
end)