local hasActivePins = false
local currentLane = 0
local totalThrown = 0
local totalDowned = 0
local lastBall = 0
local lanes = Config.BowlingLanes
local inBowlingZone = false
local function canUseLane(pLaneId)
    local shit = false
    local response = RPC.execute("bp-bowling:getLaneAccess",pLaneId)
    if(response == true) then
        shit = true
    end
    Citizen.Wait(300)
    return shit

end




Citizen.CreateThread(function()
    for k, v in pairs(lanes) do
        if (not v.enabled) then goto continueBox end

        exports[Config.PolyZoneScriptName]:AddBoxZone("bp-bowling:lane_"..k, v.pos, 1.8, 2.0, {
            heading=0,
            minZ=23.85,
            maxZ=27.85
        })

        ::continueBox::
    end
  
    exports[Config.PolyZoneScriptName]:AddBoxZone("bowling_alley", vector3(743.95, -774.54, 26.34), 16.8, 30.4, {
        heading=0.0,
        minZ=23.85,
        maxZ=28.85
    })

    local data = {
        id = 'bowling_npc_vendor',
        position = {
            coords = vector3(756.39, -774.74, 25.34),
            heading = 102.85,
        },
        pedType = 4,
        model = "a_m_o_salton_01",
        networked = false,
        distance = 25.0,
        settings = {
            { mode = 'invincible', active = true },
            { mode = 'ignore', active = true },
            { mode = 'freeze', active = true },
        },
        flags = {
            isNPC = true,
        },
    }
    RequestModel(GetHashKey(data.model))
	while not HasModelLoaded(GetHashKey(data.model)) do
		Citizen.Wait( 1 )
	end
    created_ped = CreatePed(data.pedType, data.model , data.position.coords.x,data.position.coords.y,data. position.coords.z, data.position.heading, data.networked, false)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)


    local BowlingPed = {
        GetHashKey("a_m_o_salton_01"),
    }

    exports[Config.TargetScriptName]:AddTargetModel(BowlingPed, {
        options = {
            {
                event = 'bp-bowling:client:openMenu',
                icon = 'fas fa-bowling-ball',
                label = 'View Store'
            }
        },
        job = {"all"},
        distance = 1.5
    })
   

        ::continuePeak::
    


end)

local function drawStatusHUD(state, pValues)
    local title = "Bowling - Lane #" .. currentLane
    local values = {}
  
    table.insert(values, "Throws: " .. totalThrown)
    table.insert(values, "Downed: " .. totalDowned)

    if (pValues) then
        for k, v in pairs(pValues) do
        table.insert(values, v)
        end
    end
    
    SendNUIMessage({show = state , t = title , v = values})
end
RegisterNetEvent('bp-bowling:client:openMenu')
AddEventHandler('bp-bowling:client:openMenu' , function()
    local options = Config.BowlingVendor
    local data = {}
    for itemId, item in pairs(options) do

        TriggerEvent('fa-context:sendMenu', {
            {
                id = itemId,
                header = item.name,
                txt = "Price "..item.price.."$",
                params = {
                    event = "bp-bowling:openMenu2",
                    args = {
                        data = itemId,
                    }
                }
            },
        })
    end
end)


RegisterNetEvent('bp-bowling:openMenu2')
AddEventHandler('bp-bowling:openMenu2' , function(data)
    if(data.data == 'bowlingreceipt') then
        local lanesSorted = {}
        for k, v in ipairs(lanes) do
            if(lanes[k].enabled == false) then
                return
            end

            TriggerEvent('fa-context:sendMenu', {
                {
                    id = k,
                    header = "Lane #"..k,
                    txt = "",
                    params = {
                        event = "bp-bowling:bowlingPurchase",
                        args = {
                            key = k
                        }
                    }
                },
            })
        end

    else
        TriggerEvent("bp-bowling:bowlingPurchase" , 'd')
    end
end)

local sheesh = false
function shit(k,v) 
    Citizen.CreateThread(function()
        while sheesh == true do
            exports[Config.TargetScriptName]:AddBoxZone("bp-bowling:lane_"..k, v.pos, 1.8, 2.0, {
                name = "bp-bowling:lane_"..k,
                heading = 0.0,
                minZ=20.85,
                maxZ=28.85,
                --debugPoly = true
            }, {
                options = {
                    {      
                        event = 'bp-bowling:setupPins',
                        icon = 'fas fa-arrow-circle-down',
                        label = 'Setup Pins',
                        parms = { v = k }
                    },
                },
                job = {"all"},
                distance = 1.5
            })
            sheesh = false
            Citizen.Wait(0)
        end
    end)

end

local lastlane = 0

