--[[

    Variables

]]

local enabled = false
local player = false
local firstChar = false
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false
local currentFadeStyle = 255
local currentTattoos = {}
local _currentTattoos = {}
local _currentTattoosTemp = {}

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local passedClothing = true

local currentPrice = 0
local currentTax = 0

local MenuData = {
    clothing_shop = {
        text = "To buy clothes",
        displayName = "Clothing Store",
        basePrice = 200
    },
    barber_shop = {
        text = "Fix your ugly mug",
        displayName = "Barber Shop",
        basePrice = 200
    },
    tattoo_shop = {
        text = "Become edgy",
        displayName = "Tattoo Parlor",
        basePrice = 200
    }
}

local listening = false
local inSpawn = false
local toggleClothing = {}

local hairTied = false
local currentHairStyle = nil
local supportedModels = {
    [`mp_f_freemode_01`] = 4,
    [`mp_m_freemode_01`] = 0,
}

local currentShop = false
local currentJob = "unemployed"

--[[

    Functions Util

]]

function SetCustomNuiFocus(hasKeyboard, hasMouse)
    HasNuiFocus = hasKeyboard or hasMouse
    SetNuiFocus(hasKeyboard, hasMouse)
end

function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair(),
        eyeColor=GetPedEyeColor(player)
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal(),
        fadeTotal = GetFadeTotal(),
    })
    SendNUIMessage({
        type = "barber_shop",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData()
    })
    SendNUIMessage({
        type = "clothing_shopdata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        currentFade = currentFadeStyle,
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoo_shop",
        totals = tatCategory,
        values = GetTattoos()
    })
end

function isNearClothing()
    return currentShop 
end exports('isNearClothing', isNearClothing)

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(
            player,
            i-1,
            propZ,
            propTextures[i][2], true)
    end
end

function GetSkinTotal()
  return {
    #frm_skins,
    #fr_skins
  }
end

function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

-- LoadPed(data) Sets clothing based on the data structure given, the same structure that GetCurrentPed() returns
function LoadPed(data)
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    setTattoosAndFacial(nil, data.fadeStyle)
    SetPedEyeColor(player, tonumber(data.eyeColor))
    return
end

-- GetCurrentPed() Gives you the data structure of the currently worn clothes
function GetCurrentPed()
    player = PlayerPedId()
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        eyeColor = GetPedEyeColor(player),
        fadeStyle = currentFadeStyle
    }
end

function PlayerModel(data)
    local skins = nil
    if (data['name'] == 'skin_male') then
        skins = frm_skins
    else
        skins = fr_skins
    end
    local skin = skins[tonumber(data['value'])]
    rotation(180.0)
    SetSkin(GetHashKey(skin), true)
    Citizen.Wait(1)
    rotation(180.0)
end

local function ToggleClothingToLoadPed()
    local ped = PlayerPedId()
    local drawables = GetDrawablesTotal()

    for num, _ in pairs(drawables) do
        if drawables[num][2] > 1 then
            component = tonumber(num)
            SetPedComponentVariation(ped, component, 1, 0, 0)
            Wait(250)
            SetPedComponentVariation(ped, component, 0, 0, 0)
            break
        end
    end
end

local inSpawn = false
AddEventHandler("raid_clothes:inSpawn", function(pInSpawn)
    inSpawn = pInSpawn
end)

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = PlayerPedId()
        FreezePedCameraRotation(player, true)
        SetPedMaxHealth(player, 200)
        ToggleClothingToLoadPed()
        SetPedDefaultComponentVariation(player)
        if inSpawn then
            SetEntityHealth(player, GetEntityMaxHealth(player))
        end
        if setDefault and model ~= nil and not isCustomSkin(model) and (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
            SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
            SetPedComponentVariation(player, 11, 0, 1, 0)
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
    SetEntityInvincible(PlayerPedId(),false)
end

RegisterNUICallback('saveeyecolor', function(data, cb)
    local color = tonumber(data['eyeColor'])
    if (color == 255) then
        color = 0
    end
    SetPedEyeColor(player, color)
    cb('ok')
end)
function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu, pPriceText, pPrice,disableDestroyCams)
    -- tell things to block/enable props til we close this piece of poops.
    TriggerEvent("attachedItems:block", enable)

    enabled = enable
    SetCustomNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableclothing_shop",
        enable = enable,
        menu = menu,
        priceText = pPriceText,
        price = pPrice,
        currentJob = currentJob
    })

    if (not enable and not startingMenu) then
        SaveToggleProps()
        oldPed = {}
        DestroyAllCams(true)
        RenderScriptCams(false, true, 1, true, true)
    end
