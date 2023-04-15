
-- local activeRoulettes = {}

-- function getPlayerChips(source)
--     local p = promise.new()
--     local player = exports["fa-base"]:getModule("Player"):GetUser(source)
--     if player then
--         TriggerClientEvent('fa-casino:setBalance', source)
--     end
--     return Citizen.Await(p)
-- end

-- function giveChips(source, amount)
--     local player = exports["fa-base"]:getModule("Player"):GetUser(source)
--     if player then
--         TriggerClientEvent('player:player:receiveItem', source, 'redchip', amount)
--         TriggerEvent('fa-casino:blackjack:getBalance', player.source)
--     end
-- end

-- function removeChips(source, amount)
--     local player = exports["fa-base"]:getModule("Player"):GetUser(source)
--     if player then
--         TriggerClientEvent('inventory:removeItem', source, 'redchip', amount)
--         TriggerEvent('fa-casino:blackjack:getBalance', player.source)
--     end
-- end

-- local function giveCasinoChips(amount, cid) 
--     TriggerClientEvent('player:player:receiveItem', source, 'redchip', amount)
-- end

-- RegisterNetEvent('fa-roulette:isSeatUsed')
-- AddEventHandler('fa-roulette:isSeatUsed', function(data, a1)
--     local src = source
--     local rouletteIndex = data['k']
--     local chairId = data['closestChairData']
--     if activeRoulettes[rouletteIndex] ~= nil then
--         if activeRoulettes[rouletteIndex].chairsUsed[chairId] ~= nil then
--             TriggerClientEvent('DoLongHudText', src, 'This chair is occupied.', 2)
--         else
--             TriggerClientEvent('fa-roulette:isSeatUsed', src, data, a1)
--         end
--     else
--         TriggerClientEvent('fa-roulette:isSeatUsed', src, data, a1)
--     end
-- end)

-- RegisterNetEvent('fa-roulette:taskStartRoulette')
-- AddEventHandler('fa-roulette:taskStartRoulette', function(rouletteIndex, chairId)
--         local source = source

--         local xPlayer = exports["fa-base"]:getModule("Player"):GetUser(source)
--         if xPlayer then
--             if activeRoulettes[rouletteIndex] == nil then
--                 activeRoulettes[rouletteIndex] = {
--                     status = false,
--                     time = Config.RouletteStart,
--                     bets = {},
--                     chairsUsed = {}
--                 }

--                 Config.DebugMsg(string.format('created roulette on serverside. table: %s', rouletteIndex))
--             end

--             if activeRoulettes[rouletteIndex].chairsUsed[chairId] == nil then
--                 activeRoulettes[rouletteIndex].chairsUsed[chairId] = source
--                 TriggerClientEvent('fa-roulette:openRoulette', source, rouletteIndex)
--                 TriggerClientEvent('fa-roulette:updateChips', source)
--             else
--                 TriggerClientEvent('DoLongHudText', sourc, 'This chair is occupied.', 2)
--             end
--         end
--     end
-- )

-- function countTablePlayers(rouletteIndex)
--     local count = 0

--     if activeRoulettes[rouletteIndex] ~= nil then
--         for chairId, _ in pairs(activeRoulettes[rouletteIndex].chairsUsed) do
--             count = count + 1
--         end
--         return count
--     else
--         return count
--     end
-- end

-- RegisterNetEvent('fa-roulette:notUsing')
-- AddEventHandler('fa-roulette:notUsing',function(rouletteIndex)
--     local source = source
--     if activeRoulettes[rouletteIndex] ~= nil then
--         for chairId, src in pairs(activeRoulettes[rouletteIndex].chairsUsed) do
--             if src == source then
--                 activeRoulettes[rouletteIndex].chairsUsed[chairId] = nil
--             end
--         end
--     end
-- end)

