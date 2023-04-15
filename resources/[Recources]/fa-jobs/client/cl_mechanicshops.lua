-- Tuner Shop

local Tuner_Shop_Craft = false
local Tuner_Shop_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "tuner_shop_craft" then
        Tuner_Shop_Craft = true     
        TunerCraft()
        local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Craft")
        end
    elseif name == "tuner_shop_stash" then
        Tuner_Shop_Stash = true
        TunerStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "tuner_shop_craft" then
        Tuner_Shop_Craft = false
        exports['fa-interface']:hideInteraction()
    elseif name == "tuner_shop_stash" then
        Tuner_Shop_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function TunerCraft()
	Citizen.CreateThread(function()
        while Tuner_Shop_Craft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '28', 'Craft')
                end
			end
		end
	end)
end

function TunerStash()
	Citizen.CreateThread(function()
        while Tuner_Shop_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("tuner_shop")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'tuner-shop-stash')
                end
			end
		end
	end)
end

-- Harmony 

local Harmony_Craft = false
local Harmony_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "harmony_repairs_craft" then
        Harmony_Craft = true     
        HarmonyCraft()
        local isEmployed = exports["fa-business"]:IsEmployedAt("harmony_repairs")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Craft")
        end
    elseif name == "harmony_repairs_stash" then
        Harmony_Stash = true
        HarmonyStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("harmony_repairs")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "harmony_repairs_craft" then
        Harmony_Craft = false
        exports['fa-interface']:hideInteraction()
    elseif name == "harmony_repairs_stash" then
        Harmony_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function HarmonyCraft()
	Citizen.CreateThread(function()
        while Harmony_Craft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("harmony_repairs")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '27', 'Craft')
                end
			end
		end
	end)
end

function HarmonyStash()
	Citizen.CreateThread(function()
        while Harmony_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("harmony_repairs")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'harmony-stash')
                end
			end
		end
	end)
end

-- Hayes


local Hayes_Craft = false
local Hayes_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "hayes_autos_craft" then
        Hayes_Craft = true     
        HayesCraft()
        local isEmployed = exports["fa-business"]:IsEmployedAt("hayes_autos")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Craft")
        end
    elseif name == "hayes_autos_stash" then
        Hayes_Stash = true
        HayesStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("hayes_autos")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "hayes_autos_craft" then
        Hayes_Craft = false
        exports['fa-interface']:hideInteraction()
    elseif name == "hayes_autos_stash" then
        Hayes_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function HayesCraft()
	Citizen.CreateThread(function()
        while Hayes_Craft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("hayes_autos")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '27', 'Craft')
                end
			end
		end
	end)
end

function HayesStash()
	Citizen.CreateThread(function()
        while Hayes_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("hayes_autos")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'hayes-stash')
                end
			end
		end
	end)
end

-- Otto's

local Ottos_Autos_Craft = false
local Ottos_Autos_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "ottos_autos_craft" then
        Ottos_Autos_Craft = true     
        OttosCraft()
        local isEmployed = exports["fa-business"]:IsEmployedAt("ottos_autos")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Craft")
        end
    elseif name == "ottos_autos_stash" then
        Ottos_Autos_Stash = true
        OttosStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("ottos_autos")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "ottos_autos_craft" then
        Ottos_Autos_Craft = false
        exports['fa-interface']:hideInteraction()
    elseif name == "ottos_autos_stash" then
        Ottos_Autos_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function OttosCraft()
	Citizen.CreateThread(function()
        while Ottos_Autos_Craft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("ottos_autos")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '27', 'Craft')
                end
			end
		end
	end)
end

function OttosStash()
	Citizen.CreateThread(function()
        while Ottos_Autos_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("ottos_autos")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'ottos-autos-stash')
                end
			end
		end
	end)
end

-- Poly Zones --

