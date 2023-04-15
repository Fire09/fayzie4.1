local status = false
local currentSource = 0
local pendingGroupID = 0

RegisterNUICallback('job-center', function(data, cb)
  local activeGroups = RPC.execute("fa-phone:getGroupsCount")
  local idle = RPC.execute("fa-phone:getIdleGroup", exports['isPed']:isPed('myjob'))
  local busy = RPC.execute("fa-phone:getBusyGroup", exports['isPed']:isPed('myjob'))
  local myG = RPC.execute("fa-phone:getMyGroup")
  local members = RPC.execute("fa-phone:get_groupsMem")
  local job = exports['isPed']:isPed('myjob')
  local leader = RPC.execute('fa-phone:getGroupLeader', exports['isPed']:isPed('cid'))
  local pJob = 'unemployed'
  local jCount = 0

  if job == 'sanitation_worker' or job == 'fisherman' or job == 'delivery_driver' or job == 'criminal' or job == 'towtrucker' or job == 'houserob' or job == 'chopshop' or job == 'dodologistics' then
    pJob = job
  else 
    pJob = 'unemployed'
  end

  if job == 'sanitation_worker' then
    jCount = 4
  elseif job == 'fisherman' then
    jCount = 4
  elseif job == 'criminal' then
    jCount = 4
  elseif job == 'towtrucker' then
    jCount = 2
  elseif job == 'houserob' then
    jCount = 4
  elseif job == 'chopshop' then
    jCount = 4
  elseif job == 'dodologistics' then
    jCount = 2
  elseif job == 'delivery_driver' then
    jCount = 2
  end

  SendNUIMessage({
    openSection = "openJobCenterApp",
    openStatus = 'notrefresh',
    idle = idle,
    myG = myG,
    members = members,
    mysrc = GetPlayerServerId(PlayerId()),
    busy = busy,
    groups = activeGroups, 
    gMAmount = jCount,
    myjob = pJob,
    leader = leader
  })
end)

RegisterNetEvent('refreshJobCenter', function()
  Wait(1000)
  local activeGroups = RPC.execute("fa-phone:getGroupsCount")
  local idle = RPC.execute("fa-phone:getIdleGroup", exports['isPed']:isPed('myjob'))
  local busy = RPC.execute("fa-phone:getBusyGroup", exports['isPed']:isPed('myjob'))
  local myG = RPC.execute("fa-phone:getMyGroup")
  local members = RPC.execute("fa-phone:get_groupsMem", idle)
  local leader = RPC.execute('fa-phone:getGroupLeader', exports['isPed']:isPed('cid'))

  local job = exports['isPed']:isPed('myjob')
  local pJob = 'unemployed'
  local jCount = 0

  if job == 'sanitation_worker' or job == 'fisherman' or job == 'delivery_driver' or job == 'criminal' or job == 'towtrucker' or job == 'houserob' or job == 'chopshop' or job == 'dodologistics' then
    pJob = job
  else 
    pJob = 'unemployed'
  end

  if job == 'sanitation_worker' then
    jCount = 4
  elseif job == 'fisherman' then
    jCount = 4
  elseif job == 'criminal' then
    jCount = 4
  elseif job == 'towtrucker' then
    jCount = 2
  elseif job == 'houserob' then
    jCount = 4
  elseif job == 'chopshop' then
    jCount = 4
  elseif job == 'dodologistics' then
    jCount = 2
  elseif job == 'delivery_driver' then
    jCount = 2
  end

  SendNUIMessage({
    openSection = "openJobCenterApp",
    openStatus = 'refresh',
    idle = idle,
    myG = myG,
    members = members,
    mysrc = GetPlayerServerId(PlayerId()),
    busy = busy,
    groups = activeGroups, 
    gMAmount = jCount,
    myjob = pJob,
    leader = leader,
  })
end)

RegisterNetEvent('refreshJobCentertwo', function()
  local activeGroups = RPC.execute("fa-phone:getGroupsCount")
  local idle = RPC.execute("fa-phone:getIdleGroup", exports['isPed']:isPed('myjob'))
  local busy = RPC.execute("fa-phone:getBusyGroup", exports['isPed']:isPed('myjob'))
  local myG = RPC.execute("fa-phone:getMyGroup")
  local members = RPC.execute("fa-phone:get_groupsMem", idle)
  local leader = RPC.execute('fa-phone:getGroupLeader', exports['isPed']:isPed('cid'))

  local job = exports['isPed']:isPed('myjob')
  local pJob = 'unemployed'
  local jCount = 0

  if job == 'sanitation_worker' or job == 'fisherman' or job == 'delivery_driver' or job == 'criminal' or job == 'towtrucker' or job == 'houserob' or job == 'chopshop' or job == 'dodologistics' then
    pJob = job
  else 
    pJob = 'unemployed'
  end

  if job == 'sanitation_worker' then
    jCount = 4
  elseif job == 'fisherman' then
    jCount = 4
  elseif job == 'criminal' then
    jCount = 4
  elseif job == 'towtrucker' then
    jCount = 2
  elseif job == 'houserob' then
    jCount = 4
  elseif job == 'chopshop' then
    jCount = 4
  elseif job == 'dodologistics' then
    jCount = 2
  elseif job == 'delivery_driver' then
    jCount = 2
  end

  SendNUIMessage({
    openSection = "openJobCenterApp",
    openStatus = 'notrefresh',
    idle = idle,
    myG = myG,
    members = members,
    mysrc = GetPlayerServerId(PlayerId()),
    busy = busy,
    groups = activeGroups, 
    gMAmount = jCount,
    myjob = pJob,
    leader = leader
  })
end)

