/*************************************************/
/****            FREE fa-FIBER 2.1            ****/
/*** Author: Seter#0909 | Project: NoPicks 3.5 ***/
/****      https://discord.gg/QZ4XAPUVps      ****/
/*************************************************/

import { Delay } from "../../shared/utils/tools";

var playerState: PlayerState;

export async function InitEntity() {}

FYX.Events.addHook("active", /*575*/ async () => {
    if (playerState.hasSpawned) {
        entity_updateStatus(
            {
                checks: {
                    invisible: await entity_isInvisible(PlayerPedId()),
                    invincible: await entity_state(PlayerId()),
                    spectating: await entity_isPlayerSpectating(PlayerId()),
                    noclip: await entity_isInvisible(PlayerPedId()) && await entity_state(PlayerId()),
                    infiniteArmor: await entity_armour(PlayerPedId()),
                    infiniteHealth: await entity_health(PlayerPedId(), GetEntityModel(PlayerPedId())),
                }
            }
        );
    }
});

async function entity_isInvisible(pEntity: number): Promise<boolean> {
    if (IsEntityVisible(pEntity)) return false;

    if (playerState.onEditor) return false;

    return true;
}

async function entity_state(player: number) {
    if (!GetPlayerInvincible(player)) return false;
    
    if (playerState.isDead) return false;

    return true;
}

async function entity_isPlayerSpectating(pId: number) {
    return !!NetworkIsInSpectatorMode();
}

async function entity_health(pEntity: number, pModel: number) {
    const entityHealth = GetEntityHealth(pEntity);

    if (entityHealth > 200) return true;
    SetEntityHealth(pEntity, entityHealth - 2);
    await Delay(25);

    return SetEntityHealth(pEntity, entityHealth + 2);
}

async function entity_armour(pPed: number) {
    const entityArmour = GetPedArmour(pPed);

    if (entityArmour > 200) return true;
    SetPedArmour(pPed, entityArmour - 2);
    await Delay(25);

    return SetPedArmour(pPed, entityArmour + 2);
}

async function entity_updateStatus(pObject: any) {
    let status = false;

    const playerData = ['invisible', 'invincible', 'noclip', 'infiniteArmor', 'infiniteHealth'];

    for (const [o1, o2] of Object.entries(pObject)) {
        if (o2 && !playerData.includes(o1)) {
            status = true;
            break;
        }
    }

    if (status !== true) return;

    emitNet("fa-fiber:updatePhoneStatus" /*633*/, "playerChecks" /*626*/, pObject);
}