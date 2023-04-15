local isCop = false
local isJudge = false

RegisterCommand("creationmenu", function()
	local employed = RPC.execute("IsEmployedAt", "ace_industries")
	local hasPerm = RPC.execute("fa-business:hasPermission", "ace_industries", "craft_access")
	
	if employed and hasPerm then
		TriggerEvent("fa-business:stash:creationMenu")
	end
end)

RegisterNetEvent("fa-jobmanager:playerBecameJob")
AddEventHandler("fa-jobmanager:playerBecameJob", function(job, name, notify)
    if isCop and job ~= "police" then isCop = false end
    if job == "police" then isCop = true end
end)

RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

local hasPdAuthCode = nil
RegisterInterfaceCallback("fa-business:stash:enteredAuthCode", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  exports["fa-interface"]:closeApplication("textbox")
  hasPdAuthCode = true
end)
AddEventHandler("fa-interface:application-closed", function(name)
  if name ~= "textbox" then return end
  hasPdAuthCode = false
end)
function getPDAuthCode()
  hasPdAuthCode = nil
  exports["fa-interface"]:openApplication("textbox", {
    callbackUrl = "fa-business:stash:enteredAuthCode",
    key = "",
    items = {
      { label = "Auth Code", name = "password", _type = "password" },
    },
    show = true,
  })
  while hasPdAuthCode == nil do
    Wait(1000)
  end
  return hasPdAuthCode
end


function openInventory(type, data)
  local biz = data.biz and data.biz or data.id
  if type == "stash" then
    local success = RPC.execute("fa-business:hasPermission", biz, "stash_access")
    if not success and isPD() then
      success = getPDAuthCode()
    end
    if (not success) and data.cids then
      local cid = exports["isPed"]:isPed("cid")
      success = data.cids[cid]
    end
    if success then
      local prefix = "biz"
      if data.isLarge then
        prefix = "bizlarge"
      end
      TriggerEvent("server-inventory-open", "1", string.format("%s-%s", prefix, data.id), data.invSize, data.invSlots)
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  elseif type == "craft" then
    local success = RPC.execute("fa-business:hasPermission", biz, "craft_access")
    if not success and isPD() then
      success = getPDAuthCode()
    end
    if success then
      if biz == "digital_den" then
        TriggerEvent("server-inventory-open", "42072", "Craft")
        return
      elseif biz == "tuner" then
        TriggerEvent("server-inventory-open", "42090", "Craft")
        return
      elseif biz == "sionis" then
        TriggerEvent("server-inventory-open", "47", "Craft")
        return
      end
      --Hayes/Harmony crafting
      local invId = "42"
      if data.inventory then
        invId = data.inventory
      end
      TriggerEvent("server-inventory-open", invId, "Craft")
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  elseif type == "storage" then
    OpenSelfStorageMenu(data)
  else
    TriggerEvent("DoLongHudText", "Nothing found", 2)
  end
end

local listening = false
local function listenForKeypress(type, data)
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              exports["fa-interface"]:hideInteraction()
              openInventory(string.lower(type), data)
          end
          Wait(0)
      end
  end)
end

function enterPoly(name, data)
  listenForKeypress(name, data)
  exports["fa-interface"]:showInteraction("[E] " .. name)
end

function leavePoly(name, data)
  listening = false
  exports["fa-interface"]:hideInteraction()
end

function isPD()
  local job = exports["fa-base"]:getModule("LocalPlayer"):getVar("job")

  return job == "police" or job == "district attorney"
end

AddEventHandler("fa-polyzone:enter", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    enterPoly(name == "business_stash" and "Stash" or "Craft", data)
  end
  -- if name == "secure_storage_unit" then
  --   enterPoly("storage", data)
  -- end
end)

AddEventHandler("fa-polyzone:exit", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    leavePoly(name == "business_stash" and "Stash" or "Craft", data)
  end
  -- if name == "secure_storage_unit" then
  --   leavePoly("storage", data)
  -- end
end)

