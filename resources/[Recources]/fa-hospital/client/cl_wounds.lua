local isBleeding = 0
local bleedTickTimer, advanceBleedTimer = 0, 0
local fadeOutTimer, blackoutTimer = 0, 0

local onDrugs = 0
local wasOnDrugs = false

local legCount = 0
local armcount = 0
local headCount = 0

local playerHealth = nil
local playerArmour = nil

local limbNotifId = 'MHOS_LIMBS'
local bleedNotifId = 'MHOS_BLEED'
local bleedMoveNotifId = 'MHOS_BLEEDMOVE'

local BodyParts = {
    ['HEAD'] = { label = 'Head', causeLimp = false, isDamaged = false, severity = 0 },
    ['NECK'] = { label = 'Neck', causeLimp = false, isDamaged = false, severity = 0 },
    ['SPINE'] = { label = 'Spine', causeLimp = true, isDamaged = false, severity = 0 },
    ['UPPER_BODY'] = { label = 'Upper Body', causeLimp = false, isDamaged = false, severity = 0 },
    ['LOWER_BODY'] = { label = 'Lower Body', causeLimp = true, isDamaged = false, severity = 0 },
    ['LARM'] = { label = 'Left Arm', causeLimp = false, isDamaged = false, severity = 0 },
    ['LHAND'] = { label = 'Left Hand', causeLimp = false, isDamaged = false, severity = 0 },
    ['LFINGER'] = { label = 'Left Hand Fingers', causeLimp = false, isDamaged = false, severity = 0 },
    ['LLEG'] = { label = 'Left Leg', causeLimp = true, isDamaged = false, severity = 0 },
    ['LFOOT'] = { label = 'Left Foot', causeLimp = true, isDamaged = false, severity = 0 },
    ['RARM'] = { label = 'Right Arm', causeLimp = false, isDamaged = false, severity = 0 },
    ['RHAND'] = { label = 'Right Hand', causeLimp = false, isDamaged = false, severity = 0 },
    ['RFINGER'] = { label = 'Right Hand Fingers', causeLimp = false, isDamaged = false, severity = 0 },
    ['RLEG'] = { label = 'Right Leg', causeLimp = true, isDamaged = false, severity = 0 },
    ['RFOOT'] = { label = 'Right Foot', causeLimp = true, isDamaged = false, severity = 0 },
}

local injured = {}

function IsInjuryCausingLimp()
    for k, v in pairs(BodyParts) do
        if v.causeLimp and v.isDamaged then
            return true
        end
    end

    return false
end

function IsInjuredOrBleeding()
    if isBleeding > 0 then
        return true
    else
        for k, v in pairs(BodyParts) do
            if v.isDamaged then
                return true
            end
        end
    end

    return false
end

function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            ClearEntityLastDamageEntity(ped)
            return v
        end
    end

    return nil
end

function ProcessRunStuff(ped)
    if IsInjuryCausingLimp() then
        RequestAnimSet("move_m@injured")
        while not HasAnimSetLoaded("move_m@injured") do
            Citizen.Wait(0)
        end
        SetPedMovementClipset(ped, "move_m@injured", 1 )

        local level = 0
        for k, v in pairs(injured) do
            if v.severity > level then
                level = v.severity
            end
        end

        SetPedMoveRateOverride(ped, Config.MovementRate[level])

    else
        SetPedMoveRateOverride(ped, 1.0)
        ResetPedMovementClipset(ped, 1.0)
    end
end

