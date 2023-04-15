local listening, currentPrompt = false, nil
local defaultDuiUrl = 'https://i.imgur.com/5Ust2GQ.jpg'
local currentBoardUrl = 'https://i.imgur.com/5Ust2GQ.jpg'
local currentMeetingRoomBoardUrl = 'https://i.imgur.com/5Ust2GQ.jpg'
local inClassRoom, inMeetingRoom = false, false
local dui = nil

Citizen.CreateThread(function()

    exports["fa-polyzone"]:AddPolyZone("mrpd_classroom",
        {vector2(448.41372680664, -990.47613525391), vector2(439.50704956055, -990.55731201172),
         vector2(439.43478393555, -981.08758544922), vector2(448.419921875, -981.26306152344),
         vector2(450.23190307617, -983.00885009766), vector2(450.25042724609, -988.77667236328)}, {
            gridDivisions = 25,
            minZ = 34.04,
            maxZ = 37.69
        })
    exports["fa-polyzone"]:AddBoxZone("mrpd_meetingroom", vector3(474.07, -995.08, 30.69), 10.2, 5.2, {
        heading = 0,
        minZ = 29.64,
        maxZ = 32.84
    })

    exports["fa-polyzone"]:AddBoxZone("mrpd_clothing_lockers", vector3(461.81, -997.79, 30.69), 4.4, 4.8, {
        heading = 0,
        minZ = 29.64,
        maxZ = 32.84
    })

    exports["fa-polyzone"]:AddBoxZone("mrpd_armory", vector3(481.59, -995.35, 30.69), 3.2, 0.8, {
        heading = 90,
        minZ = 29.69,
        maxZ = 32.49
    })

    exports["fa-polyzone"]:AddBoxZone("mrpd_evidence", vector3(474.84, -996.26, 26.27), 1.2, 3.0, {
        heading = 90,
        minZ = 25.27,
        maxZ = 27.87
    })

    exports["fa-polyzone"]:AddBoxZone("mrpd_trash", vector3(472.88, -996.28, 26.27), 1.2, 3.0, {
        heading = 90,
        minZ = 25.27,
        maxZ = 27.87
    })

    exports["fa-polyzone"]:AddBoxZone("mrpd_character_switcher", vector3(478.88, -983.49, 30.69), 1.35, 1.3, {
        heading = 0,
        minZ = 29.74,
        maxZ = 32.74
    })

    -- Davis PD
    exports["fa-polyzone"]:AddBoxZone("davispd_character_switcher", vector3(358.51, -1597.88, 25.45), 1.65, 4.8, {
        heading = 320,
        minZ = 24.45,
        maxZ = 27.25
    })

    exports["fa-polyzone"]:AddBoxZone("davispd_clothing_lockers", vector3(362.38, -1593.53, 25.45), 5.0, 4.2, {
        heading = 320,
        minZ = 24.45,
        maxZ = 27.05
    })

    exports["fa-polyzone"]:AddBoxZone("davispd_armory", vector3(365.28, -1603.51, 25.45), 3.2, 1.4, {
        heading = 319,
        minZ = 24.25,
        maxZ = 26.65
    })

    -- Armory, VBPD
    exports["fa-polyzone"]:AddBoxZone("vbpd_armory", vector3(-1075.05, -830.85, 19.3), 4.6, 1.2, {
        heading = 308,
        minZ = 18.3,
        maxZ = 21.1
    })

    exports["fa-polyzone"]:AddBoxZone("vbpd_clothing_lockers", vector3(-1087.41, -832.43, 19.3), 4.2, 11.2, {
        heading = 308,
        minZ = 18.15,
        maxZ = 21.95
    })

    exports["fa-polyzone"]:AddCircleZone("vbpd_character_switcher", vector3(-1081.85, -834.42, 19.3), 0.5, {
        useZ = true
    })

    exports["fa-polyzone"]:AddCircleZone("vbpd_evidence", vector3(-1099.11, -824.35, 19.3), 0.7, {
        useZ = true
    })

    exports["fa-polyzone"]:AddCircleZone("vbpd_trash", vector3(-1096.47, -818.9, 19.3), 0.3, {
        useZ = true
    })

    exports["fa-polyzone"]:AddBoxZone("sandy_clothing_lockers", vector3(1855.59, 3692.15, 34.22), 2.1, 2.9, {
        heading = 30,
        minZ = 31.42,
        maxZ = 35.42
    })

    exports["fa-polyzone"]:AddBoxZone("sandy_character_switch_evidence_trash_armory", vector3(1862.08, 3690.21, 34.22),
        2.6, 3.8, {
            heading = 30,
            minZ = 32.02,
            maxZ = 36.02
        })

    exports["fa-polyzone"]:AddBoxZone("paleto_clothing_lockers_character_switch_evidence_trash_armory",
        vector3(-449.45, 6015.25, 37.0), 1.4, 3.0, {
            heading = 44,
            minZ = 35.8,
            maxZ = 38.8
        })

    exports["fa-polyzone"]:AddBoxZone("paleto_clothing_lockers_character_switch", vector3(-438.57, 6010.16, 37.0), 4.8,
        3.6, {
            heading = 316,
            minZ = 35.8,
            maxZ = 38.4
        })

    exports["fa-polyzone"]:AddBoxZone("beaverpd_clothing_lockers_character_switch_evidence_trash_armory",
        vector3(387.19, 799.6, 187.46), 1.0, 2.2, {
            heading = 359,
            minZ = 184.86,
            maxZ = 188.86
        })

    exports["fa-polyzone"]:AddBoxZone("doc_clothing_lockers", vector3(1834.65, 2571.73, 46.01), 2.8, 2.2, {
        heading = 0,
        minZ = 45.01,
        maxZ = 47.81
    })

    exports["fa-polyzone"]:AddBoxZone("doc_armory", vector3(1841.37, 2573.99, 46.01), 1.6, 1.6, {
        heading = 0,
        minZ = 45.01,
        maxZ = 47.61
    })

    exports["fa-polyzone"]:AddBoxZone("doc_character_switcher", vector3(1841.34, 2569.78, 46.05), 2.2, 1.8, {
        heading = 0,
        minZ = 45.05,
        maxZ = 47.85
    })

    -- davis pd
    exports["fa-polyzone"]:AddBoxZone("davispd_evidence", vector3(361.84, -1599.58, 25.45), 2.0, 2.0, {
        heading = 50,
        minZ = 24.15,
        maxZ = 26.95
    })

    exports["fa-polyzone"]:AddBoxZone("davispd_trash", vector3(360.72, -1602.23, 25.45), 2, 1.5, {
        heading = 90,
        minZ = 23.35,
        maxZ = 27.35
    })

    -- Prison - Bus Spawn
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(1689.371948, 2605.291992, 44.564999), 5.8, 15.0, {
        heading = 0,
        minZ = 44.56,
        maxZ = 47.56
    })

    -- MRPD - Underground B
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(425.97, -980.22, 25.7), 11.6, 6.4, {
        heading = 0,
        minZ = 24.7,
        maxZ = 29.7
    })

    -- MRPD - Bus Spawn
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(479.43, -1019.49, 27.96), 6.0, 15.0, {
        heading = 0,
        minZ = 26.96,
        maxZ = 28.96
    })

    -- MRPD Helipads
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(466.16, -981.74, 43.69), 13.6, 46.8, {
        heading = 0,
        minZ = 39.89,
        maxZ = 46.89
    })

    -- Vespucci PD Helipad
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(-1095.58, -834.96, 37.68), 14.0, 13.6, {
        heading = 40,
        minZ = 36.48,
        maxZ = 40.68
    })

    -- Paleto PD Helipad
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(-475.69, 5988.67, 31.34), 14.0, 13.6, {
        heading = 40,
        minZ = 30.34,
        maxZ = 34.54
    })

    -- VBPD Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(-1131.84, -836.9, 3.75), 37.35, 62.6, {
        heading = 37,
        minZ = 2.55,
        maxZ = 6.75
    })

    -- Paleto PD Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(-474.19, 6029.99, 31.34), 28.4, 12.8, {
        heading = 315,
        minZ = 30.24,
        maxZ = 34.24
    })

    -- Courthouse PD Shared Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(-585.92, -236.39, 35.7), 36.0, 4.4, {
        heading = 30,
        minZ = 34.7,
        maxZ = 37.9
    })

    -- Sandy PD Shared Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(1847.74, 3671.26, 33.87), 50.6, 7.8, {
        heading = 300.0,
        minZ = 32.27,
        maxZ = 36.07
    })

    -- Beaver Bush PD Shared Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(374.53, 795.94, 187.28), 10, 8, {
        heading = 180.0,
        minZ = 186.08,
        maxZ = 191.28
    })

    -- Sandy Airfield Heli PD Shared
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(1770.36, 3239.85, 41.36), 14.0, 14.8, {
        heading = 15,
        minZ = 40.79,
        maxZ = 45.79
    })

    -- Sandy PD
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(1843.4, 3636.82, 35.64), 11.2, 10.0, {
        heading = 355,
        minZ = 34.24,
        maxZ = 39.44
    })

    -- Davis PD
    exports["fa-polyzone"]:AddBoxZone("pd_shared", vector3(397.73, -1623.0, 29.29), 19.0, 5.8, {
        heading = 320,
        minZ = 28.29,
        maxZ = 31.69
    })

    exports["fa-polyzone"]:AddBoxZone("pd_shared_bike", vector3(1880.59, 3691.18, 33.54), 6.4, 7.0, {
        heading = 30,
        minZ = 32.14,
        maxZ = 35.94
    })

    exports["fa-polyzone"]:AddBoxZone("pd_shared_bike", vector3(-1119.91, -859.81, 13.41), 23.8, 9.6, {
        heading = 304,
        minZ = 12.31,
        maxZ = 17.31
    })

    exports["fa-polyzone"]:AddBoxZone("pd_shared_bike", vector3(-457.98, 6044.63, 31.34), 16.2, 7.0, {
        heading = 45,
        minZ = 30.14,
        maxZ = 35.34
    })

    -- Davis PD Shared Bike Garage
    exports["fa-polyzone"]:AddBoxZone("pd_shared_bike", vector3(389.89, -1611.71, 29.29), 12.4, 6.0, {
        heading = 321,
        minZ = 28.29,
        maxZ = 31.89
    })

    exports["fa-polyzone"]:AddBoxZone("ems_shared", vector3(352.26, -588.32, 74.36), 15.8, 16.4, {
        name = "emschop",
        heading = 330,
        minZ = 73.0,
        maxZ = 76.36
    })

    exports["fa-polyzone"]:AddBoxZone("ems_shared", vector3(-790.76, -1191.65, 53.03), 14.2, 13.2, {
        name = "ems3",
        heading = 320,
        minZ = 51.03,
        maxZ = 55.03
    })

    exports["fa-polyzone"]:AddBoxZone("ems_shared", vector3(1217.43, -1525.4, 34.69), 16.6, 6.4, {
        name = "emsrancho",
        heading = 90,
        minZ = 33.49,
        maxZ = 39.69
    })

    exports["fa-polyzone"]:AddBoxZone("ems_shared", vector3(1814.22, 3686.16, 34.22), 9.2, 5.2, {
        name = "ems_sandy",
        heading = 299,
        minZ = 32.62,
        maxZ = 36.62
    })

    exports["fa-polyzone"]:AddCircleZone("ems_shared", vector3(1865.39, 3647.48, 35.6), 9.75, {
        name = "ems_sandy_heli"
    })

    exports["fa-polytarget"]:AddBoxZone("mrdp_change_picture", vector3(439.44, -985.89, 34.97), 1.0, 0.4, {
        heading = 0,
        minZ = 35.37,
        maxZ = 36.17
    })

    exports["fa-polytarget"]:AddBoxZone("mrpd_meetingroom_screen", vector3(474.02, -1001.79, 30.69), 3.6, 2.8, {
        heading = 1,
        minZ = 30.54,
        maxZ = 32.54
    })

    exports["fa-interact"]:AddPeekEntryByPolyTarget("mrdp_change_picture", {{
        event = "fa-polce:changewhiteboardurl",
        id = 'polcechangewhiteboardurlc',
        icon = "circle",
        label = "Change URL",
        parameters = {
            room = "classroom"
        }
    }}, {
        distance = {
            radius = 2.5
        }
    })

    exports["fa-interact"]:AddPeekEntryByPolyTarget("mrpd_meetingroom_screen", {{
        event = "fa-polce:changewhiteboardurl",
        id = 'polcechangewhiteboardurlm',
        icon = "circle",
        label = "Change URL",
        parameters = {
            room = "meetingroom"
        }
    }}, {
        distance = {
            radius = 2.5
        }
    })