Citizen.CreateThread(function()
    -- Tuner Shop | Start --
    exports["fa-polyzone"]:AddBoxZone("tuner_shop_stash", vector3(128.46, -3014.08, 7.04), 2.5, 2.5, {
        name="tuner_shop_stash",
        heading=0,
        debugPoly=false,
        minZ=5.04,
        maxZ=9.04
    })

    exports["fa-polyzone"]:AddBoxZone("tuner_shop_craft", vector3(143.96, -3051.26, 7.04), 1, 5, {
        name="tuner_shop_craft",
        heading=0,
        --debugPoly=false,
        minZ=5.44,
        maxZ=9.44
    })
    -- Tuner Shop | End --

    -- Harmony Repairs | Start --
    exports["fa-polyzone"]:AddBoxZone("harmony_repairs_stash", vector3(1187.12, 2635.81, 38.4), 1, 1.4, {
        name="harmony_repairs_stash",
        heading=0,
        --debugPoly=false,
        minZ=35.0,
        maxZ=39.0
    })

    exports["fa-polyzone"]:AddBoxZone("harmony_repairs_craft", vector3(1176.23, 2635.29, 37.75), 3, 2, {
        name="harmony_repairs_craft",
        heading=270,
        --debugPoly=false,
        minZ=35.75,
        maxZ=39.75
    })
    -- Harmony Repairs | End --

    -- Hayes Autos | Start --
    exports["fa-polyzone"]:AddBoxZone("hayes_autos_stash", vector3(-1418.49, -454.77, 35.91), 1, 3.0, {
        name="hayes_autos_stash",
        heading=30,
        --debugPoly=false,
        minZ=34.51,
        maxZ=38.51
    })

    exports["fa-polyzone"]:AddBoxZone("hayes_autos_craft", vector3(-1408.17, -447.34, 35.91), 1, 5.0, {
        name="hayes_autos_craft",
        heading=35,
        --debugPoly=false,
        minZ=33.11,
        maxZ=37.11
    })
    -- Hayes Autos | End --

    -- Ottos Autos | Start --
    exports["fa-polyzone"]:AddBoxZone("ottos_autos_stash", vector3(837.15, -814.76, 26.33), 2, 3.0, {
        name="ottos_autos_stash",
        heading=270,
        --debugPoly=false,
        minZ=23.33,
        maxZ=27.33
    })

    exports["fa-polyzone"]:AddBoxZone("ottos_autos_craft", vector3(840.33, -827.5, 26.33), 2, 3.6, {
        name="ottos_autos_craft",
        heading=0,
        --debugPoly=false,
        minZ=24.33,
        maxZ=28.33
    })
    -- Ottos Autos | End --

    -- Tuner Shop | Start --
    exports["fa-polyzone"]:AddBoxZone("auto_exotics_stash", vector3(547.22, -182.99, 54.49), 5.0, 1, {
        name="auto_exotics_stash",
        heading=0,
        debugPoly=false,
        minZ=51.84,
        maxZ=55.84
    })

    exports["fa-polyzone"]:AddBoxZone("auto_exotics_craft", vector3(546.55, -166.74, 54.49), 5.0, 1, {
        name="auto_exotics_craft",
        heading=270,
        --debugPoly=false,
        minZ=51.84,
        maxZ=55.84
    })
    -- Tuner Shop | End --
end)

local Auto_Exotic_Craft = false
local Auto_Exotic_Stash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "auto_exotics_craft" then
        Auto_Exotic_Craft = true     
        AutoExoticCraft()
        local isEmployed = exports["fa-business"]:IsEmployedAt("auto_exotics")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Craft")
        end
    elseif name == "auto_exotics_stash" then
        Auto_Exotic_Stash = true
        AutoExoticStash()
        local isEmployed = exports["fa-business"]:IsEmployedAt("auto_exotics")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "auto_exotics_craft" then
        Auto_Exotic_Craft = false
        exports['fa-interface']:hideInteraction()
    elseif name == "auto_exotics_stash" then
        Auto_Exotic_Stash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function AutoExoticCraft()
	Citizen.CreateThread(function()
        while Auto_Exotic_Craft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("auto_exotics")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '28', 'Craft')
                end
			end
		end
	end)
end

function AutoExoticStash()
	Citizen.CreateThread(function()
        while Auto_Exotic_Stash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("auto_exotics")
                if isEmployed then
                    TriggerEvent('server-inventory-open', '1', 'auto-exotic-stash')
                end
			end
		end
	end)
end