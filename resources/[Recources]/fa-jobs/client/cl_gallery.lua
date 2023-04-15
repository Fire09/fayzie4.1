RegisterNetEvent('gallery-menu')
AddEventHandler('gallery-menu', function()
    local isEmployed = exports["fa-business"]:IsEmployedAt("gallery")
    if isEmployed then
        local AGGem = {
            {
                title = "Mined Items",
                icon = "hard-hat"
            },
            {
                title = "Sell Diamond Gem",
                description = "Diamond",
                icon = "gem",
                action = 'gallery_diamond',
            },
            {
                title = "Sell Aquamarine Gem",
                description = "Aquamarine",
                icon = "gem",
                action = 'gallery_aquamarine',
            },
            {
                title = "Sell Jade Gem",
                description = "Jade",
                icon = "gem",
                action = 'gallery_jade',
            },
            {
                title = "Sell Citrine Gem",
                description = "Citrine",
                icon = "gem",
                action = 'gallery_citrine',
            },
            {
                title = "Sell Garnet Gem",
                description = "Garnet",
                icon = "gem",
                action = 'gallery_garnet',
            },
            {
                title = "Sell Opal Gem",
                description = "Opal",
                icon = "gem",
                action = 'gallery_opal',
            },
            {
                title = "Sell Ruby",
                description = "Ruby",
                icon = "gem",
                action = 'gallery_ruby',
            },
            {
                title = "Sell Starry Night",
                description = "Starry Night",
                icon = "paint-roller",
                action = 'gallery_night',
            },
            {
                title = "Sell Art",
                description = "Art",
                icon = "gem",
                action = 'gallery_art',
            },
            {
                title = "Sell Golden Coin",
                description = "Golden COin",
                icon = "coins",
                action = 'gallery_coin',
            },
            {
                title = "Sell Valuable Goods",
                description = "Valualble Goods",
                icon = "coins",
                action = 'gallery_vg',
            },
            {
                title = "Sell Gold Bars",
                description = "Gold Bars",
                icon = "coins",
                action = 'gallery_gb',
            },
            {
                title = "Sell Rolex Watch",
                description = "Rolex Watch",
                icon = "clock",
                action = 'gallery_rw',
            },
            {
                title = "Sell 8ct Chains",
                description = "8 Carat Chains",
                icon = "link",
                action = 'gallery_8ct',
            },
        }
        exports["fa-interface"]:showContextMenu(AGGem)
    end
end)

RegisterInterfaceCallback('gallery_diamond', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_diamonds')
end)

RegisterInterfaceCallback('gallery_aquamarine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_aquamarine')
end)

RegisterInterfaceCallback('gallery_jade', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_jade')
end)

RegisterInterfaceCallback('gallery_citrine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_citrine')
end)

RegisterInterfaceCallback('gallery_garnet', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_garnet')
end)

RegisterInterfaceCallback('gallery_opal', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_opal')
end)

RegisterInterfaceCallback('gallery_ruby', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_ruby')
end)

RegisterInterfaceCallback('gallery_night', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_night')
end)

RegisterInterfaceCallback('gallery_art', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gellery_sell_stolen_art')
end)

RegisterInterfaceCallback('gallery_coin', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gallery_sell_gold_coins')
end)

RegisterInterfaceCallback('gallery_vg', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gallery_sell_val_goods')
end)

RegisterInterfaceCallback('gallery_gb', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gallery_sell_gold_bars')
end)

RegisterInterfaceCallback('gallery_rw', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gallery_sell_rolex_watch')
end)

RegisterInterfaceCallback('gallery_8ct', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('fa-jobs:gallery_sell_8ct_chains')
end)

 --Sales

 --Mining Gem

RegisterNetEvent('fa-jobs:gellery_sell_diamonds')
AddEventHandler('fa-jobs:gellery_sell_diamonds', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryGem',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gems.",
            name = "pGemAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryGem', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
        local GemAmount = data.values.pGemAmount
        if exports['fa-inventory']:hasEnoughOfItem('mineddiamond', GemAmount) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*GemAmount, 'Selling Diamond Gems')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('mineddiamond', GemAmount) then
                TriggerEvent('inventory:removeItem', 'mineddiamond', GemAmount)
                TriggerServerEvent('fa-financials:business_money', 200*GemAmount, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. GemAmount .. " Diamond Gems for $" .. 200*GemAmount .. "!", 1)
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Stone

