function DPX.Core.ConsoleLog(self, msg, mod, ply)
	if not tostring(msg) then return end
	if not tostring(mod) then mod = "No Module" end

	local pMsg = string.format("^3[faye LOGGER - %s]^7 %s", mod, msg)
	if not pMsg then return end
	
	print(pMsg)

	if ply and tonumber(ply) then
		TriggerClientEvent("fa-base:consoleLog", ply, msg, mod)
	end
end


local devMode = true

local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1061288479553749002/U2-X0X6mUJnO2AVQMFdEjXhJEwclKOlWua_Ucjv-sxxmld8Fo6W4MpV4fwCSD42aezdL"
local DISCORD_NAME = "faye Security"
local DISCORD_IMAGE = "https://cdn.discordapp.com/attachments/982104385679159296/1044016654172033034/post.png"

--PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "Discord Webhook is **ONLINE**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

AddEventHandler('chatMessage', function(source, name, message) 

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end

	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')

			PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)


local resources = {
	'fayesql',
	'fa-base'
}

Citizen.CreateThread(function()
	PerformHttpRequest("https://api.ipify.org", function(err, text, headers)
		if not devMode then
			for _, v in pairs(resources) do
				local running = GetResourceState(v)
                if running == 'missing' or running == 'stopped' then
					os.exit()
				end
			end
			-- this user name needs to stored buy the purcheaser of the script upon purchase
			user = ''

			exports.fayesql:execute("SELECT * FROM `ipauth` WHERE ip = @ip", {['ip'] = text}, function(result) 
				if result ~= nil then
					if result[1] == '[]' then 
						if result and result[1].enabled == 1 then
							DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
							DPX.Core:ConsoleLog("^2IP: " .. "Thank you for purchasing a license from faye")
							DPX.Core:ConsoleLog("^2Authorised IP: " .. " Base Loaded")
							DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
						elseif result and result[1].enabled == 0 then
							DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
							DPX.Core:ConsoleLog("^2Your authorization has been disabled.")
							DPX.Core:ConsoleLog("^2Open a ticket in the faye discord.")
							DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
							StopResource(GetCurrentResourceName())
							Wait(5000)
							os.exit()
						end
					else
						
						
						--print(user)
						exports.fayesql:execute("UPDATE ipauth SET enabled = @enabled WHERE name = @name", {['enabled'] = 0, ['name'] = user})




						DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
						DPX.Core:ConsoleLog("^1Unauthorised IP: " .. " Base Not Loaded. Please purchase an official faye License.")
						DPX.Core:ConsoleLog("^1----------------------------------------------------------------------")
						StopResource(GetCurrentResourceName())
						sendToDiscord(DISCORD_NAME, "```fix\nUnauthorised IP: " .. text .. "```" .. "Access has been auto revoked for this user.. " .. user, 16711680)

						Wait(5000)
						os.exit()
					end
				end
			end)
		elseif devMode then
			print("^3faye Base Loaded in developer mode")
		end
	end)
end)

function sendToDiscord(name, message, color)
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "Made by faye",
			  },
		  }
	  }
	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler("onResourceStart", function(resource)
	TriggerClientEvent("fa-base:waitForExports", -1)

	if not DPX.Core.ExportsReady then return end

	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(0)
			if DPX.Core.ExportsReady then
				TriggerEvent("fa-base:exportsReady")
				return
			else
			end
		end
	end)
end)

RegisterNetEvent("fa-base:playerSessionStarted")
AddEventHandler("fa-base:playerSessionStarted", function()

	local src = source
	local name = GetPlayerName(src)
	local user = DPX.Player:GetUser(src)

	if user then 
		print("^0" .. name .. "^7 spawned into the server")
	end
end)

AddEventHandler("fa-base:characterLoaded", function(user, char)
	local src = source
	local hexId = user:getVar("hexid")

	if char.phone_number == 0 then
		DPX.Core:CreatePhoneNumber(source, function(phonenumber, err)	
			local q = [[UPDATE characters SET phone_number = @phone WHERE owner = @owner and id = @cid]]
			local v = {
				["phone"] = phoneNumber,
				["owner"] = hexId,
				["cid"] = char.id
			}

			exports.ghmattimysql.execute(q, v, function()
				char.phone_number = math.floor(char.phone_number)
				user:setCharacter(char)
			end)
		end)
	end
end)


RegisterServerEvent("paycheck:collect")
AddEventHandler("paycheck:collect", function(cid)
	local src = source
	local user = exports["fa-base"]:getModule("Player"):GetUser(src)
	local pChar = user:getCurrentCharacter()
	exports.oxmysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local amount = tonumber(data[1].paycheck)
		if amount >= 1 then
			exports.oxmysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {"0", cid})
			user:addBank(amount)

			local connect = {
				{
				  ["color"] = color,
				  ["title"] = "** faye [Paychecks] **",
				  ["description"] = "State ID: "..cid.." \n First Name: "..pChar.first_name.." Last Name: "..pChar.last_name.." \n Amount: $"..amount,
				}
			  }
			  PerformHttpRequest("https://discord.com/api/webhooks/1061288479553749002/U2-X0X6mUJnO2AVQMFdEjXhJEwclKOlWua_Ucjv-sxxmld8Fo6W4MpV4fwCSD42aezdL", function(err, text, headers) end, 'POST', json.encode({username = "faye | Paycheck", embeds = connect, avatar_url = "https://i.imgur.com/YOddEIF.png"}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent("DoLongHudText", src, "Your broke, go work!")
		end
	end)
end)