function GetIds(src)
    local ids = {}

    for k,v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            ids["hex"] = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            ids["license"] = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            ids["xbl"] = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ids["ip"] = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            ids["discord"] = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            ids["live"] = v
        end
    end

    if not ids["ip"] then
        ids["ip"] = GetPlayerEndpoint(src)
    end

    if not ids["steamid"] and ids["hex"] then
        ids["steamid"] = HexIdToComId(ids["hex"])
    end

    return ids
end

function HexIdToSteamId(hexid)
    local cid = HexIdToComId(hexid)
    local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end

function HexIdToComId(hexid)
    return math.floor(tonumber(string.sub(hexid, 7), 16))
end

function IsSteamId(id)
    id = tostring(id)
    if not id then return false end
    if string.match(id, "^STEAM_[01]:[01]:%d+$") then return true else return false end
end