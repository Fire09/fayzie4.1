local isInsideZone = false
local zoneName = nil

Citizen.CreateThread(function()
  -- pdm
  exports["fa-polyzone"]:AddBoxZone("pdm", vector3(-58.34, -1111.57, 26.44), 87.6, 86.8, {
    heading = 339,
    minZ = 23.84,
    maxZ = 37.64,
  })
  -- pdm tablets
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(-57.22, -1091.61, 26.42), 1.2, 2.2, {
  --   heading = 69,
  --   minZ = 25.42,
  --   maxZ = 27.42,
  -- })
  exports["fa-polytarget"]:AddBoxZone("showroom_tablet", vector3(824.61, -825.08, 26.06), 0.5, 0.5, {
    heading=0,
    minZ=26.21,
    maxZ=26.61
  })
  exports["fa-polytarget"]:AddBoxZone("showroom_tablet", vector3(828.08, -825.04, 26.33), 0.5, 0.5, {
    heading=0,
    minZ=26.21,
    maxZ=26.61
  })

  -- fastlane
  -- exports["fa-polyzone"]:AddBoxZone("fastlane", vector3(-797.42, -230.87, 37.08), 94.0, 80.2, {
  --   heading = 29,
  --   minZ = 35.13,
  --   maxZ = 58.33,
  -- })
  -- fastlane tablets
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(-792.49, -223.83, 37.08), 1.2, 2.2, {
  --   heading = 209,
  --   minZ = 36.08,
  --   maxZ = 38.28,
  -- })
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(-788.39, -225.7, 37.08), 1.2, 2.2, {
  --   heading = 304,
  --   minZ = 36.08,
  --   maxZ = 38.28,
  -- })
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(-782.68, -242.06, 37.08), 1.2, 2.2, {
  --   heading = 299,
  --   minZ = 36.08,
  --   maxZ = 38.48,
  -- })

  -- tuner
  exports["fa-polyzone"]:AddBoxZone("tuner", vector3(141.75, -3045.74, 8.38), 165.4, 126.0, {
    heading = 0,
    minZ = 4.18,
    maxZ = 17.98,
    zoneEvents = {"fa-vehiclelifts:client:StartMovingLift"},
    data = {
      id = "tuner",
    }
  })
  -- tuner tablets
  exports["fa-polytarget"]:AddBoxZone("showroom_tablet", vector3(124.11, -3011.35, 7.04), 2.8, 1, {
    heading = 0,
    minZ = 6.84,
    maxZ = 7.84,
  })
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(949.34, -956.93, 39.51), 1.2, 2.0, {
  --   heading = 272,
  --   minZ = 38.21,
  --   maxZ = 41.21,
  -- })
  -- exports["fa-polyzone"]:AddBoxZone("showroom_tablet", vector3(917.1, -957.25, 39.51), 1.2, 2.0, {
  --   heading = 2,
  --   minZ = 38.21,
  --   maxZ = 41.21,
  -- })
  -- exports["fa-polytarget"]:AddBoxZone("pdm_job_vehicles", vector3(-33.68, -1106.61, 26.42), 1.0, 0.2, {
  --   heading = 341,
  --   minZ=26.42,
  --   maxZ=27.02,
  --   data = {
  --     id = 1,
  --   },
  -- })
  -- exports['fa-interact']:AddPeekEntryByPolyTarget("pdm_job_vehicles", {{
  --   id = "pdm_job_vehicles",
  --   event = "fa-showrooms:buyJobVehicles",
  --   icon = "car",
  --   label = "Purchase Job Vehicle",
  --   parameters = {},
  -- }}, { distance = { radius = 1.5 } })
  CarPresets = RPC.execute('showroom:getCarPresets')
end)

