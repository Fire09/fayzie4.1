local currentBanks = {}
local groupTable = {}
local insertBanks = false

RPC.register("fa-phone:addToCurrentBanks", function(pSource, pBank)
    currentBanks[#currentBanks+1] = {
        bankName = pBank.bankName,
        bankExpires = pBank.bankExpires,
        status = pBank.status,
        bankID = pBank.bankID
    }
end)

RPC.register("fa-phone:getCurrentBanks", function(pSource)
    return currentBanks
end)

RPC.register("fa-phone:requestPlayerToGroup", function(pSource, pCid, pGroupID)
    local serverID = getPlayerFromCidForCharge(pCid)
    TriggerClientEvent("SendHeistRequestNotification", serverID, {
        groupID = pGroupID,
        targetID = serverID,
        senderID = pSource,
        targetCID = pCid
    })
end)

RPC.register("fa-phone:addPlayerToGroup", function(pSource, pCid, pGroupID, pSenderID)
    local user = exports['fa-base']:getModule('Player'):GetUser(source)

    for k, v in pairs(groupTable) do
        for j, s in pairs(v.members) do
            if tonumber(pGroupID) == k then
                groupTable[k].members[#groupTable[k].members+1] = {
                    ["GroupBank"] = s.GroupBank,
                    ["cid"] = pCid,
                    ["name"] = getFullNameFromCid(pCid),
                    ["leader"] = false
                }
                TriggerClientEvent("SendHeistNotification", pSenderID, "Player joined")
            end
        end
    end
end)

RPC.register('fa-phone:removePlayerFromGroup', function(pSource, pCid, pGroupID)
    local jsonDecodedGroups = json.decode(groupTable)
    for k,v in pairs(jsonDecodedGroups) do
        if pGroupID == k then
            local jsonDecodedGroupMembers = json.decode(v.members)
            for j,s in pairs(jsonDecodedGroupMembers) do
                if pCid == tonumber(s.cid) then
                    table.remove(jsonDecodedGroupMembers, pCid)
                end
            end
        end
    end
end)

RPC.register('fa-phone:deleteGroup', function(source, pGroupID)
    table.remove(groupTable, groupTable.groupID)
end)

RPC.register('fa-phone:getMyGroupBankBusters', function(pSource, pCid)
    for k, v in pairs(groupTable) do
        for j, s in pairs(v.members) do
            if tonumber(s.cid) == pCid then
                return s.GroupBank
            end
        end
    end
end)

RPC.register('fa-phone:claimBank:BankBusters', function(source, bankID, StateID)
    exports.oxmysql:execute('SELECT * FROM characters WHERE id = @StID', {
        ['StID'] = StateID
    }, function(helo)
        if helo[1].claimedBank == 0 then
            exports.oxmysql:execute('SELECT * FROM _bankbusters WHERE bankid = @BankID', {
                ['BankID'] = bankID
            }, function(resultBank)
                exports.oxmysql:execute('INSERT INTO _bankbusters_queue (leaderStateID, bankName, bankID) VALUES (@leaderStateID, @bankName, @bankID)', {
                    ['leaderStateID'] = StateID,
                    ['bankName'] = resultBank[1].bankName,
                    ['bankID'] = bankID
                }, function(result)end)
            end)
            exports.oxmysql:execute('UPDATE characters SET claimedBank = @CB WHERE id = @stateID', {
                ['CB'] = "1",
                ['stateID'] = StateID
            })
        else
            TriggerClientEvent('DoLongHudText', source, 'You can only queue for 1 bank.', 2)
        end
    end)
end)

RPC.register('getBankBusterGroups', function(pSource)
    return getBankBusterGroups()
end)

function getBankBusterGroups()
    return groupTable
end

function getFullNameFromCid(pCid)
    local data = MySQL.query.await([[
        SELECT * FROM characters WHERE id = ?
    ]], {pCid})
    return data[1].first_name .. " " .. data[1].last_name
end

