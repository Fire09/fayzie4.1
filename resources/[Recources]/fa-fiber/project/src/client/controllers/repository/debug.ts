/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { RegisterUICallbackType, SendUIMessage } from "../../utils/tools";

let display = false;
let devMode = false;

export async function InitDebug() {}

on("fa-admin:currentDevmode", /*679*/ async (pDevmode: boolean) => {
    const isDev = await FYX.Procedures.execute("fa-fiber:verify:userRank", "dev");

    if (isDev !== true) return;

    devMode = pDevmode;
});

RegisterUICallbackType("np:fiber:api:setState", /*545*/ (state: any, cb) => {
    display = state.active;

    const status = {
        voipStatus: display
    };
    
    exports["fa-ui"].sendAppEvent("hud", status);
 
    cb({ data: [], meta: { ok: true, message: '' } });
});

RegisterCommand("fiberToggleDebug", /*595*/ () => {
    if (!devMode) return;
    
    const data = {
        "type": "debug",
        "payload": {}
    };

    SendUIMessage(data);
}, false);