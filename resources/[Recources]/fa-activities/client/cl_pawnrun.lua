--------------------
------ LOCALS ------
--------------------

local tasking = false
local rnd = 0
local blip = 0
local deliveryPed = 0
local gangTaskArea = "local"
local mygang = "local"
local watching = "local"
local watchinglist = {}
local drugStorePed = 0
local rolexVehicle = 0
local firstdeal = false
local lunchtime2 = false

local RolexDropOffs123 = {
	[1] =  { ['x'] = 483.17,['y'] = -1827.35,['z'] = 27.86,['h'] = 135.87, ['info'] = ' East Side 1' },
	[2] =  { ['x'] = 475.87,['y'] = -1798.45,['z'] = 28.49,['h'] = 229.85, ['info'] = ' East Side 2' },
	[3] =  { ['x'] = 503.54,['y'] = -1765.06,['z'] = 28.51,['h'] = 67.61, ['info'] = ' East Side 3' },
	[4] =  { ['x'] = 512.0,['y'] = -1842.13,['z'] = 27.9,['h'] = 138.1, ['info'] = ' East Side 4' },
	[5] =  { ['x'] = 466.89,['y'] = -1852.81,['z'] = 27.72,['h'] = 310.97, ['info'] = ' East Side 5' },
	[6] =  { ['x'] = 431.33,['y'] = -1882.85,['z'] = 26.85,['h'] = 39.7, ['info'] = ' East Side 6' },
	[7] =  { ['x'] = 410.64,['y'] = -1908.57,['z'] = 25.46,['h'] = 80.03, ['info'] = ' East Side 7' },
	[8] =  { ['x'] = 192.93,['y'] = -2027.95,['z'] = 18.29,['h'] = 251.25, ['info'] = ' East Side 8' },
	[9] =  { ['x'] = 184.05,['y'] = -2004.77,['z'] = 18.31,['h'] = 49.81, ['info'] = ' East Side 9' },
	[10] =  { ['x'] = 212.4,['y'] = -1971.66,['z'] = 20.31,['h'] = 63.83, ['info'] = ' East Side 10' },
	[11] =  { ['x'] = 266.85,['y'] = -1964.41,['z'] = 23.0,['h'] = 49.59, ['info'] = ' East Side 11' },
	[12] =  { ['x'] = 313.05,['y'] = -1918.57,['z'] = 25.65,['h'] = 315.88, ['info'] = ' East Side 12' },
	[13] =  { ['x'] = 282.63,['y'] = -1948.96,['z'] = 24.39,['h'] = 40.21, ['info'] = ' East Side 13' },
	[14] =  { ['x'] = 250.44,['y'] = -1995.9,['z'] = 20.32,['h'] = 324.5, ['info'] = ' East Side 14' },
	[15] =  { ['x'] = 270.54,['y'] = -1706.13,['z'] = 29.31,['h'] = 46.82, ['info'] = ' Central 1' },
	[16] =  { ['x'] = 167.78,['y'] = -1635.0,['z'] = 29.3,['h'] = 22.04, ['info'] = ' Central 2' },
	[17] =  { ['x'] = 175.98,['y'] = -1542.48,['z'] = 29.27,['h'] = 316.21, ['info'] = ' Central 3' },
	[18] =  { ['x'] = -99.69,['y'] = -1577.74,['z'] = 31.73,['h'] = 231.66, ['info'] = ' Central 4' },
	[19] =  { ['x'] = -171.68,['y'] = -1659.11,['z'] = 33.47,['h'] = 85.41, ['info'] = ' Central 5' },
	[20] =  { ['x'] = -209.75,['y'] = -1632.29,['z'] = 33.9,['h'] = 177.99, ['info'] = ' Central 6' },
	[21] =  { ['x'] = -262.65,['y'] = -1580.04,['z'] = 31.86,['h'] = 251.02, ['info'] = ' Central 7' },
	[22] =  { ['x'] = -182.0,['y'] = -1433.79,['z'] = 31.31,['h'] = 210.92, ['info'] = ' Central 8' },
	[23] =  { ['x'] = -83.37,['y'] = -1415.39,['z'] = 29.33,['h'] = 180.98, ['info'] = ' Central 9' },
	[24] =  { ['x'] = -39.13,['y'] = -1473.67,['z'] = 31.65,['h'] = 5.17, ['info'] = ' Central 10' },
	[25] =  { ['x'] = 45.16,['y'] = -1475.65,['z'] = 29.36,['h'] = 136.92, ['info'] = ' Central 11' },
	[26] =  { ['x'] = 158.52,['y'] = -1496.02,['z'] = 29.27,['h'] = 133.49, ['info'] = ' Central 12' },
	[27] =  { ['x'] = 43.58,['y'] = -1599.87,['z'] = 29.61,['h'] = 50.3, ['info'] = ' Central 13' },
	[28] =  { ['x'] = 7.97,['y'] = -1662.14,['z'] = 29.33,['h'] = 318.63, ['info'] = ' Central 14' },
	[29] =  { ['x'] = -726.92,['y'] = -854.64,['z'] = 22.8,['h'] = 2.0, ['info'] = ' West 1' },
	[30] =  { ['x'] = -713.09,['y'] = -886.66,['z'] = 23.81,['h'] = 357.65, ['info'] = ' West 2' },
	[31] =  { ['x'] = -591.45,['y'] = -891.2,['z'] = 25.95,['h'] = 91.53, ['info'] = ' West 3' },
	[32] =  { ['x'] = -683.59,['y'] = -945.62,['z'] = 20.85,['h'] = 180.74, ['info'] = ' West 4' },
	[33] =  { ['x'] = -765.92,['y'] = -920.94,['z'] = 18.94,['h'] = 180.44, ['info'] = ' West 5' },
	[34] =  { ['x'] = -807.45,['y'] = -957.09,['z'] = 15.29,['h'] = 340.4, ['info'] = ' West 6' },
	[35] =  { ['x'] = -822.88,['y'] = -973.96,['z'] = 14.72,['h'] = 126.28, ['info'] = ' West 7' },
	[36] =  { ['x'] = -657.53,['y'] = -729.91,['z'] = 27.84,['h'] = 309.58, ['info'] = ' West 8' },
	[37] =  { ['x'] = -618.39,['y'] = -750.71,['z'] = 26.66,['h'] = 85.6, ['info'] = ' West 9' },
	[38] =  { ['x'] = -548.36,['y'] = -854.53,['z'] = 28.82,['h'] = 352.84, ['info'] = ' West 10' },
	[39] =  { ['x'] = -518.18,['y'] = -804.65,['z'] = 30.8,['h'] = 267.32, ['info'] = ' West 11' },
	[40] =  { ['x'] = -509.05,['y'] = -737.77,['z'] = 32.6,['h'] = 174.97, ['info'] = ' West 12' },
	[41] =  { ['x'] = -567.5,['y'] = -717.77,['z'] = 33.43,['h'] = 268.02, ['info'] = ' West 13' },
	[42] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
}