function addBankBusters(pBanks)
    currentBanks = {}
    for k,v in pairs(pBanks) do
        currentBanks[#currentBanks+1] = {
            bankName = v.bankName,
            bankExpires = v.bankExpires,
            status = v.status,
            bankID = v.bankID
        }
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(30000)
        exports.oxmysql:execute('SELECT * FROM _bankbusters', function(bankBusters)
            for i, k in pairs(bankBusters) do
                currentBanks = {}
                for i, k in pairs(bankBusters) do
                    table.insert(currentBanks, {
                        ['bankName'] = k.bankName,
                        ['bankExpires'] = k.hours..'h '..k.minutes..'m',
                        ['status'] = k.status,
                        ['bankID'] = k.bankid
                    })
                end

                if k.status == "Expired" or k.status == "Claimed" then return end

                if k.minutes == 0 then
                    exports.oxmysql:execute('UPDATE _bankbusters SET hours = @Hrs WHERE bankName = @bnkName', {
                        ['bnkName'] = k.bankName,
                        ['Hrs'] = k.hours - 1
                    })

                    exports.oxmysql:execute('UPDATE _bankbusters SET minutes = @mins WHERE bankName = @bnkName', {
                        ['bnkName'] = k.bankName,
                        ['mins'] = "60"
                    })
                end

                if k.minutes ~= 0 then
                    exports.oxmysql:execute('UPDATE _bankbusters SET minutes = @mins WHERE bankName = @bnkName', {
                        ['bnkName'] = k.bankName,
                        ['mins'] = k.minutes - 1
                    })
                end

                if k.minutes == 0 and k.hours == 0 then
                    if k.status == "Available" then

                        exports.oxmysql:execute('SELECT * FROM _bankbusters_queue WHERE bankName = @bnkName', {
                            ['bnkName'] = k.bankName
                        }, function(bbResult)
                            if bbResult[1] ~= nil then
                                exports.oxmysql:execute("UPDATE _bankbusters SET status = @Status, hours = @Hrs, minutes = @Mins WHERE bankName = @BankName", {
                                    ['Status'] = "Claimed",
                                    ['BankName'] = k.bankName,
                                    ['Hrs'] = "00",
                                    ['Mins'] = "00",
                                })

                                for y,n in pairs(GetPlayers()) do
                                    local user = exports['fa-base']:getModule("Player"):GetUser(tonumber(n))

                                    if user:getCurrentCharacter().id == bbResult[1].leaderStateID then
                                        if tonumber(n) ~= nil then
                                            exports.oxmysql:execute('UPDATE characters SET claimedBank = @CB WHERE id = @stateID', {
                                                ['CB'] = "0",
                                                ['stateID'] = bbResult[1].leaderStateID
                                            })

                                            local information = {
                                                ["name"] = k.bankName,
                                            }

                                            TriggerClientEvent('player:receiveItem', tonumber(n), 'accesscodes', 1, true, information)
                                            TriggerClientEvent('phone:addnotification', tonumber(n), 'Dark Market', 'You successfully claimed heists access codes. Invite the people who you plan to rob the bank with to your bankbusters group. Good Luck !!')

                                            local getRandomInt = math.random(1, 999999999)
                                            groupTable[#groupTable+1] = {
                                                members = {
                                                    [getRandomInt] = {
                                                        ["groupID"] = getRandomInt,
                                                        ["cid"] = bbResult[1].leaderStateID,
                                                        ["name"] = getFullNameFromCid(bbResult[1].leaderStateID),
                                                        ["leader"] = true,
                                                        ['GroupBank'] = k.bankName,
                                                    }
                                                }
                                            }
                                        else
                                            exports.oxmysql:execute("UPDATE _bankbusters SET status = @Status, hours = @Hrs, minutes = @Mins WHERE bankName = @BankName", {
                                                ['BankName'] = k.bankName,
                                                ['Status'] = "Expired",
                                                ['Hrs'] = "00",
                                                ['Mins'] = "00"
                                            })
                                        end
                                    end
                                end
                            else
                                exports.oxmysql:execute("UPDATE _bankbusters SET status = @Status, hours = @Hrs, minutes = @Mins WHERE bankName = @BankName", {
                                    ['BankName'] = k.bankName,
                                    ['Status'] = "Expired",
                                    ['Hrs'] = "00",
                                    ['Mins'] = "00"
                                })
                            end

                            exports.oxmysql:execute("DELETE FROM _bankbusters_queue WHERE bankName = @bankName", {['@bankName'] = k.bankName}, function()end)
                        end)
                    end
                end
            end
        end)
    end
