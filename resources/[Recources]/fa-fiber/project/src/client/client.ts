/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import * as Controllers from './controllers';

on("onClientResourceStop", (resource: string) => {
    emitNet("baseevents:hotreload", resource);
});

const ResName = GetCurrentResourceName();

on("onClientResourceStart", async (resource: string) => {
    if (resource !== ResName) return;
    await Controllers.Init();
});