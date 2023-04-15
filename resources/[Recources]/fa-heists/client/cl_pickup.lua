local pickupLocation = vector3(436.36608886719, 2996.1928710938, 41.283821105957)
local blip = nil
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distanceCheckPickup = GetDistanceBetweenCoords(playerCoords, 436.36608886719, 2996.1928710938, 41.283821105957, false)
        if distanceCheckPickup <= 1.0 then
            if IsControlPressed(0, 38) then
                  HasItemPickup()
            end
        end
        Citizen.Wait(1000)
    end
end)

-- RegisterCommand("testpickup", function()
--     print("testpickup")
--     RPC.execute("blackmarket:testpickup")
-- end)

function HasItemPickup()
    local cid = exports["isPed"]:isPed("cid")
    local hasPickup = RPC.execute("blackmarket:hasItemPickup", cid)
    if not hasPickup then TriggerEvent("DoLongHudText", "You don't have a pickup!") return end
    local items = RPC.execute("blackmarket:getPickupItems", cid)
    local result = RPC.execute("blackmarket:resetHasPickUp", cid)
    if not result then return end
    local pickupitem
    for i = 1, #items do
        pickupitem = items[i]["itemid"]
        --if pickupitem == "hacklaptop" then
        --TriggerEvent("player:receiveItem", pickupitem, 1, information)
        --else
        --print(json.encode(items[i]["information"]))
        --local information =  json.decode(items[i]["information"])
        if pickupitem == "hacklaptop" then
            local data = json.decode(items[i]["information"])
            TriggerEvent("player:receiveItem", pickupitem, 1, false, {
                _hideKeys = { "id", "uses" },
                id = data.id,
                uses = data.uses
              })
        else
            TriggerEvent("player:receiveItem", pickupitem, 1, items[i]["information"])
        end
        --end
    end
    TriggerEvent("DoLongHudText", "Got yo shit", 1)
    RemoveBlip(blip)
end

function addPickUpBlip()
    blip = AddBlipForCoord(pickupLocation)
    SetBlipSprite(blip, 440)
    SetBlipScale(blip, 1.2)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Item Pickup")
    EndTextCommandSetBlipName(blip)
  end

RegisterNetEvent("fa-heists:pickup:blip")
AddEventHandler("fa-heists:pickup:blip", function()
    addPickUpBlip()
end)