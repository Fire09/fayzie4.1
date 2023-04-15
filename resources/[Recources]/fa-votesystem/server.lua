local recentconvictions = {}
votingEnabled = false
mayorid = 0
mayortax = 0
FundsToAdd = 0
CurrentFunds = 0

RegisterServerEvent('showbusinesses')
AddEventHandler('showbusinesses', function(businessString)
    local src = source
    TriggerClientEvent('outlawNotifyBusiness', -1, src, businessString)
end)

RegisterServerEvent('votesystem:removefunds')
AddEventHandler('votesystem:removefunds', function(amount)
    FundsToAdd = FundsToAdd - amount
    FundsToAdd = math.floor(FundsToAdd)
end)

FundsToAdd = 0
CurrentFunds = 0
RegisterServerEvent('votesystem:addfunds')
AddEventHandler('votesystem:removefunds', function(amount)
    FundsToAdd = FundsToAdd + amount
    FundsToAdd = math.floor(FundsToAdd)
end)

RegisterServerEvent('getLatestPayBonus')
AddEventHandler('getLatestPayBonus', function()
    policebonus = 0
    emsbonus = 0
    civbonus = 0
    TriggerEvent("updatePays", policebonus, emsbonus, civbonus)
end)

function runPaySystem()
    TriggerEvent("getLatestPayBonus")
    -- checkmayor()
    updateCurrentTax()
    checkLastValue()
    AddFunds()
    updateMayorId()
end

local hotSpots = {
    ["Strawberry"] = {
        ["ratio"] = 0,
        ["zone"] = 1
    },
    ["Rancho"] = {
        ["ratio"] = 0,
        ["zone"] = 1
    },
    ["Chamberlain Hills"] = {
        ["ratio"] = 0,
        ["zone"] = 1
    },
    ["Davis"] = {
        ["ratio"] = 0,
        ["zone"] = 1
    },
    ["West Vinewood"] = {
        ["ratio"] = 0,
        ["zone"] = 2
    },
    ["Downtown Vinewood"] = {
        ["ratio"] = 0,
        ["zone"] = 2
    }
}

RegisterNetEvent('drugs:hotSpots')
AddEventHandler('drugs:hotSpots', function(newhotSpots)
    hotSpots = newhotSpots
end)

local notDone = true
local startTime = os.time()

function RandomizeHotSpots()
    startTime = os.time()
    notDone = false
    hotSpots = {
        ["Strawberry"] = {
            ["ratio"] = 0,
            ["zone"] = 1
        },
        ["Rancho"] = {
            ["ratio"] = 0,
            ["zone"] = 1
        },
        ["Chamberlain Hills"] = {
            ["ratio"] = 0,
            ["zone"] = 1
        },
        ["Davis"] = {
            ["ratio"] = 0,
            ["zone"] = 1
        },
        ["West Vinewood"] = {
            ["ratio"] = 0,
            ["zone"] = 2
        },
        ["Downtown Vinewood"] = {
            ["ratio"] = 0,
            ["zone"] = 2
        }
    }

    local oneset = false
    if math.random(100) > 70 then
        oneset = true
        hotSpots["Strawberry"]["ratio"] = math.random(50, 100)
    end
    if math.random(100) > 70 then
        oneset = true
        hotSpots["Rancho"]["ratio"] = math.random(50, 100)
    end

    if not oneset then
        hotSpots["Chamberlain Hills"]["ratio"] = math.random(50, 100)
    end

    if math.random(100) > 70 then
        oneset = true
        hotSpots["Davis"]["ratio"] = math.random(50, 100)
    end
    if math.random(100) > 50 then
        hotSpots["West Vinewood"]["ratio"] = math.random(50, 100)
    else
        hotSpots["Downtown Vinewood"]["ratio"] = math.random(50, 100)
    end
end

function gangCoords(gangType, src)
    src = tonumber(src)
    gangType = tonumber(gangType)
    if gangType == 1 then
        gangtable = "gunrunner_farming"
    elseif gangType == 2 then
        gangtable = "cocaine_farming"
    elseif gangType == 3 then
        gangtable = "launder_farming"
    end
    exports.oxmysql.execute("SELECT coords FROM " .. gangtable .. "HERE id = @id", {
        ['id'] = 1
    }, function(result)
        if result[1] ~= nil then
            local gcoords = result[1].coords
            if gcoords ~= nil then
                TriggerClientEvent("gang:setcoords", -1, gcoords, gangType)
            end
        else
            -- enter default coords
        end
    end)
