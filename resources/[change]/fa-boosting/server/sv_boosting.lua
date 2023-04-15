--BLIPS SYSTEM INFINITY

local BoostingPlate = {}


RegisterNetEvent('boosting:SetPlateInList')
AddEventHandler('boosting:SetPlateInList',function(plate, boolean)
    if plate ~= nil then
        if boolean then
            print('[BOOSTING] '..plate..' is in the list')
            BoostingPlate[plate] = boolean
        else
            if BoostingPlate[plate] ~= nil then
                print('[BOOSTING] '..plate..' is not more in the list')
                BoostingPlate[plate] = nil
            else
                print('[BOOSTING] '..plate..' is not in the list so we do nothing')
            end
        end
    end
end)


RegisterServerCallback {eventName = 'boosting:GetPlateState', eventCallback = function(source, data)
    local plate = data.plate
    if BoostingPlate[plate] ~= nil then
        return true
    else
        return false
    end
end}


BoostingBlipsSystem = {
    ActivePlayers = {},
}

function BoostingBlipsSystem:BoostingThread() 
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(5000)
            local ped = nil
            for k, v in pairs(self.ActivePlayers) do
                ped = GetPlayerPed(k)
                local veh = GetVehiclePedIsIn(ped)
                self.ActivePlayers[k].coords = GetEntityCoords(veh)
            end
            TriggerClientEvent("boosting:updateBlips", -1, self.ActivePlayers)
        end
    end)
end

function BoostingBlipsSystem:AddSrc(src)
    self.ActivePlayers[src] = {}
end

function BoostingBlipsSystem:RemoveSrc(src)
    self.ActivePlayers[src] = nil
    TriggerClientEvent("boosting:RemoveBlip", -1, src)
end


BoostingBlipsSystem:BoostingThread()

RegisterNetEvent("Boosting:AddBlipsSystem")
AddEventHandler("Boosting:AddBlipsSystem" , function()
    BoostingBlipsSystem:AddSrc(source)
end)

RegisterNetEvent("Boosting:RemoveBlipsSystem")
AddEventHandler("Boosting:RemoveBlipsSystem" , function()
    BoostingBlipsSystem:RemoveSrc(source)
end)

RegisterNetEvent("boosting:coop")
AddEventHandler("boosting:coop" , function(src)
    local player = source
    if src ~= nil then
        TriggerClientEvent('boosting:helpHack', src)
        TriggerEvent("boosting:addBoostingLevelHelp", player)
    end
end)

AddEventHandler("playerDropped",function(reason)
    BoostingBlipsSystem:RemoveSrc(source)
end)

--BLIPS SYSTEM INFINITY
local isInContract = false

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------FUNCTIONS------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not Config.OldVersion then
    DatabaseQuery = function(query, parameters)
        if Config.Database == 'ghmattimysql' then
            local result = exports.ghmattimysql:executeSync(query, parameters)
            return result
        elseif Config.Database == 'oxmysql' then
            if string.find(query, "SELECT") then
                local result = MySQL.query.await(query, parameters)
                return result
            elseif string.find(query, "INSERT") then
                MySQL.insert(query, parameters)
            else
                MySQL.update(query, parameters)
            end
        end
    end
end

function AddContractToDB(data)
    DatabaseQuery('INSERT INTO `boosting` (`identifier`, `vehicle`, `type`, `owner`, `expires`, `units`, `ExtraVin`, `coords`) VALUES (@identifier, @vehicle, @type, @owner, @expires, @units, @ExtraVin, @coords)', {
        ['@identifier'] = data.identifier,
        ['@vehicle'] = data.vehicle,
        ['@type'] = data.type,
        ['@owner'] = data.owner,
        ['@expires'] = data.expires,
        ['@ExtraVin'] = data.ExtraVin,
        ['@units'] = data.units,
        ['@coords'] = json.encode({x = data.coords[1], y = data.coords[2], z = data.coords[3]}),
    })
end

function RemoveContractToDB(data)
    DatabaseQuery('DELETE FROM `boosting` WHERE `identifier` = @identifier AND `vehicle` = @vehicle AND `id` = @id' , {
        ['@identifier'] = data.props.identifier,
        ['@vehicle'] = data.props.vehicle,
        ['@id'] = data.props.id
    })