function ProcessDamage(ped)
    if not IsEntityDead(ped) or not (onDrugs > 0) then
        for k, v in pairs(injured) do
            if (v.part == 'LLEG' and v.severity > 1) or (v.part == 'RLEG' and v.severity > 1) or (v.part == 'LFOOT' and v.severity > 2) or (v.part == 'RFOOT' and v.severity > 2) then
                if legCount >= Config.LegInjuryTimer then
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) then
                        local chance = math.random(100)
                        if (IsPedRunning(ped) or IsPedSprinting(ped)) then
                            if chance <= Config.LegInjuryChance.Running then
                                TriggerEvent('DoLongHudText', 'You\'re Having A Hard Time Running', 5000)
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        else
                            if chance <= Config.LegInjuryChance.Walking then
                                TriggerEvent('DoLongHudText', 'You\'re Having A Hard Using Your Legs', 5000)
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        end
                    end
                    legCount = 0
                else
                    legCount = legCount + 1
                end
            elseif (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) or (v.part == 'RARM' and v.severity > 1) or (v.part == 'RHAND' and v.severity > 1) or (v.part == 'RFINGER' and v.severity > 2) then
                if armcount >= Config.ArmInjuryTimer then
                    local chance = math.random(100)

                    if (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) then
                        local isDisabled = 15
                        Citizen.CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Citizen.Wait(1)
                            end
                        end)
                    else
                        local isDisabled = 15
                        Citizen.CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisableControlAction(0, 25, true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Citizen.Wait(1)
                            end
                        end)
                    end

                    armcount = 0
                else
                    armcount = armcount + 1
                end
            elseif (v.part == 'HEAD' and v.severity > 2) then
                if headCount >= Config.HeadInjuryTimer then
                    local chance = math.random(100)

                    if chance <= Config.HeadInjuryChance then
                        TriggerEvent('DoLongHudText', 'You Suddenly Black Out', 5000)
                        --TriggerEvent('DoLongHudText', 'You Suddenly Black Out', 5000)
                        SetFlash(0, 0, 100, 10000, 100)
                        
                        DoScreenFadeOut(100)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(0)
                        end

                        if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                            SetPedToRagdoll(ped, 5000, 1, 2)
                        end

                        Citizen.Wait(5000)
                        DoScreenFadeIn(250)
                    end
                    headCount = 0
                else
                    headCount = headCount + 1
                end
            end
        end

        if wasOnDrugs then
            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            wasOnDrugs = false
            TriggerEvent('DoLongHudText', 'You\'ve Realized Doing Drugs Does Not Fix All Your Problems', 5000)
        end
    else
        onDrugs = onDrugs - 1

        if not wasOnDrugs then
            wasOnDrugs = true
        end
    end
end

function CheckDamage(ped, bone, weapon)
    if weapon == nil then return end

    if Config.Bones[bone] ~= nil then
        if not BodyParts[Config.Bones[bone]].isDamaged then
            BodyParts[Config.Bones[bone]].isDamaged = true
            BodyParts[Config.Bones[bone]].severity = 1
            --TriggerEvent('DoLongHudText', 'Your ' .. BodyParts[Config.Bones[bone]].label .. ' feels ' .. Config.WoundStates[BodyParts[Config.Bones[bone]].severity], 155)
            if weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER'] or weapon == Config.WeaponClasses['CUTTING'] or weapon == Config.WeaponClasses['WILDLIFE'] or weapon == Config.WeaponClasses['OTHER'] or weapon == Config.WeaponClasses['LIGHT_IMPACT'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance / 2) then
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                        end
    
                        ApplyBleed(1)
                    end
                else
                    ApplyBleed(1)
                end
            elseif weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['HEAVY_IMPACT'] or weapon == Config.WeaponClasses['SHOTGUN'] or weapon == Config.WeaponClasses['EXPLOSIVE'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['SHOTGUN']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance) then
                            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
                        end

                        if isBleeding < 1 then
                            local chance = math.random(100)
                            if chance <= math.ceil(Config.AmorHighCalBleedChance) then
                                ApplyBleed(1)
                            end
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
                        end
                        ApplyBleed(2)
                    end
                else
                    ApplyBleed(2)
                end
            end

            table.insert(injured, {
                part = Config.Bones[bone],
                label = BodyParts[Config.Bones[bone]].label,
                severity = BodyParts[Config.Bones[bone]].severity
            })

            TriggerServerEvent('fa-hospital:server:SyncInjuries', {
                limbs = BodyParts,
                isBleeding = tonumber(isBleeding)
            })

            ProcessRunStuff(ped)
            DoLimbAlert()
            DoBleedAlert()
        else
            if weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER'] or weapon == Config.WeaponClasses['CUTTING'] or weapon == Config.WeaponClasses['WILDLIFE'] or weapon == Config.WeaponClasses['OTHER'] or weapon == Config.WeaponClasses['LIGHT_IMPACT'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance / 2) then
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                        end
    
                        ApplyBleed(1)
                    end
                else
                    ApplyBleed(1)
                end
            elseif weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['HEAVY_IMPACT'] or weapon == Config.WeaponClasses['SHOTGUN'] or weapon == Config.WeaponClasses['EXPLOSIVE'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['SHOTGUN']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance) then
                            SetPedToRagdoll(PlayerPedId(), 1500, 2000, 3, true, true, false)
                        end

                        if isBleeding < 1 then
                            local chance = math.random(100)
                            if chance <= math.ceil(Config.AmorHighCalBleedChance) then
                                ApplyBleed(1)
                            end
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(PlayerPedId(), 1500, 2000, 3, true, true, false)
                        end
    
                        ApplyBleed(2)
                    end
                else
                    ApplyBleed(2)
                end
            end

            if BodyParts[Config.Bones[bone]].severity < 4 then
                BodyParts[Config.Bones[bone]].severity = BodyParts[Config.Bones[bone]].severity + 1
                TriggerServerEvent('fa-hospital:server:SyncInjuries', {
                    limbs = BodyParts,
                    isBleeding = tonumber(isBleeding)
                })

                for k, v in pairs(injured) do
                    if v.part == Config.Bones[bone] then
                        v.severity = BodyParts[Config.Bones[bone]].severity
                    end
                end
            end

            ProcessRunStuff(ped)
            DoLimbAlert()
            DoBleedAlert()
        end
    else
    end
