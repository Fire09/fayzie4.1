function getIngredientOptions(num)
  return {
    icon = "circle",
    label = "Ingredient Type " .. num,
    name = "ingredient_type_" .. num,
    _type = "select",
    options = {
      {
        id = "oil",
        name = "Oil",
      },
      {
        id = "protein",
        name = "Protein",
      },
      {
        id = "vegetables",
        name = "Vegetables",
      },
      {
        id = "leavening",
        name = "Leavening",
      },
      {
        id = "dairy",
        name = "Dairy",
      },
      {
        id = "grain",
        name = "Grain",
      },
      {
        id = "seasoning",
        name = "Seasoning",
      },
      {
        id = "sugar",
        name = "Sugar",
      },
    }
  }
end

function manageFood(restaurant, foodType)
  local items = {
    {
      icon = "circle",
      label = "Name",
      name = "name",
    },
    {
      icon = "circle",
      label = "Description",
      name = "description",
    },
    {
      icon = "circle",
      label = "Image URL (100px x 100px)",
      name = "image_url",
    },
    getIngredientOptions(1),
  }
  if foodType == "main" then
    items[#items + 1] = getIngredientOptions(2)
    items[#items + 1] = getIngredientOptions(3)
    items[#items + 1] = getIngredientOptions(4)
    items[#items + 1] = getIngredientOptions(5)
  end
  exports['fa-ui']:openApplication('textbox', {
    callbackUrl = 'fa-ui:restaurants:createFood',
    key = { restaurant = restaurant, food_type = foodType },
    items = items,
    show = true,
  })
end

RegisterUICallback("fa-ui:restaurants:createFood", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  exports['fa-ui']:closeApplication('textbox')
  RPC.execute('fa-restaurants:createFoodItem', data)
end)

RegisterUICallback("fa-ui:restaurants:createMenuItem", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  Wait(100)
  manageFood(data.key.restaurant, data.key.foodType)
end)

RegisterUICallback("fa-ui:restaurants:manageFoodItem", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  Wait(100)
  if data.key.action == "delete" then
    RPC.execute("fa-restaurants:deleteFoodItem", data.key.id, data.key.restaurant)
    return
  end
end)

AddEventHandler("fa-restaurants:manageFoodMenu", function(pParams, p2, pContext)
  local restaurant = pParams.isEditorPeek and exports["fa-housing"]:getCurrentPropertyID() or pContext.zones["restaurant_manage_food_menu"].id

  local jobAccess = pParams.isEditorPeek and {} or pContext.zones["restaurant_manage_food_menu"].jobs
  local hasJobAccess = false
  if jobAccess then
    local curJob = exports['isPed']:isPed('myjob')
    for _,job in ipairs(jobAccess) do
      if curJob == job then
        hasJobAccess = true
        break
      end
    end
  end

  local hasCraftAccess = exports["fa-business"]:HasPermission(restaurant, "craft_access")
  if not hasCraftAccess and not hasJobAccess then
    TriggerEvent("DoLongHudText", "You are not recognized here.", 2)
    return
  end
  local contextMenu = {
    {
      title = "Menu Management",
      icon = "hamburger",
    },
    {
      title = "Create New Item",
      icon = "file",
      children = {
        {
          title = "Main Dish",
          icon = "hamburger",
          key = { foodType = "main", restaurant = restaurant },
          action = "fa-ui:restaurants:createMenuItem",
        },
        {
          title = "Side Dish",
          icon = "bacon",
          key = { foodType = "side", restaurant = restaurant },
          action = "fa-ui:restaurants:createMenuItem",
        },
        {
          title = "Dessert",
          icon = "ice-cream",
          key = { foodType = "dessert", restaurant = restaurant },
          action = "fa-ui:restaurants:createMenuItem",
        },
        {
          title = "Drink",
          icon = "coffee",
          key = { foodType = "drink", restaurant = restaurant },
          action = "fa-ui:restaurants:createMenuItem",
        },
      },
    },
    {
      title = "Dishes",
      icon = "utensils",
    },
  }
  local foodItems = FoodItems.get(restaurant)
  if not foodItems then
    foodItems = {}
  end
  local dishes = { main = {}, side = {}, dessert = {}, drink = {} }
  for _, item in pairs(foodItems) do
    local desc = ""
    for _, ingred in pairs(json.decode(item.data)["ingredients"]) do
      desc = desc .. ingred .. ","
    end
    desc = desc:sub(1, -2)
    dishes[item.food_type][#dishes[item.food_type] + 1] = {
      title = item.name,
      description = item.description .. "(" .. desc .. ")",
      image = item.image_url,
      children = {
        {
          i18nTitle = true,
          title = "Delete Item",
          icon = "trash",
          key = { action = "delete", id = item.id, restaurant = restaurant },
          action = "fa-ui:restaurants:manageFoodItem",
        },
      },
    }
  end
  for k, v in pairs(dishes) do
    if #v > 0 then
      contextMenu[#contextMenu + 1] = {
        title = "Manage " .. k .. " dishes",
        icon = "tasks",
        children = v,
      }
    end
  end
  exports["fa-ui"]:showContextMenu(contextMenu)
end)

AddEventHandler("fa-restaurants:manageDailyMenu", function(pParams, p2, pContext)
  local restaurant = pParams.isEditorPeek and exports["fa-housing"]:getCurrentPropertyID() or pContext.zones["restaurant_manage_food_menu"].id

  local jobAccess = pParams.isEditorPeek and {} or pContext.zones["restaurant_manage_food_menu"].jobs
  local hasJobAccess = false
  if jobAccess then
    local curJob = exports['isPed']:isPed('myjob')
    for _,job in ipairs(jobAccess) do
      if curJob == job then
        hasJobAccess = true
        break
      end
    end
  end

  local hasCraftAccess = exports["fa-business"]:HasPermission(restaurant, "craft_access")
  if not hasCraftAccess and not hasJobAccess then
    TriggerEvent("DoLongHudText", "You are not recognized here.", 2)
    return
  end

  -- Get all main dishes
  local foodItems = getFoodItemsOfType(restaurant, "main")

  local foodElements = {}
  for _,item in pairs(foodItems) do
    foodElements[#foodElements + 1] = {
      id = item.id,
      name = item.name,
    }
  end

  local elements = {
    {
      label = "Select Main Dish 1",
      name = "dish1",
      _type = "select",
      icon = "fas fa-list-alt",
      options = foodElements,
    },
    {
      label = "Select Main Dish 2",
      name = "dish2",
      _type = "select",
      icon = "fas fa-list-alt",
      options = foodElements,
    },
    {
      label = "Select Main Dish 3",
      name = "dish3",
      _type = "select",
      icon = "fas fa-list-alt",
      options = foodElements,
    },
    {
      label = "Select Main Dish 4",
      name = "dish4",
      _type = "select",
      icon = "fas fa-list-alt",
      options = foodElements,
    },
    {
      label = "Select Main Dish 5",
      name = "dish5",
      _type = "select",
      icon = "fas fa-list-alt",
      options = foodElements,
    }
  }

  local prompt = exports["fa-ui"]:OpenInputMenu(elements)
  if not prompt then return end

  local dishes = { prompt.dish1, prompt.dish2, prompt.dish3, prompt.dish4, prompt.dish5 }
  RPC.execute("fa-restaurants:setMenu", restaurant, dishes)
end)