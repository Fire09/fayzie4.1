local weapons = ""
local playerInjury = {}
local bones = {}
local multipledenominators = {}

local firstname = {'Mona', 'Ray', 'Sonny', 'Don', 'Jo', 'Joe', 'Dixon', 'Ben', 'Hugh G.', 'Duncan', 'Mike', 'Mike',
                   'Mike', 'Ima', 'Richard'}

local lastname = {'Alott', 'Gunn', 'Day', 'Key', 'King', 'Kane', 'Uranus', 'Dover', 'Rection', 'McOkiner', 'Hawk',
                  'Hunt', 'Oxlong', 'Pigg', 'Head'}

local logged = {}

RegisterServerEvent('server:takephone')
AddEventHandler('server:takephone', function(target)
    TriggerClientEvent('inventory:removeItem', target, "mobilephone", 1)
end)

RegisterServerEvent('fa-police:multipledenominators')
AddEventHandler('fa-police:multipledenominators', function(hasdenoms)
    local src = source
    if hasdenoms then
        multipledenominators[src] = true
    else
        multipledenominators[src] = nil
    end
end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(player)
    TriggerClientEvent('playerTackled', player)
end)

RegisterServerEvent('fa-police:targetCheckBank')
AddEventHandler('fa-police:targetCheckBank', function(target)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(target)
    local char = user:getCurrentCharacter()
    balance = user:getBalance()
    local strng = " Bank: " .. balance
    TriggerClientEvent("DoLongHudText", src, strng)
end)

RegisterNetEvent("policeimpound")
AddEventHandler("policeimpound", function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)
    user:addMoney(100)
    -- Easily exploitable, will be looked at later.
end)

RegisterServerEvent('checkVehVin')
AddEventHandler('checkVehVin', function(plate)
    local src = source
    exports.oxmysql:execute('SELECT * FROM characters_cars WHERE `license_plate` = @plate', {['@plate'] = plate}, function(result)
        if not result[1].vin then return end
        if result[1].vin == "1" then
            TriggerClientEvent("chatMessage", src, "DISPATCH", 3,"Plate does not match ! (VIN)")
        else
            TriggerClientEvent("chatMessage", src, "DISPATCH", 2,"Plate does match ! (PDM)")
        end
    end)
end)

RegisterServerEvent('checkLicensePlate')
AddEventHandler('checkLicensePlate', function(oof)
    local source = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(source)
    local char = user:getCurrentCharacter()
    local job = "Unemployed"
    local message = ""
    local phonenumber = char.phone_number
    local kekw = oof
    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE `license_plate` = @plate', {['@plate'] = kekw}, function(result)
        if result[1] ~= nil then
            exports.ghmattimysql:execute('SELECT * FROM characters WHERE `id` = @cid', {['@cid'] = result[1].cid}, function(data)
                exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE `cid` = @cid', {['@cid'] = data[1].id}, function(penis)
                    if penis[1] ~= nil then
                        job = penis[1].business_name
                        if job == "police" then
                            job = "Police"
                        elseif job == "ems" then
                            job = "EMS"
                        elseif job == "mandem" then
                            job = "Unemployed"
                        elseif job == "sosa" then
                            job = "Unemployed"
                        elseif job == "gambinos" then
                            job = "Unemployed"
                        elseif job == "black_mafia" then
                            job = "Unemployed"
                        elseif job == "saigons" then
                            job = "Unemployed"
                        end
                        local phoneNumber = string.sub(data[1].phone_number, 0, 3) .. '' ..string.sub(data[1].phone_number, 4, 6) .. '' ..string.sub(data[1].phone_number, 7, 10)
                        TriggerClientEvent("chatMessage", source, "DISPATCH", 3,"10-74 (Negative) \n Name: " .. data[1].first_name .. " " .. data[1].last_name .. " \n Phone: " ..phoneNumber .. ' \n Plate: ' .. kekw)
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'radioclick', 1.0)
                    else
                        local phoneNumber = string.sub(data[1].phone_number, 0, 3) .. '-' ..string.sub(data[1].phone_number, 4, 6) .. '-' ..string.sub(data[1].phone_number, 7, 10)
                        TriggerClientEvent("chatMessage", source, "DISPATCH", 3,"10-74 (Negative) \n Name: " .. data[1].first_name .. " " .. data[1].last_name .. " \n Phone: " ..phoneNumber .. ' \n Plate: ' .. kekw)
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'radioclick', 1.0)
                    end
                end)
            end)
        elseif logged[#logged] ~= nil then
            for k, v in ipairs(logged) do
                if v.plate == kekw then
                    TriggerClientEvent("chatMessage", source, "DISPATCH", 3,"10-74 (Negative) \n Name: " .. v.firstname .. " " .. v.lastname .. " \n Phone #: " ..math.random(000, 999) .. '' .. math.random(000, 999) .. '' .. math.random(0000, 9999) ..' \n Plate: ' .. kekw)
                end
            end
        else
            local insert = {
                plate = kekw,
                firstname = firstname[math.random(1, 5)],
                lastname = lastname[math.random(1, 5)]
            }
            TriggerClientEvent("chatMessage", source, "DISPATCH", 3, "10-74 (Negative) \n Name: " .. insert.firstname .. " " .. insert.lastname .. " \n Phone #: " .. math.random(000, 999) .. '' .. math.random(000, 999) .. '' .. math.random(0000, 9999) .. ' \n Plate: ' .. kekw)
            logged[#logged + 1] = insert
            TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'radioclick', 1.0)
        end
    end)
end)

RegisterServerEvent('dragPlayer:disable')
AddEventHandler('dragPlayer:disable', function()
    TriggerClientEvent('drag:stopped', -1, source)
end)

RegisterServerEvent('dr:releaseEscort')
AddEventHandler('dr:releaseEscort', function(releaseID)
    TriggerClientEvent('dr:releaseEscort', tonumber(releaseID))
end)

RegisterServerEvent('fa-police:IsTargetCuffed') -- that is np's code ((sway))
AddEventHandler('fa-police:IsTargetCuffed', function(playerID)
    local src = source
    TriggerClientEvent("fa-police:IsPlayerCuffed", playerID, src)
end)