end

function CustomCamera(position,ending)
    if startingMenu and position == "torso" then return end
    if not enabled then return end
    if customCam  then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        if not ending and not startingMenu then
            RenderScriptCams(false,  false,  0,  true,  true)
            if (DoesCamExist(cam)) then
               DestroyCam(cam, false)
            end
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        local pos = GetEntityCoords(player, true)
        if not startingMenu then
            SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        end

        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, player)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        SwitchCam(position)
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        if startingMenu then
            bonepos = vector3(bonepos.x - 0.7, bonepos.y + 0.0, bonepos.z + 0.05)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
        end

    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)

        if startingMenu then
            bonepos = vector3(bonepos.x - 0.9, bonepos.y + 0.0, bonepos.z-0.2)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
        end

    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    if startingMenu and name ~= "torso" then
        SetCamRot(cam, 0.0, 0.0, 250.0)
    else
        SetCamRot(cam, 0.0, 0.0, 180.0)
    end

end

--[[

    Functions Main

]]

function OpenMenu(name, pPriceText, pPrice)
    player = PlayerPedId()
    oldPed = GetCurrentPed()
    local isAllowed = false
    if(oldPed.model == 1885233650 or oldPed.model == -1667301416) then isAllowed = true end
    if((oldPed.model ~= 1885233650 or oldPed.model ~= -1667301416) and (name == "clothing_shop" or name == "tattoo_shop")) then isAllowed = true end
    if isAllowed then
        FreezePedCameraRotation(player, true)
        RefreshUI()
        EnableGUI(true, name, pPriceText, pPrice)
        TriggerEvent("inmenu", true)
    else
        TriggerEvent("DoLongHudText", "You are not welcome here!");
    end
end

function Save(save, close, newFadeStyle)
    if save then
        data = GetCurrentPed()
        data.fadeStyle = newFadeStyle

        currentFadeStyle = newFadeStyle
        currentTattoos = _currentTattoos

        if (GetCurrentPed().model == GetHashKey("mp_f_freemode_01") or GetCurrentPed().model == GetHashKey("mp_m_freemode_01")) and startingMenu then
            --startingMenu = false
        else
            passedClothing = true
        end

        print(startingMenu) 
        print(passedClothing)


        if not startingMenu or passedClothing then
            print("TRIGGERED")
            TriggerServerEvent("fa-clothes:updateClothes", data, currentTattoos)
            TriggerEvent("fa-spawn:finishedClothing","Finished") 
        elseif not passedClothing then
            print("BACKWARDS")
            EnableGUI(false, false) 
            passedClothing = true
            Wait(1000)
            OpenMenu("clothing_shop")
            startingMenu = false
            return 
        end 
    else
        TriggerEvent("fa-spawn:finishedClothing","Old")
        LoadPed(oldPed)
    end

    if close then
        EnableGUI(false, false)
    end

    TriggerEvent("inmenu", false)
    TriggerEvent("ressurection:relationships:norevive")
    TriggerEvent("gangs:setDefaultRelations")
    TriggerEvent("facewear:update")
    TriggerEvent("AnimSet:Set")
    TriggerEvent('fa-weapons:getAmmo')
    CustomCamera('torso',true)
    TriggerEvent("e-blips:updateAfterPedChange",exports["isPed"]:isPed("myjob"))
    startingMenu = false
end

--[[

    Functions Barber

]]

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    if data ~= nil then
        SetPedHeadBlendData(player,
            tonumber(data['shapeFirst']),
            tonumber(data['shapeSecond']),
            tonumber(data['shapeThird']),
            tonumber(data['skinFirst']),
            tonumber(data['skinSecond']),
            tonumber(data['skinThird']),
            tonumber(data['shapeMix']),
            tonumber(data['skinMix']),
            tonumber(data['thirdMix']),
            false)
    end
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
    RegisterNetEvent("raid_clothes:admin:open")
AddEventHandler("raid_clothes:admin:open", function(name)
    OpenMenu(name)
end)

RegisterNetEvent("raid_clothes:police:open")
AddEventHandler("raid_clothes:police:open", function(name)
    OpenMenu(name)
end)
end

