DPX.BlipManager = DPX.BlipManager or {}
DPX.Blips = DPX.Blips or {}

function DPX.BlipManager.CreateBlip(self, id, data)
    local blip = AddBlipForCoord(data.x, data.y, data.z)

    if data.sprite then SetBlipSprite(blip, data.sprite) end
    if data.range then SetBlipAsShortRange(blip, data.range) else SetBlipAsShortRange(blip, true) end
    if data.color then SetBlipColour(blip, data.color) end
    if data.display then SetBlipDisplay(blip, data.display) end
    if data.playername then SetBlipNameToPlayerName(blip, data.playername) end
    if data.showcone then SetBlipShowCone(blip, data.showcone) end
    if data.secondarycolor then SetBlipSecondaryColour(blip, data.secondarycolor) end
    if data.friend then SetBlipFriend(blip, data.friend) end
    if data.mission then SetBlipAsMissionCreatorBlip(blip, data.mission) end
    if data.route then SetBlipRoute(blip, data.route) end
    if data.friendly then SetBlipAsFriendly(blip, data.friendly) end
    if data.routecolor then SetBlipRouteColour(blip, data.routecolor) end
    if data.scale then SetBlipScale(blip, data.scale) else SetBlipScale(blip, 0.8) end

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.name)
    EndTextCommandSetBlipName(blip)

    DPX.Blips[id] = {blip = blip, data = data}
end

function DPX.BlipManager.RemoveBlip(self, id)
    local blip = DPX.Blips[id]
    if blip then RemoveBlip(blip.blip) end
    DPX.Blips[id] = nil
end

function DPX.BlipManager.HideBlip(self, id, toggle)
    local blip = DPX.Blips[id]
    if not blip then return end
    if toggle then 
        SetBlipAlpha(blip.blip, 0)
        SetBlipHiddenOnLegend(blip.blip, true)
    else
        SetBlipAlpha(blip.blip, 255)
        SetBlipHiddenOnLegend(blip.blip, false)
    end
end

function DPX.BlipManager.GetBlip(self, id)
    local blip = DPX.Blips[id]
    if not blip then return false end
    return blip
end