end

function GetContractToDB(identifier)
    local query = DatabaseQuery('SELECT * FROM `boosting` WHERE `identifier` = @identifier', {
        ['@identifier'] = identifier
    })
    return query
end

function GetContractByIDToDB(id)
    local query = DatabaseQuery('SELECT * FROM `boosting` WHERE `id` = @id', {
        ['@id'] = id
    })
    return query[1]
end

function RemoveContractByIDToDB(id)
    DatabaseQuery('DELETE FROM `boosting` WHERE `id` = @id', {
        ['@id'] = id
    })
end



function InitBoostingUser(src)
    local user = GetIdentifier(src)
    local query = DatabaseQuery('SELECT * FROM `boosting_users` WHERE `identifier` = @identifier', {
        ['@identifier'] = user
    })
    if query[1] ~= nil then
        if query[1].identifier == user then
            TriggerClientEvent("boosting:setlevel", src, query[1].level, bne)
        else
            DatabaseQuery('INSERT INTO `boosting_users` (`identifier`, `level`, `gne`) VALUES (@identifier, @level, @gne)', {
                ['@identifier'] = user,
                ['@level'] = 0,
                ['@gne'] = 0,
                ['@cooldown'] = 0,
            })
            TriggerClientEvent("boosting:setlevel", src, 0)
        end
    else
        DatabaseQuery('INSERT INTO `boosting_users` (`identifier`, `level`, `gne`) VALUES (@identifier, @level, @gne)', {
            ['@identifier'] = user,
            ['@level'] = 0,
            ['@gne'] = 0,
            ['@cooldown'] = 0,
        })
        TriggerClientEvent("boosting:setlevel", src, 0, 0)
    end
end

function GetGNE(identifier)
    local query = DatabaseQuery('SELECT * FROM `boosting_users` WHERE `identifier` = @identifier', {
        ['@identifier'] = identifier
    })
    return query[1]
end

function SetLevel(identifier, newvalue)
    local query = DatabaseQuery('UPDATE boosting_users SET level = @level WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['level'] = newvalue
    })
end

function GetLevel(identifier)
    local query = DatabaseQuery('SELECT * FROM boosting_users WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
    })
    local level

    if query ~= nil and query[1] ~= nil then
        level = query[1].level
    end
    Wait(500)
    return level
end

function SetGNE(cid, newvalue)
    exports.oxmysql:execute('SELECT gne FROM boosting_users WHERE identifier = ?', {cid}, function(result)
        exports.oxmysql:execute("UPDATE boosting_users SET `gne` = @gne WHERE identifier = @cid", {
            ['gne'] = newvalue,
            ['cid'] = cid
        })
    end)
end

function AddGNE(cid, pAmount)
    exports.oxmysql:execute('SELECT gne FROM boosting_users WHERE identifier = ?', {cid}, function(result)
        print(result[1].gne)
        exports.oxmysql:execute("UPDATE boosting_users SET `gne` = @gne WHERE identifier = @cid", {
            ['gne'] = result[1].gne + pAmount,
            ['cid'] = cid
        })
    end)
end

RegisterServerEvent('fa-boosting:removeGNE')
AddEventHandler('fa-boosting:removeGNE', function(amount, cid)
    exports.oxmysql:execute('SELECT gne FROM boosting_users WHERE identifier = ?', {cid}, function(result)
        print('This is how much GNE Before: ', result[1].gne)
        exports.oxmysql:execute("UPDATE boosting_users SET `gne` = @gne WHERE identifier = @cid", {
            ['gne'] = result[1].gne - amount,
            ['cid'] = cid
        })
    end)
end)

function RemoveGNE(amount, cid)
    exports.oxmysql:execute('SELECT gne FROM boosting_users WHERE identifier = ?', {cid}, function(result)
        print('This is how much GNE Before: ', result[1].gne)
        exports.oxmysql:execute("UPDATE boosting_users SET `gne` = @gne WHERE identifier = @cid", {
            ['gne'] = result[1].gne - amount,
            ['cid'] = cid
        })
    end)
end

function getlatestID()
    local query = DatabaseQuery('SELECT * FROM boosting WHERE id=(SELECT max(id) FROM boosting)', {})
    return query
end

