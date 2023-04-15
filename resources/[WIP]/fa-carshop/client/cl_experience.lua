-- PDM: -44.18402, -1097.083, -40
-- Tuner: 935.63, -968.52, -40.42
-- Fastlane: -795.02, -226.4, -40

local inPolyZone = nil

-- RegisterNUICallback("fa-ui:showroomChangeCar", function(data, cb)
--   vehicle = CreateShowroomVehicle(sr, data.model)
--   SetVehicleDirtLevel(vehicle, 0.0)
--   local info, vehClass, brand = calculateStats()
--   cb({ data = { info = info, vehClass = vehClass}, meta = { ok = true, message = 'done' } })
-- end)

AddEventHandler("fa-showrooms:enterExperience", function()
  openShowroom(inPolyZone, false)
end)

Citizen.CreateThread(function()
  exports["fa-interact"]:AddPeekEntryByModel({ 1723506536 }, {{
    id = "showroom_enter_experience",
    event = "fa-showrooms:enterExperience",
    icon = "fas fa-car",
    label = "View Catalog",
    parameters = {},
  }}, { distance = { radius = 1.5 } })
  exports["fa-interact"]:AddPeekEntryByPolyTarget('showroom_tablet', {{
    id = "showroom_target_experience",
    event = "fa-showrooms:enterExperience",
    icon = "fas fa-car",
    label = "View Catalog",
    paramers = {},
  }}, { distance = { radius = 3.5 }  })
end)

experience = {
  onEnter = function(location)
    inPolyZone = location
  end,
  onLeave = function()
    inPolyZone = nil
  end,
}