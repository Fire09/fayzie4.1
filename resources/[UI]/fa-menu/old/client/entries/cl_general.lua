local isInstructorMode = false
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local isAtGarage = false

-- Location's
local bennyLocationPillbox = vector3(340.38067, -570.7971, 28.188589)
local bennyLocation = vector3(-39.09, -1054.17, 27.79)
local bennyLocationHarmony = vector3(1174.78, 2639.96, 37.73)
local bennyLocationMRPD = vector3(450.01, -976.04, 25.03)
local bennyLocationTunershop = vector3(135.87, -3030.35, 7.04)
local bennyLocationHayes = vector3(-1423.979, -449.8175, 35.432106)
local bennyLocationHayes2 = vector3(-1417.338, -446.0031, 35.303215)
local bennyLocationAutoExotic = vector3(547.25, -189.45, 53.88)
local bennysSandyShoresPD = vector3(1878.4317, 3696.0478, 32.934951)
local bennysRacingWarehouse = vector3(947.46923, -1750.245, 20.419561)
local bennysHarmony2 = vector3(1182.4747314453, 2639.8022460938, 37.148681640625)
local RepairDriftSchool = vector3(-167.4725189209,-2460.7648925781,5.9091796875)
local bennyLocationdoc = vector3(1832.5999, 2549.8505, 45.285083)
local bennyslocationpaleto = vector3(111.4, 6626.74, 31.83)

local GeneralEntries = MenuEntries['general']

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles",
    title = "Vehicle",
    icon = "#vehicle-options-vehicle",
    event = "veh:options"
  },
  isEnabled = function(pEntity, pContext)
    return ( IsPedInAnyVehicle(PlayerPedId(), false) and not exports['fa-death']:GetDeathStatus())
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "peds-escort",
    title = "Stop escorting",
    icon = "#general-escort",
    event = "escortPlayer"
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and isEscorting
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "property-enter",
    title = "Enter Property",
    icon = "#property-enter",
    event = "housing:interactionTriggered"
  },
  isEnabled = function(pEntity, pContext)
    return not isDead and exports["fa-housing"]:isNearProperty()
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "property-lock",
    title = "Unlock/Lock Property",
    icon = "#property-lock",
    event = "housing:toggleClosestLock"
  },
  isEnabled = function(pEntity, pContext)
    return not isDead and exports["fa-housing"]:isNearProperty(true)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "poledance:toggle",
    title = "Poledance",
    icon = "#poledance-toggle",
    event = "poledance:toggle"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["fa-flags"]:HasPedFlag(PlayerPedId(), 'isPoledancing')
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "oxygentank",
    title = "Remove Oxygen Tank",
    icon = "#oxygen-mask",
    event = "RemoveOxyTank"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and hasOxygenTankOn
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles-keysgive",
    title = "Give Keys",
    icon = "#general-keys-give",
    event = "vehicle:giveKey"
},
isEnabled = function(pEntity, pContext)
    return not exports['fa-death']:GetDeathStatus() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["fa-vehicles"]:HasVehicleKey(GetVehiclePedIsIn(PlayerPedId(), false))
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "vehicle-vehicleList",
      title = "Vehicle List",
      icon = "#vehicle-vehicleList",
      event = "vehicle:garageVehicleList",
      parameters = { nearby = true, radius = 4.0 }
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isVehicleSpawner"] or not pEntity and exports["fa-vehicles"]:IsOnParkingSpot(PlayerPedId(), true, 4.0))
  end
}

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "police-dispatch",
--       title = "Dispatch",
--       icon = "#general-check-over-target",
--       event = "fa-dispatch:openFull"
--   },
--   isEnabled = function(pEntity, pContext)
--     return (exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' or exports["isPed"]:isPed("myJob") == 'ranger')
--   end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "police-panic",
    title = "Panic",
    icon = "#police-dead",
  },
  subMenus = {'policeDeadA', 'policeDeadB', 'policePanic'},
  isEnabled = function()  
    return (exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' or exports["isPed"]:isPed("myJob") == 'ranger' or exports["isPed"]:isPed("myJob") == 'doc')
end
}

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "impoundmenu",
--     title = "Impound Options",
--     icon = "#property-lock",
--   },
--   subMenus = {'impoundsc', 'impoundVehicle', 'fullimpoundVehicle'},
--   isEnabled = function()
--     return (exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' or exports["isPed"]:isPed("myJob") == 'ranger' or exports["isPed"]:isPed("myJob") == 'ems') and not exports['fa-death']:GetDeathStatus() and exports["fa-police"]:NearVehicle("Distance") and not IsPedInAnyVehicle(PlayerPedId())
-- end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "police-vehicle",
--     title = "Police Vehicle",
--     icon = "#police-vehicle",
--   },
--   subMenus = {'fa-fa-police:riflerack'},
--   isEnabled = function()
--     return (exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' or exports["isPed"]:isPed("myJob") == 'ranger' or exports["isPed"]:isPed("myJob") == 'ems') and not exports['fa-death']:GetDeathStatus() and exports["fa-police"]:NearVehicle("Distance") and IsPedInAnyVehicle(PlayerPedId())
-- end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "medic-actions",
    title = "Panic",
    icon = "#ems-dead",
  },
  subMenus = {'emsDeadA', 'emsDeadB'},
  isEnabled = function()  
    return (exports["isPed"]:isPed("myJob") == 'ems')
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "call_for_help",
      title = "Call For Help",
      icon = "#dead",
      event = "fa-death:alert"
  },
  isEnabled = function(pEntity, pContext)
    return (exports['fa-death']:GetDeathStatus())
  end
}