end)

local EVENTS = {
    LOCKERS = 1,
    CLOTHING = 2,
    SWITCHER = 3,
    EVIDENCE = 4,
    TRASH = 5,
    ARMORY = 6
}

local zoneData = {
    mrpd_clothing_lockers = {
        promptText = "[E] Lockers & Clothes",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }}
    },
    vbpd_clothing_lockers = {
        promptText = "[E] Lockers & Clothes",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }}
    },
    davispd_clothing_lockers = {
        promptText = "[E] Lockers & Clothes",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }}
    },
    sandy_clothing_lockers = {
        promptText = "[E] Lockers & Clothes",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }}
    },
    doc_clothing_lockers = {
        promptText = "[E] Lockers & Clothes",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }}
    },
    mrpd_character_switcher = {
        promptText = "[E] Switch Character",
        menuData = {{
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    davispd_character_switcher = {
        promptText = "[E] Switch Character",
        menuData = {{
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    vbpd_character_switcher = {
        promptText = "[E] Switch Character",
        menuData = {{
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    doc_character_switcher = {
        promptText = "[E] Switch Character",
        menuData = {{
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    sandy_character_switch_evidence_trash_armory = {
        promptText = "[E] Station Services",
        menuData = {{
            title = "Armory",
            description = "WEF - Weapons, Equipment, Fun!",
            action = "fa-police:handler",
            key = EVENTS.ARMORY
        }, {
            title = "Evidence",
            description = "Drop off some evidence",
            action = "fa-police:handler",
            key = EVENTS.EVIDENCE
        }, {
            title = "Trash",
            description = "Where Spaghetti Code belongs",
            action = "fa-police:handler",
            key = EVENTS.TRASH
        }, {
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    mrpd_trash = {
        promptText = "[E] Trash"
    },
    vbpd_trash = {
        promptText = "[E] Trash"
    },
    davispd_trash = {
        promptText = "[E] Trash"
    },
    mrpd_armory = {
        promptText = "[E] Armory"
    },
    vbpd_armory = {
        promptText = "[E] Armory"
    },
    davispd_armory = {
        promptText = "[E] Armory"
    },
    doc_armory = {
        promptText = "[E] Armory"
    },
    mrpd_evidence = {
        promptText = "[E] Evidence"
    },
    vbpd_evidence = {
        promptText = "[E] Evidence"
    },
    davispd_evidence = {
        promptText = "[E] Evidence"
    },
    doc_trash = {
        promptText = "[E] Trash"
    },
    doc_trash2 = {
        promptText = "[E] Trash"
    },
    paleto_clothing_lockers_character_switch = {
        promptText = "[E] Station Services",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }, {
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    },
    paleto_clothing_lockers_character_switch_evidence_trash_armory = {
        promptText = "[E] Station Services",
        menuData = {{
            title = "Armory",
            description = "WEF - Weapons, Equipment, Fun!",
            action = "fa-police:handler",
            key = EVENTS.ARMORY
        }, {
            title = "Evidence",
            description = "Drop off some evidence",
            action = "fa-police:handler",
            key = EVENTS.EVIDENCE
        }, {
            title = "Trash",
            description = "Where Spaghetti Code belongs",
            action = "fa-police:handler",
            key = EVENTS.TRASH
        }}
    },
    beaverpd_clothing_lockers_character_switch_evidence_trash_armory = {
        promptText = "[E] Station Services",
        menuData = {{
            title = "Lockers",
            description = "Access your personal locker",
            action = "fa-police:handler",
            key = EVENTS.LOCKERS
        }, {
            title = "Clothing",
            description = "Gotta look Sharp",
            action = "fa-police:handler",
            key = EVENTS.CLOTHING
        }, {
            title = "Armory",
            description = "WEF - Weapons, Equipment, Fun!",
            action = "fa-police:handler",
            key = EVENTS.ARMORY
        }, {
            title = "Evidence",
            description = "Drop off some evidence",
            action = "fa-police:handler",
            key = EVENTS.EVIDENCE
        }, {
            title = "Trash",
            description = "Where Spaghetti Code belongs",
            action = "fa-police:handler",
            key = EVENTS.TRASH
        }, {
            title = "Character switch",
            description = "Go bowling with your cousin",
            action = "fa-police:handler",
            key = EVENTS.SWITCHER
        }}
    }
}

RegisterInterfaceCallback("fa-police:handler", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local eventData = data.key
    local location = currentPrompt ~= nil and string.match(currentPrompt, "(.-)_") or ''
    local job = exports["isPed"]:isPed("myjob")
    if eventData == EVENTS.LOCKERS and (job == "police" or job == "doc") then
        local cid = exports["isPed"]:isPed("cid")
        TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
    elseif eventData == EVENTS.CLOTHING then
        exports["fa-interface"]:hideInteraction()
        Wait(500)
        TriggerEvent("raid_clothes:openClothing", true, true)
    elseif eventData == EVENTS.SWITCHER then
        isCop = false
        TransitionToBlurred(500)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerEvent("fa-base:clearStates")
        exports["fa-base"]:getModule("SpawnManager"):Initialize()
        Wait(1000)
    elseif eventData == EVENTS.EVIDENCE and (job == "police" or job == "doc") then
        TriggerEvent("server-inventory-open", "1", ("%s_evidence"):format(location))
    elseif eventData == EVENTS.TRASH and (job == "police" or job == "doc") then
        TriggerEvent("server-inventory-open", "1", ("%s_trash"):format(location))
    elseif eventData == EVENTS.ARMORY and (job == "police" or job == "doc") then
        TriggerEvent("server-inventory-open", "10", "Shop")
    end
    cb({
        data = {},
        meta = {
            ok = true,
            message = "done"
        }
    })
end)

local function listenForKeypress(pZone)
    listening = true
    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                local job = exports["isPed"]:isPed("myjob")
                if pZone == "mrpd_clothing_lockers" or pZone == "vbpd_clothing_lockers" or pZone ==
                    "sandy_clothing_lockers" or pZone == "doc_clothing_lockers" or pZone ==
                    "paleto_clothing_lockers_character_switch_evidence_trash_armory" or pZone ==
                    "davispd_clothing_lockers" or pZone == "paleto_clothing_lockers_character_switch" then
                    exports["fa-interface"]:showContextMenu(zoneData[pZone].menuData)
                elseif pZone == "beaverpd_clothing_lockers_character_switch_evidence_trash_armory" and
                    (job == "police" or job == "doc") then
                    exports["fa-interface"]:showContextMenu(zoneData[pZone].menuData)
                elseif pZone == "mrpd_character_switcher" or pZone == "vbpd_character_switcher" or pZone ==
                    "sandy_character_switch_evidence_trash_armory" or pZone == 'doc_character_switcher' or pZone ==
                    'davispd_character_switcher' then
                    exports["fa-interface"]:showContextMenu(zoneData[pZone].menuData)
                elseif (pZone == "mrpd_armory" or pZone == "vbpd_armory" or pZone == "doc_armory" or pZone ==
                    "davispd_armory") and (job == "police" or job == "doc") then
                    TriggerEvent("server-inventory-open", "10", "Shop")
                elseif pZone == "mrpd_trash" or pZone == "vbpd_trash" or pZone == "doc_trash" or pZone ==
                    "davispd_trash" or pZone == "doc_trash2" and (job == "police" or job == "doc") then
                    TriggerEvent("server-inventory-open", "1", pZone)
                elseif pZone == "mrpd_evidence" or pZone == "vbpd_evidence" or pZone == "davispd_evidence" and
                    (job == "police" or job == "doc") then
                    TriggerEvent("server-inventory-open", "1", pZone)
                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
                end
            end
            Wait(0)
        end
    end)
end

AddEventHandler("fa-polyzone:enter", function(zone)
    local currentZone = zoneData[zone]
    if currentZone then -- and isCop
        currentPrompt = zone
        local prompt = type(currentZone.promptText) == 'function' and currentZone.promptText() or currentZone.promptText
        exports["fa-interface"]:showInteraction(prompt)
        listenForKeypress(zone)
    end
end)

AddEventHandler("fa-polyzone:exit", function(zone)
    local currentZone = zoneData[zone]
  if currentZone then
        exports["fa-interface"]:hideInteraction()
        listening = false
        currentPrompt = nil
    end
end)

AddEventHandler('fa-inventory:itemUsed', function(itemId, itemInfo, inventoryName, slot)
    if itemId ~= "pdevidencebag" then
        return
    end
    local metaData = json.decode(itemInfo)
    if not metaData.inventoryId then
        exports['fa-interface']:openApplication('textbox', {
            callbackUrl = 'fa-interface:saveEvidenceBag',
            key = {
                slot = slot
            },
            items = {{
                icon = "circle",
                label = "Bag Name",
                name = "name"
            }},
            show = true
        })
        return
    end
    TriggerEvent("inventory-open-container", metaData.inventoryId, metaData.slots, metaData.weight)
end)

RegisterInterfaceCallback("fa-interface:saveEvidenceBag", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['fa-interface']:closeApplication('textbox')

    local genId = tostring(math.random(10000, 99999999))
    local invId = "container-" .. genId .. "-evidence bag"
    local metaData = json.encode({
        inventoryId = invId,
        bagName = data.values.name,
        slots = 15,
        weight = 10,
        _hideKeys = {'inventoryId', 'slots', 'weight'}
    })
    TriggerEvent('inventory:updateItem', 'pdevidencebag', data.key.slot, metaData)
end)
