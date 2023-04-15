(() => {
    'use strict';
    var globalList = {};
    (() => {
        globalList.d = (_0x41d5cf, _0x13fc28) => {
            for (var _0x508bfc in _0x13fc28) {
                if (globalList.o(_0x13fc28, _0x508bfc) && !globalList.o(_0x41d5cf, _0x508bfc)) {
                    Object.defineProperty(_0x41d5cf, _0x508bfc, {
                        enumerable: true,
                        get: _0x13fc28[_0x508bfc]
                    });
                }
            }
        };
    })();
    (() => {
        globalList.g = (function () {
            if (typeof globalThis === "object") {
                return globalThis;
            }
            try {
                return this || new Function("return this")();
            } catch (_0x3b8855) {
                if (typeof window === "object") {
                    return window;
                }
            }
        })();
    })();
    (() => {
        globalList.o = (_0x4d919f, _0xe37928) => Object.prototype.hasOwnProperty.call(_0x4d919f, _0xe37928);
    })();
    (() => {
        globalList.r = _0x1f3431 => {
            if (typeof Symbol !== "undefined" && Symbol.toStringTag) {
                Object.defineProperty(_0x1f3431, Symbol.toStringTag, {
                    value: "Module"
                });
            }
            Object.defineProperty(_0x1f3431, "__esModule", {
                value: true
            });
        };
    })();

    FYX.Procedures.register("fa-gangsystem:getCostOfSpray", async (src, gangId) => {
        return 500
    })

    FYX.Procedures.register("fa-gangsystem:getFoundGraffiti", async (src, gangId) => {
        //  return graffiti coords + blip color
    })

    FYX.Procedures.register("fa-gangsystem:getGanginfo", async (src) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:removeGangMember", async (src, gangId, cid) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:addGangMember", async (src, gangId, cid) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:fetchGangProgression", async (src, gangId) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:fetchIsStaff", async (src) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:fetchStaffInformation", async (src) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:staffRemoveMember", async (src, groupId, cid) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:staffFetchGangLogs", async (src, groupId) => {
        //  return gang data
        return {}
    })

    FYX.Procedures.register("fa-gangsystem:getGangsPedModels", async (src) => {
        let GangModels = {
            hoa : {
                model : 'g_m_y_lost_01',
                model : 'g_m_y_lost_02',
                model : 'g_m_y_lost_03',
            }
        }
        return GangModels
    })

    FYX.Procedures.register("fa-gangsystem:getGangNPCWeapon", async (src, gangId) => {
        return {}
    })

    FYX.Procedures.register("fa-gangsystem:getCurrentGang", async (src) => {
        return {}
    })

    FYX.Procedures.register("fa-gangsystem:getGanginfo", async (src) => {
        //  return gang data
        return {}

    })

    FYX.Procedures.register("fa-gangsystem:getGangFlagLocation", async (src) => {
        //  return gang data
        return {}

    })

    FYX.Procedures.register("fa-gangs:addFlag", async (src, objId, gangId, model) => {
        //  return gang data
    })

    FYX.Procedures.register("fa-gangsystem:openTrapInventory", async (src, gangId) => {
        //  return gang data
    })

})();