-- done ((sway))
function CheckLicense(cid, license)
    exports.ghmattimysql:execute("SELECT @license FROM licenses WHERE cid = @id", {
        ['id'] = cid,
        ['license'] = license
    }, function(result)
        if (result[1]) then
            response = result.license
        end
    end)
    Wait(200)
    if response then
        return true
    else
        return false
    end
end

function getmonth(month) -- that is np's code ((sway))
    local months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
    return months[tonumber(month)]
end

function ConvertDate(d) -- that is np's code ((sway))
    local newD = math.ceil(tonumber(d / 1000))
    local msgtime = "NA"
    if newD < 0 then
        newD = newD + 4070912400
        local a = os.date("%b %Y", newD)
        msgtime = string.upper(getmonth(a.month) .. " " .. (a.year - 129))
    else
        msgtime = os.date("%b &Y", newD)
        msgtime = string.upper(msgtime)
    end
    return msgtime
end

RegisterNetEvent("spawn100k")
AddEventHandler("spawn100k", function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(500)
end)

RegisterServerEvent('fa-police:showID')
AddEventHandler('fa-police:showID', function(itemInfo)
    local src = source
    local fuck = json.decode(itemInfo)
    local data = {
        ['DOB'] = fuck.DOB,
        ['Name'] = fuck.Name,
        ['Surname'] = fuck.Surname,
        ['Sex'] = fuck.Sex,
        ['Identifier'] = fuck.Identifier,
        ['pref'] = "sex"
    }

    if data.Sex == 0 then
        data = {
            ['DOB'] = fuck.DOB,
            ['Name'] = fuck.Name,
            ['Surname'] = fuck.Surname,
            ['Sex'] = "M",
            ['Identifier'] = fuck.Identifier,
            ['pref'] = "Male"
        }
    elseif data.Sex == 1 then
        data = {
            ['DOB'] = fuck.DOB,
            ['Name'] = fuck.Name,
            ['Surname'] = fuck.Surname,
            ['Sex'] = "F",
            ['Identifier'] = fuck.Identifier,
            ['pref'] = "Female"
        }
    end
    TriggerClientEvent("chat:showCID", -1, data, src)
end)

RegisterServerEvent('gc:showthemIdentity')
AddEventHandler('gc:showthemIdentity', function(user)
    local src = source
    --
end)

RegisterServerEvent('fa-police:showPH') -- that is np's code ((sway))
AddEventHandler('fa-police:showPH', function()
    local src = source
    local player = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = player:getCurrentCharacter()
    local result = {
        phone_number = char.phone_number
    }
    TriggerClientEvent('outlawNotifyPhone', -1, src, result)
end)

RegisterServerEvent('fa-police:jailGranted')
AddEventHandler('fa-police:jailGranted', function(args)
    local src = source
    reason = " "
    for argscount = 4, #args do
        reason = reason .. " " .. args[argscount]
    end

    print(tonumber(args[1]))
 
    local player = tonumber(args[1])
    local target = exports["fa-base"]:getModule("Player"):GetUser(player)
    local character = target:getCurrentCharacter()
    local playerName = character.first_name .. ' ' .. character.last_name

    local pdunit = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not pdunit:getVar("job") == "police" then
        local steamid, name = pdunit:getVar("name"), pdunit:getVar("steamid")

        exports["fa-log"]:AddLog("Exploiter", pdunit, "User Attempted to jail player while not on pd", {
            target = playerName,
            reason = reason,
            cid = cid,
            time = tonumber(args[2]),
            src = src
        })
        DropPlayer(src, "")

        return
    end

    TriggerClientEvent('chatMessage', src, "JAILED ", 3, "" .. playerName .. " has been put in jail for " ..
        tonumber(args[2]) .. " month(s) for " .. reason)

    TriggerClientEvent('beginJail', player, false, args[2], playerName, character.id, date)

    local date = os.date("%c")
    TriggerClientEvent("drawScaleformJail", -1, tonumber(args[2]), playerName, character.id, date)

    TriggerEvent("np:news:newConviction", {
        name = playerName,
        duration = time,
        charges = reason
    })

    TriggerEvent('server-jail-items', character.id, true)
    exports["fa-base"]:getModule("JobManager"):SetJob(target, "unemployed", true)

    -- crimeUser(player,reason,character.id)

end)

RegisterServerEvent("fa-police:deletecrimes")
AddEventHandler("fa-police:deletecrimes", function(target)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local identifier = user:getVar("hexid")

    local pdunit = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not pdunit:getVar("job" == "police") then
        local steamid, name = pdunit:getVar("name"), pdunit:getVar("steamid")

        exports["fa-log"]:AddLog("Exploiter", pdunit, "User Attempted delete crimes while not on duty", {
            target = target,
            src = src
        })
        DropPlayer(src, "")

        return
    end

    -- missing here
end)

RegisterServerEvent('fa-police:gsrGranted') -- that is np's code ((sway))
AddEventHandler('fa-police:gsrGranted', function(t)
    local copId = source
    TriggerClientEvent("DoLongHudText", t, 'You have been GSR tested', 1)
    TriggerClientEvent('fa-police:hasShotRecently', t, copId)
end)

RegisterServerEvent('fa-police:hasShotRecently') -- that is np's code ((sway))
AddEventHandler('fa-police:hasShotRecently', function(shotRecently, copId)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local msg = string.format("%s has returned %s for GSR testing", character.id,
        shotRecently and "positive" or "negative")

    TriggerClientEvent("chatMessage", copId, "", {255, 0, 0}, msg)
end)

RegisterServerEvent('fa-police:dnaAsk')
AddEventHandler('fa-police:dnaAsk', function(t)
	local src = source
	local user2 = exports["fa-base"]:getModule("Player"):GetUser(t)
	local character2 = user2:getCurrentCharacter()
    TriggerClientEvent("DoLongHudText", t, 'You have been DNA tested!',1)
	TriggerClientEvent('DoLongHudText', src, 'DNA swab comes back to a : ' .. character2.first_name .." ".. character2.last_name, 1)
	TriggerClientEvent('DoLongHudText', src, 'DNA: ' .. character2.id, 2)
end)

RegisterServerEvent('fa-police:remmaskGranted') -- that is np's code ((sway))
AddEventHandler('fa-police:remmaskGranted', function(targetplayer)
    TriggerClientEvent('fa-police:remmaskAccepted', targetplayer)
end)

