/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { InitDebug } from "./debug";
import { InitAPI } from "./api";

export async function Init(): Promise<void> {
    await InitDebug();
    await InitAPI();
}