end

function updateHotSpotPrices()

    if notDone then
        RandomizeHotSpots()
        notDone = false
    end

    if startTime + (6000) < os.time() then
        notDone = true
    end

    TriggerClientEvent("drugs:hotSpots", -1, hotSpots)
    TriggerEvent("np:news:setHotSpots", hotSpots)
    SetTimeout(300000, updateHotSpotPrices)

end

exports("GetHotSpots", function()
    return hotSpots
end)
SetTimeout(1000, updateHotSpotPrices)

RegisterServerEvent('gang:updatecoords')
AddEventHandler('gang:updatecoords', function(gangType, newCoords)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)
    local usercash = user:getCash()

    if gangType > 0 and usercash > 5000 then
        updateCoords(gangType, newCoords)
        user:removeMoney(5000)
    end

end)

function CompleteUpdate(currentFunds)
    currentFunds = tonumber(currentFunds)
    exports.oxmysql:execute("UPDATE general_variables SET value = @value WHERE id = @name", {
        ['value'] = currentFunds,
        ['name'] = 3
    })
end

RegisterServerEvent('updatecoordsweed')
AddEventHandler('updatecoordsweed', function(gangType, newCoords)
    exports.oxmysql:execute("UPDATE weed_farming SET coords = @newCoords WHERE id = @id", {
        ['newCoords'] = newCoords,
        ['id'] = 1
    })
    TriggerClientEvent("gang:setcoords", -1, newCoords, gangType)
end)

-- guns meth launder weed
-- gunrunner_farming meth_farming launder_farming weed_farming
function updateCoords(gangType, newCoords)
    src = tonumber(src)
    gangType = tonumber(gangType)
    if gangType == 1 then
        gangtable = "gunrunner_farming"
    elseif gangType == 2 then
        gangtable = "cocaine_farming"
    elseif gangType == 3 then
        gangtable = "launder_farming"
    end
    exports.oxmysql.execute("UPDATE" .. gangtable .. " SET coords = @newCoords WHERE id = @id", {
        ['newCoords'] = newCoords,
        ['id'] = 1
    })
    TriggerClientEvent("gang:setcoords", -1, newCoords, gangType)

end

function updateMayorId()
    exports.oxmysql:execute("SELECT value FROM general_variables WHERE id = @id", {
        ['id'] = 2
    }, function(result)
        mayorid = result[1].value
    end)
end

function updateCurrentTax()
    exports.oxmysql:execute("SELECT value FROM general_variables WHERE id = @id", {
        ['id'] = 4
    }, function(result)
        mayortax = result[1].value
    end)
end

function AddFunds()
    if FundsToAdd ~= 0 then

        exports.oxmysql:execute("SELECT value FROM general_variables WHERE id = @id", {
            ['id'] = 3
        }, function(result)

            currentFunds = tonumber(result[1].value) + tonumber(FundsToAdd)
            currentFunds = math.ceil(currentFunds)
            FundsToAdd = 0

            CompleteUpdate(currentFunds)

        end)
    end
    SetTimeout(600000, AddFunds)
end

RegisterServerEvent('group:pullinformation')
AddEventHandler('group:pullinformation', function(groupid, rank)
    local src = source
    exports.oxmysql:execute(
        "SELECT * FROM character_passes WHERE pass_type = @groupid and rank > 0 ORDER BY rank DESC", {
            ['groupid'] = groupid
        }, function(results)
            if results ~= nil then
                exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @groupid", {
                    ['groupid'] = groupid
                }, function(result)
                    local bank = 0
                    if result[1] ~= nil then
                        bank = result[1].bank
                    end
                    TriggerClientEvent("group:fullList", src, results, bank, groupid)
                end)
            else
                TriggerClientEvent("phone:error", src)
            end
        end)
end)

RPC.register("getCharacterPasses", function(pSource)
    local passList = {}
    local src = pSource
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()

    local data = Await(SQL.execute("SELECT * FROM character_passes WHERE character_id = ?", character.id))
    if data ~= nil then
        for k, v in pairs(data) do
            passList[v.name] = v
        end

        return passList
    end

    return nil
end)

