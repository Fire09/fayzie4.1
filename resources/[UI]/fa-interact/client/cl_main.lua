local debugEnabled = false
local PeekEntries = { ['model'] = {}, ['flag'] = {}, ['entity'] = {}, ['polytarget'] = {} }

CurrentZones, CurrentTarget, CurrentTargetType, IsPeeking, IsPeakActive = {}, nil, nil, false, false

EntryCount, ListCount, UpdateRequired, RefreshingList = 0, 0, false, false

local enableWorldPrompts = true

local function convertNpcIds(npcIds)
    if npcIds == nil then return nil end
    local idHashes = {}
    for i=1, #npcIds do
        idHashes[i] = GetHashKey(npcIds[i])
    end
    return idHashes
end

local function hasNpcId(entity, npcIds)
    if npcIds == nil then return true end
    for i=1, #npcIds do
        if DecorGetInt(entity, "NPC_ID") == npcIds[i] then
            return true
        end
    end
    return false
end

function AddPeekEntry(pType, pGroup, pData, pOptions)
    local entries = PeekEntries[pType]

    if not entries then return error(pType .. ' Is not a valid Peek Type') end

    local addEntry = function(group, data, options)
	options.npcIds = convertNpcIds(options.npcIds)
        if not entries[group] then entries[group] = {} end

        local groupEntries = entries[group]

        for _, entry in ipairs(data) do
            if not entry.id then error('Missing ID in entry for '.. group) end

            EntryCount = EntryCount + 1

            entry.index = EntryCount

            groupEntries[entry.id] = { data = entry, options = options }
        end
    end

    if type(pGroup) ~= 'table' then
        addEntry(pGroup, pData, pOptions)
        return RefreshPeekList()
    end

    for _, group in ipairs(pGroup) do
        addEntry(group, pData, pOptions)
    end

    RefreshPeekList()
end

exports('GetCurrentEntity', function()
    return CurrentTarget
end)

exports('AddPeekEntry', AddPeekEntry)

function AddPeekEntryByModel(pModel, pData, pOptions)
    AddPeekEntry('model', pModel, pData, pOptions)
end

exports('AddPeekEntryByModel', AddPeekEntryByModel)

function AddPeekEntryByFlag(pFlag, pData, pOptions)
    AddPeekEntry('flag', pFlag, pData, pOptions)
end

exports('AddPeekEntryByFlag', AddPeekEntryByFlag)

function AddPeekEntryByEntityType(pEntityType, pData, pOptions)
    AddPeekEntry('entity', pEntityType, pData, pOptions)
end

exports('AddPeekEntryByEntityType', AddPeekEntryByEntityType)

function AddPeekEntryByPolyTarget(pEvent, pData, pOptions)
    AddPeekEntry('polytarget', pEvent, pData, pOptions)
end

exports('AddPeekEntryByPolyTarget', AddPeekEntryByPolyTarget)

function RemovePeekEntryById(_id)
    for _, groups in pairs(PeekEntries) do
        for _, group in pairs(groups) do
            for id, entry in pairs(group) do
                if id == _id then
                    group[id] = nil
                end
            end
        end
    end
end

exports('RemovePeekEntryById', RemovePeekEntryById)

function RefreshPeekList()
    if RefreshingList then return end

    RefreshingList = true

    Citizen.SetTimeout(250, function()
        local entries = {}

        for _, groups in pairs(PeekEntries) do
            for _, group in pairs(groups) do
                for id, entry in pairs(group) do
                    entries[id] = entry.data
                end
            end
        end

        RefreshingList = false

        SendNUIMessage({response = "refresh", payload = entries or {}})
    end)
end

function UpdatePeekEntryList(pEntries)
    local active = IsActive(pEntries)

    if not IsPeakActive and active then
        IsPeakActive = true
    elseif IsPeakActive and not active then
        IsPeakActive = false
    end

    SendNUIMessage({response = "update", payload = { active = IsPeakActive, options = pEntries }})
end

