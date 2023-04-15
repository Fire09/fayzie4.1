local GeneralEntries = MenuEntries['general']
local bennyLocation = vector3(-32.28531, -1053.779, 27.983383)
local bennyLocationBridge = vector3(727.74, -1088.95, 22.17)
local billyLocationPaleto = vector3(110.8, 6626.46, 31.89)
local bennyLocationMRPD = vector3(450.01, -976.04, 25.03)

--local tunerLocation = vector3(124.60910797119, -3022.5561523438, 6.4606328010559)

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles",
    title = "Vehicle",
    icon = "#vehicle-options-vehicle",
    event = "veh:options"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
  end
}

-- GeneralEntries[#GeneralEntries+1] = { 
--   data = {
--     id = "pdCallSign",
--     title = "Vehicle Callsign",
--     icon = "#vehicle-options-vehicle",
--     event = "fa-callsignveh"
--   },
--   isEnabled = function(pEntity, pContext)
--     return (exports["isPed"]:isPed("myJob") == 'police') and not isDead and #(GetEntityCoords(PlayerPedId()) - vector3(443.6348, -986.6627, 25.70125)) <= 25 and IsPedInAnyVehicle(PlayerPedId(), false)
--   end
-- }

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
--     id = "vehicles-keysgive",
--     title = "Give Keys",
--     icon = "#general-keys-give",
--     event = "keys:give"
-- },
-- isEnabled = function(pEntity, pContext)
--     return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports['fa-vehicles']:hasKey(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))) 
-- end
-- }

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


-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "peds-escort",
--     title = "Escort",
--     icon = "#general-escort",
--     event = "escortPlayer"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not IsDisabled()
--   end
-- }

-- -- change to keybind?
-- -- GeneralEntries[#GeneralEntries+1] = {
-- --     data = {
-- --         id = "vehicles-doorKeyFob",
-- --         title = "Door KeyFob",
-- --         icon = "#general-door-keyFob",
-- --         event = "fa-doors:doorKeyFob"
-- --     },
-- --     isEnabled = function(pEntity, pContext)
-- --         return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["fa-inventory"]:hasEnoughOfItem("keyfob", 1, false)
-- --     end
-- -- }


-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "poledance:toggle",
--     title = "Poledance",
--     icon = "#poledance-toggle",
--     event = "poledance:toggle"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["fa-flags"]:HasPedFlag(PlayerPedId(), 'isPoledancing')
--   end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "poledance:toggle",
--     title = "Stop poledancing",
--     icon = "#poledance-toggle",
--     event = "poledance:toggle"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and exports["fa-flags"]:HasPedFlag(PlayerPedId(), 'isPoledancing')
--   end
-- }



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
    id = "policeDeadA",
    title = "10-13A",
    icon = "#police-dead",
    event = "fa-police:tenThirteenA",
  },
  isEnabled = function(pEntity, pContext)
      return isDead and (isPolice or isDoc)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "Civ-Dead",
    title = "Call For Help",
    icon = "#police-dead",
    event = "ragdoll:sendPing",
  },
  isEnabled = function(pEntity, pContext)
      return isDead
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "policeDeadB",
    title = "10-13B",
    icon = "#police-dead",
    event = "fa-police:tenThirteenB",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and (isPolice or isDoc)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "emsDeadA",
    title = "10-14A",
    icon = "#ems-dead",
    event = "fa-police:tenForteenA",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and isMedic
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "emsDeadB",
    title = "10-14B",
    icon = "#ems-dead",
    event = "fa-police:tenForteenB",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and isMedic
  end
}


--[[GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-vehicleList",
    title = "Shared Vehicles",
    icon = "#vehicle-vehicleList",
    event = "fa-garages:open"
},
isEnabled = function()
    return isAtHouseGarage and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}]]

--[[GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-parkvehicle",
    title = "Park Vehicle",
    icon = "#vehicle-parkvehicle",
    event = "fa-garages:store"
},
isEnabled = function()
  return isAtHouseGarage and exports["fa-garages"]:NearVehicle("Distance") and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}]]