passnames = {
	["gym"] = "LS Gym",
	["golf"] = "Golf Course",
	["strip_club"] = "Vanilla Unicorn",
	["illegal_carshop"] = "Camel Tows",
	["winery_factory"] = "Delmar & Caine",
	["carpet_factory"] = "Carpet Company",
	["life_invader"] = "Life Invader",
	["casino"] = "Los Santos Casino",
	["real_estate"] = "Los Santos Real Estate",
	["weed_factory"] = "The Greenery",
	["chop_shop"] = "Choppers",
	["parts_shop"] = "Parts Shop",
	["recycle_shop"] = "Recycle Centre",
	["car_shop"] = "Car Shop",
    ["burger_shot"] = "Burger Shot",
	["repairs_harmony"] = "Harmony Repairs",
	['tuner_carshop'] = "Tuner Carshop",
	['dock_worker'] = "Dock Worker",
	['lost_mc'] = "The Lost MC",
	['ug_racing'] = "Underground Racing",
	['hoa'] = "Home Owners Assoc.",
    ['rooster_academy'] = "The Rooster Academy",
    ['sahara_int'] = "Sahara International",
    ['drift_school'] = "Overboost Drift",
    ['auto_exotic'] = "Auto Exotic",
    ['sasp'] = "San Andreas State Police",
    ['saspr'] = "San Andreas State Park Rangers",
    ['lspd'] = "Los Santos Police Department",
    ['bcso'] = "Blaine County Sheriffs Office",
    ['pdhc'] = "Police Department High Command",
    ['lsm'] = "Los Santos Medical",
    ['heat'] = "Heat Unit",
    ['buns_n_roses'] = "Buns N Roses Cafe",
    ['business_boa'] = "Business Owners Association",
    ['gallery'] = "Vultur Le Culture",
    ['everybody_k'] = "Everybody Killas",
    ['ms13'] = "MS13",
    ['tuner'] = "Tuner Shop",
    ['bbmc'] = "Bondi Boys MC",
    ['camp_arpee'] = "Camp Arpee",
    ['le_fuente_blanca'] = "Le Fuente Blanca",
    ['mdm_records'] = "Mandem",
    ['wuchang'] = "Novel Records",
    ['mandem'] = "Mandem",
    ['sosa_family'] = "Sosa Family",
    ['gambinos'] = "Gambinos",
    ['bahama_mamas'] = "Bahama Mamas",
    ['influencer'] = "Influencer",
    ['phoenixbg'] = "Phoenix Business Group",
    ['saints'] = "Saints",
    ['corruption'] = "Corruption",
    ['ktownogs'] = "K Town OGs",
    ['yakuza'] = "Yakuza"
}

-- here we wipe the weed group and start over.

RegisterServerEvent('server:givepayJob')
AddEventHandler('server:givepayJob', function(pJob, pAmount, pSource)
    local src
    if pSource ~= nil then
        src = pSource
    else
        src = source
    end
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)
    exports.oxmysql:execute("SELECT id, paycheck FROM characters WHERE id = @id", {
        ['id'] = cid
    }, function(result)
        if result[1] ~= nil then
            local curPaycheck = result[1].paycheck
            TriggerClientEvent("DoLongHudText", src,
                "A payslip of $" .. pAmount .. " making a total of $" .. tonumber(curPaycheck) .. " with $" ..
                    (math.floor(tonumber(curPaycheck) / 15)) .. " tax withheld on your last payment.")
        end
    end)

    exports.oxmysql:execute("UPDATE characters SET paycheck = paycheck + @amount WHERE id = @cid", {
        ['cid'] = cid,
        ['amount'] = pAmount
    })
end)

RegisterServerEvent('server:paySlipPickup')
AddEventHandler('server:paySlipPickup', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = char.id

    exports.oxmysql:execute("SELECT id,paycheck FROM characters WHERE id = @id", {
        ['id'] = cid
    }, function(result)
        if result[1] ~= nil then
            local curPaycheck = result[1].paycheck
            if curPaycheck > 0 then
                exports.oxmysql:execute("UPDATE characters SET paycheck = 0 WHERE id  = @id", {
                    ['id'] = cid
                })
                -- local targetAccountId = exports["banking"]:getBankAccount(cid, true)
                -- exports["banking"]:doPersonalTransaction(cid, 1, targetAccountId, curPaycheck, "Payslip")
                user:addBank(curPaycheck)
                TriggerClientEvent("DoLongHudText", src,
                    "Your payslip of $" .. curPaycheck .. " has been transferred to your bank account", 1)
            else
                TriggerClientEvent("DoLongHudText", src,
                    "The cashier stares at you awkardly and says, 'You have no payslip?'", 2)
            end
        end
    end)
end)

