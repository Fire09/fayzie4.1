function getJsonDataFromAdminBans()
    local imDoneNow = RPC.execute("fa-adminUI:getRecentBans")
    return imDoneNow
  end
  
  exports('getJsonDataFromAdminBans',getJsonDataFromAdminBans)
  