--[[

    Functions Tattoos

]]

function GetTattoos()
    local tempTattoos = {}
    if currentTattoos == nil then return {} end
    for i = 1, #currentTattoos do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTattoos[i][2] then
                    tempTattoos[key] = j
                end
            end
        end
    end
    return tempTattoos
end

--[[

    Functions Fade

]]

function isFreemodeModel(pModelHash)
    return pModelHash == `mp_f_freemode_01` or pModelHash == `mp_m_freemode_01`
end

function GetFadeTotal()
    local data = getFacialDecorationsData()
    return #data
end

function getFacialDecorationsData()
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)
    if isFreemodeModel(playerModel) then
        return FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"]
    else
        return {}
    end
end

function setFacialDecoration(pFadeStyle)
    local fadeStyle = tonumber(pFadeStyle) or 255
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)
    ClearPedFacialDecorations(playerPed)
    if fadeStyle and fadeStyle > 0 and fadeStyle ~= 255 and isFreemodeModel(playerModel) then
        local facialDecoration = FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"][fadeStyle]
        Wait(1)
        SetPedFacialDecoration(playerPed, facialDecoration[1], facialDecoration[2])
    end
end

function setTattoosAndFacial(pTattoos, pFadeStyle, pShop)
    local fadeStyle = tonumber(pFadeStyle) or 255
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)

    ClearPedFacialDecorations(playerPed)

    if fadeStyle and fadeStyle > 0 and fadeStyle ~= 255 and isFreemodeModel(playerModel) then
        local facialDecoration = FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"][fadeStyle]

        Wait(1)

        SetPedFacialDecoration(playerPed, facialDecoration[1], facialDecoration[2])
    end

    if pTattoos then
        _currentTattoos = {}

        for k, v in pairs(pTattoos) do
            for category in pairs(tattooHashList) do
                if k == category then
                    local tattoo = tattooHashList[category][tonumber(v)]
                    if tattoo ~= nil then
                        table.insert(_currentTattoos, {tattoo[2], tattoo[1]})
                    end
                end
            end
        end
    end

    if pShop then
        for i, v in ipairs(currentTattoos) do
            table.insert(_currentTattoos, v)
        end

        for i, v in ipairs(_currentTattoosTemp) do
            table.insert(_currentTattoos, v)
        end
    else
        _currentTattoos = currentTattoos
    end

    for i = 1, #_currentTattoos do
        ApplyPedOverlay(playerPed, _currentTattoos[i][1], _currentTattoos[i][2])
    end
end

--[[

    Functions Misc

]]

local function listenForKeypress(zoneName, zoneData, isFree)
    listening = true
    Citizen.CreateThread(function()
        local priceWithTax = 200 
        local currentCash = RPC.execute("getCurrentCashPlayer") 

        while listening do
            if IsControlJustReleased(0, 244) then
                if zoneName == "tattoo_shop" then
                    -- TODO: Make this not retarded, use RPC please FOR THE LOVE OF FUCKING GOD
                    TriggerServerEvent("fa-clothes:getTattoos")
                    while currentTattoos == nil do
                        Citizen.Wait(0)
                    end
                end
                currentPrice = isFree and 0 or priceWithTax
                priceWithTax = isFree and 0 or priceWithTax
                OpenMenu(zoneName, priceWithTax, currentPrice)
                TriggerEvent('attachedItems:block', true)

                exports['fa-interface']:hideInteraction()
            end
            Wait(0)
        end
    end)
end

RegisterNUICallback('prop_shit', function()
    TriggerEvent('attachedItems:block', false)
end)

RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(
                player,
                tonumber(selectedValue),
                tonumber(data["value"]),
                tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins(data) then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(GetHashKey(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
    local hairTied = false
local currentHairStyle = nil
local supportedModels = {
  [`mp_f_freemode_01`] = 4,
  [`mp_m_freemode_01`] = 2,
}
AddEventHandler("fa-inventory:itemUsed", function(item)
    if item ~= "hairtie" then return end
    local hairValue = supportedModels[GetEntityModel(PlayerPedId())]
    if hairValue == nil then return end
    TriggerEvent("animation:PlayAnimation", "hairtie")
    Wait(1000)
    if not hairTied then
        hairTied = true
        local draw = GetPedDrawableVariation(PlayerPedId(), 2)
        local text = GetPedTextureVariation(PlayerPedId(), 2)
        local pal = GetPedPaletteVariation(PlayerPedId(), 2)
        currentHairStyle = { draw, text, pal }
        SetPedComponentVariation(PlayerPedId(), 2, hairValue, text, pal)
    else
        hairTied = false
        SetPedComponentVariation(PlayerPedId(), 2, currentHairStyle[1], currentHairStyle[2], currentHairStyle[3])
    end
end)
end)

RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    tonumber(data.shapeThird),
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    tonumber(data.thirdMix) / 100, false)
    cb('ok')
end)

RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    local index = has_value(face_features, data["name"])
    if (index <= -1) then return end
    local scale = tonumber(data["scale"]) / 100
    SetPedFaceFeature(player, index, scale)
    cb('ok')
end)
--[[ RegisterNetEvent("kazumi:raid_clothes_pedfix")
AddEventHandler("kazumi:raid_clothes_pedfix", function(name,price)
    SetSkin(GetEntityModel(PlayerPedId()), true)
    TriggerServerEvent("clothing:checkIfNew")  
    print("I forgot what you looked like, Let me call your gardian...")
    Citizen.Wait(2000)
    print("Ahh! There we go, All done.")
end) ]]

RegisterNUICallback('saveheadoverlay', function(data, cb)
    if data["name"] == "fadeStyle" then
        setTattoosAndFacial(nil, tonumber(data["value"]))
    else
        local index = has_value(head_overlays, data["name"])
        SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
    end
    cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
    local shouldSave = data['save'] or false
    local newFadeStyle = data["fadeStyle"] or 255
    local paymentType = data["paymentType"] or "cash"
    if shouldSave and currentPrice > 0 then
        local purchaseSuccess = RPC.execute("fa-clothes:purchase", currentPrice, currentTax, paymentType) 
        if not purchaseSuccess then
            TriggerEvent("DoLongHudText", "You do not have enough money!")
            shouldSave = false
        end
    end

    if not startingMenu then
        TriggerServerEvent("fa-hud:getData")
        TriggerServerEvent("fa-flags:ped:getFlags")
    end 

    if currentShop and listening then
        local currentZone = MenuData[currentShop]
        exports["fa-interface"]:showInteraction(("[M] %s"):format(currentZone.text))
    end

    Save(shouldSave, true, newFadeStyle)
    cb('ok')
end)

RegisterNUICallback('togglecursor', function(data, cb)
    if not startingMenu then
        CustomCamera("torso")
        SetCustomNuiFocus(false, false)
        FreezePedCameraRotation(player, false)
    end
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)

RegisterNUICallback('settats', function(data, cb)
    setTattoosAndFacial(data["tats"], currentFadeStyle, true)
    cb('ok')
end)

RegisterNUICallback('applytattoo', function(data, cb)
    local pCategory = data.category
    local pTattoo = data.tattoo

    for category in pairs(tattooHashList) do
        if pCategory == category then
            local tattoo = tattooHashList[category][tonumber(pTattoo)]
            if tattoo ~= nil then
                for i, v in ipairs(_currentTattoosTemp) do
                    if v[1] == tattoo[2] and v[2] == tattoo[1] then
                        cb('ok')
                        return
                    end
                end

                table.insert(_currentTattoosTemp, {tattoo[2], tattoo[1]})
            end
        end
    end

    cb('ok')
end)

--[[

    Events Main

]]

RegisterNetEvent("fa-jobs:jobChanged")
AddEventHandler("fa-jobs:jobChanged", function(job)
    if exports["fa-jobs"]:getJob(job, "is_police") then
        currentJob = "police"
    elseif exports["fa-jobs"]:getJob(job, "is_medic") then
        currentJob = "ems"
    else
        currentJob = job
    end
end)

AddEventHandler("raid_clothes:inSpawn", function(pInSpawn)
    inSpawn = pInSpawn
end)