-- AddEventHandler('playerDropped', function(reason)
--     local source = source
--     for rouletteIndex, v in pairs(activeRoulettes) do
--         for chairId, src in pairs(v.chairsUsed) do
--             if src == source then
--                 activeRoulettes[rouletteIndex].chairsUsed[chairId] = nil
--             end
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         for rouletteIndex, v in pairs(activeRoulettes) do
--             if v.status == false then
--                 if v.time > 0 then
--                     activeRoulettes[rouletteIndex].time = v.time - 1
--                     TriggerClientEvent('fa-roulette:updateStatus', -1, rouletteIndex, v.time, v.status)
--                 end

--                 if v.time < 1 then
--                     local randomSpinNumber = math.random(1, 38) -- do not modify this you idiot
--                     if Config.TestTicker ~= nil then
--                         randomSpinNumber = Config.TestTicker
--                     end

--                     local WinningBetIndex = Config.rouletteNumbers[randomSpinNumber]

--                     Config.DebugMsg(string.format('Rulett randomSpinNumber: %s, which is number: %s', randomSpinNumber, WinningBetIndex))

--                     activeRoulettes[rouletteIndex].status = true
--                     activeRoulettes[rouletteIndex].WinningBetIndex = WinningBetIndex
--                     TriggerClientEvent('fa-roulette:updateStatus', -1, rouletteIndex, v.time, v.status)

--                     Citizen.CreateThread(function()
--                         Config.DebugMsg('time remaining 0, starting the spin events.')
--                         TriggerClientEvent('fa-roulette:startSpin', -1, rouletteIndex, randomSpinNumber)
--                         Citizen.Wait(15500)

--                         if #v.bets > 0 then
--                             CheckWinners(v.bets, activeRoulettes[rouletteIndex].WinningBetIndex)
--                             activeRoulettes[rouletteIndex].status = false
--                             activeRoulettes[rouletteIndex].time = Config.RouletteStart
--                             activeRoulettes[rouletteIndex].WinningBetIndex = nil
--                             activeRoulettes[rouletteIndex].bets = {} -- reset the bets on the table, very importante
--                             TriggerClientEvent('fa-roulette:updateTableBets', -1, rouletteIndex, activeRoulettes[rouletteIndex].bets)
--                         else
--                             if countTablePlayers(rouletteIndex) < 1 then
--                                 activeRoulettes[rouletteIndex] = nil -- deleting the table from srv
--                                 Config.DebugMsg(string.format('Roulette table id %s, stopped because no one using it.', rouletteIndex))
--                                 TriggerClientEvent('fa-roulette:updateStatus', -1, rouletteIndex, nil, nil)
--                             else
--                                 activeRoulettes[rouletteIndex].status = false
--                                 activeRoulettes[rouletteIndex].time = Config.RouletteStart
--                                 activeRoulettes[rouletteIndex].WinningBetIndex = nil
--                                 activeRoulettes[rouletteIndex].bets = {} -- reset the bets on the table, very importante
--                                 TriggerClientEvent('fa-roulette:updateTableBets', -1, rouletteIndex, activeRoulettes[rouletteIndex].bets)
--                             end
--                         end
--                     end)
--                 end
--             end
--         end
--     end
-- end)

-- function CheckWinners(bets, WinningBetIndex)
--     local playersWon = {}
--     local playersLoss = {}
--     WinningBetIndex = tostring(WinningBetIndex)
--     for i = 1, #bets, 1 do
--         local betData = bets[i]
--         local xPlayer = exports["fa-base"]:getModule("Player"):GetUser(betData.playerSrc)
--         if xPlayer then
--             betData.betId = tostring(betData.betId)
--             if (WinningBetIndex == '00' and betData.betId == '38') or (WinningBetIndex == '0' and betData.betId == '37') then -- dbl zero, and zero
--                 giveWinningChips(xPlayer, betData.betAmount, 35)
--                 playersWon[xPlayer.source] = true
--                 if playersLoss[xPlayer.source] then
--                     playersWon[xPlayer.source] = nil
--                 end
--             elseif (betData.betId == '39' and RouletteNumbers.Red[WinningBetIndex])
--                 or (betData.betId == '40' and RouletteNumbers.Black[WinningBetIndex ])
--                 or (betData.betId == '41' and RouletteNumbers.Even[WinningBetIndex])
--                 or (betData.betId == '42' and RouletteNumbers.Odd[WinningBetIndex])
--                 or (betData.betId == '43' and RouletteNumbers.to18[WinningBetIndex])
--                 or (betData.betId == '44' and RouletteNumbers.to36[WinningBetIndex])
--                 then
--                 giveWinningChips(xPlayer, betData.betAmount, 2)
--                 playersWon[xPlayer.source] = true
--                 if playersLoss[xPlayer.source] then
--                     playersWon[xPlayer.source] = nil
--                 end
--             elseif tonumber(betData.betId) <= 36 and WinningBetIndex == betData.betId then -- the numbers
--                 giveWinningChips(xPlayer, betData.betAmount, 35)
--                 playersWon[xPlayer.source] = true
--                 if playersLoss[xPlayer.source] then
--                     playersWon[xPlayer.source] = nil
--                 end
--             elseif
--                 (betData.betId == '45' and RouletteNumbers.first12[WinningBetIndex]) or (betData.betId == '46' and RouletteNumbers.second12[WinningBetIndex]) or
--                     (betData.betId == '47' and RouletteNumbers.third12[WinningBetIndex]) or
--                     (betData.betId == '48' and RouletteNumbers.row1[WinningBetIndex]) or
--                     (betData.betId == '49' and RouletteNumbers.row2[WinningBetIndex]) or
--                     (betData.betId == '50' and RouletteNumbers.row3[WinningBetIndex])
--              then
--                 giveWinningChips(xPlayer, betData.betAmount, 2)
--                 playersWon[xPlayer.source] = true

--                 if playersLoss[xPlayer.source] then
--                     playersWon[xPlayer.source] = nil
--                 end
--             else -- LOSS
--                 giveCasinoChips(betData.betAmount)
--                 if playersWon[xPlayer.source] == nil then
--                     playersLoss[xPlayer.source] = true
--                 else
--                     playersLoss[xPlayer.source] = nil
--                 end
--             end
--         end
--     end

--     for targetSrc, _ in pairs(playersLoss) do
--         local chairId = getPlayerTableSeat(targetSrc)
--         if chairId ~= nil then
--             TriggerClientEvent('fa-roulette:playWinAnim', targetSrc, chairId)
--         end
--     end