-- New Business Stash Stuff
local validStorageProp = {
  ["prop_cabinet_02b"] = true,
  ["prop_toolchest_05"] = true,
  ["prop_container_ld_pu"] = true,
  ["p_cs_locker_01_s"] = true,
  ["p_v_43_safe_s"] = true,
  ["p_pharm_unit_01"] = true,
  ["prop_devin_box_closed"] = true,
  ["prop_tool_box_07"] = true,
  ["ba_prop_battle_crate_art_02_bc"] = true,
  ["v_med_cooler"] = true,
  ["h4_prop_h4_chest_01a2"] = true,
  ["np_prop_small_mail_a"] = true,
}

local businessStashProps = {
  GetHashKey("prop_cabinet_02b"),
  GetHashKey("prop_toolchest_05"),
  GetHashKey("prop_container_ld_pu"),
  GetHashKey("p_cs_locker_01_s"),
  GetHashKey("p_v_43_safe_s"),
  GetHashKey("p_pharm_unit_01"),
  GetHashKey("prop_devin_box_closed"),
  GetHashKey("prop_tool_box_07"),
  GetHashKey("ba_prop_battle_crate_art_02_bc"),
  GetHashKey("v_med_cooler"),
  GetHashKey("h4_prop_h4_chest_01a2"),
  GetHashKey("np_prop_small_mail_a"),
}

local creationMenu = {
  key = 1,
  show = true,
  callbackUrl = "fa-business:client:createStash",
  items = { }
}

Citizen.CreateThread(function()
  exports["fa-interact"]:AddPeekEntryByModel(businessStashProps, {
    {
      id = "business_stash",
      event = "fa-business:client:openStash",
      icon = "archive",
      label = "Open Storage",
    },
  }, 
  { 
    distance = { radius = 2.5 },
    isEnabled = function(pEntity)
      local objInfo = exports["fa-objects"]:GetObjectByEntity(pEntity)
      return objInfo ~= nil
    end
  })
  exports["fa-interact"]:AddPeekEntryByModel(businessStashProps, {
    {
      id = "business_stash_remove",
      event = "fa-business:client:removeStash",
      icon = "trash",
      label = "Remove Storage",
    },
    {
      id = "business_stash_update",
      event = "fa-business:client:changeStashModel",
      icon = "archive",
      label = "Change Unit Model",
    },
  }, 
  { 
    distance = { radius = 2.5 },
    isEnabled = function(pEntity, pContext)
      local objInfo = exports["fa-objects"]:GetObjectByEntity(pEntity)
      local cid = exports["isPed"]:isPed("cid")
      return objInfo ~= nil and IsEmployedAt("ace_industries") and HasPermission("ace_industries", "craft_access")
    end
  })
end)

RegisterNetEvent("fa-business:stash:creationMenu")
AddEventHandler("fa-business:stash:creationMenu", function ()
  local success, businesses = RPC.execute("GetBusinesses")
  
  if not success then
    return TriggerEvent("DoLongHudText", "Error while fetching businesses", 2)
  end

  local businessOptions = {}
  for _, business in pairs(businesses) do
    businessOptions[#businessOptions+1] = {
      name = business.business_name,
      id = business.business_id
    }
  end

  local unitOptions = {
    {
      name = "prop_cabinet_02b",
      id = "prop_cabinet_02b"
    },
    {
      name = "prop_toolchest_05",
      id = "prop_toolchest_05"
    },
    {
      name = "prop_container_ld_pu",
      id = "prop_container_ld_pu"
    },
    {
      name = "p_cs_locker_01_s",
      id = "p_cs_locker_01_s"
    },
    {
      name = "p_v_43_safe_s",
      id = "p_v_43_safe_s"
    },
    {
      name = "p_pharm_unit_01",
      id = "p_pharm_unit_01"
    },
    {
      name = "prop_devin_box_closed",
      id = "prop_devin_box_closed"
    },
    {
      name = "prop_tool_box_07",
      id = "prop_tool_box_07"
    },
    {
      name = "ba_prop_battle_crate_art_02_bc",
      id = "ba_prop_battle_crate_art_02_bc"
    },
    {
      name = "v_med_cooler",
      id = "v_med_cooler"
    },
    {
      name = "h4_prop_h4_chest_01a2",
      id = "h4_prop_h4_chest_01a2"
    },
  }

  creationMenu.items = {
    { icon = "id-card", _type = "select", name = "businessCode", label = "Select Business", options = businessOptions },
    { icon = "boxes", label = "Storage Size (biz, bizLarge)", name = "storageSize" },
    { icon = "object-ungroup", _type = "select", label = "Unit Model (optional)", name = "stashProp", options = unitOptions },
    { icon = "weight", label = "Storage Weight (optional)", name = "storageWeight" },
    { icon = "th", label = "Storage Slots (optional)", name = "storageSlots" }
  }

  exports["fa-interface"]:openApplication("textbox", creationMenu)
end)

