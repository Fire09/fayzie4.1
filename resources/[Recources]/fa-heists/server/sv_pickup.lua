RPC.register("blackmarket:buyProduct", function(pSource, pCid, pPrice, pItem)

    local information = {}

    local randomId = tostring(math.random(50)) .. tostring(math.random(70)) .. tostring(math.random(90))

    if pItem.param == "hacklaptop" then
        information = {
            _id = randomId,
            _uses = "3",
            _hideKeys = {"_id", "_uses"}
        }
    end

    local data1 = Await(SQL.execute("INSERT INTO pickups (cid, itemid, information) VALUES (@cid, @itemid, @information)", {
        ["cid"] = pCid.param,
        ["itemid"] = pItem.param,
        ["information"] = json.encode(information)
    }))
    local data2 = Await(SQL.execute("UPDATE user_crypto SET cryptoamount = cryptoamount - @price WHERE cryptoid = @cryptoid AND cryptocid = @cryptocid", {
        ["price"] = pPrice.param,
        ["cryptoid"] = 1,
        ["cryptocid"] = pCid.param
    }))

    return "success"
end)

RPC.register("blackmarket:testpickup", function(pSource)
    local information = {}

    local randomId = tostring(math.random(50)) .. tostring(math.random(70)) .. tostring(math.random(90))

    --if pItem.param == "hacklaptop" then
        information = {
            id = randomId,
            uses = 3
        }

        print(json.encode(information))
    --end

    local data1 = Await(SQL.execute("INSERT INTO pickups (cid, itemid, information) VALUES (@cid, @itemid, @information)", {
        ["cid"] = 699,
        ["itemid"] = "hacklaptop",
        ["information"] = json.encode(information)
    }))

    return true
end)

RPC.register("blackmarket:hasItemPickup", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT COUNT(*) AS total FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    local hasPickup

    if not data then hasPickup = false return hasPickup end

    if data[1].total > 0 then
    hasPickup = true
    else
    hasPickup = false
    end

    return hasPickup
end)

RPC.register("blackmarket:getPickupItems", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT * FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    return data
end)

RPC.register("blackmarket:resetHasPickUp", function(pSource, pCid)
    local data = Await(SQL.execute("DELETE FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    return true
end)