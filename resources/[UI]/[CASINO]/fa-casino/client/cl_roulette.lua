-- Config = {}

-- Config.Debug = false -- enable debug messages in sv/cl console
-- Config.TestTicker = nil -- need for testing the numbers, you can change the fix roulette tick by /rultick [1-38]

-- Config.RouletteStart = 25 -- how many seconds to start the rulett after you sit down

-- Config.RouletteTables = {
--     -- you can implement tables easily or delete them.
--     [0] = {
--         position = vector3(1041.3081, 49.591884, 68.059226),
--         rot = -45.0,
--         minBet = 25,
--         maxBet = 250,
--         isHighTable = false
--     },
--     [1] = {
--         position = vector3(1039.3489, 58.096839, 68.021011),
--         rot = 135.0,
--         minBet = 25,
--         maxBet = 250,
--         isHighTable = false
--     },
--     [2] = {
--         position = vector3(1133.68115234375, 262.01678466796875, -52.03075408935547),
--         rot = -156.0,
--         minBet = 100,
--         maxBet = 1000,
--         isHighTable = true
--     },
--     [3] = {
--         position = vector3(1129.53955078125, 267.06097412109375, -52.03075408935547),
--         rot = 26.0,
--         minBet = 100,
--         maxBet = 1000,
--         isHighTable = true
--     }
-- }

-- Config.ChairIds = {
--     ['Chair_Base_01'] = 1,
--     ['Chair_Base_02'] = 2,
--     ['Chair_Base_03'] = 3,
--     ['Chair_Base_04'] = 4
-- }

-- Config.rouletteNumbers = {
--     [1] = '00',
--     [2] = '27',
--     [3] = '10',
--     [4] = '25',
--     [5] = '29',
--     [6] = '12',
--     [7] = '8',
--     [8] = '19',
--     [9] = '31',
--     [10] = '18',
--     [11] = '6',
--     [12] = '21',
--     [13] = '33',
--     [14] = '16',
--     [15] = '4',
--     [16] = '23',
--     [17] = '35',
--     [18] = '14',
--     [19] = '2',
--     [20] = '0',
--     [21] = '28',
--     [22] = '9',
--     [23] = '26',
--     [24] = '30',
--     [25] = '11',
--     [26] = '7',
--     [27] = '20',
--     [28] = '32',
--     [29] = '17',
--     [30] = '5',
--     [31] = '22',
--     [32] = '34',
--     [33] = '15',
--     [34] = '3',
--     [35] = '24',
--     [36] = '36',
--     [37] = '13',
--     [38] = '1'
-- }

-- Config.DebugMsg = function(msg)
--     if Config.Debug then
--         print(msg)
--     end
-- end

-- RouletteNumbers = {}
-- RouletteNumbers.Red = {
--     ['1'] = true,
--     ['3'] = true,
--     ['5'] = true,
--     ['7'] = true,
--     ['9'] = true,
--     ['12'] = true,
--     ['14'] = true,
--     ['16'] = true,
--     ['18'] = true,
--     ['19'] = true,
--     ['21'] = true,
--     ['23'] = true,
--     ['25'] = true,
--     ['27'] = true,
--     ['30'] = true,
--     ['32'] = true,
--     ['34'] = true,
--     ['36'] = true
-- }
-- RouletteNumbers.Black = {
--     ['2'] = true,
--     ['4'] = true,
--     ['6'] = true,
--     ['8'] = true,
--     ['10'] = true,
--     ['11'] = true,
--     ['13'] = true,
--     ['15'] = true,
--     ['17'] = true,
--     ['20'] = true,
--     ['22'] = true,
--     ['24'] = true,
--     ['26'] = true,
--     ['28'] = true,
--     ['29'] = true,
--     ['31'] = true,
--     ['33'] = true,
--     ['35'] = true
-- }
-- RouletteNumbers.Even = {
--     ['2'] = true,
--     ['4'] = true,
--     ['6'] = true,
--     ['8'] = true,
--     ['10'] = true,
--     ['12'] = true,
--     ['14'] = true,
--     ['16'] = true,
--     ['18'] = true,
--     ['20'] = true,
--     ['22'] = true,
--     ['24'] = true,
--     ['26'] = true,
--     ['28'] = true,
--     ['30'] = true,
--     ['32'] = true,
--     ['34'] = true,
--     ['36'] = true
-- }
-- RouletteNumbers.Odd = {
--     ['1'] = true,
--     ['3'] = true,
--     ['5'] = true,
--     ['7'] = true,
--     ['9'] = true,
--     ['11'] = true,
--     ['13'] = true,
--     ['15'] = true,
--     ['17'] = true,
--     ['19'] = true,
--     ['21'] = true,
--     ['23'] = true,
--     ['25'] = true,
--     ['27'] = true,
--     ['29'] = true,
--     ['31'] = true,
--     ['33'] = true,
--     ['35'] = true
-- }
-- RouletteNumbers.to18 = {
--     ['1'] = true,
--     ['2'] = true,
--     ['3'] = true,
--     ['4'] = true,
--     ['5'] = true,
--     ['6'] = true,
--     ['7'] = true,
--     ['8'] = true,
--     ['9'] = true,
--     ['10'] = true,
--     ['11'] = true,
--     ['12'] = true,
--     ['13'] = true,
--     ['14'] = true,
--     ['15'] = true,
--     ['16'] = true,
--     ['17'] = true,
--     ['18'] = true
-- }
-- RouletteNumbers.to36 = {
--     ['19'] = true,
--     ['20'] = true,
--     ['21'] = true,
--     ['22'] = true,
--     ['23'] = true,
--     ['24'] = true,
--     ['25'] = true,
--     ['26'] = true,
--     ['27'] = true,
--     ['28'] = true,
--     ['29'] = true,
--     ['30'] = true,
--     ['31'] = true,
--     ['32'] = true,
--     ['33'] = true,
--     ['34'] = true,
--     ['35'] = true,
--     ['36'] = true
-- }
-- RouletteNumbers.first12 = {
--     ['1'] = true,
--     ['2'] = true,
--     ['3'] = true,
--     ['4'] = true,
--     ['5'] = true,
--     ['6'] = true,
--     ['7'] = true,
--     ['8'] = true,
--     ['9'] = true,
--     ['10'] = true,
--     ['11'] = true,
--     ['12'] = true
-- }
-- RouletteNumbers.second12 = {
--     ['13'] = true,
--     ['14'] = true,
--     ['15'] = true,
--     ['16'] = true,
--     ['17'] = true,
--     ['18'] = true,
--     ['19'] = true,
--     ['20'] = true,
--     ['21'] = true,
--     ['22'] = true,
--     ['23'] = true,
--     ['24'] = true
-- }
-- RouletteNumbers.third12 = {
--     ['25'] = true,
--     ['26'] = true,
--     ['27'] = true,
--     ['28'] = true,
--     ['29'] = true,
--     ['30'] = true,
--     ['31'] = true,
--     ['32'] = true,
--     ['33'] = true,
--     ['34'] = true,
--     ['35'] = true,
--     ['36'] = true
-- }
-- RouletteNumbers.row1 = {
--     ['1'] = true,
--     ['4'] = true,
--     ['7'] = true,
--     ['10'] = true,
--     ['13'] = true,
--     ['16'] = true,
--     ['19'] = true,
--     ['22'] = true,
--     ['25'] = true,
--     ['28'] = true,
--     ['31'] = true,
--     ['34'] = true
-- }
-- RouletteNumbers.row2 = {
--     ['2'] = true,
--     ['5'] = true,
--     ['8'] = true,
--     ['11'] = true,
--     ['14'] = true,
--     ['17'] = true,
--     ['20'] = true,
--     ['23'] = true,
--     ['26'] = true,
--     ['29'] = true,
--     ['32'] = true,
--     ['35'] = true
-- }
-- RouletteNumbers.row3 = {
--     ['3'] = true,
--     ['6'] = true,
--     ['9'] = true,
--     ['12'] = true,
--     ['15'] = true,
--     ['18'] = true,
--     ['21'] = true,
--     ['24'] = true,
--     ['27'] = true,
--     ['30'] = true,
--     ['33'] = true,
--     ['36'] = true
-- }

