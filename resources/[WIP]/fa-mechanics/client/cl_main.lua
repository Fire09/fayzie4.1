local currOrder = {}

AddEventHandler("fa-jobs:bennys:order", function(pVehicle, pChanges)
    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(pVehicle)))
    local orderId = math.random(10000000)

    if model == "NULL" then
        model = GetDisplayNameFromVehicleModel(GetEntityModel(pVehicle))
    end

    currOrder = {
        order = orderId,
        vehicle = model,
        list = pChanges,
        _hideKeys = {"list"},
    }

    TriggerEvent("player:receiveItem", "bennysorder", 1, false, {}, currOrder)
end)

AddEventHandler("fa-inventory:itemUsed", function(item, metaData)
    local meta = json.decode(metaData)
    if item == "bennysorder" then
        local VehicleClass = exports["fa-vehicles"]:GetVehicleRatingClass(meta.vehicle)
        local orderData = RPC.execute('fa-bennys:getOrderData', meta.list, VehicleClass, meta.order, meta.vehicle)

        exports["fa-ui"]:showContextMenu(orderData)
        return
    end
end)

RegisterUICallback("fa-mechanics:order:view", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" } })

end)

AddEventHandler("fa-selector:selectionChanged", function(data)
    return exports["fa-selector"]:getCurrentSelection(data.selectedEntity)
end)