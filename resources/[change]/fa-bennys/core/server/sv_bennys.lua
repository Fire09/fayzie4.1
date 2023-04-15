Bennys = {}
local PartsCatalog = {}
-- local PriceModifiers = {}

local PriceModifiers = {
    default = 3.0,
    ["X"] = {
        rating = 1200,
        ["category"] = {
            ["Turbo Upgrade"] = 5.5,
            ["Spoiler"] = 5.5,
            ["Horns"] = 5.5,
            ["Engine Upgrade"] = 5.5,
            ["Brake Upgrade"] = 5.5,
            ["Transmission Upgrade"] = 5.5,
            ["Suspension Upgrade"] = 5.5,
            ["Front Bumper"] = 5.5,
            ["Rear Bumper"] = 5.5,
            ["Side Skirt"] = 5.5,
            ["Exhaust"] = 5.5,
            ["Roll Cage"] = 5.5,
            ["Grille"] = 5.5,
            ["Hood"] = 5.5,
            ["Left Fender"] = 5.5,
            ["Right Fender"] = 5.5,
            ["Window Tint"] = 5.5,
            ["plateIndex"] = 5.5,
            ["Neons"] = 5.5,
            ["Primary Color"] = 5.5,
            ["Neon Color"] = 5.5,
            ["Headlights"] = 5.5,
            ["Xenon Colour"] = 5.5,
            ["Wheels"] = 5.5,
            ["Dashboard Color"] = 5.5,
            ["Interior Color"] = 5.5,
            ["Roof"] = 5.5,
            ["Ornaments"] = 5.5,
            ["Dashboard"] = 5.5,
            ["Dial"] = 5.5,
            ["Trunk"] = 5.5,
            ["Speaker"] = 5.5,
            ["Plaque"] = 5.5,
            ["Arch Cover"] = 5.5,
            ["Aerial"] = 5.5,
            ["Trim A"] = 5.5,
            ["Trim B"] = 5.5,
            ["Fuel Tank"] = 5.5,
            ["Livery"] = 5.5,
            ["Seats"] = 5.5,
            ["Windows"] = 5.5,
            ["Plate Index"] = 5.5,
            ["Shifter Leaver"] = 5.5,
            ["Steering Wheel"] = 5.5,
            ["Hydraulics"] = 5.5,
            ["Engine Block"] = 5.5,
            ["Door Speaker"] = 5.5,
            ["Air Filter"] = 5.5,
            ["UNK47"] = 5.5,
            ["Plate Holder"] = 5.5,
            ["Primary Colour"] = 5.5,
            ["Secondary Colour"] = 5.5,
            ["Pearlescent Colour"] = 5.5,
            ["Wheel Colour"] = 5.5,
            ["Dashboard Colour"] = 5.5,
            ["Interior Colour"] = 5.5,
        },
    },
    ["S"] = {
        rating = 900,
        ["category"] = {
            ["Turbo Upgrade"] = 5.0,
            ["Spoiler"] = 5.0,
            ["Horns"] = 5.0,
            ["Engine Upgrade"] = 5.0,
            ["Brake Upgrade"] = 5.0,
            ["Transmission Upgrade"] = 5.0,
            ["Suspension Upgrade"] = 5.0,
            ["Front Bumper"] = 5.0,
            ["Rear Bumper"] = 5.0,
            ["Side Skirt"] = 5.0,
            ["Exhaust"] = 5.0,
            ["Roll Cage"] = 5.0,
            ["Grille"] = 5.0,
            ["Hood"] = 5.0,
            ["Left Fender"] = 5.0,
            ["Right Fender"] = 5.0,
            ["Window Tint"] = 5.0,
            ["plateIndex"] = 5.0,
            ["Neons"] = 5.0,
            ["Primary Color"] = 5.0,
            ["Neon Color"] = 5.0,
            ["Headlights"] = 5.0,
            ["Xenon Colour"] = 5.0,
            ["Wheels"] = 5.0,
            ["Dashboard Color"] = 5.0,
            ["Interior Color"] = 5.0,
            ["Roof"] = 5.0,
            ["Ornaments"] = 5.0,
            ["Dashboard"] = 5.0,
            ["Dial"] = 5.0,
            ["Trunk"] = 5.0,
            ["Speaker"] = 5.0,
            ["Plaque"] = 5.0,
            ["Arch Cover"] = 5.0,
            ["Aerial"] = 5.0,
            ["Trim A"] = 5.0,
            ["Trim B"] = 5.0,
            ["Fuel Tank"] = 5.0,
            ["Livery"] = 5.0,
            ["Seats"] = 5.0,
            ["Windows"] = 5.0,
            ["Plate Index"] = 5.0,
            ["Shifter Leaver"] = 5.0,
            ["Steering Wheel"] = 5.0,
            ["Hydraulics"] = 5.0,
            ["Engine Block"] = 5.0,
            ["Door Speaker"] = 5.0,
            ["Air Filter"] = 5.0,
            ["UNK47"] = 5.0,
            ["Plate Holder"] = 5.0,
            ["Primary Colour"] = 5.0,
            ["Secondary Colour"] = 5.0,
            ["Pearlescent Colour"] = 5.0,
            ["Wheel Colour"] = 5.0,
            ["Dashboard Colour"] = 5.0,
            ["Interior Colour"] = 5.0,
        },
    },
    ["A"] = {
        rating = 600,
        ["category"] = {
            ["Turbo Upgrade"] = 4.5,
            ["Spoiler"] = 4.5,
            ["Horns"] = 4.5,
            ["Engine Upgrade"] = 4.5,
            ["Brake Upgrade"] = 4.5,
            ["Transmission Upgrade"] = 4.5,
            ["Suspension Upgrade"] = 4.5,
            ["Front Bumper"] = 4.5,
            ["Rear Bumper"] = 4.5,
            ["Side Skirt"] = 4.5,
            ["Exhaust"] = 4.5,
            ["Roll Cage"] = 4.5,
            ["Grille"] = 4.5,
            ["Hood"] = 4.5,
            ["Left Fender"] = 4.5,
            ["Right Fender"] = 4.5,
            ["Window Tint"] = 4.5,
            ["plateIndex"] = 4.5,
            ["Neons"] = 4.5,
            ["Primary Color"] = 4.5,
            ["Neon Color"] = 4.5,
            ["Headlights"] = 4.5,
            ["Xenon Colour"] = 4.5,
            ["Wheels"] = 4.5,
            ["Dashboard Color"] = 4.5,
            ["Interior Color"] = 4.5,
            ["Roof"] = 4.5,
            ["Ornaments"] = 4.5,
            ["Dashboard"] = 4.5,
            ["Dial"] = 4.5,
            ["Trunk"] = 4.5,
            ["Speaker"] = 4.5,
            ["Plaque"] = 4.5,
            ["Arch Cover"] = 4.5,
            ["Aerial"] = 4.5,
            ["Trim A"] = 4.5,
            ["Trim B"] = 4.5,
            ["Fuel Tank"] = 4.5,
            ["Livery"] = 4.5,
            ["Seats"] = 4.5,
            ["Windows"] = 4.5,
            ["Plate Index"] = 4.5,
            ["Shifter Leaver"] = 4.5,
            ["Steering Wheel"] = 4.5,
            ["Hydraulics"] = 4.5,
            ["Engine Block"] = 4.5,
            ["Door Speaker"] = 4.5,
            ["Air Filter"] = 4.5,
            ["UNK47"] = 4.5,
            ["Plate Holder"] = 4.5,
            ["Primary Colour"] = 4.5,
            ["Secondary Colour"] = 4.5,
            ["Pearlescent Colour"] = 4.5,
            ["Wheel Colour"] = 4.5,
            ["Dashboard Colour"] = 4.5,
            ["Interior Colour"] = 4.5,
        },
    },
    ["B"] = {
        rating = 500,
        ["category"] = {
            ["Turbo Upgrade"] = 4.0,
            ["Spoiler"] = 4.0,
            ["Horns"] = 4.0,
            ["Engine Upgrade"] = 4.0,
            ["Brake Upgrade"] = 4.0,
            ["Transmission Upgrade"] = 4.0,
            ["Suspension Upgrade"] = 4.0,
            ["Front Bumper"] = 4.0,
            ["Rear Bumper"] = 4.0,
            ["Side Skirt"] = 4.0,
            ["Exhaust"] = 4.0,
            ["Roll Cage"] = 4.0,
            ["Grille"] = 4.0,
            ["Hood"] = 4.0,
            ["Left Fender"] = 4.0,
            ["Right Fender"] = 4.0,
            ["Window Tint"] = 4.0,
            ["plateIndex"] = 4.0,
            ["Neons"] = 4.0,
            ["Primary Color"] = 4.0,
            ["Neon Color"] = 4.0,
            ["Headlights"] = 4.0,
            ["Xenon Colour"] = 4.0,
            ["Wheels"] = 4.0,
            ["Dashboard Color"] = 4.0,
            ["Interior Color"] = 4.0,
            ["Roof"] = 4.0,
            ["Ornaments"] = 4.0,
            ["Dashboard"] = 4.0,
            ["Dial"] = 4.0,
            ["Trunk"] = 4.0,
            ["Speaker"] = 4.0,
            ["Plaque"] = 4.0,
            ["Arch Cover"] = 4.0,
            ["Aerial"] = 4.0,
            ["Trim A"] = 4.0,
            ["Trim B"] = 4.0,
            ["Fuel Tank"] = 4.0,
            ["Livery"] = 4.0,
            ["Seats"] = 4.0,
            ["Windows"] = 4.0,
            ["Plate Index"] = 4.0,
            ["Shifter Leaver"] = 4.0,
            ["Steering Wheel"] = 4.0,
            ["Hydraulics"] = 4.0,
            ["Engine Block"] = 4.0,
            ["Door Speaker"] = 4.0,
            ["Air Filter"] = 4.0,
            ["UNK47"] = 4.0,
            ["Plate Holder"] = 4.0,
            ["Primary Colour"] = 4.0,
            ["Secondary Colour"] = 4.0,
            ["Pearlescent Colour"] = 4.0,
            ["Wheel Colour"] = 4.0,
            ["Dashboard Colour"] = 4.0,
            ["Interior Colour"] = 4.0,
        },
    },
    ["C"] = {
        rating = 400,
        ["category"] = {
            ["Turbo Upgrade"] = 3.5,
            ["Spoiler"] = 3.5,
            ["Horns"] = 3.5,
            ["Engine Upgrade"] = 3.5,
            ["Brake Upgrade"] = 3.5,
            ["Transmission Upgrade"] = 3.5,
            ["Suspension Upgrade"] = 3.5,
            ["Front Bumper"] = 3.5,
            ["Rear Bumper"] = 3.5,
            ["Side Skirt"] = 3.5,
            ["Exhaust"] = 3.5,
            ["Roll Cage"] = 3.5,
            ["Grille"] = 3.5,
            ["Hood"] = 3.5,
            ["Left Fender"] = 3.5,
            ["Right Fender"] = 3.5,
            ["Window Tint"] = 3.5,
            ["plateIndex"] = 3.5,
            ["Neons"] = 3.5,
            ["Primary Color"] = 3.5,
            ["Neon Color"] = 3.5,
            ["Headlights"] = 3.5,
            ["Xenon Colour"] = 3.5,
            ["Wheels"] = 3.5,
            ["Dashboard Color"] = 3.5,
            ["Interior Color"] = 3.5,
            ["Roof"] = 3.5,
            ["Ornaments"] = 3.5,
            ["Dashboard"] = 3.5,
            ["Dial"] = 3.5,
            ["Trunk"] = 3.5,
            ["Speaker"] = 3.5,
            ["Plaque"] = 3.5,
            ["Arch Cover"] = 3.5,
            ["Aerial"] = 3.5,
            ["Trim A"] = 3.5,
            ["Trim B"] = 3.5,
            ["Fuel Tank"] = 3.5,
            ["Livery"] = 3.5,
            ["Seats"] = 3.5,
            ["Windows"] = 3.5,
            ["Plate Index"] = 3.5,
            ["Shifter Leaver"] = 3.5,
            ["Steering Wheel"] = 3.5,
            ["Hydraulics"] = 3.5,
            ["Engine Block"] = 3.5,
            ["Door Speaker"] = 3.5,
            ["Air Filter"] = 3.5,
            ["UNK47"] = 3.5,
            ["Plate Holder"] = 3.5,
            ["Primary Colour"] = 3.5,
            ["Secondary Colour"] = 3.5,
            ["Pearlescent Colour"] = 3.5,
            ["Wheel Colour"] = 3.5,
            ["Dashboard Colour"] = 3.5,
            ["Interior Colour"] = 3.5,
        },
    },
    ["D"] = {
        rating = 300,
        ["category"] = {
            ["Turbo Upgrade"] = 3.0,
            ["Spoiler"] = 3.0,
            ["Horns"] = 3.0,
            ["Engine Upgrade"] = 3.0,
            ["Brake Upgrade"] = 3.0,
            ["Transmission Upgrade"] = 3.0,
            ["Suspension Upgrade"] = 3.0,
            ["Front Bumper"] = 3.0,
            ["Rear Bumper"] = 3.0,
            ["Side Skirt"] = 3.0,
            ["Exhaust"] = 3.0,
            ["Roll Cage"] = 3.0,
            ["Grille"] = 3.0,
            ["Hood"] = 3.0,
            ["Left Fender"] = 3.0,
            ["Right Fender"] = 3.0,
            ["Window Tint"] = 3.0,
            ["plateIndex"] = 3.0,
            ["Neons"] = 3.0,
            ["Primary Color"] = 3.0,
            ["Neon Color"] = 3.0,
            ["Headlights"] = 3.0,
            ["Xenon Colour"] = 3.0,
            ["Wheels"] = 3.0,
            ["Dashboard Color"] = 3.0,
            ["Interior Color"] = 3.0,
            ["Roof"] = 3.0,
            ["Ornaments"] = 3.0,
            ["Dashboard"] = 3.0,
            ["Dial"] = 3.0,
            ["Trunk"] = 3.0,
            ["Speaker"] = 3.0,
            ["Plaque"] = 3.0,
            ["Arch Cover"] = 3.0,
            ["Aerial"] = 3.0,
            ["Trim A"] = 3.0,
            ["Trim B"] = 3.0,
            ["Fuel Tank"] = 3.0,
            ["Livery"] = 3.0,
            ["Seats"] = 3.0,
            ["Windows"] = 3.0,
            ["Plate Index"] = 3.0,
            ["Shifter Leaver"] = 3.0,
            ["Steering Wheel"] = 3.0,
            ["Hydraulics"] = 3.0,
            ["Engine Block"] = 3.0,
            ["Door Speaker"] = 3.0,
            ["Air Filter"] = 3.0,
            ["UNK47"] = 3.0,
            ["Plate Holder"] = 3.0,
            ["Primary Colour"] = 3.0,
            ["Secondary Colour"] = 3.0,
            ["Pearlescent Colour"] = 3.0,
            ["Wheel Colour"] = 3.0,
            ["Dashboard Colour"] = 3.0,
            ["Interior Colour"] = 3.0,
        },
    },
    ["M"] = {
        rating = 2.5,
        ["category"] = {
            ["Turbo Upgrade"] = 2.5,
            ["Spoiler"] = 2.5,
            ["Horns"] = 2.5,
            ["Engine Upgrade"] = 2.5,
            ["Brake Upgrade"] = 2.5,
            ["Transmission Upgrade"] = 2.5,
            ["Suspension Upgrade"] = 2.5,
            ["Front Bumper"] = 2.5,
            ["Rear Bumper"] = 2.5,
            ["Side Skirt"] = 2.5,
            ["Exhaust"] = 2.5,
            ["Roll Cage"] = 2.5,
            ["Grille"] = 2.5,
            ["Hood"] = 2.5,
            ["Left Fender"] = 2.5,
            ["Right Fender"] = 2.5,
            ["Window Tint"] = 2.5,
            ["plateIndex"] = 2.5,
            ["Neons"] = 2.5,
            ["Primary Color"] = 2.5,
            ["Neon Color"] = 2.5,
            ["Headlights"] = 2.5,
            ["Xenon Colour"] = 2.5,
            ["Wheels"] = 2.5,
            ["Dashboard Color"] = 2.5,
            ["Interior Color"] = 2.5,
            ["Roof"] = 2.5,
            ["Ornaments"] = 2.5,
            ["Dashboard"] = 2.5,
            ["Dial"] = 2.5,
            ["Trunk"] = 2.5,
            ["Speaker"] = 2.5,
            ["Plaque"] = 2.5,
            ["Arch Cover"] = 2.5,
            ["Aerial"] = 2.5,
            ["Trim A"] = 2.5,
            ["Trim B"] = 2.5,
            ["Fuel Tank"] = 2.5,
            ["Livery"] = 2.5,
            ["Seats"] = 2.5,
            ["Windows"] = 2.5,
            ["Plate Index"] = 2.5,
            ["Shifter Leaver"] = 2.5,
            ["Steering Wheel"] = 2.5,
            ["Hydraulics"] = 2.5,
            ["Engine Block"] = 2.5,
            ["Door Speaker"] = 2.5,
            ["Air Filter"] = 2.5,
            ["UNK47"] = 2.5,
            ["Plate Holder"] = 2.5,
            ["Primary Colour"] = 2.5,
            ["Secondary Colour"] = 2.5,
            ["Pearlescent Colour"] = 2.5,
            ["Wheel Colour"] = 2.5,
            ["Dashboard Colour"] = 2.5,
            ["Interior Colour"] = 2.5,
        },
    },
}

