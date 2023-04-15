RegisterNUICallback('addEmployee', function(data)
  RPC.execute("fa-business:business:hireEmployee",data.state_id,data.rank,data.business)
end)

RegisterNUICallback('chargeCustomer', function(data)
  local success = RPC.execute('fa-phone:sendChargeCustomerNotif',data.GroupName, data.GroupID, data.stateID, data.amount, data.reason)
end)

RegisterNUICallback('editEmployee', function(data)
  RPC.execute("fa-business:phone:updateEmployee", data.state_id, data.business, data.rank)
end)

RegisterNetEvent("fa-phone:chargeCustomerNotif", function(data)
  local title = data.businessName
  data = {amount = data.amount, senderID = data.senderID, pType = 'charge', targetCID = data.stateID, companyID = data.businessID, companyName = title}
  phoneBillNotification("charge", data, title)
end)

RegisterNUICallback('acceptBusinessCharge', function(data)
    RPC.execute("fa-phone:chargeCustomerBus", data.pAmount, data.pBID, data.pTargetID, data.pSenderID)
end)

RegisterNUICallback('fireEmployee', function(data)
    RPC.execute("fa-business:business:fireEmployee", data.state_id, data.business)
end)

RegisterNUICallback('payCheckEmployee', function(data)
    local business = data.business
    local cid = data.state_id
    local amount = data.amount
    local complete, paid = RPC.execute('fa-phone:business_paycheck', business,cid,amount)
    if complete then
        local data = 'You generate a paycheck of $'..paid..''
        phoneNotification("email",data,getBusinessName(business))
    end
end)


function GroupRank(groupid)
    local rank = 0
    local mypasses = exports["isPed"]:isPed("passes")
    for i=1, #mypasses do
      if mypasses[i]["pass_type"] == groupid then
        rank = mypasses[i]["rank"]
      end 
    end
    return rank
  end
  
  RegisterNUICallback('bankGroup', function(data)
      local gangid = data.gangid
      local cashamount = data.cashamount
      TriggerServerEvent("server:gankGroup", gangid,cashamount)
  end)
  
  RegisterNUICallback('payGroup', function(data)
      local gangid = data.gangid
      local cid = data.cid
      local cashamount = data.cashamount
      TriggerEvent('DoLongHudText', 'You generated a paycheck to your employee.')
      local rank = GroupRank(gangid)
      if rank < 5 then
        SendNUIMessage({
          openSection = "error",
          textmessage = "Permission Error",
        })   
        return
      end
  
      TriggerServerEvent("server:givepayGroup", gangid,cashamount,cid)
  end)

  RegisterNUICallback('promoteGroup', function(data)
    local gangid = data.gangid
    local cid = data.cid
    local newrank = data.newrank

    local rank = GroupRank(gangid)
    if rank < 4 then
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end

    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })
    TriggerServerEvent("server:givepass", gangid,newrank,cid)
end)

