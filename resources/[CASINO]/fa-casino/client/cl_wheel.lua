local _wheel = nil
local _lambo = nil
local _isShowCar = false
local _wheelPos = vector3(989.9, 42.46, 71.27)
local _baseWheelPos = vector3(1111.0855712891, 229.8528137207, -49.737197875977)
local _isRolling = false
local model = GetHashKey('vw_prop_vw_luckywheel_02a')


AddEventHandler("fa-casino:wheel:spinWheelTurbo", function()
  if not hasMembership(false) then
    TriggerEvent("DoLongHudText", "You must have a membership", 2)
    return
  end
  local info = (exports["fa-inventory"]:GetInfoForFirstItemOfName("casinoloyalty") or { information = "{}" })
  RPC.execute("fa-casino:wheel:spinWheel", true, json.decode(info.information).state_id)
end)


Citizen.CreateThread(function()
    RequestModel(model)

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    _wheel = CreateObject(model, 1111.052, 229.851, -50.35, false, false, true)
    SetEntityHeading(_wheel,358.35986328125)
    SetModelAsNoLongerNeeded(model)
end)

-- Citizen.CreateThread(function() 
--     while true do
--         if _lambo ~= nil then
--             local _heading = GetEntityHeading(_lambo)
--             local _z = _heading - 0.3
--             SetEntityHeading(_lambo, _z)
--         end
--         Citizen.Wait(5)
--     end
-- end)


RegisterNetEvent("fa-luckywheel:doRoll")
AddEventHandler("fa-luckywheel:doRoll", function(_priceIndex) 
    _isRolling = true
	SetEntityHeading(_wheel, 358.35986328125)
    Citizen.CreateThread(function()
        local speedIntCnt = 0.2
        local rollspeed = 0.2
        local _winAngle = (_priceIndex - 1) * 18
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(_wheel, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                    
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 30
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
			      SetEntityHeading(_wheel, 358.35986328125)
            SetEntityRotation(_wheel, 0.0, _y, 358.35986328125, 2, true)
            Citizen.Wait(5)
        end
    end)
end)

RegisterNetEvent("fa-luckywheel:rollFinished")
AddEventHandler("fa-luckywheel:rollFinished", function() 
    _isRolling = false
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function doRoll()
    if not _isRolling then
        _isRolling = true
        local playerPed = PlayerPedId()
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'
            loadAnimDict(lib)
            local _movePos = vector3(990.34, 41.58, 71.27)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  -1,  312.2,  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(PlayerPedId())
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                    Citizen.Wait(0)
                    DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TriggerServerEvent("fa-luckywheel:getLucky")
            TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        
    end
end

RegisterNetEvent("fa-luckywheel:spinit")
AddEventHandler("fa-luckywheel:spinit", function() 
    if not _isRolling  then
        doRoll()
    end		
end)

RegisterNetEvent('attempt:spin-in', function()
    TriggerServerEvent("attempt:spin")
end)

RegisterNetEvent("attempt:change:spin", function()
    local pCasino = exports["isPed"]:GroupRank("casino")
	if pCasino >= 1 then
		TriggerServerEvent("spin:toggle")
	else
		TriggerEvent("DoLongHudText", "This is only for Casino Dealer to use.", 2)
	end
end)
