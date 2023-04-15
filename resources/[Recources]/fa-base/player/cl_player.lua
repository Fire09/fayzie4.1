DPX.Player = DPX.Player or {}
DPX.LocalPlayer = DPX.LocalPlayer or {}

local function GetUser()
    return DPX.LocalPlayer
end

function DPX.LocalPlayer.setVar(self, var, data)
    GetUser()[var] = data
end

function DPX.LocalPlayer.getVar(self, var)
    return GetUser()[var]
end

function DPX.LocalPlayer.setCurrentCharacter(self, data)
    if not data then return end
    GetUser():setVar("character", data)
end

function DPX.LocalPlayer.getCurrentCharacter(self)
    return GetUser():getVar("character")
end

RegisterNetEvent("fa-base:networkVar")
AddEventHandler("fa-base:networkVar", function(var, val)
    DPX.LocalPlayer:setVar(var, val)
end)

RegisterNetEvent('returnOldRouting')
AddEventHandler('returnOldRouting', function()
    TriggerServerEvent('fa-spawn:SetOldRouting')
end)