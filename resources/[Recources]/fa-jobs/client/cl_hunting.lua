local cooldown = 0
local used = false
local jobSpawned = false
local refreshPed = false
local jobPed
local useBaitCooldown = 3
local illegalhunting = false

local HuntingZones =  { 
  'MTCHIL',
  'CANNY',
  'MTGORDO',
  'CMSW',
  'MTJOSE',
}

local HuntingAnimals = {
  'a_c_boar',
  'a_c_deer',
  'a_c_coyote',
  'a_c_mtlion',
}

local dumbass = vector3(-679.89,5838.79,16.33)

Citizen.CreateThread(function()
  blip = AddBlipForCoord(-679.89,5838.79,16.33)
  SetBlipSprite(blip, 141)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Hunting Shop")
  EndTextCommandSetBlipName(blip)

  blip = AddBlipForCoord(12.19, -1299.85, 29.22)
  SetBlipSprite(blip, 141)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Hunting Sales")
  EndTextCommandSetBlipName(blip)

  SetScenarioTypeEnabled('WORLD_DEER_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_WANDER',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_REST',false)
  --SetScenarioTypeEnabled('WORLD_RABBIT_EATING',false)
  SetScenarioTypeEnabled('WORLD_BOAR_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_WANDER',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_REST',false)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local pedCoords = GetEntityCoords(GetPlayerPed(-1))
    local dst = #(dumbass - pedCoords)
    if dst < 40 and jobSpawned == false then
      TriggerEvent('fa-hunting:spawnJobPed',dumbass, 225.87)
      jobSpawned = true
      refreshPed = true
    end
    if dst >= 41  then
      if DoesEntityExist(jobPed) then
        DeletePed(jobPed)
      end
      jobSpawned = false
    end
  end
end)

RegisterNetEvent('fa-hunting:spawnAnimal')
AddEventHandler('fa-hunting:spawnAnimal', function()
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  local radius = 100.0
  local x = coords.x + math.random(-radius,radius)
  local y = coords.y + math.random(-radius,radius)
  local safeCoord, outPosition = GetSafeCoordForPed(x,y,coords.z,false,16)

  animal = HuntingAnimals[math.random(#HuntingAnimals)]
  local hash = GetHashKey(animal)
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  if outPosition.x > 1 or outPosition.x < -1  then
    --Wait(2000)
    Wait(8000)
    baitAnimal = CreatePed(28, hash, outPosition.x, outPosition.y, outPosition.z, 0, true, false)
  end
  if DoesEntityExist(baitAnimal) then
    TaskGoToCoordAnyMeans(baitAnimal,coords,2.0,0,786603,0)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if DoesEntityExist(baitAnimal) then
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(GetPlayerPed(-1))
      local animalCoords = GetEntityCoords(baitAnimal)
      local dst = #(coords - animalCoords)
      print('Animal Coords: '..animalCoords)
      print('Distance: '..dst)
      if dst < 2.5 then -- spook animal
        TaskCombatPed(baitAnimal,ped,0,16)
      end
    end
  end
end)

RegisterNetEvent('fa-hunting:skinAnimal')
AddEventHandler('fa-hunting:skinAnimal', function()
  if exports["fa-inventory"]:hasEnoughOfItem("huntingknife", 1) then
    if DoesEntityExist(baitAnimal) then
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        local finished = exports["fa-taskbar"]:taskBar(5000,"Skinning")
        if finished == 100 then
          ClearPedTasksImmediately(PlayerPedId())
          DeleteEntity(baitAnimal)
          TriggerServerEvent('fa-hunting:skinReward')
        end
    end
  else
    TriggerEvent('DoLongHudText', 'You do not have a hunting knife!', 2)
  end
end)

RegisterNetEvent('fa-hunting:usedBait')
AddEventHandler('fa-hunting:usedBait', function()
  for k,v in pairs (HuntingZones) do
    if IsEntityInZone(GetPlayerPed(-1),v) then
      if cooldown <= 0 then
        LoadAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        local finished = exports["fa-taskbar"]:taskBar(5000,"Placing Bait",false,false,playerVeh)
        Citizen.Wait(100)
        cooldown = useBaitCooldown * 10000
        ClearPedTasksImmediately(PlayerPedId())
        used = true
        usedBait()
        TriggerEvent('fa-hunting:spawnAnimal')
        TriggerServerEvent('fa-hunting:removeBait')
        baitCooldown()
      end
    end
  end
end)

function baitCooldown()
  Citizen.CreateThread(function()
    while cooldown > 0 do
      Wait(2000)
      cooldown = cooldown - 1000
    end
  end)
end

function usedBait()
  Citizen.CreateThread(function()
    while used do
      Wait(30000)
      TriggerEvent('fa-hunting:spawnAnimal')
      used = false
    end
  end)
end

function playerAnim()
	LoadAnimDict( "mp_safehouselost@" )
  TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function LoadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(10)
  end
end


local blips = {

	{title="Hunting Area", colour=3, id=141, x = -973.44, y = 4424.14, z = 18.16},
	}
  
	Citizen.CreateThread(function()
  Citizen.Wait(0)
  local bool = true
	if bool then
		  for k,v in pairs(blips) do
				 zoneblip = AddBlipForRadius(v.x,v.y,v.z, 4000.0)
							SetBlipSprite(zoneblip,1)
							SetBlipColour(zoneblip,62)
							SetBlipAlpha(zoneblip,75)	   
		      end
        for _, info in pairs(blips) do
        
          info.blip = AddBlipForCoord(info.x, info.y, info.z)
                SetBlipSprite(info.blip, info.id)
                SetBlipDisplay(info.blip, 4)
                SetBlipColour(info.blip, info.colour)
                SetBlipAsShortRange(info.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(info.title)
                EndTextCommandSetBlipName(info.blip)
		        end
		    bool = false
	    end
  end)


-- RegisterCommand('getzone', function()
--   Coords = GetEntityCoords(GetPlayerPed(-1))
--   ZoneName = GetNameOfZone(Coords)
--   print(ZoneName)
-- end)

--// Aimblock

local hasHuntingRifle = false
local isFreeAiming = false

local function processScope(freeAiming)
    if not isFreeAiming and freeAiming then
        isFreeAiming = true
        exports["fa-ui"]:sendAppEvent("sniper-scope", { show = true })
    elseif isFreeAiming and not freeAiming then
        isFreeAiming = false
        exports["fa-ui"]:sendAppEvent("sniper-scope", { show = false })
    end
end

local blockShotActive = false
local function blockShooting()
    if blockShotActive then return end
    blockShotActive = true
    Citizen.CreateThread(function()
        while hasHuntingRifle do
            local ply = PlayerId()
            local ped = PlayerPedId()
            local ent = nil
            local aiming, ent = GetEntityPlayerIsFreeAimingAt(ply)
            local freeAiming = IsPlayerFreeAiming(ply)
            processScope(freeAiming)
            local et = GetEntityType(ent)
            if not freeAiming
                or IsPedAPlayer(ent)
                or et == 2
                or (et == 1 and IsPedInAnyVehicle(ent))
            then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisablePlayerFiring(ped, true)
            end
            Citizen.Wait(0)
        end
        blockShotActive = false
        processScope(false)
    end)
end

Citizen.CreateThread(function()
    local huntingRifleHash = `weapon_sniperrifle2` -- -646649097

    while true do
        if GetSelectedPedWeapon(PlayerPedId()) == huntingRifleHash then
            hasHuntingRifle = true
            blockShooting()
        else
            hasHuntingRifle = false
        end
        Citizen.Wait(1000)
    end
end)

--// Hunting Sales

local carcasses = {
  { name = "huntingcarcass1", price = 125, illegal = false },
  { name = "huntingcarcass2", price = 250, illegal = false },
  { name = "huntingcarcass3", price = 375, illegal = false },
  { name = "huntingcarcass4", price = 5, illegal = true },
}


local function sellAnimals()
  local totalCash = 0
  local totalBMarketCash = 0

  for _, carcass in pairs(carcasses) do
      local qty = exports["fa-inventory"]:getQuantity(carcass.name)

      if qty > 0 then
          if not carcass.illegal then
              totalCash = totalCash + (carcass.price * qty)
              TriggerEvent("inventory:removeItem", carcass.name, qty)
              TriggerEvent("player:receiveItem", "freshmeat",math.random(1,5))
          elseif isNight() then
              totalBMarketCash = totalBMarketCash + (carcass.price * qty)
              TriggerEvent("player:receiveItem", "rollcash",math.random(10,25))  --// Least = $1,100 ||||| Most = $2,225
              TriggerEvent("player:receiveItem", "freshmeat",math.random(1,5))
              TriggerEvent("inventory:removeItem", carcass.name, qty)
          end
      end
  end

  if totalCash == 0 and totalBMarketCash == 0 then
      TriggerEvent("DoLongHudText", "Nothing to sell, dummy.", 2)
  end
  
  if totalCash > 0 then
      TriggerServerEvent("complete:job", totalCash)
  end

  if totalBMarketCash > 0 then
      TriggerEvent("player:receiveItem", "band", totalBMarketCash)
  end
end

local listening = false
local function listenForKeypress()
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              listening = false
              sellAnimals()
          end
          Wait(0)
      end
  end)
end

AddEventHandler("fa-polyzone:enter", function(name)
  if name ~= "huntingsales" then return end
  exports['fa-interface']:showInteraction("[E] Sell Animal Carcass")
  listenForKeypress()
end)

AddEventHandler("fa-polyzone:exit", function(name)
  if name ~= "huntingsales" then return end
  exports['fa-interface']:hideInteraction()
  listening = false
end)

function isNight()
local hour = GetClockHours()
if hour > 21 or hour < 3 then
  return true
end
end

function huntingPeds()
  modelHash = GetHashKey("csb_chef")
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
      Wait(1)
  end
  created_ped = CreatePed(0, modelHash , 11.512088775635, -1299.82421875, 29.229248046875  -1, true)
  FreezeEntityPosition(created_ped, true)
  SetEntityHeading(created_ped, 235.27558898926)
  SetEntityInvincible(created_ped, true)
  SetBlockingOfNonTemporaryEvents(created_ped, true)
end

Citizen.CreateThread(function()
  huntingPeds()
end)

--// Polyzone 

Citizen.CreateThread(function()
  exports["fa-polyzone"]:AddCircleZone("huntingsales", vector3(12.28, -1299.32, 29.29), 1.3, {
      useZ = true,
      debugPoly= false,
  })
end)