-- SITTING_SCENE = nil
-- CURRENT_CHAIR_DATA = nil
-- SELECTED_CHAIR_ID = nil
-- selectedRoulette = nil
-- Roulettes = {}
-- currentBetAmount = 0
-- idleTimer = 0
-- aimingAtBet = -1
-- lastAimedBet = -1

-- local cooldown = false

-- RegisterNetEvent('fa-casino:setBalance')
-- AddEventHandler('fa-casino:setBalance', function() 
--     SendNUIMessage({action = 'setCurrentChips', amount = exports["fa-inventory"]:getQuantity("redchip") })
-- end)

-- local function DrawText3Ds(coords, text)
--     local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     SetTextScale(0.35, 0.35)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 215)
--     SetTextEntry("STRING")
--     SetTextCentre(1)
--     AddTextComponentString(text)
--     DrawText(_x,_y)
--     local factor = (string.len(text)) / 370
--     DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
-- end

-- local function ShowHelpNotification(msg, thisFrame, beep, duration)
-- 	AddTextEntry('rouletteHelpNotification', msg)
-- 	if thisFrame then
-- 		DisplayHelpTextThisFrame('rouletteHelpNotification', false)
-- 	else
-- 		if beep == nil then beep = true end
-- 		BeginTextCommandDisplayHelp('rouletteHelpNotification')
-- 		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
-- 	end
-- end

-- createRouletteTable = function(index, data)
--     local self = {}

--     self.index = index
--     self.data = data

--     Config.DebugMsg(string.format('Roulette table creating.. %s', self.index))

--     RequestModel(GetHashKey('vw_prop_casino_roulette_01'))
--     while not HasModelLoaded(GetHashKey('vw_prop_casino_roulette_01')) do
--         Citizen.Wait(1)
--     end

--     self.tableObject = CreateObject(GetHashKey('vw_prop_casino_roulette_01'), data.position, false)
--     SetEntityHeading(self.tableObject, data.rot)

--     RequestModel(GetHashKey('S_F_Y_Casino_01'))
--     while not HasModelLoaded(GetHashKey('S_F_Y_Casino_01')) do
--         Citizen.Wait(1)
--     end

--     local pedOffset = GetObjectOffsetFromCoords(data.position.x, data.position.y, data.position.z, data.rot, 0.0, 0.7, 1.0)
--     self.ped = CreatePed(2, GetHashKey('S_F_Y_Casino_01'), pedOffset, data.rot + 180.0, false, true)

--     SetEntityCanBeDamaged(self.ped, 0)
--     SetPedAsEnemy(self.ped, 0)
--     SetBlockingOfNonTemporaryEvents(self.ped, 1)
--     SetPedResetFlag(self.ped, 249, 1)
--     SetPedConfigFlag(self.ped, 185, true)
--     SetPedConfigFlag(self.ped, 108, true)
--     SetPedCanEvasiveDive(self.ped, 0)
--     SetPedCanRagdollFromPlayerImpact(self.ped, 0)
--     SetPedConfigFlag(self.ped, 208, true)

--     -- 1.0.1
--     SetPedVoiceGroup(self.ped, 'S_M_Y_Casino_01_WHITE_01')
--     addRandomClothes(self.ped)

--     TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'idle', 3.0, 3.0, -1, 2, 0, true, true, true)

--     self.numbersData = {}
--     self.betData = {}
--     self.hoverObjects = {}
--     self.betObjects = {}
--     self.ballObject = nil

--     self.RouletteCam = nil
--     self.cameraMode = 1

--     self.enableCamera = function(state)
--         if state then
--             self.speakPed('MINIGAME_DEALER_GREET')
--             DisplayRadar(false)
--             TriggerEvent('ShowPlayerHud', false)
--             SendNUIMessage({action = 'show', state = true})
--             SendNUIMessage({action = 'setBetAmount', amount = currentBetAmount})
--             updateRouletteGame(self.index, self.time, self.status)

--             Config.DebugMsg('creating camera..')
--             local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
--             self.RouletteCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', self.data.position.x, self.data.position.y, self.data.position.z + 2.0, rot.x, rot.y, rot.z, 80.0, true, 2)
--             SetCamActive(self.RouletteCam, true)
--             RenderScriptCams(true, 900, 900, true, false)
--             Config.DebugMsg('camera setted active.')

--             selectedRoulette = self.index
--             self.betRenderState(true)

--             playRouletteIdle()

--             Citizen.CreateThread(function()
--                 while selectedRoulette ~= nil do
--                     Citizen.Wait(1000)

--                     if idleTimer ~= nil then
--                         idleTimer = idleTimer - 1
--                         if idleTimer < 1 then
--                             Config.DebugMsg('start idle')
--                             idleTimer = nil
--                             playRouletteIdle()
--                         end
--                     end
--                 end
--             end)

