
function SetVehiclePlate(vehicle, plate)
	if not DoesEntityExist(vehicle) then return end
	if not plate or type(plate) ~= "string" then return end

	SetVehicleNumberPlateText(vehicle, plate)
end

function GetVehiclePlate(vehicle)
	if not DoesEntityExist(vehicle) then
		return ""
	end

	local plate = GetVehicleNumberPlateText(vehicle)

	return string.gsub(plate, "%s+", "")
end

function GetVehicleTier(vehicle)
	if not DoesEntityExist(vehicle) then
		return
	end

	local function getField(field)
		return GetVehicleHandlingFloat(vehicle, "CHandlingData", field)
	end

	local model = GetEntityModel(vehicle)
	local isMotorCycle = IsThisModelABike(model)

	local fInitialDriveMaxFlatVel = getField("fInitialDriveMaxFlatVel")
	local fInitialDriveForce = getField("fInitialDriveForce")
	local fDriveBiasFront = getField("fDriveBiasFront")
	local fInitialDragCoeff = getField("fInitialDragCoeff")
	local fTractionCurveMax = getField("fTractionCurveMax")
	local fTractionCurveMin = getField("fTractionCurveMin")
	local fSuspensionReboundDamp = getField("fSuspensionReboundDamp")
	local fBrakeForce = getField("fBrakeForce")

	-- Acceleration: (fInitialDriveMaxFlatVel x fInitialDriveForce)/10
	-- If the fDriveBiasFront is greater than 0 but less than 1, multiply fInitialDriveForce by 1.1.
	local force = fInitialDriveForce
	if fInitialDriveForce > 0 and fInitialDriveForce < 1 then
		force = force * 1.1
	end

	local accel = (fInitialDriveMaxFlatVel * force) / 10

	-- Speed:
	-- ((fInitialDriveMaxFlatVel / fInitialDragCoeff) x (fTractionCurveMax + fTractionCurveMin))/40
	local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
	if isMotorCycle then
	  	speed = speed * 2
	end

	-- Handling:
	-- (fTractionCurveMax + fSuspensionReboundDamp) x fTractionCurveMin
	local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
	if isMotorCycle then
	  	handling = handling / 2
	end

	-- Braking:
	-- ((fTractionCurveMin / fInitialDragCoeff) x fBrakeForce) x 7
	local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7

	-- Overall Performance Bracket:
	-- ((Acceleration x 5) + Speed + Handling + Braking) * 15
	-- X Class: > 1000
	-- S Class: > 650
	-- A Class: > 500
	-- B Class: > 400
	-- C Class: > 325
	-- D Class: =< 325
	local perfRating = ((accel * 5) + speed + handling + braking) * 15
	local vehClass = "F"
	if isMotorCycle then
		vehClass = "M"
	elseif perfRating > 900 then
	  	vehClass = "X"
	elseif perfRating > 700 then
	  	vehClass = "S"
	elseif perfRating > 550 then
	  	vehClass = "A"
	elseif perfRating > 400 then
	  	vehClass = "B"
	elseif perfRating > 325 then
	  	vehClass = "C"
	else
	  	vehClass = "D"
	end

	return vehClass
end

function GetVehicleAfterMarket(vehicle, type)
	if type == 'engineSound' then
		local data = RPC.execute("fa-vehicleSync:GetVehicleAfterMarket", vehicle, type)
		return data
	else
		local vehInfo = RPC.execute("fa-vehicleSync:GetVehicleAfterMarket", vehicle)
		return vehInfo
	end
end

function GetPlayers()
  local players = {}

  for i = 0, 255 do
      if NetworkIsPlayerActive(i) then
          players[#players+1]= i
      end
  end

  return players
end

function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
      local target = GetPlayerPed(value)
      if(target ~= ply) then
          local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
          local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
          if(closestDistance == -1 or closestDistance > distance) then
              closestPlayer = value
              closestDistance = distance
          end
      end
  end
  
  return closestPlayer, closestDistance
end

RegisterCommand("transfer", function(source, args)
    TriggerEvent("transfer:attempt")
end)

RegisterNetEvent("transfer:attempt")
AddEventHandler("transfer:attempt", function()
    local coords = GetEntityCoords(PlayerPedId())
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            t, distance = GetClosestPlayer()
	        if(distance ~= -1 and distance < 2) then
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("transfer:attempt:send", plate, GetPlayerServerId(t))
            else
                TriggerEvent("DoLongHudText", "You are not near anyone to transfer the vehicle too", 2)
            end
        end
    end
end)

exports('GetClosestPlayer', GetClosestPlayer)