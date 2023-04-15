-- Police Duty --

local PDService = false
local SASPService = false
local BCSOService = false
local SAPRService = false
local DOCService = false
local DISPATCHERService = false

RegisterNetEvent('fa-police:DOCDuty')
AddEventHandler('fa-police:DOCDuty', function()

	local menuData = {
		{
            title = "DOC",
            description = "Sign On/Off Duty",
            key = "EVENTS.DOC",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:OnDutyDOC", key = "EVENTS.DOC" },
				{ title = "Sign Off Duty", action = "fa-duty:OffDutyDOC", key = "EVENTS.DOC" },
            },
        },
    }
    exports["fa-interface"]:showContextMenu(menuData)
end)

RegisterCommand('duty', function()
	TriggerEvent('fa-duty:PoliceMenu')
end)

RegisterNetEvent('fa-duty:PoliceMenu')
AddEventHandler('fa-duty:PoliceMenu', function()
	local menuData = {
		{
            title = "Police",
            description = "Sign On/Off Duty",
            key = "EVENTS.POLICE",
			children = {
				{
					title = "LSPD",
					key = "EVENTS.LSPD",
					children = {
						{
							title = "Sign On Duty",
							action = "fa-duty:OnDutyPD",
						},
						{
							title = "Sign Off Duty",
							action = "fa-duty:OffDutyPD",
						},
					}
				},
				{
					title = "SASP",
					key = "EVENTS.SASP",
					children = {
						{
							title = "Sign On Duty",
							action = "fa-duty:OnDutyHP",
						},
						{
							title = "Sign Off Duty",
							action = "fa-duty:OffDutyHP",
						},
					}
				},
				{
					title = "BCSO",
					key = "EVENTS.SASP",
					children = {
						{
							title = "Sign On Duty",
							action = "fa-duty:OnDutySH",
						},
						{
							title = "Sign Off Duty",
							action = "fa-duty:OffDutySH",
						},
					}
				},
				{
					title = "Rangers",
					key = "EVENTS.RANGERS",
					children = {
						{
							title = "Sign On Duty",
							action = "fa-duty:OnDutyRN",
						},
						{
							title = "Sign Off Duty",
							action = "fa-duty:OffDutyRN",
						},
					}
				},
            },
        },
		{
            title = "DOC",
            description = "Sign On/Off Duty",
            key = "EVENTS.DOC",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:OnDutyDOC", key = "EVENTS.DOC" },
				{ title = "Sign Off Duty", action = "fa-duty:OffDutyDOC", key = "EVENTS.DOC" },
            },
        },
		{
            title = "Dispatcher",
            description = "Sign On/Off Duty",
            key = "EVENTS.DISPATCHER",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:OnDutyDispatcher", key = "EVENTS.DISPATCHER" },
				{ title = "Sign Off Duty", action = "fa-duty:OffDutyDispatcher", key = "EVENTS.DISPATCHER" },
            },
        },
    }
    exports["fa-interface"]:showContextMenu(menuData)
end)

