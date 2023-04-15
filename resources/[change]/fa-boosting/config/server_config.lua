local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do NumberCharset[#NumberCharset+1] = string.char(i) end
for i = 65,  90 do StringCharset[#StringCharset+1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset+1] = string.char(i) end

RandomStr = function(length)
    if length <= 0 then return '' end
    return RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

RandomInt = function(length)
    if length <= 0 then return '' end
    return RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end

if Config.OldVersion then
    DatabaseQuery = function(query, parameters)
        if string.find(query, "SELECT") then
            local result = MySQL.Sync.fetchAll(query, parameters)
            return result
        elseif string.find(query, "INSERT") then
            MySQL.Sync.insert(query, parameters)
        else
            MySQL.Sync.execute(query, parameters)
        end
    end
end

Citizen.CreateThread(function()

        if Config.DevCommands then
            RegisterCommand(Config.FetchInfo, function(source, args, rawCommand)
                print('[fa-boosting] - Fetching data...')
                TriggerEvent("boostingQB:playerSpawned", source)
            end)
        end

        RegisterNetEvent("buy:gne")
        AddEventHandler("buy:gne",function(GneToAdd)
            local src = source
            local identifier = GetIdentifier(src)
            local gnes = GetGNE(identifier)
            local user = exports["fa-base"]:getModule("Player"):GetUser(src)
            local cid = user:getCurrentCharacter().id

            SetGNE(cid, gnes.gne + GneToAdd)
        end)

        RegisterNetEvent("boosting:bennysitem")
        AddEventHandler("boosting:bennysitem",function(data, pay)
            local src = source
            local identifier = GetIdentifier(src)
            local gnes = GetGNE(identifier)
            local user = exports["fa-base"]:getModule("Player"):GetUser(src)
            local cid = user:getCurrentCharacter().id

            TriggerClientEvent("boosting:setlevel", src, gnes.level, gnes.gne-pay)
            Citizen.Wait(1000)
            for k, v in pairs(data) do
                TriggerClientEvent("player:receiveItem", src, v.item, 1)
            end
        end)

        function CanBuyGne(src, quantity)
            local user = exports['fa-base']:getModule("Player"):GetUser(src)
            local accountMoney = user:getBank()
            local price = tonumber(quantity) * Config.UnitPrice
            if accountMoney >= price then 
                user:removeBank(price)
                --local cash = Player.Functions.RemoveMoney('bank', price, 'banking-quick-withdraw')
                --if cash then
                    return true
                --end
            --else 
               -- return false
            end
            return false
        end

        function GeneratePlate()			
            local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)
            local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
            if result then
                return plate
            else
                return plate:upper()
            end
        end

        function GetIdentifier(src)
            local user = exports['fa-base']:getModule("Player"):GetUser(src)
            local char = user:getCurrentCharacter()
            return char.id
        end

        function IsPoliceAllowed(src)
            local source = tonumber(src)
            local user = exports['fa-base']:getModule("Player"):GetUser(source)
                if user:getVar("job") == "police" then
                    return true
                end
            return false
        end

        function GetPlayerFromCid(pCid)
            local Retval = nil
            for k,v in pairs(GetPlayers()) do
                local user = exports['fa-base']:getModule("Player"):GetUser(v)
                local cid = user:getCurrentCharacter().id
                if cid == pCid then
                    Retval = v
                end
            end
            return Retval
        end


        function GetTransferSource(src, props, TransferID)
            local Player = GetPlayerFromCid(TransferID)
            if Player ~= nil then
                local toSrc = Player
                PlayerTransferContract(toSrc, {id= props.id, vehicle = props.vehicle, identifier = props.identifier, type = props.type, owner = props.owner, expires = props.expires, units = props.units, coords = props.coords}, true)
            else
                PlayerTransferContract(src, {id= props.id, vehicle = props.vehicle, identifier = props.identifier, type = props.type, owner = props.owner, expires = props.expires, units = props.units, coords = props.coords}, false)
            end
        end

        function AddVehicleToGarage(src, vehicle, plate) --PROPERTY IF YOU NEED
            local source = tonumber(src)
            local user = exports['fa-base']:getModule("Player"):GetUser(source)
            local cid = user:getCurrentCharacter().id
            exports.oxmysql:execute('INSERT INTO characters_cars (cid, model, vehicle_state, name, current_garage, vin, license_plate) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                cid,
                vehicle,
                'Out',
                vehicle,
                'C',
                '1',
                plate,
            })												 
            -- TriggerClientEvent('boosting:VehicleQB', source, vehicle, tostring(plate))
        end
end)

RegisterServerCallback {eventName = 'boosting:getplate', eventCallback = function(source, ...)
    local plate = GeneratePlate()
    return plate
end}

RegisterServerCallback {eventName = 'boosting:CoolDown', eventCallback = function(source, ...)
    return CoolDownFunctions(source)
end}

RegisterServerCallback {eventName = 'boosting:CreateVehicleServer', eventCallback = function(source, ...)
    local veh = CreateVehicle(hash, x, y, z, heading, isNetwork, netMissionEntity)
    return veh
end}

