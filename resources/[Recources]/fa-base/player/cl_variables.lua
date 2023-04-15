--[[

    Variables

]]

local PlayerVars = PlayerVars or {}

local DefaultVars = {
    ["dead"] = false,
    ["handcuffed"] = false,
    ["recentcuff"] = 0,
    ["trunk"] = false,
    ["call"] = false,
}

--[[

    Functions

]]

function setVar(var, data)
    PlayerVars[var] = data
end

function getVar(var)
    return PlayerVars[var]
end

function setChar(var, data)
    if not PlayerVars["char"] then return end

    PlayerVars["char"][var] = data
end

function getChar(var)
    if PlayerVars["char"] then
        if var then
            return PlayerVars["char"][var]
        end

        return PlayerVars["char"]
    else
        return
    end
end

function resetVars()
    for k, v in pairs(DefaultVars) do
        PlayerVars[k] = v
    end
end

--[[

    Exports

]]

exports("setVar", setVar)
exports("getVar", getVar)
exports("setChar", setChar)
exports("getChar", getChar)
exports("resetVars", resetVars)

--[[

    Events

]]

RegisterNetEvent("fa-base:setVar")
AddEventHandler("fa-base:setVar", setVar)

RegisterNetEvent("fa-base:setChar")
AddEventHandler("fa-base:setChar", setChar)

RegisterNetEvent("fa-base:resetVars")
AddEventHandler("fa-base:resetVars", resetVars)

--[[

    Threads

]]

Citizen.CreateThread(function()
    resetVars()
end)