-- local canDropGoods = false
-- local canDropGoodsTimer = nil

-- -- RegisterCommand("testboxes", function()
-- --   TriggerEvent("attachItem","crate01")
-- --   RequestAnimDict("anim@heists@box_carry@")
-- --   TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180, 49, 0, 0, 0, 0)
-- --   Wait(1000)
-- --   TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
-- --   TriggerEvent("animation:disable", true)
-- --   TriggerEvent("AnimSet:default")
-- -- end)

-- -- RegisterNetEvent("fa-jobs:247delivery:takeGoods")
-- -- AddEventHandler("fa-jobs:247delivery:takeGoods", function()
-- --   TriggerEvent('player:receiveItem', '247package', 1)
-- --   -- print("take goods")
-- --   canDropGoods = true
-- --   canDropGoodsTimer = GetGameTimer()
-- -- end)

-- -- AddEventHandler("fa-jobs:247delivery:dropGoods", function()
-- --   -- print("dropgoods", canDropGoods, canDropGoodsTimer)
-- --   canDropGoods = false
-- --   canDropGoodsTimer = nil
-- --   ClearPedTasks(GetPlayerPed(-1))
-- --   TriggerEvent('inventory:removeItem', '247package', 1)
-- -- end)

-- -- GeneralEntries[#GeneralEntries+1] = {
-- --   data = {
-- --     id = "job-drop-goods",
-- --     title = "Drop Goods",
-- --     icon = "#property-lock",
-- --     event = "fa-jobs:247delivery:dropGoods"
-- --   },
-- --   isEnabled = function(pEntity, pContext)
-- --     return canDropGoods and canDropGoodsTimer + 15000 < GetGameTimer()
-- --   end
-- -- }

-- -- GeneralEntries[#GeneralEntries+1] = {
-- --   data = {
-- --     id = "job-deliver-package",
-- --     title = "Deliver Package",
-- --     icon = "#obj-box",
-- --     event = "fa-jobs:drop_package"
-- --   },
-- --   isEnabled = function(pEntity, pContext)
-- --     return exports['fa-jobs']:canDropPackage()
-- --   end
-- -- }

