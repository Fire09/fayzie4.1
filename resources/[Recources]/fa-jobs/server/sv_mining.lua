

RegisterServerEvent('fa-civjobs:sell-gem-cash')
AddEventHandler('fa-civjobs:sell-gem-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(74, 124)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Gem", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('fa-civjobs:sell-stone-cash')
AddEventHandler('fa-civjobs:sell-stone-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(35, 74)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Stone", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('fa-civjobs:sell-coal-cash')
AddEventHandler('fa-civjobs:sell-coal-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(14, 65)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Coal and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Coal", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('fa-civjobs:sell-diamond-cash')
AddEventHandler('fa-civjobs:sell-diamond-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(265, 432)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Diamond and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Diamond", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('fa-civjobs:sell-sapphire-cash')
AddEventHandler('fa-civjobs:sell-sapphire-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(167, 245)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Sapphire and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Sapphire", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('fa-civjobs:sell-ruby-cash')
AddEventHandler('fa-civjobs:sell-ruby-cash', function()
    local src = tonumber(source)
    local user = exports["fa-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(187, 345)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Ruby and got $'..cash, 1)

    exports["fa-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Ruby", 
        { amount = tostring(cash) })
end)