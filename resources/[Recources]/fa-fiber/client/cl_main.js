/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

!function(e){var t={};function n(i){if(t[i])return t[i].exports;var r=t[i]={i:i,l:!1,exports:{}};return e[i].call(r.exports,r,r.exports,n),r.l=!0,r.exports}n.m=e,n.c=t,n.d=function(e,t,i){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:i})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var i=Object.create(null);if(n.r(i),Object.defineProperty(i,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)n.d(i,r,function(t){return e[t]}.bind(null,r));return i},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="",n(n.s=0)}([function(e,t,n){"use strict";async function i(e){return new Promise(t=>setTimeout(()=>t(),e))}async function r(){emitNet("fa-fiber:phoneAPIReady"),await FYX.Events.start(),await async function(){return new Promise(async e=>{for(;!NetworkIsSessionStarted();)await i(100);e()})}()}async function a(e){return!IsEntityVisible(e)&&!(void 0).onEditor}async function o(e){return!!GetPlayerInvincible(e)&&!(void 0).isDead}async function s(e){return!!NetworkIsInSpectatorMode()}async function d(e,t){const n=GetEntityHealth(e);return n>200||(SetEntityHealth(e,n-2),await i(25),SetEntityHealth(e,n+2))}async function c(e){const t=GetPedArmour(e);return t>200||(SetPedArmour(e,t-2),await i(25),SetPedArmour(e,t+2))}function u(e){SendNuiMessage(JSON.stringify(e))}n.r(t),(void 0).hasSpawned=!1,(void 0).isDead=!1,(void 0).onEditor=!0,on("pd:deathcheck",()=>{(void 0).isDead=!(void 0).isDead}),on("fa-spawn:characterSpawned",()=>{setTimeout(()=>{(void 0).hasSpawned=!0},5e3)}),on("fa-base:spawnInitialized",()=>{const e=GetEntityCoords(PlayerPedId(),!1);GetDistanceBetweenCoords(-682,-1092,200,e[0],e[1],e[2],!0)>100||((void 0).hasSpawned=!1)}),onNet("fa-editor:loadEditor",()=>({serverId:GetPlayerServerId(PlayerId()),characterId:exports.isPed.isPed("cid"),firstName:exports.isPed.isPed("firstname"),lastName:exports.isPed.isPed("lastname"),phoneNumber:exports.isPed.isPed("phone_number")})),onNet("fa-editor:closeEditor",()=>{(void 0).onEditor=!1}),on("fa-fiber:hotreload",e=>{void 0!==e&&0!==e&&((void 0).hasSpawned=!0,(void 0).isDead=exports.isPed.isPed("dead"))}),FYX.Events.addHook("active",async()=>{(void 0).hasSpawned&&async function(e){let t=!1;const n=["invisible","invincible","noclip","infiniteArmor","infiniteHealth"];for(const[i,r]of Object.entries(e))if(r&&!n.includes(i)){t=!0;break}if(!0!==t)return;emitNet("fa-fiber:updatePhoneStatus","playerChecks",e)}({checks:{invisible:await a(PlayerPedId()),invincible:await o(PlayerId()),spectating:await s(PlayerId()),noclip:await a(PlayerPedId())&&await o(PlayerId()),infiniteArmor:await c(PlayerPedId()),infiniteHealth:await d(PlayerPedId(),GetEntityModel(PlayerPedId()))}})});let l=!1,p=!1;var f,y;on("fa-admin:currentDevmode",async e=>{!0===await FYX.Procedures.execute("fa-fiber:verify:userRank","dev")&&(p=e)}),f="np:fiber:api:setState",y=(e,t)=>{l=e.active;const n={voipStatus:l};exports["fa-ui"].sendAppEvent("hud",n),t({data:[],meta:{ok:!0,message:""}})},RegisterNuiCallbackType(f),on(`__cfx_nui:${f}`,y),RegisterCommand("fiberToggleDebug",()=>{if(!p)return;u({type:"debug",payload:{}})},!1);async function v(){try{const r=await FYX.Procedures.execute("np:fiber:player:init");r||console.error("Received no details from fiber for player."),e=r.token,t=r.rest_api,n=r.socket_api,i=r.server_hash,null.token=e,null.rest_api=t,null.socket_api=n,null.server_hash=i;const a={token:r.token,endpoint:r.rest_api};exports["fa-ui"].sendAppEvent("game",a),u({type:"init",payload:{token:r.token,endpoint:r.socket_api,serverHash:r.server_hash,serverId:GetPlayerServerId(PlayerId())}})}catch(e){console.error("Unable to retrieve API details from server. Trying again..."),setTimeout(()=>v(),1e4)}var e,t,n,i}async function P(){await r(),await async function(){}(),await async function(){await async function(){}(),await v()}()}exports("GetGameDetails",(function(){return{payload:{token:null.token,endpoint:null.rest_api}}})),on("onClientResourceStop",e=>{emitNet("baseevents:hotreload",e)});const b=GetCurrentResourceName();on("onClientResourceStart",async e=>{e===b&&await P()})}]);