RegisterServerEvent('unseatAccepted') -- that is np's code ((sway))
AddEventHandler('unseatAccepted', function(targetplayer, x, y, z)
    TriggerClientEvent('unseatPlayerFinish', targetplayer, x, y, z)
end)

RegisterServerEvent('fa-police:updateLicenses')
AddEventHandler('fa-police:updateLicenses', function(targetlicense, status, license)
    if status == 1 then
        -- add license
    else
        -- remove license
    end
end)

RegisterServerEvent("fa-police:targetCheckInventory")
AddEventHandler("fa-police:targetCheckInventory", function(target, status)
    local src = source
    local user2 = exports["fa-base"]:getModule("Player"):GetUser(target)
    local char2 = user2:getCurrentCharacter()
    TriggerClientEvent("server-inventory-open", src, "1", "ply-" .. char2.id)
    TriggerClientEvent('DoLongHudText', target, 'You are being searched!', 2)
end)

RegisterServerEvent('Gimmeurfuknmoney')
AddEventHandler('Gimmeurfuknmoney', function(target)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local targetply = exports["fa-base"]:getModule("Player"):GetUser(target)
    user:addMoney(targetply:getCash())
    targetply:removeMoney(targetply:getCash())
end)

RegisterServerEvent('fa-police:SeizeCash')
AddEventHandler('fa-police:SeizeCash', function(target)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    local userz = exports["fa-base"]:getModule("Player"):GetUser(target)
    if not user.job.name == 'police' then
        return
    end

    local cash = userz:getCash()
    userz:removeMoney(cash)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', target, 'Your cash and Marked Bills was seized', 1)
    TriggerClientEvent('DoLongHudText', src, 'Seized persons cash', 1)
    -- Logs will be added.
end)

RegisterCommand('bill', function(source, args)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(tonumber(args[1]))
    local character = user:getCurrentCharacter()
    local user2 = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character2 = user2:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ?', {character2.id}, function(result)
        if result[1].job == 'police' then
            user:removeBank(tonumber(args[2]))

            TriggerClientEvent('chatMessage', tonumber(args[1]), 'BILL', 4, 'You have $' .. tonumber(user:getBalance()) .. ' in the bank!')

            TriggerClientEvent('chatMessage', src, 'BILL', 4, 'You have billed them $' .. tonumber(args[2]))
            TriggerClientEvent('fa-police:BillLog', src, tonumber(args[2]), tonumber(args[1]))
            TriggerServerEvent('fa-financials:business_money', args[2], 'police', 'add')
        end
    end)
end)
 
RegisterCommand('callsign', function(source, args)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    print("HI")
    exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
        if result[1].job == 'police' or result[1].job == 'ems' then
            print("HELLO COCK")
            exports.ghmattimysql:execute("UPDATE jobs_whitelist SET `callsign` = @callsign WHERE cid = @cid", {
                ['callsign'] = args[1],
                ['cid'] = character.id
            })
            TriggerClientEvent('fa-police:setCallSign', src, args[1])
            currentCallSign = args[1]
        else
            TriggerClientEvent('DoLongHudText', src, 'You are not Police or EMS!', 2)
        end
    end)
end)



--- POLICE SEXTION -------------------------------

RegisterServerEvent('fa-police:cuffGranted2')
AddEventHandler('fa-police:cuffGranted2', function(t, softcuff)
    local src = source

    TriggerClientEvent('menu:setCuffState', t, true)
    TriggerEvent('fa-police:setCuffState2', t, true)
    if softcuff then
        TriggerClientEvent('handCuffedWalking', t)
    else
        TriggerClientEvent('fa-police:getArrested2', t, src)
        TriggerClientEvent('fa-police:cuffTransition', src)
    end
end)

RegisterServerEvent('fa-police:cuffGranted')
AddEventHandler('fa-police:cuffGranted', function(t)
    local src = source

    TriggerEvent('fa-police:setCuffState', t, true)
    TriggerClientEvent('menu:setCuffState', t, true)
    TriggerClientEvent('fa-police:getArrested', t, src)
    TriggerClientEvent('fa-police:cuffTransition', src)
end)

RegisterServerEvent('fa-police:escortAsk')
AddEventHandler('fa-police:escortAsk', function(target)
    TriggerClientEvent('dr:escort', target, source)
end)

RegisterServerEvent('falseCuffs')
AddEventHandler('falseCuffs', function(t)
    TriggerClientEvent('falseCuffs', t)
    TriggerClientEvent('menu:setCuffState', t, false)
end)

RegisterServerEvent('fa-police:setCuffState')
AddEventHandler('fa-police:setCuffState', function(t, state)
    TriggerClientEvent('fa-police:currentHandCuffedState', t, true)
    TriggerClientEvent('menu:setCuffState', t, true)
end)

RegisterServerEvent('fa-police:forceEnterAsk')
AddEventHandler('fa-police:forceEnterAsk', function(target, netid)
    TriggerClientEvent('fa-police:forcedEnteringVeh', target, netid)
    TriggerClientEvent('notification', source, 'Seating Player', 1)
end)

--- POLICE SEXTION ^^^^^^^^^^^^

function checkDBForDna(ident, dna)
    local canUse = true
    exports.ghmattimysql:execute("SELECT meta FROM characters WHERE id = @identifier", {
        ['identifier'] = ident
    }, function(result)
        if (result[1]) then
            meta = json.decode(result[1].dna)
            if meta.dna ~= dna then
                canUse = true
            end
        end
    end)
    Wait(200)
    if canUse then
        return true
    else
        return false
    end
end

RegisterServerEvent('ped:forceTrunkAsk')
AddEventHandler('ped:forceTrunkAsk', function(targettrunk)
    TriggerClientEvent('ped:forcedEnteringVeh', targettrunk)
end)

RegisterServerEvent('Evidence:GetWounds')
AddEventHandler('Evidence:GetWounds', function(t)
    TriggerClientEvent('Evidence:GiveWounds', t, source)
end)

RegisterServerEvent('Evidence:GiveWoundsFinish')
AddEventHandler('Evidence:GiveWoundsFinish', function(CurrentDamageList, id, bones)
    local src = source
    TriggerClientEvent('Evidence:CurrentDamageListTarget', id, CurrentDamageList, bones, src)
end)

