pRan = false

function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("fa-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("fa-base:initialSpawnModelLoaded")
  -- Main events leave alone 

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent("fx:clear")
  TriggerServerEvent("fa-clothing:retrieve_tats")
  TriggerEvent('fa-bankrobbery:client:CreateTrollysEvent')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('fa-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent("requestOffices")
  Wait(500)
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("server:currentpasses")
  TriggerEvent("fa-hud:SetValues", exports['isPed']:isPed('cid'))
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent('fa-scoreboard:AddPlayer')
  TriggerServerEvent("fa-base:PolyZoneUpdate")
  TriggerEvent("fa-housing:loadHousingClient")
  TriggerEvent("fa-admin/client/loadMenu")
  TriggerServerEvent("fa-housing:getGarages")
  TriggerServerEvent("fa-phone:getAbdulTaxies")
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))
  TriggerServerEvent("fa-phone:checkForNonDocumentedLicenses", exports['isPed']:isPed("cid"))
  -- TriggerServerEvent("weapon:general:check")
  -- Anything that might need to wait for the client to get information, do it here.
  TriggerServerEvent("login:get:keys")

  --Sync Whiteboards
  TriggerServerEvent("SpawnEventsServer")

  --Meth shit
  TriggerServerEvent('fa-methtable:spawnInitialized')

  
  -- // New Clothing Menu // --
  --TriggerServerEvent("ev_clothing:retrieve_tats")
  --TriggerServerEvent('ev_clothing:get_character_current')
  --TriggerServerEvent('ev_clothing:get_character_face')

  TriggerServerEvent("fa-weapons:getAmmo")
  Wait(4000)
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('fa-hud:EnableHud', true)
end

RegisterNetEvent('fa-spawn:spawnCharacter')
AddEventHandler('fa-spawn:spawnCharacter', function()

  if not pRan then
    pRan = true
    isNear = false
    TriggerServerEvent('fa-base:sv:player_control')
    TriggerServerEvent('fa-base:sv:player_settings')
    TriggerEvent("spawning", false)
    TriggerEvent("attachWeapons")
    TriggerServerEvent("request-dropped-items")
    TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

    if Spawn.isNew then
        Wait(1000)

        TriggerEvent('fa-hud:ChangeThirst', 95)
        TriggerEvent('fa-hud:ChangeHunger', 95)
        TriggerEvent('fa-hud:SaveValues')
        TriggerServerEvent('fa-spawn:initBoosting')
        -- TriggerServerEvent('fa-spawn:licenses')

        -- commands to make sure player is alive and full food/water/health/no injuries
        local src = GetPlayerServerId(PlayerId())
        TriggerServerEvent("reviveGranted", src)
        TriggerEvent("Hospital:HealInjuries", src, true)
        TriggerServerEvent("ems:healplayer", src)
        TriggerEvent("heal", src)
        TriggerEvent("status:needs:restore", src) 

        TriggerServerEvent("fa-spawn:newPlayerFullySpawned")
      end
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  runGameplay()
  Spawn.isNew = false
end)