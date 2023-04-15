AtcChannel = {}

function AtcChannel:new (atcID)
    local this = {}

    this.id = atcID
    this.serverID = GetPlayerServerId(PlayerId())

    this.subscribers = {}

    self.__index = self

    return setmetatable(this, self)
end

function AtcChannel:subscriberExists(serverID)
    return self.subscribers[serverID] ~= nil
end

function AtcChannel:addSubscriber(serverID)
    if not self:subscriberExists(serverID) and self.serverID ~= serverID then
        self.subscribers[serverID] = serverID
    end
end

function AtcChannel:removeSubscriber(serverID)
    if self:subscriberExists(serverID) then
        self.subscribers[serverID] = nil
    end
end