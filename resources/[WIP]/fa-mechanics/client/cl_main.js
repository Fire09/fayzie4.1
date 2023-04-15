(() => {
    'use strict';
    const _0x2c55f7 = globalThis.FYX;
    const _0x452ee5 = _0x2c55f7.Utils;
    const _0x224197 = _0x2c55f7.Zones;
    const _0x1435b5 = _0x2c55f7.Events;
    const _0x1a9f5c = _0x2c55f7.Streaming;
    const _0x3b192b = _0x2c55f7.Procedures;
    const _0x19e160 = null && _0x2c55f7;
    
    let _0x3eebaf = exports['fa-config'].GetModuleConfig('main');
    const _0x180957 = new Map();
    const _0x224546 = GetCurrentResourceName();
    async function _0x3b2365() {}

    on('fa-config:configLoaded', (_0x2bcc83, _0x31ab6f) => {
        if (_0x2bcc83 === 'main') {
            _0x3eebaf = _0x31ab6f;
        } else {
            if (_0x180957.has(_0x2bcc83)) {
                _0x180957.set(_0x2bcc83, _0x31ab6f);
            }
        }
    });

    function _0x19d83e(_0x484a0b) {
        return _0x3eebaf[_0x484a0b];
    }

    function _0x3ec042(_0x4a0d6c, _0x15bb97) {
        if (!_0x180957.has(_0x4a0d6c)) {
            const _0x202c73 = exports['fa-config'].GetModuleConfig(_0x4a0d6c);
            if (_0x202c73 === undefined) {
                return;
            }
            _0x180957.set(_0x4a0d6c, _0x202c73);
        }
        const _0x33e0c8 = _0x180957.get(_0x4a0d6c);
        if (_0x15bb97) {
            if (_0x33e0c8 === null || _0x33e0c8 === void 0) {
                return void 0;
            } else {
                return _0x33e0c8[_0x15bb97];
            }
        } else {
            return _0x33e0c8;
        }
    }

    function _0x193a02(_0x5bd777) {
        return _0x3ec042(_0x224546, _0x5bd777);
    }

    const _0x569e75 = new Set();
    function _0x574cb1(_0x3acb61) {
        return _0x569e75.has(_0x3acb61);
    }

    on('fa-polyzone:enter', _0x14d53a => {
        _0x569e75.add(_0x14d53a);
    });

    on('fa-polyzone:exit', _0x415bb6 => {
        _0x569e75.delete(_0x415bb6);
        _0x41cb90(_0x415bb6);
    });
    
    const _0x2b17fe = () => {
        const _0xc889f5 = _0x3ec042('fa-mechanics');
        const _0x576199 = Object.keys(_0xc889f5.registeredShops).map(_0x1e556d => _0xc889f5.registeredShops[_0x1e556d].workingZone); 
        let _0x2cb7d2 = null;
        for (const _0x2cb869 of _0x576199) {
            const _0x4e2a73 = _0x574cb1(_0x2cb869);
            if (_0x4e2a73) {
                const _0xfeccfd = Object.keys(_0xc889f5.registeredShops).find(_0x53208b => _0xc889f5.registeredShops[_0x53208b].workingZone === _0x2cb869);
                _0x2cb7d2 = _0xc889f5.registeredShops[_0xfeccfd];
                break;
            }
        }
        return _0x2cb7d2;
    };

    const _0x1765a3 = _0x44b217 => {
        const _0x5a63d5 = Math.floor((new Date().valueOf() - _0x44b217) / 1000);
        let _0x5942a3 = _0x5a63d5 / 31536000;
        if (_0x5942a3 > 1) {
            return Math.floor(_0x5942a3) + ' years';
        }
        _0x5942a3 = _0x5a63d5 / 2592000;
        if (_0x5942a3 > 1) {
            return Math.floor(_0x5942a3) + ' months';
        }
        _0x5942a3 = _0x5a63d5 / 86400;
        if (_0x5942a3 > 1) {
            return Math.floor(_0x5942a3) + ' days';
        }
        _0x5942a3 = _0x5a63d5 / 3600;
        if (_0x5942a3 > 1) {
            return Math.floor(_0x5942a3) + ' hours';
        }
        _0x5942a3 = _0x5a63d5 / 60;
        if (_0x5942a3 > 1) {
            return Math.floor(_0x5942a3) + ' minutes';
        }
        return Math.floor(_0x5a63d5) + ' seconds';
    };
    
    let _0xd6c65c = false;
    _0x1435b5.onNet('fa-mechanics:client:clockedInState', _0x3ead67 => {
        _0xd6c65c = _0x3ead67;
    });

    _0x1435b5.on('fa-mechanics:client:clockIn', async (_0x2810f5, _0x3434db, _0x4ee598) => {
        const _0x19b534 = _0x2b17fe();
        if (!_0x19b534) {
            return;
        }
        const _0x530edc = await exports['fa-business'].IsEmployedAt(_0x19b534.code);
        if (!_0x530edc) {
            return emit('DoLongHudText', 'You are not employed here.', 2);
        }
        const [_0x231016, _0x45e23e] = await _0x3b192b.execute('fa-mechanics:server:clockIn', _0x19b534.code);
        emit('DoLongHudText', _0x45e23e, _0x231016 ? 1 : 2);
    });

    _0x1435b5.on('fa-mechanics:client:clockOut', async (_0x17ae1c, _0x48e5be, _0x2f1a36) => {
        const _0x64c1d9 = _0x2b17fe();
        if (!_0x64c1d9) {
            return;
        }
        const _0x289019 = await exports['fa-business'].IsEmployedAt(_0x64c1d9.code);
        if (!_0x289019) {
            return emit('DoLongHudText', 'You are not employed here.', 2);
        }
        const [_0x1c3a96, _0x39f49c] = await _0x3b192b.execute('fa-mechanics:server:clockOut', _0x64c1d9.code);
        emit('DoLongHudText', _0x39f49c, _0x1c3a96 ? 1 : 2);
    });

    on('fa-mechanics:client:vehiclePartApplied', (_0x8e8190, _0x58c36e) => {
        if (!_0xd6c65c) {
            return;
        }
        const _0x2ac277 = _0x2b17fe();
        if (!_0x2ac277) {
            return;
        }
        const _0x50d088 = exports['fa-vehicles'].GetVehicleIdentifier(NetworkGetEntityFromNetworkId(_0x58c36e));
        _0x1435b5.emitNet('fa-mechanics:server:vehiclePartApplied', _0x2ac277.code, _0x8e8190, _0x50d088);
    });

    _0x1435b5.on('fa-mechanics:client:collectReceipts', async () => {
        const _0x3ec3dc = _0x2b17fe();
        if (!_0x3ec3dc) {
            return;
        }
        const _0x15bdd7 = await exports['fa-business'].IsEmployedAt(_0x3ec3dc.code);
        if (!_0x15bdd7) {
            return emit('DoLongHudText', 'You are not employed here.', 2);
        }
        const [_0x308d4d, _0x4be7fa] = await _0x3b192b.execute('fa-mechanics:server:collectReceipts', _0x3ec3dc.code);
        emit('DoLongHudText', _0x4be7fa, _0x308d4d ? 1 : 2);
    });

    _0x1435b5.on('fa-mechanics:client:viewClockedIn', async () => {
        const _0x5ef0f1 = _0x2b17fe();
        if (!_0x5ef0f1) {
            return;
        }
        const _0x5d3798 = await exports['fa-business'].IsEmployedAt(_0x5ef0f1.code);
        if (!_0x5d3798) {
            return emit('DoLongHudText', 'You are not employed here.', 2);
        }
        const [_0x499c57, _0x2b7a9c] = await _0x3b192b.execute('fa-mechanics:server:viewClockedIn', _0x5ef0f1.code);
        if (!_0x499c57) {
            return emit('DoLongHudText', 'System error, try again!', 2);
        }
        const _0x35d976 = _0x2b7a9c.map(_0x217bd6 => {
            const _0x10a824 = {
                icon: 'user',
                title: '' + _0x217bd6.name,
                description: 'Time: ' + _0x1765a3(_0x217bd6.clockedInTime) + ', StateID: ' + _0x217bd6.stateId,
                action: '',
                key: {}
            };
            return _0x10a824;
        });
        const _0x23419b = {
            icon: 'frown-open',
            title: 'No Employees Clocked In',
            action: '',
            key: {}
        };
        exports['fa-ui'].showContextMenu(_0x35d976.length > 0 ? _0x35d976 : [_0x23419b]);
    });

    const _0x15592f = () => {
        return _0xd6c65c;
    };

    const _0x41cb90 = async _0x311d8e => {
        const _0x37a4fb = _0x3ec042('fa-mechanics');
        const _0x295f94 = Object.keys(_0x37a4fb.registeredShops).map(_0x21adb1 => _0x37a4fb.registeredShops[_0x21adb1].workingZone);
        if (!_0x295f94.includes(_0x311d8e)) {
            return
        }

        const _0x4a631d = Object.keys(_0x37a4fb.registeredShops).find(_0x272ee2 => _0x37a4fb.registeredShops[_0x272ee2].workingZone === _0x311d8e);
        if (!_0x4a631d) {
            return;
        }
        if (_0xd6c65c) {
            const [_0x546a01] = await _0x3b192b.execute('fa-mechanics:server:clockOut', _0x4a631d);
            if (_0x546a01) {
                emit('DoLongHudText', 'You have been clocked off duty for leaving work zone!', 1);
            }
        }
        return;
    };
    
    const _0x5c6807 = () => {
        const _0x1c51de = {
            x: 1188.58,
            y: 2639.99,
            z: 38.4
        };
        const _0xd397d9 = {
            id: 'harmony_checkin',
            biz: 'harmony_repairs'
        };
        const _0x48a829 = {
            data: _0xd397d9,
            heading: 0,
            minZ: 37.8,
            maxZ: 39.2
        };
        exports['fa-polytarget'].AddBoxZone('mechanics_checkin', _0x1c51de, 0.4, 1.8, _0x48a829);
        const _0x2f4767 = {
            x: 831.23,
            y: -819.78,
            z: 26.35
        };
        const _0x26e032 = {
            id: 'ottos_checkin',
            biz: 'ottos_auto'
        };
        const _0x1f0cb0 = {
            data: _0x26e032,
            heading: 0,
            minZ: 25.95,
            maxZ: 26.85
        };
        exports['fa-polytarget'].AddBoxZone('mechanics_checkin', _0x2f4767, 1.8, 1, _0x1f0cb0);
        const _0xf0ec6f = {
            x: -1426.68,
            y: -458.38,
            z: 35.9
        };
        const _0x530366 = {
            id: 'hayes_checkin',
            biz: 'hayes_autos'
        };
        const _0x4d6e38 = {
            data: _0x530366,
            heading: 33,
            minZ: 35.5,
            maxZ: 36.5
        };
        exports['fa-polytarget'].AddBoxZone('mechanics_checkin', _0xf0ec6f, 2.2, 1, _0x4d6e38);
        const _0x2aaf31 = {
            x: -1419.9,
            y: -444.78,
            z: 35.9
        };
        const _0x2c3ca0 = { id: 'hazes_workzone' };
        const _0x29a0b7 = {
            data: _0x2c3ca0,
            heading: 300,
            minZ: 34.7,
            maxZ: 38.7
        };
        exports['fa-polyzone'].AddBoxZone('hazes_workzone', _0x2aaf31, 33, 22.6, _0x29a0b7);
        const _0x104cf8 = {
            x: 125.58,
            y: -3007.15,
            z: 7.04
        };
        const _0x31f2a3 = {
            id: 'tuner_checkin',
            biz: 'tuner'
        };
        const _0x257cb8 = {
            data: _0x31f2a3,
            heading: 0,
            minZ: 6.64,
            maxZ: 7.44
        };
        exports['fa-polytarget'].AddBoxZone('mechanics_checkin', _0x104cf8, 0.8, 1, _0x257cb8);
        const _0x37efab = {
            x: 1773.33,
            y: 3323.11,
            z: 41.45
        };
        const _0x8b5e24 = {
            id: 'ironhog_checkin',
            biz: 'iron_hog'
        };
        const _0x17fc18 = {
            data: _0x8b5e24,
            heading: 30,
            minZ: 41.05,
            maxZ: 41.85
        };
        exports['fa-polytarget'].AddBoxZone('mechanics_checkin', _0x37efab, 1, 1.4, _0x17fc18);
        const _0x41a937 = {
            x: 1774.91,
            y: 3327.58,
            z: 41.43
        };
        const _0x3ad9d1 = { id: 'ironhog_workzone' };
        const _0x2b8f2a = {
            data: _0x3ad9d1,
            heading: 28,
            minZ: 38.93,
            maxZ: 45.33
        };
        exports['fa-polyzone'].AddBoxZone('ironhog_workzone', _0x41a937, 35.6, 29.8, _0x2b8f2a);
        const _0x5be155 = {
            id: 'fa-mechanics:client:clockIn',
            FYXEvent: 'fa-mechanics:client:clockIn',
            icon: 'clock',
            label: 'Clock In'
        };
        const _0x338359 = { radius: 3.5 };
        const _0x4e6069 = {
            distance: _0x338359,
            isEnabled: () => !_0x15592f()
        };
        exports['fa-interact'].AddPeekEntryByPolyTarget('mechanics_checkin', [_0x5be155], _0x4e6069);
        const _0x201f08 = {
            id: 'fa-mechanics:client:collectReceipts',
            FYXEvent: 'fa-mechanics:client:collectReceipts',
            icon: 'file-invoice-dollar',
            label: 'Collect Receipts'
        };
        const _0xad6609 = {
            id: 'fa-mechanics:client:viewClockedIn',
            FYXEvent: 'fa-mechanics:client:viewClockedIn',
            icon: 'clipboard-list',
            label: 'View Clocked In'
        };
        const _0x3fc84f = { radius: 3.5 };
        const _0x124310 = {
            distance: _0x3fc84f,
            isEnabled: () => true
        };
        exports['fa-interact'].AddPeekEntryByPolyTarget('mechanics_checkin', [
            _0x201f08,
            _0xad6609
        ], _0x124310);
        const _0x2696c9 = {
            id: 'fa-mechanics:client:clockOut',
            FYXEvent: 'fa-mechanics:client:clockOut',
            icon: 'clock',
            label: 'Clock Out'
        };
        const _0x9dc3a2 = { radius: 3.5 };
        const _0x12c955 = {
            distance: _0x9dc3a2,
            isEnabled: () => _0x15592f()
        };
        exports['fa-interact'].AddPeekEntryByPolyTarget('mechanics_checkin', [_0x2696c9], _0x12c955);
    };

    async function _0x4fa1d2() {
        await _0x3b2365();
        _0x5c6807();
    };
    (async () => {
        await _0x4fa1d2();
    })();
})();