AddEventHandler("fa-business:client:removeStash", function (pData, pEntity)
  local objInfo = exports["fa-objects"]:GetObjectByEntity(pEntity)
  if objInfo == nil then return end

	TriggerEvent("animation:PlayAnimation", "hammering")

  local finished = exports["fa-taskbar"]:taskBar(15000, "Destroying Storage")
  ClearPedTasks(PlayerPedId())
  if finished ~= 100 then return end

  local deleted = exports["fa-objects"]:DelObject(objInfo.id)
  if not deleted then
    TriggerEvent("DoLongHudText", "Error while deleting object", 2)
  else
    TriggerEvent("DoLongHudText", "Storage removed", 1)
  end
end)

AddEventHandler("fa-business:client:openStash", function (pData, pEntity)
  local objInfo = exports["fa-objects"]:GetObjectByEntity(pEntity)
  if objInfo == nil then return end

  local storageSize = objInfo.metaData.storageSize
  local businessCode = objInfo.metaData.businessCode
  local storageWeight = objInfo.metaData.storageWeight
  local storageSlots = objInfo.metaData.storageSlots
  local randomId = objInfo.metaData.randomId

  -- Are they employed at this business with stash access or a cop with an auth code?
  local success = RPC.execute("fa-business:hasPermission", businessCode, "stash_access")
  if not success and isPD() then
    success = getPDAuthCode()
  end

  if not success then
    return TriggerEvent("DoLongHudText", "Not allowed", 2)
  end

  local inventoryName = string.format("%s-%s-%s", storageSize, businessCode, randomId)
  TriggerEvent("server-inventory-open", "1", inventoryName, tonumber(storageWeight), tonumber(storageSlots))
end)

AddEventHandler("fa-business:client:changeStashModel", function (pData, pEntity)
  local objInfo = exports["fa-objects"]:GetObjectByEntity(pEntity)
  if objInfo == nil then return end

  local unitOptions = {
    {
      name = "prop_cabinet_02b",
      id = "prop_cabinet_02b"
    },
    {
      name = "prop_toolchest_05",
      id = "prop_toolchest_05"
    },
    {
      name = "prop_container_ld_pu",
      id = "prop_container_ld_pu"
    },
    {
      name = "p_cs_locker_01_s",
      id = "p_cs_locker_01_s"
    },
    {
      name = "p_v_43_safe_s",
      id = "p_v_43_safe_s"
    },
    {
      name = "p_pharm_unit_01",
      id = "p_pharm_unit_01"
    },
    {
      name = "prop_devin_box_closed",
      id = "prop_devin_box_closed"
    },
    {
      name = "prop_tool_box_07",
      id = "prop_tool_box_07"
    },
    {
      name = "ba_prop_battle_crate_art_02_bc",
      id = "ba_prop_battle_crate_art_02_bc"
    },
    {
      name = "v_med_cooler",
      id = "v_med_cooler"
    },
    {
      name = "h4_prop_h4_chest_01a2",
      id = "h4_prop_h4_chest_01a2"
    },
  }

  local menuData = {
    key = { id = objInfo.id },
    show = true,
    callbackUrl = "fa-business:client:updateStashModel",
    items = {
      { icon = "object-ungroup", _type = "select", label = "New Unit Model", name = "stashProp", options = unitOptions },
    }
  }
  exports["fa-interface"]:openApplication("textbox", menuData)
end)

