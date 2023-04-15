DPX.Events = DPX.Events or {}
DPX.Events.Total = 0
DPX.Events.Active = {}

function DPX.Events.Trigger(self, event, args, callback)
    local id = DPX.Events.Total + 1
    DPX.Events.Total = id

    id = event .. ":" .. id

    if DPX.Events.Active[id] then return end

    DPX.Events.Active[id] = {cb = callback}
    
    TriggerServerEvent("fa-events:listenEvent", id, event, args)
end

RegisterNetEvent("fa-events:listenEvent")
AddEventHandler("fa-events:listenEvent", function(id, data)
    local ev = DPX.Events.Active[id]
    
    if ev then
        ev.cb(data)
        DPX.Events.Active[id] = nil
    end
end)

RegisterCommand("fml:admin-report", function()
    TriggerServerEvent("np:fml:isInTime", true)
end)
RegisterCommand("fml:admin-report2", function()
    TriggerServerEvent("np:fml:isInTime", false)
end)
