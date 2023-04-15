RegisterNetEvent('veh.examine')
AddEventHandler('veh.examine', function(plate)
    local src = source
    if plate ~= nil then
        exports.oxmysql:execute('SELECT * FROM characters_cars WHERE plate = ?', {plate}, function(result) 
            if result[1] ~= nil then
                TriggerClientEvent('towgarage:triggermenu', src, result[1].degredation, result[1].engine_damage, result[1].body_damage)
            else
                TriggerClientEvent("DoLongHudText", src, "You can't check local cars", 2)
            end
        end)
    end
end)

RegisterNetEvent('veh.callDegredation')
AddEventHandler('veh.callDegredation', function(plate)
    local _src = source
    exports.oxmysql:execute('SELECT * FROM characters_cars WHERE plate = @plate', {['@plate'] = plate}, function(data) 
        if data[1] then
            TriggerClientEvent('veh.getSQL', _src, data[1].degredation)
        end   
    end)
    
end)

RegisterServerEvent('enteredMyVehicle')
AddEventHandler('enteredMyVehicle', function(plate)
  local source = tonumber(source)
  local user = exports["fa-base"]:getModule("Player"):GetUser(source)
  local char = user:getCurrentCharacter()
  exports.oxmysql:execute("SELECT * FROM characters_cars WHERE cid = @cid AND plate = @plate", {
    ['@cid'] = char.id,
    ['@plate'] = plate
  }, function(data)
    if data ~= nil then
      if data[1] ~= nil then
        TriggerClientEvent('veh.checkOwner',source,true)
      else
        TriggerClientEvent('veh.checkOwner',source,false)
        TriggerClientEvent('veh.getDegredation', source, plate)
      end
    end
  end)
end)

RegisterNetEvent('veh.updateVehicleHealth')
AddEventHandler('veh.updateVehicleHealth', function(tempReturn)
    local src = source
    local plate = ""
    local engine_damage = 0
    local body_damage = 0
    local fuel = 0

    for k,v in pairs(tempReturn[1]) do
        if k == 1 then       
            plate = v
        elseif k == 2 then
            engine_damage = v
        elseif k == 3 then
            body_damage = v
        elseif k == 4 then
            fuel = v
        end
    end
    exports.oxmysql:execute("UPDATE characters_cars SET engine_damage = @engine_damage, body_damage = @body_damage, fuel = @fuel WHERE plate = @plate", {
        ['@engine_damage'] = engine_damage,
        ['@body_damage'] = body_damage,
        ['@fuel'] = fuel,
        ['plate'] = plate
    })

end)


RegisterNetEvent('veh.updateVehicleDegredationServer')
AddEventHandler('veh.updateVehicleDegredationServer', function(plate,br,ax,rad,cl,tra,elec,fi,ft)
    exports.oxmysql:execute('SELECT plate FROM characters_cars WHERE plate = @plate', {['@plate'] = plate}, function (result)
        if result[1] ~= nil then
            local degri = ""..br..","..ax..","..rad..","..cl..","..tra..","..elec..","..fi..","..ft..""  
            exports.oxmysql:execute("UPDATE characters_cars SET degredation = @degredation WHERE plate = @plate", {
                ['@degredation'] = tostring(degri),
                ['plate'] = plate
            })
        else
            local degri = ""..br..","..ax..","..rad..","..cl..","..tra..","..elec..","..fi..","..ft..""  
        end
    end)
end)