RegisterInterfaceCallback("fa-business:client:updateStashModel", function(pData, pCb) 
  pCb({ data = {}, meta = { ok = true, message = "done" } })

  local stashProp = pData.values.stashProp
  if stashProp == nil or stashProp == "" or not validStorageProp[stashProp] then
    return TriggerEvent("DoLongHudText", "Invalid unit model", 2)
  end

  if pData.key.id == nil then return end
  
  TriggerEvent("animation:PlayAnimation", "hammering")

  exports["fa-interface"]:closeApplication("textbox")
  
  local finished = exports["fa-taskbar"]:taskBar(15000, "Changing Storage")
  ClearPedTasks(PlayerPedId())
  if finished ~= 100 then return end

  local updated = exports["fa-objects"]:UpdateObject(pData.key.id, stashProp)
end)

RegisterInterfaceCallback("fa-business:client:createStash", function(pData, pCb) 
  pCb({ data = {}, meta = { ok = true, message = "done" } })
  exports["fa-interface"]:closeApplication("textbox")

  local businessCode = pData.values.businessCode
  if businessCode == nil or businessCode == "" then
    return TriggerEvent("DoLongHudText", "Invalid/No business code", 2)
  end

  local stashProp = pData.values.stashProp
  if stashProp == nil or stashProp == "" then
    stashProp = "prop_cabinet_02b"
  end
  
  if not validStorageProp[stashProp] then
    return TriggerEvent("DoLongHudText", "Invalid unit model", 2)
  end


  local storageSize = pData.values.storageSize
  if not validStorageSize(storageSize) then
    return TriggerEvent("DoLongHudText", "Invalid storage size", 2)
  end

  local storageWeight = pData.values.storageWeight
  local storageSlots = pData.values.storageSlots

  local metaData = {
    businessCode = businessCode,
    storageSize = storageSize,
    storageWeight = storageWeight,
    storageSlots = storageSlots,
    randomId = math.random(1, 9999999),
  }
  
  local result = exports["fa-objects"]:PlaceAndSaveObject(
    stashProp, 
    metaData, 
    { groundSnap = true }
  )
  
  if not result then
    return TriggerEvent("DoLongHudText", "Failed to create stash!", 2)
  end
  TriggerServerEvent('fa-objects:requestObjects')
  return TriggerEvent("DoLongHudText", "Successfully created stash!", 1)
end)

function validStorageSize(pSize)
  local valid = false
  if (pSize == "biz" or pSize == "bizLarge") then
    valid = true
  end
  return valid
end

-- prop menu begining
--[[ local lastItemUsed = nil
local staticCamItems = {
  ["dashcamstatic"] = true,
  ["dashcamstaticpd"] = true,
}
AddEventHandler("fa-inventory:itemUsed", function(item)
  if not staticCamItems[item] then return end
  lastItemUsed = item
  currentSecCamCoords = nil
  destinationSelected = false
  TriggerEvent('DoLongHudText', "[E] Place, [MouseWheel] Rotate")
  local result = exports["fa-objects"]:PlaceObject(
    `prop_spycam`,
    {
      collision = false,
      groundSnap = false,
      forceGroundSnap = false,
      useModelOffset = false,
      zOffset = -0.05,
      distance = 4.5,
    },
    function(pCoords, pMaterial, pEntity)
      local forward = GetOffsetFromEntityInWorldCoords(pEntity, 0.0, -0.5, 0.0)
      DrawLine(pCoords.x, pCoords.y, pCoords.z, forward.x, forward.y, forward.z, 0, 255, 0, 255)
      return true
    end
  )

  if not result[1] then
    return
  end

  local prompt = exports["fa-interface"]:OpenInputMenu({
    {
      name = 'name',
      label = 'Security Camera Stream Name',
      icon = 'pencil-alt'
    }
  }, function(values)
    return values.name and values.name:len() > 2
  end)

  if not prompt then
    return
  end
  local success = RPC.execute("fa-gopros:addSecCamera", prompt.name, result[2].coords, result[2].rotation)
  if success then
    TriggerEvent("inventory:removeItem", lastItemUsed, 1)
  end
end) ]]