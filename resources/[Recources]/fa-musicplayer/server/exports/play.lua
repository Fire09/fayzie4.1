function PlayUrl(source, name_, url_, volume_, loop_)
    TriggerClientEvent("fa-musicplayer:stateSound", source, "play", {
        soundId = name_,
        url = url_,
        volume = volume_,
        loop = loop_
    })
end

exports('PlayUrl', PlayUrl)

function PlayUrlPos(source, name_, url_, volume_, pos, loop_)
    TriggerClientEvent("fa-musicplayer:stateSound", source, "playpos", {
        soundId = name_,
        position = pos,
        url = url_,
        volume = volume_,
        loop = loop_
    })
end

exports('PlayUrlPos', PlayUrlPos)

function TextToSpeech(source, name_, lang, text, volume_, loop_)
    TriggerClientEvent("fa-musicplayer:stateSound", source, "texttospeech", {
        soundId = name_,
        url = text,
        lang = lang,
        volume = volume_,
        loop = loop_
    })
end

exports('TextToSpeech', TextToSpeech)

function TextToSpeechPos(source, name_, lang, text, volume_, pos, loop_)
    TriggerClientEvent("fa-musicplayer:stateSound", source, "texttospeechpos", {
        soundId = name_,
        lang = lang,
        position = pos,
        url = text,
        volume = volume_,
        loop = loop_
    })
end

exports('TextToSpeechPos', TextToSpeechPos)



RegisterServerEvent("vanilla:request:song:sv", function(url)
    local Speaker3 = vector3(118.59310150146, -1280.6759033203, 28.260183334351)
    TriggerClientEvent("play:song", -1, url, Speaker3, "VU")
    local data = {
        soundId = "VU",
        distance =  22,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("vanilla:change:volume", function(volume)
    local Speaker3 = vector3(118.59310150146, -1280.6759033203, 28.260183334351)
    local data = {
        soundId = "VU",
        volume =  volume/100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("bahamas:request:song:sv", function(url)
    local Speaker3 = vector3(-1379.6644287109, -627.27758789062, 29.926954269409)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BH")
    local data = {
        soundId = "BH",
        distance =  40,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("bahamas:change:volume", function(volume)
    local Speaker3 = vector3(-1379.6644287109, -627.27758789062, 29.926954269409)
    local data = {
        soundId = "BH",
        volume =  volume/100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("casino:request:song:sv", function(url)
    local Speaker3 = vector3(1119.3299560547, 237.28546142578, -49.788967132568)
    TriggerClientEvent("play:song", -1, url, Speaker3, "CS")
    local data = {
        soundId = "CS",
        distance =  100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("casino:change:volume", function(volume)
    local Speaker3 = vector3(1119.3299560547, 237.28546142578, -49.788967132568)
    local data = {
        soundId = "CS",
        volume =  volume/100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("arcade:request:song:sv", function(url)
    local Speaker3 = vector3(736.33087158203, -822.54254150391, 22.667432785034)
    TriggerClientEvent("play:song", -1, url, Speaker3, "CS")
    local data = {
        soundId = "CS",
        distance =  100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "distance", data)
end)

RegisterServerEvent("arcade:change:volume", function(volume)
    local Speaker3 = vector3(736.33087158203, -822.54254150391, 22.667432785034)
    local data = {
        soundId = "CS",
        volume =  volume/100,
    }
    TriggerClientEvent("fa-musicplayer:stateSound", -1, "volume", data)
end)