RegisterServerEvent('evidence:bleeder')
AddEventHandler('evidence:bleeder', function(isBleeding)
    local src = source
    TriggerClientEvent('bleeder:alter', src, isBleeding)
end)

RegisterServerEvent('bones:server:updateServer')
AddEventHandler('bones:server:updateServer', function(bones)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getVar("character").id
    local pastebones = json.encode(bones)
    local bones = json.encode(bones)

    exports.ghmattimysql:execute("UPDATE characters SET `bones` = @bones WHERE id = @identifier", {
        ['bones'] = bones,
        ['identifier'] = characterId
    })
end)

RegisterServerEvent("Evidence:checkDna")
AddEventHandler("Evidence:checkDna", function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local needsNewDna = false

    exports.ghmattimysql:execute("SELECT dna FROM characters WHERE id = @identifier", {
        ['identifier'] = char.id
    }, function(result)
        if (result[1]) then
            if (result[1].dna) then
                meta = json.decode(result[1].dna)
                if meta ~= nil then
                    if meta.dna == "" then
                        needsNewDna = true
                    end
                else
                    needsNewDna = true
                end
            else
                needsNewDna = true
            end
        else
            needsNewDna = true
        end
    end)
    Wait(300)
    if needsNewDna then
        local dna = ""
        local check = false
        while check == false do
            dna = math.random(1000, 9999) .. "-" .. math.random(10000, 99999) .. "-" .. math.random(0, 999)
            Wait(1200)
            check = checkDBForDna(characterId, dna)
        end
        local metaData = {
            ["dna"] = dna,
            ["health"] = 200,
            ["armour"] = 0,
            ["animSet"] = "none"
        }
        meta = json.encode(metaData)
        exports.ghmattimysql:execute("UPDATE characters SET `dna` = @metaData WHERE id = @identifier", {
            ['metaData'] = meta,
            ['identifier'] = characterId
        })
    end
end)

RegisterServerEvent("fa-police:setServerMeta")
AddEventHandler("fa-police:setServerMeta", function(health, armour, thirst, hunger)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    if user ~= false then
        local characterId = user:getCurrentCharacter().id
        meta = {
            ["health"] = health,
            ["armour"] = armour,
            ["thirst"] = thirst,
            ["hunger"] = hunger
        }

        local encode = json.encode(meta)
        exports.ghmattimysql:execute('UPDATE characters SET metaData = ? WHERE id = ?', {encode, characterId})
    end
end)

--[[RegisterServerEvent('fa-police:SetMeta')
AddEventHandler('fa-police:SetMeta', function()
    local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(result)
        TriggerClientEvent("fa-police:setClientMeta", src, json.decode(result[1].metaData))
		TriggerClientEvent('client:updateStress', src, result[1].stress_level)
		TriggerClientEvent("client:newStress", src,true,result[1].stress_level)
	end)

end)

RegisterServerEvent('server:alterStress')
AddEventHandler('server:alterStress',function(positive, alteredValue)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {characterId}, function(result)
		local myStress = result[1].stress_level
		Citizen.Wait(500)
		if positive then
			if myStress < tonumber(10000) then
				newStress = myStress + alteredValue
				if newStress > 10000 then
					newStress = 10000
				end
				exports.ghmattimysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{newStress, characterId})
				TriggerClientEvent('client:updateStress', src, newStress)
			end
		else
			if myStress > tonumber(0) then
				Stress = myStress - alteredValue
				if Stress < 0 then 
					Stress = 0
				end	
				exports.ghmattimysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{Stress, characterId})
				TriggerClientEvent('client:updateStress', src, Stress)
			end
		end
	end)
end)]]

RegisterServerEvent('government:bill')
AddEventHandler('government:bill', function(data)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(data)
end)

RegisterServerEvent('sniffAccepted')
AddEventHandler('sniffAccepted', function(data)
    TriggerClientEvent('K9:SniffConfirmed', source)
end)

RegisterServerEvent('reviveGranted')
AddEventHandler('reviveGranted', function(t)
    TriggerClientEvent('reviveFunction', t)
end)

RegisterServerEvent('ems:stomachpumptarget')
AddEventHandler('ems:stomachpumptarget', function(t)
    TriggerClientEvent('fx:stomachpump', t)
end)

RegisterServerEvent('fa-police:emsVehCheck')
AddEventHandler('fa-police:emsVehCheck', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)

    if user:getVar("job") == "ems" or "doctor" then
        TriggerClientEvent('emsGarage:Menu', src, true)
    else
        TriggerClientEvent('DoLongHudText', src, "Fuck off dick head those vehicles belong's to EMS", 2)
    end
end)

RegisterServerEvent('ems:healplayer')
AddEventHandler('ems:healplayer', function(t)
    TriggerClientEvent('ems:healpassed', t)
end)

RegisterServerEvent('huntAccepted')
AddEventHandler('huntAccepted', function(player, distance, coords)
    TriggerClientEvent('K9:HuntAccepted', source)
end)

--[[---------------------------------------------------
						Emotes
--]] ---------------------------------------------------

RegisterServerEvent('fa-police:setEmoteData')
AddEventHandler('fa-police:setEmoteData', function(emoteTable)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local emote = json.encode(emoteTable)
    exports.ghmattimysql:execute("UPDATE characters SET `emotes` = @emotes WHERE id = @cid", {
        ['emotes'] = emote,
        ['cid'] = char.id
    })
end)

RegisterServerEvent('fa-police:setAnimData')
AddEventHandler('fa-police:setAnimData', function(AnimSet)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local metaData = json.encode(AnimSet)
    exports.ghmattimysql:execute("UPDATE characters SET `meta` = @metaData WHERE id = @cid", {
        ['metaData'] = metaData,
        ['cid'] = char.id
    })
end)

RegisterServerEvent('fa-police:getAnimData')
AddEventHandler('fa-police:getAnimData', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.ghmattimysql:execute("SELECT meta FROM characters WHERE id = @cid", {
        ['cid'] = char.id
    }, function(result)
        if (result[1]) then
            if not result[1].meta then
                TriggerClientEvent('checkDNA', src)
            else
                local sex = json.decode(result[1].meta)
                if sex == nil then
                    TriggerClientEvent('CheckDNA', src)
                    return
                end
                TriggerClientEvent('emote:setAnimsFromDB', src, result[1].meta)
            end
        end
    end)
end)