--  GeneralEntries[#GeneralEntries+1] = {
--    data = {
--      id = "unseat",
--      title = "Get up",
--      icon = "#obj-chair",
--      event = "fa-emotes:sitOnChair"
--    },
--    isEnabled = function(pEntity, pContext)
--      return not isDead and exports["fa-flags"]:HasPedFlag(PlayerPedId(), 'isSittingOnChair')
--    end
--  }

--  GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "property-rent",
--       title = "Rent Property",
--       icon = "#real-estate-sell",
--       event = "fa-housing:rent"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not isDead and exports["fa-housing"]:canRent()
--   end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "property-enter",
      title = "Enter Property",
      icon = "#property-enter",
      event = "fa-housing:enterBUILDINGCMON",
      parameters = false,
  },
  isEnabled = function(pEntity, pContext)
      local isNear, propertyId = exports["fa-housing"]:isNearProperty()
      return not isDead and isNear
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "property-lock",
      title = "Toggle Lock",
      icon = "#property-lock",
      event = "housing:toggleClosestLock"
  },
  isEnabled = function(pEntity, pContext)
    local isNear, propertyId = exports["fa-housing"]:isNearProperty()

      return not isDead and isNear
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "property-invade",
      title = "Invade Property",
      icon = "#property-enter",
      event = "housing:interactionTriggered",
      parameters = true,
  },
  isEnabled = function(pEntity, pContext)
      local isNear, propertyId = exports["fa-housing"]:isNearProperty()
      return not isDead and isNear and exports["fa-housing"]:isBeingRobbed(propertyId)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "sellmeth",
      title = "Sell",
      icon = "#walking",
      event = "fa-meth:cornerSellProduct",
  },
  isEnabled = function(pEntity, pContext)
      print( json.encode( {showSellMethOption , canStartCornering , hasCarTarget }) )
      return not isDead and showSellMethOption and not canStartCornering and hasCarTarget
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "sellmethfromcorner",
      title = "Corner",
      icon = "#walking",
      event = "fa-meth:cornerStartSelling",
  },
  isEnabled = function(pEntity, pContext)
      return not isDead and canStartCornering
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "dispatch:openDispatch",
      title = "Dispatch",
      icon = "#general-check-over-target",
      event = "fa-dispatch:openFull"
  },
  isEnabled = function()
      return (isPolice or isMedic) and not isDead
  end
}



GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "emotes:openmenu",
      title = "Emotes",
      icon = "#general-emotes",
      event = "emotes:OpenMenu"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "civEject",
    title = _L("menu-general-ejectvehicle", "Self Eject"),
    icon = "#vehicle-plate-remove",
    event = "ragdoll:ejectVehicle",
  },
  isEnabled = function(pEntity, pContext)
      local ped = PlayerPedId()
      local plyVeh = GetVehiclePedIsIn(ped, false)
      local IsDriver = GetPedInVehicleSeat(plyVeh, -1) == ped
      return isDead and plyVeh and IsDriver
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "drivingInstructor:testToggle",
      title = "Driving Test",
      icon = "#drivinginstructor-drivingtest",
      event = "drivingInstructor:testToggle"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead and isInstructorMode
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "drivingInstructor:submitTest",
      title = "Submit Test",
      icon = "#drivinginstructor-submittest",
      event = "drivingInstructor:submitTest"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead and isInstructorMode
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "general:checkoverself",
      title = "Examine Self",
      icon = "#general-check-over-self",
      event = "Evidence:CurrentDamageList"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead
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
      id = "bennys:enter2",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "bennys:enter"
  },
  isEnabled = function(pEntity, pContext)
    return (isInBennyPDZone and isPolice and not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationMRPD) <= 10)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "toggle-anchor",
    title = "Toggle Anchor",
    icon = "#vehicle-anchor",
    event = "sanyo-anchor:toggleAnchor"
  },
  isEnabled = function(pEntity, pContext)
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local boatModel = GetEntityModel(currentVehicle)
    return not IsDisabled() and currentVehicle ~= 0 and (IsThisModelABoat(boatModel) or IsThisModelAJetski(boatModel) or IsThisModelAnAmphibiousCar(boatModel) or IsThisModelAnAmphibiousQuadbike(boatModel))
  end
}