RegisterInterfaceCallback("fa-duty:OnDutyPD", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if PDService == false then
		TriggerServerEvent('fa-duty:AttemptDuty', 'police')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutyPD", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if PDService == true then
		PDService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyComplete', 'police')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

-- Sheriff

RegisterInterfaceCallback("fa-duty:OnDutySH", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if BCSOService == false then
		TriggerServerEvent('fa-duty:AttemptDuty', 'sheriff')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OnDutyRN", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if SAPRService == false then
		TriggerServerEvent('fa-duty:AttemptDuty', 'ranger')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutySH", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if BCSOService == true then
		BCSOService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyComplete', 'sheriff')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutyRN", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if SAPRService == true then
		SAPRService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyComplete', 'ranger')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)


-- State

RegisterInterfaceCallback("fa-duty:OnDutyHP", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if SASPService == false then
		TriggerServerEvent('fa-duty:AttemptDuty', 'state')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutyHP", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if SASPService == true then
		SASPService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyComplete', 'state')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

-- DOC

RegisterInterfaceCallback("fa-duty:OnDutyDOC", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if DOCService == false then
		TriggerServerEvent('fa-duty:AttemptDuty', 'doc')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OnDutyDispatcher", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if DISPATCHERService == false then
		DISPATCHERService = true
		TriggerEvent('DoLongHudText', 'Clocked in as Dispatcher.', 1)
		TriggerServerEvent('fa-duty:AttemptDuty', 'dispatcher')
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutyDOC", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if DOCService == true then
		DOCService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyComplete', 'doc')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

RegisterInterfaceCallback("fa-duty:OffDutyDispatcher", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = 'done' } })
	if DISPATCHERService == true then
		DISPATCHERService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

RegisterNetEvent('fa-duty:PDSuccess')
AddEventHandler('fa-duty:PDSuccess', function()
	if PDService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		PDService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:BCSOSuccess')
AddEventHandler('fa-duty:BCSOSuccess', function()
	if BCSOService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		BCSOService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:SAPRSuccess')
AddEventHandler('fa-duty:SAPRSuccess', function()
	if SAPRService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		SAPRService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:SASPSuccess')
AddEventHandler('fa-duty:SASPSuccess', function()
	if SASPService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		SASPService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:DOCSuccess')
AddEventHandler('fa-duty:DOCSuccess', function()
	if DOCService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(3)
		TriggerEvent('radio:SetRadioStatus', true)
		DOCService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- EMS Duty --

local EMSService = false

RegisterNetEvent('fa-duty:EMSMenu')
AddEventHandler('fa-duty:EMSMenu', function()

	local EMSData = {
		{
            title = "EMS",
            description = "Sign On/Off Duty",
            key = "EVENTS.EMS",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:ems_41", key = "EVENTS.EMS" },
				{ title = "Sign Off Duty", action = "fa-duty:ems_42", key = "EVENTS.EMS" },
            },
        },
    }
    exports["fa-interface"]:showContextMenu(EMSData)
end)

RegisterInterfaceCallback('fa-duty:ems_42', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:OffDutyEMS')
end)

RegisterInterfaceCallback('fa-duty:ems_41', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:OnDutyEMS')
end)

RegisterNetEvent('fa-duty:OnDutyEMS')
AddEventHandler('fa-duty:OnDutyEMS', function()
	if EMSService == false then
		TriggerServerEvent('fa-duty:AttemptDutyEMS')
		TriggerEvent('fa-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:OffDutyEMS')
AddEventHandler('fa-duty:OffDutyEMS', function()
	if EMSService == true then
		EMSService = false
		TriggerEvent('fa-clothing:inService', false)
		exports['fa-voice']:removePlayerFromRadio()
		exports["fa-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('fa-duty:OffDutyCompleteEMS')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('fa-duty:EMSSuccess')
AddEventHandler('fa-duty:EMSSuccess', function()
	if EMSService == false then
		exports["fa-voice"]:setVoiceProperty("radioEnabled", true)
		exports['fa-voice']:addPlayerToRadio(2)
		TriggerEvent('radio:SetRadioStatus', true)
		EMSService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)


-- Judge Duty ------------------------------------------------------------

local JudgeService = false

RegisterNetEvent('fa-duty:OnDutyJudge')
AddEventHandler('fa-duty:OnDutyJudge', function()
	if JudgeService == false then
		TriggerServerEvent('fa-duty:AttemptDutyJudge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:OffDutyJudge')
AddEventHandler('fa-duty:OffDutyJudge', function()
	if JudgeService == true then
		JudgeService = false
		TriggerServerEvent('fa-duty:OffDutyCompleteEMS')
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('fa-duty:JudgeSuccess')
AddEventHandler('fa-duty:JudgeSuccess', function()
	if JudgeService == false then
		JudgeService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- DA Duty --

local DAService = false

RegisterNetEvent('fa-duty:OnDutyDA')
AddEventHandler('fa-duty:OnDutyDA', function()
	if DAService == false then
		TriggerServerEvent('fa-duty:AttemptDutyDA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:OffDutyDA')
AddEventHandler('fa-duty:OffDutyDA', function()
	if DAService == true then
		DAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('fa-duty:DASuccess')
AddEventHandler('fa-duty:DASuccess', function()
	if DAService == false then
		DAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Public Duty --

local PublicService = false

RegisterNetEvent('fa-duty:OnDutyPublic')
AddEventHandler('fa-duty:OnDutyPublic', function()
	if PublicService == false then
		TriggerServerEvent('fa-duty:AttemptDutyPublic')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:OffDutyPublic')
AddEventHandler('fa-duty:OffDutyPublic', function()
	if PublicService == true then
		PublicService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('fa-duty:PublicSuccess')
AddEventHandler('fa-duty:PublicSuccess', function()
	if PublicService == false then
		PublicService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)


curPolice = 0

RegisterNetEvent('job:policecount')
AddEventHandler('job:policecount', function(pAmount)
	curPolice = pAmount
end)

function LawAmount()
	return curPolice
end

-- DOJ Duty --

local ClockedInAsJudge = false

local ClockedInAsPublicDefender = false

local ClockedInAsDistrictAttorney = false

RegisterNetEvent('fa-duty:doj_board')
AddEventHandler('fa-duty:doj_board', function()

	local JudgeData = {
		{
            title = "Judge Duty",
            description = "Sign On/Off Duty",
            key = "EVENTS.JUDGE",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:judge_on", key = "EVENTS.JUDGE" },
				{ title = "Sign Off Duty", action = "fa-duty:judge_off", key = "EVENTS.JUDGE" },
            },
        },
		{
            title = "Public Defender Duty",
            description = "Sign On/Off Duty",
            key = "EVENTS.DEFENDER",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:defender_on", key = "EVENTS.DEFENDER" },
				{ title = "Sign Off Duty", action = "fa-duty:defender_off", key = "EVENTS.DEFENDER" },
            },
        },
		{
            title = "District Attorney Duty",
            description = "Sign On/Off Duty",
            key = "EVENTS.ATTORNEY",
			children = {
				{ title = "Sign On Duty", action = "fa-duty:attorney_on", key = "EVENTS.ATTORNEY" },
				{ title = "Sign Off Duty", action = "fa-duty:attorney_off", key = "EVENTS.ATTORNEY" },
            },
        },
    }
    exports["fa-interface"]:showContextMenu(JudgeData)
end)

RegisterInterfaceCallback('fa-duty:attorney_on', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_in:district_attorney')
end)

RegisterInterfaceCallback('fa-duty:attorney_off', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_out:district_attorney')
end)

RegisterInterfaceCallback('fa-duty:defender_on', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_in:public_defender')
end)

RegisterInterfaceCallback('fa-duty:defender_off', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_out:public_defender')
end)

RegisterInterfaceCallback('fa-duty:judge_on', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_in:judge')
end)

RegisterInterfaceCallback('fa-duty:judge_off', function(data, cb)
	cb({ data = {}, meta = { ok = true, message = '' } })
	TriggerEvent('fa-duty:clock_out:judge')
end)


-- Judge --

RegisterNetEvent('fa-duty:clock_in:judge')
AddEventHandler('fa-duty:clock_in:judge', function()
	if ClockedInAsJudge == false then
		TriggerServerEvent('fa-duty:attempt_duty:judge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:clock_out:judge')
AddEventHandler('fa-duty:clock_out:judge', function()
	if ClockedInAsJudge == true then
		ClockedInAsJudge = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a Judge', 2)
		TriggerServerEvent('fa-duty:offDutyJudge')
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a Judge', 2)
	end
end)

RegisterNetEvent('fa-duty:clocked_in:judge_successful')
AddEventHandler('fa-duty:clocked_in:judge_successful', function()
	if ClockedInAsJudge == false then
		ClockedInAsJudge = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a Judge', 2)
	end
end)

-- Public Defender --

RegisterNetEvent('fa-duty:clock_in:public_defender')
AddEventHandler('fa-duty:clock_in:public_defender', function()
	if ClockedInAsPublicDefender == false then
		TriggerServerEvent('fa-duty:attempt_duty:public_defender')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:clock_out:public_defender')
AddEventHandler('fa-duty:clock_out:public_defender', function()
	if ClockedInAsPublicDefender == true then
		ClockedInAsPublicDefender = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a Public Defender', 2)
		TriggerServerEvent('fa-duty:offDutyDefender')
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a Public Defender', 2)
	end
end)

RegisterNetEvent('fa-duty:clocked_in:public_defender_successful')
AddEventHandler('fa-duty:clocked_in:public_defender_successful', function()
	if ClockedInAsPublicDefender == false then
		ClockedInAsPublicDefender = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a Public Defender', 2)
	end
end)

-- District Attorney --

RegisterNetEvent('fa-duty:clock_in:district_attorney')
AddEventHandler('fa-duty:clock_in:district_attorney', function()
	if ClockedInAsDistrictAttorney == false then
		TriggerServerEvent('fa-duty:attempt_duty:district_attorney')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('fa-duty:clock_out:district_attorney')
AddEventHandler('fa-duty:clock_out:district_attorney', function()
	if ClockedInAsDistrictAttorney == true then
		ClockedInAsDistrictAttorney = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a District Attorney', 2)
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a District Attorney', 2)
	end
end)

RegisterNetEvent('fa-duty:clocked_in:district_attorney_successful')
AddEventHandler('fa-duty:clocked_in:district_attorney_successful', function()
	if ClockedInAsDistrictAttorney == false then
		ClockedInAsDistrictAttorney = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a District Attorney', 2)
	end
end)