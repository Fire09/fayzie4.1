CharacterProgression = Progression:new()

local function InitProgression() 
    local progression = RPC.execute('np:progression:character:init')
    print(json.encode(progression))
    if not progression then return error('Unable to load progression') end

    CharacterProgression:setProgression(progression)
end

function GetProgression(pSystem)
    return CharacterProgression:getProgression(pSystem)
end

exports('GetProgression', GetProgression)

AddEventHandler('np:progression:update', function (pSystem, pValue)
    local r = RPC.execute("np:progression:update", pSystem, pValue)
    if not r then
        return
    end
    CharacterProgression:updateProgression(pSystem, pValue)
end)

Citizen.CreateThread(function()
    local cid = exports['isPed']:isPed('cid');

    if not cid or cid <= 0 then return end

    InitProgression()
end)

AddEventHandler('fa-spawn:characterSpawned', function()
    InitProgression()
end)