--             Citizen.CreateThread(function()
--                 while selectedRoulette ~= nil do
--                     Citizen.Wait(1)

--                     if self.betObjects then
--                         for i = 1, #self.betObjects, 1 do
--                             local bet = self.betObjects[i]
--                             if DoesEntityExist(bet.obj) then
--                                 local coords = GetEntityCoords(bet.obj)
--                                 if bet.playerSrc == GetPlayerServerId(PlayerId()) then
--                                     DrawText3Ds(coords, string.format('~w~%s', bet.betAmount))
--                                     --ESX.Game.Utils.DrawText3D(coords, string.format('~w~%s', bet.betAmount), 0.10, 0)
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end)

--             Citizen.CreateThread(function()
--                 while selectedRoulette ~= nil do
--                     Citizen.Wait(0)
--                     DisableAllControlActions(0)

--                     ShowHelpNotification('~INPUT_CELLPHONE_CANCEL~ Stand up\n~INPUT_CONTEXT~ Change camera\n~INPUT_LOOK_LR~ Select number\n~INPUT_ATTACK~ Bet number\n~INPUT_JUMP~ Custom bet amount')

--                     if IsDisabledControlJustPressed(0, 177) then
--                         self.enableCamera(false)
--                         PlaySoundFrontend(-1, 'FocusOut', 'HintCamSounds', false)
--                     end
--                     if IsDisabledControlJustPressed(0, 38) then
--                         self.changeCameraMode()
--                         PlaySoundFrontend(-1, 'FocusIn', 'HintCamSounds', false)
--                     end

--                     if IsDisabledControlJustPressed(0, 22) then --Custom Bet [space]
--                         local minBet = Config.RouletteTables[selectedRoulette].minBet
--                         local maxBet = Config.RouletteTables[selectedRoulette].maxBet
                        
--                         local keyboard = exports["fa-dialog"]:KeyboardInput({
--                             header = "Place Bet", 
--                             rows = { { id = 0, label = "Bet Amount", helper = "Bet Amount ($"..minBet..'- $'..maxBet..')' } }
--                         })
--                         if keyboard and keyboard[1] then
--                             local tmpInput = tonumber(keyboard[1].input)

--                             if tonumber(tmpInput) then
--                                 tmpInput = tonumber(tmpInput)
--                                 if tmpInput > 0 then
--                                     if tmpInput < minBet then
--                                         TriggerEvent('DoLongHudText', 'The minimum for this table is $'..minBet, 2)
--                                     elseif tmpInput > maxBet then
--                                         TriggerEvent('DoLongHudText', 'The maximum for this table is $'..maxBet, 2)
--                                     else
--                                         changeBetAmount(tmpInput)
--                                     end                                       
--                                 end
--                             end                                
--                         end
--                     end
--                 end
--             end)
--             Citizen.Wait(1500)
--         else
--             TriggerServerEvent('fa-roulette:notUsing', selectedRoulette)

--             SendNUIMessage({action = 'show', state = false})

--             if DoesCamExist(self.RouletteCam) then
--                 DestroyCam(self.RouletteCam, false)
--             end
--             RenderScriptCams(false, 900, 900, true, false)
--             self.betRenderState(false)
--             Config.DebugMsg('camera deleted.')
--             selectedRoulette = nil
--             self.speakPed('MINIGAME_DEALER_LEAVE_NEUTRAL_GAME')

--             NetworkStopSynchronisedScene(SITTING_SCENE)

--             local endingDict = 'anim_casino_b@amb@casino@games@shared@player@'
--             RequestAnimDict(endingDict)
--             while not HasAnimDictLoaded(endingDict) do
--                 Citizen.Wait(1)
--             end

--             local whichAnim = nil
--             if SELECTED_CHAIR_ID == 1 then
--                 whichAnim = 'sit_exit_left'
--             elseif SELECTED_CHAIR_ID == 2 then
--                 whichAnim = 'sit_exit_right'
--             elseif SELECTED_CHAIR_ID == 3 then
--                 whichAnim = ({'sit_exit_left', 'sit_exit_right'})[math.random(1, 2)]
--             elseif SELECTED_CHAIR_ID == 4 then
--                 whichAnim = 'sit_exit_left'
--             end

--             TaskPlayAnim(PlayerPedId(), endingDict, whichAnim, 1.0, 1.0, 2500, 0)
--             SetPlayerControl(PlayerId(), 0, 0)
--             Citizen.Wait(3600)
--             SetPlayerControl(PlayerId(), 1, 0)

--             DisplayRadar(true)
--             TriggerEvent('ShowPlayerHud', true)
--         end
--     end

--     self.changeCameraMode = function()
--         if DoesCamExist(self.RouletteCam) then
--             if self.cameraMode == 1 then
--                 DoScreenFadeOut(200)
--                 while not IsScreenFadedOut() do
--                     Citizen.Wait(1)
--                 end
--                 self.cameraMode = 2
--                 local camOffset = GetOffsetFromEntityInWorldCoords(self.tableObject, -1.45, -0.15, 1.45)
--                 SetCamCoord(self.RouletteCam, camOffset)
--                 SetCamRot(self.RouletteCam, -25.0, 0.0, self.data.rot + 270.0, 2)
--                 SetCamFov(self.RouletteCam, 40.0)
--                 ShakeCam(self.RouletteCam, 'HAND_SHAKE', 0.3)
--                 DoScreenFadeIn(200)
--             elseif self.cameraMode == 2 then
--                 DoScreenFadeOut(200)
--                 while not IsScreenFadedOut() do
--                     Citizen.Wait(1)
--                 end
--                 self.cameraMode = 3
--                 local camOffset = GetOffsetFromEntityInWorldCoords(self.tableObject, 1.45, -0.15, 2.15)
--                 SetCamCoord(self.RouletteCam, camOffset)
--                 SetCamRot(self.RouletteCam, -58.0, 0.0, self.data.rot + 90.0, 2)
--                 ShakeCam(self.RouletteCam, 'HAND_SHAKE', 0.3)
--                 SetCamFov(self.RouletteCam, 80.0)
--                 DoScreenFadeIn(200)
--             elseif self.cameraMode == 3 then
--                 DoScreenFadeOut(200)
--                 while not IsScreenFadedOut() do
--                     Citizen.Wait(1)
--                 end
--                 self.cameraMode = 4
--                 local camOffset = GetWorldPositionOfEntityBone(self.tableObject, GetEntityBoneIndexByName(self.tableObject, 'Roulette_Wheel'))
--                 local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
--                 SetCamCoord(self.RouletteCam, camOffset + vector3(0.0, 0.0, 0.5))
--                 SetCamRot(self.RouletteCam, rot, 2)
--                 StopCamShaking(self.RouletteCam, false)
--                 SetCamFov(self.RouletteCam, 80.0)
--                 DoScreenFadeIn(200)
--             elseif self.cameraMode == 4 then
--                 DoScreenFadeOut(200)
--                 while not IsScreenFadedOut() do
--                     Citizen.Wait(1)
--                 end
--                 self.cameraMode = 1
--                 local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
--                 SetCamCoord(self.RouletteCam, self.data.position + vector3(0.0, 0.0, 2.0))
--                 SetCamRot(self.RouletteCam, rot, 2)
--                 SetCamFov(self.RouletteCam, 80.0)
--                 StopCamShaking(self.RouletteCam, false)
--                 DoScreenFadeIn(200)
--             end
--         end
--     end

