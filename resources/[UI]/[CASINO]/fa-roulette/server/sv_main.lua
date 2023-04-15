local aktivRulettek = {}

--//////////////////////////--//////////////////////////--//////////////////////////
-- EDIT THESE FOR YOUR SERVER
-- EDIT THESE FOR YOUR SERVER
function getPlayerChips(source)
    return 999999999 -- DO NOT FORGET TO EDIT THIS WITH YOUR SERVER GETTER
end

function giveChips(source, amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:addMoney(amount)
    TriggerClientEvent('DoShortHudText', src, tostring(ammount) 'WON',2)
    --exports["fa-banking"]:UpdateSociety(amount, "casino_dealer", "remove")
end

function removeChips(source, amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if amount >= user:getCash() then
        TriggerClientEvent('DoShortHudText', src, 'You are broke!!!',2)
        return false
    end
    if amount < 100000001 then
    user:removeMoney(amount)
    exports["fa-banking"]:UpdateSociety(amount, "casino_dealer", "add")
    return true
    else if amount > 100000000 then 
     TriggerClientEvent('DoShortHudText', src, 'Max Betting is $5000',2)
    end
    end
end

function r_showNotification(source, msg)
    TriggerClientEvent('rulett:showNotification', source, msg)
end
--//////////////////////////--//////////////////////////--//////////////////////////

function isPlayerExist(source)
    if GetPlayerName(source) ~= nil then
        return true
    else
        return false
    end
end

RegisterNetEvent('server_remote:rulett:taskSitDown')
AddEventHandler(
    'server_remote:rulett:taskSitDown',
    function(rulettIndex, chairData)
        local source = source
        local chairId = chairData.chairId

        if aktivRulettek[rulettIndex] ~= nil then
            if aktivRulettek[rulettIndex].chairsUsed[chairId] ~= nil then
                return --r_showNotification(source, _U('chair_used'))
            else
                TriggerClientEvent('client_callback:rulett:taskSitDown', source, rulettIndex, chairData)
            end
        else
            TriggerClientEvent('client_callback:rulett:taskSitDown', source, rulettIndex, chairData)
        end
    end
)

RegisterNetEvent('casino:taskStartRoulette')
AddEventHandler(
    'casino:taskStartRoulette',
    function(rulettIndex, chairId)
        local source = source

        if aktivRulettek[rulettIndex] == nil then
            aktivRulettek[rulettIndex] = {
                statusz = false,
                ido = Config.RouletteStart,
                bets = {},
                chairsUsed = {}
            }

            Config.DebugMsg(string.format('created rulett on serverside. table: %s', rulettIndex))
        end

        if aktivRulettek[rulettIndex].chairsUsed[chairId] == nil then
            aktivRulettek[rulettIndex].chairsUsed[chairId] = source
            TriggerClientEvent('client:casino:openRulett', source, rulettIndex)
        else
            --r_showNotification(source, _U('chair_used'))
        end
    end
)

function countTablePlayers(rulettIndex)
    local count = 0

    if aktivRulettek[rulettIndex] ~= nil then
        for chairId, _ in pairs(aktivRulettek[rulettIndex].chairsUsed) do
            count = count + 1
        end

        return count
    else
        return count
    end
end

RegisterNetEvent('casino:rulett:notUsing')
AddEventHandler(
    'casino:rulett:notUsing',
    function(rulettIndex)
        local source = source
        if aktivRulettek[rulettIndex] ~= nil then
            for chairId, src in pairs(aktivRulettek[rulettIndex].chairsUsed) do
                if src == source then
                    aktivRulettek[rulettIndex].chairsUsed[chairId] = nil
                end
            end
        end
    end
)

AddEventHandler(
    'playerDropped',
    function(reason)
        local source = source
        for rulettIndex, v in pairs(aktivRulettek) do
            for chairId, src in pairs(v.chairsUsed) do
                if src == source then
                    aktivRulettek[rulettIndex].chairsUsed[chairId] = nil
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            for rulettIndex, v in pairs(aktivRulettek) do
                if v.statusz == false then
                    if v.ido > 0 then
                        aktivRulettek[rulettIndex].ido = v.ido - 1
                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, v.ido, v.statusz)
                    end

                    if v.ido < 1 then
                        local randomSpinNumber = math.random(1, 38) -- do not modify this you idiot
                        if Config.TestTicker ~= nil then
                            randomSpinNumber = Config.TestTicker
                        end
                        local WinningBetIndex = Config.rouletteSzamok[randomSpinNumber]

                        Config.DebugMsg(string.format('Rulett randomSpinNumber: %s, which is number: %s', randomSpinNumber, WinningBetIndex))

                        aktivRulettek[rulettIndex].statusz = true
                        aktivRulettek[rulettIndex].WinningBetIndex = WinningBetIndex
                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, v.ido, v.statusz)

                        Citizen.CreateThread(
                            function()
                                Config.DebugMsg('time remaining 0, starting the spin events.')
                                TriggerClientEvent('casino:rulett:startSpin', -1, rulettIndex, randomSpinNumber)
                                Citizen.Wait(15500)

                                if #v.bets > 0 then
                                    CheckWinners(v.bets, aktivRulettek[rulettIndex].WinningBetIndex)
                                    aktivRulettek[rulettIndex].statusz = false
                                    aktivRulettek[rulettIndex].ido = Config.RouletteStart
                                    aktivRulettek[rulettIndex].WinningBetIndex = nil
                                    aktivRulettek[rulettIndex].bets = {} -- reset the bets on the table, very importante
                                    TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                                else
                                    if countTablePlayers(rulettIndex) < 1 then
                                        aktivRulettek[rulettIndex] = nil -- deleting the table from srv
                                        Config.DebugMsg(string.format('Rulett table id %s, stopped because no one using it.', rulettIndex))
                                        TriggerClientEvent('client:rulett:updateStatusz', -1, rulettIndex, nil, nil)
                                    else
                                        aktivRulettek[rulettIndex].statusz = false
                                        aktivRulettek[rulettIndex].ido = Config.RouletteStart
                                        aktivRulettek[rulettIndex].WinningBetIndex = nil
                                        aktivRulettek[rulettIndex].bets = {} -- reset the bets on the table, very importante
                                        TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                                    end
                                end
                            end
                        )
                    end
                end
            end
        end
    end
)

