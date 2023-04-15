DPX.Core = DPX.Core or {}

function DPX.Core.ConsoleLog(self, msg, mod)
    if not tostring(msg) then return end
    if not tostring(mod) then mod = "No Module" end
    
    local pMsg = string.format("[DPX LOG - %s] %s", mod, msg)
    if not pMsg then return end

    print(pMsg)
end

RegisterNetEvent("fa-base:consoleLog")
AddEventHandler("fa-base:consoleLog", function(msg, mod)
    DPX.Core:ConsoleLog(msg, mod)
end)

function getModule(module)
    if not DPX[module] then print("Warning: '" .. tostring(module) .. "' module doesn't exist") return false end
    return DPX[module]
end

function addModule(module, tbl)
    if DPX[module] then print("Warning: '" .. tostring(module) .. "' module is being overridden") end
    DPX[module] = tbl
end

DPX.Core.ExportsReady = false

function DPX.Core.WaitForExports(self)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if exports and exports["fa-base"] then
                TriggerEvent("fa-base:exportsReady")
                DPX.Core.ExportsReady = true
                return
            end
        end
    end)
end

exports("getModule", getModule)
exports("addModule", addModule)
DPX.Core:WaitForExports()