previewEnabled = false
local usedItemId, usedItemSlot, usedItemMetadata

RegisterNetEvent("fa-racing:addedActiveRace")
AddEventHandler("fa-racing:addedActiveRace", function(race)
    print("ADDING ACTIVE RACE")
    activeRaces[race.id] = race

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("fa-racing:api:addedActiveRace", race, activeRaces)
    TriggerEvent("fa-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("fa-racing:removedActiveRace")
AddEventHandler("fa-racing:removedActiveRace", function(id)
    print("REMOVE ACTIVE RACE")
    activeRaces[id] = nil

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("fa-racing:api:removedActiveRace", activeRaces)
    TriggerEvent("fa-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("fa-racing:updatedActiveRace")
AddEventHandler("fa-racing:updatedActiveRace", function(race)
    if activeRaces[race.id] then
        activeRaces[race.id] = race
    end

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("fa-racing:api:updatedActiveRace", activeRaces)
    TriggerEvent("fa-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("fa-racing:endRace")
AddEventHandler("fa-racing:endRace", function(race)
    print("RACE FUCKING END")
    SendNUIMessage({
        showHUD = false
    })

    TriggerEvent("fa-racing:api:raceEnded", race)
    TriggerEvent('fa-racing:fa-racing:api:updatedStat')
    cleanupRace()
end)

RegisterNetEvent("fa-racing:raceHistory")
AddEventHandler("fa-racing:raceHistory", function(race)
    finishedRaces[#finishedRaces + 1] = race

    if race then
        if not config.nui.hudOnly then
            SendNUIMessage({
                leaderboardData = race
            })
        end
    end

    TriggerEvent("fa-racing:api:raceHistory", race)
    TriggerEvent("fa-racing:api:updatedState", { finishedRaces = finishedRaces })
end)

RegisterNetEvent("fa-racing:startRace")
AddEventHandler("fa-racing:startRace", function(race, startTime)
    TriggerEvent("fa-racing:api:startingRace", startTime)
    -- Wait for race countdown
    Citizen.Wait(startTime - 3000)

    SendNUIMessage({
        type = "countdown",
        start = 3,
    })

    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")

    if not curRace then
        initRace(race)
        TriggerEvent("fa-racing:api:raceStarted", race)
    end
end)

RegisterNetEvent("fa-racing:updatePosition")
AddEventHandler("fa-racing:updatePosition", function(position)
    -- print("Position is now: " .. position)
    SendNUIMessage({
        HUD = { position = position }
    })
end)

RegisterNetEvent("fa-racing:dnfRace")
AddEventHandler("fa-racing:dnfRace", function()
    SendNUIMessage({
        HUD = { dnf = true }
    })

    TriggerEvent("fa-racing:api:dnfRace", race)
end)

RegisterNetEvent("fa-racing:startDNFCountdown")
AddEventHandler("fa-racing:startDNFCountdown", function(dnfTime)
    SendNUIMessage({
        HUD = { dnfTime = dnfTime }
    })
end)

function round(x, n) 
    return tonumber(string.format("%." .. n .. "f", x))
end

RegisterNetEvent("fa-racing:finishedRace")
AddEventHandler("fa-racing:finishedRace", function(position, time, pEnterAmt)
    if position == 1 then
        RPC.execute('fa-racing:awardPlayer', math.random(40, 50) + round(pEnterAmt / 6, 0))
    elseif position == 2 then
        RPC.execute('fa-racing:awardPlayer', math.random(20, 30))
    elseif position == 3 then
        RPC.execute('fa-racing:awardPlayer', math.random(10))
    end
    SendNUIMessage({
        HUD = {
            position = position,
            finished = time,
        }
    })
end)

RegisterNetEvent("fa-racing:joinedRace")
AddEventHandler("fa-racing:joinedRace", function(race)
    race.start.pos = tableToVector3(race.start.pos)
    spawnCheckpointObjects(race.start, config.startObjectHash)
end)

RegisterNetEvent("fa-racing:leftRace")
AddEventHandler("fa-racing:leftRace", function()
    cleanupProps()
    TriggerEvent('fa-racing:api:updatedState')
end)

RegisterNetEvent("fa-racing:playerJoinedYourRace")
AddEventHandler("fa-racing:playerJoinedYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("fa-racing:api:playerJoinedYourRace", characterId, name)
end)

RegisterNetEvent("fa-racing:playerLeftYourRace")
AddEventHandler("fa-racing:playerLeftYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("fa-racing:api:playerLeftYourRace", characterId, name)
end)

RegisterNetEvent("fa-racing:addedPendingRace")
AddEventHandler("fa-racing:addedPendingRace", function(race)
    pendingRaces[race.id] = race
    if not config.nui.hudOnly then
        SendNUIMessage({
            pendingRaces = pendingRaces
        })
    end

    TriggerEvent("fa-racing:api:addedPendingRace", race, pendingRaces)
    TriggerEvent("fa-racing:api:updatedState", { pendingRaces = pendingRaces })
end)

RegisterNetEvent("fa-racing:removedPendingRace")
AddEventHandler("fa-racing:removedPendingRace", function(id)
    pendingRaces[id] = nil

    SendNUIMessage({ pendingRaces = pendingRaces })

    TriggerEvent("fa-racing:api:removedPendingRace", pendingRaces)
    TriggerEvent("fa-racing:api:updatedState", {pendingRaces=pendingRaces})
end)

RegisterNetEvent("fa-racing:startCreation")
AddEventHandler("fa-racing:startCreation", function()
    startRaceCreation()
end)

RegisterNetEvent("fa-racing:addedRace")
AddEventHandler("fa-racing:addedRace", function(newRace, newRaces)
    if not races then return end
    races = newRaces

    SendNUIMessage({
        races = newRaces
    })

    TriggerEvent("fa-racing:api:addedRace")
    TriggerEvent("fa-racing:api:updatedState", {races=races})
end)

local function openAliasTextbox()
  exports['fa-interface']:openApplication('textbox', {
    callbackUrl = 'fa-interface:racing:input:alias',
    key = 1,
    items = {{icon = "pencil-alt", label = "Alias", name = "alias"}},
    show = true
  })
end

AddEventHandler("fa-inventory:itemUsed", function(item, metadata, inventoryName, slot)
    print(" i am using racing usb2")
    print(item)
    --print(metadata)
    print(inventoryName)
    print(slot)
  --if item ~= "racingusb2" then return end
  usedItemId = item
  usedItemSlot = slot
  --usedItemMetadata = json.decode(metadata)

  --local characterId = exports["isPed"]:isPed("cid")
  --print(characterId)
  --if characterId ~= characterId then
   -- TriggerEvent("DoLongHudText", "You don't own this usb!", 2)
    --return
 -- end

  --if characterId then
   -- TriggerEvent("DoLongHudText", "Alias can't be changed for this usb!", 2)
   -- return
 -- end
   if item == "racingusb2" then
  openAliasTextbox()
   end
end)

RegisterInterfaceCallback("fa-interface:racing:input:alias", function(data, cb)
  cb({data = {}, meta = {ok = true, message = ''}})
  exports['fa-interface']:closeApplication('textbox')
  local alias = data.values.alias
  print( data.values.alias)

  --if usedItemMetadata.Alias then return end

  if  alias == nil then
    TriggerEvent("DoLongHudText", "No alias entered!", 2)
    return
  end

  local success, msg = RPC.execute("fa-racing:setAlias", usedItemId, usedItemSlot, alias)
  if success then
    exports["fa-phone"]:phoneNotification("racen", "Welcome to the underground, " .. alias .. ".", "From the PM", 5000)
  else
    TriggerEvent("DoLongHudText", msg or "Alias could not be set.", 2)
    if msg == "Alias already taken!" then
      openAliasTextbox()
    end
  end
end)

-- RegisterCommand("fa-racing:giveRacingUSB", function()
--     RPC.execute("fa-racing:giveRacingUSB")
-- end)

AddEventHandler("onResourceStop", function (resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    cleanupProps()
    clearBlips()
    ClearGpsMultiRoute()
end)

RegisterNetEvent('fa-racing:api:currentRace')
AddEventHandler("fa-racing:api:currentRace", function(currentRace)
    print(json.encode(currentRace))
    -- print("FUCK THIS SHIT HERE******************************************************")
    isRacing = currentRace ~= nil
    if isRacing then
        startBubblePopper(currentRace)
    end
end)

   RegisterCommand('openracing', function()
    openAliasTextbox()
      end)