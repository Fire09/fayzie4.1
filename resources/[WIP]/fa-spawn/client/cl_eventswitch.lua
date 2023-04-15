function Login.playerLoaded() end

function Login.characterLoaded()
 -- Main events leave alone 
 TriggerEvent("fa-base:playerSpawned")
 TriggerEvent("playerSpawned")
 TriggerServerEvent('character:loadspawns')
 -- Main events leave alone 

 TriggerEvent("Relog")

 -- Everything that should trigger on character load 
 TriggerServerEvent('checkTypes')
 TriggerServerEvent('isVip')
 TriggerEvent('rehab:changeCharacter')
 TriggerEvent("resetinhouse")
 TriggerEvent("fx:clear")
 TriggerServerEvent("raid_clothes:retrieve_tats")
 TriggerServerEvent('Blemishes:retrieve')
 TriggerServerEvent("currentconvictions")
 TriggerServerEvent("GarageData")
 TriggerServerEvent("Evidence:checkDna")
 TriggerEvent("banking:viewBalance")
 TriggerServerEvent("police:getLicensesCiv")
 TriggerServerEvent('fa-doors:requestlatest')
 TriggerServerEvent("item:UpdateItemWeight")
 TriggerServerEvent("fa-weapons:getAmmo")
 TriggerServerEvent("ReturnHouseKeys")
 TriggerServerEvent("requestOffices")
 TriggerServerEvent('fa-base:addLicenses')
 Wait(500)
 TriggerEvent("fa-housing:loadHousingClient")
 TriggerServerEvent("fa-housing:getGarages")
 TriggerServerEvent('commands:player:login')
 TriggerServerEvent("police:getAnimData")
 TriggerServerEvent("police:getEmoteData")
 TriggerServerEvent("police:SetMeta")
 TriggerServerEvent("retreive:licenes:server")
 TriggerServerEvent("clothing:checkIfNew")
 -- Anything that might need to wait for the client to get information, do it here.
 Wait(3000)
 TriggerServerEvent("bones:server:requestServer")
 TriggerEvent("apart:GetItems")
 TriggerEvent("fa-editor:readyModels")
 Wait(4000)
 TriggerServerEvent('distillery:getDistilleryLocation')
 TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
 TriggerServerEvent("bank:getLogs")
 TriggerEvent('fa-hud:EnableHud', true)
 TriggerServerEvent('void:getmapprefrence')
 TriggerServerEvent('fa-phone:grabWallpaper')
 TriggerServerEvent('evidence:StoringEnabled')
 TriggerServerEvent('evidence:getDNA')
 TriggerServerEvent('banking-loaded-in')
 TriggerServerEvent('fa-base:updatedphoneLicenses')
 TriggerServerEvent('getallplayers')
 TriggerServerEvent('evidence:bonesRaggsyy')
 TriggerEvent("fa-base:PolyZoneUpdate")
 TriggerServerEvent('fa-scoreboard:AddPlayer')
 TriggerServerEvent("server:currentpasses")
 TriggerServerEvent('fa-base:addLicenses')
 TriggerEvent("fa-phone:phone:fetch")
 TriggerEvent("isJudgeOff")
 exports['fa-interface']:showInteraction("UI Started")
 Wait(1000)
 exports['fa-interface']:hideInteraction()
 TriggerServerEvent("request-dropped-items")
 TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))
 TriggerServerEvent("request-dropped-items")
 TriggerEvent("fa-inventory:request:client:update")
 TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))
 TriggerServerEvent("fa-inventory:request:update", exports["isPed"]:isPed("cid"))
 TriggerServerEvent("striez-ready-inventory")
end

function Login.characterSpawned()
  isNear = false
  TriggerServerEvent('fa-base:sv:player_control')
  TriggerServerEvent('fa-base:sv:player_settings')

  TriggerServerEvent("TokoVoip:clientHasSelecterCharacter")
  TriggerEvent("spawning", false)
  TriggerEvent("inSpawn", false)
  TriggerEvent("attachWeapons")
  TriggerEvent("tokovoip:onPlayerLoggedIn", true)

  TriggerEvent("fa-hud:initHud")

  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))
  TriggerServerEvent("fa-inventory:request:update", exports["isPed"]:isPed("cid"))
  TriggerEvent("fa-inventory:request:client:update")
  TriggerServerEvent("striez-ready-inventory")
  TriggerEvent("isJudgeOff")
  if Spawn.isNew then
      Wait(1000)
      TriggerEvent("hud:saveCurrentMeta")

      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("status:needs:restore", src)
      TriggerServerEvent('fa-spawn:initBoosting')
      TriggerServerEvent("fa-spawn:newPlayerFullySpawned")
  end

  SetPedMaxHealth(PlayerPedId(), 200)
  
  runGameplay() -- moved from fa-base 
  Spawn.isNew = false
end
RegisterNetEvent("fa-spawn:characterSpawned");
AddEventHandler("fa-spawn:characterSpawned", Login.characterSpawned);

RegisterNetEvent("fa-spawn:getStartingItems");
AddEventHandler("fa-spawn:getStartingItems", function()
  TriggerEvent("player:receiveItem", "idcard",1,true,information)
	TriggerEvent("player:receiveItem", "mobilephone",1,true,information)
end)

RegisterNetEvent("fa-spawn:getNewAccountBox");
AddEventHandler("fa-spawn:getNewAccountBox", function(cid)
 -- // TriggerEvent("player:receiveItem", "presents", 1)
end)
