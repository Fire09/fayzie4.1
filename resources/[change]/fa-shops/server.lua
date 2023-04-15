RegisterServerEvent("itemMoneyCheck")
AddEventHandler("itemMoneyCheck", function(itemType,askingPrice,location)
	local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= askingPrice) then
		user:removeMoney(askingPrice) 
		if askingPrice > 0 then
			TriggerClientEvent('fa-notification:client:Alert', src, {style = 'info', duration = 3000, message = "Purchased"})
		end
		TriggerClientEvent("player:receiveItem",src,itemType,1)

	else
		TriggerClientEvent('fa-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent("shop:useVM:server")
AddEventHandler("shop:useVM:server", function(locatoion)
	local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (tonumber(pCash) >= 20) then
		TriggerClientEvent("shop:useVM:finish",src)
		user:removeMoney(20) 
	else
		TriggerClientEvent('fa-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You need 20$"})
	end
end)

local locations = {}
local itemTypes = {}

RegisterServerEvent("take100")
AddEventHandler("take100", function(tgtsent)
    local user = exports["fa-base"]:getModule("Player"):GetUser(tgtsent)
    local char = user:getCurrentCharacter()
	user:removeMoney(100) 
end)

RegisterServerEvent("movieticket")
AddEventHandler("movieticket", function(askingPrice)
	local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= askingPrice) then
		user:removeMoney(askingPrice) 
		TriggerClientEvent("startmovies",src)
	else
		TriggerClientEvent('fa-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent('shops:GetIDCardSV')
AddEventHandler('shops:GetIDCardSV', function()
	local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= 500) then
		user:removeMoney(500)
		TriggerClientEvent("player:receiveItem", src, 'idcard', 1)
	else
		TriggerClientEvent('fa-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent("fa-shops:WeaponShopStatus")
AddEventHandler("fa-shops:WeaponShopStatus", function()
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.oxmysql:execute("SELECT status FROM user_licenses WHERE cid = @cid AND type = @type ",{['@cid'] = char.id, ['@type'] = 'weapon'}, function(result)
		if result[1].status == 1 then 
			TriggerClientEvent("server-inventory-open", src, "5", "Shop");
			Wait(1000)
		else
			TriggerClientEvent("server-inventory-open", src, "6", "Shop");
			Wait(1000)
			TriggerClientEvent("DoLongHudText", src, "You dont have an active weapons license, contact the police.", 2)
		end
	end)
end)