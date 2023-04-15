-- POLICE HIRE/FIRE --

RegisterNetEvent("fa-duty:HireLaw:Menu")
AddEventHandler("fa-duty:HireLaw:Menu", function()
  local isEmployed = exports["fa-business"]:IsEmployedAt("rangers") or exports["fa-business"]:IsEmployedAt("statetrooper") or exports["fa-business"]:IsEmployedAt("police")
  if isEmployed then
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-duty:police_menu',
        key = 1,
        items = {
          {
            icon = "pencil-alt",
            label = "Enter State ID.",
            name = "pStateID",
          },
          {
            icon = "pencil-alt",
            label = "Enter Department.",
            name = "pDepartment",
          },
          {
            icon = "pencil-alt",
            label = "Enter Rank.",
            name = "pRank",
          },
        },
        show = true,
      })
    else
      TriggerEvent('DoLongHudText', "You do not have permission for this!", 2)
    end
end)

RegisterInterfaceCallback('fa-duty:police_menu', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
   TriggerServerEvent("fa-duty:HireLaw", data.values.pStateID, data.values.pDepartment, data.values.pRank)
end)

RegisterNetEvent("fa-duty:FireLaw:Menu")
AddEventHandler("fa-duty:FireLaw:Menu", function()
  local isEmployed = exports["fa-business"]:IsEmployedAt("rangers") or exports["fa-business"]:IsEmployedAt("statetrooper") or exports["fa-business"]:IsEmployedAt("police")
  if isEmployed then
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-duty:fire_pd',
        key = 1,
        items = {
          {
            icon = "pencil-alt",
            label = "Enter State ID.",
            name = "pStateID",
          },
        },
        show = true,
      })
    else
      TriggerEvent('DoLongHudText', "You do not have permission for this!", 2)
    end
end)

RegisterInterfaceCallback('fa-duty:fire_pd', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerServerEvent("fa-duty:FireLaw", data.values.pStateID)
end)

-- END POLICE HIRE/FIRE --

-- EMS HIRE/FIRE --

RegisterNetEvent("fa-duty:HireEMS:Menu")
AddEventHandler("fa-duty:HireEMS:Menu", function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-duty:hire_ems',
        key = 1,
        items = {
          {
            icon = "pencil-alt",
            label = "Enter State ID.",
            name = "pStateID",
          },
          {
            icon = "pencil-alt",
            label = "Enter Rank.",
            name = "pRankEMS",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-duty:hire_ems', function(data,cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerServerEvent("fa-duty:HireEMS", data.values.pStateID, data.values.pRankEMS)
end)

RegisterNetEvent("fa-duty:FireEMS:Menu")
AddEventHandler("fa-duty:FireEMS:Menu", function()
        exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-duty:fire_ems',
        key = 1,
        items = {
          {
            icon = "pencil-alt",
            label = "Enter State ID.",
            name = "pStateID",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('fa-duty:fire_ems', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerServerEvent("fa-duty:FireEMS", data.values.pStateID)
end)

-- END EMS HIRE/FIRE --