function signOff()
  if exports["isPed"]:isPed("myjob") == 'police' then
    print('here')
		TriggerEvent('raid_clothes:inService', false)
		TriggerServerEvent("TokoVoip:removePlayerFromAllRadio",GetPlayerServerId(PlayerId()))
		TriggerServerEvent("jobssystem:jobs", "unemployed")
    TriggerServerEvent("fa-signoff:duty", "police")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopDeathOff')
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		TriggerServerEvent("TokoVoip:clientHasSelecterCharecter")
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
  elseif exports["isPed"]:isPed("myjob") == 'ems' then
    TriggerServerEvent("TokoVoip:removePlayerFromAllRadio",GetPlayerServerId(PlayerId()))
    TriggerServerEvent("jobssystem:jobs", "unemployed")
    TriggerServerEvent("fa-signoff:duty", "ems")
    TriggerServerEvent('myskin_customization:wearSkin')
    TriggerServerEvent('tattoos:retrieve')
    TriggerServerEvent('Blemishes:retrieve')
    TriggerEvent("police:noLongerCop")
    TriggerEvent("logoffmedic")		
    TriggerEvent("loggedoff")					
    TriggerEvent('nowCopDeathOff')
    TriggerEvent('nowCopSpawnOff')
    TriggerEvent('nowMedicOff')
    TriggerServerEvent("TokoVoip:clientHasSelecterCharecter")
    SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
    SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
    SetPoliceIgnorePlayer(PlayerPedId(),false)
    TriggerEvent("DoLongHudText",'Signed off Duty!',1)
  end
end
