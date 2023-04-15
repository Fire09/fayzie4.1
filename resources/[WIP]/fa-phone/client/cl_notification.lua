function phoneNotification(app,data,handle)
    if hasPhone() then
        SendNUIMessage({
            openSection = "notify",
             Napp = app, 
             Ndata = data, 
             Title = handle, 
             Ntime = 2500
        })
    end
end

exports('phoneNotification', phoneNotification)

function phoneCallNotification(app,data,handle)
    if hasPhone() then
        SendNUIMessage({
            openSection = "rcall",
            pNotify = false,
            Napp = app, 
            Ndata = data, 
            Nhandle = handle, 
            Ntime = 2500
        })
    end
end

function phonePingNotification(app,handle)
    if hasPhone() then
        if handle ~= nil then
            SendNUIMessage({
                openSection = "notify",
                pNotify = false,
                Napp = app, 
                Ndata = "sent you a ping.", 
                Nhandle = handle, 
                Ntime = 2500
            })
        end
    end
end

function phoneBillNotification(icon,data,title)
    if hasPhone() then
        if title ~= nil then
            SendNUIMessage({
                openSection = "sendBill",
                data = {
                    icon = icon,
                    data = data,
                    title = title,
                },
                Ntime = 3500
              })
        end
    end
end