end

function ApplyBleed(level)
    if isBleeding ~= 4 then
        if isBleeding + level > 4 then
            isBleeding = 4
        else
            isBleeding = isBleeding + level
        end
    end
end

function DoLimbAlert()
    local player = PlayerPedId()
    if not IsEntityDead(player) then
        if #injured > 0 then
            local limbDamageMsg = ''
            if #injured > 1 and #injured < 3 then
                for k, v in pairs(injured) do
                    limbDamageMsg = limbDamageMsg .. 'Your ' .. v.label .. ' feels ' .. Config.WoundStates[v.severity]
                    if k < #injured then
                        limbDamageMsg = limbDamageMsg .. ' | '
                    end
                end
            elseif #injured > 2 then
                limbDamageMsg = 'You Feel Multiple Pains'
            else
                limbDamageMsg = 'Your ' .. injured[1].label .. ' feels ' .. Config.WoundStates[injured[1].severity]
            end
    
            TriggerEvent('DoLongHudText', limbDamageMsg, 155)
        else
            Citizen.Wait(1)
        end
    else
        Citizen.Wait(1)
    end
end

function DoBleedAlert()
    local player = PlayerPedId()
    if not IsEntityDead(player) and isBleeding > 0 then
        TriggerEvent("evidence:bleeding")
        TriggerEvent('DoLongHudText', 'You Have ' .. Config.BleedingStates[isBleeding])
    else
        Citizen.Wait(1)
    end
end

RegisterNetEvent('fa-hospital:client:SyncBleed')
AddEventHandler('fa-hospital:client:SyncBleed', function(bleedStatus)
    isBleeding = tonumber(bleedStatus)
    DoBleedAlert()
end)

