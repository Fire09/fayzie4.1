activeLocation = nil
tsunami = true

availableLocations = {
    [1] = vector3(1305.5650634766, 4250.578125, 33.908638000488),
    [2] = vector3(1582.2761230469, 3842.4379882812, 31.301727294922),
    [3] = vector3(-157.41506958008, 4268.2255859375, 31.940711975098),
    [4] = vector3(2079.0886230469, 4556.6293945312, 31.346710205078),
    [5] = vector3(1583.2722167969, 4444.96484375, 34.706634521484),
    [6] = vector3(714.02844238281, 4124.9301757812, 35.779186248779),
    [7] = vector3(-1846.2895507812, -1247.5093994141, 8.6157913208008),
    [8] = vector3(-1519.2618408203, -1497.9777832031, 6.2412505149841),
    [9] = vector3(-3425.4384765625, 967.85217285156, 8.3466806411743),
    [10] = vector3(-270.88171386719, 6631.236328125, 7.4785633087158),
    [11] = vector3(-999.20239257813, 6265.7578125, 2.1286859512329),
    [12] = vector3(55.172451019287, 7244.44140625, 2.3638601303101),
    [13] = vector3(1536.7352294922, 6641.857421875, 1.8513743877411),
    [14] = vector3(3371.3151855469, 5183.8310546875, 1.4602422714233),
    [15] = vector3(2841.6840820313, -623.72906494141, 1.4005224704742),
}

availableFishes = {
    ["bass"] = {
        name = "Bass",
        itemName = "fishingbass",
        chance = 99,
        skill = 3
    },
    ["bluefish"] = {
        name = "Bluefish",
        itemName = "fishingbluefish",
        chance = 98,
        skill = 3
    },
    ["flounder"] = {
        name = "Flounder",
        itemName = "fishingflounder",
        chance = 97,
        skill = 3
    },
    ["mackerel"] = {
        name = "Mackerel",
        itemName = "fishingmackerel",
        chance = 96,
        skill = 3
    },
    ["cod"] = {
        name = "Cod",
        itemName = "fishingcod",
        chance = 95,
        skill = 3
    },
    ["whale"] = {
        name = "Baby Whale",
        itemName = "fishingwhale",
        chance = 10,
        skill = 7
    },
    ["dolphin"] = {
        name = "Baby Dolphin",
        itemName = "fishingdolphin",
        chance = 15,
        skill = 6
    },
    ["shark"] = {
        name = "Baby Shark",
        itemName = "fishingshark",
        chance = 20,
        skill = 5
    }
}

Citizen.CreateThread(function()
    if tsunami then
        updateFishingLocation()
        TriggerClientEvent("fa-fishing:updateLocation", -1, activeLocation)
        print(activeLocation)
        tsunami = false
    end
    while true do
    Citizen.Wait(100)
    Citizen.Wait(3600000) -- 3600000
    print("upd loc")
    updateFishingLocation()
    end
end)

function updateFishingLocation()
    math.randomseed(os.time())
    activeLocation = availableLocations[math.random(1,15)]
    TriggerClientEvent("fa-fishing:updateLocation", -1, activeLocation)
    print("Updated Fishing Spot: " .. activeLocation)
end

RPC.register("fishing:getAvailableFishes", function(pSource)
    return availableFishes
end)

RPC.register("fishing:getActiveLocation", function()
    local table = {
        coords = activeLocation
    }
    return table
end)

RPC.register("fishing:jobs:getActiveLocation", function()

    local x = activeLocation.x
    local y = activeLocation.y
    local z = activeLocation.z
    return x, y, z
end)

RPC.register('fa-jobs:fishingStart', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            if result[1] ~= nil then
                print('PASSED RESULT [1]')
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    print('Start fishing.')
                    TriggerClientEvent('fa-jobs:setFirstNotiFishing', v)
                end
            end
        end)
        return
    end
end)

RPC.register('fa-jobs:fishingCaughtAFish', function(source)
    for k, v in pairs(GetPlayers()) do
        local user = exports['fa-base']:getModule('Player'):GetUser(tonumber(v))
        local cid = user:getCurrentCharacter().id
        local groupID = exports['fa-phone']:GetMyGroupID(v)

        exports.oxmysql:execute("SELECT members FROM job_group WHERE id = ?", {groupID}, function(result)
            print(result[1])
            if result[1] ~= nil then
                local jobMembers = json.decode(result[1].members)
                for k,v in ipairs(jobMembers) do
                    TriggerClientEvent('fa-jobs:fishingCatch', v)
                end
            end
        end)
        return
    end
end)