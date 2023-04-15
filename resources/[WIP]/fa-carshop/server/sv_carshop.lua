local vehiclesForSale = {}
local vehicleList = {}

function insertLog(vin, model, plate, price, financed, commission, tax, shop, buyer, seller)
    if not vin or not model or not plate or not price or not financed or not commission or not tax or not shop or not buyer or not seller then return end

    MySQL.insert.await([[
        INSERT INTO carshop_logs (vin, model, price, financed, commission, tax, shop, buyer, seller)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]],
    { vin, model, price, financed, commission, tax, shop, buyer, seller })

    exports["fa-logs"]:AddLog("vehicleShop", vin, model, price, financed, commission, tax, shop, buyer, seller)
end

exports("insertLog", insertLog)

RegisterNetEvent("fa-carshop:change")
AddEventHandler("fa-carshop:change", function(shop, index, model)
    print(shop, index, model)
    if not shop or not index or not model then return end

    MySQL.update.await([[
        UPDATE carshop_display
        SET ?? = ?
        WHERE ?? = ? AND ?? = ?
    ]],
    { "model", model, "shop", shop, "index", index })

    config[shop].carSpawns[index]["model"] = model

    TriggerClientEvent("fa-carshop:updateDisplay", -1, shop)
end)

RegisterNetEvent("fa-carshop:commission")
AddEventHandler("fa-carshop:commission", function(shop, index, commission)
    if not shop or not index or not commission then return end

    local src = source

    config[shop].carSpawns[index]["commission"] = commission

    TriggerClientEvent("DoLongHudText", src, "Commission changed to " .. commission .. "%")
end)

RegisterNetEvent("fa-carshop:sell")
AddEventHandler("fa-carshop:sell", function(plate, shop, index)
    if not plate or not shop or not index then return end

    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src) 
    local info = user:getCurrentCharacter().id
    if not info.id then return end

    local name = info.first_name .. " " .. info.last_name

    config[shop].carSpawns[index]["seller"]["sid"] = src
    config[shop].carSpawns[index]["seller"]["name"] = name

    vehiclesForSale[plate] = GetGameTimer() + 60000
end)

RegisterNetEvent("fa-carshop:buy")
AddEventHandler("fa-carshop:buy", function(pParams)
    if not pParams then return end

    local src = source

    local user = exports["fa-base"]:getModule("Player"):GetUser(src) 
    local cid = user:getCurrentCharacter().id
    if not cid then return end

    local accountId = user:getBankId()
    -- local groupBank = exports["fa-groups"]:groupBank(pParams.shop)
    -- local sellerAccount = exports["fa-base"]:getChar(pParams.seller, "bankid")

    if not accountId or not groupBank or not sellerAccount then return end

    local bank = exports["fa-financials"]:getAccountBalance(accountId)
    if bank < pParams.downpayment then
        TriggerClientEvent("DoLongHudText", src, "Você não tem $" .. pParams.downpayment .. "na sua conta do banco.", 2)
        return
    end

    local comment = "Brought " .. pParams.name
    -- local success, message = exports["fa-financials"]:transaction(accountId, groupBank, pParams.downpayment, comment, cid, 5)
    -- if not success then
    --     TriggerClientEvent("DoLongHudText", src, message)
    --     return
    -- end

    local comment2 = "Commission from " .. pParams.name
    -- local success2, message2 = exports["fa-financials"]:transaction(groupBank, sellerAccount, pParams.commission, comment2, 0, 1)
    -- if not success2 then
    --     TriggerClientEvent("DoLongHudText", src, message2)
    --     return
    -- end

    local vin = exports["fa-vehicles"]:insertVehicle(src, pParams.model, "car", pParams.financing, true, true)
    if not vin then
        TriggerClientEvent("DoLongHudText", src, "Error???", 2)
        return
    end

    -- local vehicle = exports["fa-vehicles"]:getVehicle(vin)

    -- TriggerClientEvent("fa-vehicles:spawnVehicle", src, pParams.model, Config[pParams.shop]["Buyed"], vehicle["id"], vehicle["plate"], 100, false, false, false, false, false, true)

    insertLog(vin, pParams.model, vehicle["plate"], pParams.finalprice, 1, pParams.commission, pParams.tax, pParams.shop, pParams.buyer, pParams.sellername)
end)

RPC.register("fa-carshop:getVehicles", function(src, shop)
    local _vehicles = {}

    for i, v in ipairs(vehicleList) do
        if v["shop"] == shop then
            table.insert(_vehicles, v)
        end
    end

    return _vehicles
end)

RPC.register("showroom:locationInit", function(src, shop)
    local data = getConfigFor(shop)
    return data.carSpawns, false
end)

RPC.register("showroom:getCarPresets", function(src)
    local TempPresets = {}
    for k, v in pairs(config) do 
        for index, data in pairs(config[k].carSpawns) do 
            if data["CarPresets"] ~= "{}" or "[]" then
                TempPresets[data["model"]] = data["CarPresets"]
            end
        end
    end
    return TempPresets
end)

RPC.register("fa-carshop:getInformations", function(src, shop, index)
    if not shop or not index then return end

    local model = config[shop].carSpawns[index]["model"]
    if not model then return end

    local infos = nil
    for i, v in ipairs(vehicleList) do
        if v["model"] == model and v["shop"] == shop then
            infos = v
            infos["seller"] = config[shop].carSpawns[index]["seller"]
            infos["commission"] = config[shop].carSpawns[index]["commission"]

            break
        end
    end

    return infos
end)

RPC.register("fa-carshop:forSale", function(plate)
    if vehiclesForSale[plate] and vehiclesForSale[plate] > GetGameTimer() then
        return vehiclesForSale[plate]
    else
        return GetGameTimer() + 60000
    end
end)

Citizen.CreateThread(function()
    local _vehicles = MySQL.query.await([[
        SELECT *
        FROM carshop_vehicles
        ORDER BY category, model
    ]])

    vehicleList = _vehicles

    local _display = MySQL.query.await([[
        SELECT *
        FROM carshop_display
    ]])

    for i, v in ipairs(_display) do
        config[v.shop].carSpawns[v.index]["model"] = v.model
        config[v.shop].carSpawns[v.index]["CarPresets"] = json.decode(v.presets)
        config[v.shop].carSpawns[v.index]["commission"] = 15
        config[v.shop].carSpawns[v.index]["seller"] = {
            ["sid"] = 0,
            -- ["name"] = exports["fa-groups"]:groupName(v.shop) -- biz name
        }
    end
end)