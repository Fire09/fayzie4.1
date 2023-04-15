let playerList = {};
playerList["Disconnected"] = [];

RPC.register("pnp:admin:isAdmin", async() => {
    const src = source
    const userRank = exports["fa-lib"].getUserRank(src)
    if (typeof userRank !== "string") {
        return false
    }

    const defaultPower = exports["fa-admin"].getRank("user");
    const userPower = exports["fa-admin"].getRank(userRank);

    if (userPower > defaultPower) {
        return true
    }

    return false
});

RPC.register("pnp:admin:getCommandUI", async() => {
    const src = source
    return exports["fa-admin"].getCommandUI(src)
});

RPC.register("pnp:admin:getVehicleInfo", async(pVin) => {
    let data = SQL.execute("SELECT * FROM characters_cars WHERE vin = ?", pVin)
    if (data.vin) {
        return data
    } else {
        return
    }
});

RPC.register("pnp:admin:runCommandFromClient", function(pAction, pData) {
    const src = source
    exports["fa-admin"].runCommandFromClient(src, pAction, pData);
    return true
});

RPC.register("fa-admin:getValidLicenses", async() => {
    return exports["fa-admin"].getValidLicenses()
});

RPC.register("pnp:admin:getPlayerList", async() => {
    playerList["CurrentPlayers"] = exports["fa-admin"].getCurrentPlayers();

    playerList["Banned"] = [
        {
            from: "01/01/2022",
            until: "12/12/2023",
            admin: "Admin Name",
            name: "Player Name",
            SteamID: "Player Steam ID",
            Reason: "Example Reason",
        }
    ];

    return playerList
});

RPC.register("pnp:admin:getDefinedNames", async(pDefinedNames) => {
    return exports["fa-admin"].getDefinedNames(pDefinedNames)
});

RPC.register("pnp:admin:getPlayerLogs", async(pData) => {
    return exports["fa-log"].getPlayerLogs(pData)
});

RPC.register("pnp:admin:triggerLogFromClient", async(pLog, pResponseData) => {
    
});

RPC.register("pnp:admin:getUserData", async() => {
    let pPlayerId = source
    if (pPlayerId > 0) {
        let user = exports["fa-lib"].getCharacter(pPlayerId)
        let steamId = exports["fa-lib"].getUserVar(pPlayerId)

        let data = {
            name:  user.first_name + " " + user.last_name,
            steamid: steamId,
            cid: user.id,
            cash: user.cash,
        }
        return data
    }  
    return false
});

onNet("playerDropped", async () => {
    let src = source
    const user = exports["fa-lib"].getCharacter(src)
    let steamId = exports["fa-lib"].getUserVar(pPlayerId)

    playerList["Disconnected"].push({
        name: GetPlayerName(src),
        serverID: src,
        SteamID: steamId,
        charID: user.id,
        charName: user.first_name + " " + user.last_name || "No Character Name",
        queueType: "Regular",
    })
});
