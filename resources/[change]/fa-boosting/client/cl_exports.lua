function SendUIMessage(data)
    SendNUIMessage(data)
end

function openApplication(app, data)
  SendUIMessage({
      action = "openApplication",
      app = app,
      show = true,
  })
end

exports("openApplication", openApplication)

function closeApplication(app, data)
  SendUIMessage({
      app = app,
      show = false,
      data = data or {},
  })
end

exports("closeApplication", closeApplication)

function sendAppEvent(app, data)
    SendUIMessage({
        action = "UpdateValueUI",
        app = app,
        data = data
    })
end

exports("sendAppEvent", sendAppEvent)


