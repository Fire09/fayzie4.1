AddEventHandler("fa-companions:showPetshop", function(pArgs, pEntity, pContext)
    local data = {}

    for _, pet in ipairs(pArgs["Pets"]) do
        pet.type = pArgs["Type"]
        pet.department = pArgs["Department"]

        table.insert(data, {
            title = pet.name,
            description = "$" .. pet.price,
            children = {
                { title = "Confirmar Purchase", action = "fa-pets:purchasePet", key = pet },
            },
        })
    end

    exports["fa-ui"]:showContextMenu(data)
end)

RegisterUICallback("fa-pets:purchasePet", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" } })
    exports["fa-ui"]:closeApplication("context")

    exports["fa-ui"]:openApplication("textbox", {
        callbackUrl = "fa-pets:purchasePetDone",
        key = data,
        items = {{icon = "paw", label = "Animal name", name = "name"}},
        show = true
    })
end)

RegisterUICallback("fa-pets:purchasePetDone", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" } })
    exports["fa-ui"]:closeApplication("textbox")

    local r = RPC.execute("fa-pets:purchasePet", data)
    if not r then return end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    for i, v in ipairs(PetshopConfig) do
        exports["fa-npcs"]:RegisterNPC(v["NPC"], "fa-companions")
        local group = { "isPetshopSeller" }

        local data = {
            {
                id = "petshop_" .. i,
                label = v["Label"],
                icon = "paw",
                event = "fa-companions:showPetshop",
                parameters = v,
            }
        }

        local options = {
            distance = { radius = 2.5 },
            -- isEnabled = function()
            --     return exports["isPed"]:isPed("myjob") == v["Job"]
            -- end
        }

        exports["fa-interact"]:AddPeekEntryByFlag(group, data, options)
    end
end)

RegisterCommand('pet', function(source, args, RawCommand)
    for i, v in ipairs(PetshopConfig) do
        TriggerEvent("fa-companions:showPetshop", v)
    end
end)