--     for targetSrc, _ in pairs(playersWon) do
--         local chairId = getPlayerTableSeat(targetSrc)
--         if chairId ~= nil then
--             TriggerClientEvent('fa-roulette:playLossAnim', targetSrc, chairId)
--         end
--     end
-- end

-- function giveWinningChips(xPlayer, amount, szorzo)
--     amount = math.floor(amount * szorzo)

--     if amount > 0 then
--         TriggerClientEvent('DoLongHudText', sourc, 'You have won $'..amount..' - Multiplier: x'..szorzo, 2)
--         giveChips(xPlayer.source, amount)
--     end
-- end

-- RegisterNetEvent('fa-roulette:taskBetRoulette')
-- AddEventHandler('fa-roulette:taskBetRoulette', function(rouletteIndex, betId, betAmount)
--     local source = source
--     local xPlayer = exports["fa-base"]:getModule("Player"):GetUser(source)
--     if xPlayer then
--         if activeRoulettes[rouletteIndex] ~= nil then
--             if activeRoulettes[rouletteIndex].status then
--                 TriggerClientEvent('DoLongHudText', sourc, 'The game started, you can not bet at the moment.', 2)
--                 return
--             end
            
--             local playerBet = 0

--             if activeRoulettes[rouletteIndex].bets then
--                 for i = 1, #activeRoulettes[rouletteIndex].bets, 1 do
--                     local d = activeRoulettes[rouletteIndex].bets[i]
--                     if d.playerSrc == source then
--                         exist = true
--                         playerBet = activeRoulettes[rouletteIndex].bets[i].betAmount + betAmount
--                         --activeRoulettes[rouletteIndex].bets[i].betAmount = activeRoulettes[rouletteIndex].bets[i].betAmount + betAmount
--                     end
--                 end
--             end

--             if playerBet > Config.RouletteTables[rouletteIndex].maxBet then
--                 TriggerClientEvent('DoLongHudText', source, 'You have reached the maximum bet for the table. </br> Max total bets: $'..Config.RouletteTables[rouletteIndex].maxBet, 2)
--                 return
--             end

--             if tonumber(betId) < 38 then
--                 if Config.RouletteTables[rouletteIndex].isHighTable then
--                     if tonumber(betAmount) > 250 then
--                         TriggerClientEvent('DoLongHudText', source, 'Single number bets are limited to $250', 2)
--                         return
--                     end
--                 elseif tonumber(betAmount) > 100 then
--                     TriggerClientEvent('DoLongHudText', source, 'Single number bets are limited to $100', 2)
--                     return
--                 end
--             end

--             local chipsAmount = getPlayerChips(source)
--             print('PLAYER CHIPS: '..chipsAmount)
--             if chipsAmount >= betAmount then
--                 removeChips(source, betAmount)
--                 TriggerClientEvent('DoLongHudText', source, 'Placed $'..betAmount..' bet.', 2)

--                 Config.DebugMsg(string.format('player %s betted %s chips on betId: %s', GetPlayerName(source), betAmount, betId))

--                 local exist = false
--                 for i = 1, #activeRoulettes[rouletteIndex].bets, 1 do
--                     local d = activeRoulettes[rouletteIndex].bets[i]
--                     if d.betId == betId and d.playerSrc == source then
--                         exist = true
--                         activeRoulettes[rouletteIndex].bets[i].betAmount = activeRoulettes[rouletteIndex].bets[i].betAmount + betAmount
--                     end
--                 end

--                 if not exist then
--                     table.insert(
--                         activeRoulettes[rouletteIndex].bets,
--                         {
--                             betId = betId,
--                             playerSrc = source,
--                             betAmount = betAmount
--                         }
--                     )
--                 end
--                 TriggerClientEvent('fa-roulette:updateTableBets', -1, rouletteIndex, activeRoulettes[rouletteIndex].bets)
--                 local chairId = getPlayerTableSeat(source)
--                 if chairId ~= nil then
--                     Config.DebugMsg(string.format('%s chair betanim play', chairId))
--                     TriggerClientEvent('fa-roulette:playBetAnim', xPlayer.source, chairId)
--                 end
--             else
--                 TriggerClientEvent('DoLongHudText', source, 'You do not have enough funds to place bet.', 2)
--             end
--         else -- the table not existing on the serverside? error
--             --TriggerClientEvent('Notify', xPlayer.source, 'error', 'Hiba történt, nem létező rulettasztal szerveroldalon?')
--         end
--     end
-- end)

-- function getPlayerTableSeat(source)
--     for rouletteIndex, v in pairs(activeRoulettes) do
--         for chairId, src in pairs(v.chairsUsed) do
--             if src == source then
--                 return chairId
--             end
--         end
--     end
-- end

-- -- RegisterCommand('rtick', function(source,args,rawCommand)
-- --     local tickRate = tonumber(args[1])
-- --     Config.TestTicker = tickRate
-- --     print("New Tick Rate: ",Config.TestTicker)
-- -- end, false)