function CheckWinners(bets, WinningBetIndex)
    local playersWon = {}
    local playersLoss = {}

    for i = 1, #bets, 1 do
        local betData = bets[i]

        local targetSrc = betData.playerSrc
        local PLAYER_HANDLE = isPlayerExist(targetSrc)
        if PLAYER_HANDLE then
            betData.betId = tostring(betData.betId)
            if (WinningBetIndex == '0' and betData.betId == '37') or (WinningBetIndex == '00' and betData.betId == '38') then -- dbl zero, and zero
                giveWinningChips(targetSrc, betData.betAmount, 35)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif
                (betData.betId == '39' and RULETT_NUMBERS.Pirosak[WinningBetIndex]) or (betData.betId == '40' and RULETT_NUMBERS.Feketek[WinningBetIndex]) or
                    (betData.betId == '41' and RULETT_NUMBERS.Parosak[WinningBetIndex]) or
                    (betData.betId == '42' and RULETT_NUMBERS.Paratlanok[WinningBetIndex]) or
                    (betData.betId == '43' and RULETT_NUMBERS.to18[WinningBetIndex]) or
                    (betData.betId == '44' and RULETT_NUMBERS.to36[WinningBetIndex])
             then
                giveWinningChips(targetSrc, betData.betAmount, 2)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif betData.betId <= '36' and WinningBetIndex == betData.betId then -- the numbers
                giveWinningChips(targetSrc, betData.betAmount, 35)
                playersWon[targetSrc] = true
                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            elseif
                (betData.betId == '45' and RULETT_NUMBERS.st12[WinningBetIndex]) or (betData.betId == '46' and RULETT_NUMBERS.sn12[WinningBetIndex]) or
                    (betData.betId == '47' and RULETT_NUMBERS.rd12[WinningBetIndex]) or
                    (betData.betId == '48' and RULETT_NUMBERS.ket_to_1[WinningBetIndex]) or
                    (betData.betId == '49' and RULETT_NUMBERS.ket_to_2[WinningBetIndex]) or
                    (betData.betId == '50' and RULETT_NUMBERS.ket_to_3[WinningBetIndex])
             then
                giveWinningChips(targetSrc, betData.betAmount, 3)
                playersWon[targetSrc] = true

                if playersLoss[targetSrc] then
                    playersWon[targetSrc] = nil
                end
            else -- LOSS
                if playersWon[targetSrc] == nil then
                    playersLoss[targetSrc] = true
                else
                    playersLoss[targetSrc] = nil
                end
            end
        end
    end

    for targetSrc, _ in pairs(playersLoss) do
        local chairId = getPlayerTableSeat(targetSrc)
        if chairId ~= nil then
            TriggerClientEvent('client:rulett:playWinAnim', targetSrc, chairId)
        end
    end

    for targetSrc, _ in pairs(playersWon) do
        local chairId = getPlayerTableSeat(targetSrc)
        if chairId ~= nil then
            TriggerClientEvent('client:rulett:playLossAnim', targetSrc, chairId)
        end
    end
