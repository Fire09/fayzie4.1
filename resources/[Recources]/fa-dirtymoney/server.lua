RegisterServerEvent("fa-dirtymoney:attemptDirtyMoneyDrops")
AddEventHandler("fa-dirtymoney:attemptDirtyMoneyDrops", function()
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if DirtyMoney > 500 then
		TriggerClientEvent("fa-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - 500
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,500)
	else
		TriggerClientEvent("DoLongHudText",source,"You need $500 in Marked Bills.",2)
	end

end)

RegisterServerEvent("fa-dirtymoney:alterDirtyMoney")
AddEventHandler("fa-dirtymoney:alterDirtyMoney", function(reason, amount)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if reason == "ItemDrop" then
		TriggerClientEvent("fa-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - amount
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,amount)
	else
		DirtyMoney = DirtyMoney + amount
		user:alterDirtyMoney(DirtyMoney)
	end

end)

RegisterServerEvent("fa-dirtymoney:moneyPickup")
AddEventHandler("fa-dirtymoney:moneyPickup", function(amount)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	user:addMoney((amount))
end)