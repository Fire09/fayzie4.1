RegisterNetEvent('fa-jobs:burgershot-warmer')
AddEventHandler('fa-jobs:burgershot-warmer', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        TriggerEvent("server-inventory-open", "1", "storage-burger_warmer")
        Wait(1000)
    else
        TriggerEvent('DoLongHudText', 'You do not work here !',2)
    end
end)

RegisterNetEvent("fa-burgershot:startfryer")
AddEventHandler("fa-burgershot:startfryer", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('potato', 1) then
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['fa-taskbar']:taskBar(10000, 'Dropping Fries')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'fries', 1)
                TriggerEvent('inventory:removeItem', 'potato', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', "You need more patato's (Required Amount: x1)", 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent("fa-burgershot:makeshake")
AddEventHandler("fa-burgershot:makeshake", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('milk', 1) then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['fa-taskbar']:taskBar(10000, 'Making Shake')
        if (finished == 100) then
            TriggerEvent('inventory:removeItem', 'milk', 1)
            TriggerEvent('player:receiveItem', 'mshake', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"You need milk (Required Amount: x1)",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)


RegisterNetEvent("fa-burgershot:soft-drink")
AddEventHandler("fa-burgershot:soft-drink", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then   
        if exports['fa-inventory']:hasEnoughOfItem('burgershot_cup', 1) then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['fa-taskbar']:taskBar(10000, 'Making Soft Drink')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'softdrink', 1)
            TriggerEvent('inventory:removeItem', 'burgershot_cup', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"Required Ingridients: 1x Sugar | 1x Empty Burgershot Cup",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)

RegisterNetEvent("fa-burgershot:getcola")
AddEventHandler("fa-burgershot:getcola", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then  
        if exports['fa-inventory']:hasEnoughOfItem('sugarbs', 1) then  
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['fa-taskbar']:taskBar(10000, 'Pouring Cola')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'cola', 1)
            TriggerEvent('inventory:removeItem', 'sugarbs', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
            Citizen.Wait(1000)
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText',"You need more sugar (Required Amount: x1)",2)
    end
else
    TriggerEvent('DoLongHudText', 'You dont work here', 2)
end
end)

RegisterNetEvent('fa-burgershot:get_water')
AddEventHandler('fa-burgershot:get_water', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        SetEntityHeading(GetPlayerPed(-1), 121.88976287842)
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports['fa-taskbar']:taskBar(10000, 'Pouring Water')
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'water', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
        else
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

--// Counter

RegisterNetEvent('fa-burgershot:counter')
AddEventHandler('fa-burgershot:counter', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
		TriggerEvent("server-inventory-open", "1", "counter-burger_shot")
		Wait(1000)
else
    TriggerEvent('DoLongHudText', 'You do not work here !',2)
    end
end)

--// Store

RegisterNetEvent('fa-burgershot:store')
AddEventHandler('fa-burgershot:store', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        TriggerEvent("server-inventory-open", "45", "Shop")
		Wait(1000)
    else
        TriggerEvent('DoLongHudText', 'You do not work here !',2)
        end
    end)

--// Make Burgers

RegisterNetEvent('fa-civjobs:burgershot-heartstopper')
AddEventHandler('fa-civjobs:burgershot-heartstopper', function()
    local ped = PlayerPedId()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('burgershotpatty', 2) and exports['fa-inventory']:hasEnoughOfItem('lettuce', 1) and exports['fa-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['fa-inventory']:hasEnoughOfItem('tomato', 1) and exports['fa-inventory']:hasEnoughOfItem('cheese', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local heartstopper = exports['fa-taskbar']:taskBar(5000, 'Cooking Heartstopper')
            if (heartstopper == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1) 
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 2) 
                TriggerEvent('inventory:removeItem', 'lettuce', 1) 
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'heartstopper', 1)
                TriggerEvent('DoLongHudText', 'Cooked Heartstopper', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 2x Cooked Burger Pattys | 1x Lettuce | 1x Tomato | 1x Cheese', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('fa-civjobs:burgershot-moneyshot')
AddEventHandler('fa-civjobs:burgershot-moneyshot', function()
    local ped = PlayerPedId()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['fa-inventory']:hasEnoughOfItem('burgershotpatty', 1) and exports['fa-inventory']:hasEnoughOfItem('lettuce', 1) and exports['fa-inventory']:hasEnoughOfItem('tomato', 1) and exports['fa-inventory']:hasEnoughOfItem('cheese', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local moneyshot = exports['fa-taskbar']:taskBar(5000, 'Cooking Moneyshot')
            if (moneyshot == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 1)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'moneyshot', 1)
                TriggerEvent('DoLongHudText', 'Cooked Moneyshot', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 1x Cooked Burger Patty | 1x Cheese | 1x Lettuce | 1x Tomato', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('fa-civjobs:burgershot-meatfree')
AddEventHandler('fa-civjobs:burgershot-meatfree', function()
    local ped = PlayerPedId()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('burgershotpatty2', 1) and exports['fa-inventory']:hasEnoughOfItem('lettuce', 1) and exports['fa-inventory']:hasEnoughOfItem('hamburgerbuns', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local meatfree = exports['fa-taskbar']:taskBar(5000, 'Cooking Meat Free')
            if (meatfree == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty2', 1)
                TriggerEvent('player:receiveItem', 'meatfree', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Burger Buns | 1x Lettuce | 1x Cooked Meat Free Patty', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)  

RegisterNetEvent('fa-civjobs:burgershot-bleeder')
AddEventHandler('fa-civjobs:burgershot-bleeder', function()
    local ped = PlayerPedId()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports['fa-inventory']:hasEnoughOfItem('hamburgerbuns', 1) and exports['fa-inventory']:hasEnoughOfItem('lettuce', 1) and exports['fa-inventory']:hasEnoughOfItem('burgershotpatty', 1) and exports['fa-inventory']:hasEnoughOfItem('cheese', 1) and exports['fa-inventory']:hasEnoughOfItem('tomato', 1) then
            FreezeEntityPosition(ped, true)
            ExecuteCommand('e cokecut')
            local meatfree = exports['fa-taskbar']:taskBar(5000, 'Cooking Bleeder Burger')
            if (meatfree == 100) then
                FreezeEntityPosition(ped, false)
                TriggerEvent('inventory:removeItem', 'lettuce', 1)
                TriggerEvent('inventory:removeItem', 'hamburgerbuns', 1)
                TriggerEvent('inventory:removeItem', 'burgershotpatty', 1)
                TriggerEvent('inventory:removeItem', 'tomato', 1)
                TriggerEvent('inventory:removeItem', 'cheese', 1)
                TriggerEvent('player:receiveItem', 'bleederburger', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'Requires: 1x Lettuce | 1x Patty | 1x Burger Buns', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)  

-- // Drink Machine Start // --

RegisterNetEvent('fa-jobs:burgershot-drinks')
AddEventHandler('fa-jobs:burgershot-drinks', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotDrinks = {
            {
                title = 'Burger Shot Drinks',
                icon = "glass-whiskey"
            },
            {
                title = "Pour Cola",
                description = "Pour a nice refreshing Cola",
                icon = "beer",
                action = 'fa-burgershot:cola',
            },
            {
                title = "Pour Milkshake",
                description = "Pour a Ice Cold Milkshake",
                icon = "beer",
                action = 'fa-burgershot:shake',
            },
            {
                title = "Pour Soft Drink",
                description = "Pour a monsterous sweet Soft Drink",
                icon = "beer",
                action = 'fa-burgershot:drink',
            },
            {
                title = "Pour Cup Of Water",
                description = "Pour a Cup Of Water",
                icon = "beer",
                action = 'fa-burgershot:water',
            },
        }
        exports["fa-interface"]:showContextMenu(BurgershotDrinks)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('fa-burgershot:cola', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:getcola')
end)

RegisterInterfaceCallback('fa-burgershot:shake', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:makeshake')
end)

RegisterInterfaceCallback('fa-burgershot:drink', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:soft-drink')
end)

RegisterInterfaceCallback('fa-burgershot:water', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:get_water')
end)

-- // Drink Machine End // --

-- // Start Of Burgers // --

RegisterNetEvent('fa-civjobs:burgershot-make-burgers')
AddEventHandler('fa-civjobs:burgershot-make-burgers', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotBurgers = {
            {
                title = 'Burger Shot Burgers',
                icon = "utensils"
            },
            {
                title = "Assemble Heartstopper",
                icon = "hamburger", 
                action = 'fa-burgershot:hs',
            },
            {
                title = "Assemble Moneyshot",
                icon = "hamburger", 
                action = 'fa-burgershot:ms',
            },
            {
                title = "Assemble Meat Free Burger",
                icon = "hamburger", 
                action = 'fa-burgershot:mf',
            },
            {
                title = "Assemble Bleeder Burger",
                icon = "hamburger", 
                action = 'fa-burgershot:bb',
            },
        }
        exports["fa-interface"]:showContextMenu(BurgershotBurgers)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('fa-burgershot:hs', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-civjobs:burgershot-heartstopper')
end)

RegisterInterfaceCallback('fa-burgershot:ms', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-civjobs:burgershot-moneyshot')
end)

RegisterInterfaceCallback('fa-burgershot:mf', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-civjobs:burgershot-meatfree')
end)

RegisterInterfaceCallback('fa-burgershot:bb', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-civjobs:burgershot-bleeder')
end)

--// Meat No Meat?

RegisterNetEvent('fa-civjobs:burgershot-make-pattys')
AddEventHandler('fa-civjobs:burgershot-make-pattys', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        local BurgershotPattys = {
            {
                title = 'Burger Shot Pattys',
            },
            {
                title = "Cook Patty (Contains Meat)",
                description = "Requires: 1x Raw Patty (Contains Meat)",
                key = "CP.M",
                action = 'fa-burgershot:cm',
            },
            {
                title = "Cook Patty (Doesnt Contain Meat)",
                description = "Requires: 1x Raw Patty (Doesnt Contain Meat)",
                key = "CP.NM",
                action = 'fa-burgershot:dcm',
            },
        }
        exports["fa-interface"]:showContextMenu(BurgershotPattys)
    else
        TriggerEvent('DoLongHudText', 'Fuck off POLITELY', 2)
    end
end)

RegisterInterfaceCallback('fa-burgershot:cm', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:contains-meat')
end)

RegisterInterfaceCallback('fa-burgershot:dcm', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-burgershot:doesnt-contains-meat')
end)

RegisterNetEvent("fa-burgershot:contains-meat")
AddEventHandler("fa-burgershot:contains-meat", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports["fa-inventory"]:hasEnoughOfItem("rawpatty", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['fa-taskbar']:taskBar(7500, 'Cooking Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty", 1)
                TriggerEvent('player:receiveItem', 'burgershotpatty', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Raw Pattys to cook! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent("fa-burgershot:doesnt-contains-meat")
AddEventHandler("fa-burgershot:doesnt-contains-meat", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then   
        if exports["fa-inventory"]:hasEnoughOfItem("rawpatty2", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['fa-taskbar']:taskBar(7500, 'Cooking Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty2", 1)
                TriggerEvent('player:receiveItem', 'burgershotpatty2', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Raw Pattys to cook! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('fa-burgershot:gettoy')
AddEventHandler('fa-burgershot:gettoy', function()
    local BurgershotToy = math.random(10)
    if BurgershotToy == 1 then
        TriggerEvent('player:receiveItem', 'larrybirdtoy', 1)
    elseif BurgershotToy == 2 then
        TriggerEvent('player:receiveItem', 'tatumtoy', 1)
    elseif BurgershotToy == 3 then
        TriggerEvent('player:receiveItem', 'klaytoy', 1)
    elseif BurgershotToy == 4 then
        TriggerEvent('player:receiveItem', 'currytoy', 1)
    elseif BurgershotToy == 5 then
        TriggerEvent('player:receiveItem', 'strangetoy', 1)
    elseif BurgershotToy == 6 then
        TriggerEvent('player:receiveItem', 'woodytoy', 1)
    elseif BurgershotToy == 7 then
        TriggerEvent('player:receiveItem', 'joinwicktoy', 1)
    elseif BurgershotToy == 8 then
        TriggerEvent('player:receiveItem', 'eletoy', 1)
    elseif BurgershotToy == 9 then
        TriggerEvent('player:receiveItem', 'captoy', 1)
    elseif BurgershotToy == 10 then
        TriggerEvent('player:receiveItem', 'supermantoy', 1)
    end
end)

RegisterNetEvent("fa-icecream")
AddEventHandler("fa-icecream", function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("burger_shot")
    if isEmployed then
        if exports["fa-inventory"]:hasEnoughOfItem("icecreamcone", 1) then 
            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 302.72439575195)
            local finished = exports['fa-taskbar']:taskBar(7500, 'Scooping')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "icecreamcone", 1)
                TriggerEvent('player:receiveItem', 'vanillaicecream', 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more Ice Cream Cone!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You dont work here', 2)
    end
end)

RegisterNetEvent('grabtoybs')
AddEventHandler('grabtoybs', function()
    TriggerEvent('player:receiveItem', 'bstoy', 1)
end)

 -- Interact --
 
 exports["fa-polytarget"]:AddBoxZone("burgershot_assemble", vector3(-1197.3, -898.32, 13.97), 0.8, 3.2, {
    heading=34,
    minZ=9.97,
    maxZ=13.97
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_assemble", {{
    event = "fa-civjobs:burgershot-make-burgers",
    id = "burgershot_assemble",
    icon = "hand-holding",
    label = "Assemble Burger",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddBoxZone("burgershot_stash", vector3(-1199.87, -903.93, 13.97), 1.55, 0.8, {
    heading=35,
    --debugPoly=false,
    minZ=9.97,
    maxZ=13.97
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_stash", {
    {
        event = "fa-burgershot:store",
        id = "burgershot_stash",
        icon = "circle",
        label = "Get Ingridients",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddBoxZone("np_burgershot_make_drinks", vector3(-1197.0, -895.05, 13.97), 0.6, 0.85, {
    heading=304,
    minZ=10.77,
    maxZ=14.77
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("np_burgershot_make_drinks", {{
    event = "fa-jobs:burgershot-drinks",
    id = "np_burgershot_make_drinks",
    icon = "circle",
    label = "Drink Machine",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddBoxZone("burgershot_warmer",  vector3(-1195.37, -897.63, 13.97), 3.15, 0.8, {
    minZ=10.72,
    maxZ=14.72
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_warmer", {
    {
        event = "fa-jobs:burgershot-warmer",
        id = "void_burgershot_warmer",
        icon = "circle",
        label = "Food Warmer",
        parameters = {},
    },
    {
        event = "fa-dispatch:burgershotAlarm",
        id = "Panic",
        icon = "bell",
        label = "Panic Button",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-dispatch:burgershotAlarm')
AddEventHandler('fa-dispatch:burgershotAlarm', function()
    if exports['fa-business']:IsEmployedAt('burger_shot') then
        RPC.execute("dispatch:addCall", "10-31A", "Burgershot Panic Alarm", {{icon = "fa-traffic-light", info = "Need Assistance!"}}, {GetEntityCoords(PlayerPedId())[1], GetEntityCoords(PlayerPedId())[2], GetEntityCoords(PlayerPedId())[3]}, 103, 480, 0)
    end
end)

exports["fa-polytarget"]:AddCircleZone("burgershot_fryer",  vector3(-1200.82, -896.99, 13.85), 0.81, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_fryer", {{
    event = "fa-burgershot:startfryer",
    id = "burgershot_fryer",
    icon = "circle",
    label = "Make Fries",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddBoxZone("burgershot_stash", vector3(-1201.49, -901.77, 13.97), 4.0, 1.0, {
    heading=34,
    --debugPoly=false,
    minZ=11.27,
    maxZ=15.27
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_stash", {
    {
        event = "fa-burgershot:store",
        id = "burgershot_stash",
        icon = "circle",
        label = "Get Ingridients",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddCircleZone("burgershot_stuffs_4",  vector3(-1198.11, -895.24, 13.82), 0.79, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("burgershot_stuffs_4", {{
    event = "fa-civjobs:burgershot-make-pattys",
    id = "burgershot_stuffs_4",
    icon = "hamburger",
    label = "Grill Patty",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddCircleZone("gettoybs",  vector3(-1194.94, -897.35, 13.97), 0.26, {
    useZ = true
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("gettoybs", {
    {
        event = "grabtoybs",
        id = "gettoybs",
        icon = "circle",
        label = "Grab Toy!",
        parameters = {},
    },
}, {
    distance = { radius = 2.5 },
});

exports["fa-polytarget"]:AddBoxZone("icecreamspot",  vector3(-1197.63, -893.85, 13.97), 0.45, 0.8, {
    heading=35,
    --debugPoly=false,
    minZ=11.02,
    maxZ=15.02
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("icecreamspot", {
    {
        event = "fa-icecream",
        id = "icecreamspot",
        icon = "circle",
        label = "Scoop Ice Cream!",
        parameters = {},
    },
}, {
    distance = { radius = 5 },
});

-- Trays --

exports["fa-polytarget"]:AddBoxZone("burger_shot_tray_1", vector3(-1194.42, -893.9, 13.97), 1, 0.6, {
    heading=34,
    minZ=10.02,
    maxZ=14.22
})

exports["fa-polytarget"]:AddBoxZone("burger_shot_tray_2", vector3(-1193.42, -895.39, 13.97), 1, 0.6, {
    heading=34,
    minZ=10.02,
    maxZ=14.22
})

 -- Tray 1
 exports["fa-interact"]:AddPeekEntryByPolyTarget("burger_shot_tray_1", {{
    event = "fa-jobs:BurgerShotTray-1",
    id = "burger_shot_tray_1",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

-- Tray 2
exports["fa-interact"]:AddPeekEntryByPolyTarget("burger_shot_tray_2", {{
    event = "fa-jobs:BurgerShotTray-2",
    id = "burger_shot_tray_2",
    icon = "hand-holding",
    label = "Open",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('fa-jobs:BurgerShotTray-1')
AddEventHandler('fa-jobs:BurgerShotTray-1', function()
    TriggerEvent("server-inventory-open", "1", "trays-Burgershot Tray")
end)

RegisterNetEvent('fa-jobs:BurgerShotTray-2')
AddEventHandler('fa-jobs:BurgerShotTray-2', function()
    TriggerEvent("server-inventory-open", "1", "trays-Burgershot Tray")
end)