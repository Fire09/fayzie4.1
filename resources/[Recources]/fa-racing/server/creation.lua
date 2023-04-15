RegisterNetEvent("fa-racing:recieveCreateData")
AddEventHandler("fa-racing:recieveCreateData", function(pRaceName, pRaceType, pRaceThumbnail, pCheckpoints)
    local src = source
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    --local aliases = getAlias(char.id)
	local aliases = char.id

    local distanceMap = 0.0
    for i, v in ipairs(pCheckpoints) do
        if i == #pCheckpoints and pRaceType == "Lap" then
            distanceMap = #(vector3(v["pos"]["x"],v["pos"]["y"],v["pos"]["z"]) - vector3(pCheckpoints[1]["pos"]["x"],pCheckpoints[1]["pos"]["y"],pCheckpoints[1]["pos"]["z"])) + distanceMap
        elseif i ~= #pCheckpoints then
            distanceMap = #(vector3(v["pos"]["x"],v["pos"]["y"],v["pos"]["z"]) - vector3(pCheckpoints[i+1]["pos"]["x"],pCheckpoints[i+1]["pos"]["y"],pCheckpoints[i+1]["pos"]["z"])) + distanceMap
        end
    end
    distanceMap = math.ceil(distanceMap)

    local insertId = MySQL.insert.await([[
        INSERT INTO racing_races (name, creator, distance, type, thumbnail, checkpoints)
        VALUES (?, ?, ?, ?, ?, ?)
    ]],
    { pRaceName, aliases, distanceMap, pRaceType, pRaceThumbnail, json.encode(pCheckpoints) })

    if not insertId or insertId < 1 then return end

    formatRace({
        id = insertId,
        name = pRaceName,
        creator = aliases,
        distance = distanceMap,
        type = pRaceType,
        thumbnail = pRaceThumbnail,
        checkpoints = pCheckpoints,
        fastest_time = 0,
        fastest_name = "N/A",
        races = 0,
    })

    TriggerClientEvent("fa-racing:addedRace", -1, {}, Races)
    TriggerClientEvent("DoLongHudText", src, "Race " .. pRaceName .. " created!")
end)

RPC.register("fa-racing:isRaceNameTaken", function(src, pRaceName)
    local result = MySQL.scalar.await([[
        SELECT id
        FROM racing_races
        WHERE name = ?
    ]],
    { pRaceName })

    if not result then return false end

    return true
end)