RegisterServerEvent('fa-police:getEmoteData')
AddEventHandler('fa-police:getEmoteData', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.ghmattimysql:execute("SELECT emotes FROM characters WHERE id = @cid", {
        ['cid'] = char.id
    }, function(result)
        if (result[1]) then
            local emotes = json.decode(result[1].emotes)
            if result[1] ~= nil then
                TriggerClientEvent('emote:setEmotesFromDB', src, emotes)
            else
                local emoteTable = {{
                    ['key'] = {289},
                    ["anim"] = "Handsup"
                }, {
                    ['key'] = {170},
                    ["anim"] = "HandsHead"
                }, {
                    ['key'] = {166},
                    ["anim"] = "Drink"
                }, {
                    ['key'] = {167},
                    ["anim"] = "Lean"
                }, {
                    ['key'] = {168},
                    ["anim"] = "Smoke"
                }, {
                    ['key'] = {56},
                    ["anim"] = "FacePalm"
                }, {
                    ['key'] = {57},
                    ["anim"] = "Wave"
                }, {
                    ['key'] = {289, 21},
                    ["anim"] = "gangsign1"
                }, {
                    ['key'] = {170, 21},
                    ["anim"] = "gangsign3"
                }, {
                    ['key'] = {166, 21},
                    ["anim"] = "gangsign2"
                }, {
                    ['key'] = {167, 21},
                    ["anim"] = "hug"
                }, {
                    ['key'] = {168, 21},
                    ["anim"] = "Cop"
                }, {
                    ['key'] = {56, 21},
                    ["anim"] = "Medic"
                }, {
                    ['key'] = {57, 21},
                    ["anim"] = "Notepad"
                }}

                local emote = json.encode(emoteTable)
                exports.ghmattimysql:execute("UPDATE characters SET `emotes` = @emotes WHERE id = @cid", {
                    ['emotes'] = emote,
                    ['identifier'] = char.id
                })
                TriggerClientEvent("emote:setEmotesFromDB", src, emoteTable)
            end
        end
    end)
end)
--[[
 RegisterCommand('testing123', function(source)
 	local src = source
 	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
 	user:setRank("dev")
 	print("done knk")
 end)
--]]

RegisterServerEvent('fa-police:whitelist')
AddEventHandler('fa-police:whitelist', function(arg, jobType)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    if jobType == "police" or jobType == "ems" or jobType == "doctor" or jobType == "therapist" or jobType == "doc" then
        exports.ghmattimysql:execute("SELECT rank from jobs_whitelist WHERE job = @job AND cid = @cid", {
            ['job'] = jobType,
            ["cid"] = arg
        }, function(result)
            if (result[1]) then
                TriggerClientEvent("DoLongHudText", src, 'This person is already on the list.', 2)
            else
                exports["fa-log"]:AddLog("HC Added Job", "Character: " .. char.id .. " Changed Char: " .. arg ..
                    " Job whitelisting: " .. jobType .. " Type: Added", {
                    source = src,
                    char = char.id
                })

                exports.ghmattimysql:execute(
                    "INSERT INTO jobs_whitelist (owner,cid,job,rank) VALUES (@owner,@cid,@job,@rank)", {
                        ['owner'] = arg,
                        ['cid'] = arg,
                        ['job'] = jobType,
                        ['rank'] = 1
                    })

                TriggerClientEvent("DoLongHudText", src,
                    "Person Added , CID = " .. arg .. " Job = " .. jobType .. " Rank 1", 1)
            end
        end)
    elseif jobType == "judge" then
        exports.ghmattimysql:execute("SELECT judge_type FROM characters WHERE id = @cid", {
            ["cid"] = char.id
        }, function(result)
            if result[1] then
                if result[1].judge_type == 10 then
                    exports["fa-log"]:AddLog("HC Added Job", "Character: " .. char.id .. " Changed Char: " .. arg ..
                        " Job whitelisting " .. jobType .. " Type: Added", {
                        source = src,
                        char = char.id
                    })
                    exports.ghmattimysql:execute("UPDATE characters SET `judge_type`=@rank WHERE id = @cid", {
                        ['rank'] = 1,
                        ["cid"] = arg
                    })
                    TriggerClientEvent("DoLongHudText", src,
                        'Person added , CID = ' .. arg .. " Job = " .. jobType .. " Rank 1", 1)
                else
                    TriggerClientEvent("DoLongHudText", src, 'Not high enough rank.', 2)
                end
            else
                TriggerClientEvent("DoLongHudText", src, 'Invalid Character ID.', 2)
            end
        end)
    else
        TriggerClientEvent("DoLongHudText", src, 'invalid Job.', 2)
    end
end)

RegisterServerEvent('fa-police:remove')
AddEventHandler('fa-police:remove', function(arg, jobType)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    if jobType == "police" or jobType == "ems" or jobType == "doctor" or jobType == "therapist" or jobType == "doc" then
        exports.ghmattimysql:execute("SELECT rank from jobs_whitelist WHERE job = @job AND cid = @cid", {
            ['job'] = jobType,
            ["cid"] = arg
        }, function(result)
            if (result[1]) then
                TriggerClientEvent("DoLongHudText", src, 'This person is already on the list.', 2)
            else
                exports["fa-log"]:AddLog("HC Removed Job", "Character: " .. char.id .. " Changed Char: " .. arg ..
                    " Job whitelisting: " .. jobType .. " Type: Removed", {
                    source = src,
                    char = char.id
                })

                exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE owner = @owner, cid = @cid, job = @job",
                    {
                        ['owner'] = arg,
                        ['cid'] = arg,
                        ['job'] = jobType
                    })

                TriggerClientEvent("DoLongHudText", src, "Person Removed , CID = " .. arg .. " Job = " .. jobType, 1)
            end
        end)
    elseif jobType == "judge" then
        exports.ghmattimysql:execute("SELECT judge_type FROM characters WHERE id = @cid", {
            ["cid"] = char.id
        }, function(result)
            if result[1] then
                if result[1].judge_type == 10 then
                    exports["fa-log"]:AddLog("HC Removed Job", "Character: " .. char.id .. " Changed Char: " .. arg ..
                        " Job whitelisting " .. jobType .. " Type: Removed", {
                        source = src,
                        char = char.id
                    })
                    exports.ghmattimysql:execute("UPDATE characters SET `judge_type`=@rank WHERE id = @cid", {
                        ['rank'] = 0,
                        ["cid"] = arg
                    })
                    TriggerClientEvent("DoLongHudText", src, 'Person removed , CID = ' .. arg .. " Job = " .. jobType, 1)
                else
                    TriggerClientEvent("DoLongHudText", src, 'Not high enough rank.', 2)
                end
            else
                TriggerClientEvent("DoLongHudText", src, 'Invalid Character ID.', 2)
            end
        end)
    else
        TriggerClientEvent("DoLongHudText", src, 'invalid Job.', 2)
    end