function PlayerTransferContract(src, props, posible)
    if posible then
        local SendContracInformation2 = {
            id= props.id, 
            identifier = GetIdentifier(src), 
            vehicle = props.vehicle, 
            type = props.type, 
            owner = props.owner, 
            expires = props.expires, 
            ExtraVin = props.ExtraVin,
            units = props.units, 
            coords = props.coords
        }
        local msg = {msg = "You received a transfered contract", time = time, app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}
        TriggerClientEvent("boosting:CreateContractFromServer", src, SendContracInformation2, msg)
        DatabaseQuery('DELETE FROM `boosting` WHERE `identifier` = @identifier AND `vehicle` = @vehicle AND `id` = @id' , {
            ['@identifier'] = props.identifier,
            ['@vehicle'] = props.vehicle,
            ['@id'] = props.id
        })
        DatabaseQuery('INSERT INTO `boosting` (`identifier`, `vehicle`, `type`, `owner`, `expires`, `ExtraVin`, `units`, `coords`) VALUES (@identifier, @vehicle, @type, @owner, @expires, @ExtraVin, @units, @coords)', {
            ['@identifier'] = GetIdentifier(src),
            ['@vehicle'] = props.vehicle,
            ['@type'] = props.type,
            ['@owner'] = props.owner,
            ['@expires'] = props.expires,
            ['@ExtraVin'] = props.ExtraVin,
            ['@units'] = props.units,
            ['@coords'] = json.encode({x = props.coords.x, y = props.coords.y, z = props.coords.z}),
        })
    else
        local SendContracInformation2 = {
            id= props.id, 
            identifier = GetIdentifier(src), 
            vehicle = props.vehicle, 
            type = props.type, 
            owner = props.owner, 
            expires = props.expires, 
            ExtraVin = props.ExtraVin,
            units = props.units, 
            coords = props.coords}
        local msg = {msg = "It was not possible to send the contract", time = time, app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}
        TriggerClientEvent("boosting:CreateContractFromServer", src, SendContracInformation2, msg)
    end
end


function CoolDownFunctions(src)
    local time = DatabaseQuery('SELECT * FROM `boosting_users` WHERE `identifier` = @identifier', {['@identifier'] = GetIdentifier(src)})
    local result = time[1].cooldown
    if (os.time() - result) < Config.VinCoolDown * 60 and result ~= 0 then
        local seconds = Config.VinCoolDown * 60 - (os.time() - result)
        return {CoolDown = false, minutes = math.floor(seconds / 60)}
    else
        DatabaseQuery('UPDATE boosting_users SET cooldown = @cooldown WHERE identifier = @identifier', {
            ['@identifier'] = GetIdentifier(src),
            ['@cooldown'] = os.time()
        })
        return {CoolDown = true, minutes = 0}
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------HANDLERS-------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function filterContract(number)
    local boomer = tonumber(number)
    randomChance = math.random(1, 100)
    if boomer >= 0 and boomer <= 100 then
        return Config.BoostingContracts["D"][math.random(1, Config.NumberOfContracts.D)] 
    elseif boomer >= 100 and boomer <= 200 then
        if randomChance >= 1 and randomChance <= 74 then
            return Config.BoostingContracts["C"][math.random(1, Config.NumberOfContracts.C)]
        elseif randomChance >= 75 and randomChance <= 100 then
            return Config.BoostingContracts["D"][math.random(1, Config.NumberOfContracts.D)]
        end
    elseif boomer >= 200 and boomer <= 300 then
        if randomChance >= 1 and randomChance <= 33 then
            return Config.BoostingContracts["B"][math.random(1, Config.NumberOfContracts.B)]
        elseif randomChance >= 34 and randomChance <= 66 then
            return Config.BoostingContracts["C"][math.random(1, Config.NumberOfContracts.C)]
        elseif randomChance >= 67 and randomChance <= 100 then
            return Config.BoostingContracts["D"][math.random(1, Config.NumberOfContracts.D)]
        end
    elseif boomer >= 200 and boomer <= 400 then
        if randomChance >= 1 and randomChance <= 25 then
            return Config.BoostingContracts["A"][math.random(1, Config.NumberOfContracts.A)]
        elseif randomChance >= 26 and randomChance <= 65 then
            return Config.BoostingContracts["B"][math.random(1, Config.NumberOfContracts.B)]
        elseif randomChance >= 66 and randomChance <= 100 then
            return Config.BoostingContracts["C"][math.random(1, Config.NumberOfContracts.C)]
        end
    elseif boomer >= 200 and boomer <= 500 then
        if randomChance >= 1 and randomChance <= 15 then
            return Config.BoostingContracts["S"][math.random(1, Config.NumberOfContracts.S)]
        elseif randomChance >= 16 and randomChance <= 35 then
            return Config.BoostingContracts["A"][math.random(1, Config.NumberOfContracts.A)]
        elseif randomChance >= 36 and randomChance <= 69 then
            return Config.BoostingContracts["B"][math.random(1, Config.NumberOfContracts.B)]
        elseif randomChance >= 70 and randomChance <= 100 then
            return Config.BoostingContracts["C"][math.random(1, Config.NumberOfContracts.C)]
        end
    else 
        if randomChance >= 1 and randomChance <= 10 then
            return Config.BoostingContracts["S+"][math.random(1, Config.NumberOfContracts.SPLUS)]
        elseif randomChance >= 11 and randomChance <= 25 then
            return Config.BoostingContracts["S"][math.random(1, Config.NumberOfContracts.S)]
        elseif randomChance >= 26 and randomChance <= 69 then
            return Config.BoostingContracts["A"][math.random(1, Config.NumberOfContracts.A)]
        elseif randomChance >= 70 and randomChance <= 100 then
            return Config.BoostingContracts["B"][math.random(1, Config.NumberOfContracts.B)]
        end
    end
