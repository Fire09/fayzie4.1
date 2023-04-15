local PedEntries = MenuEntries['peds']

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-escort",
        title = "Escort",
        icon = "#general-escort",
        event = "escortPlayer"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and not isEscorting and pEntity and pContext.flags['isPlayer']
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-unblindfold",
        title = "Remove Blindfold",
        icon = "#blindfold",
        event = "blindfold:blindfold"
    },
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isBlindfolded']
    end
}

PedEntries[#PedEntries+1] = {
  data = {
      id = "cuffs:gag",
      title = "Remove gag",
      icon = "#gag",
      event = "gag:toggle"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isGagged']
  end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-cuffActions",
        title = "Cuff Actions",
        icon = "#cuffs",
    },
    subMenus = {"peds:cuff", "peds:uncuff", "cuffs:remmask", "cuffs:blindfold", "cuffs:gag" }, --"cuffs:checkphone", 
    isEnabled = function(pEntity, pContext)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and ((exports["fa-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-revive",
        title = "Revive",
        icon = "#medic-revive",
        event = "revive",
    },
    isEnabled = function(pEntity, pContext)
        --return not isDead and (isPolice or isDoc or isMedic or isDoctor)
        return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isDead'] and (isPolice or isDoc or isMedic or isDoctor)
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-heal",
        title = "Heal",
        icon = "#medic-heal",
        event = "ems:heal",
    },
    isEnabled = function(pEntity, pContext)
        return not isDead and (isMedic or isDoctor or isDoc)
        --return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and not pContext.flags['isDead'] and (isMedic or isDoctor or isDoc)
    end
}

PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-medicActions",
        title = "Medical Actions",
        icon = "#medic",
    },
    subMenus = {"medic:checktargetstates", "medic:stomachpump", "medic:bloodtest" },
    isEnabled = function(pEntity, pContext)
        return not isDead and (isMedic or isDoctor)
        --return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and (isMedic or isDoctor)
    end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "police-action",
    title = "Police Actions",
    icon = "#police-action",
  },
  subMenus = {"fa-fa-police:frisk", "fa-fa-police:search", "fa-fa-police:fingerprint", "fa-fa-police:checkBank", "fa-fa-police:gsr", "medic:checktargetstates", "fa-fa-police:seizeItems"},
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and (isPolice or isDoc) and pContext.distance <= 1.2
  end
}


-- PedEntries[#PedEntries+1] = {
--     data = {
--       id = "tesla-action",
--       title = "Tesla",
--       icon = "#vehicle-options", 
--     },
--     subMenus = {"tesla:autopilot"},
--     isEnabled = function(pEntity, pContext)
--       return not isDead and GetVehiclePedIsIn(PlayerPedId(), 'models', true) 
--     end
-- }

-- MenuItems['tesla:autopilot'] = {
--     data = {
--         id = "tes-frisk",
--         title = "Auto Pilot",
--         icon = "#tesla-autopilotim",
--         event = "autopilot:toggle",
--     }
-- }
--[[   
  MenuItems['tesla:park'] = {
    data = {
        id = "tes-search",
        title = "Self Park", 
        icon = "#blips-garages",
        event = "parking:call"
    }
}
  
  MenuItems['tesla:come'] = {
      data = {
          id = "tes:remmask",
          title = "Recall vehicle",
          icon = "#ped-give-stolen-items",
          event = "createDrivePath"
      }
}  ]]


PedEntries[#PedEntries+1] = {
  data = {
    id = "steal",
    title = "Steal",
    icon = "#steal",
    event = "fa-fa-police:rob"
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and not (isPolice or isDoc) and pEntity and pContext.flags['isPlayer'] and (isPersonBeingHeldUp(pEntity) or pContext.flags['isDead']) 
  end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "steal-shoes",
    title = "Steal shoes",
    icon = "#shoes",
    event = "shoes:steal"
  },
  isEnabled = function(pEntity, pContext)
    return not IsDisabled() and not (isPolice or isDoc) and pEntity and pContext.flags['isPlayer'] and (pContext.flags['isCuffed'] or pContext.flags['isDead'] or isPersonBeingHeldUp(pEntity))
  end
}


