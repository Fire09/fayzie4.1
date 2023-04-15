Generic = {}
Generic.NPCS = {}

Generic.SpawnLocations = {
  vector4(-1605.03,-994.58,7.53 - 1.0,136.79),
}

Generic.ShopKeeperLocations = {
  vector4(24.896705627441, -1346.8747558594, 28.482055664062, 272.1259765625),
  vector4(-47.380218505859, -1758.6329345703, 28.414672851562, 45.354328155518),
  vector4(-706.087890625, -914.47912597656, 18.20361328125, 90.708656311035),
  vector4(-1221.3890380859, -907.912109375, 11.312133789062, 28.34645652771),
  vector4(1134.2506103516, -983.20880126953, 45.399291992188, 277.79528808594),
  vector4(1164.9099121094, -323.60440063477, 68.197021484375, 93.543304443359),
  vector4(373.0813293457, 326.75604248047, 102.55383300781, 255.11810302734),
  vector4(-1819.5560302734, 793.55603027344, 137.0791015625, 133.22833251953),
  vector4(2556.8044433594, 381.25714111328, 107.60876464844, 0.0),
  vector4(1165.2263183594, 2710.8395996094, 37.142822265625, 181.41732788086),
  vector4(1391.8154296875, 3606.1450195312, 32.97509765625, 192.75592041016),
  vector4(1697.3670654297, 4923.4155273438, 41.052001953125, 331.65353393555),
  vector4(1728.4219970703, 6415.384765625, 34.025634765625, 243.77952575684),
  vector4(161.03736877441, 6641.630859375, 30.689331054688, 226.77166748047),
  vector4(-3242.5185546875, 1000.4307861328, 11.817626953125, 0.0),
  vector4(-3039.5341796875, 584.78240966797, 6.8974609375, 14.173228263855),
  vector4(-2966.38671875, 391.62197875977, 14.041748046875, 87.874015808105),
  vector4(1960.2329101562, 3740.4790039062, 31.329711914062, 303.30709838867),
  vector4(548.71649169922, 2670.8835449219, 41.153076171875, 96.377944946289),
  vector4(2677.8989257812, 3279.9560546875, 54.228515625, 331.65353393555)
}

Generic.SportsShopLocations = {
  vector4(-703.37164306641, -1179.4047851562, 9.609468460083, 122.92682647705),
  vector4(-23.520534515381, -106.42227935791, 56.061752319336, 154.0001373291)
}

Generic.DigitalShopLocations = {
  vector4(1134.5090332031, -468.16110229492, 65.485946655273, 165.39506530762)
}

Generic.HuntingShopLocations = {
  vector4(-679.46, 5839.32, 16.34, 218.69),
}

Generic.WeaponShopLocations = {
  vector4(17.934066772461, -1107.9560546875, 28.785400390625, 158.74015808105),
  vector4(813.67913818359, -2155.2395019531, 28.616821289062, 357.16534423828),
  vector4(841.16046142578, -1029.1120605469, 27.1845703125, 274.96063232422),
  vector4(-1310.4263916016, -394.36483764648, 35.693725585938, 348.6614074707),
  vector4(-3167.4592285156, 1087.1604003906, 19.838134765625, 150.23622131348),
  vector4(-1112.8483886719, 2697.5869140625, 17.546508789062, 133.22833251953),
  vector4(2564.7824707031, 298.31210327148, 107.72668457031, 274.96063232422),
  vector4(1697.5648193359, 3757.7275390625, 33.688598632812, 141.7322845459),
  vector4(-326.42636108398, 6081.61328125, 30.453491210938, 133.22833251953),
  vector4(247.37142944336, -51.586814880371, 68.9384765625, 345.82678222656)
}

Generic.ToolShopLocations = {
  vector4(44.838947296143, -1748.5364990234, 28.549386978149, 35.3),
  vector4(2749.2309570313, 3472.3308105469, 54.679393768311, 244.4),
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "recycle_exchange",
  name = "Recycle Exchange",
  pedType = 4,
  model = "s_m_y_garbage",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-321.53405761719,-1545.982421875,30.015380859375),
    heading = 0.0,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isRecycleExchange'] = true
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "scuba_diving-startjob",
  name = "Scuba Diving",
  pedType = 4,
  model = "s_m_y_garbage",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-1611.862, 5261.747, 3.0),
    heading = 203.0859,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "paintball_getgear",
  name = "Paint Ball Get Gear",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(5490.568, 6006.509, 589.1),
    heading = 279.929,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "paintball_Maingamemenu",
  name = "Paint Ball Game Menu",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(5505.188, 6025.734, 589.1),
    heading = 158.162,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "fishing_selectzone",
  name = "Fishing Select Zone",
  pedType = 4,
  model = "a_m_y_stwhi_02",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(1530.3297119141, 3778.4174804688, 33.503295898438),
    heading = 226.77166748047,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "postop_ped",
  name = "Post OP Job",
  pedType = 4,
  model = "ig_floyd",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-417.9560546875, -2792.6110839844, 4.993408203125),
    heading = 226.77166748047,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "taxi_status",
  name = "Taxi Clock On",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(895.236, -179.2208, 73.7),
    heading = 242.135,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "hunting_buy",
  name = "Hunting BuyShit",
  pedType = 4,
  model = "ig_hunter",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-775.97802734375, 5602.998046875, 32.728149414062),
    heading = 257.95275878906,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "hunting_sell",
  name = "Hunting SellShit",
  pedType = 4,
  model = "ig_hunter",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(2545.1604003906, 2591.89453125, 36.940673828125),
    heading = 107.71653747559,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "mining_sales",
  name = "Mining Sales",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-1463.94, -182.22, 47.8),
    heading = 34.0157,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = false,
  }
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "rental_purchase",
  name = "Rental Dude",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(110.5345, -1090.946,28.3),
    heading = 356.434,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = false,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "oxyruns_grab_packages",
  name = "Oxy Get Packages",
  pedType = 4,
  model = "g_m_y_strpunk_02",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(563.56, -1024.84, 31.8),
    heading = 98.15,
    random = false
  },
  appearance =
   nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "crim_taco_purchase",
  name = "Weed GetList",
  pedType = 4,
  model = "g_m_m_mexboss_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-1210.325,-1022.4395,1.2),
    heading = 174.773,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "crim_taco_package",
  name = "Weed package",
  pedType = 4,
  model = "g_m_y_strpunk_02",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(499.503,-1963.7010,24.0),
    heading = 125.373,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "heist_laptop_availabli",
  name = "Hiest Availablity",
  pedType = 4,
  model = "g_m_m_chicold_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-1365.82421875,-482.215393066,30.6),
    heading = 51.0236,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "heist_laptop_buySpot",
  name = "Hiest Buy Laplops",
  pedType = 4,
  model = "g_m_m_chicold_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-1360.6153564453,-757.87249755859,21.3),
    heading = 284.086,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
    },
    scenario = "WORLD_HUMAN_STAND_MOBILE"
  }

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "houserobbery_getjob",
  name = "Get HouseRobbery Job",
  pedType = 4,
  model = "g_m_m_chicold_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(206.63735961914,-1851.4681396484,26.476928710938),
    heading = 138.89762878418,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}