RegisterNetEvent("fa-clothes:setClothes")
AddEventHandler("fa-clothes:setClothes", function(data)
    player = PlayerPedId()

    if not data.model then return end

    model = data.model
    model = model ~= nil and tonumber(model) or false

	if not IsModelInCdimage(model) or not IsModelValid(model) then return end

    SetSkin(model, false)
    Citizen.Wait(500)

    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)

    if model == 1885233650 or model == -1667301416 then
        local head = data.headBlend
        local haircolor = data.hairColor

        SetPedHeadBlendData(player,
            tonumber(head["shapeFirst"]),
            tonumber(head["shapeSecond"]),
            tonumber(head["shapeThird"]),
            tonumber(head["skinFirst"]),
            tonumber(head["skinSecond"]),
            tonumber(head["skinThird"]),
            tonumber(head["shapeMix"]),
            tonumber(head["skinMix"]),
            tonumber(head["thirdMix"]),
            false)
        SetHeadStructure(data.headStructure)
        SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
        SetHeadOverlayData(data.headOverlay)

        currentFadeStyle = data.fadeStyle
        currentTattoos = data.tattoos

        Citizen.Wait(1000)

        setTattoosAndFacial(nil, currentFadeStyle)
    end

	TriggerServerEvent("fa-hud:getData")
    TriggerServerEvent("fa-flags:ped:getFlags")
end)

RegisterNetEvent("raid_clothes:settattoos")
AddEventHandler("raid_clothes:settattoos", function(playerTattoosList)
    currentTattoos = playerTattoosList
    setTattoosAndFacial(nil, currentFadeStyle)
end)

RegisterNetEvent('raid_clothes:openClothing')
AddEventHandler('raid_clothes:openClothing', function(pDontShowBarber, pShouldCost)
    if pShouldCost ~= nil and pShouldCost then
        local tax = RPC.execute("fa-financials:priceWithTax", MenuData.clothing_shop.basePrice, "Services")

        currentPrice = tax.total
        currentTax = tax.tax
        OpenMenu("clothing_shop", "$" .. tax.total .. " Incl. " .. tax.porcentage .. "% taxas", currentPrice)
        startingMenu = false
    else
        currentPrice = 0 

        if pDontShowBarber == nil and pShouldCost == nil then
            OpenMenu("barber_shop", "", 0)
        else
            OpenMenu("clothing_shop", "", 0)
        end

        startingMenu = true
    end
    passedClothing = pDontShowBarber or false
end)

RegisterNetEvent("fa-clothes:saveCurrentClothes")
AddEventHandler("fa-clothes:saveCurrentClothes", function()
    local data = GetCurrentPed()
    TriggerServerEvent("fa-clothes:updateClothes", data, currentTattoos)
end)

--[[

    Events Misc

]]

AddEventHandler("fa-polyzone:enter", function(zone, data)
    local currentZone = MenuData[zone]
    if currentZone then
        currentShop = zone
        exports["fa-interface"]:showInteraction(("[M] %s"):format(currentZone.text))
        listenForKeypress(zone, currentZone, ((data and data.isFree) and true or false))
    end
end)

AddEventHandler("fa-polyzone:exit", function(zone)
    local currentZone = MenuData[zone]
    if currentZone then
        currentShop = false
        listening = false
        exports["fa-interface"]:hideInteraction()
    end
end)

AddEventHandler("fa-inventory:itemUsed", function(item)
    if item ~= "hairtie" then return end

    local hairValue = supportedModels[GetEntityModel(PlayerPedId())]
    if hairValue == nil then return end

    TriggerEvent("animation:PlayAnimation", "hairtie")
    Wait(1000)

    if not hairTied then
        hairTied = true
        local draw = GetPedDrawableVariation(PlayerPedId(), 2)
        local text = GetPedTextureVariation(PlayerPedId(), 2)
        local pal = GetPedPaletteVariation(PlayerPedId(), 2)
        currentHairStyle = { draw, text, pal }
        SetPedComponentVariation(PlayerPedId(), 2, hairValue, text, pal)
    else
        hairTied = false
        SetPedComponentVariation(PlayerPedId(), 2, currentHairStyle[1], currentHairStyle[2], currentHairStyle[3])
    end
end)