AddEventHandler("fa-polyzone:enter", function(name)
  if name ~= "pdm" and name ~= "fastlane" and name ~= "tuner" then return end
  zoneName = name
  exports["fa-ui"]:sendAppEvent("game", { location = name })
  experience.onEnter(zoneName)
  locationEnter(zoneName)
end)
AddEventHandler("fa-polyzone:exit", function(name)
  if name ~= "pdm" and name ~= "fastlane" and name ~= "tuner" then return end
  experience.onLeave(name)
  locationLeave(name)
  exports["fa-ui"]:sendAppEvent("game", { location = "world" })
end)


RegisterNetEvent("showroom-tuner:clPurchaseVehicle",function(model, plate)
  TakeOutVehicle(model, plate)
end)

function TakeOutVehicle(vehicle, plate)
  enginePercent = 1000
  bodyPercent = 1000
  currentFuel = 1000
  model = vehicle
  veh = CreateVehicle(model, -45.60,-1080.9, 26.706,70.0, true, false)
  SetEntityAsMissionEntity(veh, true, true)
  SetModelAsNoLongerNeeded(model)
  SetVehicleOnGroundProperly(veh)
  TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
  SetVehicleNumberPlateText(veh, plate)
  TriggerEvent("keys:addNew", veh, plate)
end

function resetMods(pVehicle)
  local mods = {
    ["Spoilers"] = -1,
    ["FrontBumper"] = -1,
    ["RearBumper"] = -1,
    ["SideSkirt"] = -1,
    ["Exhaust"] = -1,
    ["Frame"] = -1,
    ["Grille"] = -1,
    ["Hood"] = -1,
    ["Fender"] = -1,
    ["RightFender"] = -1,
    ["Roof"] = -1,
    ["Engine"] = -1,
    ["Brakes"] = -1,
    ["Transmission"] = -1,
    ["Horns"] = -1,
    ["Suspension"] = -1,
    ["Armor"] = -1,
    ["UNK17"] = 0,
    ["Turbo"] = 0,
    ["UNK19"] = 0,
    ["TireSmoke"] = 0,
    ["UNK21"] = 0,
    ["XenonHeadlights"] = -1,
    ["FrontWheels"] = -1,
    ["BackWheels"] = -1,
    ["PlateHolder"] = -1,
    ["VanityPlates"] = -1,
    ["InteriorTrim"] = -1,
    ["Ornaments"] = -1,
    ["Dashboard"] = -1,
    ["Dials"] = -1,
    ["DoorSpeakers"] = -1,
    ["Seats"] = -1,
    ["SteeringWheel"] = -1,
    ["ShiftLeavers"] = -1,
    ["Plaques"] = -1,
    ["Speakers"] = -1,
    ["Trunk"] = -1,
    ["Hydraulics"] = -1,
    ["EngineBlock"] = -1,
    ["AirFilter"] = -1,
    ["Struts"] = -1,
    ["ArchCover"] = -1,
    ["Aerials"] = -1,
    ["ExteriorTrim"] = -1,
    ["Tank"] = -1,
    ["Windows"] = -1,
    ["UNK47"] = -1,
    ["Livery"] = -1,
  }
  exports["fa-vehicles"]:SetVehicleMods(pVehicle, mods)
  exports["fa-vehicles"]:SetVehicleAppearance(pVehicle, { colors = {}, tint = 0 })
end
--
local jobVehicleData = {
  ["taxi"] = { price = 2500, name = "Taxi" },
  ["flatbed"] = { price = 2500, name = "Tow Truck" },
  ["rumpo"] = { price = 3500, name = "News Rumpo" },
}

AddEventHandler("fa-showrooms:buyJobVehicles", function()
  Wait(200)
  exports['fa-ui']:showContextMenu({
    {
      title = "Taxi",
      description = '$2,500.00',
      action = 'fa-showrooms:buyJobVehicleAction',
      key = 'taxi',
    },
    {
      title = "Tow Truck (Flatbed)",
      description = '$2,500.00',
      action = 'fa-showrooms:buyJobVehicleAction',
      key = 'flatbed',
    },
    {
      title = "News Rumpo",
      description = '$3,500.00',
      action = 'fa-showrooms:buyJobVehicleAction',
      key = 'rumpo',
    },
  })
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)
