(() => {
    'use strict';
    var _0x37a94a = {
        g: function () {
            if (typeof globalThis === 'object') {
                return globalThis;
            }
            try {
                return this || new Function('return this')();
            } catch (_0x720964) {
                if (typeof window === 'object') {
                    return window;
                }
            }
        }()
    };
    let _0x4da516 = exports['fa-config'].GetModuleConfig('main');
    let _0x24652a = null;
    const _0xc0a0b5 = new Map();
    const _0x24f9df = GetCurrentResourceName();
    async function _0x26d544() {
        while (_0x24652a === null) {
            await new Promise(_0x4c5f25 => setTimeout(_0x4c5f25, 2000));
            _0x24652a = _0x36bc54();
        }
    }
    on('fa-config:configLoaded', (_0x346fbe, _0x19c242) => {
        if (_0x346fbe === 'main') {
            _0x4da516 = _0x19c242;
        } else {
            if (_0xc0a0b5.has(_0x346fbe)) {
                _0xc0a0b5.set(_0x346fbe, _0x19c242);
            }
        }
    });
    function _0x5e2a7f(_0x17fc6e) {
        return _0x4da516[_0x17fc6e];
    }
    function _0x935a28(_0x1aeef5, _0xb46714) {
        if (!_0xc0a0b5.has(_0x1aeef5)) {
            const _0x530b45 = exports['fa-config'].GetModuleConfig(_0x1aeef5);
            if (_0x530b45 === undefined) {
                return;
            }
            _0xc0a0b5.set(_0x1aeef5, _0x530b45);
        }
        const _0x2bd958 = _0xc0a0b5.get(_0x1aeef5);
        if (_0xb46714) {
            if (_0x2bd958 === null || _0x2bd958 === void 0) {
                return void 0;
            } else {
                return _0x2bd958[_0xb46714];
            }
        } else {
            return _0x2bd958;
        }
    }
    function _0x36bc54(_0x2cdcb1) {
        return _0x935a28(_0x24f9df, _0x2cdcb1);
    }
    ;
    const _0x99a049 = globalThis.FYX;
    const _0x49f1df = _0x99a049.Utils;
    const _0x4a4940 = _0x99a049.Zones;
    const _0x1ad7d9 = _0x99a049.Events;
    const _0x3e13b7 = _0x99a049.Streaming;
    const _0x47646c = _0x99a049.Procedures;
    const _0x5f5dfc = null && _0x99a049;
    ;
    async function _0xdb3e33(_0x380900) {
        return new Promise(_0x16fc55 => setTimeout(() => _0x16fc55(), _0x380900));
    }
    function _0x33a3e2(_0x3b0052) {
        return console.log('[Lifts] - ' + _0x3b0052);
    }
    ;
    const _0x5fb76 = { timeToLive: 300000 };
    const _0x2ab0c0 = Cacheable(async () => {
        const _0x42cee6 = exports.isPed.isPed('cid');
        const _0x41fa15 = await _0xe097ac('hno_imports', 'craft_access', _0x42cee6);
        return [
            true,
            _0x41fa15
        ];
    }, _0x5fb76);
    const _0x14d81e = { timeToLive: 300000 };
    const _0x215ecd = Cacheable(async () => {
        const _0x19c8b8 = exports.isPed.isPed('cid');
        const _0x585961 = await _0xe097ac('hno_imports', 'stash_access', _0x19c8b8);
        return [
            true,
            _0x585961
        ];
    }, _0x14d81e);
    const _0x3218b0 = { timeToLive: 300000 };
    const _0x3315c9 = Cacheable(async (_0x4844cf, _0x1bbe50) => {
        const _0x345d60 = exports['fa-vehicles'].GetVehicleIdentifier(_0x1bbe50);
        const _0x344c6b = await _0x47646c.execute('fa-ottosauto:getVehicleOwner', _0x345d60);
        const _0x375a0b = exports.isPed.isPed('cid') === _0x344c6b;
        return [
            true,
            _0x375a0b
        ];
    }, _0x3218b0);
    async function _0xe097ac(_0x5ec840, _0x3787f7, _0x4f1028) {
        const _0x1eada9 = await exports['fa-business'].HasPermission(_0x5ec840, _0x3787f7);
        return _0x1eada9;
    }
    function _0x5ceddb() {
        const [_0x202aea, _0x1d9eb1, _0x47ae93] = GetEntityCoords(PlayerPedId(), true);
        const _0x56c115 = GetDistanceBetweenCoords(_0x202aea, _0x1d9eb1, _0x47ae93, 946.45, -1745.27, 21.02, true);
        return _0x56c115 < 25;
    }
    function _0x1eecb4() {
        const [_0x10adde, _0xe9db80, _0x17a3e7] = GetEntityCoords(PlayerPedId(), true);
        const _0x103c34 = GetDistanceBetweenCoords(_0x10adde, _0xe9db80, _0x17a3e7, 139.52, -3030.65, 7.05, true);
        return _0x103c34 < 50;
    }
    async function _0x5f3df2(_0x3169da, _0x1db676, _0x4ada8f) {
        const _0xc9b5cc = PlayerPedId();
        TaskTurnPedToFaceCoord(_0xc9b5cc, _0x3169da[0], _0x3169da[1], _0x3169da[2], 1000);
        await _0xdb3e33(1000);
        TaskStartScenarioInPlace(_0xc9b5cc, 'WORLD_HUMAN_WELDING', 0, true);
        const _0x5529f7 = await _0x1288b7(_0x1db676, _0x4ada8f);
        ClearPedTasks(_0xc9b5cc);
        return _0x5529f7;
    }
    function _0x1288b7(_0x5aac20, _0x128b75, _0x3c30a9 = false) {
        return new Promise(_0x1506d5 => {
            exports['fa-taskbar'].taskBar(_0x5aac20, _0x128b75, _0x3c30a9, true, null, false, _0x1506d5);
        });
    }
    function _0x1ee23e(_0x118cba, _0x467fad) {
        const _0x58e09c = exports['fa-inventory'].hasEnoughOfItem('hqparts', _0x118cba, false);
        let _0x3f61e2 = true;
        for (let _0x15e046 = 0; _0x15e046 < _0x24652a.materialsReq.length; _0x15e046++) {
            if (!exports['fa-inventory'].hasEnoughOfItem(_0x24652a.materialsReq[_0x15e046], _0x467fad, false)) {
                _0x3f61e2 = false;
            }
        }
        return [
            _0x58e09c,
            _0x3f61e2
        ];
    }
    function _0x531985(_0x500dc2, _0x1f063d) {
        emit('inventory:removeItem', 'hqparts', _0x500dc2);
        for (let _0x315aca = 0; _0x315aca < _0x24652a.materialsReq.length; _0x315aca++) {
            emit('inventory:removeItem', _0x24652a.materialsReq[_0x315aca], _0x1f063d);
        }
        console.log('Removed: ' + _0x500dc2 + ' HQ parts and ' + _0x1f063d + ' of each refined material (Steel/Copper/Rubber/Glass/Aluminium');
        return true;
    }
    ;
    _0x1ad7d9.on('fa-hoimports:client:SignOn', () => {
        return _0x533a9e();
    });
    _0x1ad7d9.on('fa-hoimports:client:SignOff', () => {
        return _0x10aa4e();
    });
    ;
    let _0x30c7bd = false;
    const _0x2dad50 = () => _0x30c7bd;
    const _0x533a9e = async () => {
        const _0xe297cc = await _0x47646c.execute('fa-hoimports:ClockedIn');
        _0x30c7bd = _0xe297cc;
        emit('DoLongHudText', 'Signed on duty');
    };
    const _0x10aa4e = async () => {
        const _0x456963 = await _0x47646c.execute('fa-hoimports:ClockedOut');
        _0x30c7bd = _0x456963;
        emit('DoLongHudText', 'Signed off duty');
    };
    ;
    class _0x521251 {
        static AddPeekEntryByModel(_0x2cf5c7, _0x3dd0bf, _0x3bc3c4) {
            exports['fa-interact'].AddPeekEntryByModel(_0x2cf5c7, _0x3dd0bf, _0x3bc3c4);
        }
        static AddPeekEntryByPolyTarget(_0x3ceb5b, _0x3ac157, _0x58cb1b) {
            exports['fa-interact'].AddPeekEntryByPolyTarget(_0x3ceb5b, _0x3ac157, _0x58cb1b);
        }
        static AddPeekEntryByEntityType(_0x17c3ec, _0x203c25, _0x118348) {
            exports['fa-interact'].AddPeekEntryByEntityType(_0x17c3ec, _0x203c25, _0x118348);
        }
    }
    ;
    async function _0x58e945() {
        const _0x254c2d = {
            FYXEvent: 'fa-business:openHOImportsLaptop',
            id: 'hoimport_warehouse_laptop_open',
            icon: 'laptop',
            label: 'Open laptop',
            parameters: {}
        };
        const _0x1a3e7f = { radius: 2 };
        const _0x4e59bd = {
            distance: _0x1a3e7f,
            isEnabled: async () => {
                return await _0x215ecd();
            }
        };
        _0x521251.AddPeekEntryByPolyTarget('hoimport_warehouse_laptop', [_0x254c2d], _0x4e59bd);
        const _0x388c47 = {
            FYXEvent: 'fa-hoimports:client:SignOn',
            id: 'hoimport_warehouse_laptop_signon',
            icon: 'sign-in-alt',
            label: 'Ready For Rentals',
            parameters: {}
        };
        const _0x1b7d0f = { radius: 2 };
        const _0x11e71b = {
            distance: _0x1b7d0f,
            isEnabled: async () => {
                return await _0x215ecd() && !_0x2dad50();
            }
        };
        _0x521251.AddPeekEntryByPolyTarget('hoimport_warehouse_laptop', [_0x388c47], _0x11e71b);
        const _0x58f993 = {
            FYXEvent: 'fa-hoimports:client:SignOff',
            id: 'hoimport_warehouse_laptop_signoff',
            icon: 'sign-out-alt',
            label: 'Not ready For Rentals',
            parameters: {}
        };
        const _0x2f3f1e = { radius: 2 };
        const _0x5889e3 = {
            distance: _0x2f3f1e,
            isEnabled: async () => {
                return await _0x215ecd() && _0x2dad50();
            }
        };
        _0x521251.AddPeekEntryByPolyTarget('hoimport_warehouse_laptop', [_0x58f993], _0x5889e3);
        const _0x1d6b22 = {
            FYXEvent: 'fa-hoimports:client:ClaimRentalProfits',
            id: 'hoimport_collectprofit',
            icon: 'horse-head',
            label: 'Collect Rentals Profit',
            parameters: {}
        };
        const _0x3fd165 = { stickType: 'GNESTICK_10' };
        const _0x15ea91 = {
            FYXEvent: 'fa-hoimports:client:CreateStick',
            id: 'warehouse_gne_stick_4',
            icon: 'horse-head',
            label: 'Create a 10 GNE Stick (Requires 10 GNE)',
            parameters: _0x3fd165
        };
        const _0xdfc0f = { stickType: 'GNESTICK_25' };
        const _0x35c0c0 = {
            FYXEvent: 'fa-hoimports:client:CreateStick',
            id: 'warehouse_gne_stick_5',
            icon: 'horse-head',
            label: 'Create a 25 GNE Stick (Requires 25 GNE)',
            parameters: _0xdfc0f
        };
        const _0x16b21a = { stickType: 'GNESTICK_50' };
        const _0x1511dd = {
            FYXEvent: 'fa-hoimports:client:CreateStick',
            id: 'warehouse_gne_stick_1',
            icon: 'horse-head',
            label: 'Create a 50 GNE Stick (Requires 50 GNE)',
            parameters: _0x16b21a
        };
        const _0x41a4a3 = { stickType: 'GNESTICK_100' };
        const _0x51bce7 = {
            FYXEvent: 'fa-hoimports:client:CreateStick',
            id: 'warehouse_gne_stick_2',
            icon: 'horse-head',
            label: 'Create a 100 GNE Stick (Requires 100 GNE)',
            parameters: _0x41a4a3
        };
        const _0x3eb0e8 = { stickType: 'GNESTICK_250' };
        const _0x3dcd02 = {
            FYXEvent: 'fa-hoimports:client:CreateStick',
            id: 'warehouse_gne_stick_3',
            icon: 'horse-head',
            label: 'Create a 250 GNE Stick (Requires 250 GNE)',
            parameters: _0x3eb0e8
        };
        const _0x3ecfc8 = { radius: 2 };
        const _0xd25c23 = {
            distance: _0x3ecfc8,
            isEnabled: async () => {
                return await _0x2ab0c0();
            }
        };
        _0x521251.AddPeekEntryByPolyTarget('hoimport_warehouse_laptop', [
            _0x1d6b22,
            _0x15ea91,
            _0x35c0c0,
            _0x1511dd,
            _0x51bce7,
            _0x3dcd02
        ], _0xd25c23);
        const _0x1b6f6b = {
            event: 'fa-business:repairItem',
            id: 'warehouse_repairs_repair',
            icon: 'pencil-ruler',
            label: 'Repair Item to 80% - (Slot 1)',
            parameters: {}
        };
        const _0x4673cf = {
            event: 'fa-business:examineItem',
            id: 'warehouse_repairs_costs',
            icon: 'pencil-ruler',
            label: 'Examine Repair Costs - (Slot 1)',
            parameters: {}
        };
        const _0x876a42 = {
            FYXEvent: 'fa-hoimports:client:OpenCraftBench',
            id: 'warehouse_craft',
            icon: 'pencil-ruler',
            label: 'Open Tool Bench',
            parameters: {}
        };
        const _0x1e8412 = { radius: 2 };
        const _0x5cc6e7 = {
            distance: _0x1e8412,
            isEnabled: async () => {
                return await _0x2ab0c0();
            }
        };
        _0x521251.AddPeekEntryByPolyTarget('hoimport_warehouse_bench', [
            _0x1b6f6b,
            _0x4673cf,
            _0x876a42
        ], _0x5cc6e7);
        const _0x455624 = {
            FYXEvent: 'fa-hoimports:client:RepairVehicleDegredation',
            id: 'warehouse_repairs_degredation',
            icon: 'tools',
            label: 'Repair Degredation',
            parameters: {}
        };
        const _0x34a29c = {
            FYXEvent: 'fa-hoimports:client:RepairVehicleStandard',
            id: 'warehouse_repairs_standard',
            icon: 'tools',
            label: 'General Repair',
            parameters: {}
        };
        const _0x5c7cc3 = { radius: 20 };
        const _0x2b52ea = {
            distance: _0x5c7cc3,
            isEnabled: async () => {
                return await _0x215ecd() && _0x5ceddb();
            }
        };
        _0x521251.AddPeekEntryByEntityType([2], [
            _0x455624,
            _0x34a29c
        ], _0x2b52ea);
        const _0x48896c = {
            FYXEvent: 'fa-hoimports:client:ConvertVinScratchedVehicle',
            id: 'warehouse_convert_scratched',
            icon: 'car',
            label: 'Convert Scratched Vehicle',
            parameters: {}
        };
        const _0x37c18d = {
            FYXEvent: 'fa-hoimports:client:CrushVinScratchedVehicle',
            id: 'warehouse_scrap_scratched',
            icon: 'car-crash',
            label: 'Scrap Scratched Vehicle',
            parameters: {}
        };
        const _0x564641 = { radius: 20 };
        const _0x1c83a1 = {
            distance: _0x564641,
            isEnabled: async () => {
                return await _0x2ab0c0() && _0x5ceddb();
            }
        };
        _0x521251.AddPeekEntryByEntityType([2], [
            _0x48896c,
            _0x37c18d
        ], _0x1c83a1);
        const _0x5d8399 = {
            FYXEvent: 'fa-hoimports:client:ExamineUpgrades',
            id: 'vehicle_upgrades',
            icon: 'level-up-alt',
            label: 'Examine Upgrades',
            parameters: {}
        };
        const _0x5bcd46 = { radius: 5 };
        const _0x32dfdf = {
            distance: _0x5bcd46,
            isEnabled: async _0x283fa4 => {
                return exports['fa-vehicles'].IsVinScratched(_0x283fa4) && (await _0x3315c9(_0x283fa4) || await _0x2ab0c0()) && (_0x5ceddb() || _0x1eecb4());
            }
        };
        _0x521251.AddPeekEntryByEntityType([2], [_0x5d8399], _0x32dfdf);
    };

    class _0x16ad5f {
        constructor(_0x41a4de = 0, _0x42a641 = 0, _0x488c25 = 0) {
            this.x = _0x41a4de;
            this.y = _0x42a641;
            this.z = _0x488c25;
        }
        setFromArray(_0x1e0957) {
            this.x = _0x1e0957[0];
            this.y = _0x1e0957[1];
            this.z = _0x1e0957[2];
            return this;
        }
        getArray() {
            return [
                this.x,
                this.y,
                this.z
            ];
        }
        add(_0x253069) {
            this.x += _0x253069.x;
            this.y += _0x253069.y;
            this.z += _0x253069.z;
            return this;
        }
        addScalar(_0x3facbf) {
            this.x += _0x3facbf;
            this.y += _0x3facbf;
            this.z += _0x3facbf;
            return this;
        }
        sub(_0x9cf1c0) {
            this.x -= _0x9cf1c0.x;
            this.y -= _0x9cf1c0.y;
            this.z -= _0x9cf1c0.z;
            return this;
        }
        equals(_0x1b2357) {
            return this.x === _0x1b2357.x && this.y === _0x1b2357.y && this.z === _0x1b2357.z;
        }
        subScalar(_0x1ddaff) {
            this.x -= _0x1ddaff;
            this.y -= _0x1ddaff;
            this.z -= _0x1ddaff;
            return this;
        }
        multiply(_0x3d8397) {
            this.x *= _0x3d8397.x;
            this.y *= _0x3d8397.y;
            this.z *= _0x3d8397.z;
            return this;
        }
        multiplyScalar(_0x2851fa) {
            this.x *= _0x2851fa;
            this.y *= _0x2851fa;
            this.z *= _0x2851fa;
            return this;
        }
        round() {
            this.x = Math.round(this.x);
            this.y = Math.round(this.y);
            this.z = Math.round(this.z);
            return this;
        }
        floor() {
            this.x = Math.floor(this.x);
            this.y = Math.floor(this.y);
            this.z = Math.floor(this.z);
            return this;
        }
        ceil() {
            this.x = Math.ceil(this.x);
            this.y = Math.ceil(this.y);
            this.z = Math.ceil(this.z);
            return this;
        }
        getDistance(_0xa87ed4) {
            const [_0x32051e, _0x30f6e0, _0x1b3ed2] = [
                this.x - _0xa87ed4.x,
                this.y - _0xa87ed4.y,
                this.z - _0xa87ed4.z
            ];
            return Math.sqrt(_0x32051e * _0x32051e + _0x30f6e0 * _0x30f6e0 + _0x1b3ed2 * _0x1b3ed2);
        }
        getDistanceFromArray(_0x11a1aa) {
            const [_0xc3571c, _0x4098a1, _0x38bd71] = [
                this.x - _0x11a1aa[0],
                this.y - _0x11a1aa[1],
                this.z - _0x11a1aa[2]
            ];
            return Math.sqrt(_0xc3571c * _0xc3571c + _0x4098a1 * _0x4098a1 + _0x38bd71 * _0x38bd71);
        }
        static fromArray(_0x45ff19) {
            return new _0x16ad5f(_0x45ff19[0], _0x45ff19[1], _0x45ff19[2]);
        }
        static fromObject(_0x46b2b6) {
            return new _0x16ad5f(_0x46b2b6.x, _0x46b2b6.y, _0x46b2b6.z);
        }
    };

    async function _0x297519() {
        const _0x210141 = {
            minZ: 21.37,
            maxZ: 22.77,
            heading: 354
        };
        exports['fa-polytarget'].AddBoxZone('hoimport_warehouse_laptop', new _0x16ad5f(911.55, -1806.37, 22.37), 0.8, 2.6, _0x210141);
        const _0x1b72fa = {
            minZ: 19.83,
            maxZ: 21.43,
            heading: 351
        };
        exports['fa-polytarget'].AddBoxZone('hoimport_warehouse_bench', new _0x16ad5f(946.47, -1744.47, 21.03), 0.8, 2, _0x1b72fa);
        const _0x45b5aa = {
            minZ: 21.14,
            maxZ: 23.54,
            heading: 355
        };
        exports['fa-polyzone'].AddBoxZone('clothing_shop', new _0x16ad5f(918.53, -1796.14, 22.14), 2, 2.8, _0x45b5aa);
        const _0x4705fd = {
            mode: 3,
            range: 40,
            priority: 3
        };
        const _0x10a376 = {
            id: 'hnoimports:stage',
            ranges: [_0x4705fd]
        };
        const _0x22067c = {
            minZ: 20.23,
            maxZ: 22.63,
            heading: 355,
            data: _0x10a376
        };
        exports['fa-polyzone'].AddBoxZone('fa-fx:audio:stage', new _0x16ad5f(969.01, -1787.88, 21.23), 3.8, 3, _0x22067c);
        const _0x1c15b2 = {
            mode: 3,
            range: 60,
            priority: 3
        };
        const _0x3d3cdc = {
            id: 'hnoimports:stage:track',
            ranges: [_0x1c15b2]
        };
        const _0x2bdb41 = {
            minZ: 17,
            maxZ: 22.63,
            heading: 355,
            data: _0x3d3cdc
        };
        exports['fa-polyzone'].AddBoxZone('fa-fx:audio:stage', new _0x16ad5f(986.64, -1787.51, 18.03), 4.8, 3.4, _0x2bdb41);
    }
    ;
    _0x47646c.register('fa-hoimports:fetchRacingAlias', () => {
        const _0x54bcf6 = _0x37a94a.g.exports['fa-racing'].getHasRaceUsbAndAlias();
        const _0x1bde60 = _0x54bcf6.has_usb_racing && _0x54bcf6.racingAlias;
        if (_0x1bde60) {
            return _0x54bcf6.racingAlias;
        } else {
            return null;
        }
    });
    ;
    _0x1ad7d9.on('fa-hoimports:client:OpenCraftBench', () => {
        TriggerEvent('server-inventory-open', '42089', 'Craft');
    });

    var _0x3bc27a
    (function (_0x18122a) {
        _0x18122a.GNESTICK_10 = 'cryptostick4';
        _0x18122a.GNESTICK_25 = 'cryptostick5';
        _0x18122a.GNESTICK_50 = 'cryptostick1';
        _0x18122a.GNESTICK_100 = 'cryptostick2';
        _0x18122a.GNESTICK_250 = 'cryptostick3';
    }(_0x3bc27a || (_0x3bc27a = {})));

    let _0x191d3b = null;
    on('fa-inventory:itemUsed', async _0x122282 => {
        if (!_0x122282.includes('cryptostick')) {
            return;
        }
        const _0x142cca = Object.keys(_0x3bc27a).find(_0x169514 => _0x3bc27a[_0x169514] === _0x122282);
        if (!_0x142cca) {
            return;
        }
        const _0xd9d274 = parseInt(_0x142cca.split('_')[1]);
        const _0x159d2c = exports.isPed.isPed('cid');
        const _0x27736d = await _0x47646c.execute('fa-hoimports:GiveGNE', _0xd9d274, _0x159d2c);
        if (!_0x27736d) {
            return;
        }
        emit('inventory:removeItem', _0x122282, 1);
        return emit('DoLongHudText', 'You have added crypto to your wallet!');
    });

    _0x1ad7d9.on('fa-hoimports:client:CreateStick', async _0x3dc76a => {
        const _0x285565 = parseInt(_0x3dc76a.stickType.split('_')[1]);
        if (isNaN(_0x285565)) {
            return emit('DoLongHudText', 'Seems like USB couldn\'t decide which amount to give you..', 2);
        }
        const _0x3c725f = await _0x47646c.execute('fa-hoimports:ChargeGNE', _0x285565);
        if (!_0x3c725f.success) {
            return emit('DoLongHudText', _0x3c725f.message, 2);
        }
        emit('player:receiveItem', _0x3bc27a[_0x3dc76a.stickType]);
        return emit('DoLongHudText', 'Successfully created ' + _0x285565 + ' GNE USB Stick.', 1);
    });

    _0x1ad7d9.on('fa-hoimports:client:DepositSticks', async () => {
        const _0x5da733 = await _0x47646c.execute('fa-hoimports:DeliverSticks');
        if (_0x5da733) {
            emit('DoLongHudText', 'Sticks have been delivered!');
        } else {
            emit('DoLongHudText', 'Unknown error while attempting to deliver!', 2);
        }
    });

    _0x1ad7d9.on('fa-hoimports:client:PickupOrder', async () => {
        const _0xda20cf = await _0x47646c.execute('fa-hoimports:PickupOrder');
        for (let _0x1a8ac3 = 0; _0x1a8ac3 < _0xda20cf.length; _0x1a8ac3++) {
            emit('player:receiveItem', _0xda20cf[_0x1a8ac3].item, _0xda20cf[_0x1a8ac3].quantity);
        }
        if (_0xda20cf.length <= 0) {
            emit('DoLongHudText', 'You have no pending orders!', 2);
        }
        if (_0x191d3b) {
            RemoveBlip(_0x191d3b);
        }
    });

    _0x1ad7d9.on('fa-hoimports:client:ClaimTax', async () => {
        const _0x1e8fcd = await _0x47646c.execute('fa-hoimports:ClaimEarnedTax');
        for (let _0x7818bc = 0; _0x7818bc < _0x1e8fcd.length; _0x7818bc++) {
            emit('player:receiveItem', _0x1e8fcd[_0x7818bc].itemId, _0x1e8fcd[_0x7818bc].amount);
        }
    });

    _0x1ad7d9.on('fa-hoimports:client:OpenDepositInventory', () => {
        emit('server-inventory-open', '1', 'hoimports_deliversticks');
    });

    RegisterUICallback('fa-hoimports:ui:checkoutCart', async (_0x53530a, _0x2ea19d) => {
        const _0x575856 = await _0x47646c.execute('fa-hoimports:CreateOrder', _0x53530a.cart);
        if (_0x575856.success) {
            if (_0x191d3b) {
                RemoveBlip(_0x191d3b);
                _0x191d3b = null;
            }
            const _0x279db8 = AddBlipForCoord(1240.37, -3257.77, 6.92);
            SetBlipSprite(_0x279db8, 440);
            SetBlipScale(_0x279db8, 1.2);
            SetBlipColour(_0x279db8, 5);
            SetBlipAsShortRange(_0x279db8, true);
            BeginTextCommandSetBlipName('STRING');
            AddTextComponentString('Item Pickup');
            EndTextCommandSetBlipName(_0x279db8);
            _0x191d3b = _0x279db8;
        }
        const _0x3c88af = {
            ok: _0x575856.success,
            message: _0x575856.message
        };
        const _0x1b963a = {
            data: [],
            meta: _0x3c88af
        };
        _0x2ea19d(_0x1b963a);
    });

    RegisterUICallback('fa-hoimports:ui:fetchStock', async (_0xd0bcc2, _0x131839) => {
        const _0x210e76 = await _0x47646c.execute('fa-hoimports:GetCurrentStock');
        const _0x34dbc7 = { ok: true };
        const _0x4991cd = {
            data: _0x210e76,
            meta: _0x34dbc7
        };
        _0x131839(_0x4991cd);
    });

    let _0x47fff1;
    on('fa-inventory:closed', async _0x37cb7a => {
        if (!_0x47fff1 || !_0x37cb7a.endsWith('-Engine-enginebay')) {
            return;
        }
        const _0x4397e8 = _0x37cb7a.split('-')[1];
        if (!_0x4397e8 || _0x4397e8 !== _0x47fff1.vin) {
            return;
        }
        const _0x48369f = await _0x47646c.execute('fa-hoimports:ApplyCurrentUpgrades', _0x47fff1.netId, _0x47fff1.vin);
        exports['fa-sync'].SyncedExecution('SetVehicleDoorShut', NetworkGetEntityFromNetworkId(_0x47fff1.netId), 4);
        emit('animation:PlayAnimation', 'cancel');
        if (!_0x48369f) {
            emit('DoLongHudText', 'Failed to apply upgrades.');
        }
        _0x47fff1 = null;
    });
    _0x1ad7d9.on('fa-hoimports:client:RepairVehicleDegredation', async () => {
        const _0x2e3274 = exports.isPed.TargetVehicle();
        if (_0x2e3274 === 0) {
            return;
        }
        const vehRating = exports['fa-vehicles'].GetVehicleRatingClass(_0x2e3274);
        const _0x369542 = [
            'S',
            'X'
        ];

        const _0x1eeef7 = exports['fa-inventory'].hasEnoughOfItem('cryptostick5', 1, false);
        const _0x3b54bc = exports['fa-inventory'].hasEnoughOfItem('cryptostick4', 1, false);
        const _0x1e6b78 = GetEntityCoords(_0x2e3274, false);
        if (_0x369542.includes(vehRating) && _0x1eeef7) {
            const _0x4b2e2a = await _0x5f3df2(_0x1e6b78, 25000, 'Repairing Degredation');
            if (_0x4b2e2a !== 100) {
                return;
            }
            const _0x234d6f = await _0x47646c.execute('fa-hoimports:RepairVehicleDeg', NetworkGetNetworkIdFromEntity(_0x2e3274));
            if (_0x234d6f) {
                SetVehicleFixed(_0x2e3274);
                SetVehicleDirtLevel(_0x2e3274, 0);
                emit('inventory:removeItem', 'cryptostick5', 1);
            }
            return;
        }
        if (_0x3b54bc) {
            console.log("other Classes")
            const _0x102e56 = await _0x5f3df2(_0x1e6b78, 25000, 'Repairing Degredation');
            if (_0x102e56 !== 100) {
                return;
            }
            const _0x47ec7a = await _0x47646c.execute('fa-hoimports:RepairVehicleDeg', NetworkGetNetworkIdFromEntity(_0x2e3274));
            if (_0x47ec7a) {
                SetVehicleFixed(_0x2e3274);
                SetVehicleDirtLevel(_0x2e3274, 0);
                emit('inventory:removeItem', 'cryptostick4', 1);
            }
            return;
        }
        return emit('DoLongHudText', 'You need more GNE sticks', 2);
    });
    _0x1ad7d9.on('fa-hoimports:client:CrushVinScratchedVehicle', async () => {
        const _0x572ba4 = exports.isPed.TargetVehicle();
        const _0x404c22 = exports['fa-inventory'].hasEnoughOfItem('scraptoolset', 1, false);
        if (!_0x404c22) {
            return emit('DoLongHudText', 'You need a scrap tool set.', 2);
        }
        const _0x2e652f = exports['fa-vehicles'].GetVehicleRatingClass(_0x572ba4);
        if (!_0x24652a.partsForScratch[_0x2e652f]) {
            return emit('DoLongHudText', 'Unknown Class.', 2);
        }
        const _0x52412d = GetEntityCoords(_0x572ba4, false);
        const _0x363f9d = await _0x5f3df2(_0x52412d, 60000, 'Scrapping Vehicle');
        if (_0x363f9d !== 100) {
            return;
        }
        const _0x514176 = await _0x47646c.execute('fa-hoimports:CrushVehicle', NetworkGetNetworkIdFromEntity(_0x572ba4));
        if (_0x514176) {
            emit('player:receiveItem', 'hqparts', _0x24652a.partsForScratch[_0x2e652f]);
        }
    });
    _0x1ad7d9.on('fa-hoimports:client:ConvertVinScratchedVehicle', async () => {
        const _0x1947fe = exports.isPed.TargetVehicle();
        const _0x2a441a = exports['fa-vehicles'].GetVehicleRatingClass(_0x1947fe);
        const _0x3fd22c = exports['fa-inventory'].hasEnoughOfItem('scraptoolset', 1, false);
        if (!_0x3fd22c) {
            return emit('DoLongHudText', 'You need a scrap tool set.', 2);
        }
        if (!_0x24652a.partsForScratch[_0x2a441a]) {
            return emit('DoLongHudText', 'Unknown Class.', 2);
        }
        const _0x2ac937 = Math.ceil(_0x24652a.partsForScratch[_0x2a441a] * _0x24652a.conversionFactor);
        const _0x3304e1 = Math.ceil(_0x24652a.partsForScratch[_0x2a441a] * _0x24652a.materialFactor / 5);
        const _0x134138 = GetEntityCoords(_0x1947fe, false);
        const _0x5a3b2a = await _0x5f3df2(_0x134138, 120000, 'Converting Vehicle');
        if (_0x5a3b2a !== 100) {
            return;
        }
        const [_0x322370, _0x28d011] = _0x1ee23e(_0x2ac937, _0x3304e1);
        if (_0x322370 && _0x28d011) {
            const _0x4372ed = GetVehicleHandlingFloat(_0x1947fe, 'CHandlingData', 'fInitialDriveForce');
            const _0x3d400e = await _0x47646c.execute('fa-hoimports:ConvertVehicle', NetworkGetNetworkIdFromEntity(_0x1947fe), _0x4372ed);
            if (_0x3d400e) {
                _0x531985(_0x2ac937, _0x3304e1);
            }
        } else {
            emit('DoLongHudText', 'Not enough materials, you need: ' + _0x2ac937 + ' HQ parts and ' + _0x3304e1 + ' of each refined material (Steel/Copper/Rubber/Glass/Aluminium');
        }
    });
    _0x1ad7d9.on('fa-hoimports:client:RepairVehicleStandard', async () => {
        const _0x162d10 = exports.isPed.TargetVehicle();
        if (_0x162d10 === 0) {
            return;
        }
        const _0x16202b = GetEntityCoords(_0x162d10, false);
        const _0x141188 = await _0x5f3df2(_0x16202b, 25000, 'Repairing Vehicle');
        if (_0x141188 !== 100) {
            return;
        }
        SetVehicleFixed(_0x162d10);
        SetVehicleDirtLevel(_0x162d10, 0);
        return emit('DoLongHudText', 'Vehicle successfully repaired!');
    });
    _0x1ad7d9.on('fa-hoimports:client:ExamineUpgrades', async (_0x1497b3, _0x118204) => {
        const _0x87417d = exports['fa-vehicles'].GetVehicleIdentifier(_0x118204);
        emit('animation:PlayAnimation', 'mechanic');
        exports['fa-sync'].SyncedExecution('SetVehicleDoorOpen', _0x118204, 4);
        const _0xbfe549 = await _0x1288b7(10000, 'Checking Upgrades', true);
        if (_0xbfe549 !== 100) {
            return emit('animation:PlayAnimation', 'cancel');
        }
        const _0x2a804a = {
            netId: NetworkGetNetworkIdFromEntity(_0x118204),
            vin: _0x87417d
        };
        _0x47fff1 = _0x2a804a;
        return emit('inventory-open-container', 'container-' + _0x87417d + '-Engine-enginebay', 5, 30);
    });
    _0x1ad7d9.onNet('fa-hoimports:server:SetVehicleMods', (_0x3216df, _0x4cad01) => {
        exports['fa-vehicles'].SetVehicleMods(NetworkGetEntityFromNetworkId(_0x3216df), _0x4cad01);
    });
    _0x1ad7d9.on('fa-business:openHOImportsLaptop', async () => {
        const _0x45cd60 = exports.isPed.isPed('cid');
        const _0x45184d = 'hno_imports';
        const _0xdabe71 = [];
        const _0x58c784 = [];
        const _0xf57ea = await exports['fa-business'].IsEmployedAt(_0x45184d);
        if (_0xf57ea) {
            _0xdabe71.push('hoimportsApp');
            const _0x305f79 = await _0xe097ac(_0x45184d, 'craft_access', _0x45cd60);
            if (_0x305f79) {
                _0x58c784.push('hoimportsApp:managerRole');
            }
            const _0x8e74eb = await _0xe097ac(_0x45184d, 'craft_access', _0x45cd60);
            if (_0x8e74eb) {
                _0x58c784.push('hoimportsApp:employeeRole');
            }
        }
        const _0x426df3 = { laptopBackground: 'https://i.imgur.com/mko5Dho.png' };
        exports['fa-laptop'].OpenLaptop(_0xdabe71, _0x58c784, _0x426df3);
    });

    _0x1ad7d9.on('fa-hoimports:client:ClaimRentalProfits', async () => {
        return await _0x47646c.execute('fa-hoimports:ClaimRentalProfit');
    });
    RegisterUICallback('fa-hoimports:ui:CreateListing', async (_0xda7a8a, _0x4f8b97) => {
        const [_0x5b864f, _0x384ec2] = await _0x47646c.execute('fa-hoimports:CreateListing', _0xda7a8a.payload);
        let _0x223d1d = [];
        if (_0x5b864f) {
            const _0x29dcfb = await _0x47646c.execute('fa-hoimports:FetchListings');
            _0x223d1d = _0x29dcfb[1];
        }
        const _0x4031dc = { ok: _0x5b864f };
        const _0x2a5652 = {
            data: _0x223d1d,
            meta: _0x4031dc
        };
        _0x4f8b97(_0x2a5652);
    });
    RegisterUICallback('fa-hoimports:ui:FetchListings', async (_0x4ce207, _0x55f045) => {
        const [_0x2e5955, _0x262963] = await _0x47646c.execute('fa-hoimports:FetchListings');
        const _0x4dc46e = { ok: _0x2e5955 };
        const _0x3a090c = {
            data: _0x262963,
            meta: _0x4dc46e
        };
        _0x55f045(_0x3a090c);
    });
    RegisterUICallback('fa-hoimports:ui:UpdateListing', async (_0x5368d1, _0x9f2e79) => {
        const [_0x21d8f8, _0x4bde30] = await _0x47646c.execute('fa-hoimports:UpdateListing', _0x5368d1.payload, _0x5368d1.listingId);
        let _0x5c07a8 = [];
        if (_0x21d8f8) {
            const _0x46fddb = await _0x47646c.execute('fa-hoimports:FetchListings');
            _0x5c07a8 = _0x46fddb[1];
        }
        const _0x2fbd44 = { ok: _0x21d8f8 };
        const _0x33698 = {
            data: _0x5c07a8,
            meta: _0x2fbd44
        };
        _0x9f2e79(_0x33698);
    });
    RegisterUICallback('fa-hoimports:ui:RemoveListing', async (_0x1c32c8, _0x2624cf) => {
        const [_0x36dc8b, _0x555101] = await _0x47646c.execute('fa-hoimports:RemoveListing', _0x1c32c8.listingId);
        const _0x53f6b1 = { ok: _0x36dc8b };
        const _0x4cd5ce = {
            data: _0x555101,
            meta: _0x53f6b1
        };
        _0x2624cf(_0x4cd5ce);
    });
    RegisterUICallback('fa-hoimports:ui:RentVehicle', async (_0x2bfb6f, _0x4445ad) => {
        const [_0xb30abd, _0x1ea917] = await _0x47646c.execute('fa-hoimports:RentVehicle', _0x2bfb6f.listingId);
        const _0x4a8bd = { ok: _0xb30abd };
        const _0x390a52 = {
            data: [],
            meta: _0x4a8bd
        };
        _0x4445ad(_0x390a52);
    });
    RegisterUICallback('fa-hoimports:ui:FetchListingInfo', async (_0x294e51, _0x3695db) => {
        const [_0x51bdf4, _0x4639ac] = await _0x47646c.execute('fa-hoimports:FetchListingInfo', _0x294e51.listingId);
        const _0x38699b = { ok: _0x51bdf4 };
        const _0x44d564 = {
            data: _0x4639ac !== null && _0x4639ac !== void 0 ? _0x4639ac : null,
            meta: _0x38699b
        };
        _0x3695db(_0x44d564);
    });
    RegisterUICallback('fa-hoimports:ui:CompleteListing', async (_0x2b3a54, _0x3d9d80) => {
        const [_0x5080b5, _0x1e3885] = await _0x47646c.execute('fa-hoimports:CompleteListing', _0x2b3a54.listingId, _0x2b3a54.refundInsurance);
        const _0x13e70b = { ok: _0x5080b5 };
        const _0xad64cc = {
            data: [],
            meta: _0x13e70b
        };
        _0x3d9d80(_0xad64cc);
    });

    async function _0x473a8d() {
        await _0x297519();
        await _0x58e945();
        await _0x26d544();
    };
    const _0x5b3a4c = GetCurrentResourceName();
    on('onClientResourceStart', async _0x259590 => {
        if (_0x259590 !== _0x5b3a4c) {
            return;
        }
        await _0x473a8d();
    });
})();