-- -- GeneralEntries[#GeneralEntries+1] = {
-- --   data = {
-- --     id = "job-do-electrical",
-- --     title = "Start Fixing Box",
-- --     icon = "#ped-give-stolen-items",
-- --     event = "fa-jobs:fix_elec"
-- --   },
-- --   isEnabled = function(pEntity, pContext)
-- --     return exports['fa-jobs']:canFixElec()
-- --   end
-- -- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "emotes:openmenu",
      title = "Emotes",
      icon = "#general-emotes",
      event = "emotes:OpenMenu"
  },
  isEnabled = function(pEntity, pContext)
      return not exports['fa-death']:GetDeathStatus()
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "bennys:enter"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and polyChecks.bennys.isInside and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter1",
      title = "Enter Benny's ($750)",
      icon = "#general-check-vehicle",
      event = "fa-public-bennys" 
  },
  isEnabled = function()
    return (not exports['fa-death']:GetDeathStatus()) and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocation) <= 10
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter2",
      title = "Enter Benny's ($750)",
      icon = "#general-check-vehicle",
      event = "fa-public-bennyspaleto" 
  },
  isEnabled = function()
    return (not exports['fa-death']:GetDeathStatus()) and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyslocationpaleto) <= 10
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "enter:benny:pillbox",
      title = "Enter Benny's",
      icon = "#general-check-vehicle",
      event = "enter:benny:pillbox" 
  },
  isEnabled = function()
    return (not exports['fa-death']:GetDeathStatus()) and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationPillbox) <= 5
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "enter:benny:doc",
      title = "Enter Benny's",
      icon = "#general-check-vehicle",
      event = "enter:bennys:doc" 
  },
  isEnabled = function()
    return (exports["isPed"]:isPed("myJob") == 'doc' and not exports['fa-death']:GetDeathStatus()) and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationdoc) <= 5
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enterHarmony2",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:harmony2"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennysHarmony2) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enterRacingWarehouse",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "fa-bennys:enter_maf"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennysRacingWarehouse) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enterSandyPd",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "fa-fa-police:AttemptBennys:SandyPD"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennysSandyShoresPD) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:bennys_2",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:bennys2"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationHayes2) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enter9",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:bennys"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationHayes) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enter8",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:harmony"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationHarmony) <= 3)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enter5",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:tunershop"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationTunershop) <= 4)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:enter4",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:mrpd"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationMRPD) <= 10)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "benny:drift_school",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "fa-driftschool:repair_vehicle"
  },
  isEnabled = function()
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - RepairDriftSchool) <= 10)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "mdw",
    title = "MDW",
    icon = "#mdt",
    event = "fa-mdw:openMDW"
  },
  isEnabled = function()
    return not exports['fa-death']:GetDeathStatus() and ((exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'ems' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' or exports["isPed"]:isPed("myJob") == 'ranger' or exports["isPed"]:isPed("myJob") == 'judge' or exports["isPed"]:isPed("myJob") == 'district_attorney'))
  end
}

local currentJob = nil
local policeModels = {
  [`npolvic`] = true,
}
RegisterNetEvent("fa-workmanager:playerBecameJob")
AddEventHandler("fa-workmanager:playerBecameJob", function(job, name, notify)
    currentJob = job
end)
GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "fa-fa-police:riflerack",
      title = "Rifle Rack",
      icon = "#vehicle-plate-remove",
      event = "fa-fa-police:RifleRack"
  },
  isEnabled = function(pEntity)
    if currentJob ~= "police" then return false end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh == 0 then return false end
    local model = GetEntityModel(veh)
    if policeModels[model] == nil then return false end
    return true
  end
}

MenuItems['policePanic'] = {
  data = {
    id = "policePanic",
    title = "Panic",
    icon = "#police-action-panic",
    event = "fa-fa-police:policePanic",
  }
}