function GetCurrentPeekEntryList()
    local entity, context = CurrentTarget, GetEntityContext(CurrentTarget)

    ListCount = ListCount + 1

    local listId, entries, tracked = ListCount, {}, {}

    local addEntry = function(pId, pEntry, pContext, pRelated)
        local data, options = pEntry.data, pEntry.options

        if options.job then
            local hasJob = false

            for _, job in ipairs(options.job) do
                if job == LocalPlayer.state.job then
                    hasJob = true
                    break
                end
            end

            if not hasJob then return end
        end

        local hasChecks = options.isEnabled or options.distance

        entries[pId] = not hasChecks

        if not hasChecks then return end

        if options.distance and pContext.zones[pRelated] then
            options.distance.zone = pRelated
        end

        tracked[pId] = options
    end

    if CurrentTarget then
        if PeekEntries['model'][context.model] then
            for id, entry in pairs(PeekEntries['model'][context.model]) do
                addEntry(id, entry, context, entity)
            end
        end

        for flag, active in pairs(context.flags) do
            if active and PeekEntries['flag'][flag] then
                for id, entry in pairs(PeekEntries['flag'][flag]) do
                    addEntry(id, entry, context, entity)
                end
            end
        end

        if PeekEntries['entity'][context.type] then
            for id, entry in pairs(PeekEntries['entity'][context.type]) do
                addEntry(id, entry, context, entity)
            end
        end
    end

    for zoneName, zone in pairs(CurrentZones) do
        if zone then
            context.zones[zoneName] = zone.data

            if PeekEntries['polytarget'][zoneName] then
                for id, entry in pairs(PeekEntries['polytarget'][zoneName]) do
                    addEntry(id, entry, context, zoneName)
                end
            end
        end
    end

    StartTrackerThread(listId, entries, tracked, context)
    return entries, context
end