end)

-- RegisterServerEvent("isVip")
-- AddEventHandler("isVip", function(src)
-- 	local commands = exports["fa-base"]:getModule("Commands")
-- 	if src == nil or src == 0 then src = source end

-- 	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
-- 	local steamcheck = user:getVar("steamid")

-- 	exports.ghmattimysql:execute("SELECT * FROM vip_list WHERE steamid = @steamcheck",{['steamcheck'] = steamcheck}, function(result)
-- 		if result[1] then
-- 			commands:RemoveCommand("/priority", src)

-- 			commands:AddCommand("/priority", "/priority [check] #pid | [alter] #pid #rank", src, function(src, args)
-- 				local user = exports["fa-base"]:getModule("Player"):GetUser(src)

-- 				local char = user:getCurrentCharacter()
-- 					local name = char.first_name .. " " .. char.last_name

-- 				if not args[2] then return end
-- 				if not tonumber(args[1]) then return end
-- 				if args[2] == "alter" and not tonumber(args[4]) then return end

-- 				local target = tonumber(args[1])
-- 				local user = exports["fa-base"]:getModule("Player"):GetUser(target)
-- 				local steamcheck = user:getVar("steamid")

-- 				if args[1] == "check" then
-- 					exports.ghmattimysql:execute("SELECT * FROM users_whitelist WHERE steamid = @steamcheck",{['steamcheck'] = steamcheck}, function(result)

-- 						TriggerClientEvent("DoLongHudText",src,"Targets rank was " .. result[1].power)
-- 					end)

-- 				elseif args[2] == "alter" then

-- 					local rank = tonumber(args[4])

-- 					if rank == nil then

-- 						if rank < 1 then
-- 							rank = 0
-- 						end
-- 						exports.ghmattimysql:execute("UPDATE users_whitelist SET 'power'=@rank,'admin_name'=@name WHERE steamid = @steamcheck",{['name'] = name, ['rank'] = rank, ['steamcheck'] = steamcheck})
-- 						if rank == 0 then
-- 							TriggerClientEvent("DoLongHudText",src,steamcheck .. " was unwhitelisted.")
-- 						else
-- 							TriggerClientEvent("DoLongHudText",src,steamcheck .. " set to rank of " .. rank)
-- 						end

-- 					else
-- 						TriggerClientEvent("DoLongHudText",src,"Error - no rank",2)
-- 					end

-- 				end

-- 			end)

-- 		else

-- 			commands:RemoveCommand("/priority", src)

-- 			commands:AddCommand("/priority", "/priority [check] #pid", src, function(src, args)
-- 				local user = exports["fa-base"]:getModule("Player"):GetUser(src)

-- 				local char = user:getCurrentCharacter()
-- 					local name = char.first_name .. " " .. char.last_name

-- 				if not args[2] then return end
-- 				if not tonumber(args[3]) then return end

-- 				local target = tonumber(args[1])
-- 				local user = exports["fa-base"]:getModule("Player"):GetUser(target)
-- 				local steamcheck = user:getVar("steamid")

-- 				if args[2] == "check" then
-- 					exports.ghmattimysql:execute("SELECT * FROM users_whitelist WHERE steamid = @steamcheck",{['steamcheck'] = steamcheck}, function(result)

-- 						TriggerClientEvent("DoLongHudText",src,"Targets rank was " .. result[1].power)
-- 					end)

-- 				end

-- 			end)

-- 		end

-- 	end)

-- end)

function jailUser(player, reason, cid, time, src)
    local jailer = exports["fa-base"]:getModule("Player"):GetUser(src)
    if not jailer then
        return false
    end

    if not jailer:getVar("job") == "police" and not jailer:getVar("job") == "doc" then
        local steamid, name = jailer:getVar("name"), jailer:getVar("steamid")

        exports["fa-log"]:AddLog("Exploiter", jailer,
            "User attempted to jail while not on pd; Reason: " .. tostring(reason), {
                target = player,
                reason = reason,
                cid = cid,
                time = time
            })
        DropPlayer(src, "")
        return
    end

    local player = tonumber(player)
    local playerName = GetPlayerName(player)
    local target = exports["fa-base"]:getModule("Player"):GetUser(player)
    local character = target:getCurrentCharacter()

    -- TriggerClientEvent('chatMessage', src, "JAILED", 3, "" .. playerName .. " has been put in jail for " .. tonumber(time) .. " month(s). for " ..reason)

    TriggerClientEvent('beginJail', player, false, time)
    TriggerEvent("fa-fa-police:playerJailed", character)

    local date = os.date("%c")
    TriggerClientEvent("drawScaleformJail", -1, time, playerName, character.id, date)

    TriggerEvent("np:news:newConviction", {
        name = playerName,
        duration = time,
        charges = reason
    })
  
    TriggerEvent("server-jail-items", character.id, true)
    exports["fa-base"]:getModule("JobManager"):SetJob(target, "unemployed", true)

    crimeUser(player, reason, character.id)

end

