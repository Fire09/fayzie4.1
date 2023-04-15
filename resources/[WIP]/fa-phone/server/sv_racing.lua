

RPC.register('fa-phone:getRaceTrack', function(source, pl)
    local src = source
    local plate = pl
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local raceTrackers = {}
    local raceTracks = MySQL.query.await([[
        SELECT * 
        FROM racing_tracks
    ]],{})
    local checkPoints = MySQL.query.await([[
        SELECT checkPoints 
        FROM racing_tracks
    ]],{})
    -- print("CHECK POINTS", json.encode(raceTracks[1].checkpoints))
    -- checkPoints(raceTracks[1].checkpoints)
    for i=1, #raceTracks do
        -- print(raceTracks[i].track_name)
        -- for s,v in pairs(result[i].checkpoints) do
        --     print(s)
        -- end
        table.insert(raceTrackers, {
            id = raceTracks[i].id,
            checkpoints = json.decode(raceTracks[i].checkpoints),
            track_name = raceTracks[i].track_name,
            creator = raceTracks[i].creator,
            distance = raceTracks[i].distance,
            races = raceTracks[i].races,
            fastest_car = raceTracks[i].fastest_car,
            fastest_name = raceTracks[i].fastest_name,
            fastest_lap = raceTracks[i].fastest_lap,
            fastest_sprint = raceTracks[i].fastest_sprint, 
            fastest_sprint_name = raceTracks[i].fastest_sprint_name,
            description = raceTracks[i].description
        })
        -- raceTrackers = {
        --     checkpoints = json.decode(result[i].checkpoints),
        --     track_name = raceTracks[i].track_name,
        --     creator = result[i].creator,
        --     distance = result[i].distance,
        --     races = result[i].races,
        --     fastest_car = result[i].fastest_car,
        --     fastest_name = result[i].fastest_name,
        --     fastest_lap = result[i].fastest_lap,
        --     fastest_sprint = result[i].fastest_sprint, 
        --     fastest_sprint_name = result[i].fastest_sprint_name,
        --     description = result[i].description
        -- }
    end
    -- print('RACE', json.encode(raceTrackers))
   
    return raceTrackers
end)

function checkPoints(cpoints)
    -- print(json.encode(cpoints))
    -- for i=1, #cpoints do
    --     print(cpoints[i])
    -- end
    -- for i=1, #cpoints do
    --     print(cpoints[i])
    -- end
end

RPC.register('fa-phone:racing:setGPS', function(pSource, id)
    local mID = id
    local raceTrackers = {}
    local raceTracks = MySQL.query.await([[
        SELECT * 
        FROM racing_tracks
        WHERE id = ?
    ]],{mID})
    
    for i=1, #raceTracks do
        table.insert(raceTrackers, {
            id = raceTracks[i].id,
            checkpoints = json.decode(raceTracks[i].checkpoints),
            track_name = raceTracks[i].track_name,
            creator = raceTracks[i].creator,
            distance = raceTracks[i].distance,
        })
    end
    return raceTrackers
end)