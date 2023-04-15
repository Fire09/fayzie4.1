RegisterNetEvent('raid_clothes:outfits')
AddEventHandler('raid_clothes:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("raid_clothes:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit",pId)
    elseif pAction == 3 then 
        --TriggerEvent("hud:saveCurrentMeta")
        TriggerEvent('item:deleteClothesDna')
        TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", pId)
    else
        TriggerServerEvent("raid_clothes:list_outfits")
    end
end)

RegisterInterfaceCallback("fa-ui:raid_clothes:addOutfitPrompt", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    Wait(1) --wait to fix ui bug?
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-ui:raid_clothes:addOutfit',
        key = 1,
        items = {
            {
                icon = "pencil-alt",
                label = "Outfit Number [ID]",
                name = "outfitSlot",
            },
            {
                icon = "pencil-alt",
                label = "Outfit Name",
                name = "outfitName",
            },
        },
        show = true, 
    })
end)

RegisterInterfaceCallback("fa-ui:raid_clothes:addOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local outfitSlot = data.values.outfitSlot
    local outfitName = data.values.outfitName
    if outfitName == nil then outfitName = "Outfit" end
    
    TriggerServerEvent("raid_clothes:set_outfit", outfitSlot, outfitName, GetCurrentPed())
end)

RegisterInterfaceCallback("fa-ui:raid_clothes:changeOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    TriggerEvent('hotel:outfit', { true, data.key }, 3)
    --exports["fa-interface"]:hideContextMenu() 
end)

RegisterInterfaceCallback("fa-ui:raid_clothes:deleteOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    TriggerEvent('hotel:outfit', { true, data.key }, 2)
    --exports["fa-interface"]:hideContextMenu()   
end)

RegisterNetEvent('raid_clothes:ListOutfits')
AddEventHandler('raid_clothes:ListOutfits', function(skincheck)
    local menuData = {}
    local takenSlots = {}
    for i = 1, #skincheck do
        local slot = tonumber(skincheck[i].slot)
        takenSlots[slot] = true
        menuData[#menuData + 1] = {
            title = slot .. " | " .. skincheck[i].name,
            description = '',
            key = slot,
            children = {
                { title = "Change Outfit", action = "fa-ui:raid_clothes:changeOutfit", key = slot},
                { title = "Delete Outfit", action = "fa-ui:raid_clothes:deleteOutfit", key = slot},
            }
        }
    end
    if #menuData >= 0 then
        if #menuData < 20 then
            --Find first empty slot
            local emptySlot = -1
            for i=1,10 do
                if emptySlot == -1 and takenSlots[i] == nil then
                    emptySlot = i
                end
            end
            menuData[#menuData + 1] = {
                title = "Save Current Outfit",
                description = '',
                key = emptySlot,
                action = "fa-ui:raid_clothes:addOutfitPrompt"
            }
        end
        exports['fa-interface']:showContextMenu(menuData)
    else
        TriggerEvent("DoLongHudText", "No saved outfits", 2)
    end
end)