PedEntries[#PedEntries+1] = {
    data = {
      id = "police-props",
      title = "Police Barriers",
      icon = "#police-action-frisk",
    },
    subMenus = {"fa-fa-police:barrier1", "fa-fa-police:barrier2", "fa-fa-police:barrier3","fa-fa-police:pickupp" },
    isEnabled = function(pEntity, pContext)
        return (isPolice or isDoc or isJudge or isMedic)
      end
  }

--barriers

MenuItems['fa-fa-police:barrier1'] = {
data = {
    id = "fa-fa-police:barrier1",
    title = "Cone",
    icon = "#police-action-frisk",
    event = "barriers:cone",
    parameters = { true }
}
}

MenuItems['fa-fa-police:barrier2'] = {
data = {
    id = "fa-fa-police:barrier2",
    title = "Barrier",
    icon = "#police-action-frisk",
    event = "barriers:sbarrier",
    parameters = { true }
}
}

MenuItems['fa-fa-police:barrier3'] = {
data = {
    id = "fa-fa-police:barrier3",
    title = "Road Closure",
    icon = "#police-action-frisk",
    event = "barriers:barrier",
    parameters = { true }
}
}

MenuItems['fa-fa-police:pickupp'] = {
data = {
    id = "fa-fa-police:pickupp",
    title = "Pickup",
    icon = "#police-action-frisk",
    event = "barriers:pickup",
    parameters = { true }
}
}





MenuItems['fa-fa-police:frisk'] = {
  data = {
      id = "peds-frisk",
      title = "Frisk",
      icon = "#police-action-frisk",
      event = "fa-fa-police:frisk",
      parameters = { true }
  }
}

MenuItems['fa-fa-police:search'] = {
  data = {
      id = "peds-search",
      title = "Search",
      icon = "#cuffs-check-inventory",
      event = "fa-fa-police:checkInventory"
  }
}

MenuItems['cuffs:remmask'] = {
    data = {
        id = "cuffs:remmask",
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        event = "fa-fa-police:remmask"
    }
}