--     self.loadTableData = function()
--         Config.DebugMsg('Table data creating, loading..')
--         self.numbersData = {}
--         self.betData = {}
--         local e = 1
--         for i = 0, 11, 1 do
--             for j = 0, 2, 1 do
--                 table.insert(self.numbersData,
--                     {
--                         name = e + 1,
--                         hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, (0.081 * i) - 0.057, (0.167 * j) - 0.192, 0.9448),
--                         hoverObject = 'vw_prop_vw_marker_02a'
--                     }
--                 )
--                 local offset = nil
--                 if j == 0 then
--                     offset = 0.155
--                 elseif j == 1 then
--                     offset = 0.171
--                 elseif j == 2 then
--                     offset = 0.192
--                 end

--                 table.insert(self.betData,
--                     {
--                         betId = e,
--                         name = e + 1,
--                         pos = GetOffsetFromEntityInWorldCoords(self.tableObject, (0.081 * i) - 0.057, (0.167 * j) - 0.192, 0.9448),
--                         objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.081 * i - 0.057, 0.167 * j - 0.192, 0.9448),
--                         hoverNumbers = {e}
--                     }
--                 )

--                 e = e + 1
--             end
--         end
--         table.insert(
--             self.numbersData,
--             {
--                 name = 'Zero',
--                 hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
--                 hoverObject = 'vw_prop_vw_marker_01a'
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'Zero',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
--                 hoverNumbers = {#self.numbersData}
--             }
--         )
--         table.insert(
--             self.numbersData,
--             {
--                 name = 'Double Zero',
--                 hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
--                 hoverObject = 'vw_prop_vw_marker_01a'
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'Double Zero',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
--                 hoverNumbers = {#self.numbersData}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'RED',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.3, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.3, -0.4, 0.9448),
--                 hoverNumbers = {1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'BLACK',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.5, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.5, -0.4, 0.9448),
--                 hoverNumbers = {0, 2, 4, 6, 8, 9, 11, 13, 15, 18, 20, 22, 24, 26, 27, 29, 31, 33, 35}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'EVEN',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.15, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.15, -0.4, 0.9448),
--                 hoverNumbers = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = 'ODD',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.65, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.65, -0.4, 0.9448),
--                 hoverNumbers = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '1to18',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.02, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.02, -0.4, 0.9448),
--                 hoverNumbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '19to36',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.78, -0.4, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.78, -0.4, 0.9448),
--                 hoverNumbers = {19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '1st 12',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.05, -0.3, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.05, -0.3, 0.9448),
--                 hoverNumbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '2nd 12',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.4, -0.3, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.4, -0.3, 0.9448),
--                 hoverNumbers = {13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '3rd 12',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.75, -0.3, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.75, -0.3, 0.9448),
--                 hoverNumbers = {25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '2to1',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, -0.15, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, -0.15, 0.9448),
--                 hoverNumbers = {1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '2to1',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.0, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.0, 0.9448),
--                 hoverNumbers = {2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35}
--             }
--         )
--         table.insert(
--             self.betData,
--             {
--                 betId = #self.betData,
--                 name = '2to1',
--                 pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.15, 0.9448),
--                 objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.15, 0.9448),
--                 hoverNumbers = {3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36}
--             }
--         )

--         Config.DebugMsg('Table data successfully created..')
--     end

--     self.speakPed = function(speakName)
--         PlayAmbientSpeech1(self.ped, speakName, 'SPEECH_PARAMS_FORCE_NORMAL_CLEAR', 1)
--     end

--     self.createBetObjects = function(bets)
--         for i = 1, #self.betObjects, 1 do
--             if DoesEntityExist(self.betObjects[i].obj) then
--                 DeleteObject(self.betObjects[i].obj)
--             end
--         end

--         self.betObjects = {}

--         local existBetId = {}

--         for i = 1, #bets, 1 do
--             local t = self.betData[bets[i].betId]

--             if existBetId[bets[i].betId] == nil then
--                 existBetId[bets[i].betId] = 0
--             else
--                 existBetId[bets[i].betId] = existBetId[bets[i].betId] + 1
--             end

--             if t ~= nil then
--                 local betModelObject = getBetObjectType(bets[i].betAmount)

--                 if betModelObject ~= nil then
--                     RequestModel(betModelObject)
--                     while not HasModelLoaded(betModelObject) do
--                         Citizen.Wait(0)
--                     end

--                     local obj = CreateObject(betModelObject, t.objectPos.x, t.objectPos.y, t.objectPos.z + (existBetId[bets[i].betId] * 0.0081), false)
--                     SetEntityHeading(obj, self.data.rot)
--                     table.insert(
--                         self.betObjects,
--                         {
--                             obj = obj,
--                             betAmount = bets[i].betAmount,
--                             playerSrc = bets[i].playerSrc
--                         }
--                     )
--                 end
--             end
--         end
--     end

--     self.hoverNumbers = function(hoveredNumbers)
--         for i = 1, #self.hoverObjects, 1 do
--             if DoesEntityExist(self.hoverObjects[i]) then
--                 DeleteObject(self.hoverObjects[i])
--             end
--         end

--         self.hoverObjects = {}

--         for i = 1, #hoveredNumbers, 1 do
--             local t = self.numbersData[hoveredNumbers[i]]
--             if t ~= nil then
--                 RequestModel(GetHashKey(t.hoverObject))
--                 while not HasModelLoaded(GetHashKey(t.hoverObject)) do
--                     Citizen.Wait(1)
--                 end

--                 local obj = CreateObject(GetHashKey(t.hoverObject), t.hoverPos, false)
--                 SetEntityHeading(obj, self.data.rot)

