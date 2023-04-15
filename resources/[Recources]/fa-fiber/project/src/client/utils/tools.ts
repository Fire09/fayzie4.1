/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

export function RegisterUICallbackType(name: string, fn: any) {
    RegisterNuiCallbackType(name)
    on(`__cfx_nui:${name}`, fn);
}

export function SendUIMessage(jsonString: string | {}) {
    SendNuiMessage(JSON.stringify(jsonString));
}