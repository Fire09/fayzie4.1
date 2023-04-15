local currentPrompt, isExercising = nil, false

local EVENTS = {
  LOCKERS = 1,
  CLOTHING = 2,
  SWITCHER = 3
}

-- AddEventHandler("playerSpawned", function()
-- 	TriggerServerEvent('doctor:setTriageState', "pillbox")
-- 	TriggerServerEvent('doctor:setTriageState', "viceroy")
-- end)

RegisterNUICallback("fa-healthcare:handler", function(data, cb)
  local eventData = data.key
  local location = string.match(currentPrompt, "(.-)_")
	if eventData == EVENTS.LOCKERS then
		local cid = exports['isPed']:isPed('myJob')
		TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		exports["fa-interface"]:hideContextMenu()
	elseif eventData == EVENTS.CLOTHING then
		TriggerEvent("fa-clothing:openClothing", true, true, false)
		exports["fa-interface"]:hideContextMenu()
	elseif eventData == EVENTS.SWITCHER then
		TriggerServerEvent('fa-base:ResetPlayerInfo')
		Citizen.Wait(1000)
		TriggerEvent("fa-base:clearStates")
		exports["fa-interface"]:hideContextMenu()
		exports["fa-base"]:getModule("SpawnManager"):Initialize()
	end
	cb({ data = {}, meta = { ok = true, message = "done" } })
end)

local zoneData = {
	pillbox_checkin = {
		promptText = "[E] Check-In"
	},
	viceroy_checkin = {
		promptText = "[E] Check-In"
	},
	hospital_armory = {
		promptText = "[E] Armory"
	},
	hospital_clothing_lockers_staff = {
		promptText = "[E] Lockers & Clothes",
		menuData = {
			{
				title = "Lockers",
				description = "Access your personal locker",
				action = "fa-healthcare:handler",
				key = EVENTS.LOCKERS
			},
			{
				title = "Clothing",
				description = "Gotta look Sharp",
				action = "fa-healthcare:handler",
				key = EVENTS.CLOTHING
			}
		}
	},
	hospital_character_switcher_staff = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Go bowling with your cousin",
				action = "fa-healthcare:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
	pillbox_character_switcher_backroom = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Go bowling with your cousin",
				action = "fa-healthcare:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
	morgue_character_switcher_backroom = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Go bowling with your cousin",
				action = "fa-healthcare:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
	parsons_character_switcher_backroom = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Go bowling with your cousin",
				action = "fa-healthcare:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
	infirm_char_switcher_backroom = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Go bowling with your cousin",
				action = "fa-healthcare:handler",
				key = EVENTS.SWITCHER
			}
		}
	}
}


local function listenForKeypress(pZone, pDoctors)
	listening = true
	Citizen.CreateThread(function()
		while listening do
			if IsControlJustReleased(0, 38) then
				if pZone == "hospital_clothing_lockers_staff" then
					exports["fa-interface"]:showContextMenu(zoneData[pZone].menuData)
				elseif pZone == "pillbox_checkin" or pZone == "viceroy_checkin" then
					local hospital = pZone == "viceroy_checkin" and "viceroy" or "pillbox"
                    local string = ''
					loadAnimDict('anim@narcotics@trash')
					TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    if pDoctors <= 0 then 
                        -- No ems / doctors on duty 
                        pDoctors = false
                        string = 'Checking Credentials'
                    else
                        pDoctors = true
                        string = 'Paging a doctor'
                    end

                    local finished = exports["fa-taskbar"]:taskBar(1500,string, false, true, false, false, nil, 5.0, PlayerPedId())
                    if finished == 100 then
							if pDoctors then
								TriggerEvent("DoLongHudText","A doctor has been paged. Please take a seat and wait.",2)
								TriggerEvent("fa-jobs:EMS:doctorpaged", hospital)
							else
								TriggerEvent("bed:checkin")
							end
							ClearPedTasksImmediately(PlayerPedId())
						end
				elseif pZone == "hospital_character_switcher_staff" or pZone == "pillbox_character_switcher_backroom" or pZone == "morgue_character_switcher_backroom" or pZone == "parsons_character_switcher_backroom" then
					exports["fa-interface"]:showContextMenu(zoneData[pZone].menuData)
				elseif pZone == "hospital_armory" then
					local job = exports['isPed']:isPed('myJob')
					if job == "doctor" or job == "ems" then
						TriggerEvent("server-inventory-open", "9", "Shop")
					end
				end
			end
			Wait(0)
		end
	end)
end