local RolexDropOffs = {
	[1] =  { ['x'] = 74.5,['y'] = -762.17,['z'] = 31.68,['h'] = 160.98, ['info'] = ' 1' },
	[2] =  { ['x'] = 100.58,['y'] = -644.11,['z'] = 44.23,['h'] = 69.11, ['info'] = ' 2' },
	[3] =  { ['x'] = 175.45,['y'] = -445.95,['z'] = 41.1,['h'] = 92.72, ['info'] = ' 3' },
	[4] =  { ['x'] = 130.3,['y'] = -246.26,['z'] = 51.45,['h'] = 219.63, ['info'] = ' 4' },
	[5] =  { ['x'] = 198.1,['y'] = -162.11,['z'] = 56.35,['h'] = 340.09, ['info'] = ' 5' },
	[6] =  { ['x'] = 341.0,['y'] = -184.71,['z'] = 58.07,['h'] = 159.33, ['info'] = ' 6' },
	[7] =  { ['x'] = -26.96,['y'] = -368.45,['z'] = 39.69,['h'] = 251.12, ['info'] = ' 7' },
	[8] =  { ['x'] = -155.88,['y'] = -751.76,['z'] = 33.76,['h'] = 251.82, ['info'] = ' 8' },
	[9] =  { ['x'] = -305.02,['y'] = -226.17,['z'] = 36.29,['h'] = 306.04, ['info'] = ' penis1' },
	[10] =  { ['x'] = -347.19,['y'] = -791.04,['z'] = 33.97,['h'] = 3.06, ['info'] = ' penis2' },
	[11] =  { ['x'] = -703.75,['y'] = -932.93,['z'] = 19.22,['h'] = 87.86, ['info'] = ' penis3' },
	[12] =  { ['x'] = -659.35,['y'] = -256.83,['z'] = 36.23,['h'] = 118.92, ['info'] = ' penis4' },
	[13] =  { ['x'] = -934.18,['y'] = -124.28,['z'] = 37.77,['h'] = 205.79, ['info'] = ' penis5' },
	[14] =  { ['x'] = -1214.3,['y'] = -317.57,['z'] = 37.75,['h'] = 18.39, ['info'] = ' penis6' },
	[15] =  { ['x'] = -822.83,['y'] = -636.97,['z'] = 27.9,['h'] = 160.23, ['info'] = ' penis7' },
	[16] =  { ['x'] = 308.04,['y'] = -1386.09,['z'] = 31.79,['h'] = 47.23, ['info'] = ' penis8' },
}

