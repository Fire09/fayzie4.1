Citizen.CreateThread(function()

    exports["fa-polyzone"]:AddBoxZone("wifi1", vector3(-225.95, -1329.81, 30.89), 9.4, 6.2, {
        name="wifi1",
        heading=0,
        --debugPoly=false,
        minZ=29.89,
        maxZ=33.69
    })

    exports["fa-polyzone"]:AddBoxZone("wifi2", vector3(237.35, -571.11, 43.27), 31.8, 14.4, {
        name="wifi2",
        heading=338,
        --debugPoly=false,
        minZ=41.97,
        maxZ=47.17
    })

    exports["fa-polyzone"]:AddBoxZone("wifi3", vector3(-214.61, -1598.55, 34.89), 15.6, 35.2, {
        name="wifi3",
        heading=264,
        --debugPoly=false,
        minZ=33.89,
        maxZ=41.89
        })

    exports["fa-polyzone"]:AddBoxZone("wifi4", vector3(444.43, -222.39, 55.97), 20.8, 17.55, {
        name="wifi4",
        heading=340,
        --debugPoly=false,
        minZ=54.97,
        maxZ=58.97
        })

    exports["fa-polyzone"]:AddBoxZone("wifi5", vector3(-1676.42, -294.16, 51.81), 35.8, 40.4, {
        name="wifi5",
        heading=322,
        --debugPoly=false,
        minZ=49.61,
        maxZ=53.61
        })
    exports["fa-polyzone"]:AddBoxZone("wifi6", vector3(1661.1, 1.27, 166.12), 10.2, 5.4, {
        name="wifi6",
        heading=32,
        --debugPoly=false,
        minZ=164.72,
        maxZ=168.72
      })
    exports["fa-polyzone"]:AddBoxZone("wifi7", vector3(-153.95, 6433.65, 31.92), 3.0, 3.2, {
        name="wifi7",
        heading=315,
        --debugPoly=false,
        minZ=29.32,
        maxZ=33.32
      })
      

    exports["fa-polytarget"]:AddBoxZone("fa-phone:takeDarkMarket", vector3(509.31, 3099.43, 41.31), 1.3, 0.5, {
        DebugPoly=false,
        heading=320,
        minZ=40.31,
        maxZ=42.71
    })

    exports['fa-interact']:AddPeekEntryByPolyTarget('fa-phone:takeDarkMarket', {{
        event = "fa-phone:takeDMarket",
        id = "novel_takeDarkMarket",
        icon = "fas fa-circle",
        label = "Take it!",
        }}, { distance = { radius = 5.5 }  , isEnabled = function(pEntity, pContext) return exports["fa-phone"]:orderingItem() end })
end)
