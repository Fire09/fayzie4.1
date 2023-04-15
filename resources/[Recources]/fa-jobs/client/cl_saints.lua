
Citizen.CreateThread(function()
    exports["fa-polyzone"]:AddBoxZone("saint_stash_1", vector3(-1796.87, 439.61, 128.39), 1, 1, {
        name="saint_stash_1",
        heading=0,
        --debugPoly=false,
        minZ=124.59,
        maxZ=128.59
    })
end)

SaintsStash = false

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "saint_stash_1" then
        SaintsStash = true     
        SaintsStashhhh()
        local isEmployed = exports["fa-business"]:IsEmployedAt("saints")
        if isEmployed then
            exports['fa-interface']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "saint_stash_1" then
        SaintsStash = false
        exports['fa-interface']:hideInteraction()
    end
end)

function SaintsStashhhh()
	Citizen.CreateThread(function()
        while SaintsStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local isEmployed = exports["fa-business"]:IsEmployedAt("saints")
                if isEmployed then
                    TriggerEvent('fa-stashes:openAspect', 1)
                end
			end
		end
	end)
end

RegisterNetEvent('fa-stashes:openAspect')
AddEventHandler('fa-stashes:openAspect', function(stashNum)
    TriggerEvent('server-inventory-open', '1', 'saints-stash'..stashNum)
end)