RPC.register("fa-pets:purchasePet", function(src, data)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src) 

    local model = data.key.key.model
    local price = data.key.key.price
    local deparment = data.key.key.deparment
    local Type = data.key.key.type
    local variants = data.key.key.variants
    local name = data.values.name

    local cid = user:getCurrentCharacter().id
    if not cid then return end

    local cash = user:getCash() 

    if price > cash then
        TriggerClientEvent("DoLongHudText", src, "You do not have $" .. price .. " with you", 2)
        return
    end

    if Type == "k9" then
        TriggerClientEvent("fa-pets:k9create", src, cid, model, deparment, name, math.random(0, variants))
    else
        TriggerClientEvent("fa-pets:petCreate", src, cid, model, name, math.random(0, variants))
    end
end)