end)

RPC.register('fa-phone:getBankBustersCodesSlot', function(source, cid)
    local data = MySQL.query.await([[
        SELECT * FROM user_inventory2 WHERE item_id = ? AND name = ?
    ]], {"accesscodes", 'ply-'..cid})
    
    return data[1].slot
end)

exports('addBankBusters', addBankBusters)
exports('getBankBusterGroups', getBankBusterGroups)

Citizen.CreateThread(function()
    exports.oxmysql:execute('DELETE FROM _bankbusters', function(deletedBankBusters) end)
    exports.oxmysql:execute('DELETE FROM _bankbusters_queue', function(deletedBankBusters) end)
    exports.oxmysql:execute('DELETE FROM user_inventory2 WHERE item_id = @iID', {['iID'] = "accesscodes"})

    exports.oxmysql:execute('UPDATE characters SET claimedBank = @CB', {
        ['CB'] = "0",
    })
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    exports.oxmysql:execute('SELECT * FROM _bankbusters', function(resultz)
        if json.encode(resultz) == "[]" then
            exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
                "Fleeca: Legion",
                math.random(0, 3),
                math.random(0, 60),
                "Available",
                "1"
            })

            exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
                "Fleeca: Blvd Del Perro",
                math.random(2, 4),
                math.random(0, 60),
                "Available",
                "2"
            })

            exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
                "Fleeca: Great Ocean",
                math.random(0, 3),
                math.random(30, 60),
                "Available",
                "3"
            })

            exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
                "Fleeca: Hawick",
                math.random(1, 3),
                "0",
                "Available",
                "5"
            })

            -- exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
            --     "Vault",
            --     os.time() + math.random(7000, 15000),
            --     "Available",
            --     "6"
            -- })

            exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
                "Fleeca: Harmony",
                math.random(3, 5),
                "0",
                "Available",
                "7"
            })

            -- exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
            --     "Fleeca: Paleto",
            --     os.time() + math.random(3000, 10000),
            --     "Available",
            --     "8"
            -- })

            -- exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
            --     "Bay City Bank",
            --     os.time() + math.random(3000, 10000),
            --     "Available",
            --     "9"
            -- })

            -- exports.oxmysql:execute("INSERT INTO _bankbusters (bankName, hours, minutes, status, bankid) VALUES (?, ?, ?, ?, ?)", {
            --     "Jewelry Store",
            --     os.time() + math.random(3000, 10000),
            --     "Available",
            --     "10"
            -- })

            Citizen.Wait(5000)

            exports.oxmysql:execute('SELECT * FROM _bankbusters', function(bankBusters)
                for i, k in pairs(bankBusters) do
                    table.insert(currentBanks, {
                        ['bankName'] = k.bankName,
                        ['bankExpires'] = k.hours..'h '..k.minutes..'m',
                        ['status'] = k.status,
                        ['bankID'] = k.bankid
                    })
                end
            end)
        end
    end)
end)

AddEventHandler('playerDropped', function()
    local src = source
    local user = exports['fa-base']:getModule('Player'):GetUser(src)
    local cid = user:getVar("character").id

    exports.oxmysql:execute('DELETE FROM _bankbusters_queue WHERE leaderStateID = @lSID', {
        ['lSID'] = cid
    })

    exports.oxmysql:execute('UPDATE characters SET claimedBank = @CB WHERE id = @stateID', {
        ['CB'] = "0",
        ['stateID'] = cid
    })
end)