end

RegisterNetEvent("boosting:updateTimer")
AddEventHandler("boosting:updateTimer" , function(id, time)
    local src = source
    local identifier = GetIdentifier(src)
    
    DatabaseQuery('UPDATE boosting SET expires = @expires WHERE identifier = @identifier AND id = @id', {
        ['@identifier'] = identifier,
        ['@id'] = id,
        ['@expires'] = time
    })
end)

RegisterNetEvent("boosting:IsInContract")
AddEventHandler("boosting:IsInContract" , function(Bool)
 isInContract = Bool
end)

RegisterNetEvent("boosting:CreateContract")
AddEventHandler("boosting:CreateContract" , function(time)
    local src = source
    local identifier = GetIdentifier(src)
    local contracts = filterContract(GetGNE(identifier).level)
    local ContractsCoords = Config.BoostinSpawnLocations[math.random(1, Config.NumberBoostingLocations)]
    local SendContracInformation = {
        identifier = GetIdentifier(src), 
        vehicle = contracts.vehicle, 
        type = contracts.type, 
        owner = contracts.owner, 
        expires = contracts.expires, 
        units = contracts.units, 
        ExtraVin = contracts.ExtraVin,
        coords = ContractsCoords.coords, 
    }
    AddContractToDB(SendContracInformation)
    Citizen.Wait(1000)
    local id = getlatestID()[1]
    local SendContracInformation2 = {
        id= id.id,
        identifier = GetIdentifier(src), 
        vehicle = contracts.vehicle, 
        type = contracts.type, 
        owner = contracts.owner, 
        expires = contracts.expires, 
        units = contracts.units, 
        ExtraVin = contracts.ExtraVin,
        coords = ContractsCoords.coords
    }
    TriggerClientEvent('phone:addnotification', src, 'Anonymous', 'You recieved a '..contracts.type..' Class Boosting Contract. Vehicle: '..contracts.vehicle)
    local msg = {msg = "A new contract has been received", time = time, app = 'Boosting', img = 'https://imgur.com/FEPqpLc.png'}
    TriggerClientEvent("boosting:CreateContractFromServer", src, SendContracInformation2, msg)
end)


RegisterNetEvent("boosting:CancelContract")
AddEventHandler("boosting:CancelContract" , function(data)
    RemoveContractToDB(data)
end)