RegisterNetEvent('fa-jobs:gellery_sell_aquamarine')
AddEventHandler('fa-jobs:gellery_sell_aquamarine', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryStone',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Stones.",
            name = "pAquaAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryStone', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pAquaAmt = data.values.pAquaAmount

    if exports['fa-inventory']:hasEnoughOfItem('minedaquamarine', pAquaAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(250*pAquaAmt, 'Selling Aquamarine')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('minedaquamarine', pAquaAmt) then
                TriggerEvent('inventory:removeItem', 'minedaquamarine', pAquaAmt)
                TriggerServerEvent('fa-financials:business_money', 555*pAquaAmt, 'gallery', 'add')
                TriggerEvent("DoLongHudText", "You sold " .. pAquaAmt .. " Aquamarine for $" .. 555*pAquaAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Jade

RegisterNetEvent('fa-jobs:gellery_sell_jade')
AddEventHandler('fa-jobs:gellery_sell_jade', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryJade',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Jade\'s.",
            name = "pJadeAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryJade', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pJadeAmt = data.values.pJadeAmount

    if exports['fa-inventory']:hasEnoughOfItem('minedjade', pJadeAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pJadeAmt, 'Selling Mined Jade')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('minedjade', pJadeAmt) then
                TriggerEvent('inventory:removeItem', 'minedjade', pJadeAmt)
                TriggerServerEvent('fa-financials:business_money', 877*pJadeAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Citrine

RegisterNetEvent('fa-jobs:gellery_sell_citrine')
AddEventHandler('fa-jobs:gellery_sell_citrine', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryCitrine',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Citrine.",
            name = "pCitrineAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryCitrine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pCitrineAmt = data.values.pCitrineAmount
    if exports['fa-inventory']:hasEnoughOfItem('minedcitrine', pCitrineAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2500*pCitrineAmt, 'Selling Citrine')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('minedcitrine', pCitrineAmt) then
                TriggerEvent('inventory:removeItem', 'minedcitrine', pCitrineAmt)
                TriggerServerEvent('fa-financials:business_money', 1925*pCitrineAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pCitrineAmt .. " Citrine for $" .. 1925*pCitrineAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Garnet

RegisterNetEvent('fa-jobs:gellery_sell_garnet')
AddEventHandler('fa-jobs:gellery_sell_garnet', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryGarnet',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Garnet.",
            name = "pGarnetAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryGarnet', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGarnetAmt = data.values.pGarnetAmount
        if exports['fa-inventory']:hasEnoughOfItem('minedgarnet', pGarnetAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pGarnetAmt, 'Selling Garnet')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('minedgarnet', pGarnetAmt) then
                TriggerEvent('inventory:removeItem', 'minedgarnet', pGarnetAmt)
                TriggerServerEvent('fa-financials:business_money', 1650*pGarnetAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pGarnetAmt .. " Garnet for $" .. 1650*pGarnetAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

-- Mining Opal

RegisterNetEvent('fa-jobs:gellery_sell_opal')
AddEventHandler('fa-jobs:gellery_sell_opal', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryOpal',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Opal.",
            name = "pOpalAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryOpal', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pOpalAmt = data.values.pOpalAmount
        if exports['fa-inventory']:hasEnoughOfItem('minedopal', pOpalAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
        local finished = exports['fa-taskbar']:taskBar(2000*pOpalAmt, 'Selling Opal')
        if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('minedopal', pOpalAmt) then
                TriggerEvent('inventory:removeItem', 'minedopal', pOpalAmt)
                TriggerServerEvent('fa-financials:business_money', 580*pOpalAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pOpalAmt .. " Opal for $" .. 580*pOpalAmt .. "!", 1)
                FreezeEntityPosition(PlayerPedId(), false)
            end
        else
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
        end
    end
end)

 --Stolen Art

RegisterNetEvent('fa-jobs:gellery_sell_stolen_art')
AddEventHandler('fa-jobs:gellery_sell_stolen_art', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryArt',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Art Pieces.",
            name = "pArtAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryArt', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pArtAmt = data.values.pArtAmount
        if exports['fa-inventory']:hasEnoughOfItem('stolenart', pArtAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pArtAmt, 'Selling Art Pieces')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('stolenart', pArtAmt) then
                TriggerEvent('inventory:removeItem', 'stolenart', pArtAmt)
                TriggerServerEvent('fa-financials:business_money', 1500*pArtAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pArtAmt .. " Art Pieces for $" .. 1500*pArtAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Golden Coins

RegisterNetEvent('fa-jobs:gallery_sell_gold_coins')
AddEventHandler('fa-jobs:gallery_sell_gold_coins', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryGoldcoin',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gold Coin\'s.",
            name = "pGoldCoinAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryGoldcoin', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGoldCointAmt = data.values.pGoldCoinAmount
        if exports['fa-inventory']:hasEnoughOfItem('goldcoin', pGoldCointAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pGoldCointAmt, 'Selling Golden Coins')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('goldcoin', pGoldCointAmt) then
                TriggerEvent('inventory:removeItem', 'goldcoin', pGoldCointAmt)
                TriggerServerEvent('fa-financials:business_money', 85*pGoldCointAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pGoldCointAmt .. " Golden Coins for $" .. 85*pGoldCointAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Valuable Goods

RegisterNetEvent('fa-jobs:gallery_sell_val_goods')
AddEventHandler('fa-jobs:gallery_sell_val_goods', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryVG',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Valuable Good\'s.",
            name = "pVGAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryVG', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pVGAmt = data.values.pVGAmount
        if exports['fa-inventory']:hasEnoughOfItem('valuablegoods', pVGAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pVGAmt, 'Selling Valuable Goods')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('valuablegoods', pVGAmt) then
                TriggerEvent('inventory:removeItem', 'valuablegoods', pVGAmt)
                TriggerServerEvent('fa-financials:business_money', 352*pVGAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pVGAmt .. " Valuable Goods for $" .. 352*pVGAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end 
end)

 --Golden Bars

RegisterNetEvent('fa-jobs:gallery_sell_gold_bars')
AddEventHandler('fa-jobs:gallery_sell_gold_bars', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryGoldBar',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gold Bar\'s.",
            name = "pGoldAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryGoldBar', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGoldAmt = data.values.pGoldAmount
    if exports['fa-inventory']:hasEnoughOfItem('goldbar', pGoldAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pGoldAmt, 'Selling Valuable Goods')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('goldbar', pGoldAmt) then
                TriggerEvent('inventory:removeItem', 'goldbar', pGoldAmt)
                TriggerServerEvent('fa-financials:business_money', 2000*pGoldAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pGoldAmt .. " Gold Bars for $" .. 2000*pGoldAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

 --Rolex Watch

RegisterNetEvent('fa-jobs:gallery_sell_rolex_watch')
AddEventHandler('fa-jobs:gallery_sell_rolex_watch', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryRolexWatch',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Rolex Watch\'s.",
            name = "pRolexAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryRolexWatch', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pRolexAmt = data.values.pRolexAmount
    if exports['fa-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pRolexAmt, 'Selling Rolex Watche\'s')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmt) then
                TriggerEvent('inventory:removeItem', 'rolexwatch', pRolexAmt)
                TriggerServerEvent('fa-financials:business_money', 114*pRolexAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHuDText", "You Sold " .. pRolexAmt .. " Rolex Watche\'s For $" .. 114*pRolexAmt .. "!", 1)
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --8CT Chains

RegisterNetEvent('fa-jobs:gallery_sell_8ct_chains')
AddEventHandler('fa-jobs:gallery_sell_8ct_chains', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:gallery8Ct',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many 8 CT Chain\'s.",
            name = "p8ctAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:gallery8Ct', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local p8CTAmt = data.values.p8ctAmount
    if exports['fa-inventory']:hasEnoughOfItem('stolen8ctchain', p8CTAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*p8CTAmt, 'Selling Ruby\'s')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('stolen8ctchain', p8CTAmt) then
                TriggerEvent('inventory:removeItem', 'stolen8ctchain', p8CTAmt)
                TriggerServerEvent('fa-financials:business_money', 25*p8CTAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. p8CTAmt .. " 8 Carat Chains for $" .. 25*p8CTAmt .. "")
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Ruby

 --Mining Ruby

RegisterNetEvent('fa-jobs:gellery_sell_ruby')
AddEventHandler('fa-jobs:gellery_sell_ruby', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryRuby',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Ruby\'s.",
            name = "pRubyAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryRuby', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pRubyAmt = data.values.pRubyAmount
    if exports['fa-inventory']:hasEnoughOfItem('miningruby', pRubyAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pRubyAmt, 'Selling Ruby\'s')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('miningruby', pRubyAmt) then
                TriggerEvent('inventory:removeItem', 'miningruby', pRubyAmt)
                TriggerServerEvent('fa-financials:business_money', 100*pRubyAmt, 'gallery', 'add')
                TriggerEvent("DoLongHudText", "You sold " .. pRubyAmt .. " Ruby\'s for $" .. 100*pRubyAmt .. "!", 1)
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Starry Night

RegisterNetEvent('fa-jobs:gellery_sell_night')
AddEventHandler('fa-jobs:gellery_sell_night', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-jobs:galleryNight',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Starry Night\'s.",
            name = "pStarryAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-jobs:galleryNight', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pStarryAmt = data.values.pStarryAmount 
    if exports['fa-inventory']:hasEnoughOfItem('starrynight', pStarryAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['fa-taskbar']:taskBar(2000*pStarryAmt, 'Selling Starry Night')
         if finished == 100 then
            if exports['fa-inventory']:hasEnoughOfItem('starrynight', pStarryAmt) then
                TriggerEvent('inventory:removeItem', 'starrynight', pStarryAmt)
                TriggerServerEvent('fa-financials:business_money', 550*pStarryAmt, 'gallery', 'add') 
                TriggerEvent("DoLongHudText", "You sold " .. pStarryAmt .. " Starry Night for $" .. 550*pStarryAmt, 1)
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

 --// Eye // 

exports["fa-polytarget"]:AddBoxZone("artgallerysell", vector3(-466.86, 46.12, 46.23), 1, 1, {
    heading=43,
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("artgallerysell", {
    {
        event = "gallery-menu",
        id = "pTable3322233",
        icon = "circle",
        label = "Sell Gems",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});