RegisterServerEvent('server:givepass')
AddEventHandler('server:givepass', function(pass_type, wrank, cid)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if getRank(char.id, pass_type) >= 4 then
        local success = Await(SQL.execute("UPDATE character_passes SET rank = ? WHERE cid = ? AND pass_type = ?", wrank, cid, pass_type))
        if success.affectedRows > 0 then
            --print("hired but chad way")
            TriggerClientEvent("DoLongHudText", src, "You have given " .. passnames[pass_type] .. " to " .. getName(cid) .. ".")
        else
            exports.oxmysql:execute(
                "INSERT INTO character_passes(cid, rank, name, giver, pass_type, business_name) values (@cid, @rank, @name, @giver, @gang_id, @business_name)",
                {
                    ["cid"] = cid,
                    ['rank'] = wrank,
                    ['name'] = getName(cid),
                    ['giver'] = char.first_name .. ' ' .. char.last_name,
                    ['gang_id'] = pass_type,
                    ['business_name'] = pass_type
                })
                TriggerClientEvent("DoLongHudText", src, "You have given " .. passnames[pass_type] .. " to " .. getName(cid) .. ".")
                --print("hired yes?")
        end
    else
        --print("cant hire loool loser")
        TriggerClientEvent("DoLongHudText", src, "You do not have permission to hire somebody.")
    end
end)

function getName(cid)
    local data = Await(SQL.execute("SELECT first_name, last_name FROM characters WHERE id = ?", cid))

    return data[1].first_name .. ' ' .. data[1].last_name
end

function getRank(pCid, pBusinessName)
    local data = Await(SQL.execute("SELECT rank FROM character_passes WHERE cid = ? AND pass_type = ?", pCid, pBusinessName))

    return data[1].rank
end


RegisterServerEvent('server:givepayGroup')
AddEventHandler('server:givepayGroup', function(groupname, amount, cid)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @id", {
        ['id'] = groupname
    }, function(data)
        if data[1].bank >= tonumber(amount) then
            local removeMoney = Await(SQL.execute("UPDATE group_banking SET bank = bank - ? WHERE group_type = ?", tonumber(amount), groupname))
            if removeMoney.affectedRows > 0 then
                addPaycheck(cid, amount)
                TriggerClientEvent("DoLongHudText", src, "You have given $" .. amount .. " to " .. getName(cid) .. ".")
            end
        else
            TriggerClientEvent('DoLongHudText', src, 'This company afford that payment.', 2)
        end
    end)
end)

function addPaycheck(cid, amount)
    exports.oxmysql:execute("UPDATE characters SET paycheck = paycheck + @amount WHERE id = @cid", {
        ['cid'] = cid,
        ['amount'] = amount
    })
end

RegisterServerEvent('server:gankGroup')
AddEventHandler('server:gankGroup', function(groupid, amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if user:getCash() >= tonumber(amount) then
        user:removeMoney(tonumber(amount))
        exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @id", {
            ['id'] = groupid
        }, function(result)
            local solution = result[1].bank + amount
            exports.oxmysql:execute("UPDATE group_banking SET `bank` = @bank WHERE `group_type` = @id", {
                ['id'] = groupid,
                ['bank'] = solution
            })
            TriggerClientEvent("DoLongHudText", src, "You have ganked $" .. amount .. " to " .. groupid .. ".")
        end)
    else
        TriggerClientEvent('DoLongHudText', 'Invalid Amount Please Check Your Cash!')
    end
end)

RegisterServerEvent('setPolicePay')
AddEventHandler('setPolicePay', function(newPay)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not user then
        return
    end

    if not user:getVar("mayor") then
        DropPlayer(src, "")
    end

    local payRate = tonumber(payRate)

    if payRate > 200 or payRate < 0 then
        return
    end

    exports.oxmysql:execute("UPDATE general_variables SET value = @value WHERE id = @name", {
        ['value'] = newPay,
        ['name'] = 7
    })
    TriggerEvent("updateSinglePlays", payRate, 'police')
end)

