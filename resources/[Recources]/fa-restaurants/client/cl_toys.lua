AddEventHandler('fa-restaurants:manageToyMenu', function(pParams, pEntity, pContext)
    local restaurant = pParams.isEditorPeek and exports["fa-housing"]:getCurrentPropertyID() or pContext.zones["restaurant_manage_food_menu"].id
    local hasCraftAccess = exports["fa-business"]:HasPermission(restaurant, "craft_access")
    if not hasCraftAccess and not pParams.isEditorPeek then
      TriggerEvent("DoLongHudText", "You are not recognized here.", 2)
      return
    end
    local currentToys = RPC.execute('fa-restaurants:getCustomToys', restaurant)

    local context = {
        {
            title = 'Add New Toy',
            icon = 'fas fa-plus',
            action = 'fa-restuarants:createToy',
            key = restaurant
        }
    }

    for _,toy in ipairs(currentToys) do
        context[#context+1] = {
            title = toy.name,
            description = toy.description,
            image = toy.image_url_pre,
            children = {
                {
                    title = 'Delete',
                    icon = 'fas fa-trash',
                    action = 'fa-restuarants:removeToy',
                    key = {
                        restaurant = restaurant,
                        id = toy.id
                    },
                },
            },
        }
    end

    exports['fa-ui']:showContextMenu(context)
end)

RegisterUICallback("fa-restuarants:createToy", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    Wait(0)

    local prompt = exports['fa-ui']:OpenInputMenu({
        {
            label = 'Name',
            name = 'name',
            icon = 'fas fa-pencil-alt',
        },
        {
            label = 'Description',
            name = 'description',
            icon = 'fas fa-pencil-alt',
        },
        {
            label = 'Wrapped Image URL',
            name = 'image_url_pre',
            icon = 'fas fa-link',
        },
        {
            label = 'Unwrapped Image URL',
            name = 'image_url_post',
            icon = 'fas fa-unlink',
        }
    }, function(values)
        return values.name and values.description and values.image_url_pre and values.image_url_post
    end)

    if not prompt then
        return
    end
    
    local result = RPC.execute('fa-restaurants:createToyItem', data.key, prompt)
    if not result then
        TriggerEvent('DoLongHudText', 'Failed to create toy item', 2)
        return
    end
    TriggerEvent('DoLongHudText', 'Created toy item')
end)

RegisterUICallback("fa-restuarants:removeToy", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local result = RPC.execute('fa-restaurants:removeToyItem', data.key.restaurant, data.key.id)
    if not result then
        TriggerEvent('DoLongHudText', 'Failed to remove toy item', 2)
        return
    end
    TriggerEvent('DoLongHudText', 'Removed toy item')
end)

AddEventHandler('fa-restaurants:getCustomToyItem', function(pParameters, pEntity, pContext)
    local restaurant = pContext.zones['restaurant_takeout'].restaurant
    local toys = RPC.execute('fa-restaurants:getCustomToys', restaurant)

    local options = {}
    for _, toy in pairs(toys) do
        options[#options+1] = {
            name = toy.name,
            id = toy.id,
        }
    end

    local prompt = exports['fa-ui']:OpenInputMenu({
        {
            label = 'Select Toy',
            name = 'toy',
            _type = 'select',
            options = options,
        },
        {
            label = 'Enter Amount',
            name = 'amount',
            icon = 'fas fa-pencil-alt',
            maxLength = 2,
        }
    }, function(values)
        return values.toy and tonumber(values.amount) and values.amount:len() > 0 and values.amount:len() < 99
    end)

    if not prompt then
        return
    end

    local toy
    for _, t in pairs(toys) do
        if t.id == prompt.toy then
            toy = t
            break
        end
    end
    local amount = tonumber(prompt.amount)

    TriggerEvent('player:receiveItem', 'customtoyitem', amount,  false,
        {
            _factory = true,
            _name = toy.name,
            _description = toy.description,
            _image_url = toy.image_url_pre,
            _image_url_post = toy.image_url_post,
            _progress_length = 1000,
            _progress_text = 'Unwrapping...',
            _hideKeys = {'_image_url_post', '_progress_length', '_progress_text'},
        },
        {}
    );
end)
