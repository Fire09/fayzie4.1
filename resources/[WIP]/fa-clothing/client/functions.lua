function getComponentSettings(ped, componentId)
    local drawableId = GetPedDrawableVariation(ped, componentId);
  
    local settings = {
      component_id = componentId,
      drawable = {
        min = 0,
        max = GetNumberOfPedDrawableVariations(ped, componentId) - 1,
      },
      texture = {
        min = 0,
        max = GetNumberOfPedTextureVariations(ped, componentId, drawableId) - 1,
      },
    };
  
    return settings;
end

function getHeadOverlaySettings(ped, componentId)
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(ped, componentId)

    return {
        overlayValue = overlayValue,
        colourType = colourType,
        firstColour = firstColour,
        secondColour = secondColour,
        overlayOpacity = overlayOpacity   
    }
end

function getPedComponents(ped)
    local components = {}

    for key, value in pairs(PED_COMPONENTS_IDS) do
        table.insert(components, {
            component_id = value,
            drawable =  GetPedDrawableVariation(ped, value),
            texture = GetPedTextureVariation(ped, value)
        })
    end

    return components
end

RegisterNetEvent("fa-clothing:isPedFreemodeModel")
AddEventHandler("fa-clothing:isPedFreemodeModel", function()
    isPedFreemodeModel(ped)
end)

function isPedFreemodeModel(ped)
    local bool = false
    local entityModel = GetEntityModel(ped)

    local freemodeMale = GetHashKey('mp_m_freemode_01');
    local freemodeFemale = GetHashKey('mp_f_freemode_01');

    if (entityModel == freemodeMale) or (entityModel == freemodeFemale) then
        bool = true
    end

    return bool
end

exports("isPedFreemodeModel", isPedFreemodeModel)



function setPedComponent(ped, component, cb)
    local excludedFromFreemodeModels = {
        [0] = true,
        [2] = true,
    }
  
    if (excludedFromFreemodeModels[component.componentId] and not isPedFreemodeModel(ped)) then
      return 
    end
  
    SetPedComponentVariation(ped, component.componentSettings.component_id, component.currentIndex, component.currentTextureIndex, 0);

    if cb then cb( getComponentSettings(ped, component.componentSettings.component_id) ) end
end

function getPropSettings(ped, propId)
    local drawableId = GetPedPropIndex(ped, propId)

    local settings = {
      prop_id = propId,
      drawable = {
        min = -1,
        max = GetNumberOfPedPropDrawableVariations(ped, propId) - 1,
      },
      texture = {
        min = -1,
        max = GetNumberOfPedPropTextureVariations(ped, propId, drawableId) - 1,
      },
    };

    return settings;
end

function setPedProp(ped, prop)
    if not prop then return end

    local prop_id = prop.componentSettings.prop_id
    local currentIndex = prop.currentIndex
    local currentTextureIndex = prop.currentTextureIndex
    
    if currentIndex == -1 then
        ClearPedProp(ped, prop_id);
    else
        SetPedPropIndex(ped, prop_id, currentIndex, currentTextureIndex, false);
    end
end

function arrayToVector3(coords) 
    return {
        x = coords[1],
        y = coords[2],
        z = coords[3],
    }
end

function setPlayerModel(ped, data)
    local model = Config.ManPlayerModels[data.currentIndex]
    if data.variant == "woman" then model = Config.WomanPlayerModels[data.currentIndex] end
    if not model then return end
    model = GetHashKey(model)
    CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    end)
end

function setPlayerHeadFeature(ped, face)
    for key,val in pairs(playerHeadBlend) do
        if face.id == key then
            -- print("buldum", key, face.currentIndex)
            playerHeadBlend[key] = face.currentIndex
            print(face.currentIndex)
            -- print(playerHeadBlend[key])
        elseif face.skinId == key then
            playerHeadBlend[key] = face.currentTextureIndex
        end
    end

    SetPedHeadBlendData(
        ped, 
        playerHeadBlend['shapeFirst'], 
        playerHeadBlend['shapeSecond'], 
        nil, 
        playerHeadBlend['skinFirst'], 
        playerHeadBlend['skinSecond'], 
        nil, 
        playerHeadBlend['shapeMix'] / 10, 
        playerHeadBlend['skinMix'] / 10, 
        nil, 
        true
    )

end

local faceFeatures = {}
function setPlayerFaceFeature(ped, data)
    -- print(data.componentSettings.face_id, data.currentIndex / 10)
    SetPedFaceFeature(ped, data.componentSettings.face_id, data.currentIndex / 10)
end

