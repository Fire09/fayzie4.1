--Example : 
    --{
    --     id = 1,
    --     floors = {
    --         name = "test",
    --         description = "test",
    --         teleport = {
    --             coords = typedata vector3,
    --             heading = 0,
    --             onArriveEvent = "",
    --             onLeaveEvent = "",
    --         },
    --         locked = false,
    --         forceUnlocked = false,
    --         zone = {
    --             center =  ,
    --             width = ,
    --             length = ,
    --             options = {
    --                 data =
    --             },
    --             target = true / false
    --         }
    --     },
    -- }

    ELEVATOR_CONFIG = {
        {
            id = 1,
            floors = {
                {
                    name = "FIB Lobby",
                    description = "Lobby",
                    teleport = {
                        coords = vector3(139.02432250977, -762.98846435547, 45.75199508667),
                        heading = 0,
                        onArriveEvent = "",
                        onLeaveEvent = "",
                    },
                    locked = false,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(139.48, -764.39, 45.75),
                        width = 0.4,
                        length = 0.2,
                        options = {
                            minZ=42.6,
                            maxZ=46.4,
                            debugPoly = false
                        },
                        target = true
                    },
                },
                {
                    name = "FIB Main Floor",
                    description = "Main Floor",
                    teleport = {
                        coords = vector3(136.24949645996, -761.81329345703, 242.15200805664),
                        heading = 0,
                        onArriveEvent = "",
                        onLeaveEvent = "",
                    },
                    locked = false,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(136.63, -763.32, 242.15),
                        width = 0.4,
                        length = 0.2,
                        options = {
                            minZ=238.85,
                            maxZ=242.85,
                            debugPoly = false
                        },
                        target = true
                    },
                },
                {
                    name = "FIB Top Floor",
                    description = "Top Floor",
                    teleport = {
                        coords = vector3(115.20023345947, -741.92028808594, 258.15246582031),
                        heading = 343.59173583984,
                        onArriveEvent = "",
                        onLeaveEvent = "",
                    },
                    locked = true,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(114.76, -742.56, 258.15),
                        width = 0.4,
                        length = 1.3,
                        options = {
                            heading=340,
                            minZ=255.5,
                            maxZ=259.45,
                            debugPoly = false
                        },
                        target = true
                    },
                }
            },
            access = {
                job = {},
                business = {
                  ["fib"] = true,
                },
              },
        },
        {
            id = 3,
            floors = {
                {
                    name = "Basement Level",
                    description = "Spooky...",
                    teleport = {
                        coords = vector3(3540.7160644531, 3675.6850585938, 20.991792678833),
                        heading = 174.01573181152,
                        onArriveEvent = "",
                        onLeaveEvent = "",
                    },
                    locked = false,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(3538.19, 3673.66, 20.99),
                        width = 1,
                        length = 1,
                        options = {
                            heading=350,
                            debugPoly = false
                        },
                        target = true
                    },
                },
                {
                    name = "Main Level",
                    description = "Experiments",
                    teleport = {
                        coords = vector3(3540.626953125, 3675.6848144531, 28.121129989624),
                        heading = 167.94708251953,
                        onArriveEvent = "humane:startHeist",
                        onLeaveEvent = "",
                    },
                    locked = false,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(3542.35, 3674.44, 28.12),
                        width = 2.6,
                        length = 0.8,
                        options = {
                            heading=350,
                            debugPoly = false
                        },
                        target = true
                    },
                },
                {
                    name = "Restricted Level",
                    description = "??????",
                    teleport = {
                        coords = vector3(3558.8232421875, 3699.09375, 50.771167755127),
                        heading = 56.359851837158,
                        onArriveEvent = "",
                        onLeaveEvent = "",
                    },
                    locked = true,
                    forceUnlocked = false,
                    zone = {
                        center = vector3(3558.73, 3699.13, 50.77),
                        width = 1,
                        length = 0.2,
                        options = {
                            heading=325,
                            minZ=48.37,
                            maxZ=52.37,
                            debugPoly = false
                        },
                        target = true
                    },
                }
            },
            access = {
                job = {},
                business = {
                    ["humane_labs"] = true,
                },
              },
        },
    }