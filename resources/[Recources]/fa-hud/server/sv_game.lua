RegisterServerEvent('server:alterStress')
AddEventHandler('server:alterStress', function(positive, alteredValue, notify)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id

	local result = MySQL.query.await([[
        SELECT *
        FROM characters
        WHERE id = ?
    ]],
    { cid })

	local myStress = result[1].stress_level

	Citizen.Wait(500)
	if positive then
		if myStress < tonumber(10000) then
			newStress = myStress + alteredValue

			MySQL.update.await([[
				UPDATE characters
				SET stress_level = ?
				WHERE id = ?
			]],
			{ newStress, cid })
			TriggerClientEvent('client:updateStress', src, newStress)
		end
	else
		if myStress > tonumber(1000) then
			Stress = myStress - alteredValue

			if Stress < 0 then
				Stress = 0
			end
			
			MySQL.update.await([[
				UPDATE characters
				SET stress_level = ?
				WHERE id = ?
			]],
			{ Stress, cid })
			
			TriggerClientEvent('client:updateStress', src, Stress)
		end
	end
end)

RegisterServerEvent("police:update:hud")
AddEventHandler("police:update:hud", function(health, armor, thirst, hunger)
	--print("police:update:hud", health, armour, thirst, hunger)
    local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		meta = { 
			["health"] = health,
			["armor"] = armor,
			["thirst"] = thirst,
			["hunger"] = hunger
		}

		local encode = json.encode(meta)
		exports.oxmysql:execute('UPDATE characters SET metaData = ? WHERE id = ?', {encode, characterId})
	end
end)

RPC.register("police:getMeta", function(src)
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id

	local data = MySQL.query.await([[
        SELECT *
        FROM characters
        WHERE id = ?
    ]],
    { cid })
    
	if not data then return false end

	return json.decode(data[1].metaData)
end)

RPC.register("police:getStress", function(pSource)
	local src = pSource
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id

	local data = MySQL.query.await([[
        SELECT *
        FROM characters
        WHERE id = ?
    ]],
    { cid })
	
	if not data then return false end

	return data[1].stress_level
end)

RegisterServerEvent('fa-hud:buy_can')
AddEventHandler('fa-hud:buy_can', function()
	local src = source
	local user = exports['fa-base']:getModule('Player'):GetUser(src)

	if user:getCash() >= 200 then
		user:removeMoney(200)
		TriggerClientEvent('player:receiveItem', src, '883325847', 1)
	else
		TriggerClientEvent('DoLongHudText', src, 'You do not have enough money.', 2)
	end
end) 