/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	// The require scope
/******/ 	var __webpack_require__ = {};
/******/
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/
/************************************************************************/
var __webpack_exports__ = {};

// NAMESPACE OBJECT: ./src/client/skills/index.ts
var skills_namespaceObject = {};
__webpack_require__.r(skills_namespaceObject);
__webpack_require__.d(skills_namespaceObject, {
  "attack": () => (attack),
  "bark": () => (bark),
  "beg": () => (beg),
  "follow": () => (follow),
  "graze": () => (graze),
  "howl": () => (howl),
  "laydown": () => (laydown),
  "move": () => (move),
  "paw": () => (paw),
  "peck": () => (peck),
  "pet": () => (pet),
  "playdead": () => (playdead),
  "sit": () => (sit),
  "stretch": () => (stretch),
  "taunt": () => (taunt),
  "vehicle": () => (vehicle),
  "wander": () => (wander),
  "watch": () => (watch)
});

// CONCATENATED MODULE: ./src/client/lib/cameraToWorld.ts
/* harmony default export */ const cameraToWorld = ((flags, ignore) => {
    const cameraCoord = GetGameplayCamCoord();
    const [rx, , rz] = GetGameplayCamRot(0).map((r) => Math.PI / 180 * r);
    const direction = [
        -Math.sin(rz) * Math.abs(Math.cos(rx)),
        Math.cos(rz) * Math.abs(Math.cos(rx)),
        Math.sin(rx)
    ];
    const from = direction.map((direction, i) => cameraCoord[i] + direction);
    const to = direction.map((direction, i) => cameraCoord[i] + direction * 100);
    const shapeTest = StartShapeTestSweptSphere(from[0], from[1], from[2], to[0], to[1], to[2], 0.2, flags, ignore, 4);
    //const shapeTest = StartExpensiveSynchronousShapeTestLosProbe(cameraCoord[0], cameraCoord[1], cameraCoord[2], destination[0], destination[1], destination[2], flags, ignore, 4);
    return GetShapeTestResult(shapeTest);
});

// CONCATENATED MODULE: ./src/client/lib/vector3.ts
// Never reuse this. It's nasty as hell.
// imma pretend I was drunk when I wrote this
const vector3 = (x, y, z) => {
    if (typeof x === 'object') {
        return x;
    }
    else {
        y = y !== undefined ? y : x;
        z = z !== undefined ? z : x;
    }
    return {
        with: (c) => c(vector3(x, y, z)),
        add: (...v) => vector3(...v).with(({ x: x2, y: y2, z: z2 }) => vector3(x + x2, y + y2, z + z2)),
        sub: (...v) => vector3(...v).with(({ x: x2, y: y2, z: z2 }) => vector3(x - x2, y - y2, z - z2)),
        mul: (...v) => vector3(...v).with(({ x: x2, y: y2, z: z2 }) => vector3(x * x2, y * y2, z * z2)),
        direction: () => {
            const _z = (z * Math.PI) / 180.0;
            const _x = (x * Math.PI) / 180.0;
            const num = Math.abs(Math.cos(_x));
            return vector3(-Math.sin(_z) * num, Math.cos(_z) * num, Math.sin(_x));
        },
        x,
        y,
        z
    };
};
/* harmony default export */ const lib_vector3 = (vector3);

// CONCATENATED MODULE: ./src/client/interaction.ts


/* harmony default export */ const interaction = ((onSelectionChanged) => {
    let selecting = false;
    let objectWhitelist = [];
    let selectedEntity = null;
    let selectedEntityType = null;
    let selectedEntityModel = null;
    let selectedEntityDimensions = null;
    let selectedPosition = null;
    const deselect = () => {
        selectedEntity = selectedEntityDimensions = selectedPosition = selectedEntityType = selectedEntityModel = null;
        onSelectionChanged();
    };
    const draw = () => {
        if (selectedEntity) {
            const [x, y, z] = GetEntityCoords(selectedEntity, true);
            const [gotGround, ground] = GetGroundZFor_3dCoord(x, y + 1, z, false);
            const [[minX, minY], [maxX, maxY]] = selectedEntityDimensions;
            const size = Math.min(maxX - minX, maxY - minY) * 1.4;
            DrawMarker(1, x, y, gotGround ? ground : z, 0, 0, 0, 0, 0, 0, size, size, 0.4, 0, 255, 0, 150, false, false, 2, false, null, null, false);
            return;
        }
        if (selectedPosition) {
            const { x, y, z } = selectedPosition;
            DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.3, 0, 0, 255, 150, false, false, 2, false, null, null, false);
        }
    };
    const update = () => {
        if (selectedEntity && (!DoesEntityExist(selectedEntity) || GetEntityHealth(selectedEntity) <= 0)) {
            deselect();
        }
        if (!selecting) {
            return;
        }
        const [retval, hit, endCoords, , entityHit] = cameraToWorld(-1, PlayerPedId());
        if (retval && hit) {
            const entityType = GetEntityType(entityHit);
            const entityModel = entityType > 0 ? GetEntityModel(entityHit) : null;
            const entitySelected = entityType === 1 || entityType === 2 || (entityType === 3 && objectWhitelist.includes(entityModel));
            selectedEntity = entitySelected ? entityHit : null;
            selectedEntityType = selectedEntity ? entityType : null;
            selectedEntityDimensions = selectedEntity ? GetModelDimensions(entityModel) : null;
            selectedPosition = selectedEntity ? null : lib_vector3(...endCoords);
            selectedEntityModel = selectedEntity ? entityModel : null;
        }
    };
    const startSelecting = (_objectWhitelist = []) => {
        selecting = true;
        objectWhitelist = _objectWhitelist;
    };
    const stopSelecting = () => {
        selecting = false;
        onSelectionChanged();
    };
    return {
        startSelecting,
        stopSelecting,
        deselect,
        draw,
        update,
        getSelectedEntity: () => selectedEntity,
        getSelectedEntityType: () => selectedEntityType,
        getSelectedPosition: () => selectedPosition,
        getSelectedEntityDimensions: () => selectedEntityDimensions,
        getSelectedEntityModel: () => selectedEntityModel
    };
});

