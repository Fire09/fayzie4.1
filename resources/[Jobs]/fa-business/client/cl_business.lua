RegisterInterfaceCallback("fa-ui:createBusiness", function(data, cb)
  local success, message = RPC.execute("CreateBusiness", data)
  cb({ data = {}, meta = { ok = success, message = message } })
end)

RegisterInterfaceCallback("fa-ui:getBusinessTypes", function(data, cb)
  local success, message = RPC.execute("GetBusinessTypes")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:getBusinesses", function(data, cb)
  local success, message = RPC.execute("GetBusinesses")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:getEmploymentInformation", function(data, cb)
  local success, message = RPC.execute("GetEmploymentInformation", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:getBusinessEmployees", function(data, cb)
  local success, message = RPC.execute("GetBusinessEmployees", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:getBusinessRoles", function(data, cb)
  local success, message = RPC.execute("GetBusinessRoles", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:createBusinessRole", function(data, cb)
  local success, message = RPC.execute("CreateBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:changeBusinessRole", function(data, cb)
  local success, message = RPC.execute("ChangeBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:hireBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("HireBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:removeBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("RemoveBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:businessPayEmployee", function(data, cb)
  local success, message = RPC.execute("BusinessPayEmployee", data)
  cb({ data = message or {}, meta = { ok = success, message = message or "Unknown Error; check account balance" } })
end)

RegisterInterfaceCallback("fa-ui:businessPayExternal", function(data, cb)
  local success, message = RPC.execute("BusinessPayExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("fa-ui:businessChargeExternal", function(data, cb)
  RPC.execute("ChargeExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)
RegisterInterfaceCallback("fa-ui:businessChargeAccept", function(data, cb)
  local success, message = RPC.execute("BusinessChargeAccept", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

--[[ RegisterNetEvent("business:chargeAcceptPrompt")
AddEventHandler("business:chargeAcceptPrompt", function(data)
  SendUIMessage({
    source = "fa-nui",
    app = "phone",
    data = {
      action = "charge-accept",
      data = data,
    },
  })
end) ]]
