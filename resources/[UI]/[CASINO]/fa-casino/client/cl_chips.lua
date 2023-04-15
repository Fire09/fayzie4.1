exports["fa-polytarget"]:AddCircleZone("bd_casino_trade_chips", vector3(989.73, 31.57, 71.54), 0.35, {
    name="bd_casino_trade_chips",
    useZ=true,
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("bd_casino_trade_chips", {
    {
        event = "fa-casino:cashoutBank",
        id = "row_1",
        icon = "landmark",
        label = "Cashout Chips (Bank)",
        parameters = {},
    },
    {
        event = "fa-casino:cashoutCash",
        id = "row_3",
        icon = "wallet",
        label = "Cashout Chips (Cash)",
        parameters = {},
    },
    {
        event = "fa-casino:purchaseChips",
        id = "row_2",
        icon = "circle",
        label = "Purchase Chips",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});


RegisterNetEvent('fa-casino:purchaseChips')
AddEventHandler('fa-casino:purchaseChips', function()
    exports['fa-interface']:openApplication('textbox', {
        callbackUrl = 'fa-casino:pPurchaseMyChips',
        key = 1,
        items = {
        {
            icon = "money-bill",
            label = "How many chips.",
            name = "pChips",
        },
        },
        show = true,
    })
end)

RegisterInterfaceCallback('fa-casino:pPurchaseMyChips', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    if exports['fa-inventory']:hasEnoughOfItem('casinomember', 1) then
        if exports["isPed"]:isPed("mycash") >= tonumber(data.values.pChips) then
            TriggerServerEvent('aspect-casino:takeMoneyChips', data.values.pChips)
            TriggerEvent('fa-casino:giveChipsCL', data.values.pChips)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a Casino Membership to purchase Chips.', 2)
    end
end)

RegisterNetEvent('fa-casino:cashoutCash')
AddEventHandler('fa-casino:cashoutCash', function()
    local pQuantityChipsCash = RPC.execute('fa-casino:getChips')
    TriggerEvent('fa-casino:removeChipsCL', pQuantityChipsCash)
    TriggerServerEvent('aspect-casino:giveCashoutCashChips', pQuantityChipsCash)
end)

RegisterNetEvent('fa-casino:cashoutBank')
AddEventHandler('fa-casino:cashoutBank', function()
    local pQuantityChipBank = RPC.execute('fa-casino:getChips')
    TriggerEvent('fa-casino:removeChipsCL', pQuantityChipBank)
    TriggerServerEvent('aspect-casino:giveCashoutBankChips', pQuantityChipBank)
end)

RegisterNetEvent('fa-casino:addBalance')
AddEventHandler('fa-casino:addBalance', function(pAmount)
    TriggerServerEvent('fa-financials:business_money', pAmount, 'casino', 'add')
end)

RegisterCommand('givechips', function()
    TriggerServerEvent('fa-casino:giveChips', 10)
end)