RegisterServerEvent("911")
AddEventHandler("911", function(args, pStreetName)
    local src = source

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local job = user:getVar("job")
    local message = ""
    local pName = GetPlayerName(source)
    local identifiers = GetPlayerIdentifiers(source)

    local phonenumber = char.phone_number

    for k, v in ipairs(args) do
        message = message .. " " .. v
    end
    local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)

    TriggerClientEvent("GPSTrack:Create", src)
    TriggerClientEvent("animation:phonecall", src)
    TriggerClientEvent("chatMessage", src,
        "911 | " .. char.first_name .. " | " .. char.last_name .. " # " .. phonenumber, 1, tostring(message))

    local connect = {
        {
            ["color"] = color,
            ["title"] = "** faye [Police] | 911 Call **",
            ["description"] = "Steam Name:"..pName.. " \n Steam ID: "..identifiers[1].. " \n 911 | " .. char.first_name .. " " .. char.last_name .. " \n Message: " .. tostring(message),
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1012082593790951525/jOaujaZf4fXM5XVf8hiVBfylIGS65mGODaGY3G7xvmOMo6KHkyhWjd6xvNDyeCMfQ4OR", function(err, text, headers) end, 'POST', json.encode({username = "faye | 911 Call", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })

    TriggerEvent('dispatch:svNotify', {
        dispatchCode = "911 | " .. char.first_name .. " | " .. char.last_name .. " # " .. phonenumber,
        firstStreet = pStreetName,
        gender = user:getGender(),
        isImportant = false,
        priority = 1,
        dispatchMessage = tostring(message),
        recipientList = {
            police = "police",
            ems = "ems"
        },
        origin = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    })

    local users = exports["fa-base"]:getModule("Player"):GetUsers()

    local emergencyPlayers = {}

    for k, v in pairs(users) do
        local user = exports["fa-base"]:getModule("Player"):GetUser(v)
        local job = user:getVar("job")

        if job == "ems" or job == "police" then
            emergencyPlayers[#emergencyPlayers + 1] = v
        end
    end

    for k, v in ipairs(emergencyPlayers) do
        TriggerClientEvent("callsound", v)
        TriggerClientEvent("chatMessage", v, "911 | (" .. tonumber(src) .. ") " .. char.first_name .. " | " ..
            char.last_name .. " # " .. phonenumber, 1, tostring(message))
    end
end)

RegisterServerEvent("911a")
AddEventHandler("911a", function(args)
    local src = source

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local job = user:getVar("job")
    local message = ""

    local phonenumber = char.phone_number

    for k, v in ipairs(args) do
        message = message .. " " .. v
    end
    local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)

    TriggerClientEvent("GPSTrack:Create", src)
    TriggerClientEvent("animation:phonecall", src)
    TriggerClientEvent("chatMessage", src, "911 | Anonymous", 1, tostring(message))
    TriggerEvent('dispatch:svNotify', {
        dispatchCode = "911 | Anonymous ",
        firstStreet = "Unavailable",
        gender = user:getGender(),
        isImportant = false,
        priority = 1,
        dispatchMessage = tostring(message),
        recipientList = {
            police = "police",
            ems = "ems"
        },
        origin = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    })

    local users = exports["fa-base"]:getModule("Player"):GetUsers()

    local emergencyPlayers = {}

    for k, v in pairs(users) do
        local user = exports["fa-base"]:getModule("Player"):GetUser(v)
        local job = user:getVar("job")

        if job == "ems" or job == "police" then
            emergencyPlayers[#emergencyPlayers + 1] = v
        end
    end

    for k, v in ipairs(emergencyPlayers) do
        TriggerClientEvent("callsound", v)
        TriggerClientEvent("chatMessage", v, "911 | (" .. tonumber(src) .. ") Anonymous", 1, tostring(message))
    end
end)

RegisterServerEvent("311")
AddEventHandler("311", function(args)
    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local job = user:getVar("job")
    local message = ""
    local pName = GetPlayerName(source)
    local identifiers = GetPlayerIdentifiers(source)

    local phonenumber = char.phone_number

    for k, v in ipairs(args) do
        message = message .. " " .. v
    end
    local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)

    -- TriggerClientEvent("GPSTrack:Create", src)
    TriggerClientEvent("animation:phonecall", src)
    TriggerClientEvent("chatMessage", src,
        "311 | " .. char.first_name .. " | " .. char.last_name .. " # " .. phonenumber, 4, tostring(message))

        local connect = {
            {
                ["color"] = color,
                ["title"] = "** faye [Police] | 311 Call **",
                ["description"] = "Steam Name:"..pName.. " \n Steam ID: "..identifiers[1].. " \n 911 | " .. char.first_name .. " " .. char.last_name .. " \n Message: " .. tostring(message),
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1012082637910847600/cKpN2i_Sn8PNYulkz54mPViM_SawPRIVmzrUUfKXXdSY6OeGUvR9n970_1_y2ixT36Tt", function(err, text, headers) end, 'POST', json.encode({username = "faye | 311 Call", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })

    local users = exports["fa-base"]:getModule("Player"):GetUsers()

    local emergencyPlayers = {}

    for k, v in pairs(users) do
        local user = exports["fa-base"]:getModule("Player"):GetUser(v)
        local job = user:getVar("job")

        if job == "ems" or job == "police" then
            emergencyPlayers[#emergencyPlayers + 1] = v
        end
    end

    for k, v in ipairs(emergencyPlayers) do
        TriggerClientEvent("callsound", v)
        TriggerClientEvent("chatMessage", v, "311 | (" .. tonumber(src) .. ") " .. char.first_name .. " | " ..
            char.last_name .. " # " .. phonenumber, 4, tostring(message))
    end
end)

RegisterNetEvent("fa-police:targetCheckWeapons")
AddEventHandler("fa-police:targetCheckWeapons", function(playerId,items)
    local src = source
    local char = exports["fa-base"]:getModule("Player"):GetUser(playerId)
    local pSteam = char:getCurrentCharacter().owner
    local pCid = char:getCurrentCharacter().id
    local pName = "ply-"..pCid
    exports.ghmattimysql:execute('SELECT * FROM user_inventory2 WHERE `name` = @name', { ['@name'] = pName }, function(result)
        if result[1] ~= nil then
            for k,v in pairs(result) do
                local itemname = result[k].item_id
                if items[itemname].weapon then
                    TriggerClientEvent("chatMessage", src, "", {}, "^1 Something feeling sharp")
                    return
                end
            end
        end
    end)
end)

-- RegisterServerEvent("911a")
-- AddEventHandler("911a", function(args)
-- 	local src = source
-- 	table.remove(args, 1)

-- 	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
-- 	local char = user:getCurrentCharacter()
-- 	local job = user:getVar("job")
-- 	local message = ""

-- 	local phonenumber = char.phone_number

-- 	for k,v in ipairs(args) do
-- 		message = message .. " " .. v
-- 	end
-- 	local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)
-- 	exports["fa-log"]:AddLog("911 Chat", user, caller .. ": " .. message, {})

-- 	TriggerClientEvent("GPSTrack:Create", src)
-- 	TriggerClientEvent("animation:phonecall", src)
-- 	TriggerClientEvent("chatMessage", src, "911r | " .. char.first_name .. " " .. char.last_name .. " # " .. phonenumber, 3, tostring(message))

-- 	local users = exports["fa-base"]:getModule("Player"):GetUsers()

-- 	local emergencyPlayers = {}

-- 	for k,v in pairs(users) do
-- 		local user = exports["fa-base"]:getModule("Player"):GetUser(v)
-- 		local job = user:getVar("job")

-- 		if job == "ems" or job == "police" then
-- 			emergencyPlayers[#emergencyPlayers+1]= v
-- 		end
-- 	end

-- 	for k,v in ipairs(emergencyPlayers) do
-- 		TriggerClientEvent("callsound", v)
-- 		TriggerClientEvent("chatMessage", v, "911r | (" .. tonumber(src) .. ") " .. char.first_name .. " | " .. char.last_name .. " # " .. phonenumber, 3, tostring(message))
-- 	end
-- end)

RegisterServerEvent("fire:serverStopFire")
AddEventHandler("fire:serverStopFire", function(x, y, z, radius)
    TriggerClientEvent("fire:stopClientFires", -1, x, y, z, radius)
end)

RegisterServerEvent("911r")
AddEventHandler("911r", function(args)
    local src = source
    -- table.remove(args, 1)

    if not args[1] or not tonumber(args[1]) then
        return
    end
    local target = args[1]

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    local job = user:getVar("job")

    local canRun = (job == "police" or job == "ems") and true or false
    if not canRun then
        return
    end

    local message = ""

    local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)

    for k, v in ipairs(args) do
        if k > 1 then
            message = message .. " " .. v
        end
    end
    TriggerClientEvent("animation:phonecall", src)

    local users = exports["fa-base"]:getModule("Player"):GetUsers()

    local emergencyPlayers = {}

    for k, v in pairs(users) do
        local user = exports["fa-base"]:getModule("Player"):GetUser(v)
        local job = user:getVar("job")

        if job == "ems" or job == "police" then
            emergencyPlayers[#emergencyPlayers + 1] = v
        end
    end

    for k, v in ipairs(emergencyPlayers) do
        TriggerClientEvent("chatMessage", v, "911r -> " .. target .. " | " .. char.first_name .. ' ' .. char.last_name,
            1, tostring(message))
    end

    TriggerClientEvent("chatMessage", target, "911r | (" .. tonumber(src) .. ")", 1, tostring(message))
end)

RegisterServerEvent("311r")
AddEventHandler("311r", function(args)
    local src = source
    -- table.remove(args, 1)

    if not args[1] or not tonumber(args[1]) then
        return
    end
    local target = args[1]

    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    local job = user:getVar("job")

    local canRun = (job == "police" or job == "ems") and true or false
    if not canRun then
        return
    end

    local message = ""

    local caller = tostring(char.first_name) .. " " .. tostring(char.last_name)

    for k, v in ipairs(args) do
        if k > 1 then
            message = message .. " " .. v
        end
    end
    TriggerClientEvent("animation:phonecall", src)

    local users = exports["fa-base"]:getModule("Player"):GetUsers()

    local emergencyPlayers = {}

    for k, v in pairs(users) do
        local user = exports["fa-base"]:getModule("Player"):GetUser(v)
        local job = user:getVar("job")

        if job == "ems" or job == "police" then
            emergencyPlayers[#emergencyPlayers + 1] = v
        end
    end

    for k, v in ipairs(emergencyPlayers) do
        TriggerClientEvent("chatMessage", v, "311r -> " .. target .. " | " .. char.first_name .. ' ' .. char.last_name,
            4, tostring(message))
    end

    TriggerClientEvent("chatMessage", target, "311r | (" .. tonumber(src) .. ")", 4, tostring(message))
end)
-- user:getVar("steamid")

local police_state = ""

RegisterCommand('pstate', function(source, args)
    local src = source
    local users = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = users:getCurrentCharacter()
    local job = users:getVar("job")

    if job == "police" then
        if args[1] == "lspd" then
            police_state = "lspd"
        elseif args[1] == "sheriff" then
            police_state = "sheriff"
        elseif args[1] == "ranger" then
            police_state = "ranger"
        elseif args[1] == "state" then
            police_state = "state"
        end
    end
end)

-- Hire -- 

RegisterServerEvent('fa-fa-police:hire_pd')
AddEventHandler('fa-fa-police:hire_pd', function(pCID, pRank, pCallsign, pDept)
    exports.oxmysql:execute("INSERT INTO jobs_whitelist (cid,job,rank,callsign,dept) VALUES (@cid,@job,@rank,@callsign,@dept)", {
        ['cid'] = pCID,
        ['job'] = 'police',
        ['rank'] = pRank,
        ['callsign'] = pCallsign,
        ['dept'] = pDept
    })
end)

RegisterServerEvent('fa-fa-police:sv:open_hire_menu')
AddEventHandler('fa-fa-police:sv:open_hire_menu', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()

    exports.oxmysql:execute('SELECT rank FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
        print('Rank: ' .. result[1].rank)
        if result[1].rank >= 7 then
			TriggerClientEvent('fa-police:hireNewPerson', src)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not a high enough rank to use this!", 2)
		end
	end)
end)

-- // Swat Armory // --

RegisterServerEvent('fa-police:openSwatArmory')
AddEventHandler('fa-police:openSwatArmory', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()

    exports.oxmysql:execute('SELECT rank FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
        print('Rank: ' .. result[1].rank)
        if result[1].rank >= 7 then
			TriggerClientEvent('server-inventory-open', src, '22', 'Shop')
		else
			TriggerClientEvent("DoLongHudText", src,"You are not a high enough rank to use this!", 2)
		end
	end) 
end) 

local JSON = json.decode(LoadResourceFile("fa-hud", "/config/pursuitModes.json"))

RPC.register("pursuit:getJSON",function()
    return JSON
end)