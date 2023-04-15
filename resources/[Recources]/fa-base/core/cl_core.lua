DPX.Core.hasLoaded = false


function DPX.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("fa-base:playerSessionStarted")
                TriggerServerEvent("fa-base:playerSessionStarted")
                break
            end
        end
    end)
end
DPX.Core:Initialize()

AddEventHandler("fa-base:playerSessionStarted", function()
    while not DPX.Core.hasLoaded do
        --print("waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    DPX.SpawnManager:Initialize()
end)

RegisterNetEvent("fa-base:waitForExports")
AddEventHandler("fa-base:waitForExports", function()
    if not DPX.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["fa-base"] then
            TriggerEvent("fa-base:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    print("player has spawned ")
    if not DPX.Core.hasLoaded then
         DPX.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)

-- Discord Rich Presence --