RegisterNetEvent("boosting:completeNormalContract")
AddEventHandler("boosting:completeNormalContract" , function(id)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
    local src = source
    local query = GetContractByIDToDB(id)
    local gnes = GetGNE(cid)
    local level = gnes.level
    local newgnes = gnes.gne + query.units

    Citizen.Wait(1000)
    print(query.units)
    SetGNE(cid, query.units)
    SetLevel(identifier, level + Config.XpGain)
    TriggerClientEvent("boosting:setlevel", src, level + Config.XpGain, newgnes)
    RemoveContractByIDToDB(id)
end)

RegisterNetEvent("boosting:addBoostingLevelHelp")
AddEventHandler("boosting:addBoostingLevelHelp" , function()
    local src = source
    local identifier = GetIdentifier(src)
    local gnes = GetGNE(identifier)
    local levelTo = gnes.level + Config.XpGainHackerman
    SetLevel(identifier, levelTo)
    TriggerClientEvent("boosting:setlevel", src, levelTo, gnes.gne)
end)


RegisterNetEvent("boosting:RemoveBNE")
AddEventHandler("boosting:RemoveBNE" , function(toRemove)
    local src = source
    local identifier = GetIdentifier(src)
    local gnes = GetGNE(identifier)
    local newgnes = gnes.gne - toRemove
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id

    RemoveGNE(toRemove, cid)
    TriggerClientEvent("boosting:setlevel", src, gnes.level, newgnes)
end)

RegisterNetEvent("boosting:getLevel", function()
    local src = source
    local identifier = GetIdentifier(src)
    local user = GetIdentifier(src)
    local query = DatabaseQuery('SELECT * FROM `boosting_users` WHERE `identifier` = @identifier', {
        ['@identifier'] = user
    })

    if query[1] == nil then
        DatabaseQuery('INSERT INTO `boosting_users` (`identifier`, `level`, `gne`) VALUES (@identifier, @level, @gne)', {
            ['@identifier'] = user,
            ['@level'] = 0,
            ['@gne'] = 0,
            ['@cooldown'] = 0,
        })
        TriggerClientEvent("boosting:setlevel", src, 0)

        --original trigger
        local gnes = GetGNE(identifier)
        print(gnes.gne)
        print("ARE YOU READING THIS? CLOSE AND RE-OPEN THE TABLET THANKS :) ")
        TriggerClientEvent("boosting:setlevel", src, gnes.level, gnes.gne)
        TriggerClientEvent("boosting:sendHowMuchGNEIHave",src,gnes.gne)
    else
        local gnes = GetGNE(identifier)
        print(gnes.gne)
        TriggerClientEvent("boosting:setlevel", src, gnes.level, gnes.gne)
        TriggerClientEvent("boosting:sendHowMuchGNEIHave",src,gnes.gne)
    end
end)

RegisterNetEvent("boosting:completeVinContract")
AddEventHandler("boosting:completeVinContract" , function(id, plate)
    local src = source
    local identifier = GetIdentifier(src)
    local query = GetContractByIDToDB(id)
    local gnes = GetGNE(identifier)
    Citizen.Wait(1000)
    AddVehicleToGarage(src, query.vehicle, plate)
    SetLevel(identifier, gnes.level + Config.XpGain)
    TriggerClientEvent("boosting:setlevel", src, gnes.level, newgnes)
    RemoveContractByIDToDB(id)
end)

RegisterNetEvent("boosting:TransferContract")
AddEventHandler("boosting:TransferContract" , function(data)
    local props = data.props
    local TransferID = data.imputValue
    GetTransferSource(source, props, TransferID)
end)

