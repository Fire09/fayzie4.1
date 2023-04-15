RPC.register("fa-restaurants:getFoodItems", function(pSource, pBiz)
    return BUSINESSES[pBiz].foodItems
end)

RPC.register("fa-restaurants:fetchMenu", function(pSource, pBiz)
    return BUSINESSES[pBiz].menu
end)

RPC.register("fa-restaurants:createFoodItem", function(pSource, pData)
    local pRestaurant = pData.key.restaurant
    local pFoodType = pData.key.food_type
    local pItemData = pData.values
    local currentFoodItems = BUSINESSES[pRestaurant].foodItems
    local pFoodIngredients = {}
    local nextId = #currentFoodItems + 1
    for i = 1, 5 do
        if pItemData["ingredient_type_" .. i] ~= nil then
            pFoodIngredients[#pFoodIngredients + 1] = pItemData["ingredient_type_" .. i]
        end
    end
    if (pFoodIngredients == nil) then
        TriggerClientEvent("DoLongHudText", pSource, "You must select at least one ingredient type.", 2)
        return
    end
    local newFoodItem = {
        id = nextId,
        name = pItemData.name,
        description = pItemData.description,
        food_type = pFoodType,
        image_url = pItemData.image_url,
        restaurant = pRestaurant,
        data = json.encode({ingredients = pFoodIngredients})
    }

    if (currentFoodItems == nil) then
        currentFoodItems = {}
    end

    currentFoodItems[nextId] = newFoodItem

    local query = "UPDATE _restaurants SET foodItems = ? WHERE code = ? LIMIT 1"
    local queryData = Await(SQL.execute(query, json.encode(currentFoodItems), pRestaurant))

    TriggerClientEvent("fa-restaurants:changedFoodItems", -1, pRestaurant)
    return true
end)

RPC.register("fa-restaurants:deleteFoodItem", function(pSource, pItemId, pRestaurant)
    local pRestaurantData = BUSINESSES[pRestaurant]
    local pFoodItems = pRestaurantData.foodItems
    
    if (pFoodItems[pItemId] == nil) then
        TriggerClientEvent("DoLongHudText", pSource, "This food item does not exist.", 2)
        return
    end

    pFoodItems[pItemId] = nil

    local query = "UPDATE _restaurants SET foodItems = ? WHERE code = ? LIMIT 1"
    local queryData = Await(SQL.execute(query, json.encode(pFoodItems), pRestaurant))

    TriggerClientEvent("fa-restaurants:changedFoodItems", -1, pRestaurant)
    return true
end)

RPC.register("fa-restaurants:setMenu", function(pSource, pBiz, pDishes)
    BUSINESSES[pBiz].menu = pDishes

    local query = "UPDATE _restaurants SET menu = ? WHERE code = ? LIMIT 1"
    local queryData = Await(SQL.execute(query, json.encode(pDishes), pBiz))

    TriggerClientEvent("fa-restaurants:changedMenuItems", -1, pBiz)
    return true
end)