-----------------------
------ NETEVENTS ------
-----------------------

RegisterNetEvent('lunchtime2')
AddEventHandler('lunchtime2', function(pass)
	lunchtime2 = pass
end)

RegisterNetEvent("rolexdelivery:client")
AddEventHandler("rolexdelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#RolexDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"])) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated then
			pedCreated = true
			DeleteCreatedPed()
			CreateRolexPed()
			TriggerEvent("DoLongHudText","You are close to the drop off.")
		end
		toolong = toolong - 1
		if toolong < 0 then
			tasking = false
			RolexRun = false
			TriggerEvent("DoLongHudText","You are no longer selling Rolex due to taking too long to drop off.")
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E] - Make Exchange")  

			if IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				local finished = exports["fa-taskbar"]:taskBar(2000,"Making An Exchange")
				if finished == 100 then 
					DoDropOff()
					tasking = false
				end
			end
		end
	end
	
	DeleteCreatedPed()
	DeleteBlip()

end)

RegisterNetEvent("rolexdelivery:startDealing")
AddEventHandler("rolexdelivery:startDealing", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	TriggerEvent("chatMessage", "EMAIL - Pawn Runs", 8, "Find a car get to the drop offs, preferably not your personal car ! Keep the police away.")
	salecount = 0	
	firstdeal = true
	RolexRun = true
end)

-----------------------
------ FUNCTIONS ------
-----------------------

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)
    EndFindObject(handle)
end

RolexSpot = false

Citizen.CreateThread(function()
	exports["fa-polyzone"]:AddBoxZone("rolex_run_start", vector3(182.79, -1319.47, 29.32), 2, 2, {
		name="rolex_run_start",
		heading=335,
		minZ=27.72,
		maxZ=31.72
	  })
	  
end)

RegisterNetEvent('fa-polyzone:enter')
AddEventHandler('fa-polyzone:enter', function(name)
    if name == "rolex_run_start" then
        RolexSpot = true     
        RolexLocation()
		if not RolexRun then
			exports["fa-interface"]:showInteraction("[E] Start Run ($500)")
		else 
			exports["fa-interface"]:showInteraction("Finish Your Run")
		end
    end
end)