RegisterNUICallback('jobcenter-setgps', function(data)
  if data.item == "sanitation" then
      SetNewWaypoint(-321.84, -1545.59)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "fishing" then
      SetNewWaypoint(1298.76, 4216.27)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
    elseif data.item == "delivery" then
      SetNewWaypoint(-437.81, -2793.22)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "poultry" then
      SetNewWaypoint(2387.75, 5044.41)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "hunting" then
      SetNewWaypoint(-773.51, 5600.52)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "mining" then
      SetNewWaypoint(-596.59, 2089.55)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "darkmarket" then
      SetNewWaypoint(-1564.092, -440.6379, 36.982887)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
      TriggerServerEvent("rp-deliveries:JobCenter")
  elseif data.item == "chopshop" then
      SetNewWaypoint(-219.0431, -1368.112, 31.258249)
      TriggerEvent("DoLongHudText", "GPS Updated",1)
  elseif data.item == "houserobbery" then
    SetNewWaypoint(205.83923, -1852.659, 27.215774)
    TriggerEvent("DoLongHudText", "GPS Updated",1)
  end
end)

RegisterNUICallback('setwaypointImpound', function()
  SetNewWaypoint(1587.6922607422, 3841.8198242188)
end)

RegisterNUICallback('c_group', function()
  local create = RPC.execute("fa-phone:c_group")
end)

RegisterNUICallback('group_CheckOut', function()
  TriggerServerEvent("jobssystem:jobs", "unemployed")
  RPC.execute("fa-phone:group_CheckOut")
end)

RegisterNUICallback('fa-phone:joinGroup', function(data)
    local gId = data.gId
    RPC.execute("fa-phone:j_group", gId, exports['isPed']:isPed('cid'))
end)

RegisterNUICallback('JobReady', function(data)
    status = data.status
    if data.status == true then
      grpStatus = "1"
    else
      grpStatus = "0"
    end
    if data.changeStatus then
      RPC.execute('fa-phone:setGroupStatus', grpStatus, exports['isPed']:isPed('fullname'))
    end
end)

pressedLeave = false

RegisterNUICallback('leave_group', function(data)
  local gId = data.gid
  if not pressedLeave then
    pressedLeave = true
    RPC.execute('fa-phone:leave_group', gId)
    Citizen.Wait(5000)
    pressedLeave = false
  end
end)

RegisterNUICallback('jobInviteAccepted', function()
    local job = exports['isPed']:isPed('myjob')
    local jCount = 0

    if job == 'sanitation_worker' then
      jCount = 3
    elseif job == 'fisherman' then
      jCount = 3
    elseif job == 'criminal' then
      jCount = 3
    elseif job == 'houserob' then
      jCount = 3
    elseif job == 'delivery_driver' then
      jCount = 1
    elseif job == 'dodologistics' then
      jCount = 1
    end

    RPC.execute("fa-phone:joinGroup_Accepted", currentSource, pendingGroupID, jCount)
    Wait(100)
    pendingGroupID = 0
    currentSource = 0
end)

RegisterNUICallback('jobInviteDecline', function()
  RPC.execute("fa-phone:j_group_decline")
  Wait(100)
  pendingGroupID = 0
  currentSource = 0
end)

RegisterNetEvent('fa-phone:client:joboffer', function(jInfo)
    SendNUIMessage({
      openSection = "jobOffer", 
      jobInfo = jInfo
    }) 
end)

RegisterNetEvent('fa-phone:CreateGroupInvite', function(jInfo, jMessage, pInfo, gID)
  pendingGroupID = gID
  currentSource = pInfo
  SendNUIMessage({
    openSection = "createGroupInvite", 
    jobInviteHeader = jInfo,
    jobInviteMessage = jMessage
  }) 
end)

RegisterNetEvent('fa-phone:JobNotify', function(jInfo, jMessage)
  SendNUIMessage({
    openSection = "jobNotify", 
    jobTaskAmount = jInfo,
    jobMessage = jMessage
  }) 
end)

RegisterNetEvent('fa-phone:JobNotifyStable', function(jInfo, jMessage)
  SendNUIMessage({
    openSection = "jobNotifyStable", 
    jobTaskAmount = jInfo,
    jobMessage = jMessage
  }) 
end)

