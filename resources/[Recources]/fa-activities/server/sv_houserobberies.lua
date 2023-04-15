local x,y,z
local cooldown = 0
local expect, door, initiated = false, false, false
local wait = 10000
local num = 0 
local cooldownTimer = {}
local props = {
	['prop_micro_01'] = {item = 'microwave'},
	['prop_coffee_mac_02'] = {item = 'coffeemaker'},
}

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		num = math.random(111,999)
		print('^2[House Robbery]: Started^7')
		initiated = true
	end
end)

Citizen.CreateThread(function()
	while not initiated do
		Citizen.Wait(10)
	end
	RPC.register('fa-houserobbery:enter_property', function(source, ...)
		local cb = {x,y,z,num}
		return cb
	end)	
	print('^4[House Robbery]:^4 Initilised Framework')
end)

function getIdenti(source)
	for k,v in pairs(GetPlayerIdentifiers(source))do       
		if string.sub(v, 1, string.len("license:")) == "license:" then
			return v
		end		
	end
end

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(cooldownTimer) do
			if v.time <= 0 then
				ResetCooldownTimer(v.identifier)
			else
				v.time = v.time - 1
			end
		end
		Citizen.Wait(30 * 60 * 1000)
	end
end)

function ResetCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            table.remove(cooldownTimer,k)
        end
    end
end

function CheckCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            return true
        end
    end
    return false
end

RegisterServerEvent('fa-activities:givePayout')
AddEventHandler('fa-activities:givePayout', function(amount, pType, text)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()

    if pType == "cash" then
        user:addMoney(amount)
    elseif pType == "bank" then
        user:addBank(amount)
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Endless RP [Activities] | Payout Log **",
          ["description"] = "Log | Amount: $"..amount.." | Type: "..pType.." | Job Type (Buff / No Buff): "..text.." | Character Name: "..charInfo.first_name.." "..charInfo.last_name.." | State ID: "..charInfo.id,
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1040840915763335208/9t9z_FcFbm1qeanDYo2HXB6ksHldivZmynndK_7E2IbjBOK1h5cqQOqu1Y_JQZJeUNeP", function(err, text, headers) end, 'POST', json.encode({username = "Endless RP | Job Payout Log", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/476423150817771526/1026844730488787045/Endless-2.png"}), { ['Content-Type'] = 'application/json' })
end)

RPC.register('fa-activities:houseRobberyGetJob', function(source, houseLoc)
    local user = exports['fa-base']:getModule('Player'):GetUser(source)
    local cid = user:getCurrentCharacter().id
    local groupId = exports['fa-phone']:GetMyGroupID(source)


    print("Group Id for sourceId : ", groupId, source)
    exports.oxmysql:execute("SELECT `members` FROM job_group WHERE id = ?", {groupId}, function(result)
        if (result[1] == nil) then print("cant find members in your group") return end 

        local jobMembers = json.decode(result[1].members)
        for k,v in ipairs(jobMembers) do
            print("member source Id: ", tonumber(v))
            TriggerClientEvent('fa-activities:getJob', tonumber(v), houseLoc)
        end
    end)
end)

RPC.register('fa-activities:houseGainedAccess', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:houseRobberFirstEntraceSync', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-activities:houseRobberySearchLocationSync', function(source, itemNum)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupId = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupId}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-activities:syncSearchedItemLocation', v, itemNum)
                end
            end
        end)
        return
    end
end)