function StartTrackerThread(pTrackerId, pEntries, pTracked, pContext)
    local entity = CurrentTarget
    local playerPed = PlayerPedId()

    local bones, normal, zones = {}, {}, {}

    local entries, updateRequired = pEntries, true

    for id, options in pairs(pTracked) do
        local distance = options.distance

        local visible, callbacks = false, normal

        if distance and distance.boneId then
            local bone = distance.boneId
            local boneIndex = type(bone) == 'string' and GetEntityBoneIndexByName(entity, bone) or GetPedBoneIndex(entity, bone)

            if not bones[boneIndex] then bones[boneIndex] = {} end

            callbacks = bones[boneIndex]
        elseif distance and distance.zone then
            if not zones[distance.zone] then zones[distance.zone] = {} end

            callbacks = zones[distance.zone]
        end

        callbacks[#callbacks + 1] = function(pDistance)
            local inRange = not distance or pDistance <= distance.radius
            local isEnabled = inRange and (not options.isEnabled or options.isEnabled(entity, pContext))

            if inRange and isEnabled and not visible then
                visible = true
                updateRequired = true
                entries[id] = true
            elseif not inRange or not isEnabled and visible then
                visible = false
                updateRequired = true
                entries[id] = false
            end
        end
    end

    Citizen.CreateThread(function()
        while IsPeeking and ListCount == pTrackerId do
            DisablePlayerFiring(PlayerPedId(), true)
            local playerCoords = GetEntityCoords(playerPed)

            if entity then
                for boneIndex, callbacks in pairs(bones) do
                    local targetCoords = GetWorldPositionOfEntityBone(entity, boneIndex)
                    local targetDistance = #(playerCoords - targetCoords)

                    for _, callback in ipairs(callbacks) do
                        callback(targetDistance)
                    end
                end

                if #normal > 0 then
                    local targetCoords = GetEntityCoords(entity)
                    local targetDistance = #(playerCoords - targetCoords)

                    for _, callback in ipairs(normal) do
                        callback(targetDistance)
                    end
                end
            end

            for zoneId, callbacks in pairs(zones) do
                local zone = CurrentZones[zoneId]
                local targetDistance = not zone and 9999.9 or #(playerCoords - zone.vectors)

                for _, callback in ipairs(callbacks) do
                    callback(targetDistance)
                end
            end

            if updateRequired then
                updateRequired = false
                UpdatePeekEntryList(entries)
            end

            if enableWorldPrompts then
                FindNearestZones(playerCoords, 3, entity, pContext)
            end

            Citizen.Wait(150)
        end
    end)
end

function FindNearestZones(playerCoords, count, entity, context)
    NearZones = {}

    local function checkIsEnabled(zone)
        local peekEntries = PeekEntries['polytarget'][zone.name]
        local isEnabled = not peekEntries
        if peekEntries then
            for id,entry in pairs(peekEntries) do
                isEnabled = isEnabled or (not entry.options.isEnabled or entry.options.isEnabled(entity, context))
            end
        end
        return isEnabled
    end

    -- Add `CurrentZones` to `NearZones` first
    for _, zone in ipairs(nearbyZones) do
        local currentZone = CurrentZones[zone.name]
        if currentZone and currentZone.vectors == zone.center and checkIsEnabled(zone) then
            NearZones[#NearZones+1] = {
                id = zone.id,
                center = zone.center,
                active = true,
                dist = #(playerCoords - zone.center),
                opacity = 255
            }
        end
    end

    -- Filter `nearbyZones` to all zones that are not in `CurrentZones` and are closer than 5.0 units from the player
    -- and sort them by their distance to the player
    -- local sortedNearbyZones = Array(nearbyZones)
    --     :Filter(function (zone)
    --         local currentZone = CurrentZones[zone.name]
    --         zone.distanceToPlayer = #(playerCoords - zone.center)
    --         return (currentZone == nil or currentZone.vectors ~= zone.center) and zone.distanceToPlayer < 5.0 and checkIsEnabled(zone)
    --     end)
    --     :Sort(-1, function (a, b) return (a.distanceToPlayer - b.distanceToPlayer) > 0 end)

    -- -- Until `NearZones` has `count` number of zones, keep popping zones off the end of `sortedNearbyZones`
    -- while #NearZones < count and not sortedNearbyZones:isEmpty() do
    --     local zone = sortedNearbyZones:Pop()
    --     NearZones[#NearZones+1] = {
    --         id = zone.id,
    --         center = zone.center,
    --         active = false,
    --         dist = zone.distanceToPlayer,
    --         opacity = 200
    --     }
    -- end
end

function IsActive(pEntries)
    if not pEntries then return end

    for _, active in pairs(pEntries) do
        if active then return true end
    end

    return false
end

function StartPeekin()
    if IsPeeking then return end
    if IsPedArmed(GetPlayerPed(-1), 4 | 2) or IsPedBeingStunned(PlayerPedId()) or IsPedRagdoll(PlayerPedId()) then return end

    local entries, context

    IsPeeking = true
    UpdateRequired = true
    NearZones = {}
    nearbyZones = exports["fa-polytarget"]:GetZones(GetEntityCoords(PlayerPedId())) or {}
    SendNUIMessage({response = "openTarget"})

    Citizen.CreateThread(function()
        local rgbGreen, rgbWhite = {0, 248, 185}, {255, 255, 255}
        local previousZones = {}
        local drawingZones = {}
        local lastUpdate = GetGameTimer()

        RequestStreamedTextureDict("shared")
        while IsPeeking do
            DisablePlayerFiring(PlayerPedId(), true)

            if UpdateRequired then
                UpdateRequired = false
                entries, context = GetCurrentPeekEntryList()
            end

            if IsPeakActive and (IsControlJustPressed(0, 24) or IsDisabledControlJustPressed(0, 24)) then
                SetCursorLocation(0.5, 0.5)
                SetNuiFocus(true,true)
                IsPeeking = true
                SendNUIMessage({response = "interact",  payload = { context = context }})
            end

            if (IsControlJustReleased(0, 68) or IsDisabledControlJustReleased(0, 68)) then
                StopPeekin()
                SetNuiFocus(false, false)
                --SetUIFocus(false, false)
                IsPeeking = false
            end

            if LocalPlayer.state.disabled or LocalPlayer.state.dead or IsPlayerFreeAiming(PlayerId()) then 
                StopPeekin()
                return 
            end

            if enableWorldPrompts then
                local activeZones, nearZoneLookup = {}, {}

                -- Insert all `NearZones` that aren't already being drawn into `drawingZones`
                for _, zone in ipairs(NearZones) do
                    nearZoneLookup[zone.id] = true
                    if zone.active then activeZones[zone.id] = true end
                    if not drawingZones[zone.id] then
                        drawingZones[zone.id] = { zone = zone, type = "in", fade = 0 }
                    end
                end

                -- Insert all `previousZones` that aren't in `NearZones` and aren't already being drawn (or whose fade type == 'in') into `drawingZones`
                for _, zone in ipairs(previousZones) do
                    local inNear = nearZoneLookup[zone.id]
                    if not inNear and (not drawingZones[zone.id] or drawingZones[zone.id].type == "in") then
                        drawingZones[zone.id] = { zone = zone, type = "out", fade = 100 }
                    end
                end

                -- Draw prompts for all zones in `drawingZones`
                local currentTime = GetGameTimer()
                for id, fz in pairs(drawingZones) do
                    local isActive = activeZones[fz.zone.id] ~= nil
                    local opacity = map_range(fz.fade, 0, 100, 0, isActive and 255 or 200)
                    if fz.type == "in" then
                        fz.fade = math.min(fz.fade + 0.55 * (currentTime - lastUpdate), 100)
                    elseif fz.type == "out" then
                        fz.fade = math.max(fz.fade - 0.35 * (currentTime - lastUpdate), 0)
                        if fz.fade == 0 then drawingZones[id] = nil end
                    end

                    SetDrawOrigin(fz.zone.center, 0)
                    local rgb = isActive and rgbGreen or rgbWhite
                    DrawSprite("shared", "emptydot_32", 0, 0, 0.02, 0.035, 0, rgb[1], rgb[2], rgb[3], math.floor(opacity + 0.5))
                    ClearDrawOrigin()
                end

                lastUpdate = currentTime
                previousZones = {table.unpack(NearZones)}
            end

            Wait(0)
        end
    end)
end

function map_range(s, a1, a2, b1, b2)
    return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end

function StopPeekin()
    if not IsPeeking then return end
    if not IsPeakActive then
        IsPeeking = false
        SendNUIMessage({response = "closeTarget"})
    end
end

RegisterNetEvent("fa-target:changed", function(pTarget, pEntityType, pEntityOffset)
    CurrentTarget = pTarget
    CurrentTargetType = pEntityType
    CurrentTargetOffset = pEntityOffset

    UpdateRequired = true
end)

RegisterNetEvent('fa-polyzone:enter', function(zoneName, zoneData, zoneCenter)
    if not PeekEntries['polytarget'][zoneName] then return end

    CurrentZones[zoneName] = { data = zoneData, vectors = zoneCenter }

    if not IsPeeking then return end

    UpdateRequired = true
end)

RegisterNetEvent('fa-polyzone:exit', function(zoneName)
    if not PeekEntries['polytarget'][zoneName] then return end

    CurrentZones[zoneName] = nil

    UpdateRequired = true
end)

RegisterNUICallback('selectTarget', function(data)
    DisablePlayerFiring(PlayerPedId(), true)
    SetCustomNuiFocus(false, false)

    IsPeeking = false

    SendNUIMessage({response = "closeTarget"})

    Wait(100)

    local option = data.option
    local context = data.context or {}

    local event = option.event
    local FYXEvent = option.FYXEvent
    local target = data.context.entity or 0
    local parameters = option.parameters or {}

    if event == nil and FYXEvent ~= nil then
        return FYX.Events.emit(FYXEvent, parameters, target, context)
    end

    parameters["polyZoneCoordinates"] = CurrentTargetOffset
    
    TriggerEvent(event, parameters, target, context)
end)

RegisterNUICallback('closeTarget', function(data)
    DisablePlayerFiring(PlayerPedId(), false)
    SetCustomNuiFocus(false, false)
    
    IsPeeking = false
end)


Citizen.CreateThread(function()
    RegisterCommand('+peek', StartPeekin, false)
    RegisterCommand('-peek', StopPeekin, false)
    RegisterKeyMapping("+peek", "(peek): Peek", "keyboard", "LMENU")
end)


exports('IsPeeking', function() return IsPeeking end)

local ped = PlayerPedId()

--antimeta

Citizen.CreateThread( function()
	local resetcounter = 0
	local jumpDisabled = false
  	while true do 
    Citizen.Wait(1)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(ped) then	
			SetPedToRagdoll(ped, 1000, 1000, 3, 0, 0, 0)
			print("jump")
			resetcounter = 0
		end
		if not jumpDisabled and IsPedJumping(ped) then
			if math.random(2) == 2 then
				jumpDisabled = true
			end
			resetcounter = 1000
			Citizen.Wait(1200)
		end
		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)