RegisterServerEvent('setEmsPay')
AddEventHandler('setPolicePay', function(newPay)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not user then
        return
    end

    if not user:getVar("mayor") then
        DropPlayer(src, "")
    end

    local payRate = tonumber(payRate)

    if payRate > 200 or payRate < 0 then
        return
    end

    exports.oxmysql:execute("UPDATE general_variables SET value = @value WHERE id = @name", {
        ['value'] = newPay,
        ['name'] = 7
    })
    TriggerEvent("updateSinglePlays", payRate, 'ems')
end)

RegisterServerEvent('setCivilianPay')
AddEventHandler('setPolicePay', function(newPay)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not user then
        return
    end

    if not user:getVar("mayor") then
        DropPlayer(src, "")
    end

    local payRate = tonumber(payRate)

    if payRate > 100 or payRate < 0 then
        return
    end

    exports.oxmysql:execute("UPDATE general_variables SET value = @value WHERE id = @name", {
        ['value'] = newPay,
        ['name'] = 7
    })
    TriggerEvent("updateSinglePlays", payRate, 'civilian')
end)

function setValue(amount)

    if amount >= 0 and amount <= 45000 then
        return 7
    elseif amount >= 45000 and amount <= 100000 then
        return 20
    elseif amount >= 100000 and amount <= 250000 then
        return 30
    elseif amount >= 250000 and amount <= 500000 then
        return 40
    elseif amount >= 500000 and amount <= 750000 then
        return 50
    elseif amount >= 750000 and amount <= 999999 then
        return 60
    else
        return 70
    end

end

RegisterServerEvent('checkTypes')
AddEventHandler('checkTypes', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)
    local mayorid = tonumber(mayorid)
    -- user:setTax(tonumber(mayortax))

    local myname = char.first_name .. "  " .. char.last_name

    TriggerEvent("garages:loginKeyRequest", src)

    TriggerClientEvent("updateNameClient", src, char.first_name, char.last_name, char.phone_number)

    TriggerClientEvent("updatecid", src, cid)
	TriggerClientEvent("updateAlias", src, char.alias)

    TriggerEvent("stocks:update")

    TriggerClientEvent("setTax", src, 5)

    if cid == mayorid then
        user:setVar("mayor", true)
        TriggerClientEvent("setMayor", src)
        TriggerClientEvent("DoLongHudText", -1, "The mayor has joined the city! " .. myname, 1)
    end

    TriggerEvent("phone:activeNumber", src, true)

    local judgeType = user:getJudgeType()
    local stresslevel = user:getStressLevel()

    TriggerClientEvent("client:updateStress", source, tonumber(stresslevel))
    judgeType = tonumber(judgeType)
    if judgeType ~= 0 then
        TriggerClientEvent("isJudge", src)
        Wait(1000)
        TriggerEvent("isJudge", src)
    end
end)

--   exports.oxmysql:execute("SELECT rank FROM jobs_whitelist WHERE job = @job AND cid = @cid", {['job'] = "therapist", ["cid"] = cid}, function(result2)
--     if(result2 ~= nil and result2[1] ~= nil) then
--       if result2[1].rank >= 1 then
--         TriggerClientEvent("isTherapist",src)
--         Wait(1000)
--         TriggerEvent("isTherapist",src)
--       end
--     end
--   end)

--   TriggerEvent("gang:reputationStart",src,cid)
-- end)

-- RegisterServerEvent('server:alterStress')
-- AddEventHandler('server:alterStress', function(positive, alteredValue)
--     if alteredValue ~= nil then
--         raszebi = alteredValue
--     else
--         raszebi = 0
--     end
--     local src = source
--     local user = exports["fa-base"]:getModule("Player"):GetUser(source)
--     local stresslevel = user:getStressLevel()
--     if positive then
--         stresslevel = stresslevel + raszebi
--     else
--         stresslevel = stresslevel - raszebi
--     end
--     if stresslevel > 10000 then
--         stresslevel = 10000
--     end
--     if stresslevel < 0 then
--         stresslevel = 0
--     end
--     user:alterStressLevel(stresslevel)
--     TriggerClientEvent("client:updateStress", src, stresslevel)
-- end)