--                 table.insert(self.hoverObjects, obj)
--             end
--         end
--     end

--     self.betRenderState = function(state)
--         enabledBetRender = state

--         Config.DebugMsg('Bet rendering turned: %s', enabledBetRender)

--         if state then
--             Citizen.CreateThread(function()
--                 while enabledBetRender do
--                     Citizen.Wait(8)

--                     if aimingAtBet ~= -1 and lastAimedBet ~= aimingAtBet then
--                         Config.DebugMsg('aimed at different bet.')
--                         lastAimedBet = aimingAtBet
--                         local bettingData = self.betData[aimingAtBet]
--                         if bettingData ~= nil then
--                             self.hoverNumbers(bettingData.hoverNumbers)
--                         else
--                             self.hoverNumbers({})
--                         end
--                     end

--                     if aimingAtBet == -1 and lastAimedBet ~= -1 then
--                         self.hoverNumbers({})
--                     end
--                 end
--             end)

--             Citizen.CreateThread(function()
--                 while enabledBetRender do
--                     Citizen.Wait(0)

--                     ShowCursorThisFrame()

--                     local e = Roulettes[selectedRoulette]
--                     if e ~= nil then
--                         local cx, cy = GetNuiCursorPosition()
--                         local rx, ry = GetActiveScreenResolution()

--                         local n = 30 -- this is for the cursor point, how much to tolerate in range, increasing it you will find it easier to click on the bets.

--                         local foundBet = false

--                         for i = 1, #self.betData, 1 do
--                             local bettingData = self.betData[i]
--                             local onScreen, screenX, screenY = World3dToScreen2d(bettingData.pos.x, bettingData.pos.y, bettingData.pos.z)
--                             local l = math.sqrt(math.pow(screenX * rx - cx, 2) + math.pow(screenY * ry - cy, 2))
--                             if l < n then
--                                 aimingAtBet = i
--                                 foundBet = true

--                                 if IsDisabledControlJustPressed(0, 24) then
--                                     if currentBetAmount > 0 then
--                                         if not cooldown then
--                                             if Config.RouletteTables[selectedRoulette] ~= nil then
--                                                 if currentBetAmount >= Config.RouletteTables[selectedRoulette].minBet and currentBetAmount <= Config.RouletteTables[selectedRoulette].maxBet then
--                                                     cooldown = true
--                                                     CreateThread(function()
--                                                         Wait(2500)
--                                                         cooldown = false
--                                                     end)
--                                                     PlaySoundFrontend(-1, 'DLC_VW_BET_DOWN', 'dlc_vw_table_games_frontend_sounds', true)
--                                                     TriggerServerEvent('fa-roulette:taskBetRoulette', selectedRoulette, aimingAtBet, currentBetAmount)
--                                                 else
--                                                     TriggerEvent('DoLongHudText', 'Your bet it too low or too high for this table.', 2)
--                                                 end
--                                             end
--                                         else
--                                             TriggerEvent('DoLongHudText', 'Fuck off you spammer.', 2)
--                                         end
--                                     else
--                                         TriggerEvent('DoLongHudText', 'Invalid bet amount.', 2)
--                                     end
--                                 end
--                             end
--                         end

--                         if not foundBet then
--                             aimingAtBet = -1
--                         end
--                     end
--                 end
--             end)
--         end
--     end

--     self.spinRulett = function(tickRate)
--         Config.DebugMsg(self.index)
--         if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
--             Config.DebugMsg('spinRoulette event 1')

--             self.speakPed('MINIGAME_DEALER_CLOSED_BETS')
--             TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'no_more_bets', 3.0, 3.0, -1, 0, 0, true, true, true)

--             Citizen.Wait(1500)

--             if DoesEntityExist(self.ballObject) then
--                 DeleteObject(self.ballObject)
--             end

--             TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'spin_wheel', 3.0, 3.0, -1, 0, 0, true, true, true)

--             RequestModel(GetHashKey('vw_prop_roulette_ball'))
--             while not HasModelLoaded(GetHashKey('vw_prop_roulette_ball')) do
--                 Citizen.Wait(1)
--             end

--             local ballOffset = GetWorldPositionOfEntityBone(self.tableObject, GetEntityBoneIndexByName(self.tableObject, 'Roulette_Wheel'))

--             Config.DebugMsg('spinRoulette event 2')

--             local LIB = 'anim_casino_b@amb@casino@games@roulette@table'
--             RequestAnimDict(LIB)
--             while not HasAnimDictLoaded(LIB) do
--                 Citizen.Wait(1)
--             end

--             Citizen.Wait(3000)

--             self.ballObject = CreateObject(GetHashKey('vw_prop_roulette_ball'), ballOffset, false)
--             SetEntityHeading(self.ballObject, self.data.rot)
--             SetEntityCoordsNoOffset(self.ballObject, ballOffset, false, false, false)
--             local h = GetEntityRotation(self.ballObject)
--             SetEntityRotation(self.ballObject, h.x, h.y, h.z + 90.0, 2, false)

--             if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
--                 Config.DebugMsg('spinRoulette event 3')

--                 PlayEntityAnim(self.ballObject, 'intro_ball', LIB, 1000.0, false, true, true, 0, 136704)
--                 PlayEntityAnim(self.ballObject, 'loop_ball', LIB, 1000.0, false, true, false, 0, 136704)

--                 PlayEntityAnim(self.tableObject, 'intro_wheel', LIB, 1000.0, false, true, true, 0, 136704)
--                 PlayEntityAnim(self.tableObject, 'loop_wheel', LIB, 1000.0, false, true, false, 0, 136704)

--                 PlayEntityAnim(self.ballObject, string.format('exit_%s_ball', tickRate), LIB, 1000.0, false, true, false, 0, 136704)
--                 PlayEntityAnim(self.tableObject, string.format('exit_%s_wheel', tickRate), LIB, 1000.0, false, true, false, 0, 136704)

--                 Citizen.Wait(11e3)

--                 if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
--                     TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'clear_chips_zone1', 3.0, 3.0, -1, 0, 0, true, true, true)
--                     Citizen.Wait(1500)
--                     TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'clear_chips_zone2', 3.0, 3.0, -1, 0, 0, true, true, true)
--                     Citizen.Wait(1500)
--                     TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'clear_chips_zone3', 3.0, 3.0, -1, 0, 0, true, true, true)

--                     Citizen.Wait(2000)
--                     if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
--                         TaskPlayAnim(self.ped, 'anim_casino_b@amb@casino@games@roulette@dealer_female', 'idle', 3.0, 3.0, -1, 0, 0, true, true, true)
--                     end

