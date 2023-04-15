DPX.SpawnManager = {}

function DPX.SpawnManager.Initialize(self)
    Citizen.CreateThread(function()

        FreezeEntityPosition(PlayerPedId(), true)

        TransitionToBlurred(500)
        DoScreenFadeOut(500)

        ShutdownLoadingScreen()

        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

        SetCamRot(cam, 0.0, 0.0, -45.0, 2)
        SetCamCoord(cam, -682.0, -1092.0, 226.0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)

        local ped = PlayerPedId()

        SetEntityCoordsNoOffset(ped, -682.0, -1092.0, 200.0, false, false, false, true)

        SetEntityVisible(ped, false)

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end

        TriggerEvent("fa-base:spawnInitialized")
        TriggerServerEvent("fa-base:spawnInitialized")

    end)
end

function DPX.SpawnManager.InitialSpawn(self)
    Citizen.CreateThread(function()
        DisableAllControlActions(0)
      
        DoScreenFadeOut(10)

        while IsScreenFadingOut() do
            Citizen.Wait(0)
        end

        local character = DPX.LocalPlayer:getCurrentCharacter()


        --Tells raid clothes to set ped to correct skin
        TriggerEvent("fa-base:initialSpawnModelLoaded")

        local ped = PlayerPedId()

        SetEntityVisible(ped, true)
        FreezeEntityPosition(PlayerPedId(), false)
        
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)
        --ClearPlayerWantedLevel(PlayerId())

        EnableAllControlActions(0)

        TriggerEvent("character:finishedLoadingChar")
    end)
end

AddEventHandler("fa-base:firstSpawn", function()
    DPX.SpawnManager:InitialSpawn()

    Citizen.CreateThread(function()
        Citizen.Wait(600)
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end)

RegisterNetEvent('fa-base:clearStates')
AddEventHandler('fa-base:clearStates', function()
  TriggerEvent("isJudgeOff")
  TriggerEvent("nowCopSpawnOff")
  TriggerEvent("nowEMSDeathOff")
  TriggerEvent("police:noLongerCop")
  TriggerEvent("nowCopDeathOff")
  TriggerEvent("ResetFirstSpawn")
  TriggerEvent("stopSpeedo")
  TriggerServerEvent("TokoVoip:removePlayerFromAllRadio",GetPlayerServerId(PlayerId()))
  TriggerEvent("wk:disableRadar")
end)



DPX.SettingsData = DPX.SettingsData or {}
DPX.Settings = DPX.Settings or {}

DPX.Settings.Current = {}
-- Current bind name and keys
DPX.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["clickVolume"] = 0.8,
    ["radioVolume"] = 0.8,
    ["phoneVolume"] = 0.8,
    ["releaseDelay"] = 200
  },
  ["hud"] = {

  }

}


function DPX.SettingsData.setSettingsTable(settingsTable, shouldSend)
  if settingsTable == nil then
    DPX.Settings.Current = DPX.Settings.Default
    TriggerServerEvent('fa-base:sv:player_settings_set',DPX.Settings.Current)
    DPX.SettingsData.checkForMissing()
  else
    if shouldSend then
      DPX.Settings.Current = settingsTable
      TriggerServerEvent('fa-base:sv:player_settings_set',DPX.Settings.Current)
      DPX.SettingsData.checkForMissing()
    else
       DPX.Settings.Current = settingsTable
       DPX.SettingsData.checkForMissing()
    end
  end

  TriggerEvent("event:settings:update",DPX.Settings.Current)

end

function DPX.SettingsData.setSettingsTableGlobal(self, settingsTable)
  DPX.SettingsData.setSettingsTable(settingsTable,true);
end

function DPX.SettingsData.getSettingsTable()
    return DPX.Settings.Current
end

function DPX.SettingsData.setVarible(self,tablename,atrr,val)
  DPX.Settings.Current[tablename][atrr] = val
  TriggerServerEvent('fa-base:sv:player_settings_set',DPX.Settings.Current)
end

function DPX.SettingsData.getVarible(self,tablename,atrr)
  return DPX.Settings.Current[tablename][atrr]
end

function DPX.SettingsData.checkForMissing()
  local isMissing = false

  for j,h in pairs(DPX.Settings.Default) do
    if DPX.Settings.Current[j] == nil then
      isMissing = true
      DPX.Settings.Current[j] = h
    else
      for k,v in pairs(h) do
        if  DPX.Settings.Current[j][k] == nil then
           DPX.Settings.Current[j][k] = v
           isMissing = true
        end
      end
    end
  end
  

  if isMissing then
    TriggerServerEvent('fa-base:sv:player_settings_set',DPX.Settings.Current)
  end


end

RegisterNetEvent("fa-base:cl:player_settings")
AddEventHandler("fa-base:cl:player_settings", function(settingsTable)
  DPX.SettingsData.setSettingsTable(settingsTable,false)
end)


RegisterNetEvent("fa-base:cl:player_reset")
AddEventHandler("fa-base:cl:player_reset", function(tableName)
  if DPX.Settings.Default[tableName] then
      if DPX.Settings.Current[tableName] then
        DPX.Settings.Current[tableName] = DPX.Settings.Default[tableName]
        DPX.SettingsData.setSettingsTable(DPX.Settings.Current,true)
      end
  end
end)