AddEventHandler("fa-polyzone:enter", function(zone)
	local currentZone = zoneData[zone]
	local myjob = exports['isPed']:isPed('myJob')
	local checkEMS = exports["isPed"]:isPed("countems")
	if currentZone then --and isCop
		currentPrompt = zone
		local prompt = currentZone.promptText
		local doctors = 0

		if zone == 'pillbox_checkin' or zone == "viceroy_checkin" then
			local hosp = zone == "viceroy_checkin" and "viceroy" or "pillbox"
			if checkEMS > 0 then
				prompt = '[E] Page a doctor'
			else
				prompt = prompt
			end
		end
		exports["fa-interface"]:showInteraction(prompt)
		listenForKeypress(zone, checkEMS)
	end
end)

AddEventHandler("fa-polyzone:exit", function(zone)
	if zoneData[zone] then
		exports["fa-interface"]:hideInteraction()
		listening = false
		currentPrompt = nil
	end
end)


RegisterNetEvent("fa-healthcare:yoga")
AddEventHandler("fa-healthcare:yoga", function(pArgs, pEntity, pContext)
	local waitTime = 0
	Wait(200)
	TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, -1)
	Citizen.Wait(650)
	local animation = AnimationTask:new(PlayerPedId(), 'normal', 'Breathe in..', 11000, 'WORLD_HUMAN_YOGA', nil, nil)
	animation:start()
	repeat 
		waitTime = waitTime + 1
		Citizen.Wait(100)
	until waitTime == 100 do
		animation:stop()
		ClearPedTasks(PlayerPedId())
		TriggerEvent("DoLongHudText", "Stress Relieved")
		TriggerEvent("fa-hud:updateStress", false, math.random(2,10))	
	end
end)


CreateThread(function()
	-- Checkin, pillbox
	exports["fa-polyzone"]:AddCircleZone("pillbox_checkin", vector3(306.9, -595.03, 43.28), 0.7, {
		useZ=true,
	})

	exports["fa-polyzone"]:AddCircleZone("viceroy_checkin", vector3(-817.44, -1236.69, 7.34), 0.7, {
		useZ=true,
	})
	-- Armory, pillbox
	exports["fa-polyzone"]:AddCircleZone("hospital_armory", vector3(306.28, -601.58, 43.28), 0.7, {
		useZ=true,
	})

	exports["fa-polyzone"]:AddCircleZone("hospital_armory", vector3(-820.22, -1242.72, 7.34), 0.7, {
		useZ=true,
	})

	-- Clothing / Personal Lockers, Staff room, pillbox
	exports["fa-polyzone"]:AddBoxZone("hospital_clothing_lockers_staff", vector3(300.28, -598.83, 43.28), 3.2, 4.2, {
		heading=340,
		minZ=42.28,
		maxZ=45.68
	})

	exports["fa-polyzone"]:AddBoxZone("hospital_clothing_lockers_staff", vector3(-824.44, -1237.3, 7.34), 5.0, 3.8, {
		heading=320,
		minZ=6.34,
		maxZ=9.34
	})
	-- Character Switcher, Staff room, pillbox
	exports["fa-polyzone"]:AddBoxZone("hospital_character_switcher_staff", vector3(296.16, -598.31, 43.28), 2.4, 1.2, {
		heading=250,
		minZ=42.28,
		maxZ=45.68
	})

	exports["fa-polyzone"]:AddBoxZone("hospital_character_switcher_staff", vector3(-828.56, -1236.19, 7.38), 1.6, 2.4, {
		heading=321,
		minZ=6.38,
		maxZ=9.18
	})
	-- Character Switcher, Backroom pillbox
	exports["fa-polyzone"]:AddBoxZone("pillbox_character_switcher_backroom", vector3(340.82, -596.46, 43.28), 2.4, 1.2, {
		heading=160,
		minZ=42.28,
		maxZ=45.68
	})
	-- Character Switcher, Morgue
	exports["fa-polyzone"]:AddBoxZone("morgue_character_switcher_backroom", vector3(296.61, -1352.36, 24.53), 1.8, 2.0, {
		heading=50,
		minZ=23.53,
		maxZ=26.53
	})
	-- Character Switcher, Parsons
	exports["fa-polyzone"]:AddBoxZone("parsons_character_switcher_backroom", vector3(-1501.62, 857.45, 181.59), 1.8, 2.0, {
		heading=25,
		minZ=180.59,
		maxZ=184.59
	})
	-- Character Switcher, Infirmirary
	exports["fa-polyzone"]:AddBoxZone("infirm_char_switcher_backroom", vector3(1771.78, 2509.0, 45.83), 1.0, 1.6, {
		heading=301,
		minZ=44.88,
		maxZ=47.68
	})
end)

