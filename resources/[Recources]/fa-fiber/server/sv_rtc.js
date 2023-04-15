let USE_VOICE_RTC = true;
let ActiveConnections = [];

RegisterServerEvent("pnp:fiber:startCall:phone")
onNet("pnp:fiber:startCall:phone", async (caller,calling,RTCInfo) => {
    emitNet("pnp:fiber:startCall", calling, caller, RTCInfo)
    ActiveConnections[RTCInfo] == true;
});

RegisterServerEvent("pnp:fiber:stopCall:phone")
onNet("pnp:fiber:stopCall:phone", async (caller,calling,RTCInfo) => {
    emitNet("pnp:fiber:stopCall", calling, caller, RTCInfo)
    emitNet("pnp:fiber:stopCall", caller, calling, RTCInfo)
    ActiveConnections[RTCInfo] == null;
});

FYX.Procedures.register("fa-fiber:verify:userRank", async(src, pRank) => {
    let rank = exports['fa-lib'].getUserRank(src)

    if (rank == pRank) {
        return true
    } else {
        return false
    }
})

// FYX.Procedures.register("pnp:fiber:player:init", async(src) => {
//     return []
// })