/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { Delay } from "../../shared/utils/tools";

var playerState: PlayerState;

export async function InitEvents() {
    emitNet('fa-fiber:phoneAPIReady');
    await FYX.Events.start();
    await netSession();
}

// // Test State
// export const playerState = {
//     hasSpawned: false, // 640
//     onEditor: true,  // 478
//     isDead: false, // 669
// } /*size=1787*/;

playerState.hasSpawned = false;
playerState.isDead = false;
playerState.onEditor = true;

on("pd:deathcheck", /*503*/ () => {
    playerState.isDead = !playerState.isDead;
});

on("fa-spawn:characterSpawned", /*548*/ () => {
    setTimeout((/*562*/) => {
        playerState.hasSpawned = true;
    }, 5000);
});

on("fa-base:spawnInitialized", /*582*/ () => {
    const playerCoords = GetEntityCoords(PlayerPedId(), false);
    
    const playerDistance = GetDistanceBetweenCoords(-682.0, -1092.0, 200.0, playerCoords[0], playerCoords[1], playerCoords[2], true);

    if (playerDistance > 100) return;

    playerState.hasSpawned = false;
});

onNet("fa-editor:loadEditor", /*603*/ () => {
    return {
        'serverId': GetPlayerServerId(PlayerId()),
        'characterId': exports['isPed'].isPed('cid'),
        'firstName': exports['isPed'].isPed('firstname'),
        'lastName': exports['isPed'].isPed('lastname'),
        'phoneNumber': exports['isPed'].isPed('phone_number')
    };
});

onNet("fa-editor:closeEditor", /*623*/ () => {
    playerState.onEditor = false;
});

on("fa-fiber:hotreload", /*659*/ (a1) => {
    if (a1 === undefined || a1 === 0) return;

    playerState.hasSpawned = true;
    playerState.isDead = exports['isPed'].isPed('dead');
});

async function netSession() {
    return new Promise<void>(async resolve => {
        while (!NetworkIsSessionStarted()) {
            await Delay(100);
        }

        resolve();
    });
}