RegisterNetEvent('fa-fuel:initFuel')
AddEventHandler('fa-fuel:initFuel', function(sentVeh)
	local veh = NetworkGetEntityFromNetworkId(sentVeh)
	if veh ~= 0 then
		Entity(veh).state.fuel = math.random(40, 60)
	end
end)

AddEventHandler('fa-fuel:setFuel', function(sentVeh, sentFuel)
	if type(sentFuel) == 'number' and sentFuel >= 0 and sentFuel <= 100 then
		if DoesEntityExist(sentVeh) then
			Entity(sentVeh).state.fuel = sentFuel
		else
			Entity(NetworkGetEntityFromNetworkId(sentVeh)).state.fuel = sentFuel
		end
	end
end)

local function GetFuel(sentVeh)
	if DoesEntityExist(sentVeh) then
		return Entity(sentVeh).state.fuel
	else
		return Entity(NetworkGetEntityFromNetworkId(sentVeh)).state.fuel
	end
end

exports('GetFuel', GetFuel) -- exports['fa-fuel']:GetFuel(veh)

-- RegisterCommand("setfuel", function(source, args, rawCommand)
-- 	TriggerEvent('fa-fuel:setFuel', GetVehiclePedIsIn(GetPlayerPed(source)), tonumber(args[1]))
-- 	Wait(500)
-- 	print(GetFuel(GetVehiclePedIsIn(GetPlayerPed(source))))
-- end, false)

RPC.register('fa-fuel:PurchaseSuccessful', function(src, gprice)
	local pSrc = src
	local user = exports["fa-base"]:getModule("Player"):GetUser(pSrc)

	if user:getBalance() >= gprice then
		print(gprice)
		user:removeBank(gprice)
		return true
	else
		TriggerClientEvent('DoLongHudText', pSrc, 'Not enough money in bank!', 2)
		return false
	end
end)

RegisterNetEvent('fa-fuel:Refund', function(gprice)
	local pSrc = source
	exports['fa-fw']:GetModule('AddBank')(pSrc, tonumber(gprice))
end)

RegisterNetEvent('fa-fuel:testing', function()
	local src = source
	local data = src
	TriggerClientEvent("fa-fuel:send_billSelf2",src ,data)
end)