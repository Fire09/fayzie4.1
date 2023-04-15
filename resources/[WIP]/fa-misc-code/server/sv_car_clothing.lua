
RPC.register("fa-car-clothing:swapCurrentOutfit", function(src, pNetId, data)
    local entity = NetworkGetEntityFromNetworkId(pNetId)
    local vehData = Entity(tonumber(entity))
    local vin = vehData.state.vin
    local temp = {}

    if not vin then return ("vin not found") end

    local outfitsList = DoesVehHasOutfits(vin)
    for k, v in pairs(outfitsList) do 
        if tonumber(k) == tonumber(data.slot) then
            temp = {
                app = v.app,
                mods = v.mods,
                colors = v.app.colors
            }
            return temp
        end
    end
end)

RPC.register("fa-car-clothing:saveCurrentOutfit", function(src, pNetId, data)
    local entity = NetworkGetEntityFromNetworkId(pNetId)
    local currApp = exports["fa-vehicles"]:GetVehicleAppearance(pNetId)
    local currMods = exports["fa-vehicles"]:GetVehicleMods(pNetId)
    local vehData = Entity(tonumber(entity))
    local vin = vehData.state.vin
    local temp = {}

    if not vin then return ("vin not found") end

    local outfits = DoesVehHasOutfits(vin)
    if not outfits then
        temp[#temp + 1] = {
            name = data.name,
            slot = data.slot,
            app = currApp,
            mods = currMods,
        }

        local affectedRows = MySQL.update.await([[
            UPDATE characters_cars
            SET veh_outfit = ?
            WHERE vin = ?
        ]],
        { json.encode(temp), vin })

        if not affectedRows or affectedRows < 1 then
            return false, print("there's not affectedRows changes")
        end
    else
        for k, v in pairs(outfitsList) do 
            if tonumber(k) == tonumber(data.slot) then
                temp = {
                    name = data.name,
                    slot = data.slot,
                    app = currApp,
                    mods = currMods,
                }
            end
        end

        table.insert(outfits, temp)

        local affectedRows = MySQL.update.await([[
            UPDATE characters_cars
            SET veh_outfit = ?
            WHERE vin = ?
        ]],
        { json.encode(outfits), vin })

        if not affectedRows or affectedRows < 1 then
            return false, print("there's not affectedRows changes")
        end
    end
end)

function DoesVehHasOutfits(pVin)
    local result = MySQL.scalar.await([[
        SELECT veh_outfit
        FROM characters_cars
        WHERE vin = ?
    ]],
    { pVin })

    if not result then
        return false
    end

    local data = json.decode(result)
    return data
end