RegisterNetEvent('fa-phone:JobNotifyClose', function()
  SendNUIMessage({
    openSection = "jobNotifyClose"
  })
  RPC.execute('fa-phone:setGroupStatus', "0", exports['isPed']:isPed('fullname'))
end)

RegisterNetEvent('fa-phone:JobNotifyCloseNotFully', function()
  SendNUIMessage({
    openSection = "jobNotifyCloseNotFully"
  }) 
end)

local hasRequiredVehicle = function() 
  local pPed = PlayerPedId()
end

local checkJobVehicle = function(vModel) 

  local res = false
  
  if vModel == "TRASH" or vModel == "TRASH2" then 
    res = true
  end
  return res
end

local TrashZones = {} 

TrashZones["ALTA ST"] = true  -- maybe call this from garbage job ?

local inValidZone = function(cZone)
  local res = false
  if TrashZones[cZone:upper()] ~= nil then
    res = true
  end
  return res
end

-- When player has accepted the job at he foreman !
local hasJobAccepted = function()  
local currentTask = RPC.execute('fa-phone:getGroupTask')
  if currentTask == 0 then 
    updateTasks()
  end
end

RegisterNetEvent('fa-phone:CancelJob', function(status)
  local job = exports['isPed']:isPed('myjob')

    if status == 1 then
      if job == 'sanitation_worker' then
        TriggerEvent('fa-garbage:JobCancel', status)
      end
      if job == 'fisherman' then
        TriggerEvent('fa-fishing:JobCancel', status)
      end
      if job == 'delivery_driver' then
        TriggerEvent('fa-delivery:JobCancel', status)
      end
    else
      if job == 'sanitation_worker' then
        TriggerEvent('fa-garbage:JobCancel', status)
      end
      if job == 'fisherman' then
        TriggerEvent('fa-fishing:JobCancel', status)
      end
      if job == 'delivery_driver' then
        TriggerEvent('fa-delivery:JobCancel', status)
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait((60 * 1000) * 1)
    if status then
      local job = exports['isPed']:isPed('myjob')
      if job == 'sanitation_worker' then
        phoneBillNotification("joboffergarbage", {amount = "Garbage Job Offer", sellerID = sId, pType = 'garbage'}, 'Job Offer')
      elseif job == 'fisherman' then
        phoneBillNotification("jobofferfishing", {amount = "Fishing Job Offer", sellerID = sId, pType = 'fishing'}, 'Job Offer')
      elseif job == 'delivery_driver' then
        phoneBillNotification("jobofferdelivery", {amount = "24/7 Delivery Job Offer", sellerID = sId, pType = 'garbage'}, 'Job Offer')
      elseif job == 'criminal' then
        if exports['fa-inventory']:hasEnoughOfItem('vpnxj', 1) and exports['fa-inventory']:hasEnoughOfItem('darkmarketdeliveries', 1) then
          phoneBillNotification("jobofferoxy", {amount = "Oxy Run Job Offer", sellerID = sId, pType = 'oxy'}, 'Job Offer')
        else
          phoneNotification('jobactivity', 'You lack the job requirements.', 'Job Center')
        end
      elseif job == 'towtrucker' then
        phoneBillNotification("joboffertowing", {amount = "Tow Trucking Job Offer", sellerID = sId, pType = 'joboffertowing'}, 'Job Offer')
      elseif job == 'houserob' then
        phoneBillNotification("house_robbery", {amount = "House Robbery Job Offer", sellerID = sId, pType = 'house_robbery'}, 'Job Offer')
      elseif job == 'chopshop' then
        phoneBillNotification("jobofferchop", {amount = "Chop Job Offer", sellerID = sId, pType = 'jobofferchop'}, 'Job Offer')
      elseif job == 'dodologistics' then
        phoneBillNotification("jobofferdodo", {amount = "Dodo Logistics Job Offer", sellerID = sId, pType = 'jobofferdodo'}, 'Job Offer')
      end
    end
  end
end)

RegisterNUICallback('accept_delivery_job', function()
    TriggerEvent('fa-jobs:deliveries:getCar')
    SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_fishing_job', function()
  RPC.execute('fa-jobs:fishingStart')
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_garbage_job', function()
  TriggerEvent('fa-jobs:startGarbageRun')
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_oxy_run', function()
  RPC.execute('fa-activities:syncOxyStart', math.random(1, 3))
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_tow_job', function()
	TriggerEvent('fa-jobs:clockIntoTowing', math.random(1, 8))
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_house_robbery', function(data)
  TriggerEvent('fa-activities:acceptJob')
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_chop_shop', function(data)
    TriggerEvent('fa-activities:startJobChop', math.random(1, 7))
    SendNUIMessage({openSection = "resetJobStatus"}) 
end)

RegisterNUICallback('accept_dodo_job', function(data)
  TriggerEvent('fa-jobs:spawn-truck')
  SendNUIMessage({openSection = "resetJobStatus"}) 
end)