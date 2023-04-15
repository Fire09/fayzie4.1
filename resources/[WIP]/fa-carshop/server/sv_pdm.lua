local door = "closed"

RegisterNetEvent("fa-carshop:pdmBackDoor")
AddEventHandler("fa-carshop:pdmBackDoor", function()
    local update = "opened"
    if door == "opened" then
        update = "closed"
    end

    door = update

    TriggerClientEvent("fa-carshop:pdmBackDoor", -1, door)
end)