RegisterNetEvent("raid_clothes:AdminSetModel")
AddEventHandler("raid_clothes:AdminSetModel", function(model)
    local hashedModel = GetHashKey(model)
    if not IsModelInCdimage(hashedModel) or not IsModelValid(hashedModel) then return end
    SetSkin(hashedModel, true)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    addBlips()
    SetCustomNuiFocus(false, false)

    while true do
        Wait(0)
        if enabled then
            if (IsControlJustReleased(1, 25)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            if (IsControlJustReleased(1, 202)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            InvalidateIdleCam()
        end
    end
end)

--blip shit
local showBarberShopBlips = true 
local showTattooShopBlips = true
local showClothingShopBlips = true
local showStorageBlips = true
local showGasBlips = true

RegisterNetEvent('hairDresser:ToggleHair', function()
   showBarberShopBlips = not showBarberShopBlips
   for _, item in pairs(barberShops) do
        if not showBarberShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 71)
            SetBlipColour(item.blip, 1)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Barber Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

RegisterNetEvent('tattoo:ToggleTattoo')
AddEventHandler('tattoo:ToggleTattoo', function()
   showTattooShopBlips = not showTattooShopBlips
   for _, item in pairs(tattoosShops) do
        if not showTattooShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 75)
            SetBlipColour(item.blip, 1)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Tattoo Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

local ClothingShop = {
	{-162.658, -303.397, 39.733},
	{75.950, -1392.891, 29.376},
	{-822.194, -1074.134, 11.328},
	{-1450.711, -236.83, 49.809},
	{4.254, 6512.813, 31.877},
	{615.180, 2762.933, 44.088},
	{1196.785, 2709.558, 38.222},
	{-3171.453, 1043.857, 20.863},
	{-1100.959, 2710.211, 19.107},
	{-1192.9453125, -772.62481689453, 17.3254737854},
	{-707.33416748047, -155.07914733887, 37.415187835693},
	{1683.45667, 4823.17725, 42.1631294},
	{121.76, -224.6, 54.56},
	{-1207.5267333984,-1456.9530029297,4.3763856887817},
}

local storageLockers = {
	{-67.14555, -1204.11900, 27.23},
}

local GasStations = {
	{49.4187, 2778.793, 58.043},
	{263.894, 2606.463, 44.983},
	{1039.958, 2671.134, 39.550},
	{1207.260, 2660.175, 37.899},
	{2539.685, 2594.192, 37.944},
	{2679.858, 3263.946, 55.240},
	{2005.055, 3773.887, 32.403},
	{1687.156, 4929.392, 42.078},
	{1701.314, 6416.028, 32.763},
	{179.857, 6602.839, 31.868},
	{-94.4619, 6419.594, 31.489},
	{-2554.996, 2334.40, 33.078},
	{-1800.375, 803.661, 138.651},
	{-1437.622, -276.747, 46.207},
	{-2096.243, -320.286, 13.168},
	{-724.619, -935.1631, 19.213},
	{-526.019, -1211.003, 18.184},
	{-70.2148, -1761.792, 29.534},
	{265.648, -1261.309, 29.292},
	{819.653, -1028.846, 26.403},
	{1208.951, -1402.567,35.224},
	{1181.381, -330.847, 69.316},
	{620.843, 269.100, 103.089},
	{2581.321, 362.039, 108.468},
	{176.631, -1562.025, 29.263},
	{176.631, -1562.025, 29.263},
	{-319.292, -1471.715, 30.549},
	{1784.324, 3330.55, 41.253}
}

RegisterNetEvent('clothing:ToggleClothing')
AddEventHandler('clothing:ToggleClothing', function()
    showClothingShopBlips = not showClothingShopBlips
    for _, item in pairs(ClothingShop) do 
        if not showClothingShopBlips then 
            if item.blip ~= nil then 
                RemoveBlip(item.blip) 
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 73)
            SetBlipColour(item.blip, 5)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)


RegisterNetEvent('gasstations:ToggleGas')
AddEventHandler('gasstations:ToggleGas', function()
    showGasBlips = not showGasBlips
    for _, item in pairs(GasStations) do 
        if not showGasBlips then 
            if item.blip ~= nil then 
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 361)
            SetBlipColour(item.blip, 1)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Fuel Station")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)


RegisterNetEvent('storage:Togglestorage')
AddEventHandler('storage:Togglestorage', function()
    showStorageBlips = not showStorageBlips
    for _, item in pairs(storageLockers) do 
        if not showStorageBlips then 
            if item.blip ~= nil then 
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 50)
            SetBlipColour(item.blip, 5)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Storage Units")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

function addBlips()
    showBarberShopBlips = false
    showTattooShopBlips = false
    showClothingShopBlips = false
    showStorageBlips = false
    showGasBlips = false
    TriggerEvent('hairDresser:ToggleHair')
    TriggerEvent('tattoo:ToggleTattoo')
    TriggerEvent('clothing:ToggleClothing')
end
