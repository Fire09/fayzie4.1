PED_COMPONENTS_IDS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
playerApperance = nil
currentFadeStyle = {}
playerTattoos = {}
local firstspawn = false
local finishedClothing = false

playerHeadBlend = {
    ["shapeFirst"] = 0,
    ["shapeSecond"] = 0,
    ["shapeThirt"] = 0,
    ["skinFirst"] = 0,
    ["skinSecond"] = 0,
    ["shapeMix"] = 0,
    ["skinMix"] = 0,
    ["thirdMix"] = 0,
}

hairDecorDefault = {'mpbeach_overlays', "FM_hair_fuzz"} --if the haircut is not there, add some hair fuzz. It will not always match, but it's better than having the hair look "glued on".

hairDecor = {
    ['m'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "FM_M_Hair_001_a"},
        [2] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_M_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_M_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_M_Hair_long_a"},
        [6] = {"multiplayer_overlays", "FM_M_Hair_006_a"},
        [8] = {"multiplayer_overlays", "FM_M_Hair_008_a"},
        [9] = {"multiplayer_overlays", "NG_M_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_M_Hair_013"},
        [11] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [12] = {"multiplayer_overlays", "NG_M_Hair_011"},
        [13] = {"multiplayer_overlays", "NG_M_Hair_012"},
        [14] = {"multiplayer_overlays", "NG_M_Hair_014"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_M_Hair_000"},
        [17] = {"multiplayer_overlays", "NGBea_M_Hair_001"},
        [18] = {"mpbusiness_overlays", "FM_Bus_M_Hair_000_a"},
        [19] = {"mpbusiness_overlays", "FM_Bus_M_Hair_001_a"},
        [20] = {"mphipster_overlays", "FM_Hip_M_Hair_000_a"},
        [21] = {"mphipster_overlays", "FM_Hip_M_Hair_001_a"},
        [22] = {"multiplayer_overlays", "NGInd_M_Hair_000"},
            --23
        [24] = {"mplowrider_overlays", "LR_M_Hair_000"},
        [25] = {"mplowrider_overlays", "LR_M_Hair_001"},
        [26] = {"mplowrider_overlays", "LR_M_Hair_002"},
        [27] = {"mplowrider_overlays", "LR_M_Hair_003"},
        [28] = {"mplowrider2_overlays", "LR_M_Hair_004"},
        [29] = {"mplowrider2_overlays", "LR_M_Hair_005"},
        [30] = {"mplowrider2_overlays", "LR_M_Hair_006"},
        [31] = {"mpbiker_overlays", "MP_Biker_Hair_000_M"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_001_M"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_002_M"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_003_M"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_004_M"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_M"},

        [72] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_000_M"},
        [73] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_001_M"},
        [74] = {"mpvinewood_overlays", "MP_Vinewood_Hair_M_000_M"},
        [75] = {"mptuner_overlays", "MP_Tuner_Hair_001_M"},
        [76] = {"mpsecurity_overlays", "MP_Security_Hair_001_M"},
    },
    ['f'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "NG_F_Hair_001"},
        [2] = {"multiplayer_overlays", "NG_F_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_F_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_F_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_F_Hair_005_a"},
        [6] = {"multiplayer_overlays", "FM_F_Hair_006_a"},
        [7] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [8] = {"multiplayer_overlays", "NG_F_Hair_008"},
        [9] = {"multiplayer_overlays", "NG_F_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_F_Hair_010"},
        [11] = {"multiplayer_overlays", "NG_F_Hair_011"},
        [12] = {"multiplayer_overlays", "NG_F_Hair_012"},
        [13] = {"multiplayer_overlays", "FM_F_Hair_013_a"},
        [14] = {"multiplayer_overlays", "FM_F_Hair_014_a"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_F_Hair_000"},
        [17] = {"mpbusiness_overlays", "FM_Bus_F_Hair_a"},
        [18] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [19] = {"multiplayer_overlays", "NGBus_F_Hair_000"},
        [20] = {"multiplayer_overlays", "NGBus_F_Hair_001"},
        [21] = {"multiplayer_overlays", "NGBea_F_Hair_001"},
        [22] = {"mphipster_overlays", "FM_Hip_F_Hair_000_a"},
        [23] = {"multiplayer_overlays", "NGInd_F_Hair_000"},
        --24
        [25] = {"mplowrider_overlays", "LR_F_Hair_000"},
        [26] = {"mplowrider_overlays", "LR_F_Hair_001"},
        [27] = {"mplowrider_overlays", "LR_F_Hair_002"},
        [29] = {"mplowrider2_overlays", "LR_F_Hair_003"},
        [30] = {"mplowrider2_overlays", "LR_F_Hair_004"},
        [31] = {"mplowrider2_overlays", "LR_F_Hair_006"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_000_F"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_001_F"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_002_F"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_003_F"},
        [38] = {"mpbiker_overlays", "MP_Biker_Hair_004_F"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},
        [37] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},

        [76] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_000_F"},
        [77] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_001_F"},
        [78] = {"mpvinewood_overlays", "MP_Vinewood_Hair_F_000_F"},
        [79] = {"mptuner_overlays", "MP_Tuner_Hair_000_F"},
        [80] = {"mpsecurity_overlays", "MP_Security_Hair_000_F"},
    },
}
Citizen.CreateThread(function()  
    for k, _ in pairs (Config.Stores) do
        local blipConfig = Config.Blips[Config.Stores[k].shopType]
        local blip = AddBlipForCoord(Config.Stores[k].coords.x, Config.Stores[k].coords.y, Config.Stores[k].coords.z)
        SetBlipSprite(blip, blipConfig.Sprite)
        SetBlipColour(blip, blipConfig.Color)
        SetBlipScale(blip, blipConfig.Scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipConfig.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    local TextureNames = RPC.execute("fa-clothing:getTextureNames")
    Config.SetShops()
    Citizen.Wait(500)
    return TextureNames
end)

function SendReactMessage(action, data)
    SendNUIMessage({
      action = action,
      data = data
    })
end

local current = {
    ["mask"] = {
        id = 1,
        item = 0,
        texture = 0
    },
    ["hat"] = {
        id = 0,
        item = 0,
        texture = 0
    },
    ["glasses"] = {
        id = 1,
        item = 0,
        texture = 0
    },
    ["tshirt"] = {
        id = {
            torso = 11,
            tshirt = 8,
            arms = 3
        },
        item = {
            torso = 0,
            tshirt = 0,
            arms = 0
        },
        texture = {
            torso = 0,
            tshirt = 0,
            arms = 0
        }
    },
    ["bag"] = {
        id = 5,
        item = 0,
        texture = 0
    },
    ["pants"] = {
        id = 4,
        item = 0,
        texture = 0
    },
    ["shoes"] = {
        id = 6,
        item = 0,
        texture = 0
    },
}

local currentPrice = 250

RegisterNUICallback("handlePrice", function(data)
    if data then
        currentPrice = currentPrice + 30
    else
        currentPrice = currentPrice - 30
    end

    SendReactMessage("updatePrice", currentPrice)
end)

RegisterNUICallback("handleClothe", function(data)
    local ped = GetPlayerPed(-1)    
    if data then
        currentPrice = currentPrice + 30
    else
        currentPrice = currentPrice - 30
    end
    if data == "mask" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 0 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 0, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "hat" then
        if GetPedPropIndex(ped, current[data].item) ~= -1 then
            current[data].item = GetPedPropIndex(ped, current[data].id)
            current[data].texture = GetPedPropTextureIndex(ped, current[data].id)
            ClearPedProp(ped, 0)
        else
            SetPedPropIndex(ped, current[data].id, current[data].item, current[data].texture, true)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "glasses" then
        if GetPedPropIndex(ped, current[data].item) ~= -1 then
            current[data].item = GetPedPropIndex(ped, current[data].id)
            current[data].texture = GetPedPropTextureIndex(ped, current[data].id)
            ClearPedProp(ped, 1)
        else
            SetPedPropIndex(ped, current[data].id, current[data].item, current[data].texture, true)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "tshirt" then
        if GetPedDrawableVariation(ped, current[data].id.tshirt) ~= 15 then
            current[data].item.tshirt = GetPedDrawableVariation(ped, current[data].id.tshirt)
            current[data].texture.tshirt = GetPedTextureVariation(ped, current[data].id.tshirt)
            current[data].item.torso = GetPedDrawableVariation(ped, current[data].id.torso)
            current[data].texture.torso = GetPedTextureVariation(ped, current[data].id.torso)
            current[data].item.arms = GetPedDrawableVariation(ped, current[data].id.arms)
            current[data].texture.arms = GetPedTextureVariation(ped, current[data].id.arms)
            SetPedComponentVariation(ped, 8, 15, 0, 0)
            SetPedComponentVariation(ped, 11, 15, 0, 0)
            SetPedComponentVariation(ped, 3, 15, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id.tshirt, current[data].item.tshirt, current[data].texture.tshirt, 0)
            SetPedComponentVariation(ped, current[data].id.torso, current[data].item.torso, current[data].texture.torso, 0)
            SetPedComponentVariation(ped, current[data].id.arms, current[data].item.arms, current[data].texture.arms, 0)
            current[data].item.tshirt = 0
            current[data].item.torso = 0
            current[data].item.arms = 0
            current[data].texture.thirst = 0
            current[data].texture.torso = 0
            current[data].texture.arms = 0
        end
    elseif data == "bag" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 0 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 0, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "pants" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 143 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 143, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "shoes" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 34 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 34, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, 0, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    end
end)
 

function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setDisplay', shouldShow)
end

function GetCurrentPed()
    player = PlayerPedId()
    
    return player
end

RegisterNUICallback("closeNui", function(buy)
    local currentPrices = 58
    local buy = RPC.execute("clothing:purchasecash", currentPrices)
    playerSkin = GetCurrentPed()
    if not buy and playerApperance then
        TriggerServerEvent("raid_clothes:get_character_current")
        TriggerEvent("DoLongHudText", "You don't have enough money!", 2)
    end
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityHeading(GetPlayerPed(-1), false)
    toggleNuiFrame(false)
    exports["fa-clothing"]:closeCamera()
    TriggerServerEvent("raid_clothes:insert_character_current", playerSkin)
    TriggerServerEvent("raid_clothes:insert_character_face", playerSkin) 
    TriggerServerEvent("raid_clothes:insert_character_face_blend", getPedAppearance(PlayerPedId())) 
    TriggerServerEvent("raid_clothes:set_tats", getPedAppearance(PlayerPedId()))
    TriggerEvent("fa-clothing:save")
    if firstspawn then
        firstspawn = false
        finishedClothing = true
        OpenShops('barber')
    elseif finishedClothing then
        finishedClothing = false
        TriggerEvent("fa-spawn:finishedClothing","Finished")
    end
end)

RegisterNUICallback("closeCancel", function(buy)
    TriggerServerEvent("raid_clothes:get_character_current")
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityHeading(GetPlayerPed(-1), false)
    toggleNuiFrame(false)
    exports["fa-clothing"]:closeCamera()
    if firstspawn then
        firstspawn = false
        finishedClothing = true
        OpenShops('barber')
    elseif finishedClothing then
        finishedClothing = false
        TriggerEvent("fa-spawn:finishedClothing","Finished")
    end
end)

RegisterNUICallback("resetNui", function(buy)
    TriggerServerEvent("raid_clothes:get_character_current")
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityHeading(GetPlayerPed(-1), false)
    toggleNuiFrame(false)
    exports["fa-clothing"]:closeCamera()
    if firstspawn then
        firstspawn = false
        finishedClothing = true
        OpenShops('barber')
    elseif finishedClothing then
        finishedClothing = false
        TriggerEvent("fa-spawn:finishedClothing","Finished")
    end
end)

RegisterNUICallback("PayBank", function(buy)
    local currentPrices = 58
    local buy = RPC.execute("clothing:bankpurchase", currentPrices)
    if not buy and playerApperance then
        TriggerServerEvent("raid_clothes:get_character_current")
        TriggerEvent("DoLongHudText", "You don't have enough money!", 2)
    end
    TriggerServerEvent("raid_clothes:insert_character_current", playerSkin)
    TriggerServerEvent("raid_clothes:insert_character_face", playerSkin) 
    TriggerServerEvent("raid_clothes:insert_character_face_blend", getPedAppearance(PlayerPedId())) 
    TriggerServerEvent("raid_clothes:set_tats", getPedAppearance(PlayerPedId()))
    TriggerEvent("fa-clothing:save")
    FreezeEntityPosition(GetPlayerPed(-1), false)
    toggleNuiFrame(false)
    exports["fa-clothing"]:closeCamera()
    if firstspawn then
        firstspawn = false
        finishedClothing = true
        OpenShops('barber')
    elseif finishedClothing then
        finishedClothing = false
        TriggerEvent("fa-spawn:finishedClothing","Finished")
    end
end)

RegisterNUICallback("getClothesMenu", function(data, cb)
    local ped = GetPlayerPed(-1)
    local menus = {
        ["parent"] = {
            {
                name = Config.Translate[Config.Lang].Parents.father,
                id = "shapeFirst",
                skinId = "skinFirst",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                currentTextureIndex = 0,
                slider = false,
                disableSelect= true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 46
                    },
                    texture = {
                        min = 0,
                        max = 46
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.mother,
                id = "shapeSecond",
                skinId = "skinSecond",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                currentTextureIndex = 0,
                disableSelect= true,
                slider = false,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 46
                    },
                    texture = {
                        min = 0,
                        max = 46
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.faceBlend,
                id = "shapeMix",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                slider = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 10
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.skinBlend,
                id = "skinMix",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                slider = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 10
                    }
                },
            },
            
        },
        ["clothing"] = {
            {
                name = Config.Translate[Config.Lang].Clothing.hat,
                componentId  = 0,
                currentIndex = GetPedPropIndex(ped, 0),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 0, GetPedPropIndex(ped, 0)),
                componentSettings = getPropSettings(ped, 0),
                menuItems = getItems(getPropSettings(ped, 0).texture.max),
                type = "prop"
            },
            {
                name = Config.Translate[Config.Lang].Clothing.hair,
                componentId  = 2,
                currentIndex = GetPedDrawableVariation(ped, 2),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 2, GetPedDrawableVariation(ped, 2)),
                componentSettings = getComponentSettings(ped, 2),
                menuItems = getItems(getComponentSettings(ped, 2).texture.max),
            },
            {
                name = Config.Translate[Config.Lang].Clothing.body,
                componentId  = 11,
                currentIndex = GetPedDrawableVariation(ped, 11),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 11, GetPedDrawableVariation(ped, 11)),
                componentSettings = getComponentSettings(ped, 11)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.gloves,
                componentId  = 3,
                currentIndex = GetPedDrawableVariation(ped, 3),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 3, GetPedDrawableVariation(ped, 3)),
                componentSettings = getComponentSettings(ped, 3)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.tshirt,
                componentId  = 8,
                currentIndex = GetPedDrawableVariation(ped, 8),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 8, GetPedDrawableVariation(ped, 8)),
                componentSettings = getComponentSettings(ped, 8)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.pants,
                componentId  = 4,
                currentIndex = GetPedDrawableVariation(ped, 4),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 4, GetPedDrawableVariation(ped, 4)),
                componentSettings = getComponentSettings(ped, 4)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.shoes,
                componentId  = 6,
                currentIndex = GetPedDrawableVariation(ped, 6),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 6, GetPedDrawableVariation(ped, 6)),
                componentSettings = getComponentSettings(ped, 6)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.sticker,
                componentId  = 10,
                currentIndex = GetPedDrawableVariation(ped, 10),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 10, GetPedDrawableVariation(ped, 10)),
                componentSettings = getComponentSettings(ped, 10)
            },
        },
        ["berber"] = {
            {
                name = Config.Translate[Config.Lang].Barber.hair,
                type = "hair",
                componentId  = 2,
                currentIndex = GetPedDrawableVariation(ped, 2),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 2, GetPedDrawableVariation(ped, 2)),
                componentSettings = getComponentSettings(ped, 2),
            },
            {
                name = Config.Translate[Config.Lang].Barber.hairColor.hairColor,
                isColor = true,
                type = "hair",
                colorLabel = Config.Translate[Config.Lang].Barber.hairColor.primaryHairColor,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.hairColor.secondaryHairColor,
                highlight = getHairColors()[1]
            },
            {
                name = Config.Translate[Config.Lang].Barber.fade,
                type = "fade",
                disableSelect = true,
                currentIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 75
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Barber.eyebrows,
                type = "eyebrows",
                componentId = 2,
                currentIndex = 0,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 2),
            },
            {
                name = Config.Translate[Config.Lang].Barber.eyebrowsColor.eyebrowsColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.eyebrowsColor.primaryEyebrowsColor,
                type = "makeup",
                id = 2,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.eyebrowsColor.secondaryEyebrowsColor,
                highlight = getHairColors()[1],
            },
            {
                name = Config.Translate[Config.Lang].Barber.beardColor.beard,
                type = "skin",
                componentId = 1,
                currentIndex = 0,
                currentTextureIndex = 10,
                componentSettings = getPedOverlaySettings(ped, 1),
            },
            {
                name = Config.Translate[Config.Lang].Barber.beardColor.beardColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.beardColor.primaryBeardColor,
                type = "makeup",
                id = 1,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.beardColor.secondaryBeardColor,
                highlight = getHairColors()[1],
            },
            {
                name = Config.Translate[Config.Lang].Barber.chestHairColor.chestHair,
                type = "skin",
                componentId = 10,
                currentIndex = 0,
                currentTextureIndex = 10,
                componentSettings = getPedOverlaySettings(ped, 10),
            },
            {
                name = Config.Translate[Config.Lang].Barber.chestHairColor.chestHairColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.chestHairColor.primaryChestColor,
                type = "makeup",
                id = 10,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.chestHairColor.secondaryChestHairColor,
                highlight = getHairColors()[1],
            },
        },
        ["makeup"] = {
            {
                name = Config.Translate[Config.Lang].Makeup.makeup,
                type = "makeup",
                componentId  = 4,
                currentIndex = getHeadOverlaySettings(ped, 4).overlayValue,
                currentTextureIndex = getHeadOverlaySettings(ped, 4).overlayOpacity,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 81
                    },
                    texture = {
                        min = 0,
                        max = 10
                    },
                }
            },
            {
                name = Config.Translate[Config.Lang].Makeup.makeupColor.makeupColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.makeupColor.primaryMakeupColor,
                type = "makeup",
                id = 4,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.makeupColor.secondaryMakeupColor,
                highlight = getHairColors()[2],
            },
            {
                name = Config.Translate[Config.Lang].Makeup.rednessColor.redness,
                type = "makeup",
                componentId = 5,
                currentIndex = 0,
                currentTextureIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 34,
                    },
                    texture = {
                        min = 0,
                        max = 10,
                    },
                },
            },
            {
                name = Config.Translate[Config.Lang].Makeup.rednessColor.rednessColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.rednessColor.primaryRednessColor,
                type = "makeup",
                id = 5,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.rednessColor.secondaryRednessColor,
                highlight = getHairColors()[2],
            },
            {
                name = Config.Translate[Config.Lang].Makeup.lipstickColor.lipstick,
                type = "makeup",
                componentId = 8,
                currentIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = GetNumberOfPedDrawableVariations(ped, 8),
                    },
                    texture = {
                        min = 0,
                        max = 10,
                    },
                },
            },
            {
                name = Config.Translate[Config.Lang].Makeup.lipstickColor.lipstickColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.lipstickColor.primaryLipstickColor,
                type = "makeup",
                id = 8,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.lipstickColor.secondaryLipstickColor,
                highlight = getHairColors()[2],
            },
        },
        ["aksesuar"] = {
            {
                name = Config.Translate[Config.Lang].Clothing.mask,
                componentId  = 1,
                currentIndex = GetPedDrawableVariation(ped, 1),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 1, GetPedDrawableVariation(ped, 1)),
                componentSettings = getComponentSettings(ped, 1)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.glasses,
                componentId  = 1,
                currentIndex = GetPedPropIndex(ped, 1),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 1, GetPedPropIndex(ped, 1)),
                componentSettings = getPropSettings(ped, 1)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.earing,
                componentId  = 2,
                currentIndex = GetPedPropIndex(ped, 2),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 2, GetPedPropIndex(ped, 2)),
                componentSettings = getPropSettings(ped, 2)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.ties,
                componentId  = 7,
                currentIndex = GetPedDrawableVariation(ped, 7),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 7, GetPedDrawableVariation(ped, 7)),
                componentSettings = getComponentSettings(ped, 7)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.idk,
                componentId  = 5,
                currentIndex = GetPedPropIndex(ped, 5),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 5, GetPedPropIndex(ped, 5)),
                componentSettings = getPropSettings(ped, 5)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.vest,
                componentId  = 9,
                currentIndex = GetPedDrawableVariation(ped, 9),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 9, GetPedDrawableVariation(ped, 9)),
                componentSettings = getComponentSettings(ped, 9)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.bags,
                componentId  = 5,
                currentIndex = GetPedDrawableVariation(ped, 5),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 5, GetPedDrawableVariation(ped, 5)),
                componentSettings = getComponentSettings(ped, 5)
            },
        },
        ["peds"] = {
            {
                name = Config.Translate[Config.Lang].MalePed,
                type = "ped",
                currentIndex = 0,
                variant = "man",
                componentSettings = {
                    drawable = {
                      min = 0,
                      max = #Config.ManPlayerModels,
                    },
                }
            },
            {
                name = Config.Translate[Config.Lang].FemalePed,
                type = "ped",
                currentIndex = 1,
                variant = "woman",
                componentSettings = {
                    drawable = {
                      min = 1,
                      max = #Config.WomanPlayerModels,
                    },
                }
            },

            {
                name = "Face Skins",
                type = "pedface",
                currentIndex = 1,
                componentSettings = {
                    drawable = {
                      min = 1,
                      max = 10,
                    },

                    texture = {
                        min = 1,
                        max = 10,
                    },
                }
            },
        },
        ["face"] = {
            {
                name = Config.Translate[Config.Lang].Face.noseSettings.noseHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.width,
                        componentSettings = {
                            face_id = 0,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.height,
                        componentSettings = {
                            face_id = 1,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.length,
                        componentSettings = {
                            face_id = 2,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.curved,
                        componentSettings = {
                            face_id = 3,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },
                    
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.front,
                        componentSettings = {
                            face_id = 4,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.boneSkew,
                        componentSettings = {
                            face_id = 5,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.eyebrowsSettings.eyebrowsHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.eyebrowsSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 6,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.eyebrowsSettings.depth,
                        width = "full",
                        componentSettings = {
                            face_id = 7,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },
            {
                name = Config.Translate[Config.Lang].Face.cheekboneSettings.cheekboneHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 8,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.width,
                        width = "full",
                        componentSettings = {
                            face_id = 9,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.shortness,
                        width = "full",
                        componentSettings = {
                            face_id = 10,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.jawboneSettings.jawboneHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.jawboneSettings.width,
                        width = "full",
                        componentSettings = {
                            face_id = 13,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawboneSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 14,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.jawSettings.jawHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.height,
                        componentSettings = {
                            face_id = 15,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.length,
                        componentSettings = {
                            face_id = 16,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.width,
                        componentSettings = {
                            face_id = 17,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.split,
                        componentSettings = {
                            face_id = 18,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.variousFeatures.variousFeaturesHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.lipThickness,
                        componentSettings = {
                            face_id = 12,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.eyeAperture,
                        componentSettings = {
                            face_id = 11,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.neckThickness,
                        componentSettings = {
                            face_id = 19,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

        },
        ["skin"] = {
            {
                name = Config.Translate[Config.Lang].Skin.freckles,
                componentId  = 0,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 0),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.wrinkle,
                componentId  = 3,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 3),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.skinColor,
                componentId  = 6,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 6),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.sunBurn,
                componentId  = 7,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 6),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.moles,
                componentId  = 9,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 9),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.bodySpots,
                componentId  = 11,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 11),
                type = "skin"
            },
        },
        ["tattoo"] = {
            {
                name = Config.Translate[Config.Lang].TattooShop.torso,
                tattooId = "ZONE_TORSO",
                componentId  = 1,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 117
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.head,
                tattooId = "ZONE_HEAD", 
                componentId  = 2,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 22
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.leftArm,
                tattooId = "ZONE_LEFT_ARM", 
                componentId  = 3,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 44
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.rightArm,
                tattooId = "ZONE_RIGHT_ARM", 
                componentId  = 4,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 44
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.leftLeg,
                tattooId = "ZONE_LEFT_LEG", 
                componentId  = 5,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 21
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.rightLeg,
                tattooId = "ZONE_RIGHT_LEG", 
                componentId  = 6,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 16
                    },
                },
                type = "tattoo"
            },
        },
    }


    cb(menus[data])
end)


function OpenShops(type, bool)
    if bool then
        firstspawn = true
    end
    local playerPed = GetPlayerPed(-1)
    playerApperance = getPedAppearance(playerPed)
    local firstPrice = 58
    reverseCamera = false;
    isCameraInterpolating = false;

    FreezeEntityPosition(playerPed, true)
    local currentHeading = GetEntityHeading(ped)
    SetEntityHeading(ped, currentHeading)
    exports["fa-clothing"]:setCamera(3)

    if type == "barber" then
        SendReactMessage("setCurrentShop", "parent")
        SendReactMessage("setSubMenus", Config.SubMenus["all"])
        SendReactMessage("updatePrice", firstPrice)
    else
        SendReactMessage("setCurrentShop", type)
        SendReactMessage("setSubMenus", Config.SubMenus[type])
        SendReactMessage("updatePrice", firstPrice)
    end
    toggleNuiFrame(true)
    RenderScriptCams(true, false, 0, true, true);
    DisplayRadar(false)
end

RegisterNUICallback("changeHairColor", function(data)
    local ped = GetPlayerPed(-1)
    if data.type == "hair" then
        SetPedHairColor(ped, data.currentIndex, data.currentTextureIndex)
    elseif data.type == "makeup" then
        SetPedHeadOverlayColor(ped, data.id, 1, data.currentIndex, data.currentTextureIndex)
    end
end)

local testoCat = {
    {"ZONE_TORSO", 0},
    {"ZONE_HEAD", 0},
    {"ZONE_LEFT_ARM", 0},
    {"ZONE_RIGHT_ARM", 0},
    {"ZONE_LEFT_LEG", 0},
    {"ZONE_RIGHT_LEG", 0},
    {"ZONE_UNKNOWN", 0},
    {"ZONE_NONE", 0},
}

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = GetPlayerPed(-1)
        FreezePedCameraRotation(player, true)
        if setDefault and model ~= nil then
            if (model ~= `mp_f_freemode_01` and model ~= `mp_m_freemode_01`) then
                SetPedRandomComponentVariation(GetPlayerPed(-1), true)
            else
                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 1, 2, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
            end
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
end
function SetPedHeadOverlayColor2(e,r,i,o,n)
    print'here'
    print(e)
    print(r)
    print(i)
    print(o)
    print(n)

end

local MakeUp = {}
local Ammount = 1.0
RegisterNUICallback("changeClothe", function(data, cb)
    local ped = GetPlayerPed(-1)
    if data then
        currentPrice = currentPrice + 30
    else
        currentPrice = currentPrice - 30
    end
    if data.componentSettings.component_id then
        setPedComponent(ped, data, cb)
    elseif data.componentSettings.prop_id then
        setPedProp(ped, data)
    elseif data.type == "ped" then
        setPlayerModel(ped, data)
    elseif data.type == "pedface" then
        SetPedComponentVariation(GetPlayerPed(-1), 0, data.currentIndex, data.currentTextureIndex, 0)
    elseif data.type == "parent" then
        setPlayerHeadFeature(ped, data)
    elseif data.type == "face" then
        setPlayerFaceFeature(ped, data)
    elseif data.type == "skin" then
        local Amount = data.currentTextureIndex
        print(data.currentTextureIndex, 'index')
        if data.currentTextureIndex == 1 or data.currentTextureIndex == 0 then
            Amount = 1.0
        else
            Amount = data.currentTextureIndex / 10
        end
        SetPedHeadOverlay(ped, data.componentSettings.overlay_id, data.currentIndex, Amount)
    elseif data.type == "hair" then
        SetPedComponentVariation(ped, data.componentId, data.currentIndex, data.currentTextureIndex, 0)
    elseif data.type == "fade" then
        local charHair = GetPedDrawableVariation(ped, 2)
        local charGender = "m"
        local LocalPlayer = exports["fa-base"]:getModule("LocalPlayer")
        local gender = LocalPlayer:getCurrentCharacter().gender

        if gender == 0 then
            charGender = "m"
        else
            charGender = "f"
        end

        ClearPedDecorations(ped)
        if hairDecor[charGender][charHair] ~= nil then
            AddPedDecorationFromHashes(ped, hairDecor[charGender][data.currentIndex][1], hairDecor[charGender][data.currentIndex][2])
            currentFadeStyle[charGender] = {
                first = hairDecor[charGender][data.currentIndex][1],
                second = hairDecor[charGender][data.currentIndex][2]
            }
        else
            AddPedDecorationFromHashes(ped, hairDecorDefault[data.currentIndex], hairDecorDefault[data.currentIndex])
        end
    elseif data.type == "eyebrows" then
        local Amount = data.currentTextureIndex
        print(data.currentTextureIndex, 'index')
        if data.currentTextureIndex == 1 or data.currentTextureIndex == 0 then
            Amount = 1.0
        else
            Amount = data.currentTextureIndex / 10
        end
        SetPedHeadOverlay(ped, data.componentId, data.currentIndex, Amount)
    elseif data.type == "makeup" then
        local Amount = data.currentTextureIndex
        print(data.currentTextureIndex, 'index')
        if data.currentTextureIndex == 1 or data.currentTextureIndex == 0 then
            Amount = 1.0
        else
            Amount = data.currentTextureIndex / 10
        end
        -- print(Amount, 'Amount')
        SetPedHeadOverlay(ped, data.componentId, data.currentIndex, Amount)
        SetPedHeadOverlayColor(ped, data.componentId, 1, 0, 0)
    elseif data.type == "tattoo" then
        SetTats(tattoosList, data.tattooId, data.currentIndex)
    end
end)

RegisterNUICallback("getComponentSettings", function(data, cb)
    local ped = GetPlayerPed(-1)
    if data.componentSettings.component_id then
        cb(getComponentSettings(ped, data.componentSettings.component_id))
    elseif data.componentSettings.prop_id then
        cb( getPropSettings(ped,data.componentSettings.prop_id) )
    elseif data.type == "ped" then
        setPlayerModel(ped, data)
    end
end)

RegisterNetEvent("fa-clothing:opefa-clothing", OpenShops)

function isPedMale(ped)
    local entityModel = GetEntityModel(ped);
    local freemodeMale = GetHashKey('mp_m_freemode_01');
  
    return entityModel == freemodeMale;
end

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(tattoos, id, index)
    local ped = GetPlayerPed(-1)
    local infos = tattoos[id][index]

    if not playerTattoos[id] then
        playerTattoos[id] = {
            {            
                collection = infos.collection,
                hash = infos.hashMale
            }
        }
        AddPedDecorationFromHashes(ped, GetHashKey(infos.collection), GetHashKey(infos.hashMale))
    else
        ClearPedDecorations(ped)
        for k,v in pairs(playerTattoos) do 
            if k == id then
                for _,i in pairs(v) do
                    if i.collection then
                        i.collection = infos.collection
                        i.hash = infos.hashMale
                    end
                end
            end
        end
    end

    for k,v in pairs(playerTattoos) do 
        for _,i in pairs(v) do
            if i.collection then
                AddPedDecorationFromHashes(ped, GetHashKey(i.collection), GetHashKey(i.hash))
            end
        end
    end
end