Generic.NPCS[#Generic.NPCS + 1] = {
  id = "houserobbery_sellstolen_items",
  name = "HouseRobbery Sell Items",
  pedType = 4,
  model = "cs_barry",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-262.905487060,2195.9736,129.4),
    heading = 243.779,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "chop_shop",
  name = "Chop Shop",
  pedType = 4,
  model = "a_m_y_smartcaspat_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(-226.2, -1329.58, 29.89),
    heading = 269.51,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isChopShopCreate'] = true
  },
  scenario = "WORLD_HUMAN_SMOKING"
}

-- hotspot shit

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot1",
  name = "Hotspot 1",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(-320.27, -1389.77, 35.5),
    heading = 106.1,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot2",
  name = "Hotspot 2",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(1017.18, -2528.91, 27.4),
    heading = 72.91,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot3",
  name = "Hotspot 3",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(739.86, -1399.48, 26.91),
    heading = 179.22,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot5",
  name = "Hotspot 5",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(-1680.45, -291.6, 50.9),
    heading = 205.49,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot6",
  name = "Hotspot 6",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(1656.82, 4.47, 165.1),
    heading = 249.39,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "Hotspot7",
  name = "Hotspot 7",
  pedType = 4,
  model = "a_m_y_mexthug_01",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(-154.26, 6433.84, 30.9),
    heading = 224.4,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
    ['isNPC'] = false,
  },
  scenario = "WORLD_HUMAN_SMOKING"
}


-- Generic.NPCS[#Generic.NPCS + 1] = {
--   id = "tier_1_c",
--   name = "Tier 1",
--   pedType = 4,
--   model = "a_m_m_og_boss_01",
--   networked = false,
--   distance = 30.0,
--   position = {
--     coords = vector3(206.63735961914,-1851.4681396484,26.476928710938),
--     heading = 138.89762878418,
--     random = false
--   },
--   appearance = nil,
--   settings = {
--       { mode = "invincible", active = true },
--       { mode = "ignore", active = true },
--       { mode = "freeze", active = true }
--   },
--   flags = {
--       ['isNPC'] = true,
--       ['isCraftOneCreate'] = true
--   },
--   scenario = "WORLD_HUMAN_LEANING"
-- }

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "junk_yard",
  name = "Junk Yark Bitch",
  pedType = 4,
  model = "a_m_m_salton_02",
  networked = false,
  distance = 30.0,
  position = {
    coords = vector3(-441.1516418457,-1695.8637695312,17.93408203125),
    heading = 164.4094543457,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isJunkExchange'] = true
  },
  scenario = "WORLD_HUMAN_LEANING"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "townhall_yoga",
  name = "Yoga dude",
  pedType = 4,
  model = "a_m_y_surfer_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-508.25, -224.3, 35.65),
    heading = 177.21,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "paycheck_banker",
  name = "Bank Account Manager",
  pedType = 4,
  model = "cs_bankman",
  networked = false,
  distance = 25.0,
  position = {
    coords = vector3(269.27, 217.17, 106.28),
    heading = 70.48,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
      { mode = "collision", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isBankAccountManager'] = true
  },
}


-- Generic.NPCS[#Generic.NPCS + 1] = {
--   id = "heist_bobcat_queueTruck",
--   name = "Hiests Bobcat Queue for truck",
--   pedType = 4,
--   model = "cs_barry",
--   networked = false,
--   distance = 150.0,
--   position = {
--     coords = vector3(-104.4985, -69.38, 57.9),
--     heading = 295.487,
--     random = false
--   },
--   appearance = nil,
--   settings = {
--       { mode = "invincible", active = true },
--       { mode = "ignore", active = true },
--       { mode = "freeze", active = true }
--   },
--   flags = {
--       ['isNPC'] = true,
--   }
-- }