// CONCATENATED MODULE: ./src/client/lib/animLookup.ts
const DOG_GENERIC = {
    sit: {
        dictionary: "creatures@rottweiler@amb@world_dog_sitting@base",
        anim: "base",
        exitDictionary: "creatures@rottweiler@amb@world_dog_sitting@exit",
        exitAnim: "exit"
    },
    bark: {
        dictionary: "creatures@rottweiler@amb@world_dog_barking@idle_a",
        anim: "idle_a",
        exitDictionary: "creatures@rottweiler@amb@world_dog_barking@exit",
        exitAnim: "exit"
    },
    laydown: {
        dictionary: "creatures@rottweiler@amb@sleep_in_kennel@",
        anim: "sleep_in_kennel",
        exitDictionary: "creatures@rottweiler@amb@sleep_in_kennel@",
        exitAnim: "exit_kennel"
    },
    beg: {
        dictionary: "creatures@rottweiler@tricks@",
        anim: "beg_loop",
        exitDictionary: "creatures@rottweiler@tricks@",
        exitAnim: "beg_exit"
    },
    taunt: {
        dictionary: "creatures@rottweiler@melee@streamed_taunts@",
        anim: "taunt_02"
    },
    paw: {
        dictionary: "creatures@rottweiler@tricks@",
        anim: "paw_right_enter",
        exitDictionary: "creatures@rottweiler@tricks@",
        exitAnim: "paw_right_exit"
    },
    pet: {
        dictionary: "creatures@rottweiler@tricks@",
        anim: "petting_chop"
    },
    playdead: {
        dictionary: "creatures@rottweiler@move",
        anim: "dying",
        exitDictionary: "creatures@rottweiler@amb@world_dog_sitting@exit",
        exitAnim: "exit"
    }
};
const DOG_SMALL = {
    bark: {
        dictionary: "creatures@pug@amb@world_dog_barking@idle_a",
        anim: "idle_a",
        exitDictionary: "creatures@pug@amb@world_dog_barking@exit",
        exitAnim: "exit"
    },
    sit: {
        dictionary: "creatures@pug@amb@world_dog_sitting@base",
        anim: "base",
        exitDictionary: "creatures@pug@amb@world_dog_sitting@exit",
        exitAnim: "exit"
    },
    playdead: {
        dictionary: "creatures@pug@move",
        anim: "dying",
        exitDictionary: "creatures@pug@amb@world_dog_sitting@exit",
        exitAnim: "exit"
    }
};
const BIG_CAT = {
    laydown: {
        dictionary: "creatures@cougar@amb@world_cougar_rest@base",
        anim: "base",
        exitDictionary: "creatures@cougar@amb@world_cougar_rest@exit",
        exitAnim: "exit"
    },
    taunt: {
        dictionary: "creatures@cougar@melee@",
        anim: "growling",
    }
};
/* harmony default export */ const animLookup = ({
    [GetHashKey("a_c_rottweiler")]: DOG_GENERIC,
    [GetHashKey("a_c_chop")]: DOG_GENERIC,
    [GetHashKey("a_c_retriever")]: {
        ...DOG_GENERIC,
        bark: {
            dictionary: "creatures@retriever@amb@world_dog_barking@idle_a",
            anim: "idle_a",
            exitDictionary: "creatures@retriever@amb@world_dog_barking@exit",
            exitAnim: "exit"
        },
        playdead: {
            dictionary: "creatures@retriever@move",
            anim: "dying",
            exitDictionary: "creatures@retriever@getup",
            exitAnim: "getup_l"
        },
    },
    [GetHashKey("a_c_retriever_np")]: {
        ...DOG_GENERIC,
        bark: {
            dictionary: "creatures@retriever@amb@world_dog_barking@idle_a",
            anim: "idle_a",
            exitDictionary: "creatures@retriever@amb@world_dog_barking@exit",
            exitAnim: "exit"
        },
        playdead: {
            dictionary: "creatures@retriever@move",
            anim: "dying",
            exitDictionary: "creatures@retriever@getup",
            exitAnim: "getup_l"
        },
    },
    [GetHashKey("a_c_husky")]: DOG_GENERIC,
    [GetHashKey("a_c_husky_2")]: DOG_GENERIC,
    [GetHashKey("a_c_husky_np")]: DOG_GENERIC,
    [GetHashKey("a_c_shepherd")]: DOG_GENERIC,
    [GetHashKey("a_c_shepherd_np")]: DOG_GENERIC,
    [GetHashKey("a_c_pit_np")]: DOG_GENERIC,
    [GetHashKey("a_c_pug")]: DOG_SMALL,
    [GetHashKey("a_c_poodle")]: DOG_SMALL,
    [GetHashKey("a_c_westy")]: DOG_SMALL,
    [GetHashKey("a_c_cat_01")]: {
        laydown: {
            dictionary: "creatures@cat@amb@world_cat_sleeping_ground@base",
            anim: "base",
            exitDictionary: "creatures@cat@amb@world_cat_sleeping_ground@exit",
            exitAnim: "exit"
        },
        stretch: {
            dictionary: "creatures@cat@amb@peyote@enter",
            anim: "enter",
            exitDictionary: "creatures@cat@amb@world_cat_sleeping_ledge@exit",
            exitAnim: "exit"
        },
        sitCar: {
            dictionary: "creatures@cat@amb@world_cat_sleeping_ledge@base",
            anim: "base",
            exitDictionary: "creatures@cat@amb@world_cat_sleeping_ledge@exit",
            exitAnim: "exit"
        }
    },
    [GetHashKey("a_c_mtlion")]: BIG_CAT,
    [GetHashKey("a_c_panther")]: BIG_CAT,
    [GetHashKey("a_c_coyote")]: {
        ...BIG_CAT,
        howl: {
            dictionary: "creatures@coyote@amb@world_coyote_howl@idle_a",
            anim: "idle_a",
            exitDictionary: "creatures@coyote@amb@world_coyote_howl@exit",
            exitAnim: "exit"
        }
    },
    [GetHashKey("a_c_hen")]: {
        peck: {
            dictionary: "creatures@hen@amb@world_hen_pecking@base",
            anim: "base",
            exitDictionary: "creatures@hen@amb@world_hen_pecking@exit",
            exitAnim: "exit"
        },
        sitCar: {
            dictionary: "creatures@hen@amb@world_hen_standing@base",
            anim: "base"
        }
    },
    [GetHashKey("a_c_cow")]: {
        graze: {
            dictionary: "creatures@cow@amb@world_cow_grazing@base",
            anim: "base",
            exitDictionary: "creatures@cow@amb@world_cow_grazing@exit",
            exitAnim: "exit"
        }
    },
    [GetHashKey("a_c_pig")]: {
        graze: {
            dictionary: "creatures@pig@amb@world_pig_grazing@base",
            anim: "base",
            exitDictionary: "creatures@pig@amb@world_pig_grazing@exit",
            exitAnim: "exit"
        },
        sitCar: {
            dictionary: "creatures@pig@move",
            anim: "idle"
        }
    },
    [GetHashKey("a_c_rat")]: {
        sitCar: {
            dictionary: "creatures@rat@move",
            anim: "idle"
        }
    },
    [GetHashKey("a_c_rabbit_01")]: {
        sitCar: {
            dictionary: "creatures@rabbit@amb@world_rabbit_eating@exit",
            anim: "exit"
        }
    }
});

