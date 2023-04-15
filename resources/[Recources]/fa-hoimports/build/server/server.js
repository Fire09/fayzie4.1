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
    // done
    FYX.Procedures.register("fa-hoimports:ClockedIn", async(src) => {
        let cid = exports["fa-lib"].getCharacter(src).id
        let canUse = exports["fa-business"].IsEmployedAt(src, cid, "digital_den")
        if (canUse) {
            return true
        } else {
            return false
        }
    })
    // done
    FYX.Procedures.register("fa-hoimports:ClockedOut", async(src) => {
        return false
    })
    // done
    FYX.Procedures.register("fa-hoimports:GiveGNE", async(src, pAmount, pCid) => {
        if (exports["fa-phone"].addCrypto(src, pCid, pAmount, 1)) {
            return true
        } else {
            return false
        }
    })
    // done
    FYX.Procedures.register("fa-hoimports:ChargeGNE", async(src, pAmount) => {
        let cid = exports["fa-lib"].getCharacter(src).id
        let temp = {
            success : false,
            message : "not enough GNE",
        }

        if (exports["fa-phone"].takeCrypto(src, cid, pAmount, 1)) {
            temp.success = true
            return temp
        }
        return temp
    })

    FYX.Procedures.register("fa-hoimports:DeliverSticks", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:PickupOrder", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:ClaimEarnedTax", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:CreateOrder", async(src, pCart) => {

    })

    FYX.Procedures.register("fa-hoimports:GetCurrentStock", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:ApplyCurrentUpgrades", async(src, pNetId, pVin) => {

    })
    // done
    FYX.Procedures.register("fa-hoimports:RepairVehicleDeg", async(src, pNetId) => {
        let veh = NetworkGetEntityFromNetworkId(pNetId)
        exports["fa-vehicles"].FixVehicleDegredation(veh)
        return true
    })

    FYX.Procedures.register("fa-hoimports:CrushVehicle", async(src, pNetId) => {

    })

    FYX.Procedures.register("fa-hoimports:ConvertVehicle", async(src, pNetId, pHandling) => {

    })

    FYX.Procedures.register("fa-hoimports:ClaimRentalProfit", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:CreateListing", async(src, pPayload) => {

    })

    FYX.Procedures.register("fa-hoimports:FetchListings", async(src) => {

    })

    FYX.Procedures.register("fa-hoimports:UpdateListing", async(src, pPayload, pId) => {

    })

    FYX.Procedures.register("fa-hoimports:RemoveListing", async(src, pId) => {

    })

    FYX.Procedures.register("fa-hoimports:RentVehicle", async(src, pId) => {

    })

    FYX.Procedures.register("fa-hoimports:FetchListingInfo", async(src, pId) => {

    })

    FYX.Procedures.register("fa-hoimports:CompleteListing", async(src, pId) => {

    })

})();
