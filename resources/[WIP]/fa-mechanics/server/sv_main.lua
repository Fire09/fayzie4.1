local MenuData = {}

RPC.register("fa-bennys:getOrderData", function(src, data, vehClass, pOrder, vehType)
    MenuData = {
        {
            title = "Benny's Order",
            description = "Order ID: " .. pOrder .. " | Vehicle: " .. tostring(vehType),
        }
    }

    local cosmMenu = setupCosmetics(data)
    local performMenu = setupPerformance(data.mods)
    local resprayMenu = setupRespray(data)
    
    if cosmMenu then
        table.insert(MenuData, cosmMenu)
    end
    if performMenu then
        table.insert(MenuData, performMenu)
    end
    if resprayMenu then
        table.insert(MenuData, resprayMenu)
    end

    return MenuData
end)


function setupCosmetics(mods)
    local Cosmetic = {
        title = "Cosmetic",
        children = {},
    }
    
    if mods.tint ~= (-2) then    
        table.insert(Cosmetic.children, 
            {
                title = "Vehicle Window Tint",
                description = "Price: $375 | Stock: 0",
                action = "fa-mechanics:order:view",
                key = mods.tint,
            }
        )
    end

    if mods.platestyle ~= (-2) then    
        table.insert(Cosmetic.children, 
            {
                title = "Vehicle Plate Styling",
                description = "Price: $450 | Stock: 0",
                action = "fa-mechanics:order:view",
                key = mods.platestyle,
            }
        )
    end

    if mods.xenonColor ~= (-2) then    
        table.insert(Cosmetic.children, 
            {
                title = "Vehicle Xenon Bulb",
                description = "Price: $338 | Stock: 0",
                action = "fa-mechanics:order:view",
                key = mods.xenonColor,
            }
        )
    end

    if mods.lights then  
        if mods.lights ~= (-2) then    
            table.insert(Cosmetic.children, 
                {
                    title = "Vehicle Neon Color",
                    description = "Price: $338 | Stock: 0",
                    action = "fa-mechanics:order:view",
                    key = mods.lights,
                }
            )
        end
    end

    if mods.neon then
        if mods.neon["0"] ~= 0 or mods.neon["1"] ~= 0 or mods.neon["2"] ~= 0 or mods.neon["3"] ~= false then    
            table.insert(Cosmetic.children, 
                {
                    title = "Vehicle Neon Color",
                    description = "Price: $563 | Stock: 0",
                    action = "fa-mechanics:order:view",
                    key = mods.neon,
                }
            )
        end
    end

    if mods.xenonColor ~= (-2) then    
        table.insert(Cosmetic.children, 
            {
                title = "Vehicle Xenon Headlights",
                description = "Price: $938 | Stock: 0",
                action = "fa-mechanics:order:view",
                key = mods.xenonColor,
            }
        )
    end

    if Cosmetic.children[1] ~= nil then
        return Cosmetic
    end
end

function setupRespray(data)
    local Respray = {
        title = "Respray",
        children = {},
    }

    if data.colors then
        if data.colors[1] ~= 0 then    
            table.insert(Respray.children, 
                {
                    title = "Vehicle Primary Color Respray",
                    description = "Price: $600 | Stock: 9999",
                    action = "fa-mechanics:order:view",
                    key = data.colors[1]
                }
            )
        end
        if data.colors[2] ~= 0 then    
            table.insert(Respray.children, 
                {
                    title = "Vehicle Secondary Color Respray",
                    description = "Price: $600 | Stock: 9999",
                    action = "fa-mechanics:order:view",
                    key = data.colors[2]
                }
            )
        end
    end

    if data.dashColour ~= (-2) then    
        table.insert(Respray.children, 
            {
                title = "Vehicle Dashboard Color",
                description = "Price: $600 | Stock: 9999",
                action = "fa-mechanics:order:view",
                key = data.dashColour
            }
        )
    end
    if data.interColour ~= (-2) then    
        table.insert(Respray.children, 
            {
                title = "Vehicle Interior Color",
                description = "Price: $600 | Stock: 9999",
                action = "fa-mechanics:order:view",
                key = data.interColour
            }
        )
    end

    if data.extracolors then
        if data.extracolors[1] ~= 0 or data.extracolors[2] ~= 0 then    
            table.insert(Respray.children, 
                {
                    title = "Vehicle Pearlescent Finish",
                    description = "Price: $600 | Stock: 9999",
                    action = "fa-mechanics:order:view",
                    key = data.extracolors
                }
            )
        end
    end

    if data.wheeltype ~= (-2) then    
        table.insert(Respray.children, 
            {
                title = "Vehicle Wheel Finish",
                description = "Price: $600 | Stock: 9999",
                action = "fa-mechanics:order:view",
                key = data.wheeltype
            }
        )
    end

    if Respray.children[1] ~= nil then
        return Respray
    end
end

function setupPerformance(mods)
    local Mods = {
        title = "Performance",
        children = {},
    }

    if (mods) then
        if mods["11"] ~= (-2) then    
            table.insert(Mods.children, 
                {
                    title = "Vehicle Engine Upgrade",
                    description = "Price: $12000 | Stock: 2454",
                    action = "fa-mechanics:order:view",
                    key = mods["11"],
                }
            )
        end
        if mods["12"] ~= (-2) then    
            table.insert(Mods.children, 
                {
                    title = "Vehicle Brakes Upgrade",
                    description = "Price: $12000 | Stock: 2454",
                    action = "fa-mechanics:order:view",
                    key = mods["12"],
                }
            )
        end
        if mods["13"] ~= (-2) then    
            table.insert(Mods.children, 
                {
                    title = "Vehicle Transmission Upgrade",
                    description = "Price: $12000 | Stock: 2454",
                    action = "fa-mechanics:order:view",
                    key = mods["13"],
                }
            )
        end
        if mods["15"] ~= (-2) then    
            table.insert(Mods.children, 
                {
                    title = "Vehicle Suspension Upgrade",
                    description = "Price: $12000 | Stock: 2454",
                    action = "fa-mechanics:order:view",
                    key = mods["15"],
                }
            )
        end
        if mods["18"] ~= (-2) then    
            table.insert(Mods.children, 
                {
                    title = "Vehicle Turbo Upgrade",
                    description = "Price: $12000 | Stock: 2454",
                    action = "fa-mechanics:order:view",
                    key = mods["18"],
                }
            )
        end

        if Mods.children[1] ~= nil then
            return Mods
        end
    end
end