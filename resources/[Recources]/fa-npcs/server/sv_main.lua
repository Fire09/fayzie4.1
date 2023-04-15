RegisterServerEvent("fa-npcs:location:fetch")
AddEventHandler("fa-npcs:location:fetch",function()
    local src = source
    for k,v in pairs(Generic.ShopKeeperLocations) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "shopkeeper_"..k,
            name = "Shop Keeper "..k,
            pedType = 4,
            model = "mp_m_shopkeep_01",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isShopKeeper'] = true
            }
        } )
    end
    
    for k,v in pairs(Generic.WeaponShopLocations) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "weaponShopKeeper_"..k,
            name = "Weapon Shop Keeper "..k,
            pedType = 4,
            model = "s_m_y_ammucity_01",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isWeaponShopKeeper'] = true
            }
        })
    end

    for k,v in pairs(Generic.ToolShopLocations) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "toolsShopKeeper_"..k,
            name = "Tools Shop Keeper "..k,
            pedType = 4,
            model = "s_m_m_lathandy_01",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isToolShopKeeper'] = true
            }
        })
    end

    for k,v in pairs(Generic.CasinoLocations) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "CasinoPeds2_"..k,
            name = "Casino2 "..k,
            pedType = 4,
            model = "s_m_y_casino_01",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isToolShopKeeper'] = false
            }
        })
    end
    
    for k,v in pairs(Generic.CasinoLocations2) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "CasinoPeds_"..k,
            name = "Casino "..k,
            pedType = 4,
            model = "s_f_y_casino_01",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isToolShopKeeper'] = false
            }
        })
    end

    -- for k,v in pairs(Generic.ApartmentUpgrade) do
    --     table.insert( Generic.NPCS, #Generic.NPCS + 1, {
    --         id = "apartupgradeKeeper_"..k,
    --         name = "Apart Upgrade Keeper "..k,
    --         pedType = 4,
    --         model = "a_f_y_business_01",
    --         networked = false,
    --         distance = 25.0,
    --         position = {
    --             coords = vector3(v[1], v[2], v[3]),
    --             heading = v[4],
    --             random = false
    --         },
    --         appearance = nil,
    --         settings = {
    --             { mode = "invincible", active = true },
    --             { mode = "ignore", active = true },
    --             { mode = "freeze", active = true },
    --         },
    --         flags = {
    --             ['isNPC'] = true,
    --             ['isApartmentUpgradeKeeper'] = true
    --         }
    --     })
    -- end

    for k,v in pairs(Generic.SportShopLocations) do
        table.insert( Generic.NPCS, #Generic.NPCS + 1, {
            id = "huntingShopKeeper_"..k,
            name = "Hunting Shop Keeper "..k,
            pedType = 4,
            model = "csb_cletus",
            networked = false,
            distance = 25.0,
            position = {
                coords = vector3(v[1], v[2], v[3]),
                heading = v[4],
                random = false
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ['isNPC'] = true,
                ['isHuntingStore'] = true
            }
        })
    end
    TriggerClientEvent("fa-npcs:set:ped", src, Generic.NPCS)
end)