MenuItems['peds:cuff'] = {
    data = {
        id = "peds:cuff",
        title = "Cuff",
        icon = "#cuffs-cuff",
        event = "civ:cuffFromMenu"
    },
    isEnabled = function(pEntity, pContext)
        return not isDead and ((exports["fa-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
        --return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and not pContext.flags['isCuffed'] and ((exports["fa-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc))) and pContext.distance <= 1.2
    end
}

MenuItems['peds:uncuff'] = {
    data = {
        id = "peds:uncuff",
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        event = "fa-fa-police:uncuffMenu"
    },
    isEnabled = function(pEntity, pContext)
        return not isDead and ((exports["fa-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
        --return not IsDisabled() and pEntity and pContext.flags['isPlayer'] and pContext.flags['isCuffed'] and ((exports["fa-inventory"]:hasEnoughOfItem("cuffs",1,false) or (isPolice or isDoc)))
    end
}


MenuItems['fa-fa-police:seizeItems'] = {
    data = {
        id = "fa-fa-police:seizeItems",
        title = "Seize Possessions",
        icon = "#steal",
        event = "fa-fa-police:seizeItems"
    },
    isEnabled = function(pEntity, pContext)
      return not isDead and (isPolice or isDoc)
    end
}

-- MenuItems['cuffs:checkphone'] = {
--     data = {
--         id = "cuffs:checkphone",
--         title = "Read Phone",
--         icon = "#cuffs-check-phone",
--         event = "fa-fa-police:checkPhone"
--     }
-- }

MenuItems['cuffs:beatmode'] = {
    data = {
        id = "cuffs:beatmode",
        title = "Beat Mode",
        icon = "#cuffs-beatmode",
        event = "fa-fa-police:startPutInBeatMode"
    }
}

MenuItems['cuffs:blindfold'] = {
    data = {
        id = "cuffs:blindfold",
        title = "Blindfold",
        icon = "#blindfold",
        event = "blindfold:blindfold"
    },
    isEnabled = function(pEntity, pContext)
        return not isDead and ((exports["fa-inventory"]:hasEnoughOfItem("blindfold",1,false)))
        --return not IsDisabled() and pEntity and pContext.flags['isCuffed'] and pContext.flags['isPlayer'] and not pContext.flags['isBlindfolded'] and ((exports["fa-inventory"]:hasEnoughOfItem("blindfold",1,false)))
    end
}

MenuItems['cuffs:gag'] = {
  data = {
      id = "cuffs:gag",
      title = "Gag",
      icon = "#gag",
      event = "gag:toggle"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead and ((exports["fa-inventory"]:hasEnoughOfItem("gag_sock",1,false)))
      --return not IsDisabled() and pEntity and pContext.flags['isCuffed'] and pContext.flags['isPlayer'] and not pContext.flags['isGagged'] and ((exports["fa-inventory"]:hasEnoughOfItem("gag_sock",1,false)))
  end
}

MenuItems['medic:stomachpump'] = {
    data = {
        id = "medic:stomachpump",
        title = "Stomach pump",
        icon = "#medic-stomachpump",
        event = "ems:stomachpump"
    },
    isEnabled = function(pEntity, pContext)
        return isDoctor
    end
}

MenuItems['medic:bloodtest'] = {
  data = {
      id = "medic:bloodtest",
      title = "Blood test",
      icon = "#general-check-over-target",
      event = "ems:bloodtest"
  },
  isEnabled = function(pEntity, pContext)
      return isDoctor
  end
}

MenuItems['medic:checktargetstates'] = {
    data = {
        id = "medic:checktargetstates",
        title = "Examine Target",
        icon = "#general-check-over-target",
        event = "requestWounds"
    }
}

MenuItems['fa-fa-police:fingerprint'] = {
    data = {
        id = "fa-fa-police:fingerprint",
        icon = "#police-action-fingerprint",
        title = "Check Fingerprint",
        event = "fa-fa-police:fingerPrintPlayer"
    },
    isEnabled = function(pEntity, pContext)
        --return not isDead and pContext.flags and isPolice or isDoc
        return not isDead  and isPolice or isDoc
    end
}

MenuItems['fa-fa-police:checkBank'] = {
    data = {
        id = "fa-fa-police:checkBank",
        icon = "#police-check-bank",
        title = "Check Bank",
        event = "fa-fa-police:checkBank"
    },
    isEnabled = function(pEntity, pContext)
        --return not isDead and pContext.flags and isPolice
        return not isDead and isPolice
    end
}

MenuItems['fa-fa-police:gsr'] = {
    data = {
        id = "fa-fa-police:gsr",
        icon = "#police-action-gsr",
        title = "Check GSR",
        event = "fa-fa-police:gsr"
    },
    isEnabled = function(pEntity, pContext)
        --return not isDead and pContext.flags and isPolice
        return not isDead and isPolice
    end
}


MenuItems["fa-fa-police:dnaSwab"] = {
    data = {
        id = "fa-fa-police:dnaSwab",
        icon = "#police-action-fingerprint",
        title = "Collect DNA",
        event = "fa-evidence:dnaSwab"
    },
    isEnabled = function(pEntity, pContext)
        return not isDead and isPolice
    end
}

PedEntries[#PedEntries+1] = {
  data = {
    id = "mobile-data-terminal",
    title = "MDW",
    icon = "#mdt-action",
    event = "fa-mdw:open-mdw"
  },
  isEnabled = function(pEntity, pContext)
    return (isPolice or isDoc or isJudge or isMedic)
  end
}

RegisterNetEvent('fa-mdw:open-mdw')
AddEventHandler('fa-mdw:open-mdw', function()
    ExecuteCommand('+mdw')
end)


PedEntries[#PedEntries+1] = {
    data = {
        id = "peds-revive-var",
        title = "Revive",
        icon = "#medic-revive", 
        event = "np-heists:serverroom:revivePlayer",
    },
    isEnabled = function(pEntity, pContext)
        return pEntity and not isDead and exports["fa-inventory"]:hasEnoughOfItem("varmedkit", 1, false, true)
    end
}