RegisterNetEvent("boosting:sendGNE")
AddEventHandler("boosting:sendGNE" , function(player, gne)
    -- local src = source
    -- local xPlayer = ESX.GetPlayerFromId(src)
    -- local xPlayer2 = ESX.GetPlayerFromId(tonumber(player))
    -- local gnes = tonumber(gne)
    -- if xPlayer2 ~= nil then
    --     if tonumber(player) == src then
    --         TriggerClientEvent("boosting:Notification", src, {msg = '[ERROR] - No puedes poner tu misma id', time = '' , app = 'BNE Finance', img = 'https://i.imgur.com/RAMmJg7.png'})
    --     else
    --         local identifier = xPlayer.getIdentifier()
    --         local identifier2 = xPlayer2.getIdentifier()
    --         local gnePlayer1 = GetGNE(identifier)
    --         local gnePlayer2 = GetGNE(identifier2)
    --         if tonumber(gnePlayer1.gne) >= gnes then
    --             RemoveGNE(identifier, gnes)  --confirmacion extra en el ui esta incluido pero por las dudas
    --             SetGNE(identifier2, gnes)
    --             TriggerClientEvent("boosting:setlevel", src, gnePlayer1.level, gnePlayer1.gne - gnes)
    --             TriggerClientEvent("boosting:setlevel", tonumber(player), gnePlayer2.level, gnePlayer2.gne + gnes)
    --             TriggerClientEvent("boosting:Notification", src, {msg = 'Mandaste exitosamente '..gne..' BNE a la persona con id '..player, time = '' , app = 'BNE Finance', img = 'https://i.imgur.com/RAMmJg7.png'})
    --             TriggerClientEvent("boosting:Notification", tonumber(player), {msg = 'Recibiste '..gne..' BNE te los ha enviado la persona con id '..src, time = '' , app = 'BNE Finance', img = 'https://i.imgur.com/RAMmJg7.png'})
    --         end
    --     end
    -- else
    --     TriggerClientEvent("boosting:Notification", src, {msg = '[ERROR] - No existe la id '..player, time = '' , app = 'BNE Finance', img = 'https://i.imgur.com/RAMmJg7.png'})
    -- end
end)


RegisterNetEvent("boosting:purchaseGNE")
AddEventHandler("boosting:purchaseGNE" , function(quantity)
    local src = source
    local identifier = GetIdentifier(src)
    local gnes = GetGNE(identifier)
    local user = exports['fa-base']:getModule("Player"):GetUser(src)
    RemoveGNE(identifier, quantity)
    user:addBank(quantity * Config.UnitPrice)
    TriggerClientEvent("boosting:setlevel", src, gnes.level, gnes.gne - quantity)
    TriggerClientEvent("boosting:Notification", src, {msg = 'You sold ' ..quantity.. ' and for that reason you receive ' ..quantity * Config.UnitPrice , time = '' , app = 'BNE Finance', img = 'https://i.imgur.com/RAMmJg7.png'})
end)

RegisterNetEvent("boostingQB:playerSpawned")
AddEventHandler("boostingQB:playerSpawned" , function(source)
    local src = source
    local query = GetContractToDB(GetIdentifier(src))
    InitBoostingUser(src)
    for k, v in pairs(query) do
        if v.id ~= nil and v.identifier ~= nil and v.vehicle ~= nil then
            local coords = json.decode(v.coords) or {x = 0, y = 0, z = 0}
            local SendContracInformation = {
                id = v.id, 
                identifier = v.identifier, 
                vehicle = v.vehicle, 
                type = v.type, 
                owner = v.owner, 
                expires = v.expires, 
                ExtraVin = v.ExtraVin,
                units = v.units, 
                coords = vector3(coords.x, coords.y, coords.z)
            }
            local msg = {msg = "A new contract has been received", time = time}
            TriggerClientEvent("boosting:CreateContractFromServer2", src, SendContracInformation, msg)
        end
    end
end)

RegisterServerEvent('fa-boosting:pay_gne')
AddEventHandler('fa-boosting:pay_gne', function()
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
    local gnes = GetGNE(cid)

    SetLevel(cid, gnes.level + Config.XpGain)
    exports.oxmysql:execute('SELECT level FROM boosting_users WHERE identifier = ?', {cid}, function(result)
        if tonumber(result[1].level) >= 0 and tonumber(result[1].level) <= 100 then
            AddGNE(cid, 10)
        elseif tonumber(result[1].level) >= 100 and tonumber(result[1].level) <= 200 then
            AddGNE(cid, 25)
        elseif tonumber(result[1].level) >= 200 and tonumber(result[1].level) <= 300 then
            AddGNE(cid, 170)
        elseif tonumber(result[1].level) >= 300 and tonumber(result[1].level) <= 400 then
            AddGNE(cid, 300)
        elseif tonumber(result[1].level) >= 400 and tonumber(result[1].level) <= 500 then
            AddGNE(cid, 500)
        end
    end)
end)
 
RegisterServerEvent('fa-boosting:giveGNE')
AddEventHandler('fa-boosting:giveGNE', function(amount)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id

    AddGNE(cid, amount)
end)