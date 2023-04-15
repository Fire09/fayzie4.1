local VehicleEntries = MenuEntries['vehicles']

-- VehicleEntries[#VehicleEntries+1] = {
--     data = {
--         id = "247goods",
--         title = "Grab goods",
--         icon = "#obj-box",
--         event = "fa-jobs:247delivery:takeGoods"
--     },
--     isEnabled = function(pEntity, pContext)
--       return not IsDisabled() and GetEntityModel(pEntity) == `benson` and isCloseToTrunk(pEntity, PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), false)
--     end
-- }

VehicleEntries[#VehicleEntries+1] = {
  data = {
      id = "vehicle-parkvehicle",
      title = "Park Vehicle",
      icon = "#vehicle-parkvehicle",
      event = "vehicle:storeVehicle"
  },
  isEnabled = function(pEntity, pContext)
    return not exports['fa-death']:GetDeathStatus() and exports['fa-vehicles']:HasVehicleKey(pEntity) and exports['fa-vehicles']:IsOnParkingSpot(pEntity, false) and not IsPedInAnyVehicle(PlayerPedId(), false)
  end
}