// CONCATENATED MODULE: ./src/client/skills/helper/genericAnimation.ts

const isViable = (pedId, interaction) => !!pedId;
const playExitAnimation = async (pedId, exitDictionary, exitAnim) => {
    RequestAnimDict(exitDictionary);
    let bail = 0;
    while (!HasAnimDictLoaded(exitDictionary) && bail++ < 50) {
        await new Promise((res) => setTimeout(res, 10));
    }
    TaskPlayAnim(pedId, exitDictionary, exitAnim, 2.7, 2.7, 1000, 2, 0, false, false, false);
    await new Promise((res) => setTimeout(res, 100));
    while (IsEntityPlayingAnim(pedId, exitDictionary, exitAnim, 3)) {
        await new Promise((res) => setTimeout(res, 200));
    }
};
/* harmony default export */ const genericAnimation = ((id, flags = 2, duration = -1) => ({
    isViable,
    createTask: (companion) => {
        let cancelled = false;
        const pedId = companion.getPedId();
        const model = GetEntityModel(pedId);
        const animationForModel = animLookup[model];
        const perform = () => new Promise(async (res) => {
            if (animationForModel) {
                const animation = animationForModel[id];
                if (animation) {
                    const { dictionary, anim, exitDictionary, exitAnim } = animation;
                    RequestAnimDict(dictionary);
                    let bail = 0;
                    while (!HasAnimDictLoaded(dictionary) && bail++ < 50) {
                        await new Promise((res) => setTimeout(res, 10));
                    }
                    if (!cancelled) {
                        TaskPlayAnim(pedId, dictionary, anim, -1, -1, -1, flags, 0, false, false, false);
                        await new Promise((res) => setTimeout(res, 100));
                        let startTime = Date.now();
                        while (!cancelled && IsEntityPlayingAnim(pedId, dictionary, anim, 3) && (duration === -1 || Date.now() - startTime < duration)) {
                            await new Promise((res) => setTimeout(res, 200));
                        }
                        if (exitDictionary && exitAnim) {
                            await playExitAnimation(pedId, exitDictionary, exitAnim);
                        }
                    }
                    ClearPedTasks(pedId);
                }
            }
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
}));

// CONCATENATED MODULE: ./src/client/skills/attack.ts
const attack_isViable = (pedId, interaction) => {
    const selectedEntity = interaction.getSelectedEntity();
    const selectedEntityType = interaction.getSelectedEntityType();
    return !!pedId && !!selectedEntity && selectedEntityType === 1;
};
const skill = {
    isViable: attack_isViable,
    createTask: (companion, interaction) => {
        let cancelled = false;
        const selectedEntity = interaction.getSelectedEntity();
        const perform = () => new Promise(async (res) => {
            if (selectedEntity) {
                const pedId = companion.getPedId();
                try {
                    SetCanAttackFriendly(pedId, true, false);
                    TaskCombatPed(pedId, selectedEntity, 0, 16);
                    while (!cancelled && GetScriptTaskStatus(pedId, 0x2E85A751) !== 7 && [0, selectedEntity].includes(GetMeleeTargetForPed(pedId))) {
                        await new Promise((res) => setTimeout(res, 100));
                    }
                    SetCanAttackFriendly(pedId, false, false);
                }
                catch (e) {
                    console.error(e);
                }
                ClearPedTasks(pedId);
            }
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const attack = (skill);

// CONCATENATED MODULE: ./src/client/skills/move.ts
const move_isViable = (pedId, interaction, params) => !!pedId && (params || (!!interaction.getSelectedPosition() || !!interaction.getSelectedEntity()));
const move_skill = {
    isViable: move_isViable,
    createTask: (companion, interaction, params = null) => {
        let cancelled = false;
        const selectedEntity = interaction.getSelectedEntity();
        const speedModifier = params === null || params === void 0 ? void 0 : params.speed;
        const speed = companion.getMaxSpeed();
        // a bit ugly to ensure backwards compatibility
        const targetPosition = (params && (params.x !== undefined && params.y !== undefined && params.z !== undefined)) ?
            { x: params.x, y: params.y, z: params.z } :
            interaction.getSelectedPosition();
        const perform = () => new Promise(async (res) => {
            if (speedModifier) {
                companion.setSpeedModifier(speedModifier);
            }
            const pedId = companion.getPedId();
            try {
                if (targetPosition) {
                    const { x, y, z } = targetPosition;
                    TaskFollowNavMeshToCoord(pedId, x, y, z, speed, -1, 0, false, 0);
                    while (GetScriptTaskStatus(pedId, 0x2A89B8A7) !== 7 && !cancelled) {
                        await new Promise((res) => setTimeout(res, 100));
                    }
                }
                else if (selectedEntity !== null) {
                    TaskGoToEntity(pedId, selectedEntity, -1, 2, speed, 0, 0);
                    while (!cancelled) {
                        if (GetScriptTaskStatus(pedId, 0x4924437D) === 7 && !cancelled) {
                            TaskGoToEntity(pedId, selectedEntity, -1, 2, speed, 0, 0);
                        }
                        await new Promise((res) => setTimeout(res, 100));
                    }
                }
            }
            catch (e) {
                console.error(e);
            }
            companion.resetSpeedModifier();
            ClearPedTasks(pedId);
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const move = (move_skill);

// CONCATENATED MODULE: ./src/client/skills/follow.ts
const follow_isViable = (pedId, _interaction) => !!pedId;
const follow_skill = {
    isViable: follow_isViable,
    createTask: (companion) => {
        let cancelled = false;
        const maxSpeed = companion.getMaxSpeed();
        const perform = () => new Promise(async (res) => {
            const pedId = companion.getPedId();
            try {
                TaskGoToEntity(pedId, PlayerPedId(), -1, 3, maxSpeed, 0, 0);
                while (!cancelled) {
                    if (GetScriptTaskStatus(pedId, 0x4924437D) === 7 && !cancelled) {
                        TaskGoToEntity(pedId, PlayerPedId(), -1, 3, maxSpeed, 0, 0);
                    }
                    await new Promise((res) => setTimeout(res, 100));
                }
            }
            catch (e) {
                console.error(e);
            }
            ClearPedTasks(pedId);
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    },
};
/* harmony default export */ const follow = (follow_skill);

// CONCATENATED MODULE: ./src/client/lib/getFreeSeat.ts
/* harmony default export */ const getFreeSeat = ((entity) => {
    let maxSeats = GetVehicleMaxNumberOfPassengers(entity);
    while (maxSeats--) {
        if (IsVehicleSeatFree(entity, maxSeats)) {
            return maxSeats;
        }
    }
    return null;
});

// CONCATENATED MODULE: ./src/client/skills/vehicle.ts


/*
@TODO:
Big cleanup of this. It's become messy since I added this params stuff
*/
const vehicle_isViable = (pedId, interaction, params = null) => {
    if (!params && IsPedInAnyVehicle(PlayerPedId(), false)) {
        params = {
            vehicleId: GetVehiclePedIsIn(PlayerPedId(), false),
            instant: true
        };
    }
    return !!pedId &&
        (interaction.getSelectedEntityType() === 2 || params) &&
        getFreeSeat(interaction.getSelectedEntity() || (params === null || params === void 0 ? void 0 : params.vehicleId)) !== null;
};
const vehicle_skill = {
    isViable: vehicle_isViable,
    createTask: (companion, interaction, params = null) => {
        if (!params && IsPedInAnyVehicle(PlayerPedId(), false)) {
            params = {
                vehicleId: GetVehiclePedIsIn(PlayerPedId(), false),
                instant: false
            };
        }
        let cancelled = false;
        const selectedEntity = interaction.getSelectedEntity() || (params === null || params === void 0 ? void 0 : params.vehicleId);
        const selectedEntityDimensions = interaction.getSelectedEntityDimensions() ?
            interaction.getSelectedEntityDimensions() :
            params && GetModelDimensions(GetEntityModel(params === null || params === void 0 ? void 0 : params.vehicleId));
        const usingParams = !interaction.getSelectedEntity() && params;
        const pedId = companion.getPedId();
        const maxSpeed = companion.getMaxSpeed();
        const perform = () => new Promise(async (res) => {
            var _a, _b, _c;
            if (["a_c_pig", "a_c_cow"].some((model) => GetHashKey(model) === GetEntityModel(pedId))) {
                emit("fa-companions:tooBigForVehicle");
                res();
                return;
            }
            try {
                if (selectedEntity === null || selectedEntityDimensions === null) {
                    res();
                    return;
                }
                const animationForModel = animLookup[GetEntityModel(pedId)];
                const dict = ((_a = animationForModel === null || animationForModel === void 0 ? void 0 : animationForModel.sitCar) === null || _a === void 0 ? void 0 : _a.dictionary) || ((_b = animationForModel === null || animationForModel === void 0 ? void 0 : animationForModel.sit) === null || _b === void 0 ? void 0 : _b.dictionary) || "creatures@rottweiler@in_vehicle@std_car";
                const anim = ((_c = animationForModel === null || animationForModel === void 0 ? void 0 : animationForModel.sitCar) === null || _c === void 0 ? void 0 : _c.anim) || "sit";
                let freeSeat = getFreeSeat(selectedEntity);
                const [[minX, minY], [maxX, maxY]] = selectedEntityDimensions;
                const maxSize = Math.max(maxX - minX, maxY - minY);
                if (freeSeat !== null) {
                    if (!usingParams || !(params === null || params === void 0 ? void 0 : params.instant)) {
                        TaskGoToEntity(pedId, selectedEntity, 5000, maxSize, maxSpeed, 0, 0);
                        while (GetScriptTaskStatus(pedId, 0x4924437D) !== 7 && !cancelled) {
                            await new Promise((res) => setTimeout(res, 100));
                        }
                    }
                    freeSeat = getFreeSeat(selectedEntity);
                    if (freeSeat !== null) {
                        let bail = 0;
                        while (!IsPedInAnyVehicle(pedId, true) && bail++ < 5) {
                            freeSeat = getFreeSeat(selectedEntity);
                            TaskWarpPedIntoVehicle(pedId, selectedEntity, freeSeat);
                            await new Promise((res) => setTimeout(res, 10));
                        }
                        RequestAnimDict(dict);
                        await new Promise((res) => setTimeout(res, 1000));
                        while (!HasAnimDictLoaded(dict)) {
                            await new Promise((res) => setTimeout(res, 100));
                        }
                        if (!cancelled) {
                            TaskPlayAnim(pedId, dict, anim, 8.0, -8.0, -1, 2, 0.0, false, false, false);
                            await new Promise((res) => setTimeout(res, 100));
                        }
                        while (!cancelled && IsPedInAnyVehicle(pedId, false)) {
                            await new Promise((res) => setTimeout(res, 100));
                        }
                        if (IsPedInAnyVehicle(pedId, false)) {
                            const [x, y, z] = GetEntryPositionOfDoor(selectedEntity, freeSeat);
                            SetEntityCoords(pedId, x, y, z, true, false, false, false);
                            TaskPlayAnim(pedId, dict, "get_out", 8.0, -8.0, -1, 2, 0.0, false, false, false);
                            await new Promise((res) => setTimeout(res, 100));
                        }
                    }
                }
            }
            catch (e) {
                console.error(e);
            }
            ClearPedTasks(pedId);
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const vehicle = (vehicle_skill);

// CONCATENATED MODULE: ./src/client/skills/wander.ts
const wander_isViable = (pedId) => !!pedId;
const wander_skill = {
    isViable: wander_isViable,
    createTask: (companion) => {
        let cancelled = false;
        const pedId = companion.getPedId();
        const perform = () => new Promise(async (res) => {
            if (!wander_isViable(pedId)) {
                res();
                return;
            }
            try {
                const [x, y, z] = GetEntityCoords(PlayerPedId(), true);
                TaskWanderInArea(pedId, x, y, z, 15, 3, 10);
                while (!cancelled && GetScriptTaskStatus(pedId, 0x370BCF53) !== 7) {
                    await new Promise((res) => setTimeout(res, 100));
                }
            }
            catch (e) {
                console.error(e);
            }
            ClearPedTasks(pedId);
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const wander = (wander_skill);

// CONCATENATED MODULE: ./src/client/skills/watch.ts
const watch_isViable = (pedId, interaction) => {
    const selectedEntity = interaction.getSelectedEntity();
    return !!pedId && !!selectedEntity;
};
const watch_skill = {
    isViable: watch_isViable,
    createTask: (companion, interaction) => {
        let cancelled = false;
        const pedId = companion.getPedId();
        const selectedEntity = interaction.getSelectedEntity();
        const perform = () => new Promise(async (res) => {
            if (!watch_isViable(pedId, interaction)) {
                res();
                return;
            }
            try {
                TaskTurnPedToFaceEntity(pedId, selectedEntity, -1);
                while (!cancelled && GetScriptTaskStatus(pedId, 0xCBCE4595) !== 7) {
                    await new Promise((res) => setTimeout(res, 100));
                }
            }
            catch (e) {
                console.error(e);
            }
            ClearPedTasks(pedId);
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const watch = (watch_skill);

// CONCATENATED MODULE: ./src/client/skills/pet.ts

const pet_isViable = (pedId, interaction) => !!pedId;
const pet_skill = {
    isViable: pet_isViable,
    createTask: (companion) => {
        let cancelled = false;
        const pedId = companion.getPedId();
        const model = GetEntityModel(pedId);
        const animationForModel = animLookup[model];
        const perform = () => new Promise(async (res) => {
            if (animationForModel) {
                const animation = animationForModel.pet;
                if (animation) {
                    const { dictionary, anim } = animation;
                    RequestAnimDict(dictionary);
                    let bail = 0;
                    while (!HasAnimDictLoaded(dictionary) && bail++ < 50) {
                        await new Promise((res) => setTimeout(res, 10));
                    }
                    if (!cancelled) {
                        await Promise.all([
                            new Promise(async (resolve) => {
                                TaskTurnPedToFaceEntity(pedId, PlayerPedId(), 2500);
                                while (!cancelled && GetScriptTaskStatus(pedId, 0xCBCE4595) !== 7) {
                                    await new Promise((res) => setTimeout(res, 100));
                                }
                                resolve();
                            }),
                            new Promise(async (resolve) => {
                                TaskTurnPedToFaceEntity(PlayerPedId(), pedId, 2500);
                                while (!cancelled && GetScriptTaskStatus(PlayerPedId(), 0xCBCE4595) !== 7) {
                                    await new Promise((res) => setTimeout(res, 100));
                                }
                                resolve();
                            })
                        ]);
                    }
                    if (!cancelled) {
                        TaskPlayAnim(PlayerPedId(), dictionary, "petting_franklin", -1, -1, 4000, 2, 0, false, false, false);
                        TaskPlayAnim(pedId, dictionary, anim, -1, -1, 4000, 2, 0, false, false, false);
                        await new Promise((res) => setTimeout(res, 100));
                        while (!cancelled && IsEntityPlayingAnim(pedId, dictionary, anim, 3)) {
                            await new Promise((res) => setTimeout(res, 200));
                        }
                    }
                    ClearPedTasks(pedId);
                }
            }
            res();
        });
        return {
            perform,
            isCancelled: () => cancelled,
            cancel: () => cancelled = true
        };
    }
};
/* harmony default export */ const pet = (pet_skill);

// CONCATENATED MODULE: ./src/client/skills/index.ts








const sit = genericAnimation("sit");
const bark = genericAnimation("bark", 3);
const beg = genericAnimation("beg", 3, 3000);
const laydown = genericAnimation("laydown");
const taunt = genericAnimation("taunt", 3);
const stretch = genericAnimation("stretch");
const paw = genericAnimation("paw", 2, 3000);
const peck = genericAnimation("peck", 3);
const graze = genericAnimation("graze", 3);
const howl = genericAnimation("howl");
const playdead = genericAnimation("playdead");

// CONCATENATED MODULE: ./src/client/companion.ts

/* harmony default export */ const companion = (async (config, interaction) => {
    let { id, speedModifier = 1, appearance, maxHealth = 200, maxSpeed = 8 } = config;
    const originalSpeedModifier = speedModifier;
    let companion = null;
    let pedId = null;
    let currentSkill = null;
    let nextSkill = null;
    let aliveInterval = null;
    const getPedId = () => pedId;
    const createPed = async (x, y, z, isNetworked = true) => {
        var _a;
        const modelHash = GetHashKey(appearance.model);
        RequestModel(modelHash);
        while (!HasModelLoaded(modelHash)) {
            await new Promise((res) => setTimeout(res, 10));
        }
        const ped = CreatePed(28, modelHash, x, y, z, 0, isNetworked, false);
        (_a = config.appearance.components) === null || _a === void 0 ? void 0 : _a.forEach(({ componentId, drawableId, textureId, paletteId }) => SetPedComponentVariation(ped, componentId, drawableId, textureId, paletteId));
        SetBlockingOfNonTemporaryEvents(ped, true);
        SetEntityMaxSpeed(ped, 1000);
        SetPedFleeAttributes(ped, 0, true);
        SetEntityMaxHealth(ped, maxHealth);
        SetEntityHealth(ped, maxHealth);
        return ped;
    };
    const updateFrameSpeed = () => SetPedMoveRateOverride(pedId, speedModifier);
    const dismiss = async (lostOwnership = false) => {
        emit("fa-companions:dismissed", id, lostOwnership);
        clearInterval(aliveInterval);
        aliveInterval = null;
        if (pedId && DoesEntityExist(pedId)) {
            const networkId = NetworkGetNetworkIdFromEntity(pedId);
            emitNet("fa-companions:destroyed", networkId);
            DeleteEntity(pedId);
            pedId = null;
            return true;
        }
        return false;
    };
    const perform = async (skillId, params) => {
        const skill = skills_namespaceObject[skillId];
        if (!currentSkill && skill.isViable(pedId, interaction, params)) {
            currentSkill = skill.createTask(companion, interaction, params);
            await currentSkill.perform();
            currentSkill = null;
            while (nextSkill) {
                currentSkill = nextSkill;
                nextSkill = null;
                await currentSkill.perform();
                currentSkill = null;
            }
        }
        else if (skill.isViable(pedId, interaction, params)) {
            currentSkill.cancel();
            nextSkill = skill.createTask(companion, interaction, params);
        }
    };
    const setSpeedModifier = (_speedModifier) => {
        speedModifier = _speedModifier;
    };
    const resetSpeedModifier = () => {
        speedModifier = originalSpeedModifier;
    };
    const getPedCoords = () => {
        if (!pedId) {
            return null;
        }
        const [x, y, z] = GetEntityCoords(pedId, false);
        return { x, y, z };
    };
    const getMaxSpeed = () => {
        return maxSpeed;
    };
    const [x, y, z] = GetEntityCoords(PlayerPedId(), true);
    pedId = await createPed(x - 2 + (Math.random() * 4), y - 2 + (Math.random() * 4), z);
    companion = {
        id,
        setSpeedModifier,
        resetSpeedModifier,
        getMaxSpeed,
        updateFrameSpeed,
        dismiss,
        getPedId,
        getPedCoords,
        perform
    };
    if (IsPedInAnyVehicle(PlayerPedId(), false)) {
        perform("vehicle", {
            vehicleId: GetVehiclePedIsIn(PlayerPedId(), false),
            instant: true
        });
    }
    aliveInterval = setInterval(() => {
        if (pedId && !DoesEntityExist(pedId)) {
            dismiss(true);
        }
    }, 1e3);
    const networkId = NetworkGetNetworkIdFromEntity(pedId);
    SetNetworkIdCanMigrate(networkId, false);
    emitNet("fa-companions:created", networkId);
    emit("fa-companions:summoned", id, pedId);
    return companion;
});

// CONCATENATED MODULE: ./src/client/companionList.ts

/* harmony default export */ const companionList = (() => {
    const companions = {};
    let interaction = null;
    const updateFrameSpeed = () => Object.values(companions).forEach((companion) => companion.updateFrameSpeed());
    const summon = async (_config) => {
        const configs = Array.isArray(_config) ? _config : [_config];
        const results = {};
        for (const config of configs) {
            if (!companions[config.id]) {
                companions[config.id] = await companion(config, interaction);
                results[config.id] = true;
                continue;
            }
            results[config.id] = false;
        }
        return results;
    };
    const dismiss = (_id) => {
        const ids = (_id === "" || _id === null || typeof _id === "undefined") ? Object.keys(companions) : (Array.isArray(_id) ? _id : [_id]);
        const results = {};
        for (const id of ids) {
            if (companions[id]) {
                companions[id].dismiss();
                delete companions[id];
                results[id] = true;
                continue;
            }
            results[id] = false;
        }
        return results;
    };
    const perform = (skillId, _id, params) => {
        const ids = (_id === "" || _id === null || typeof _id === "undefined") ? Object.keys(companions) : (Array.isArray(_id) ? _id : [_id]);
        const results = {};
        for (const id of ids) {
            if (companions[id]) {
                companions[id].perform(skillId, params);
                results[id] = true;
                continue;
            }
            results[id] = false;
        }
        return results;
    };
    const getByPedId = (pedId) => Object.values(companions).find((companion) => companion.getPedId() === pedId);
    const getPedId = (id) => { var _a; return (_a = companions[id]) === null || _a === void 0 ? void 0 : _a.getPedId(); };
    const getPedCoords = (id) => { var _a; return (_a = companions[id]) === null || _a === void 0 ? void 0 : _a.getPedCoords(); };
    return {
        updateFrameSpeed,
        summon,
        dismiss,
        perform,
        getByPedId,
        getPedId,
        getPedCoords,
        setInteraction: (_interaction) => interaction = _interaction
    };
});

// CONCATENATED MODULE: ./src/client/lib/debounceAnimation.ts
/* harmony default export */ const debounceAnimation = ((dictionary, anim) => {
    let lastPerform = 0;
    return async (pedId) => {
        const now = Date.now();
        if (now - lastPerform < 1e3) {
            return;
        }
        lastPerform = now;
        RequestAnimDict(dictionary);
        let bail = 0;
        while (!HasAnimDictLoaded(dictionary) && bail++ < 50) {
            await new Promise((res) => setTimeout(res, 10));
        }
        TaskPlayAnim(pedId, dictionary, anim, 2.7, 2.7, 1000, 49, 0, false, false, false);
    };
});

// CONCATENATED MODULE: ./src/client/client.ts



const whistle = debounceAnimation("rcmnigel1c", "hailing_whistle_waive_a");
const client_companionList = companionList();
const client_interaction = interaction(() => {
    const selectedEntity = client_interaction.getSelectedEntity();
    const selectedEntityType = client_interaction.getSelectedEntityType();
    const selectedPosition = client_interaction.getSelectedPosition();
    if (selectedEntity) {
        if (selectedEntityType === 1) {
            const companion = client_companionList.getByPedId(selectedEntity);
            emit("fa-companions:pedSelected", selectedEntity, companion === null || companion === void 0 ? void 0 : companion.id);
        }
        else if (selectedEntityType === 2) {
            emit("fa-companions:vehicleSelected", selectedEntity);
        }
    }
    else if (selectedPosition) {
        const { x, y, z } = selectedPosition;
        emit("fa-companions:groundSelected", { x, y, z });
    }
});
client_companionList.setInteraction(client_interaction);
on("gameEventTriggered", (eventName, data) => {
    // sync the companions health when they take damage
    if (eventName == "CEventNetworkEntityDamage" && data[0]) {
        const companion = client_companionList.getByPedId(data[0]);
        if (companion) {
            emit("fa-companions:damageTaken", data[0], companion.id);
        }
    }
});
setTick(() => {
    client_companionList.updateFrameSpeed();
    client_interaction.update();
    client_interaction.draw();
});
const startSelecting = (objectWhitelist = []) => client_interaction.startSelecting(objectWhitelist);
const stopSelecting = () => client_interaction.stopSelecting();
const deselect = () => client_interaction.deselect();
const summon = (configs, callback) => (async () => {
    const res = await client_companionList.summon(configs);
    whistle(PlayerPedId());
    if (callback) {
        callback(res);
    }
})();
const dismiss = (id, callback) => {
    const res = client_companionList.dismiss(id);
    if (callback) {
        callback(res);
    }
};
const perform = (skillId, id, params, callback) => (async () => {
    const res = client_companionList.perform(skillId, id, params);
    if (callback) {
        callback(res);
    }
})();
const getPedId = (id) => client_companionList.getPedId(id);
const getPedCoords = (id) => client_companionList.getPedCoords(id);
const getSelection = () => ({
    entityId: client_interaction.getSelectedEntity(),
    entityType: client_interaction.getSelectedEntityType(),
    entityDimensions: client_interaction.getSelectedEntityDimensions(),
    entityModel: client_interaction.getSelectedEntityModel(),
    ground: client_interaction.getSelectedPosition()
});
const getByPedId = (pedId) => client_companionList.getByPedId(pedId);
exports("startSelecting", startSelecting);
exports("stopSelecting", stopSelecting);
exports("deselect", deselect);
exports("summon", summon);
exports("dismiss", dismiss);
exports("perform", perform);
exports("getByPedId", getByPedId);
exports("getPedId", getPedId);
exports("getSelection", getSelection);
exports("getPedCoords", getPedCoords);

/******/ })()
;