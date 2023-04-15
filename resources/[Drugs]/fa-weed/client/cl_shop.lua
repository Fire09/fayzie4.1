-- Citizen.CreateThread(function()
--     Citizen.Wait(1000)

--     exports["fa-npcs"]:RegisterNPC({
--         id = "weed_shop",
--         name = "Smoke on the Water",
--         pedType = 4,
--         model = "a_f_y_hippie_01",
--         networked = false,
--         distance = 50.0,
--         position = {
--             coords = vector3(-1171.17, -1571.09, 3.67),
--             heading = 120.0,
--             random = false,
--         },
--         appearance = nil,
--         settings = {
--             { mode = "invincible", active = true },
--             { mode = "ignore", active = true },
--             { mode = "freeze", active = true },
--         },
--         flags = {
--             ["isNPC"] = true,
--             ["isWeedShopKeeper"] = true,
--         },
--         scenario = "WORLD_HUMAN_SMOKING_POT",
--     })


--     local group = { "isWeedShopKeeper" }

--     local data = {
--         {
--             id = "weed_shop",
--             label = "Smoke on the Water",
--             icon = "cannabis",
--             event = "fa-weed:shop",
--             parameters = {},
--         }
--     }

--     local options = {
--         distance = { radius = 2.5 }
--     }

--     exports["fa-interact"]:AddPeekEntryByFlag(group, data, options)
-- end)

-- AddEventHandler("fa-weed:shop", function()
--     TriggerEvent("server-inventory-open", "420", "Shop")
-- end)

