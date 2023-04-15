local ThermitedDoor = false

RegisterServerEvent('fa-heists:thermite_var')
AddEventHandler('fa-heists:thermite_var', function()
    local src = source

    if not ThermitedDoor then
        TriggerClientEvent('fa-heists:var_door_to_lobby', src)
    end
end)

RegisterServerEvent('fa-heists:var_thermite')
AddEventHandler('fa-heists:var_thermite', function()
    ThermitedDoor = true
end)

-- Entry 1 --

local InVAR1 = false

RegisterServerEvent('fa-heists:in_var_1_srv')
AddEventHandler('fa-heists:in_var_1_srv', function()
    local src = source

    if not InVAR1 then
        if ThermitedDoor then
            TriggerClientEvent('fa-heists:enter_var_location_1', src)
            InVAR1 = true
        else
            TriggerClientEvent('DoLongHudText', src, 'Nice try but it doesnt quite work like this.', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'Find another computer someone already used this one.', 2)
    end
end)

-- Entry 2 --

local InVAR2 = false

RegisterServerEvent('fa-heists:in_var_2_srv')
AddEventHandler('fa-heists:in_var_2_srv', function()
    local src = source

    if not InVAR2 then
        if ThermitedDoor then
            TriggerClientEvent('fa-heists:enter_var_location_2', src)
            InVAR2 = true
        else
            TriggerClientEvent('DoLongHudText', src, 'Nice try but it doesnt quite work like this.', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'Find another computer someone already used this one.', 2)
    end
end)

-- Entry 3 --

local InVAR3 = false

RegisterServerEvent('fa-heists:in_var_3_srv')
AddEventHandler('fa-heists:in_var_3_srv', function()
    local src = source

    if not InVAR3 then
        if ThermitedDoor then
            TriggerClientEvent('fa-heists:enter_var_location_3', src)
            InVAR3 = true
        else
            TriggerClientEvent('DoLongHudText', src, 'Nice try but it doesnt quite work like this.', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'Find another computer someone already used this one.', 2)
    end
end)

-- Entry 4 --

local InVAR4 = false

RegisterServerEvent('fa-heists:in_var_4_srv')
AddEventHandler('fa-heists:in_var_4_srv', function()
    local src = source

    if not InVAR4 then
        if ThermitedDoor then
            TriggerClientEvent('fa-heists:enter_var_location_4', src)
            InVAR4 = true
        else
            TriggerClientEvent('DoLongHudText', src, 'Nice try but it doesnt quite work like this.', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'Find another computer someone already used this one.', 2)
    end
end)

-- Entry 5 --

local InVAR5 = false

RegisterServerEvent('fa-heists:in_var_5_srv')
AddEventHandler('fa-heists:in_var_5_srv', function()
    local src = source

    if not InVAR5 then
        if ThermitedDoor then
            TriggerClientEvent('fa-heists:enter_var_location_5', src)
            InVAR5 = true
        else
            TriggerClientEvent('DoLongHudText', src, 'Nice try but it doesnt quite work like this.', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'Find another computer someone already used this one.', 2)
    end
end)



--- first hack start

local canhack = true
local canhack1 = false
local canhack2 = false
local canhack3 = false
local canhack4 = false
local canhack5 = false
local canupload = false
local canupload2 = false
local canleave = false

RegisterServerEvent('fa-heists:hack1')
AddEventHandler('fa-heists:hack1', function()
    local src = source

    if canhack then
        TriggerClientEvent('varhack:1', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse')
AddEventHandler('fa-heists:hackfalse', function()
    canhack = false
    canhack1 = true
end)

--- first hack end

RegisterServerEvent('fa-heists:hack2')
AddEventHandler('fa-heists:hack2', function()
    local src = source

    if canhack1 then
        TriggerClientEvent('varhack:2', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse2')
AddEventHandler('fa-heists:hackfalse2', function()
canhack1 = false
canhack2 = true
end)


RegisterServerEvent('fa-heists:hack3')
AddEventHandler('fa-heists:hack3', function()
    local src = source

    if canhack2 then
        TriggerClientEvent('varhack:3', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse3')
AddEventHandler('fa-heists:hackfalse3', function()
canhack2 = false
canhack3 = true
end)

RegisterServerEvent('fa-heists:hack4')
AddEventHandler('fa-heists:hack4', function()
    local src = source

    if canhack3 then
        TriggerClientEvent('varhack:4', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse4')
AddEventHandler('fa-heists:hackfalse4', function()
canhack3 = false
canhack4 = true
end)

RegisterServerEvent('fa-heists:hack5')
AddEventHandler('fa-heists:hack5', function()
    local src = source

    if canhack4 then
        TriggerClientEvent('varhack:5', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse5')
AddEventHandler('fa-heists:hackfalse5', function()
canhack4 = false
canhack5 = true
end)

RegisterServerEvent('fa-heists:hack6')
AddEventHandler('fa-heists:hack6', function()
    local src = source

    if canhack5 then
        TriggerClientEvent('varhack:6', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse6')
AddEventHandler('fa-heists:hackfalse6', function()
canhack5 = false
canupload = true
end)

RegisterServerEvent('fa-heists:hack7')
AddEventHandler('fa-heists:hack7', function()
    local src = source

    if canupload then
        TriggerClientEvent('varhack:7', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse7')
AddEventHandler('fa-heists:hackfalse7', function()
canupload = false
canupload2 = true
end)

RegisterServerEvent('fa-heists:hack8')
AddEventHandler('fa-heists:hack8', function()
    local src = source

    if canupload2 then
        TriggerClientEvent('varhack:8', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You are not ready for this or you have already completed', 2)
    end
end)

RegisterServerEvent('fa-heists:hackfalse8')
AddEventHandler('fa-heists:hackfalse8', function()
canupload2 = false
canleave = true
end)


RegisterServerEvent('fa-leavevar2')
AddEventHandler('fa-leavevar2', function()
    local src = source

    if canleave then
        TriggerClientEvent('exit:varcompleteheist', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'you cant leave yet', 2)
    end
end)

local canloot = true

RegisterServerEvent('fa-evannicxvar:varlootcooldown')
AddEventHandler('fa-evannicxvar:varlootcooldown', function()
    local src = source

    if canloot then
        TriggerClientEvent('fa-heists:var_loot_ped', src)
        canloot = false
        Citizen.Wait(300000)
        canloot = true
    else
        TriggerClientEvent('DoLongHudText', src, '5 minute cooldown', 2)
    end
end)