function getPedOverlaySettings(ped, id)
    local settings = {
        overlay_id = id,
        drawable = {
          min = 0,
          max = GetNumHeadOverlayValues(id),
        },
        texture = {
            min = 0,
            max = 10
        }
    };

    return settings
end

function getHairColors()
    local colors = {}
    local makeUp = {}

    for key = 1, GetNumHairColors(), 1 do
        local r,g,b = GetPedHairRgbColor(key)
        table.insert(colors, {
            r = r,
            g = g,
            b = b,
            id = key
        })
    end

    for i = 1, GetNumMakeupColors(), 1 do
        local r,g,b = GetMakeupRgbColor(i)
        table.insert(makeUp, {
            r = r,
            g = g,
            b = b,
            id = i
        })
    end

    return {colors, makeUp}
end

function getPedProps(ped)
    return {
        prop_id = {
            0,
            1,
            2,
            6,
            7
        },
        drawable = GetPedPropIndex(ped, propId),
        texture = GetPedPropTextureIndex(ped, propId),
    }
end

function getPedHair(ped)
    return {
        style = GetPedDrawableVariation(ped, 2),
        color = GetPedHairColor(ped),
        highlight = GetPedHairHighlightColor(ped),
    }
end

function getPedFade()
    return currentFadeStyle
end

function getPedAppearance(ped)
    return {
        model = GetEntityModel(ped),
        headBlend = exports["fa-clothing"]:getPedHeadBlend(ped),
        faceFeatures = exports["fa-clothing"]:getPedFaceFeatures(ped),
        headOverlays = exports["fa-clothing"]:getPedHeadOverlays(ped),
        components = getPedComponents(ped),
        props = exports["fa-clothing"]:getPedProps(ped),
        hair = getPedHair(ped),
        tattoos = getPedTattoos(),
        fade = getPedFade()
    }
end

function getItems(max) 
    local values = {}

    for i = 1, max, 1 do
        table.insert(values, {
            name = "Texture " .. i,
            id = i 
        })
    end

    return values
end


function getPedTattoos()
    return playerTattoos
end

function setPedAppearance(player, data)
    if not data then return end
    local armor = GetPedArmour(PlayerPedId())
    local health = GetEntityHealth(PlayerPedId())
    local ped = GetPlayerPed(-1)

    local excludedFromFreemodeModels = {
        [0] = true,
        [2] = true,
    }

    local model = tonumber(data.model)
    Citizen.CreateThread(function()    
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)

        for key, value in pairs(data.components) do
            if excludedFromFreemodeModels[component_id] and not isPedFreemodeModel(GetPlayerPed(-1)) then return end 
            SetPedComponentVariation(GetPlayerPed(-1), value.component_id, value.drawable, value.texture, 0);
        end
        
        if data.faceFeatures then
            exports["fa-clothing"]:setPedFaceFeaturesJS(GetPlayerPed(-1), data.faceFeatures)
        end

        if data.headBlend then
            exports["fa-clothing"]:setPedHeadBlend(GetPlayerPed(-1), data.headBlend)
        end

        if data.props then
            exports["fa-clothing"]:setPedProps(GetPlayerPed(-1), data.props)
        end

        if data.headOverlays then
            exports["fa-clothing"]:setPedHeadOverlays(GetPlayerPed(-1), data.headOverlays)
        end

        if data.fade then
            for k,v in pairs(data.fade) do
                for i,z in pairs(v) do
                    AddPedDecorationFromHashes(GetPlayerPed(-1), v.first, v.second)
                    currentFadeStyle[k] = {
                        first = v.first,
                        second = v.second
                    }
                end
            end
        end
        
        SetPedHairColor(GetPlayerPed(-1), data.hair.color, data.hair.highlight)
        SetPedComponentVariation(GetPlayerPed(-1), 2, data.hair.style, 0, 0)

        -- print(data.tattoos, json.encode(data.tattoos))

        if data.tattoos then
            for k,v in pairs(data.tattoos) do
                for i,z in pairs(v) do
                    AddPedDecorationFromHashes(GetPlayerPed(-1), GetHashKey(z.collection), GetHashKey(z.hash))
                end
            end
        end
    end)

    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
    Wait(100)
    SetEntityHealth(PlayerPedId(), health)
    SetPedArmour(PlayerPedId(), armor)
    TriggerServerEvent('fa-walkstyles:server:walkstyles', 'get')
    playerTattoos = {}
end

function GetForwardVector(rotation)
    local rot = (math.pi / 180.0) * rotation
    return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

exports('getPedComponents', getPedComponents)