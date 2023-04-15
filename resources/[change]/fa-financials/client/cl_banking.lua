local open = false
local banktype = "atm"

local atms = {
  [1] = -1126237515,
  [2] = 506770882,
  [3] = -870868698,
  [4] = 150237004,
  [5] = -239124254,
  [6] = -1364697528,  
}

local banks = {
  {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},

  {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
  {name="Bank", id=108, x=1176.0833740234, y=2706.3386230469, z=38.157722473145},
  {name="Bank", id=108, x=-112.09, y=6470.12, z=31.63},
  --mall
  {name="Bank", id=108, x=-562.866, y=-585.4028, z=41.430236},

}

local displayBankBlips = true -- Toggles Bank Blips on the map (Default: true)


--Display Map Blips
Citizen.CreateThread(function()
  if (displayBankBlips == true) then
    for _, item in pairs(banks) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipScale(item.blip, 1.0)
      SetBlipColour(item.blip, 0)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end
end)

RegisterNetEvent('bank:openbank')
AddEventHandler('bank:openbank', function()
  local accounts, cash, name = RPC.execute("GetAccounts")
  local transactions = RPC.execute("GetTransactionLogs", "personal")
  open = not open
  bankanimation()
  local finished = exports["fa-taskbar"]:taskBar(1500,"Opening Banking")
  if (finished == 100) then 
  SetNuiFocus(open, open)
  SendReactMessage('setVisible', open)
  banktype = "bank"
  SendReactMessage('bankData', {
    type = "bank",
    accounts = accounts,
    cash = cash,
    name = name
  })
  local trans = nil
  if type(transactions) == "table" then
    trans = transactions
  end
  SendReactMessage('transactionData', {
    transactions = trans
  })
end
end)

RegisterNetEvent('bank:openatm')
AddEventHandler('bank:openatm', function()
  local accounts, cash, name = RPC.execute("GetAccounts")
  local transactions = RPC.execute("GetTransactionLogs", "personal")
  open = not open
  bankanimation()
  local finished = exports["fa-taskbar"]:taskBar(1500,"Opening Banking")
  if (finished == 100) then 
  SetNuiFocus(open, open)
  SendReactMessage('setVisible', open)
  banktype = "atm"
  SendReactMessage('bankData', {
    type = "atm",
    accounts = accounts,
    cash = cash,
    name = name
  })
  local trans = nil
  if type(transactions) == "table" then
    trans = transactions
  end
  SendReactMessage('transactionData', {
    transactions = trans
  })
end
end)

RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(reciever, amount)
	t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 7.5) then
    if tonumber(reciever) == GetPlayerServerId(t) then
      TriggerServerEvent("bank:givemecash", reciever, amount)
      TriggerEvent("animation:PlayAnimation","id")
    else
      TriggerEvent("DoLongHudText", "This player is not online", 2)
    end
  else
    TriggerEvent("DoLongHudText", "You are not near this player", 2)
  end
end)

RegisterNUICallback('hideFrame', function(_, cb)
  open = not open
  SetNuiFocus(open, open)
  SendReactMessage('setVisible', open)
end)

RegisterNUICallback('getTransactions', function(data, cb)
  --print("getTransactions", data.id)
  local transactions = RPC.execute("GetTransactionLogs", data.id)
  SendReactMessage('transactionData', {
    transactions = transactions
  })
end)

local years, months, days, hours, minutes, seconds
local date = 31

function time()
    years, months, days, hours, minutes, seconds =
    Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(), Citizen.PointerValueInt())

    if months < 10 then months = "0" .. months end

    if days < 10 then days = "0" .. days end

    if minutes < 10 then minutes = "0" .. minutes - 1 end

    if seconds < 10 then seconds = "0" .. seconds end

    if hours < 10 then hours = "0" .. hours end

    date = years .. "-" .. months .. "-" .. days .. "T" .. hours .. ":" ..minutes .. ":" .. seconds
end

RegisterNUICallback('bankWithdraw', function(data, cb)
  --print("bankWithdraw", data.id, data.amount, data.comment, data.transid)

  time()

  local success, message = RPC.execute("BankWithdraw", data.id, data.amount, data.comment, data.transid, date)
  if success then
    --print("success")
    TriggerServerEvent('fa-financials:withdraw_log', data.amount, data.comment)
    local accounts, cash, name = RPC.execute("GetAccounts")
    local transactions = RPC.execute("GetTransactionLogs", data.id)
    SendReactMessage('bankData', {
      type = banktype,
      accounts = accounts,
      cash = cash,
      name = name
    })
    SendReactMessage('transactionData', {
      transactions = transactions
    })
    cb(true)
  else
    cb(false)
    --print("error")
  end
end)

RegisterNUICallback('bankDeposit', function(data, cb)
  --print("bankDeposit", data.id, data.amount, data.comment, data.transid)

  time()

  local success, message = RPC.execute("BankDeposit", data.id, data.amount, data.comment, data.transid, date)
  if success then
    --print("success")
    TriggerServerEvent('fa-financials:deposit_log', data.amount, data.comment)
    local accounts, cash, name = RPC.execute("GetAccounts")
    local transactions = RPC.execute("GetTransactionLogs", data.id)
    SendReactMessage('bankData', {
      type = banktype,
      accounts = accounts,
      cash = cash,
      name = name
    })
    SendReactMessage('transactionData', {
      transactions = transactions
    })
    cb(true)
  else
    cb(false)
    --print("error")
  end
end)

RegisterNUICallback('bankTransfer', function(data, cb)
  time()

  local success, message = RPC.execute("DoTransaction", data.id, data.amount, data.comment, data.transid, date, data.target)
  if success then
    local accounts, cash, name = RPC.execute("GetAccounts")
    local transactions = RPC.execute("GetTransactionLogs", data.id)
    SendReactMessage('bankData', {
      type = banktype,
      accounts = accounts,
      cash = cash,
      name = name
    })
    SendReactMessage('transactionData', {
      transactions = transactions
    })
    cb(true)
  else
    cb(false)
  end
end)

-- ANIMATION PUSSYO
atmuse = false
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
function bankanimation()
    local player = GetPlayerPed( -1 )
    if IsNearATM() then
      if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "amb@prop_human_atm@male@enter" )
            loadAnimDict( "amb@prop_human_atm@male@exit" )
            loadAnimDict( "amb@prop_human_atm@male@idle_a" )

          if ( atmuse ) then 
              ClearPedTasks(PlayerPedId())
              TaskPlayAnim( player, "amb@prop_human_atm@male@exit", "exit", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
              atmuse = false
              ClearPedTasks(PlayerPedId())
          else
              atmuse = true
              TaskPlayAnim( player, "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
          end
      end
    else
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "mp_common" )

            if ( atmuse ) then 
                ClearPedTasks(PlayerPedId())
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                atmuse = false
                ClearPedTasks(PlayerPedId())
            else
                atmuse = true
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                Citizen.Wait(1000)
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end

function IsNearATM()
  for i = 1, #atms do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 1.5, atms[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
      return true
    end
  end

  return false
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
      if(closestDistance == -1 or closestDistance > distance) then
        closestPlayer = value
        closestPed = target
        closestDistance = distance
      end
    end
  end
  
  return closestPlayer, closestDistance, closestPed

end