RegisterNetEvent('fa-polyzone:exit')
AddEventHandler('fa-polyzone:exit', function(name)
    if name == "rolex_run_start" then
        RolexSpot = false  
		exports["fa-interface"]:hideInteraction()
    end
end)

function RolexLocation()
	Citizen.CreateThread(function()
        while RolexSpot do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				if exports['fa-inventory']:hasEnoughOfItem('rolexwatch', 1) or exports['fa-inventory']:hasEnoughOfItem('stolenpsp', 1) or exports['fa-inventory']:hasEnoughOfItem('stolens8', 1) or exports['fa-inventory']:hasEnoughOfItem('stolenBrokenGoods', 1) or exports['fa-inventory']:hasEnoughOfItem('stolen2ctchain', 1) or exports['fa-inventory']:hasEnoughOfItem('stolenraybans', 1) or exports['fa-inventory']:hasEnoughOfItem('stolencasiowatch', 1) then
					if not RolexRun then
						TriggerServerEvent("rolexdelivery:server", 500)
					end
				else
					TriggerEvent('DoLongHudText', 'We need something to buy ?!?!', 2)
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
    while true do
        if drugdealer then
	        Citizen.Wait(1000)
	        if firstdeal then
	        	Citizen.Wait(10000)
	        end
	        TriggerEvent("drugdelivery:client")  
		    salecount = salecount + 1
		    if salecount == 7 then
		    	Citizen.Wait(1200000)
		    	drugdealer = false
		    end
		    Citizen.Wait(150000)
		    firstdeal = false
		elseif RolexRun then
			if (not DoesEntityExist(rolexVehicle) or GetVehicleEngineHealth(rolexVehicle) < 100.0) and vehspawn then
				RolexRun = false
				tasking = false
				TriggerEvent("chatMessage", "EMAIL - Drug Deliveries", 8, "Dude! You fucked the car up, I canceled your run, asshole! ")
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("rolexdelivery:client")  
				    salecount = salecount + 1
				    if salecount == 7 then
				    	RolexRun = false
				    end
				end
			end
	    else
			Citizen.Wait(2000)
	    end
    end
end)

function CreateRolexPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"], RolexDropOffs[rnd]["h"], 0, 0)
	
	DecorSetBool(deliveryPed, 'ScriptedPed', true)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)

