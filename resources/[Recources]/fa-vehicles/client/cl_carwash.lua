local listening = false
local cleaning = false

local function cleanVehicle()
	cleaning = true

    local clean = RPC.execute("fa-carwash:cleanVehicle")

	if clean then
        local car = GetVehiclePedIsUsing(PlayerPedId())
	    local coords = GetEntityCoords(PlayerPedId())

        FreezeEntityPosition(car, true)

        if not HasNamedPtfxAssetLoaded("core") then
		    RequestNamedPtfxAsset("core")
		    while not HasNamedPtfxAssetLoaded("core") do
			    Wait(1)
		    end
	    end

        UseParticleFxAssetNextCall("core")
	    local particles  = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords["x"], coords["y"], coords["z"], 0.0, 0.0, 0.0, 1.0, false, false, false, false)

        UseParticleFxAssetNextCall("core")
	    local particles2  = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords["x"] + 2, coords["y"], coords["z"], 0.0, 0.0, 0.0, 1.0, false, false, false, false)

        for i = 1, 15 do
            Citizen.Wait(1000)

            if i == 15 then
                WashDecalsFromVehicle(car, 1.0)
	    		SetVehicleDirtLevel(car)
	    		FreezeEntityPosition(car, false)
	    		TriggerEvent("DoLongHudText", "Your vehicle has been cleaned!")
	    		StopParticleFxLooped(particles, 0)
	    		StopParticleFxLooped(particles2, 0)
	    		break
            end
        end
	end

    cleaning = false
end

local function listenForKeypress()
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) and not cleaning then
                cleanVehicle()
            end
            Wait(0)
        end
    end)
end

AddEventHandler("fa-polyzone:enter", function(zone)
    if zone ~= "car_wash" then return end
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then return end

    exports["fa-ui"]:showInteraction("[E] Clean the Vehicle for $100")
    listenForKeypress()
end)

AddEventHandler("fa-polyzone:exit", function(zone)
    if zone ~= "car_wash" then return end

    exports["fa-ui"]:hideInteraction()
    listening = false
end)

Citizen.CreateThread(function()
    -- Strawberry
    exports["fa-polyzone"]:AddBoxZone("car_wash", vector3(26.59, -1392.02, 27.36), 3.0, 3.0, {
        heading=0,
        minZ=25.00,
        maxZ=32.00,
    })

    -- Davis
    exports["fa-polyzone"]:AddBoxZone("car_wash", vector3(175.03, -1736.63, 29.29), 6.0, 6.0, {
        heading=0,
        minZ=25.00,
        maxZ=32.00,
    })

    -- Little Seoul
    exports["fa-polyzone"]:AddBoxZone("car_wash", vector3(-699.96, -933.30, 19.01), 6.0, 6.0, {
        heading=0,
        minZ=18.00,
        maxZ=22.00,
    })

    -- Sandy Shores
    exports["fa-polyzone"]:AddBoxZone("car_wash", vector3(1362.53, 3592.12, 33.92), 6.0, 6.0, {
        heading=115,
        minZ=33.00,
        maxZ=38.00,
    })
end)