--                     Config.DebugMsg('spinRulett event ending')

--                     if DoesEntityExist(self.ballObject) then
--                         DeleteObject(self.ballObject)
--                     end
--                 end
--             end
--         end
--     end

--     self.loadTableData()
--     Config.DebugMsg(string.format('Rulett table created %s id', self.index))
--     Roulettes[self.index] = self
-- end

-- function changeBetAmount(amount)
--     currentBetAmount = amount
--     SendNUIMessage({action = 'setBetAmount', amount = amount})
--     PlaySoundFrontend(-1, 'DLC_VW_BET_HIGHLIGHT', 'dlc_vw_table_games_frontend_sounds', true)
-- end

-- function getGenericTextInput(type)
--     if type == nil then
--         type = ''
--     end
--     AddTextEntry('FMMC_MPM_NA', tostring(type))
--     DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', tostring(type), '', '', '', '', 30)
--     while (UpdateOnscreenKeyboard() == 0) do
--         DisableAllControlActions(0)
--         Wait(0)
--     end
--     if (GetOnscreenKeyboardResult()) then
--         local result = GetOnscreenKeyboardResult()
--         if result then
--             return result
--         end
--     end
--     return false
-- end

-- local casinoLoaded = false

-- RegisterCommand('roulette_load', function()
--     TriggerEvent('fa-casino:events:entered')
-- end)

-- AddEventHandler('fa-casino:events:entered', function()
--     print("Has the casino roulette data loaded yet?", casinoLoaded) 
--     if casinoLoaded then return end;
--     casinoLoaded = true
--     for rouletteIndex, data in pairs(Config.RouletteTables) do
--         createRouletteTable(rouletteIndex, data)
--         RequestAnimDict('anim_casino_b@amb@casino@games@roulette@table')
--         RequestAnimDict('anim_casino_b@amb@casino@games@roulette@dealer_female')
--         RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
--         RequestAnimDict('anim_casino_b@amb@casino@games@roulette@player')
--     end
--     Config.DebugMsg('Casino rulett loaded.')
-- end)

-- RegisterNetEvent('fa-roulette:isSeatUsed')
-- AddEventHandler('fa-roulette:isSeatUsed', function(data, a1)
--     local k = data['k']
--     SELECTED_CHAIR_ID = data['closestChairData']
--     CURRENT_CHAIR_DATA = a1
--     SITTING_SCENE = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, CURRENT_CHAIR_DATA.rotation, 2, 1, 0, 1065353216, 0, 1065353216)
--     RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
--     while not HasAnimDictLoaded('anim_casino_b@amb@casino@games@shared@player@') do Wait(100)  end
--     local randomSit = ({'sit_enter_left', 'sit_enter_right'})[math.random(1, 2)]
--     NetworkAddPedToSynchronisedScene(
--         PlayerPedId(),
--         SITTING_SCENE,
--         'anim_casino_b@amb@casino@games@shared@player@',
--         randomSit,
--         2.0,
--         -2.0,
--         13,
--         16,
--         2.0,
--         0
--     )
--     NetworkStartSynchronisedScene(SITTING_SCENE)
--     SetPlayerControl(PlayerId(), 0, 0)
--     startRoulette(k, CURRENT_CHAIR_DATA.chairId)
--     Wait(4000)
--     SetPlayerControl(PlayerId(), 1, 0)
-- end)

