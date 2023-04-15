function leaderboardAddRaces(id)
    if not id then return end

    MySQL.update([[
        UPDATE racing_races
        SET races = races + 1
        WHERE id = ?
    ]],
    { tonumber(id) })
end

function leaderboardAddFastest(id, time, aliases)
    if not id or not Races[id] then return end

    local fastest_time = Races[id]["fastest_time"]
    local fastest_name = Races[id]["fastest_name"]

    if fastest_time > time or fastest_time == 0 then
        Races[id]["fastest_time"] = time
        Races[id]["fastest_name"] = aliases

        MySQL.update([[
            UPDATE racing_races
            SET fastest_time = ?, fastest_name = ?
            WHERE id = ?
        ]],
        { time, aliases, tonumber(id) })
    end
end

RPC.register("fa-racing:getLeaderboard", function()
    local leaderboard = MySQL.query.await([[
        SELECT id, name, creator, distance, fastest_time, fastest_name, races
        FROM racing_races
        ORDER BY races
    ]])

    return leaderboard
end)