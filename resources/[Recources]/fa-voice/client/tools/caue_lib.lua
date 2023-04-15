myJob = "unemployed"

RegisterNetEvent("fa-jobs:jobChanged")
AddEventHandler("fa-jobs:jobChanged", function(pJob)
    myJob = pJob

    if not CanUseFrequency(CurrentChannel, nil, myJob) then
        return SetRadioFrequency()
    end
end)

local job = exports['isPed']:isPed("myJob")

function CanUseFrequency(pFrequency, pNotify, pJobOverWrite)
    if not pFrequency then return false end

    if pFrequency == 0 then return true end

    local hasPDRadio = exports["fa-inventory"]:hasEnoughOfItem("radio", 1, false)
    local hasCivRadio = exports["fa-inventory"]:hasEnoughOfItem("civradio", 1, false)

    local frequency = type(pFrequency) == "table" and pFrequency.id or pFrequency
    if frequency >= 10.0 then
        return true
    elseif frequency <= 10.0 and job ~= 'police' or job ~= 'ambulance' then
        TriggerEvent("DoLongHudText", "This frequency is encrypted.", 2) 
        return false
    end
end

AddEventHandler("SpawnEventsClient", function()
    myJob = exports['isPed']:isPed("myJob")
end)