end

function giveWinningChips(source, amount, szorzo)
    amount = math.floor(amount * szorzo)

    if amount > 0 then
        --r_showNotification(source, _('won_chips', amount, szorzo))
        giveChips(source, amount)
        TriggerClientEvent('DoShortHudText', source, 'won_chips', amount, szorzo,2)
    end
end

RegisterNetEvent('casino:taskBetRulett')
AddEventHandler(
    'casino:taskBetRulett',
    function(rulettIndex, betId, betAmount)
        local source = source

        if aktivRulettek[rulettIndex] ~= nil then
            if aktivRulettek[rulettIndex].statusz then
                return --r_showNotification(source, _U('can_not_bet_because_started'))
            end

            local chipsAmount = getPlayerChips(source)
            if chipsAmount >= betAmount then
                removeChips(source, betAmount)
                --r_showNotification(source, _('placed_bet', betAmount))

                Config.DebugMsg(string.format('player %s betted %s chips on betId: %s', GetPlayerName(source), betAmount, betId))

                local exist = false
                for i = 1, #aktivRulettek[rulettIndex].bets, 1 do
                    local d = aktivRulettek[rulettIndex].bets[i]
                    if d.betId == betId and d.playerSrc == source then
                        exist = true
                        aktivRulettek[rulettIndex].bets[i].betAmount = aktivRulettek[rulettIndex].bets[i].betAmount + betAmount
                    end
                end

                if not exist then
                    table.insert(
                        aktivRulettek[rulettIndex].bets,
                        {
                            betId = betId,
                            playerSrc = source,
                            betAmount = betAmount
                        }
                    )
                end
                TriggerClientEvent('client:rulett:updateTableBets', -1, rulettIndex, aktivRulettek[rulettIndex].bets)
                local chairId = getPlayerTableSeat(source)
                if chairId ~= nil then
                    Config.DebugMsg(string.format('%s chair betanim play', chairId))
                    TriggerClientEvent('client:rulett:playBetAnim', source, chairId)
                end
            else
                --r_showNotification(source, _U('not_enough_chips'))
            end
        else -- the table not existing on the serverside? error
            TriggerClientEvent('Notify', source, 'error', 'Hiba történt, nem létező rulettasztal szerveroldalon?')
        end
    end
)

function getPlayerTableSeat(source)
    for rulettIndex, v in pairs(aktivRulettek) do
        for chairId, src in pairs(v.chairsUsed) do
            if src == source then
                return chairId
            end
        end
    end
end