RegisterServerEvent('fa-bennys:attemptPurchase')
AddEventHandler('fa-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local Cash = user:getCash() 
    if type == "repair" then
        if Cash >= vehicleBaseRepairCost then
            user:removeMoney(tonumber(vehicleCustomisationPrices[type].price))
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if Cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            user:removeMoney(tonumber(vehicleCustomisationPrices[type].prices[upgradeLevel]))
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    else
        if Cash >= vehicleCustomisationPrices[type].price then
            user:removeMoney(tonumber(vehicleCustomisationPrices[type].price))
            TriggerClientEvent('fa-bennys:purchaseSuccessful', src)
        else
            TriggerClientEvent('fa-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('fa-bennys:updateRepairCost')
AddEventHandler('fa-bennys:updateRepairCost', function(cost)
    vehicleBaseRepairCost = cost
end)

RegisterServerEvent('fa-bennys:removeFromInUse')
AddEventHandler('fa-bennys:removeFromInUse', function(currentBennys)
    Bennys[currentBennys] = nil
end)

RegisterServerEvent('fa-bennys:addToInUse')
AddEventHandler('fa-bennys:addToInUse', function(currentBennys)
    Bennys[currentBennys] = true
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods, pVin)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local mods = vehicleMods.mods
    local appearance = vehicleMods

    if not user then return end

    local owner = MySQL.query.await([[
        SELECT * 
        FROM characters_cars
        WHERE vin = ?
    ]],
    { pVin })

    if not owner.vin then return end

    if owner then
        local update = MySQL.update.await([[
            UPDATE characters_cars
            SET mods = ?, appearance = ?
            WHERE vin = ?
        ]],
        { json.encode(mods), json.encode(appearance), pVin })
    end
end)

RegisterServerEvent('fa-bennys:repairciv')
AddEventHandler('fa-bennys:repairciv', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(450)
end)

RPC.register("fa-jobs:bennys:getPartsCatalog", function(src)
    return PartsCatalog
end)

RPC.register("fa-jobs:bennys:getPriceModifiers", function(src)
    return PriceModifiers
end)

RPC.register("fa-bennys:jobRepair", function(src)
    return true
end)

RPC.register("fa-bennys:checkIfUsed", function(src, currentBennys)
    if Bennys[currentBennys] ~= nil then
        return true
    else
        return nil
    end
end)

local performancePrices = {}
function getPartsCatalog()
    for k, v in pairs(vehicleCustomisationPrices.performance.prices) do
        performancePrices[k] = {
            price = v
        }
    end

    for k,v in ipairs(vehicleCustomisation) do
        -- pParts = string.gsub(v.category, " ", "")
        for i = 1, #Mods do
            if string.find(v.category,  Mods[i]) then
                table.insert(PartsCatalog, {
                    type = "mods",
                    part = Mods[i],
                    category = v.category,
                    prices = {
                        vehicleCustomisationPrices.cosmetics,
                        id = v.id,
                    }
                })
            end
        end
        if string.find(v.category,  "Spoiler") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Spoilers",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Brake Upgrade") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Brakes",
                category = v.category,
                prices =  performancePrices,
            })
        end
        if string.find(v.category,  "Front Bumper") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "FrontBumper",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Rear Bumper") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "RearBumper",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Side Skirt") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "SideSkirt",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Roll Cage") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Frame",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Right Fender") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "RightFender",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Vanity Plates") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "VanityPlates",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Trim A") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "ExteriorTrim",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Trim B") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "InteriorTrim",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Dial") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Dials",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Door Speaker") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "DoorSpeakers",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Steering Wheel") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "SteeringWheel",
                category = v.category,
                prices = {
                    id = v.id,
                    vehicleCustomisationPrices.cosmetics,
                }
            })
        end
        if string.find(v.category,  "Shifter Leaver") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "ShiftLeavers",
                category = v.category,
                prices = {
                    id = v.id,
                    vehicleCustomisationPrices.cosmetics,
                }
            })
        end
        if string.find(v.category,  "Plaque") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Plaques",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Speaker") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Speakers",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Hydraulic") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Hydraulics",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Air Filter") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "AirFilter",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Strut") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Struts",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Arch Cover") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "ArchCover",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Aerial") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Aerials",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
        if string.find(v.category,  "Window") then
            table.insert(PartsCatalog, {
                type = "mods",
                part = "Windows",
                category = v.category,
                prices = {
                    vehicleCustomisationPrices.cosmetics,
                    id = v.id,
                }
            })
        end
    end

    for k,v in ipairs(vehicleResprayCategories) do
        for i in string.gmatch(v.category, "%S+") do
            table.insert(PartsCatalog, {
                type = "colors",
                part = string.lower(i),
                category = v.category,
                prices = {
                    id = v.id,
                    vehicleCustomisationPrices.respray,
                }
            })
        end
        table.insert(PartsCatalog, {
            type = "colors",
            part = "xenon",
            category = "Xenon Colour",
            prices = {
                vehicleCustomisationPrices.xenoncolours,
            }
        })
        table.insert(PartsCatalog, {
            type = "colors",
            part = "neon",
            category = "Neons",
            prices = {
                vehicleCustomisationPrices.neoncolours,
            }
        })
    end

    for k,v in ipairs(vehicleWindowTintOptions) do
        table.insert(PartsCatalog, {
            type = "additionals",
            part = "tint",
            category = "Window Tint",
            prices = {
                id = v.id,
                vehicleCustomisationPrices.windowtint,
            }
        })
    end

    table.insert(PartsCatalog, {
        type = "mods",
        part = "XenonHeadlights",
        category = "Headlights",
        prices = {
            vehicleCustomisationPrices.headlights,
        }
    })
    table.insert(PartsCatalog, {
        type = "mods",
        part = "FrontWheels",
        category = "Wheels",
        prices = {
            vehicleCustomisationPrices.wheels,
        }
    })
    table.insert(PartsCatalog, {
        type = "mods",
        part = "BackWheels",
        category = "Wheels",
        prices = {
            vehicleCustomisationPrices.wheels,
        }
    })
    table.insert(PartsCatalog, {
        type = "mods",
        part = "PlateHolder",
        category = "Plate Holder",
        prices = {
            vehicleCustomisationPrices.plateindex,
        }
    })
    table.insert(PartsCatalog, {
        type = "mods",
        part = "UNK47",
        category = "UNK47",
        prices = {
            vehicleCustomisationPrices.cosmetics,
        }
    })
    table.insert(PartsCatalog, {
        type = "additionals",
        part = "plateIndex",
        category = "plateIndex",
        prices = {
            vehicleCustomisationPrices.plateindex,
        }
    })
    table.insert(PartsCatalog, {
        type = "additionals",
        part = "neon",
        category = "Neons",
        prices = {
            vehicleCustomisationPrices.neonside,
        }
    })

    for k ,v in ipairs(PartsCatalog) do
        if v.part == "colour" then
            table.remove(PartsCatalog, k)
        end

        if v.part == "Fender" and v.category == "Right Fender"  then
            table.remove(PartsCatalog, k)
        end

        if v.part == "Engine" and v.category == "Engine Upgrade"  then
            v.prices = performancePrices
        end

        if v.part == "Transmission" and v.category == "Transmission Upgrade"  then
            v.prices = performancePrices
        end

        if v.part == "Suspension" and v.category == "Suspension Upgrade"  then
            v.prices = performancePrices
        end

        if v.part == "Turbo" and v.category == "Turbo Upgrade"  then
            v.prices = {
                vehicleCustomisationPrices.turbo,
                id = v.id,
            }
        end
    end
end

function getPriceModifiers()
    
end

Citizen.CreateThread(function()
    getPartsCatalog()
    getPriceModifiers()
end)