RegisterNetEvent('bp-bowling:bowlingPurchase')
AddEventHandler("bp-bowling:bowlingPurchase", function(data)
    local isLane = type(data.key) == "number"
    local response = RPC.execute("bp-bowling:purchaseItem",data.key , isLane)

    if response == true then
        if(isLane == true) then
            for k, v in pairs(lanes) do

                if(canUseLane(k) == true) then
                    sheesh = true
                    shit(k , v)
                end
            end
            lanes[data.key].enabled = false
            lastlane = data.key
            TriggerEvent("DoLongHudText","You've successfuly bought lane access | Lane: "..data.key.."#")
        else
            TriggerEvent("DoLongHudText","You've successfuly bought a Bowling Ball")
        end
        return
    end  
end)

AddEventHandler('bp-bowling:setupPins', function(pParameters)
    local response = RPC.execute("bp-bowling:getLaneAccess",pParameters.v)
    if response == true then
        local lane = pParameters.v
        if (not lanes[lane]) then return end
        if (hasActivePins) then return end
        hasActivePins = true
        currentLane = lane
        drawStatusHUD(true)
        createPins(lanes[lane].pins)
    else
        TriggerEvent("DoLongHudText","No access to this lane",2)
    end
end)



local function canUseBall()
    return (lastBall == 0 or lastBall + 6000 < GetGameTimer()) and (inBowlingZone)
end

local function resetBowling()
    removePins()
    hasActivePins = false
    drawStatusHUD(false)
end

local gameState = {}
gameState[1] = {
    onState = function()
        if (totalDowned >= 10) then
            TriggerEvent("DoLongHudText","Strike!")

            drawStatusHUD(true, {"Strike!"})

            Citizen.Wait(1500)

            resetBowling()
            totalDowned = 0
            totalThrown = 0
        elseif (totalDowned < 10) then
            removeDownedPins()
            drawStatusHUD(true, {"Throw again!"})
        end
    end
}
gameState[2] = {
    onState = function()
        if (totalDowned >= 10) then
            drawStatusHUD(true, {"Spare!"})
            TriggerEvent("DoLongHudText","Spare!")


            Citizen.Wait(500)

            resetBowling()
        elseif (totalDowned < 10) then
            TriggerEvent("You downed " .. totalDowned .. " pins!")

            Citizen.Wait(1500)

            resetBowling()
        end

        totalDowned = 0
        totalThrown = 0
    end
}

RegisterNetEvent('bp-bowling:client:itemused')
AddEventHandler('bp-bowling:client:itemused' , function()
    if (IsPedInAnyVehicle(PlayerPedId(), true)) then return end

    -- Cooldown
    if (not canUseBall()) then return end
    startBowling(false, function(ballObject)
        lastBall = GetGameTimer()
        
        if (hasActivePins) then
            totalThrown = totalThrown + 1

            local isRolling = true
            local timeOut = false

            while (isRolling and not timeOut) do
                Citizen.Wait(100)

                local ballPos = GetEntityCoords(ballObject)
                
                if (lastBall == 0 or lastBall + 10000 < GetGameTimer()) then
                    timeOut = true
                end 

                if (ballPos.x < 730.0) then
                    -- Finish line baby
                    isRolling = false
                end
            end

            Citizen.Wait(5000)

            totalDowned = getPinsDownedCount()

            if (timeOut) then
                drawStatusHUD(true, {"Time's up!"})
                timeOut = false
            end

            if (gameState[totalThrown]) then
                gameState[totalThrown].onState()
            end

            removeBowlingBall()
            
        end
    end)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    drawStatusHUD(false)
end)

AddEventHandler("fa-polyzone:enter", function(zone, data)
    if zone ~= "bowling_alley" then return end
    inBowlingZone = true
end)

AddEventHandler("fa-polyzone:exit", function(zone, data)
    if zone ~= "bowling_alley" then return end

    inBowlingZone = false
    TriggerEvent("bp-bowling:RemoveItem")
    if (lanes[lastlane] ~= nil) then
        lanes[lastlane].enabled = true
    end
    if (hasActivePins) then
        resetBowling()
        totalDowned = 0
        totalThrown = 0
    end
end)


RegisterNetEvent("bp-bowling:RemoveItem")
AddEventHandler("bp-bowling:RemoveItem" , function()
    if not exports["fa-inventory"]:hasEnoughOfItem("bowlingball",1,false) then return end
    if exports['fa-inventory']:hasEnoughOfItem('bowlingball', 1) then
        TriggerEvent("inventory:removeItem", "bowlingball", 1)
        Citizen.Wait(3000)
    end
    if not exports["fa-inventory"]:hasEnoughOfItem("bowlingreceipt",1,false) then return end
    if exports['fa-inventory']:hasEnoughOfItem('bowlingreceipt', 1) then
        TriggerEvent("inventory:removeItem", "bowlingreceipt", 1)
        Citizen.Wait(3000)
    end
end)