end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		DecorSetBool(deliveryPed, 'ScriptedPed', false)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if RolexRun then
		blip = AddBlipForCoord(RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"])
	else
		blip = AddBlipForCoord(RolexDrops[rnd]["x"],RolexDrops[rnd]["y"],RolexDrops[rnd]["z"])
	end
    
    SetBlipSprite(blip, 500)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function searchPockets()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( deliveryPed, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff(requestMoney)
	local success = true

	searchPockets()

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

			if math.random(10) == 1 then
				TriggerEvent( "player:receiveItem", "Gruppe6Card", 1 )
			end

			if RolexRun then
		        if exports["fa-inventory"]:hasEnoughOfItem("rolexwatch",1) then     
                TriggerEvent("inventory:removeItem","rolexwatch", 1) 
                if exports['fa-hud']:MoneyBuff() then
                    TriggerServerEvent('fa-activities:pawnPayout', math.random(200, 275), '[Pawn Run | With Buff] | Rolex')
                else
                    TriggerServerEvent('fa-activities:pawnPayout', math.random(150, 175), '[Pawn Run | Without Buff] | Rolex')
                end

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolenpsp",1) then     
					TriggerEvent("inventory:removeItem","stolenpsp", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(350, 400), '[Pawn Run | With Buff] | Stolen PSP')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(250, 300), '[Pawn Run | Without Buff] | Stolen PSP')
                    end           

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolens8",1) then     
					TriggerEvent("inventory:removeItem","stolens8", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(250, 275), '[Pawn Run | With Buff] | Stolen S8')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(175, 225), '[Pawn Run | Without Buff] | Stolen S8')
                    end           

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolenBrokenGoods",1) then     
					TriggerEvent("inventory:removeItem","stolenBrokenGoods", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(350, 425), '[Pawn Run | With Buff] | Broken Goods')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(250, 325), '[Pawn Run | Without Buff] | Broken Goods')
                    end                 

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolen2ctchain",1) then     
					TriggerEvent("inventory:removeItem","stolen2ctchain", 1)   
					TriggerServerEvent('stolen2ctchain:cash:payment')     
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(200, 275), '[Pawn Run | With Buff] | Stolen 2CT Chain')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(150, 175), '[Pawn Run | Without Buff] | Stolen 2CT Chain')
                    end                   

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolenraybans",1) then     
					TriggerEvent("inventory:removeItem","stolenraybans", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(125, 200), '[Pawn Run | With Buff] | Stolen Raybans')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(50, 100), '[Pawn Run | Without Buff] | Stolen Raybans')
                    end

				elseif exports["fa-inventory"]:hasEnoughOfItem("stolencasiowatch",1) then     
					TriggerEvent("inventory:removeItem","stolencasiowatch", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(150, 250), '[Pawn Run | With Buff] | Stolen Casio')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(100, 125), '[Pawn Run | Without Buff] | Stolen Casio')
                    end   
                    
                elseif exports["fa-inventory"]:hasEnoughOfItem("goldbar",1) then     
					TriggerEvent("inventory:removeItem","goldbar", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(3000, 5000), '[Pawn Run | With Buff] | Gold Bar')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(1500, 2500), '[Pawn Run | Without Buff] | Gold Bar')
                    end   

                elseif exports["fa-inventory"]:hasEnoughOfItem("valuablegoods",1) then     
					TriggerEvent("inventory:removeItem","valuablegoods", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(1500, 2500), '[Pawn Run | With Buff] | Valuable Goods')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(750, 1000), '[Pawn Run | Without Buff] | Valuable Goods')
                    end   

                elseif exports["fa-inventory"]:hasEnoughOfItem("goldcoin",1) then     
					TriggerEvent("inventory:removeItem","goldcoin", 1)   
                    if exports['fa-hud']:MoneyBuff() then
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(1500, 2500), '[Pawn Run | With Buff] | Gold Coin')
                    else
                        TriggerServerEvent('fa-activities:pawnPayout', math.random(750, 1000), '[Pawn Run | Without Buff] | Gold Coin')
                    end   
					
			else
				TriggerEvent("DoLongHudText","You aint got anything to sell !", 2)
			end
		end
	end

	local counter = math.random(90, 115)
	while counter > 0 do
		local crds = GetEntityCoords(deliveryPed)
		counter = counter - 1
		Citizen.Wait(1)
	end

	if success then
		searchPockets()
		local counter = math.random(90, 115)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
		giveAnim()
	end

	local crds = GetEntityCoords(deliveryPed)
	local crds2 = GetEntityCoords(PlayerPedId())

	if #(crds - crds2) > 5.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
		success = false
	end


	if success then
		PlayAmbientSpeech1(deliveryPed, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
		TriggerEvent("denoms",true)
		TriggerEvent("client:newStress",true,25)
	else
		TriggerEvent("DoLongHudText","The drop off failed.",2)
	end
	
	DeleteBlip()
	if success then
		TriggerEvent("DoLongHudText", "I got the call in, delivery was on point, go await the next one! ", 1)
	else
		TriggerEvent("DoLongHudText","Drop off failed I expect better.",2)
	end

	DeleteCreatedPed()
end

function DropItemPed(ai)
    local ai = ai
    local chance = math.random(50)
    if chance > 41 then
        DropDrugs(ai,true)
    elseif chance > 35 then
        DropDrugs(ai,false)
    end
end

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