RegisterNetEvent('fa-hospital:client:FieldTreatLimbs')
AddEventHandler('fa-hospital:client:FieldTreatLimbs', function()
    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 1
    end

    for k, v in pairs(injured) do
        if v.part == Config.Bones[bone] then
            v.severity = BodyParts[Config.Bones[bone]].severity
        end
    end
    
    TriggerServerEvent('fa-hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
end)
RegisterNetEvent('fa-hospital:client:FieldTreatBleed')
AddEventHandler('fa-hospital:client:FieldTreatBleed', function()
    if isBleeding > 1 then
        isBleeding = tonumber(isBleeding) - 1
    
        TriggerServerEvent('fa-hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)

RegisterNetEvent('fa-hospital:client:ReduceBleed')
AddEventHandler('fa-hospital:client:ReduceBleed', function()
    if isBleeding > 0 then
        isBleeding = tonumber(isBleeding) - 1
    
        TriggerServerEvent('fa-hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)


RegisterNetEvent('fa-hospital:client:ResetLimbs')
AddEventHandler('fa-hospital:client:ResetLimbs', function()
    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end
    injured = {}
    
    TriggerServerEvent('fa-hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
end)

RegisterNetEvent('fa-hospital:client:RemoveBleed')
AddEventHandler('fa-hospital:client:RemoveBleed', function()
    isBleeding = 0
    
    TriggerServerEvent('fa-hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoBleedAlert()
end)

local prevPos = nil
Citizen.CreateThread(function()
    prevPos = GetEntityCoords(PlayerPedId(), true)
    while true do
        local player = PlayerPedId()
        if bleedTickTimer >= Config.BleedTickRate then
            if not IsEntityDead(player) then
                if isBleeding > 0 then
                    if isBleeding == 1 then
                        SetFlash(0, 0, 100, 100, 100)
                    elseif isBleeding == 2 then
                        SetFlash(0, 0, 100, 250, 100)
                    elseif isBleeding == 3 then
                        SetFlash(0, 0, 100, 500, 100)
                        --Function.Call(Hash.SET_FLASH, 0, 0, 100, 500, 100);
                    elseif isBleeding == 4 then
                        SetFlash(0, 0, 100, 500, 100)
                        --Function.Call(Hash.SET_FLASH, 0, 0, 100, 500, 100);
                    end
                    
                    if fadeOutTimer % Config.FadeOutTimer == 0 then
                        if blackoutTimer >= Config.BlackoutTimer then
                            TriggerEvent('DoLongHudText', 'You Suddenly Black Out', 5000)
                            SetFlash(0, 0, 100, 7000, 100)
                                
                            DoScreenFadeOut(500)
                            while not IsScreenFadedOut() do
                                Citizen.Wait(0)
                            end
                    
                            if not IsPedRagdoll(player) and IsPedOnFoot(player) and not IsPedSwimming(player) then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(PlayerPedId(), 7500, 9000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                    
                            Citizen.Wait(1500)
                            DoScreenFadeIn(1000)
                            blackoutTimer = 0
                        else
                            DoScreenFadeOut(2000)
                            while not IsScreenFadedOut() do
                                Citizen.Wait(0)
                            end
                            DoScreenFadeIn(2000)
                            if isBleeding > 3 then
                                blackoutTimer = blackoutTimer + 2
                            else
                                blackoutTimer = blackoutTimer + 1
                            end
                            fadeOutTimer = 0
                        end
                    else
                        fadeOutTimer = fadeOutTimer + 1
                    end

                    --TriggerEvent('DoLongHudText', 'You Have ' .. Config.BleedingStates[isBleeding], 25000)
                    local bleedDamage = tonumber(isBleeding) * Config.BleedTickDamage
                    ApplyDamageToPed(player, bleedDamage, false)
                    playerHealth = playerHealth - bleedDamage

                    if advanceBleedTimer >= Config.AdvanceBleedTimer then
                        ApplyBleed(1)
                        DoBleedAlert()
                        advanceBleedTimer = 0
                    end

                end
            end
            bleedTickTimer = 0
        else
            if math.floor(bleedTickTimer % (Config.BleedTickRate / 10)) == 0 then
                local currPos = GetEntityCoords(player, true)
                local moving = #(vector2(prevPos.x, prevPos.y) - vector2(currPos.x, currPos.y))
                if (moving > 1) and isBleeding > 2 then
                    TriggerEvent('DoLongHudText', 'You notice blood oozing from your wounds faster when you\'re moving', 155)
                    advanceBleedTimer = advanceBleedTimer + Config.BleedMovementAdvance
                    bleedTickTimer = bleedTickTimer + Config.BleedMovementTick
                    prevPos = currPos
                else
                    advanceBleedTimer = advanceBleedTimer + 1
                    bleedTickTimer = bleedTickTimer + 1
                end

            else

            end
            bleedTickTimer = bleedTickTimer + 1
        end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped) - 100
        local armor = GetPedArmour(ped)

        if not playerHealth then
            playerHealth = health
        end

        if not playerArmor then
            playerArmor = armor
        end

        local armorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
        local healthDamaged = (playerHealth ~= health and health < (playerHealth - Config.HealthDamage)) -- Players health was damaged
        
        if armorDamaged or healthDamaged then
            local hit, bone = GetPedLastDamageBone(ped)
            local bodypart = Config.Bones[bone]

            if hit and bodypart ~= 'NONE' then
                local checkDamage = true
                local weapon = GetDamagingWeapon(ped)
                if weapon ~= nil then
                    if armorDamaged and (bodypart == 'SPINE' or bodypart == 'LOWER_BODY') and weapon <= Config.WeaponClasses['LIGHT_IMPACT'] and weapon ~= Config.WeaponClasses['NOTHING'] then
                        checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                    end

                    if checkDamage then
                        CheckDamage(ped, bone, weapon)
                    end
                end
            end
        end

        playerHealth = health
        playerArmor = armor
        Citizen.Wait(500)

		ProcessDamage(ped)
		Citizen.Wait(500)
	end
end)

--[[ Player Died Events ]]--


RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
    TriggerEvent('fa-hospital:client:ResetLimbs')
    TriggerEvent('fa-hospital:client:RemoveBleed')
end)

RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
    TriggerEvent('fa-hospital:client:ResetLimbs')
    TriggerEvent('fa-hospital:client:RemoveBleed')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    end
end)