local configFile = LoadResourceFile(GetCurrentResourceName(), "config/config.json")
local cfgFile = json.decode(configFile)

local localsFile = LoadResourceFile(GetCurrentResourceName(), "locals/"..cfgFile['locals']..".json")
local lang = json.decode(localsFile)

if cfgFile['EnableAcFunctions'] then

    CreateThread(function()
        TriggerServerEvent('Prefech:getACConfig')
        while true do
            Wait(60 * 1000)
            TriggerServerEvent('Prefech:getACConfig')
        end
    end)

	local acConfig = {}
	RegisterNetEvent('Prefech:SendACConfig')
	AddEventHandler('Prefech:SendACConfig', function(_config)
		acConfig = _config
	end)

	local lastVehicle        = nil
	local lastVehicleModel   = nil
	local warnLimit = 0

	CreateThread(function()
		while true do
			Wait(10000)
			local resourceList = {}
			for i=0,GetNumResources()-1 do
				resourceList[i+1] = GetResourceByFindIndex(i)
				Wait(500)
			end
			Wait(5000)
			TriggerServerEvent("Prefech:resourceCheck", resourceList)
		end
	end)

	CreateThread(function()
		while true do
			Wait(60 * 1000)
			local prefixCheck = {"+", "_", "-", "-", "|", "\\","/",""}
			for k,v in ipairs(GetRegisteredCommands()) do
				for k,x in pairs(acConfig['BlacklistedCommands']) do
					for k,z in pairs(prefixCheck) do
						if string.lower(v.name) == string.lower(z..""..x) then
							if GetPlayerServerId(PlayerId()) ~= nil then
								TriggerServerEvent('Prefech:ClientDiscord', {EmbedMessage = lang['AntiCheat'].BlacklistedCommand:format(x), player_id = GetPlayerServerId(PlayerId()), channel = 'AntiCheat'})
							end
							TriggerServerEvent('ACCheatAlert', {target = GetPlayerServerId(PlayerId()), reason = 'BC01: '..z..''..x, screenshot = true, kick = true})
							if acConfig['KickSettings'].BlacklistedCommands then
								TriggerServerEvent('Prefech:DropPlayer', lang['AntiCheat'].BlacklistedCommandKick)
							end
						end
					end
				end
			end
		end
	end)
end