RegisterNUICallback('btnTaskGroups', function()

  local mypasses = RPC.execute("fa-business:phone:GetEmploymentInformation")
  local groupObject = {}

  for k,v in pairs(mypasses) do 
    local myRoles = RPC.execute("fa-business:phone:GetRolePermission", v.businessid, v.businessrole)
    for j,s in pairs(myRoles) do
      groupObject[#groupObject+1] = {
        namesent      = v.businessname,
        ranksent      = v.businessrole,
        idsent        = v.businessid,
        role_manage   = s.role_manage, 
        role_create   = s.role_create, 
        can_hire      = s.can_hire, 
        can_fire      = s.can_fire, 
        bank_access   = s.bank_access, 
        charge_access = s.charge_access, 
        key_access    = s.key_access, 
        stash_access  = s.stash_access, 
        craft_access  = s.craft_access,
        logs_access   = s.logs_access
      }
    end
  end
    SendNUIMessage({
      openSection = "groups",
      groups = groupObject
    })
  end)
  
  
  RegisterNetEvent("group:fullList")
  AddEventHandler("group:fullList", function(bank,groupid)
    local myjob = exports["isPed"]:isPed("myjob")
    local fullGroupList = {}
    local peniashiut = RPC.execute("fa-business:hasPermission", groupid)
    local groupseemployyees = RPC.execute("fa-businesses:getRoleAndEmployeesList", groupid)
    for k,v in pairs(groupseemployyees) do
      for p,s in pairs(peniashiut) do
        fullGroupList[#fullGroupList+1] = {
          first_name = v.first_name,
          last_name = v.last_name,
          cid = v.cid,
          role = v.role,
          role_manage = s.role_manage,
          role_create = s.role_create, 
          can_hire = s.can_hire, 
          can_fire = s.can_fire, 
          bank_access = s.bank_access, 
          charge_access = s.charge_access, 
          key_access = s.key_access, 
          stash_access = s.stash_access, 
          craft_access = s.craft_access,
          logs_access = s.logs_access,
          myRank = s.myRank
        }
      end
    end
      -- group-manage
      SendNUIMessage({
        openSection = "groupManage",
        groupData = {
          groupName = groupname,
          bank = bank,
          groupId = groupid,
          employees = fullGroupList,
          ranking = rank,
        }
      })
  end)

  RegisterNUICallback('openBusinessLogs', function(data)
    local businessLogs = RPC.execute("erp:getBusinessLogs", data.business)

    SendNUIMessage({
      openSection = "addBusinessLogs",
      accessLogs = businessLogs
    })
  end)

  RegisterNUICallback('payExternal', function(data)
    local typee
    local success, msg = RPC.execute('fa-business:payExternal', data.pStateId, data.pAmount, data.pBusinessID)
    if success then
      typee = 1
    else
      typee = 2
    end
    TriggerEvent("DoLongHudText",msg,typee)
  end)

  RegisterNUICallback('deleteRole', function(data)
    RPC.execute("fa-business:business:deleteRole", data.pBusinessID, data.pRole)
  end)

  RegisterNUICallback('createBusinessRole', function(data)
    RPC.execute("fa-business:business:createRole", data.pBusinessId, data.pRoleName, data.pPermHire, data.pPermFire, data.pPermChangeRoles, data.pPermKeys, data.pPermStash, data.pPermCraft, data.pPermCharge, data.pPermBank, data.pPermLogs)  
  end)

  RegisterNUICallback("editBusinessRole", function(data)
    RPC.execute("fa-business:business:editRole", data.pBusinessId, data.pCurRole, data.pRoleName, data.pPermFire, data.pPermHire, data.pPermChangeRoles, data.pPermKeys, data.pPermStash, data.pPermCraft, data.pPermCharge, data.pPermBank, data.pPermLogs)
  end)
  
  RegisterNUICallback('manageGroup', function(data)
    local groupid = data.GroupID
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })   
    TriggerEvent("group:fullList",'groupid',groupid)
  end)

  RegisterNUICallback('retreiveGroupRanks', function(data)
    local groupFountData = {}
    local roles = RPC.execute("fa-business:business:GetBusinessRoles", data.bID)
    for k,v in pairs(roles) do
      groupFountData[#groupFountData+1] = {
        name = {
          dada = v.label
        }
      }
    end
    SendNUIMessage({
      openSection = "groupSendDatah",
      groupDatah = groupFountData
    })
  end)

  RegisterNUICallback('btnTaskGang', function()
    TriggerEvent("gangTasks:updated")
  end)

  RegisterNUICallback('fa-phone:fireEmp', function(data,cb)
    TriggerServerEvent('fa-phone:fireEmp', data.id,data.group,data.name)
  end)

  RegisterNUICallback('addCashBank', function(data)
    local bid = data.bid
    local amount = data.amount
    local bank = RPC.execute("fa-phone:bus_addBank",bid,amount)
    if bank then
      local data = 'You add $'..amount..' in bank.'
      phoneNotification("email",data,getBusinessName(bid))
    end
  end)
