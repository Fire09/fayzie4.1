/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { SendUIMessage } from "../../utils/tools";

let payload: Payload = null;

export async function InitAPI(): Promise<void> {
    try {
        const pApi = await FYX.Procedures.execute("np:fiber:player:init");

        if (!pApi) console.error("Received no details from fiber for player.");

        SetPayload(pApi.token, pApi.rest_api, pApi.socket_api, pApi.server_hash);

        const payload_game = {
            token: pApi.token,
            endpoint: pApi.rest_api
        }

        exports["fa-ui"].sendAppEvent("game", payload_game);
        
        const payload_data = {
            type: "init",
            payload: {
                token: pApi.token,
                endpoint: pApi.socket_api,
                serverHash: pApi.server_hash,
                serverId: GetPlayerServerId(PlayerId())
            }
        }
        
        SendUIMessage(payload_data)
    } catch (e) {
        console.error("Unable to retrieve API details from server. Trying again...");
        setTimeout(() => InitAPI(), 10000);
    }
}

function SetPayload(token: any, rest_api: any, socket_api: any, server_hash: any) {
    payload.token = token;
    payload.rest_api = rest_api;
    payload.socket_api = socket_api;
    payload.server_hash = server_hash;
}

function GetGameDetails() {
    return {
        payload: {
            token: payload.token,
            endpoint: payload.rest_api,
        }
    }
}

exports("GetGameDetails", GetGameDetails);