-- AddEventHandler('fa-casino:roulette:selectChair', function(data)
--     local entity = data.entity
--     if exports['fa-casino']:inCasino() then
--         for k, v in pairs(Roulettes) do
--             if DoesEntityExist(v.tableObject) then
--                 if v.tableObject == entity then
--                     local closestChairData = getClosestChairData(v.tableObject)
--                     if closestChairData == nil then break end

--                     if v.data then
--                         print("Is this high table?", v.data.isHighTable)
--                         if v.data.isHighTable then
--                             if exports['fa-inventory']:hasEnoughOfItem('casinovip', 1) then
--                                 TriggerServerEvent('fa-roulette:isSeatUsed', { k = k, closestChairData = closestChairData.chairId}, closestChairData)
--                             else
--                                 TriggerEvent('DoLongHudText', 'You need to use a casino card in order to play this game.', 2)
--                             end
--                         else
--                             TriggerServerEvent('fa-roulette:isSeatUsed', { k = k, closestChairData = closestChairData.chairId}, closestChairData)
--                         end
--                         break
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- function startRoulette(index, chairId)
--     if Roulettes[index] then
--         TriggerServerEvent('fa-roulette:taskStartRoulette', index, chairId)
--     end
-- end

-- RegisterNetEvent('fa-roulette:openRoulette')
-- AddEventHandler('fa-roulette:openRoulette',function(rouletteIndex)
--     if Roulettes[rouletteIndex] ~= nil then
--         Citizen.Wait(4000)
--         Roulettes[rouletteIndex].enableCamera(true)
--     end
-- end)

-- RegisterNetEvent('fa-roulette:startSpin')
-- AddEventHandler(
--     'fa-roulette:startSpin',
--     function(rouletteIndex, tickRate)
--         if Roulettes[rouletteIndex] ~= nil then
--             Config.DebugMsg(string.format('rulett table index: %s, tickrate: %s', rouletteIndex, tickRate))
--             Roulettes[rouletteIndex].spinRulett(tickRate)

--             if selectedRoulette == rouletteIndex then
--                 Config.DebugMsg('impartial anim play')
--                 playImpartial()
--             end
--         end
--     end
-- )

-- RegisterNetEvent('fa-roulette:updateStatus')
-- AddEventHandler('fa-roulette:updateStatus', function(rouletteIndex, time, status)
--     if Roulettes and Roulettes[rouletteIndex] ~= nil then
--         Roulettes[rouletteIndex].time = time
--         Roulettes[rouletteIndex].status = status
--         updateRouletteGame(rouletteIndex, time, status)
--     end
-- end)

-- RegisterNetEvent('fa-roulette:updateTableBets')
-- AddEventHandler('fa-roulette:updateTableBets', function(rouletteIndex, bets)
--     if Roulettes[rouletteIndex] ~= nil then
--         Roulettes[rouletteIndex].createBetObjects(bets)
--     end
-- end)

-- function updateRouletteGame(rouletteIndex, time, status)
--     if selectedRoulette == rouletteIndex then
--         if not status then
--             SendNUIMessage(
--                 {
--                     action = 'setGameInfo',
--                     header = 'The game is starting soon..',
--                     text = string.format('%s %s', time, 'seconds.')
--                 }
--             )
--         else
--             SendNUIMessage(
--                 {
--                     action = 'setGameInfo',
--                     header = 'The game is in progress..',
--                     text = nil
--                 }
--             )
--         end
--     end
-- end

-- RegisterNetEvent('fa-roulette:updateChips')
-- AddEventHandler('fa-roulette:updateChips', function()
--     SendNUIMessage({action = 'setCurrentChips', amount = exports["fa-inventory"]:getQuantity("redchip")})
-- end)

-- function getClosestChairData(tableObject)
--     local localPlayer = PlayerPedId()
--     local playerpos = GetEntityCoords(localPlayer)
--     if DoesEntityExist(tableObject) then
--         local chairs = {'Chair_Base_01', 'Chair_Base_02', 'Chair_Base_03', 'Chair_Base_04'}
--         for i = 1, #chairs, 1 do
--             local objcoords = GetWorldPositionOfEntityBone(tableObject, GetEntityBoneIndexByName(tableObject, chairs[i]))
--             local dist = Vdist(playerpos, objcoords)
--             if dist < 1.7 then
--                 return {
--                     position = objcoords,
--                     rotation = GetWorldRotationOfEntityBone(tableObject, GetEntityBoneIndexByName(tableObject, chairs[i])),
--                     chairId = Config.ChairIds[chairs[i]]
--                 }
--             end
--         end
--     end
-- end

-- function getBetObjectType(betAmount)
--     if betAmount < 10 then
--         return GetHashKey('vw_prop_vw_coin_01a')
--     elseif betAmount >= 10 and betAmount < 50 then
--         return GetHashKey('vw_prop_chip_10dollar_x1')
--     elseif betAmount >= 50 and betAmount < 100 then
--         return GetHashKey('vw_prop_chip_50dollar_x1')
--     elseif betAmount >= 100 and betAmount < 500 then
--         return GetHashKey('vw_prop_chip_100dollar_x1')
--     elseif betAmount >= 500 and betAmount < 1000 then
--         return GetHashKey('vw_prop_chip_500dollar_x1')
--     elseif betAmount >= 1000 and betAmount < 5000 then
--         return GetHashKey('vw_prop_chip_1kdollar_x1')
--     elseif betAmount >= 5000 then
--         return GetHashKey('vw_prop_plaq_10kdollar_x1')
--     else -- this should never happen, but yeah.
--         return GetHashKey('vw_prop_plaq_10kdollar_x1')
--     end

--     -- these are deprecated, it looks cool, but it hides some data, you can put it in you like the big chip piles.

--     -- elseif bets[i].betAmount >= 10000 and bets[i].betAmount < 25000 then
--     --     return GetHashKey('vw_prop_vw_chips_pile_01a')
--     -- elseif bets[i].betAmount >= 25000 and bets[i].betAmount < 50000 then
--     --     return GetHashKey('vw_prop_vw_chips_pile_02a')
--     -- elseif bets[i].betAmount >= 50000 then
--     --     return GetHashKey('vw_prop_vw_chips_pile_03a')
--     -- end
-- end

-- RegisterNetEvent('fa-roulette:playBetAnim')
-- AddEventHandler('fa-roulette:playBetAnim', function(chairId)
--     local sex = 0

--     if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
--         sex = 1
--     end

--     local rot = CURRENT_CHAIR_DATA.rotation

--     if chairId == 4 then
--         rot = rot + vector3(0.0, 0.0, 90.0)
--     elseif chairId == 3 then
--         rot = rot + vector3(0.0, 0.0, -180.0)
--     elseif chairId == 2 then
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     elseif chairId == 1 then
--         chairId = 1
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     end

--     local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@play@v01', chairId, chairId)
--     if sex == 1 then
--         L = string.format('anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@play@v01', chairId, chairId)
--     end

--     RequestAnimDict(L)
--     while not HasAnimDictLoaded(L) do
--         Citizen.Wait(1)
--     end

--     if CURRENT_CHAIR_DATA ~= nil then
--         local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
--         NetworkAddPedToSynchronisedScene(
--             PlayerPedId(),
--             currentScene,
--             L,
--             ({'place_bet_zone1', 'place_bet_zone2', 'place_bet_zone3'})[math.random(1, 3)],
--             4.0,
--             -2.0,
--             13,
--             16,
--             1148846080,
--             0
--         )
--         NetworkStartSynchronisedScene(currentScene)

--         idleTimer = 8
--     end
-- end)

-- RegisterNetEvent('fa-roulette:playWinAnim')
-- AddEventHandler('fa-roulette:playWinAnim', function(chairId)
--     local rot = CURRENT_CHAIR_DATA.rotation

--     if chairId == 4 then
--         rot = rot + vector3(0.0, 0.0, 90.0)
--     elseif chairId == 3 then
--         rot = rot + vector3(0.0, 0.0, -180.0)
--     elseif chairId == 2 then
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     elseif chairId == 1 then
--         chairId = 1
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     end

--     local sex = 0
--     local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01', chairId, chairId)

--     if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
--         sex = 1
--     end

--     if sex == 1 then
--         local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01', chairId, chairId)
--     end

--     RequestAnimDict(L)
--     while not HasAnimDictLoaded(L) do
--         Citizen.Wait(1)
--     end

--     if CURRENT_CHAIR_DATA ~= nil then
--         local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
--         NetworkAddPedToSynchronisedScene(PlayerPedId(), currentScene, L, 'reaction_great', 4.0, -2.0, 13, 16, 1148846080, 0)
--         NetworkStartSynchronisedScene(currentScene)

--         idleTimer = 8
--     end
-- end)

-- RegisterNetEvent('fa-roulette:playLossAnim')
-- AddEventHandler('fa-roulette:playLossAnim', function(chairId)
--     local rot = CURRENT_CHAIR_DATA.rotation

--     if chairId == 4 then
--         rot = rot + vector3(0.0, 0.0, 90.0)
--     elseif chairId == 3 then
--         rot = rot + vector3(0.0, 0.0, -180.0)
--     elseif chairId == 2 then
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     elseif chairId == 1 then
--         chairId = 1
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     end

--     local sex = 0
--     local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01', chairId, chairId)

--     if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
--         sex = 1
--     end

--     if sex == 1 then
--         local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01', chairId, chairId)
--     end

--     RequestAnimDict(L)
--     while not HasAnimDictLoaded(L) do
--         Citizen.Wait(1)
--     end

--     if CURRENT_CHAIR_DATA ~= nil then
--         local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
--         NetworkAddPedToSynchronisedScene(
--             PlayerPedId(),
--             currentScene,
--             L,
--             ({'reaction_bad_var01', 'reaction_bad_var02', 'reaction_terrible'})[math.random(1, 3)],
--             4.0,
--             -2.0,
--             13,
--             16,
--             1148846080,
--             0
--         )
--         NetworkStartSynchronisedScene(currentScene)

--         idleTimer = 8
--     end
-- end)

-- function playImpartial()
--     local rot = CURRENT_CHAIR_DATA.rotation

--     if SELECTED_CHAIR_ID == 4 then
--         rot = rot + vector3(0.0, 0.0, 90.0)
--     elseif SELECTED_CHAIR_ID == 3 then
--         rot = rot + vector3(0.0, 0.0, -180.0)
--     elseif SELECTED_CHAIR_ID == 2 then
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     elseif SELECTED_CHAIR_ID == 1 then
--         SELECTED_CHAIR_ID = 1
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     end

--     local sex = 0
--     local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01', SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)

--     if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
--         sex = 1
--     end

--     if sex == 1 then
--         local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01', SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)
--     end

--     RequestAnimDict(L)
--     while not HasAnimDictLoaded(L) do
--         Citizen.Wait(1)
--     end

--     if CURRENT_CHAIR_DATA ~= nil then
--         local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
--         NetworkAddPedToSynchronisedScene(
--             PlayerPedId(),
--             currentScene,
--             L,
--             ({'reaction_impartial_var01', 'reaction_impartial_var02', 'reaction_impartial_var03'})[math.random(1, 3)],
--             4.0,
--             -2.0,
--             13,
--             16,
--             1148846080,
--             0
--         )
--         NetworkStartSynchronisedScene(currentScene)

--         idleTimer = 8
--     end
-- end

-- function playRouletteIdle()
--     local rot = CURRENT_CHAIR_DATA.rotation

--     if SELECTED_CHAIR_ID == 4 then
--         rot = rot + vector3(0.0, 0.0, 90.0)
--     elseif SELECTED_CHAIR_ID == 3 then
--         rot = rot + vector3(0.0, 0.0, -180.0)
--     elseif SELECTED_CHAIR_ID == 2 then
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     elseif SELECTED_CHAIR_ID == 1 then
--         SELECTED_CHAIR_ID = 1
--         rot = rot + vector3(0.0, 0.0, -90.0)
--     end

--     local sex = 0
--     local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@idles', SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)

--     if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
--         sex = 1
--     end

--     if sex == 1 then
--         local L = string.format('anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@idles', SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)
--     end

--     RequestAnimDict(L)
--     while not HasAnimDictLoaded(L) do
--         Citizen.Wait(1)
--     end

--     if CURRENT_CHAIR_DATA ~= nil then
--         local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
--         NetworkAddPedToSynchronisedScene(PlayerPedId(), currentScene, L, ({'idle_a', 'idle_b', 'idle_c', 'idle_d'})[math.random(1, 4)], 1.0, -2.0, 13, 16, 1148846080, 0)
--         NetworkStartSynchronisedScene(currentScene)
--     end
-- end

-- function addRandomClothes(ped)
--     local r = math.random(1,5)

--     if r == 1 then
--         SetPedComponentVariation(ped, 0, 4, 0, 0)
--         SetPedComponentVariation(ped, 1, 0, 0, 0)
--         SetPedComponentVariation(ped, 2, 4, 0, 0)
--         SetPedComponentVariation(ped, 3, 2, 1, 0)
--         SetPedComponentVariation(ped, 4, 1, 0, 0)
--         SetPedComponentVariation(ped, 6, 1, 0, 0)
--         SetPedComponentVariation(ped, 7, 1, 0, 0)
--         SetPedComponentVariation(ped, 8, 2, 0, 0)
--         SetPedComponentVariation(ped, 10, 0, 0, 0)
--         SetPedComponentVariation(ped, 11, 0, 0, 0)
--         SetPedPropIndex(ped, 1, 0, 0, false)
--     elseif r == 2 then
--         SetPedComponentVariation(ped, 0, 3, 1, 0)
--         SetPedComponentVariation(ped, 1, 0, 0, 0)
--         SetPedComponentVariation(ped, 2, 3, 1, 0)
--         SetPedComponentVariation(ped, 3, 1, 1, 0)
--         SetPedComponentVariation(ped, 4, 1, 0, 0)
--         SetPedComponentVariation(ped, 6, 1, 0, 0)
--         SetPedComponentVariation(ped, 7, 2, 0, 0)
--         SetPedComponentVariation(ped, 8, 1, 0, 0)
--         SetPedComponentVariation(ped, 10, 0, 0, 0)
--         SetPedComponentVariation(ped, 11, 0, 0, 0)
--     elseif r == 3 then
--         SetPedComponentVariation(ped, 0, 3, 0, 0)
--         SetPedComponentVariation(ped, 1, 0, 0, 0)
--         SetPedComponentVariation(ped, 2, 3, 0, 0)
--         SetPedComponentVariation(ped, 3, 0, 1, 0)
--         SetPedComponentVariation(ped, 4, 1, 0, 0)
--         SetPedComponentVariation(ped, 6, 1, 0, 0)
--         SetPedComponentVariation(ped, 7, 1, 0, 0)
--         SetPedComponentVariation(ped, 8, 0, 0, 0)
--         SetPedComponentVariation(ped, 10, 0, 0, 0)
--         SetPedComponentVariation(ped, 11, 0, 0, 0)
--         SetPedPropIndex(ped, 1, 0, 0, false)
--     elseif r == 4 then
--         SetPedComponentVariation(ped, 0, 2, 1, 0)
--         SetPedComponentVariation(ped, 1, 0, 0, 0)
--         SetPedComponentVariation(ped, 2, 2, 1, 0)
--         SetPedComponentVariation(ped, 3, 3, 3, 0)
--         SetPedComponentVariation(ped, 4, 1, 0, 0)
--         SetPedComponentVariation(ped, 6, 1, 0, 0)
--         SetPedComponentVariation(ped, 7, 2, 0, 0)
--         SetPedComponentVariation(ped, 8, 3, 0, 0)
--         SetPedComponentVariation(ped, 10, 0, 0, 0)
--         SetPedComponentVariation(ped, 11, 0, 0, 0)
--     end
-- end

-- function isPlayingRoulette()
--     return selectedRoulette
-- end
-- exports('isPlayingRoulette', isPlayingRoulette)