RegisterServerEvent('gang:allowAccess')
AddEventHandler('gang:allowAccess', function(gangType)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)

    if gangType > 0 then
        gangCoords(gangType, src)
    end

    TriggerClientEvent('enablegangmember', src, gangType, cid)
end)

RegisterServerEvent('server:currentpassestgt')
AddEventHandler('server:currentpassestgt', function(tgt)
    local src = tonumber(tgt)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.oxmysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {
        ['cid'] = char.id
    }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("client:passes", src, result)
        else
            TriggerClientEvent("client:passes", src, {})
        end
    end)
end)

RegisterServerEvent('updatePasses')
AddEventHandler('updatePasses', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)
    local mayorid = tonumber(mayorid)

    TriggerEvent("server:currentpassesgt", src)

    exports.oxmysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {
        ['cid'] = char.id
    }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("client:passes", src, result)
        else
            TriggerClientEvent("client:passes", src, {})
        end
    end)
end)

RegisterServerEvent('server:currentpasses')
AddEventHandler('server:currentpasses', function(passType)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.oxmysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {
        ['cid'] = char.id
    }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("client:passes", src, result)
        else
            TriggerClientEvent("client:passes", src, {})
        end
    end)
end)

RegisterServerEvent('checkmayorname')
AddEventHandler('checkmayorname', function()
    local src = source
    local mayorname = "None"

    exports.oxmysql:execute("SELECT first_name, last_name FROM characters WHERE id = @id", {
        ['id'] = mayorid
    }, function(result)

        if result[1] ~= nil then
            blah = result[1].first_name
            dicks = result[1].last_name
            TriggerClientEvent("DoLongHudText", src, "The Mayor is " .. blah .. " " .. dicks, 1)
        else
            TriggerClientEvent("DoLongHudText", src, "The Mayor is " .. mayorname, 1)
        end

    end)

end)

RegisterServerEvent('server:PayStoreOwner')
AddEventHandler('server:PayStoreOwner', function(cid, cashamount)
    local job = "Player Store Owner"

    exports.oxmysql:execute("SELECT id,paycheck FROM characters WHERE id = @cid", {
        ['cid'] = cid
    }, function(result)
        if result[1] ~= nil then
            local curPaycheck = result[1].paycheck
            local taxWithheld = (cashamount * (mayortax / 100))
            curPaycheck = curPaycheck + (cashamount - (taxWithheld))
            exports.oxmysql:execute("UPDATE characters SET paycheck = @curPayCheck WHERE id = @cid", {
                ['cid'] = cid,
                ['curPayCheck'] = curPaycheck
            })
            TriggerEvent('votesystem:addfunds', taxWithheld)
        end
    end)
end)

RegisterServerEvent('server:GroupPayment')
AddEventHandler('server:GroupPayment', function(gangid, cashamount, sauce)
    local src = sauce

    if sauce == nil then
        src = source
    end
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)

    exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @gangid", {
        ['gangid'] = gangid
    }, function(result)

        if result[1] ~= nil then

            local curbank = result[1].bank
            curbank = curbank + cashamount
            exports.oxmysql:execute("UPDATE group_banking SET bank = @bank WHERE group_type = @gangid", {
                ['gangid'] = gangid,
                ['bank'] = curbank
            })
        end
    end)
end)

function doNewValueCheck()
    exports.oxmysql:execute("SELECT name,paid_funds,money,paid_funds FROM user_appartements", {}, function(result)
        for i = 1, #result do
            local name = result[i].name
            local payment = (tonumber(result[i].paid_funds)) + (tonumber(result[i].money))
            local valuecheck = setValue(tonumber(result[i].paid_funds))
            -- mysql update
        end
    end)
end

RegisterServerEvent('lastconviction')
AddEventHandler('lastconviction', function(newconv)
    recentconvictions[#recentconvictions + 1] = newconv
    TriggerClientEvent("lastconvictionlist", -1, recentconvictions)
end)

RegisterServerEvent('currentconvictions')
AddEventHandler('currentconvictions', function(newconv)
    TriggerClientEvent("lastconvictionlist", -1, recentconvictions)
end)