--[[GeneralEntries[#GeneralEntries+1] = {
   data = {
     id = "mdw",
     title = "MDW",
     icon = "#mdt",
     event = 'fa-mdt:open'
   },
   isEnabled = function()
     return (
    myJob == "police"  or  isPolice) and not isDead
   end
 }]]

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "prepare-boat-mount",
--       title = "Mount on Trailer",
--       icon = "#vehicle-plate-remove",
--       event = "vehicle:mountBoatOnTrailer"
--   },
--   isEnabled = function()
--     local ped = PlayerPedId()
--     local veh = GetVehiclePedIsIn(ped)
--     if veh == 0 then
--       return false
--     end
--     local seat = GetPedInVehicleSeat(veh, -1)
--     if seat ~= ped then
--       return false
--     end
--     local model = GetEntityModel(veh)
--     if IsDisabled() or not (IsThisModelABoat(model) or IsThisModelAJetski(model) or IsThisModelAnAmphibiousCar(model)) then
--       return false
--     end
--     local left, right = GetModelDimensions(model)
--     return #(vector3(0, left.y, 0) - vector3(0, right.y, 0)) < 15
--   end
-- }

-- -- GeneralEntries[#GeneralEntries+1] = {
-- --   data = {
-- --       id = "prepare-boat-mount1",
-- --       title = "Mount on Trailer",
-- --       icon = "#vehicle-plate-remove",
-- --       event = "vehicle:mountCarOnTrailer"
-- --   },
-- --   isEnabled = function(pEntity)

-- --     return pEntity ~= 0
-- --   end
-- -- }

-- -- AddEventHandler("vehicle:mountCarOnTrailer", function(a, pEntity)
-- --   if GetVehicleDoorAngleRatio(pEntity, 5) == 0 then
-- --     SetVehicleDoorOpen(pEntity, 5, 0, 0)
-- --   else
-- --     SetVehicleDoorShut(pEntity, 5, 0)
-- --   end
-- --   -- SetCarBootOpen(pEntity)
-- --   SetVehicleOnGroundProperly(pEntity)
-- --   -- SetEntityCoords(pEntity, GetEntityCoords(pEntity).x, GetEntityCoords(pEntity).y, GetEntityCoords(pEntity).z + 0.05, 0, 0, 0, 1)
-- -- end)

 local currentJob = nil
 local policeModels = {
   [`npolvic`] = true,
   [`npolchar`] = true,
   [`npolexp`] = true,
   [`npolchal`] = true,
   [`npolvette`] = true,
   [`npolstang`] = true,
   [`npolmm`] = true,
 }
 RegisterNetEvent("fa-jobmanager:playerBecameJob")
 AddEventHandler("fa-jobmanager:playerBecameJob", function(job, name, notify)
     currentJob = job
 end)
 GeneralEntries[#GeneralEntries+1] = {
   data = {
       id = "open-rifle-rack",
       title = "Locked Storage",
       icon = "#vehicle-plate-remove",
       event = "vehicle:openRifleRack"
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
 AddEventHandler("vehicle:openRifleRack", function()
	local rackNumber = GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId()))
	if exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'ranger' or exports["isPed"]:isPed("myJob") == 'state' then
		local finished = exports["fa-taskbar"]:taskBar(1000,"Unlocking...",false,true)
		if finished == 100 then
			TriggerEvent("server-inventory-open", "1", "rifle-rack"..rackNumber)
		end
	end
 end)

local dashCamAttached = {}
AddEventHandler("fa-menu:dashCamAttached", function(pVehicleNetId, pEnabled)
  dashCamAttached[pVehicleNetId] = pEnabled
end)

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "remove-dashcam-from-vehicle",
--       title = "Remove Dashcam",
--       icon = "#news-job-news-camera",
--       event = "fa-gopro:removeDashCam",
--   },
--   isEnabled = function()
--     local veh = GetVehiclePedIsIn(PlayerPedId())
--     local netId = NetworkGetNetworkIdFromEntity(veh)
--     return not IsDisabled() and dashCamAttached[netId]
--   end
-- }

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "Benny" then
		isInBennyZone = true
        return isInBennyZone
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "Benny" then
		isInBennyZone = false
        return isInBennyZone
    end
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "BennyPD" then
		isInBennyPDZone = true
        return isInBennyPDZone
    end
end)


RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "BennyPD" then
		isInBennyPDZone = false
        return isInBennyPDZone
    end
end)
