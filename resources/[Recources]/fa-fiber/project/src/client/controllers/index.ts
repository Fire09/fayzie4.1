/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { InitEvents } from "./events";
import { InitEntity } from "./entity";
import * as Repository from "./repository";

export async function Init(): Promise<void> {
    await InitEvents();
    await InitEntity();
    await Repository.Init();
}