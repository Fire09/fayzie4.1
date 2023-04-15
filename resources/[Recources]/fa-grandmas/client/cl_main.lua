local NearGrandmas = false

Citizen.CreateThread(function()
  exports["fa-polyzone"]:AddBoxZone("grandmas", vector3(2435.32, 4966.31, 42.35), 2.8, 2, {
    name="grandmas",
    heading=315,
    --debugPoly=true,
    minZ=40.55,
    maxZ=43.15
  })  
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
  if name == "grandmas" then
      NearGrandmas = true
      NearGrandmasHoe()
      exports['fa-interface']:showInteraction("[E] - Grandmas ($1000)")
    end
end) 

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
  if name == "grandmas" then
    NearGrandmas = false
  end
  exports['fa-interface']:hideInteraction()
end)


function NearGrandmasHoe()
  Citizen.CreateThread(function()
    while NearGrandmas do
      Citizen.Wait(5)
      if IsControlPressed(1,38) then
        TriggerServerEvent("grandmas:attemt:checkin")
      end
    end
  end)
end



RegisterNetEvent("grandmas:success:attemt", function()
  local finished = exports["fa-taskbar"]:taskBar(math.random(60000, 120000), "Grandma is helping you up!")
  if finished == 100 then
    TriggerEvent("fa-death:revive")
    TriggerServerEvent("grandmas:bill")
    TriggerEvent("DoLongHudText", "Success!")
  end
end)