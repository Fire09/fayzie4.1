local carSpawns = {}
local spawnedVehicles = {}
currentLocation = nil

function getLocation()
  return currentLocation
end

function locationEnter(location)
  currentLocation = location
  cars, testDriveSpawnPoint = RPC.execute("showroom:locationInit", location)
  setTestDriveLocation(testDriveSpawnPoint)
  spawn(cars)
end

function locationLeave(location)
  currentLocation = nil
  setTestDriveLocation(nil)
  despawn()
  RPC.execute("showroom:locationRemove", location)
end

function despawn()
  for i = 1, #spawnedVehicles do
    local veh = spawnedVehicles[i]
    DeleteVehicle(veh)
    spawnedVehicles[i] = nil
  end
end

function spawn(carsToSpawn)
  for i = 1, #carsToSpawn do
    local car = carsToSpawn[i]
    if not carSpawns[i] or not spawnedVehicles[i] or carSpawns[i].model ~= car.model then
      local vehToDespawn = spawnedVehicles[i]
      if vehToDespawn then
        DeleteVehicle(vehToDespawn)
      end

      local model = GetHashKey(car.model)
      RequestModel(model)
      while not HasModelLoaded(model) do
        Citizen.Wait(0)
      end

      local veh = CreateVehicle(
        model,
        car.coords.x,
        car.coords.y,
        car.coords.z - 1,
        car.coords.w,
        false,
        false
      )
      SetModelAsNoLongerNeeded(model)
      SetVehicleOnGroundProperly(veh)
      SetEntityInvincible(veh, true)
      SetVehicleDoorsLocked(veh, 2)

      local preset = CarPresets[car.model]
      if preset then
        exports["fa-vehicles"]:SetVehicleAppearance(veh, preset.appearance and preset.appearance or {})
        exports["fa-vehicles"]:SetVehicleMods(veh, preset.mods and preset.mods or {})

        if car.fitment and car.fitment.w_width then
          DecorSetBool(veh, "fa-wheelfitment_applied", true)
          DecorSetFloat(veh, "fa-wheelfitment_w_width", preset.fitment.w_width)
          DecorSetFloat(veh, "fa-wheelfitment_w_fl", preset.fitment.w_fl)
          DecorSetFloat(veh, "fa-wheelfitment_w_fr", preset.fitment.w_fr)
          DecorSetFloat(veh, "fa-wheelfitment_w_rl", preset.fitment.w_rl)
          DecorSetFloat(veh, "fa-wheelfitment_w_rr", preset.fitment.w_rr)
        end
      end

      FreezeEntityPosition(veh, true)
      SetVehicleNumberPlateText(veh, i .. "CARSALE")
      spawnedVehicles[i] = veh

      exports["fa-flags"]:SetVehicleFlag(veh, "isCarShopVehicle", true)
    end
  end
  carSpawns = carsToSpawn
end

RegisterNetEvent("showroom:updateCarSpawns")
AddEventHandler("showroom:updateCarSpawns", function(cars)  
  spawn(cars)
end)

RegisterNetEvent("showroom:setFitment", function(pNetId, pFitment)
  local vehicle = NetworkGetEntityFromNetworkId(pNetId)
  if not vehicle then return end
  DecorSetBool(vehicle, "fa-wheelfitment_applied", true)
  DecorSetFloat(vehicle, "fa-wheelfitment_w_width", pFitment.w_width)
  DecorSetFloat(vehicle, "fa-wheelfitment_w_fl", pFitment.w_fl)
  DecorSetFloat(vehicle, "fa-wheelfitment_w_fr", pFitment.w_fr)
  DecorSetFloat(vehicle, "fa-wheelfitment_w_rl", pFitment.w_rl)
  DecorSetFloat(vehicle, "fa-wheelfitment_w_rr", pFitment.w_rr)
end)

RegisterNetEvent("showroom:setCarPresets", function(pPresets)
  CarPresets = pPresets
end)

