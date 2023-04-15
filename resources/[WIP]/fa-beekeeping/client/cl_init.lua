Citizen.CreateThread(function()
    for id, zone in ipairs(HiveZones) do
        exports["fa-polyzone"]:AddCircleZone("fa-beekeeping:bee_zone", zone[1], zone[2],{
            zoneEvents={"fa-beekeeping:trigger_zone"},
            data = {
                id = id,
            },
        })
    end
end)