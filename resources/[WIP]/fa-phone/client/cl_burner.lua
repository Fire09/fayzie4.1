RegisterNetEvent("openBurner", function(v)
    openGui(true, exports['isPed']:isPed('cid'))
end)

RegisterNUICallback("getRecentCallsByCid", function(data, cb)
    local recentCalls = RPC.execute("fa-phone:getRecentCallsByCid", tonumber(data.cid))
    SendNUIMessage({
        openSection = "callHistory",
        callHistory = recentCalls
      })
end)

RegisterNUICallback("getTextsByCid", function(data, cb)
    loadSMS(tonumber(data.cid))
end)