RegisterNetEvent("showroom:updateCarPreset", function(pCarModel, pPreset)
  CarPresets[pCarModel] = pPreset
end)


Citizen.CreateThread(function()
  Citizen.Wait(1000)

-- for k, v in pairs(Config) do
--   if k ~= "Vehicles" and k ~= "Zones" then
--     v["Init"]()
--     Config["Zones"][k] = true
--     Config["Zones"][k .. "catalog"] = true
--   end
-- end

local peeks = {
  {
    group = { "isCarShopVehicle" },
    data = {
      {
        id = "carshop_check",
        label = "Vehicle Information",
        icon = "search-dollar",
        event = "fa-carshop:check",
        parameters = {}
      },
    },
    options = {
      distance = { radius = 2.5 }
    },
  },
  {
    group = { "isCarShopVehicle" },
    data = {
      {
        id = "carshop_buy",
        label = "Buy vehicle",
        icon = "dollar-sign",
        event = "fa-carshop:buy",
        parameters = {}
      },
    },
    options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        local _plate = GetVehicleNumberPlateText(pEntity)
        return RPC.execute("fa-carshop:forSale", _plate)
      end,
    },
  },
  {
    group = { "isCarShopVehicle" },
    data = {
      {
        id = "carshop_change",
        label = "Change Vehicle",
        icon = "exchange-alt",
        event = "fa-carshop:change",
        parameters = {}
      },
      {
        id = "carshop_commission",
        label = "Change Commission",
        icon = "percentage",
        event = "fa-carshop:commission",
      },
    },
    options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        local cid = exports["isPed"]:isPed("cid")
        local _shop = getLocation()
        local a, b, c, d = RPC.execute("fa-business:businessGetEmploymentInformationBusinessID", cid, _shop)
        return d > 0
      end,
    },
  },
  {
    group = { "isCarShopVehicle" },
    data = {
      {
        id = "carshop_sell",
        label = "Sell Vehicle",
        icon = "dollar-sign",
        event = "fa-carshop:sell",
        parameters = {}
      },
    },
    options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        local cid = exports["isPed"]:isPed("cid")
        local _shop = getLocation()
        local a, b, c, d = RPC.execute("fa-business:businessGetEmploymentInformationBusinessID", cid, _shop)
        local _plate = GetVehicleNumberPlateText(pEntity)
        return d > 0 and not RPC.execute("fa-carshop:forSale", _plate)
      end,
    },
  },
  {
    group = { "isCarShopVehicle" },
    data = {
      {
        id = "carshop_testdrive",
        label = "Test Drive",
        icon = "car",
        event = "fa-carshop:testdrive",
        parameters = {}
      },
    },
    options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        local cid = exports["isPed"]:isPed("cid")
        local _shop = getLocation()
        local a, b, c, d = RPC.execute("fa-business:businessGetEmploymentInformationBusinessID", cid, _shop)
        return d >= 3
      end,
    },
  },
  {
    group = { "isTestDriveVehicle" },
    data = {
      {
        id = "carshop_testdrivereturn",
        label = "Return Vehicle",
        icon = "car",
        event = "fa-carshop:testdriveReturn",
        parameters = {}
      },
    },
    options = {
      distance = { radius = 2.5 },
      isEnabled = function(pEntity, pContext)
        local shop = getLocation()
        if not shop then
          return false
        end

        local cid = exports["isPed"]:isPed("cid")
        local a, b, c, d = RPC.execute("fa-business:businessGetEmploymentInformationBusinessID", cid, _shop)
        if d < 3 then
          return false
        end

        return #(GetEntityCoords(pEntity) - exports["fa-carshop"]:getTestDriveLocation(shop)["xyz"]) < 3.0
      end,
    },
  },
}

  for i, v in ipairs(peeks) do
    exports["fa-interact"]:AddPeekEntryByFlag(v.group, v.data, v.options)
  end
end)