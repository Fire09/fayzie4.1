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
    });

    FYX.Procedures.register("fa-mechanics:server:clockIn", async (src, pBiz) => {
        let cid = exports["fa-lib"].getCharacter(src).id
        let isEmployed = exports["fa-business"].IsEmployedAt(src, cid, pBiz)
        if (isEmployed) {
            FYX.Events.emitNet("fa-mechanics:client:clockedInState", true)
            return true, "You Clocked in"
        }
    })

    FYX.Procedures.register("fa-mechanics:server:clockOut", async (src, pBiz) => {
        let cid = exports["fa-lib"].getCharacter(src).id
        let isEmployed = exports["fa-business"].IsEmployedAt(src, cid, pBiz)
        if (isEmployed) {
            FYX.Events.emitNet("fa-mechanics:client:clockedInState", false)
            return false, "You Clocked out"
        }
    })


});
