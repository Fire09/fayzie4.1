local Entries = {}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChicken' },
    data = {
        {
            id = 'chicken',
            label = "Slaught Chicken",
            icon = "circle",
            event = "portionthechicken",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isSafe' },
    data = {
        {
            id = 'RobSafe',
            label = "Smash!",
            icon = "hammer",
            event = "fa-heists:safe:rob",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'use_gas',
            label = " Use Gas Pump",
            icon = "gas-pump",
            event = "fa-fuel:SelectFuel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
        isEnabled = function(pEntity, pContext)
            return not exports['fa-fuel']:hasNozle()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'return_hose',
            label = "Return Hose",
            icon = "hand-holding",
            event = "fa-fuel:ReturnNozel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
        isEnabled = function(pEntity, pContext)
            return exports['fa-fuel']:hasNozle()
        end
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChickenPack' },
    data = {
        {
            id = 'ChickenPack',
            label = "Pack the Chicken",
            icon = "circle",
            event = "packingchicken",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isYogaMat' },
    data = {
        {
            id = 'yoga',
            label = "Yoga",
            icon = "circle",
            event = "fa-healthcare:yoga",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return IsEntityTouchingEntity(PlayerPedId(), pEntity)
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isExercise' },
    data = {
        {
            id = 'weights',
            label = "Weights",
            icon = "circle",
            event = "fa-healthcare:exercise",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.2 },
    }
}

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isSmokeMachineTrigger' },
--     data = {
--         {
--             id = 'smoke_machine',
--             label = "Smoke Machine",
--             icon = "circle",
--             event = "fa-stripclub:smokemachine",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 1.2 },
--     }
-- }

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'jerrycan_refill',
            label = "Refill Can",
            icon = "circle",
            event = "vehicle:refuel:showMenu",
            parameters = { isJerryCan = true }
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return HasWeaponEquipped(GetHashKey('WEAPON_PetrolCan'))
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isVendingMachine' },
    data = {
        {
            id = 'vending_machine',
            label = "Browse",
            icon = "shopping-basket",
            event = "shops:food",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isHotDogStand' },
    data = {
        {
            id = 'vending_machine_hotdog',
            label = "Menu",
            icon = "shopping-basket",
            event = "shops:hotdog",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isTrash' },
    data = {
        {
            id = 'search',
            label = "Search Dumpster",
            icon = "circle",
            event = "fa-dumpster",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFruitStand' },
    data = {
        {
            id = 'vending_machine_fruitstand',
            label = "Purchase Fruits",
            icon = "shopping-basket",
            event = "shops:fruits",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isBurgerStand' },
    data = {
        {
            id = 'vending_machine_burger',
            label = "Menu",
            icon = "shopping-basket",
            event = "shops:burger",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isGumball' },
    data = {
        {
            id = 'vending_machine_gumball',
            label = "Put a Dollar in",
            icon = "shopping-basket",
            event = "kosta:gumball",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChair' },
    data = {
        {
            id = 'sit_on_chair',
            label = _L("interact-sit", "Sit"),
            icon = "chair",
            event = "fa-emotes:sitOnChair",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isStopSign' },
    data = {
        {
            id = 'steal_sign',
            label = "Steal!",
            icon = "hammer",
            event = "fa-usableprops:stealStopSign",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}


--[[Entries[#Entries + 1] = {
    type = 'model',
    group = { 'isStopSign' },
    data = {
        {
            id = 'fa-usableprops:stealStopSign',
            label = "Steal!",
            icon = "hammer",
            event = "fa-usableprops:stealStopSign",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
  }]]

  
Entries[#Entries + 1] = {
    type = 'model',
    group = { 307287994 },
    data = {
        {
            id = 'hunting_shibiz',
            label = "Skin Animal",
            icon = "circle",
            event = "fa-hunting:skinAnimal",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { -832573324 },
    data = {
        {
            id = 'hunting_shibiz',
            label = "Skin Animal",
            icon = "circle",
            event = "fa-hunting:skinAnimal",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { -664053099 },
    data = {
        {
            id = 'hunting_shibiz',
            label = "Skin Animal",
            icon = "circle",
            event = "fa-hunting:skinAnimal",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { 1682622302 },
    data = {
        {
            id = 'hunting_shibiz',
            label = "Skin Animal",
            icon = "circle",
            event = "fa-hunting:skinAnimal",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isATM' },
    data = {
        {
            id = 'use_atm',
            label = "Use ATM",
            icon = "credit-card",
            event = "bank:openatm",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}
 
--[[Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isHunting' },
  data = {
      {
          id = 'Hunting',
          label = "Start Hunting",
          icon = "circle",
          event = "fa-hunting:start",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isHuntingStop' },
  data = {
      {
          id = 'HuntingStop',
          label = "Return Hunting Equipment",
          icon = "circle",
          event = "fa-hunting:stop",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}]]

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeedPlant' },
    data = {
        { 
            id = 'weed',
            label = _L("interact-weedplant-check", "Check"),
            icon = "cannabis",
            event = "fa-weed:checkPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isLrgWeedPlant' },
    data = {
        {
            id = 'weed2',
            label = _L("interact-weedplant-harvest", "Harvest"),
            icon = "hand-paper",
            event = "fa-weed:pickPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBeehive' },
  data = {
      {
          id = 'beehive1',
          label = _L("interact-beehive-check", "Check"),
          icon = "archive",
          event = "fa-beekeeping:checkBeehive",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 7.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBeehive' },
  data = {
      {
          id = 'beehive2',
          label = _L("interact-beehive-harvest", "Harvest"),
          icon = "hand-holding-water",
          event = "fa-beekeeping:harvestHive",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 7.0 }
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin2' },
    data = {
        {
            id = 'Pin2',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:secpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin3' },
    data = {
        {
            id = 'Pin3',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:thirdpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin4' },
    data = {
        {
            id = 'Pin4',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:fourthpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

--[[Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_ch_cash_trolly_01c` },
  data = {
      {
          id = 'trolleygrab',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:firsttrolley",
          parameters = { type = "cash" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_ch_gold_trolly_01c` },
  data = {
      {
          id = 'trolleygrabgold',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:secondtrolley",
          parameters = { type = "gold" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_cash_trolly_01c` },
  data = {
      {
          id = 'trolleygrab2',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:thirdtrolley",
          parameters = { type = "cash" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}]]

Entries[#Entries + 1] = {
  type = 'model',
  group = { 'isMech' },
  data = {
      {
          id = 'mech:craft',
          label = "Start Crafting",
          icon = "circle",
          event = "mech:craft",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { `ch_prop_gold_trolly_01c` },
    data = {
        {
            id = 'trolleygrabgold',
            label = "Grab it!",
            icon = "hand-holding",
            event = "fa-loot_gold_tray",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
  }
  
  Entries[#Entries + 1] = {
    type = 'model',
    group = { 269934519 },
    data = {
        {
            id = 'fleeca_heist',
            label = "Grab it",
            icon = "circle",
            event = "fa-loot_cash_tray",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)
