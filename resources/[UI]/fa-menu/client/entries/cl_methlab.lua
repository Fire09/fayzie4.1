canStartCornering = false
showSellMethOption = false
hasCarTarget = false

AddEventHandler("divine:target:changed", function(pEntity, pEntityType)
  if not pEntity or pEntityType ~= 2 then
    hasCarTarget = false
    return
  end
  hasCarTarget = true
end)

AddEventHandler("fa-meth:showSellDrugsMenuItem", function(type, b)
    if type == "cancorner" then
        canStartCornering = b
        print('canStartCornering = ',b )
    end
end)

AddEventHandler("fa-polyzone:enter", function(name)
    if name == "meth_corner" then
        print('[ENTERED] Meth corner area')
        showSellMethOption = true
    end
end)
AddEventHandler("fa-polyzone:exit", function(name)
    if name == "meth_corner" then
        print('[EXIT] Meth corner')
        showSellMethOption = false
    end
end)