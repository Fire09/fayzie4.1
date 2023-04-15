RPC.register("fa-phone:submitNewEventDiamondSports", function(pSource, pEventName, pEventLocation, pTimeZone, pEventTimeHr, pEventTimeMin, pEventDate)
    exports.oxmysql:execute("INSERT INTO __diamondsports (time,date,name,location,timezoneAbbreviation) VALUES (?,?,?,?,?)",{pEventTimeHr .. ":" .. pEventTimeMin, pEventDate, pEventName, pEventLocation, pTimeZone})
end)

RPC.register("fa-phone:getDiamondSportsEvents", function(pSource)
    local result = MySQL.query.await("SELECT * FROM __diamondsports")
    local tableh = {}
        for k,v in pairs(result) do
            print(v.name, v.location, v.timezoneAbbreviation, v.time, v.date, v.id)
            tableh[#tableh+1] = {
                name = v.name, 
                location = v.location,
                timezoneAbbreviation = v.timezoneAbbreviation,
                time = v.time,
                date = v.date,
                id = v.id
            } 
        end
    return tableh
end)

RPC.register("fa-phone:deleteDiamondEvent", function(pSource, pID)
    exports.oxmysql:execute("DELETE FROM __diamondsports WHERE id = ?",{pID})
end)