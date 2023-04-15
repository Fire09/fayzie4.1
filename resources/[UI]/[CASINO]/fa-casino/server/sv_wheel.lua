isRoll = false
amount = 500

RPC.register('fa-casino:purchaseMembershipCard',function(pCid)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if user:getCash() >= 250 then
          user:removeMoney(250)
          TriggerClientEvent('fa-casino:purchaseMembership',src)
    end
end)

RegisterServerEvent('fa-luckywheel:getLucky')
AddEventHandler('fa-luckywheel:getLucky', function(money)
    local src = source
    local source = tonumber(source)
    local user =  exports["fa-base"]:getModule("Player"):GetUser(src)
    local player = GetPlayerName(source)
    if not isRoll then
        if user ~= nil then
            if user:getCash() >= amount  then
              --  user:removeMoney(amount)
                user:removeMoney(amount)
                isRoll = true

                local _randomPrice = math.random(1, 100)
                if _randomPrice == 1 then
                    -- Win car
                    local _subRan = math.random(1,1000)
                    if _subRan <= 1 then
                        _priceIndex = 19
                    else
                        _priceIndex = 3
                    end
                elseif _randomPrice > 1 and _randomPrice <= 6 then
                    -- Win skin AK Gold
                    _priceIndex = 12
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 12
                    else
                        _priceIndex = 7
                    end
                elseif _randomPrice > 6 and _randomPrice <= 15 then
                    -- Black money
                    -- 4, 8, 11, 16
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 4
                    elseif _sRan == 2 then
                        _priceIndex = 8
                    elseif _sRan == 3 then
                        _priceIndex = 11
                    else
                        _priceIndex = 16
                    end
                elseif _randomPrice > 15 and _randomPrice <= 25 then
                    -- Win 300,000$
                    -- _priceIndex = 5
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 5
                    else
                        _priceIndex = 20
                    end
                elseif _randomPrice > 25 and _randomPrice <= 40 then
                    -- 1, 9, 13, 17
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 1
                    elseif _sRan == 2 then
                        _priceIndex = 9
                    elseif _sRan == 3 then
                        _priceIndex = 13
                    else
                        _priceIndex = 17
                    end
                elseif _randomPrice > 40 and _randomPrice <= 60 then
                    local _itemList = {}
                    _itemList[1] = 2
                    _itemList[2] = 6
                    _itemList[3] = 10
                    _itemList[4] = 14
                    _itemList[5] = 18
                    _priceIndex = _itemList[math.random(1, 5)]
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _itemList = {}
                    _itemList[1] = 3
                    _itemList[2] = 7
                    _itemList[3] = 15
                    _itemList[4] = 20
                    _priceIndex = _itemList[math.random(1, 4)]
                end
                SetTimeout(7000, function()
                    isRoll = false
                    if _priceIndex == 1 or _priceIndex == 9 or _priceIndex == 13 or _priceIndex == 17 then
                        local _money = 0
                        if _priceIndex == 1 then
                            _money = 0
                        elseif _priceIndex == 9 then
                            _money = 0
                        elseif _priceIndex == 13 then
                            _money = 0
                        elseif _priceIndex == 17 then
                            _money = 0
                        end
                        TriggerClientEvent('DoLongHudText', src, "You Lost ", 2)
                    elseif _priceIndex == 2 or _priceIndex == 6 or _priceIndex == 10 or _priceIndex == 14 or _priceIndex == 18 then
                        local _money3 = 0
                        if _priceIndex == 2 then
                            _money3 = 250
                        elseif _priceIndex == 6 then
                            _money3 = 500
                        elseif _priceIndex == 10 then
                            _money3 = 500
                        elseif _priceIndex == 14 then
                            _money3 = 1000
                        elseif _priceIndex == 18 then
                            _money3 = 750
                        end 
                     --   user:addMoney(_money3)
                        user:addMoney(_money3)
                        TriggerClientEvent('DoLongHudText', src, "You Won", 1)
                    elseif _priceIndex == 3 or _priceIndex == 7 or _priceIndex == 15 or _priceIndex == 20 then
                        local _money2 = 0
                        if _priceIndex == 3 then
                            _money2 = 0
                        elseif _priceIndex == 7 then
                            _money2 = 0
                        elseif _priceIndex == 15 then
                            _money2 = 0
                        elseif _priceIndex == 20 then
                            _money2 = 0
                        end
                        TriggerClientEvent('DoLongHudText', src, "You lost", 2)
                    elseif _priceIndex == 4 or _priceIndex == 8 or _priceIndex == 11 or _priceIndex == 16 then
                        local _money4 = 0
                        if _priceIndex == 4 then
                            _money4 = 2000
                        elseif _priceIndex == 8 then
                            _money4 = 3000
                        elseif _priceIndex == 11 then
                            _money4 = 4000
                        elseif _priceIndex == 16 then
                            _money4 = 5000
                        end
                    --    user:addMoney(_money4)
                        user:addMoney(_money4)
                        TriggerClientEvent('DoLongHudText', src, "You won", 1)
                    elseif _priceIndex == 5 then
                       -- user:addMoney(10000)
                       user:addMoney(10000)
                        TriggerClientEvent('DoLongHudText', src, "You won", 1)
                    elseif _priceIndex == 12 then
                        TriggerClientEvent("player:receiveItem", source, "casinofob", 1)
                      --  sendToDiscord5("Car Winner Logs", "Player ID: ".. src ..", Steam: ".. player ..",  Just WON THE CAR!!")
                      TriggerClientEvent('DoLongHudText', src, "You won a car show the staff this to claim it!", 1)
                    elseif _priceIndex == 19 then
                        TriggerClientEvent("player:receiveItem", source, "casinofob", 1)
                       -- sendToDiscord5("Car Winner Logs", "Player ID: ".. src ..", Steam: ".. player ..",  Just WON THE CAR!!")
                        TriggerClientEvent('DoLongHudText', src, "You won a car show the staff this to claim it!", 1)
                    end
                    TriggerClientEvent("fa-luckywheel:rollFinished", -1)
                end)
                TriggerClientEvent("fa-luckywheel:doRoll", -1, _priceIndex)
            else
                TriggerClientEvent("fa-luckywheel:rollFinished", -1)  
                TriggerClientEvent('DoLongHudText', src, "You Need some cash!", 2)
            end
        end
    end
end)

CasinoSpin = false
RegisterServerEvent("spin:toggle")
AddEventHandler('spin:toggle', function(pAuto)
    if not pAuto then
        local pSrc = source
        TriggerClientEvent("DoLongHudText", pSrc, ('Spin To Win has been %s!'):format(CasinoSpin and 'Disabled' or 'Enabled')) 
        CasinoSpin = not CasinoSpin
    else
        CasinoSpin = not CasinoSpin
    end
end)

RegisterServerEvent("attempt:spin", function()
    local pSrc = source
    if CasinoSpin then
        TriggerClientEvent("fa-luckywheel:spinit", pSrc, true)
    else
        TriggerClientEvent("DoLongHudText", pSrc, "Spin to Win is disabled, please contact a Casino Dealer!", 2)
    end
end)
