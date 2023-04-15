-- Settings
local serverNotes = {}
local Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondaryWorld"] = {23,"F"}} 


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end

Citizen.CreateThread(function()
  local interactionActive = false

  while true do
    Citizen.Wait(1)


    if #serverNotes == 0 then
      Citizen.Wait(1000)
    else
      local plyLoc = GetEntityCoords(PlayerPedId())
      local closestNoteDistance = 900.0
      local closestNoteId = 0
      for i = 1, #serverNotes do
        local distance = #(plyLoc - vector3( serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]))

        if distance < 10.0 then
            DrawMarker(27, serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 2.0, 255, 255,150, 75, 0, 0, 2, 0, 0, 0, 0)
        end

        if distance < closestNoteDistance then
          closestNoteDistance = distance
          closestNoteId = i
        end
      end

      if closestNoteDistance > 100.0 then
        Citizen.Wait(math.ceil(closestNoteDistance*10))
      end
      if serverNotes[closestNoteId] ~= nil then
        local distance = #(plyLoc - vector3( serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]))
        if distance < 2.0 then
            DrawMarker(27, serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 2.0, 255, 255, 155, 75, 0, 0, 2, 0, 0, 0, 0)
            if not interactionActive then
              interactionActive = true
              showTextUI("[E] Read Note / [F] Destroy Note")
            end
            if IsControlJustReleased(0, Controlkey["generalUse"][1]) then
             --   openGuiRead(serverNotes[closestNoteId]["text"])
                openGui(nil, nil)

                local pDocShared = RPC.execute("fa-phone:acceptDocumentReceiveRequest", serverNotes[closestNoteId]["text"])
                SendNUIMessage({
                    openSection = "openSharedDocument",
                    documentData = pDocShared
                })
            end
            if IsControlJustReleased(0, Controlkey["generalUseSecondaryWorld"][1]) then
              TriggerServerEvent("server:destroyNote",closestNoteId)
              interactionActive = false
              Wait(500)
              hideTextUI()
            end

          elseif interactionActive == true then
            interactionActive = false
            hideTextUI()
          end
        else
          if interactionActive then
            interactionActive = false
            hideTextUI()
          end
        if serverNotes[closestNoteId] ~= nil then
          table.remove(serverNotes,closestNoteId)
        end
      end
    end
  end
end)

RegisterNetEvent('client:updateNotes')
AddEventHandler('client:updateNotes', function(serverNotesPassed)
    serverNotes = serverNotesPassed
end)

RegisterNetEvent('client:updateNotesAdd')
AddEventHandler('client:updateNotesAdd', function(newNote)
    serverNotes[#serverNotes+1] = newNote 
end)
RegisterNetEvent('client:updateNotesRemove')
AddEventHandler('client:updateNotesRemove', function(id)
    table.remove(serverNotes,id)
end)

CreateThread(function()
  Wait(200)
  TriggerServerEvent("server:requestNotes")
end)
