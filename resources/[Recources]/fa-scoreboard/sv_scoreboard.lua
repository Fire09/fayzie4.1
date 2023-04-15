local DPX = DPX or {}
DPX.Scoreboard = {}
DPX._Scoreboard = {}
DPX._Scoreboard.PlayersS = {}
DPX._Scoreboard.RecentS = {}

RegisterServerEvent('fa-scoreboard:AddPlayer')
AddEventHandler("fa-scoreboard:AddPlayer", function()

    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("fa-scoreboard:AddPlayer", -1, data )
    DPX.Scoreboard.AddAllPlayers()
end)

function DPX.Scoreboard.AddAllPlayers(self)
    --local players = GetActivePlayers()

    for i, _PlayerId in pairs(GetPlayers()) do
        
        local identifiers, steamIdentifier = GetPlayerIdentifiers(_PlayerId)
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end

        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(_PlayerId)
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = tonumber(_PlayerId), steamid = stid, comid = scomid, name = ply }

        TriggerClientEvent("fa-scoreboard:AddAllPlayers", source, data)

    end
end

function DPX.Scoreboard.AddPlayerS(self, data)
    DPX._Scoreboard.PlayersS[data.src] = data
end

AddEventHandler("playerDropped", function()
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local plyid = source
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("fa-scoreboard:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("fa-scoreboard:RemoveRecent", -1, plyid)
end)

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end