MenuItems['policeDeadA'] = {
  data = {
    id = "policeDeadB",
    title = "10-13A",
    icon = "#police-dead",
    event = "fa-fa-police:tenThirteenA",
  }
}

MenuItems['policeDeadB'] = {
  data = {
    id = "policeDeadB",
    title = "10-13B",
    icon = "#police-dead",
    event = "fa-fa-police:tenThirteenB",
  }
}

MenuItems['fa-fa-police:riflerack'] = {
  data = {
      id = "fa-fa-police:riflerack",
      title = "Rifle Rack",
      icon = "#drivinginstructor-submittest",
      event = "fa-fa-police:RifleRack"
  }
}

MenuItems['impoundsc'] = {
  data = {
    id = "impoundsc",
    title = "Impound Scuff",
    icon = "#vehicle-options",
    event = "impoundsc",
  }
}

MenuItems['impoundVehicle'] = {
  data = {
    id = "impoundVehicle",
    title = "Impound Normal $100",
    icon = "#vehicle-options",
    event = "impoundVehicle",
  }
}

MenuItems['fullimpoundVehicle'] = {
  data = {
    id = "fullimpoundVehicle",
    title = "Impound Police $1500",
    icon = "#vehicle-options",
    event = "fullimpoundVehicle",
  }
}

MenuItems['emsDeadA'] = {
  data = {
    id = "emsDeadA",
    title = "10-14A",
    icon = "#ems-dead",
    event = "fa-fa-police:tenForteenA",
  }
}

MenuItems['emsDeadB'] = {
  data = {
    id = "emsDeadB",
    title = "10-14B",
    icon = "#ems-dead",
    event = "fa-fa-police:tenForteenB",
  }
}

local approvedGarages = {
  "garagea",
  "garageb",
  "garagec",
  "garaged",
  "garagee",
  "garagef",
  "garageg",
  "garageh",
  "garagei",
  "garagej",
  "garagek",
  "garagel",
  "garagem",
  "garageo",
  "garagep",
  "garageq",
  "garager",
  "garages",
  "garaget",
  "garageu",
  "garagepd",
  "garageuwu",
  "garagesandy",
  "garagestate",
  "garageharm",
  "garagepier",
  "garagerich",
  "garageems",
  "garagecasino",
  "nomalimpound",
  "garagempg",
  "garagegallery",
  "garagelsp",
  "garagebahamas",
  "garagetuner",
  "garagehydra",
  "garageseoul",
  "garagedoc",
  "garagehightable",
  "garagecosmic",
  "garagemandem",
  "garagebennysnew"
}

local pCurrentGarage = "None"


function polyZoneEnter(zoneName, zoneData)
  currentZone = zoneName
  for k, v in pairs (approvedGarages) do
      if zoneName == v then
          exports['fa-interface']:showInteraction('Parking')
          pCurrentGarage = zoneName
          -- print(pCurrentGarage)
          isAtGarage = true
      end
  end
end

function polyZoneExit(zoneName)
  if currentZone == zoneName then
      exports['fa-interface']:hideInteraction()
      isAtGarage = false
      pCurrentGarage = "None"
  end
end

exports("currentGarage", function()
  if isAtGarage then
      return pCurrentGarage
  elseif isAtHouseGarage then
      return pHouseNameGarage
  end
end)

exports("houseGarageCoords", function()
  return pHouseGarages
end)

exports("NearHouseGarage", function()
  return isAtHouseGarage
end)

RegisterNetEvent("menu:send:house:garages", function(pCoords, pGarageName)
  pHouseGarages = pCoords
  isAtHouseGarage = true
  pHouseNameGarage = pGarageName
end)

RegisterNetEvent("menu:housing", function(pState)
  isAtHouseGarage = pState
end)

AddEventHandler('fa-polyzone:entered:garages', polyZoneEnter)
AddEventHandler('fa-polyzone:exited:garages', polyZoneExit)