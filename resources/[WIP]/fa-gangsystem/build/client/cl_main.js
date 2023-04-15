(() => {
    'use strict';
    var _0x364abf = {
        g: function () {
            if (typeof globalThis === 'object') {
                return globalThis;
            }
            try {
                return this || new Function('return this')();
            } catch (_0x4a0d4f) {
                if (typeof window === 'object') {
                    return window;
                }
            }
        }()
    };
    (() => {
    })();
    ;
    const _0x4579b0 = globalThis.FYX;
    const _0x35a8e0 = _0x4579b0.Hud;
    const _0x4737e9 = _0x4579b0.Utils;
    const _0x59ac5e = _0x4579b0.Zones;
    const _0x10bc14 = _0x4579b0.Events;
    const _0x283ba5 = _0x4579b0.Streaming;
    const _0x1b0d0d = _0x4579b0.Procedures;
    const _0x168745 = _0x4579b0.Interface;
    const _0x5d9a97 = null && _0x4579b0;
    ;
    let _0xb07b59 = exports['fa-config'].GetModuleConfig('main');
    let _0x409ea8 = null;
    const _0xab95b5 = new Map();
    const _0x25dc40 = GetCurrentResourceName();
    async function _0x198dc3() {
        while (_0x409ea8 === null) {
            await new Promise(_0x39e095 => setTimeout(_0x39e095, 2000));
            _0x409ea8 = _0x29cfad();
        }
    }
    on('fa-config:configLoaded', (_0x2ee00f, _0x3d046f) => {
        if (_0x2ee00f === 'main') {
            _0xb07b59 = _0x3d046f;
        } else {
            if (_0xab95b5.has(_0x2ee00f)) {
                _0xab95b5.set(_0x2ee00f, _0x3d046f);
            }
        }
    });
    function _0x2383a2(_0x1c25b3) {
        return _0xb07b59[_0x1c25b3];
    }
    function _0x4e3402(_0x135538, _0x390f5b) {
        if (!_0xab95b5.has(_0x135538)) {
            const _0x3e16eb = exports['fa-config'].GetModuleConfig(_0x135538);
            if (_0x3e16eb === undefined) {
                return;
            }
            _0xab95b5.set(_0x135538, _0x3e16eb);
        }
        const _0x18c1da = _0xab95b5.get(_0x135538);
        if (_0x390f5b) {
            if (_0x18c1da === null || _0x18c1da === void 0) {
                return void 0;
            } else {
                return _0x18c1da[_0x390f5b];
            }
        } else {
            return _0x18c1da;
        }
    }
    function _0x29cfad(_0x3b48a3) {
        return _0x4e3402(_0x25dc40, _0x3b48a3);
    }
    ;
    const _0x1c2a33 = { timeToLive: 3600000 };
    // const _0x3fb703 = _0x4737e9.cache(async () => {
    //     const _0xc89a72 = await _0x1b0d0d.execute('fa-gangsystem:getGangsPedModels');
    //     return [
    //         true,
    //         _0xc89a72
    //     ];
    // }, _0x1c2a33);
    const _0x30b6a4 = { timeToLive: 600000 };
    // const _0x75be7b = _0x4737e9.cache(async () => {
    //     const _0x4707f7 = await _0x1b0d0d.execute('fa-gangsystem:getCurrentGang');
    //     return [
    //         true,
    //         _0x4707f7
    //     ];
    // }, _0x30b6a4);
    const _0x2fe734 = { timeToLive: 300000 };
    // const _0x687e3 = _0x4737e9.cache(async () => {
    //     const _0x53bbfb = await _0x1b0d0d.execute('fa-gangsystem:getGanginfo');
    //     return [
    //         true,
    //         _0x53bbfb
    //     ];
    // }, _0x2fe734);
    const _0x451700 = { timeToLive: 300000 };
    // const _0x31a105 = _0x4737e9.cache(async () => {
    //     const _0x22fbf6 = await _0x75be7b.get();
    //     if (!_0x22fbf6) {
    //         return [
    //             false,
    //             null
    //         ];
    //     }
    //     const _0x3bb492 = await _0x1b0d0d.execute('fa-gangsystem:getGangFlagLocation', _0x22fbf6);
    //     return [
    //         true,
    //         _0x3bb492
    //     ];
    // }, _0x451700);
    const _0x52d48a = () => {
        // _0x75be7b.reset();
        _0x31a105.reset();
        _0x687e3.reset();
    };
    const _0x380159 = async () => await _0x75be7b.get();
    const _0x2b4bb4 = async () => await _0x31a105.get();
    const _0x19e210 = async () => await _0x687e3.get();
    const _0x83b41c = async () => await _0x3fb703.get();
    ;
    const _0x31eed8 = globalThis;
    const _0x4cd454 = _0x59a31e => new Promise(_0x3694e4 => setTimeout(() => _0x3694e4(), _0x59a31e));
    const _0x3c0d11 = (_0x28ef1d, _0x2859e4) => {
        const [_0x827285, _0x528c12, _0x5417a7] = [
            _0x28ef1d.x - _0x2859e4.x,
            _0x28ef1d.y - _0x2859e4.y,
            _0x28ef1d.z - _0x2859e4.z
        ];
        return Math.sqrt(_0x827285 * _0x827285 + _0x528c12 * _0x528c12 + _0x5417a7 * _0x5417a7);
    };
    const _0x4c0dce = (_0xff844a, _0x30cee3) => {
        return _0xff844a.sort((_0x73ba25, _0x13d209) => _0x3c0d11(_0x30cee3, {
            x: _0x73ba25.x,
            y: _0x73ba25.y,
            z: _0x73ba25.z
        }) - _0x3c0d11(_0x30cee3, {
            x: _0x13d209.x,
            y: _0x13d209.y,
            z: _0x13d209.z
        })).map(_0x5d295c => _0x3c0d11(_0x30cee3, {
            x: _0x5d295c.x,
            y: _0x5d295c.y,
            z: _0x5d295c.z
        }));
    };
    function _0x589b54(_0x58c046, _0x46ae64) {
        return Math.floor(_0x46ae64 ? Math.random() * (_0x46ae64 - _0x58c046) + _0x58c046 : Math.random() * _0x58c046);
    }
    const _0x3f203c = (_0x404bf1, _0x1059d6) => {
        return _0x404bf1.slice(0, _0x1059d6).map(function () {
            return this.splice(Math.floor(Math.random() * this.length), 1)[0];
        }, _0x404bf1.slice());
    };
    const _0x4c1d0f = _0x9077ec => {
        let _0x3e0414 = 0;
        let _0x39da9d = 0;
        const _0x1e39a2 = GetResourceConfig('progressions');
        for (const _0x1724ea of _0x1e39a2) {
            if (_0x9077ec >= _0x1724ea.requiredGraffitis) {
                _0x3e0414 = _0x1724ea.inventorySlots;
                _0x39da9d = _0x1724ea.inventoryWeight;
            }
        }
        return [
            _0x3e0414,
            _0x39da9d
        ];
    };
    const _0x2f2bd5 = _0x4eea17 => {
        for (let _0x2ddce4 = _0x4eea17.length - 1; _0x2ddce4 > 0; _0x2ddce4--) {
            const _0x552973 = Math.floor(Math.random() * (_0x2ddce4 + 1));
            [_0x4eea17[_0x2ddce4], _0x4eea17[_0x552973]] = [
                _0x4eea17[_0x552973],
                _0x4eea17[_0x2ddce4]
            ];
        }
        return _0x4eea17;
    };
    ;
    function _0x107ca8(_0x589d7c, _0x17beb0, _0x456680 = false) {
        return new Promise(_0x43367b => {
            if (_0x17beb0) {
                exports['fa-taskbar'].taskBar(_0x589d7c, _0x17beb0, _0x456680, true, null, false, _0x43367b);
            } else {
                setTimeout(() => _0x43367b(100), _0x589d7c);
            }
        });
    }
    function _0x576673(_0x1441b7, _0x3075af, _0x3f5096) {
        return new Promise(_0x665329 => {
            exports['fa-phone'].DoPhoneConfirmation(_0x1441b7, _0x3075af, _0x3f5096, _0x665329);
        });
    }
    ;
    let _0x449b54 = [];
    setImmediate(() => {
        _0x449b54 = _0x364abf.g.exports['fa-doors'].GetDoorLocations();
    });
    on('fa-inventory:itemUsed', (_0x1d167b, _0x54014f) => {
        if (_0x1d167b !== 'gangflag') {
            return;
        }
        if (_0x5ec211()) {
            return emit('DoLongHudText', 'You cannot place a flag here', 2);
        }
        const _0x31dba8 = JSON.parse(_0x54014f);
        _0x444b2a(_0x31dba8.gangId, _0x31dba8 === null || _0x31dba8 === void 0 ? void 0 : _0x31dba8.upgraded);
    });
    const _0x444b2a = async (_0x245ef6, _0x5ef46e = false) => {
        if (!_0x245ef6) {
            return emit('DoLongHudText', 'Unknown flag', 2);
        }
        const _0x4bac76 = {
            collision: false,
            groundSnap: false,
            adjustZ: false,
            distance: 3,
            alignToSurface: true,
            surfaceOffset: 0.1
        };
        const _0x161c05 = await _0x364abf.g.exports['fa-objects'].PlaceAndSaveObject(_0x5ef46e ? GetHashKey('np_gangflag_' + _0x245ef6) : GetHashKey('np_gangflag'), { gangId: _0x245ef6 }, _0x4bac76, _0x2e04c3, 'gang-flags');
        if (!_0x161c05) {
            return emit('DoLongHudText', 'Failed to place down flag', 2);
        }
        const [_0x5a8cc5, _0x435106] = await _0x1b0d0d.execute('fa-gangs:addFlag', _0x161c05, _0x245ef6, _0x5ef46e);
        emit('DoLongHudText', _0x435106, _0x5a8cc5 ? 1 : 2);
        if (!_0x5a8cc5) {
            globalThis.exports['fa-objects'].DeleteObject(_0x161c05);
        }
        emit('inventory:removeItem', 'gangflag', 1);
    };
    const _0xde908d = _0x375eb1 => _0x449b54.some(_0xd22614 => _0xd22614.reduce((_0x1aa411, _0x508866, _0x238511) => _0x1aa411 += (_0x508866 - _0x375eb1[_0x238511]) ** 2, 0) <= 16);
    const _0x2e04c3 = (_0x12f84d, _0x2cc976, _0x313839, _0x6abbe4) => {
        if (GetEntityType(_0x6abbe4) !== 0) {
            return false;
        }
        if (_0x364abf.g.exports['fa-doors'].GetCurrentDoor() !== undefined) {
            return false;
        }
        const _0x2e4e1f = GetEntityModel(_0x313839);
        const [[_0x3ef983, , _0x285042], [_0x285efc, _0xde9bda, _0x320826]] = GetModelDimensions(_0x2e4e1f);
        const _0x3e8a60 = GetEntityForwardVector(_0x313839).map(_0x1c5e30 => _0x1c5e30 * 0.2);
        return [
            GetOffsetFromEntityInWorldCoords(_0x313839, _0x3ef983 * 0.8, _0xde9bda, _0x285042 * 0.8),
            GetOffsetFromEntityInWorldCoords(_0x313839, _0x285efc * 0.8, _0xde9bda, _0x285042 * 0.8),
            GetOffsetFromEntityInWorldCoords(_0x313839, _0x3ef983 * 0.8, _0xde9bda, _0x320826 * 0.8),
            GetOffsetFromEntityInWorldCoords(_0x313839, _0x285efc * 0.8, _0xde9bda, _0x320826 * 0.8)
        ].every(_0x4abc40 => {
            const _0xcc7601 = StartShapeTestCapsule(..._0x4abc40, _0x4abc40[0] + _0x3e8a60[0], _0x4abc40[1] + _0x3e8a60[1], _0x4abc40[2] + _0x3e8a60[2], 0.02, -1, _0x313839, 7);
            const [, _0x5552ce, , , _0x4600c1] = GetShapeTestResult(_0xcc7601);
            const _0x1549cc = GetEntityType(_0x4600c1);
            return _0x5552ce && _0x1549cc === 0;
        }) && !_0xde908d([
            _0x12f84d.x,
            _0x12f84d.y,
            _0x12f84d.z
        ]);
    };
    const _0x514e95 = async (_0x466d94, _0x90cf96) => {
        var _0x4cf14f;
        var _0x14f0cb;
        var _0x775573;
        var _0x589312;
        const _0x34bd74 = (_0x775573 = (_0x14f0cb = (_0x4cf14f = _0x90cf96.meta) === null || _0x4cf14f === void 0 ? void 0 : _0x4cf14f.data) === null || _0x14f0cb === void 0 ? void 0 : _0x14f0cb.metadata) === null || _0x775573 === void 0 ? void 0 : _0x775573.gangId;
        if (!_0x34bd74) {
            return false;
        }
        const _0x5d4508 = (_0x589312 = _0x90cf96.meta) === null || _0x589312 === void 0 ? void 0 : _0x589312.id;
        if (!_0x5d4508) {
            return false;
        }
        TaskTurnPedToFaceEntity(PlayerPedId(), _0x466d94, -1);
        emit('animation:PlayAnimation', 'hammering');
        const _0x217a9f = await _0x107ca8(5000, 'Destroying gang flag', true);
        ClearPedTasks(PlayerPedId());
        if (_0x217a9f !== 100) {
            return false;
        }
        const _0x2014f5 = await _0x364abf.g.exports['fa-objects'].DeleteObject(_0x5d4508);
        if (_0x2014f5) {
            _0x10bc14.emitNet('fa-gangsystem:flagDestroyed', _0x34bd74);
        }
    };
    ;
    _0x10bc14.onNet('fa-gangsystem:doPedHandOff', async _0x7b68c2 => {
        const _0x49a3a4 = GetGamePool('CPed').filter(_0x4a0c99 => !IsPedAPlayer(_0x4a0c99));
        const _0x438051 = _0x49a3a4.filter(_0x3a709c => GetEntityModel(_0x3a709c) === GetHashKey(_0x7b68c2) && !IsPedInAnyVehicle(_0x3a709c, false) && !IsEntityDead(_0x3a709c));
        if (_0x438051.length <= 0) {
            return;
        }
        await _0x283ba5.loadAnim('mp_safehouselost@');
        const _0x1d682f = _0x438051[Math.floor(Math.random() * _0x438051.length)];
        const _0xf1cdc6 = GetEntityCoords(_0x1d682f, true);
        const _0x2342b8 = {
            x: _0xf1cdc6[0],
            y: _0xf1cdc6[1],
            z: _0xf1cdc6[2]
        };
        const _0x591c40 = _0x49a3a4.filter(_0x484009 => {
            const _0x426a0c = GetEntityCoords(_0x484009, true);
            return GetEntityModel(_0x484009) !== GetHashKey(_0x7b68c2) && _0x3c0d11(_0x5dec68, _0x2342b8) < 50 && !IsPedInAnyVehicle(_0x484009, false);
        });
        const _0x462f3f = _0x591c40[Math.floor(Math.random() * _0x591c40.length)];
        if (!_0x462f3f) {
            return;
        }
        NetworkRequestControlOfEntity(_0x462f3f);
        NetworkRequestControlOfEntity(_0x1d682f);
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(_0x462f3f), false);
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(_0x1d682f), false);
        TaskStartScenarioInPlace(_0x1d682f, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, true);
        let _0xe64fc6 = false;
        const _0x52b764 = Date.now() + 120000;
        while (!_0xe64fc6) {
            if (Date.now() > _0x52b764 || IsEntityDead(_0x1d682f) || IsEntityDead(_0x462f3f)) {
                _0xe64fc6 = true;
                return;
            }
            const _0x3fb00b = GetEntityCoords(_0x462f3f, true);
            const _0x13d443 = {
                x: _0x3fb00b[0],
                y: _0x3fb00b[1],
                z: _0x3fb00b[2]
            };
            const _0x3388de = _0x3c0d11(_0x2342b8, _0x13d443);
            if (_0x3388de <= 2) {
                ClearPedTasksImmediately(_0x1d682f);
                await _0x4cd454(500);
                TaskTurnPedToFaceEntity(_0x462f3f, _0x1d682f, -1);
                TaskTurnPedToFaceEntity(_0x1d682f, _0x462f3f, -1);
                await _0x4cd454(1000);
                TaskPlayAnim(_0x462f3f, 'mp_safehouselost@', 'package_dropoff', 8, -8, -1, 0, 0, false, false, false);
                TaskPlayAnim(_0x1d682f, 'mp_safehouselost@', 'package_dropoff', 8, -8, -1, 0, 0, false, false, false);
                _0xe64fc6 = true;
                return;
            }
            if (GetScriptTaskStatus(_0x462f3f, 1227113341) === 7 && !_0xe64fc6) {
                TaskGoToEntity(_0x462f3f, _0x1d682f, -1, 2, 1, 0, 0);
            }
            await _0x4cd454(500);
        }
    });
    ;
    const _0x53577d = new Set();
    function _0x565245(_0xb6d76d) {
        return _0x53577d.has(_0xb6d76d);
    }
    on('fa-polyzone:enter', _0x4dd80d => {
        _0x53577d.add(_0x4dd80d);
    });
    on('fa-polyzone:exit', _0x2f69f8 => {
        _0x53577d.delete(_0x2f69f8);
    });
    ;
    let _0x698e5b = null;
    let _0x280812 = [];
    let _0x1e23eb = [];
    const _0x4c64b8 = async (_0x361478, _0x36fb69) => {
        if (!_0x361478 || !_0x36fb69) {
            return [
                false,
                'Where did I find this spray can...'
            ];
        }
        if (_0x5ec211()) {
            return [
                false,
                'You cannot place graffiti here'
            ];
        }
        const _0x214114 = await _0x380159();
        if (!_0x214114) {
            return [
                false,
                'You are not in a gang!'
            ];
        }
        if (_0x214114 !== _0x361478) {
            return [
                false,
                'You are not in this gang!'
            ];
        }
        const _0x548abc = GetEntityCoords(PlayerPedId(), false);
        const _0x1b4adc = {
            x: _0x548abc[0],
            y: _0x548abc[1],
            z: _0x548abc[2]
        };
        const _0x4b61bb = exports['fa-objects'].GetObjectsByNamespace('graffiti');
        const _0x1c88d4 = exports['fa-objects'].GetObjectsByNamespace('gang-flags').sort((_0x222ffa, _0xb4cfe5) => _0x3c0d11(_0x1b4adc, {
            x: _0x222ffa.x,
            y: _0x222ffa.y,
            z: _0x222ffa.z
        }) - _0x3c0d11(_0x1b4adc, {
            x: _0xb4cfe5.x,
            y: _0xb4cfe5.y,
            z: _0xb4cfe5.z
        })).filter(_0x2353bb => _0x3c0d11(_0x1b4adc, {
            x: _0x2353bb.x,
            y: _0x2353bb.y,
            z: _0x2353bb.z
        }) < _0x409ea8.minDistanceFromFlag);
        const _0x26bff5 = _0x4b61bb.filter(_0x7e324 => _0x7e324.data.metadata.gangId && _0x7e324.data.metadata.gangId === _0x361478);
        const _0x33bd9c = _0x4b61bb.filter(_0x7b428 => _0x7b428.data.metadata.gangId && _0x7b428.data.metadata.gangId !== _0x361478);
        const _0x3984fb = _0x1c88d4.find(_0x46848a => _0x46848a.data.metadata.gangId !== _0x214114);
        const _0xeaf315 = _0x4c0dce(_0x33bd9c, _0x1b4adc).filter(_0x587772 => _0x587772 < _0x409ea8.minDistanceFromEnemy).length > 0;
        if (_0xeaf315 || _0x3984fb) {
            return [
                false,
                'You are too close to an enemy territory!'
            ];
        }
        const _0x5c44a1 = _0x4c0dce(_0x26bff5, _0x1b4adc).filter(_0x51f247 => _0x51f247 < _0x409ea8.minDistanceFromFriendly).length > 0;
        if (_0x5c44a1) {
            return [
                false,
                'Need to spread out more!'
            ];
        }
        const _0x48d0ab = _0x4c0dce(_0x26bff5, _0x1b4adc).filter(_0x1e1afa => _0x1e1afa < _0x409ea8.maxDistanceFromFriendly).length === 0;
        const _0x1df64a = _0x1c88d4.find(_0x1e4a56 => _0x1e4a56.data.metadata.gangId === _0x214114);
        if (_0x48d0ab && !_0x1df64a) {
            return [
                false,
                'You are too far from a friendly territory!'
            ];
        }
        if (_0x1df64a || !_0x48d0ab) {
            return [
                true,
                ''
            ];
        }
        return [
            true,
            ''
        ];
    };
    const _0x3c57c7 = _0x553299 => {
        const _0x50ee05 = _0x364abf.g.exports['fa-objects'].GetObjectsByNamespace('graffiti').filter(_0x19d01a => _0x19d01a.data.metadata.gangId && _0x3c0d11(_0x553299, {
            x: _0x19d01a.x,
            y: _0x19d01a.y,
            z: _0x19d01a.z
        }) < 100).sort((_0x387898, _0x349010) => _0x3c0d11(_0x553299, {
            x: _0x387898.x,
            y: _0x387898.y,
            z: _0x387898.z
        }) - _0x3c0d11(_0x553299, {
            x: _0x349010.x,
            y: _0x349010.y,
            z: _0x349010.z
        }));
        if (_0x50ee05.length > 0) {
            return _0x50ee05[0].data.metadata.gangId;
        } else {
            return null;
        }
    };
    const _0x241920 = async _0x254706 => {
        const _0x2aba2a = await _0x380159();
        if (_0x2aba2a === _0x254706) {
            return;
        }
        const _0x2a8a52 = GetEntityCoords(PlayerPedId(), true);
        const _0x474b91 = {
            x: _0x2a8a52[0],
            y: _0x2a8a52[1],
            z: _0x2a8a52[2]
        };
        const _0xdb5cec = GetLabelText(GetNameOfZone(_0x474b91.x, _0x474b91.y, _0x474b91.z));
        const [_0x33b768, _0x2353df] = GetStreetNameAtCoord(_0x474b91.x, _0x474b91.y, _0x474b91.z);
        const _0x3a36c4 = GetStreetNameFromHashKey(_0x33b768) + ', ' + _0xdb5cec;
        _0x10bc14.emitNet('fa-gangsystem:graffitiBeingRemoved', _0x254706, _0x3a36c4);
    };
    const _0x5e1ef7 = async _0x1b8dec => {
        const _0x487e0e = await _0x380159();
        if (!_0x487e0e) {
            return;
        }
        const _0x24e763 = PlayerPedId();
        const _0x51cfdd = await _0x1b0d0d.execute('fa-gangsystem:openTrapInventory', _0x487e0e);
        if (!_0x51cfdd) {
            return;
        }
        _0x698e5b = _0x1b8dec;
        SetEntityAsMissionEntity(_0x1b8dec, true, true);
        SetNetworkIdCanMigrate(_0x1b8dec, false);
        ClearPedTasks(_0x1b8dec);
        TaskLookAtEntity(_0x1b8dec, _0x24e763, -1, 2048, 3);
        TaskTurnPedToFaceEntity(_0x1b8dec, _0x24e763, 10000);
    };
    const _0x50cf14 = async () => {
        await _0x283ba5.loadAnim('mp_safehouselost@');
        TaskTurnPedToFaceEntity(_0x698e5b, PlayerPedId(), 0);
        TaskTurnPedToFaceEntity(PlayerPedId(), _0x698e5b, 0);
        TaskPlayAnim(_0x698e5b, 'mp_safehouselost@', 'package_dropoff', 8, -8, -1, 0, 0, false, false, false);
        TaskPlayAnim(PlayerPedId(), 'mp_safehouselost@', 'package_dropoff', 8, -8, -1, 0, 0, false, false, false);
        await _0x4cd454(2000);
        SetEntityAsNoLongerNeeded(_0x698e5b);
        _0x698e5b = null;
    };
    const _0x57b326 = async () => {
        const _0x34ea44 = await _0x380159();
        if (!_0x34ea44) {
            return emit('DoLongHudText', 'Looks at you confused...');
        }
        const _0x5d46b2 = await _0x1b0d0d.execute('fa-gangsystem:getCostOfSpray', _0x34ea44);
        const _0x386239 = {
            icon: 'money-bill',
            title: 'Purchase Spray ($' + _0x5d46b2 + ')',
            description: '',
            action: 'fa-gangsystem:confirmPurchaseSpray'
        };
        const _0x4fd1cf = [_0x386239];
        _0x364abf.g.exports['fa-ui'].showContextMenu(_0x4fd1cf);
    };
    const _0x2bf6c3 = async () => {
        const _0x1a74a8 = await _0x380159();
        if (!_0x1a74a8) {
            return emit('DoLongHudText', 'Looks at you confused...');
        }
        const _0xfd32d3 = await _0x1b0d0d.execute('fa-gangsystem:getCostOfSpray', _0x1a74a8);
        const _0x4201a0 = _0xfd32d3 + 100000;
        const _0x2e4e2a = {
            icon: 'money-bill',
            title: 'Purchase Cloth ($' + _0x4201a0 + ')',
            description: '',
            action: 'fa-gangsystem:confirmPurchaseCloth'
        };
        const _0x3933a5 = [_0x2e4e2a];
        _0x364abf.g.exports['fa-ui'].showContextMenu(_0x3933a5);
    };
    const _0x5ec211 = () => {
        const _0x31e03f = _0x565245('fa-gangsystem:blockedZone');
        return _0x31e03f;
    };
    const _0x2ba201 = async _0x554229 => {
        var _0x29ab3d;
        var _0x325585;
        const _0x15139f = _0x554229.meta.id;
        const _0x3baba9 = (_0x325585 = (_0x29ab3d = _0x554229.meta.data) === null || _0x29ab3d === void 0 ? void 0 : _0x29ab3d.metadata) === null || _0x325585 === void 0 ? void 0 : _0x325585.gangId;
        if (!_0x15139f) {
            return;
        }
        const _0x35d626 = await _0x380159();
        if (_0x35d626 !== _0x3baba9) {
            return;
        }
        const _0x5b714f = { upForGrabs: true };
        exports['fa-objects'].UpdateObject(_0x15139f, _0x5b714f);
    };
    const _0x54b9ba = async _0x2520a9 => {
        var _0x12a8f8;
        var _0x4a2633;
        var _0x29e7d4;
        var _0x438c1d;
        var _0xd6ddb2;
        const _0x3f895a = _0x2520a9.meta.id;
        const _0x2b07b6 = (_0x4a2633 = (_0x12a8f8 = _0x2520a9 === null || _0x2520a9 === void 0 ? void 0 : _0x2520a9.meta) === null || _0x12a8f8 === void 0 ? void 0 : _0x12a8f8.data) === null || _0x4a2633 === void 0 ? void 0 : _0x4a2633.metadata.gangId;
        const _0x2e3d7a = (_0xd6ddb2 = (_0x438c1d = (_0x29e7d4 = _0x2520a9 === null || _0x2520a9 === void 0 ? void 0 : _0x2520a9.meta) === null || _0x29e7d4 === void 0 ? void 0 : _0x29e7d4.data) === null || _0x438c1d === void 0 ? void 0 : _0x438c1d.metadata.gangsDiscovered) !== null && _0xd6ddb2 !== void 0 ? _0xd6ddb2 : [];
        const _0x4f6e07 = await _0x380159();
        if (_0x2b07b6 === _0x4f6e07 || _0x2e3d7a && _0x2e3d7a.includes(_0x4f6e07)) {
            const _0x53bb84 = { i18n: ['You already know of this graffiti!'] };
            return emit('DoLongHudText', 'You already know of this graffiti!', 1, 12000, _0x53bb84);
        }
        emit('animation:PlayAnimation', 'search');
        const _0x2889b2 = await _0x168745.taskBar(30000, 'Discovering Graffiti', true, {
            distance: 2,
            entity: PlayerPedId()
        });
        ClearPedTasks(PlayerPedId());
        if (_0x2889b2 !== 100) {
            return;
        }
        const _0x94fbf3 = {
            gangsDiscovered: [
                ..._0x2e3d7a,
                _0x4f6e07
            ]
        };
        exports['fa-objects'].UpdateObject(_0x3f895a, _0x94fbf3);
        const _0x271a86 = { i18n: ['Discovered graffiti!'] };
        return emit('DoLongHudText', 'Discovered graffiti!', 1, 12000, _0x271a86);
    };
    const _0x2523ff = async (_0x2cdaf8 = false) => {
        if (_0x280812.length > 0) {
            for (const _0x9f8c3b of _0x280812) {
                RemoveBlip(_0x9f8c3b);
            }
            _0x280812 = [];
            const _0x54678d = { i18n: ['Removed all blips'] };
            return emit('DoLongHudText', 'Removed all blips', 1, 12000, _0x54678d);
        }
        const _0x553f24 = await _0x1b0d0d.execute('fa-gangsystem:getFoundGraffiti', _0x2cdaf8);
        for (const _0x1affd1 of _0x553f24) {
            const _0x28a677 = AddBlipForRadius(_0x1affd1.coords.x, _0x1affd1.coords.y, _0x1affd1.coords.z, 100);
            SetBlipAlpha(_0x28a677, 100);
            SetBlipSprite(_0x28a677, 9);
            SetBlipColour(_0x28a677, _0x1affd1.color);
            _0x280812.push(_0x28a677);
        }
        if (_0x553f24.length > 0) {
            const _0x4fd5de = { i18n: ['Discovered graffitis marked'] };
            return emit('DoLongHudText', 'Discovered graffitis marked', 1, 12000, _0x4fd5de);
        }
    };
    const _0x277eb8 = async () => {
        const _0x297b44 = await _0x380159();
        if (!_0x297b44) {
            return;
        }
        const _0x54fd13 = await _0x1b0d0d.execute('fa-gangsystem:getCollectHistory', _0x297b44);
        const _0x2fe58f = _0x54fd13.map(_0xa337f8 => {
            const _0x579a26 = {
                icon: 'info-circle',
                title: '' + _0xa337f8.log,
                description: '' + _0xa337f8.date,
                action: ''
            };
            return _0x579a26;
        });
        if (_0x2fe58f.length === 0) {
            const _0x1b12fc = {
                icon: 'info-circle',
                title: 'No profit has been collected yet',
                description: '',
                action: ''
            };
            _0x2fe58f.push(_0x1b12fc);
        }
        _0x364abf.g.exports['fa-ui'].showContextMenu(_0x2fe58f);
        return;
    };
    const _0x1d0a33 = async () => {
        if (_0x1e23eb.length > 0) {
            for (const _0x5a102c of _0x1e23eb) {
                RemoveBlip(_0x5a102c);
            }
            _0x1e23eb = [];
            const _0x294353 = { i18n: ['Removed all blips'] };
            return emit('DoLongHudText', 'Removed all blips', 1, 12000, _0x294353);
        }
        const _0x5d79ff = await _0x380159();
        if (!_0x5d79ff) {
            return;
        }
        const _0x1a1a24 = await _0x1b0d0d.execute('fa-gangsystem:getContestedGraffiti', _0x5d79ff);
        for (const _0x5a7d1a of _0x1a1a24) {
            const _0xb413e8 = AddBlipForRadius(_0x5a7d1a.coords.x, _0x5a7d1a.coords.y, _0x5a7d1a.coords.z, 100);
            SetBlipAlpha(_0xb413e8, 100);
            SetBlipSprite(_0xb413e8, 9);
            SetBlipColour(_0xb413e8, _0x5a7d1a.color);
            _0x1e23eb.push(_0xb413e8);
        }
        if (_0x1a1a24.length > 0) {
            const _0x51b0e7 = { i18n: ['Contested graffitis marked'] };
            return emit('DoLongHudText', 'Contested graffitis marked', 1, 12000, _0x51b0e7);
        } else {
            const _0x4da4c8 = { i18n: ['No contested graffitis found'] };
            return emit('DoLongHudText', 'No contested graffitis found', 1, 12000, _0x4da4c8);
        }
    };
    ;
    const _0x5e19c3 = [];
    const _0x522b68 = { timeToLive: 600000 };
    // const _0x40ef1f = _0x4737e9.cache(async (_0x14feba, _0x19f793) => {
    //     const _0x6ae3cb = await _0x1b0d0d.execute('fa-gangsystem:getGangNPCWeapon', _0x19f793);
    //     return [
    //         true,
    //         _0x6ae3cb
    //     ];
    // }, _0x522b68);
    const _0x3770a8 = async () => {
        const _0x457c23 = await _0x83b41c();
        for (const _0x21be42 in _0x457c23) {
            _0x5e19c3.push({
                gangId: _0x21be42,
                model: GetHashKey(_0x457c23[_0x21be42])
            });
        }
    };
    const _0x392808 = async (_0x5037a0, _0x55c1a5) => {
        SetCanAttackFriendly(_0x5037a0, true, false);
        SetPedAlertness(_0x5037a0, 3);
        SetPedConfigFlag(_0x5037a0, 100, true);
        SetPedCombatRange(_0x5037a0, 1);
        SetPedSeeingRange(_0x5037a0, 100);
        SetPedHearingRange(_0x5037a0, 1000);
        SetPedDiesWhenInjured(_0x5037a0, false);
        SetPedEnableWeaponBlocking(_0x5037a0, true);
        SetPedSuffersCriticalHits(_0x5037a0, false);
        SetPedAccuracy(_0x5037a0, 90);
        SetPedCombatAbility(_0x5037a0, 2);
        SetPedCombatMovement(_0x5037a0, 3);
        SetPedCombatAttributes(_0x5037a0, 5, true);
        SetPedCombatAttributes(_0x5037a0, 16, true);
        SetPedCombatAttributes(_0x5037a0, 17, false);
        SetPedCombatAttributes(_0x5037a0, 46, true);
        SetPedCombatAttributes(_0x5037a0, 1424, false);
        SetPedFleeAttributes(_0x5037a0, 0, false);
        TaskWanderStandard(_0x5037a0, 1, 10);
        RegisterHatedTargetsAroundPed(_0x5037a0, 500);
        TaskCombatHatedTargetsAroundPed(_0x5037a0, 500, 0);
        SetPedKeepTask(_0x5037a0, true);
        SetBlockingOfNonTemporaryEvents(_0x5037a0, true);
        const _0x49a0f8 = await _0x40ef1f.get(_0x55c1a5);
        GiveWeaponToPed(_0x5037a0, _0x49a0f8 !== null && _0x49a0f8 !== void 0 ? _0x49a0f8 : -1024456158, 1000, false, true);
        SetPedDropsWeaponsWhenDead(_0x5037a0, false);
    };
    const _0x20f682 = _0x28f999 => {
        const _0x300a3c = GetEntityModel(_0x28f999);
        const _0x59d708 = _0x5e19c3.find(_0x37bcdd => _0x37bcdd.model === _0x300a3c);
        return _0x59d708;
    };
    const _0x3c68d7 = (_0x3615fd, _0xef55b5) => {
        const _0xaba389 = GetHashKey('PLAYER');
        const _0x55c9b0 = GetHashKey('GANG_' + _0xef55b5);
        if (!DoesRelationshipGroupExist(_0x55c9b0)) {
            AddRelationshipGroup('GANG_' + _0xef55b5);
        }
        SetRelationshipBetweenGroups(_0x3615fd, _0xaba389, _0x55c9b0);
        SetRelationshipBetweenGroups(_0x3615fd, _0x55c9b0, _0xaba389);
    };
    ;
    class _0x46e1fa {
        constructor(_0x29551e, _0x329529, _0x5a0bfc = 'interval') {
            this.callback = _0x29551e;
            this.delay = _0x329529;
            this.mode = _0x5a0bfc;
            this.scheduled = {};
            this.tick = 0;
            this.data = {};
            this.hooks = new Map([
                [
                    'active',
                    []
                ],
                [
                    'preStop',
                    []
                ],
                [
                    'preStart',
                    []
                ],
                [
                    'afterStop',
                    []
                ],
                [
                    'afterStart',
                    []
                ],
                [
                    'stopAborted',
                    []
                ],
                [
                    'startAborted',
                    []
                ]
            ]);
        }
        get isActive() {
            return this.active;
        }
        async 'start'() {
            if (this.active) {
                return;
            }
            this.aborted = false;
            this.scheduled = {};
            const _0x573206 = this.hooks.get('preStart');
            try {
                for (const _0x3eb18e of _0x573206) {
                    if (!this.aborted) {
                        await _0x3eb18e.call(this);
                    }
                }
            } catch (_0x5c71db) {
                this.aborted = true;
                console.log('Error while calling pre-start hook', _0x5c71db.message);
            }
            if (this.aborted) {
                try {
                    const _0x442055 = this.hooks.get('startAborted');
                    for (const _0x24da0e of _0x442055) {
                        await _0x24da0e.call(this);
                    }
                } catch (_0x4cd019) {
                    console.log('Error while calling start-aborted hook', _0x4cd019.message);
                }
                return;
            }
            this.active = true;
            const _0x562d88 = this.hooks.get('active');
            switch (this.mode) {
            case 'tick': {
                    this.threadId = _0x31eed8.setTick(async () => {
                        this.tick += 1;
                        try {
                            await this.callback.call(this);
                            for (const _0x1ed069 of _0x562d88) {
                                await _0x1ed069.call(this);
                            }
                        } catch (_0x2af874) {
                            console.log('Error while calling active hook', _0x2af874.message);
                        }
                        if (this.delay > 0) {
                            await new Promise(_0x1aa928 => _0x31eed8.setTimeout(_0x1aa928, this.delay));
                        }
                    });
                    break;
                }
            case 'interval': {
                    this.threadId = _0x31eed8.setInterval(async () => {
                        this.tick += 1;
                        try {
                            await this.callback.call(this);
                            for (const _0x6db491 of _0x562d88) {
                                await _0x6db491.call(this);
                            }
                        } catch (_0xd8bb22) {
                            console.log('Error while calling active hook', _0xd8bb22.message);
                        }
                    }, this.delay);
                    break;
                }
            case 'timeout': {
                    const _0x491c36 = () => {
                        if (this.active) {
                            this.threadId = _0x31eed8.setTimeout(async () => {
                                this.tick += 1;
                                try {
                                    await this.callback.call(this);
                                    for (const _0x4c9bae of _0x562d88) {
                                        await _0x4c9bae.call(this);
                                    }
                                } catch (_0x2b549e) {
                                    console.log('Error while calling active hook', _0x2b549e.message);
                                }
                                return _0x491c36();
                            }, this.delay);
                        }
                    };
                    _0x491c36();
                    break;
                }
            }
            const _0x335865 = this.hooks.get('afterStart');
            try {
                for (const _0x15fe64 of _0x335865) {
                    await _0x15fe64.call(this);
                }
            } catch (_0x3b93f7) {
                console.log('Error while calling after-start hook', _0x3b93f7.message);
            }
        }
        async 'stop'() {
            if (!this.active) {
                return;
            }
            const _0x32892d = this.hooks.get('preStop');
            try {
                for (const _0x49d9a6 of _0x32892d) {
                    if (!this.aborted) {
                        await _0x49d9a6.call(this);
                    }
                }
            } catch (_0x752d48) {
                this.aborted = true;
                console.log('Error while calling pre-stop hook', _0x752d48.message);
            }
            this.active = false;
            switch (this.mode) {
            case 'tick': {
                    _0x31eed8.clearTick(this.threadId);
                    break;
                }
            case 'interval': {
                    _0x31eed8.clearInterval(this.threadId);
                    break;
                }
            case 'timeout': {
                    _0x31eed8.clearTimeout(this.threadId);
                    break;
                }
            }
            if (this.aborted) {
                try {
                    const _0x1fa3e5 = this.hooks.get('stopAborted');
                    for (const _0x308db0 of _0x1fa3e5) {
                        await _0x308db0.call(this);
                    }
                } catch (_0x4f6c05) {
                    console.log('Error while calling stop-aborted hook', _0x4f6c05.message);
                }
                return;
            }
            const _0x2fe165 = this.hooks.get('afterStop');
            try {
                for (const _0x471f64 of _0x2fe165) {
                    await _0x471f64.call(this);
                }
            } catch (_0x30d3dd) {
                console.log('Error while calling after-stop hook', _0x30d3dd.message);
            }
        }
        abort() {
            this.aborted = true;
        }
        addHook(_0xecaad8, _0x9d863f) {
            var _0x4bb802;
            if ((_0x4bb802 = this.hooks.get(_0xecaad8)) === null || _0x4bb802 === void 0) {
                void 0;
            } else {
                _0x4bb802.push(_0x9d863f);
            }
        }
        setNextTick(_0x4c262b, _0x202e8d) {
            this.scheduled[_0x4c262b] = this.tick + _0x202e8d;
        }
        canTick(_0x1ffc8a) {
            return this.scheduled[_0x1ffc8a] === undefined || this.tick >= this.scheduled[_0x1ffc8a];
        }
    }
    ;
    const _0x282190 = new _0x46e1fa(function () {
    }, 1000);
    _0x282190.addHook('preStart', function () {
    });
    _0x282190.addHook('active', function () {
        if (!this.canTick('ped')) {
            return;
        }
        this.setNextTick('ped', 5);
        this.data.playerId = PlayerId();
        this.data.playerPed = PlayerPedId();
    });
    ;
    const _0x228a66 = new Set();
    const _0x41abe3 = [-820634585];
    let _0x452fed = [];
    let _0xb904dc = false;
    const _0x3cac42 = async () => {
        await _0x4cd454(10000);
        await _0x4d4b48();
        await _0x4d6cf8();
        await _0x28603d();
        await _0x380159();
        if (_0x282190.isActive) {
            await _0x282190.stop();
        } else {
            await _0x282190.start();
        }
    };
    const _0x4d4b48 = async () => {
        const _0x2dc7de = await _0x83b41c();
        for (const _0x2d0dfd in _0x2dc7de) {
            if (!IsModelValid(_0x2dc7de[_0x2d0dfd])) {
                continue;
            }
            try {
                await _0x283ba5.loadModel(_0x2dc7de[_0x2d0dfd]);
                _0xc9e3d5[_0x2d0dfd] = _0x2dc7de[_0x2d0dfd];
                AddRelationshipGroup('GANG_' + _0x2d0dfd);
            } catch (_0x548410) {
                console.log('Failed to load model', _0x2d0dfd);
            }
        }
    };
    const _0x4d6cf8 = () => {
        console.log('[GangSystem] Initializing ped creation event');
        if (_0x452fed.length === 0) {
            console.log('[GangSystem] Loading blocked models');
            _0x452fed = [..._0x409ea8.blockedModels.map(_0x32f943 => GetHashKey(_0x32f943))];
        }
        on('populationPedCreating', (_0x1c686c, _0xcde012, _0x314747, _0x3454c3, _0x539d86) => {
            if (!_0xc9e3d5 || Math.random() <= 0.5 || _0x452fed.includes(_0x3454c3 & 4294967295)) {
                return;
            }
            const _0x45ef00 = _0x3c57c7(_0x27a81f);
            if (!_0x45ef00 || !_0xc9e3d5[_0x45ef00]) {
                return;
            }
            const _0x550f4f = GetGamePool('CPed').map(_0x13ff77 => GetEntityModel(_0x13ff77)).filter(_0x326575 => GetHashKey(_0xc9e3d5[_0x45ef00]) === _0x326575);
            if (_0x550f4f.length >= 4) {
                return;
            }
            _0x539d86.setModel(_0xc9e3d5[_0x45ef00]);
        });
    };
    let _0x3ba608 = 0;
    const _0x28603d = () => {
        setInterval(async () => {
            const _0x42de34 = GetSelectedPedWeapon(PlayerPedId());
            const _0x44c70d = _0x41abe3.includes(_0x42de34);
            if (IsPedShooting(PlayerPedId()) && GetGameTimer() > _0x3ba608 + 60000 && !_0x44c70d) {
                _0x3ba608 = GetGameTimer();
                const _0x734471 = GetEntityCoords(PlayerPedId(), false);
                const _0x3b856 = _0x3c57c7(_0x19f737);
                const _0x3ae603 = await _0x380159();
                if (!_0x3b856 || _0x3b856 === _0x3ae603) {
                    return;
                }
                const _0x5b5075 = GetGamePool('CPed').filter(_0x43db80 => GetHashKey(_0xc9e3d5[_0x3b856]) === GetEntityModel(_0x43db80) && !IsPedAPlayer(_0x43db80)).filter((_0x14160e, _0x3c6a01) => _0x3c6a01 < 8);
                for (const _0x1707ac of _0x5b5075) {
                    ClearPedTasks(_0x1707ac);
                    NetworkRequestControlOfEntity(_0x1707ac);
                    await _0x392808(_0x1707ac, _0x3b856);
                    SetPedKeepTask(_0x1707ac, true);
                    TaskCombatPed(_0x1707ac, PlayerPedId(), 0, 16);
                }
            }
        }, 3);
    };
    const _0xe3d0d9 = async _0x3d2d9b => {
        const _0xd27321 = await _0x380159();
        if (!_0xd27321) {
            return;
        }
        const _0x425ca8 = GetEntityCoords(_0x3d2d9b, false);
        const _0x5552e0 = {
            x: _0x425ca8[0],
            y: _0x425ca8[1],
            z: _0x425ca8[2]
        };
        const _0x2435f6 = _0x3c57c7(_0x5552e0);
        if (!_0x2435f6) {
            return;
        }
        const _0x221b8b = _0x20f682(_0x3d2d9b);
        if (_0x221b8b.gangId !== _0x2435f6) {
            return;
        }
        const [_0x492c4d, _0xe897a9] = await _0x1b0d0d.execute('fa-gangsystem:canRobGang', _0x2435f6);
        if (!_0x492c4d) {
            return emit('DoLongHudText', _0xe897a9, 2);
        }
        ClearPedTasks(_0x3d2d9b);
        await _0x283ba5.loadAnim('missfbi5ig_22');
        await _0x283ba5.loadAnim('random@shop_robbery');
        NetworkRequestControlOfEntity(_0x3d2d9b);
        TaskSetBlockingOfNonTemporaryEvents(0, true);
        SetEntityAsMissionEntity(_0x3d2d9b, true, true);
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(_0x3d2d9b), false);
        TaskGoToEntity(_0x3d2d9b, PlayerPedId(), -1, 2, 4, 0, 0);
        TaskTurnPedToFaceEntity(_0x3d2d9b, PlayerPedId(), -1);
        TaskTurnPedToFaceEntity(PlayerPedId(), _0x3d2d9b, -1);
        TaskPlayAnim(_0x3d2d9b, 'missfbi5ig_22', 'hands_up_anxious_scientist', 8, 1, -1, 1, -1, false, false, false);
        TaskPlayAnim(PlayerPedId(), 'random@shop_robbery', 'robbery_action_b', 20, -8, -1, 49, 0, false, false, false);
        const _0x555dc8 = GetLabelText(GetNameOfZone(_0x5552e0.x, _0x5552e0.y, _0x5552e0.z));
        const [_0x161157, _0xa45113] = GetStreetNameAtCoord(_0x5552e0.x, _0x5552e0.y, _0x5552e0.z);
        const _0x3c9154 = GetStreetNameFromHashKey(_0x161157) + ', ' + _0x555dc8;
        const _0x1147c3 = { i18n: ['Someone is robbing one of our members'] };
        _0x10bc14.emitNet('fa-gangsystem:notifyGang', 'Someone is robbing one of our members! ' + _0x3c9154, _0x2435f6, _0x1147c3);
        _0x10bc14.emitNet('fa-gangsystem:gangMemberBeingRobbed', _0x2435f6);
        _0xb904dc = true;
        const _0x4bbd77 = GetGamePool('CPed').filter(_0x4e0f98 => GetHashKey(_0xc9e3d5[_0x2435f6]) === GetEntityModel(_0x4e0f98) && !IsPedAPlayer(_0x4e0f98));
        for (const _0x49f1bf of _0x4bbd77) {
            if (_0x49f1bf === _0x3d2d9b) {
                continue;
            }
            ClearPedTasks(_0x49f1bf);
            NetworkRequestControlOfEntity(_0x49f1bf);
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(_0x49f1bf), false);
            await _0x392808(_0x49f1bf, _0x2435f6);
            TaskCombatPed(_0x49f1bf, PlayerPedId(), 0, 16);
        }
        const _0xc708bf = GetGameTimer();
        const _0x520a98 = setInterval(async () => {
            const _0x3dbbc8 = exports['fa-flags'].GetPedFlags(PlayerPedId());
            if (_0xc708bf + 120000 < GetGameTimer() || !_0xb904dc || _0x3dbbc8.isDead) {
                return clearInterval(_0x520a98);
            }
            if (!IsEntityPlayingAnim(PlayerPedId(), 'random@shop_robbery', 'robbery_action_b', 3)) {
                TaskPlayAnim(PlayerPedId(), 'random@shop_robbery', 'robbery_action_b', 20, -8, -1, 49, 0, false, false, false);
            }
            if (!IsEntityPlayingAnim(_0x3d2d9b, 'missfbi5ig_22', 'hands_up_anxious_scientist', 3)) {
                TaskPlayAnim(_0x3d2d9b, 'missfbi5ig_22', 'hands_up_anxious_scientist', 8, 1, -1, 1, -1, false, false, false);
            }
        }, 1000);
        const _0x510c94 = await _0x107ca8(240000, 'Robbing gang member', true);
        _0xb904dc = false;
        ClearPedTasks(PlayerPedId());
        ClearPedTasks(_0x3d2d9b);
        TaskWanderStandard(_0x3d2d9b, 1, 10);
        if (_0x510c94 !== 100) {
            return;
        }
        const [_0x14085d, _0xee2ba6] = await _0x1b0d0d.execute('fa-gangsystem:robGangMember', _0x2435f6);
        if (!_0x14085d) {
            emit('DoLongHudText', _0xee2ba6, 2);
        }
    };
    _0x282190.addHook('active', async function () {
        const _0xd853c0 = GetGamePool('CPed');
        for (const _0x19e0ea of _0xd853c0) {
            const _0xc3d391 = _0x20f682(_0x19e0ea);
            if (_0x228a66.has(_0x19e0ea) || !_0xc3d391) {
                continue;
            }
            const _0x531895 = IsPedAPlayer(_0x19e0ea);
            const _0x2eca44 = GetPedType(_0x19e0ea) === 28;
            if (_0x531895 || _0x2eca44) {
                continue;
            }
            _0x228a66.add(_0x19e0ea);
            TaskSetBlockingOfNonTemporaryEvents(_0x19e0ea, true);
            SetPedFleeAttributes(_0x19e0ea, 0, false);
            SetPedRelationshipGroupHash(_0x19e0ea, GetHashKey('GANG_' + _0xc3d391.gangId));
        }
    });
    ;
    let _0x197f58 = false;
    on('fa-admin:currentDevmode', _0x56f7ae => {
        _0x197f58 = _0x56f7ae;
    });
    _0x10bc14.onNet('fa-gangsystem:refreshGangStatus', () => {
        return _0x52d48a();
    });
    _0x10bc14.onNet('fa-gangsystem:openGangStorage', (_0x312a36, _0x460ec6) => {
        return _0x5e1ef7(_0x460ec6);
    });
    _0x10bc14.on('fa-gangsystem:collectTrapProfit', async () => {
        const _0x5c0d05 = await _0x380159();
        return _0x10bc14.emitNet('fa-gangsystem:collectTrapProfit', _0x5c0d05);
    });
    _0x10bc14.on('fa-gangsystem:collectHistory', () => {
        return _0x277eb8();
    });
    _0x10bc14.onNet('fa-gangsystem:robGangMember', (_0x7dae38, _0x3bc012) => {
        return _0xe3d0d9(_0x3bc012);
    });
    _0x10bc14.on('fa-gangsystem:destroyFlag', (_0x3edaa1, _0x50b3a9, _0x1e5d12) => {
        return _0x514e95(_0x50b3a9, _0x1e5d12);
    });
    _0x10bc14.on('fa-gangsystem:purchaseGangSpray', () => {
        return _0x57b326();
    });
    _0x10bc14.on('fa-gangsystem:purchaseScrubbingCloth', () => {
        return _0x2bf6c3();
    });
    _0x10bc14.on('fa-gangsystem:handOverSpray', (_0x11cc5c, _0x3d9b36, _0x34a4a3) => {
        return _0x2ba201(_0x34a4a3);
    });
    _0x10bc14.onNet('fa-gangsystem:sendEmail', async _0x2f328b => {
        const _0x3ebcd3 = { i18n: [] };
        emit('phone:emailReceived', 'Unknown', 'IMPORTANT!', _0x2f328b, _0x3ebcd3);
        await _0x576673('GANG', 'READ EMAIL APP', 'exclamation-triangle');
    });
    _0x10bc14.onNet('fa-gangsystem:incomingInvite', async (_0x103b09, _0x470baa, _0x4835b4) => {
        const _0x1a3d84 = await _0x576673('Gang invitation', _0x4835b4 + ' is inviting you to join their group.', 'user-ninja');
        if (!_0x1a3d84) {
            return;
        }
        const [_0x282371, _0x3ac24b] = await _0x1b0d0d.execute('fa-gangsystem:acceptGangInvite', _0x103b09, _0x470baa);
        emit('DoLongHudText', _0x3ac24b, _0x282371 ? 1 : 2);
    });
    _0x10bc14.on('fa-gangsystem:discoverGraffiti', (_0x56e3df, _0x266d29, _0xbbfb12) => {
        return _0x54b9ba(_0xbbfb12);
    });
    on('fa-inventory:closed', _0x5ec9b9 => {
        if (!_0x5ec9b9.endsWith('-Traphouse-Storage')) {
            return;
        }
        return _0x50cf14();
    });
    RegisterUICallback('fa-gangsystem:confirmPurchaseSpray', (_0x401354, _0x22da93) => {
        _0x10bc14.emitNet('fa-gangsystem:purchaseGangSpray', _0x401354.key.gangId, _0x401354.key.cost);
        const _0x39648f = { ok: true };
        const _0x14febd = { meta: _0x39648f };
        _0x22da93(_0x14febd);
    });
    RegisterUICallback('fa-gangsystem:confirmPurchaseCloth', (_0x756784, _0x244027) => {
        _0x10bc14.emitNet('fa-gangsystem:purchaseScrubbingCloth', _0x756784.key.cost);
        const _0x2e4565 = { ok: true };
        const _0x24c8ca = { meta: _0x2e4565 };
        _0x244027(_0x24c8ca);
    });
    RegisterUICallback('fa-gangsystem:ui:fetchGangInfo', async (_0x38916c, _0x537737) => {
        const _0x46148f = await _0x1b0d0d.execute('fa-gangsystem:getGanginfo');
        const _0x129f04 = { ok: true };
        const _0x40f0df = { meta: _0x129f04 };
        _0x537737(_0x40f0df);
    });
    RegisterUICallback('fa-gangsystem:ui:kickMember', async (_0x21bb33, _0x285dae) => {
        const _0x4aa406 = await _0x380159();
        const [_0x501c6a, _0x5da120] = await _0x1b0d0d.execute('fa-gangsystem:removeGangMember', _0x4aa406, Number(_0x21bb33.stateId));
        const _0x25a512 = { ok: _0x501c6a };
        const _0x59ff86 = { meta: _0x25a512 };
        _0x285dae(_0x59ff86);
    });
    RegisterUICallback('fa-gangsystem:ui:addMember', async (_0x2ed30a, _0x2720fa) => {
        const _0x34b7f4 = await _0x380159();
        const [_0x4c9d46, _0x447da6] = await _0x1b0d0d.execute('fa-gangsystem:addGangMember', _0x34b7f4, Number(_0x2ed30a.stateId));
        const _0x28ba23 = { ok: _0x4c9d46 };
        const _0x4f5c2c = { meta: _0x28ba23 };
        _0x2720fa(_0x4f5c2c);
    });
    RegisterUICallback('fa-gangsystem:ui:fetchGangProgression', async (_0x39b312, _0x2075d4) => {
        const _0x2f093e = await _0x380159();
        const _0x4c6c22 = await _0x1b0d0d.execute('fa-gangsystem:fetchGangProgression', _0x2f093e);
        const _0x24a954 = { ok: true };
        const _0x1c7563 = { meta: _0x24a954 };
        _0x2075d4(_0x1c7563);
    });
    RegisterUICallback('fa-gangsystem:ui:fetchIsStaff', async (_0x18f4e4, _0x40d23f) => {
        const _0x48bbd1 = await _0x1b0d0d.execute('fa-gangsystem:fetchIsStaff');
        const _0x3c31a4 = { isStaff: _0x48bbd1 && _0x197f58 };
        const _0x2ba2f3 = { ok: true };
        const _0x395dd2 = { meta: _0x2ba2f3 };
        _0x40d23f(_0x395dd2);
    });
    RegisterUICallback('fa-gangsystem:ui:fetchStaffInformation', async (_0x45165a, _0x451ea9) => {
        const _0xf1a0a8 = await _0x1b0d0d.execute('fa-gangsystem:fetchStaffInformation');
        const _0x3422b5 = { ok: true };
        const _0x3a0176 = { meta: _0x3422b5 };
        _0x451ea9(_0x3a0176);
    });
    RegisterUICallback('fa-gangsystem:ui:staffRemoveMember', async (_0x4bf995, _0x46ab38) => {
        const [_0x2fe6d5, _0x4cdb1f] = await _0x1b0d0d.execute('fa-gangsystem:staffRemoveMember', _0x4bf995.groupId, Number(_0x4bf995.stateId));
        const _0x41dac3 = { ok: true };
        const _0x378f3c = { meta: _0x41dac3 };
        _0x46ab38(_0x378f3c);
    });
    RegisterUICallback('fa-gangsystem:ui:staffFetchGangLogs', async (_0x11d9b5, _0x219e36) => {
        const _0x1661b7 = await _0x1b0d0d.execute('fa-gangsystem:staffFetchGangLogs', _0x11d9b5.groupId);
        const _0x59f37c = { logs: _0x1661b7 };
        const _0x5d9b42 = { ok: true };
        const _0x3ee955 = { meta: _0x5d9b42 };
        _0x219e36(_0x3ee955);
    });
    RegisterUICallback('fa-gangsystem:ui:toggleGangBlips', async (_0x1eb3f3, _0x5c10a3) => {
        await _0x2523ff();
        const _0x327d61 = { ok: true };
        const _0x469dbe = { meta: _0x327d61 };
        _0x5c10a3(_0x469dbe);
    });
    RegisterUICallback('fa-gangsystem:ui:toggleContestedGraffitis', async (_0x24b78b, _0xf092cc) => {
        await _0x1d0a33();
        const _0x32165e = { ok: true };
        const _0x45379c = { meta: _0x32165e };
        _0xf092cc(_0x45379c);
    });
    ;
    _0x364abf.g.exports('GetCurrentGang', _0x380159);
    _0x364abf.g.exports('GetCurrentFlagLocation', _0x2b4bb4);
    _0x364abf.g.exports('IsValidGraffitiPlacement', _0x4c64b8);
    _0x364abf.g.exports('RemovingGangSpray', _0x241920);
    _0x364abf.g.exports('GetCurrentGangInfo', _0x19e210);
    _0x364abf.g.exports('InRestrictedArea', _0x5ec211);
    _0x364abf.g.exports('GetGangsPedModels', _0x83b41c);
    ;
    RegisterCommand('fa-gangsystem:toggleGangBlips', async (_0x266921, _0x35ab25) => {
        _0x2523ff(true);
    }, false);
    ;
    const _0x6439ec = () => {
        const _0x1af668 = {
            FYXEvent: 'fa-gangsystem:openGangStorage',
            id: 'gangs_hand_goods',
            icon: 'hand-holding',
            label: 'Hand Goods',
            parameters: {}
        };
        const _0x58b901 = {
            FYXEvent: 'fa-gangsystem:collectTrapProfit',
            id: 'gangs_collect_profit',
            icon: 'money-bill',
            label: 'Collect Profit',
            parameters: {}
        };
        const _0x11e786 = {
            FYXEvent: 'fa-gangsystem:collectHistory',
            id: 'gangs_collect_profit_history',
            icon: 'history',
            label: 'Who has collected profit?',
            parameters: {}
        };
        const _0x4e66e9 = { radius: 2 };
        _0x364abf.g.exports['fa-interact'].AddPeekEntryByEntityType([1], [
            _0x1af668,
            _0x58b901,
            _0x11e786
        ], {
            distance: _0x4e66e9,
            isEnabled: async (_0x284629, _0x172b2a) => {
                const _0x2ff928 = await _0x380159();
                if (!_0x2ff928) {
                    return false;
                }
                const _0xc4fa5d = await _0x83b41c();
                if (!_0xc4fa5d[_0x2ff928]) {
                    return false;
                }
                const _0x49760d = GetHashKey(_0xc4fa5d[_0x2ff928]);
                const _0x45f55b = GetEntityCoords(_0x284629, false);
                const _0x298991 = _0x3c57c7(_0x5d3a80);
                return _0x172b2a.model === _0x49760d && _0x298991 === _0x2ff928 && !IsPedAPlayer(_0x284629) && !IsEntityDead(_0x284629);
            }
        });
        const _0x425895 = {
            FYXEvent: 'fa-gangsystem:robGangMember',
            id: 'gangs_rob_npc',
            icon: 'bullseye',
            label: 'Rob Member',
            parameters: {}
        };
        const _0x8e4efb = { radius: 2 };
        _0x364abf.g.exports['fa-interact'].AddPeekEntryByEntityType([1], [_0x425895], {
            distance: _0x8e4efb,
            isEnabled: async (_0x222252, _0xd9b36) => {
                const _0x336d5e = await _0x380159();
                if (!_0x336d5e) {
                    return false;
                }
                const _0x265adc = GetEntityCoords(_0x222252, false);
                const _0x5db532 = _0x3c57c7(_0x891a6f);
                const _0x501ad3 = await _0x83b41c();
                if (!_0x501ad3[_0x5db532]) {
                    return false;
                }
                const _0x2774e0 = GetHashKey(_0x501ad3[_0x5db532]);
                return _0xd9b36.model === _0x2774e0 && _0x5db532 !== _0x336d5e && !IsPedAPlayer(_0x222252) && !IsEntityDead(_0x222252);
            }
        });
        const _0xa238ad = {
            FYXEvent: 'fa-gangsystem:destroyFlag',
            id: 'gangs_destroy_flag',
            icon: 'trash',
            label: 'Remove Flag',
            parameters: {}
        };
        const _0x981705 = { radius: 2 };
        _0x364abf.g.exports['fa-interact'].AddPeekEntryByModel([GetHashKey('np_gangflag')], [_0xa238ad], {
            distance: _0x981705,
            isEnabled: async (_0x4fee70, _0x2f83e2) => {
                var _0x34585c;
                var _0x20ee07;
                var _0x7b9afd;
                const _0x12f994 = (_0x7b9afd = (_0x20ee07 = (_0x34585c = _0x2f83e2.meta) === null || _0x34585c === void 0 ? void 0 : _0x34585c.data) === null || _0x20ee07 === void 0 ? void 0 : _0x20ee07.metadata) === null || _0x7b9afd === void 0 ? void 0 : _0x7b9afd.gangId;
                if (!_0x12f994) {
                    return false;
                }
                const _0x426fb9 = await _0x380159();
                if (!_0x426fb9) {
                    return false;
                }
                const _0x1556a1 = GetEntityCoords(PlayerPedId(), false);
                const _0x49fd46 = _0x3c57c7(_0x4e499f);
                return _0x426fb9 === _0x49fd46 && _0x49fd46 === _0x12f994;
            }
        });
    };
    ;
    const _0x1b027b = () => {
        var _0x5bdacf;
        const _0x21cde0 = (_0x5bdacf = _0x29cfad('blockVinewoodArea')) !== null && _0x5bdacf !== void 0 ? _0x5bdacf : false;
        if (_0x21cde0) {
            const _0x3737b8 = {
                x: -800,
                y: -521.21
            };
            const _0x2b8a92 = {
                x: -1292.42,
                y: -62.12
            };
            const _0x46d45a = {
                x: -1566.67,
                y: -165.15
            };
            const _0x5c23a5 = {
                x: -1710.61,
                y: -400
            };
            const _0x6b2742 = {
                x: -1976.467,
                y: -224.3751
            };
            const _0x80421a = {
                x: -2364.01,
                y: -436.5
            };
            const _0x2a5267 = {
                x: -2810.61,
                y: -89.39
            };
            const _0x406f87 = {
                x: -3089.39,
                y: -13.64
            };
            const _0x2be610 = {
                x: -3483.33,
                y: 1001.52
            };
            const _0xdb7d = {
                x: -2986.36,
                y: 2601.52
            };
            const _0x40d21e = {
                x: -562.12,
                y: 2953.03
            };
            const _0x1de2af = {
                x: 98.48,
                y: 2540.91
            };
            const _0x2dee66 = {
                x: 1365.15,
                y: 2607.58
            };
            const _0x38d03c = {
                x: 1668.18,
                y: 2850
            };
            const _0x72b998 = {
                x: 1971.21,
                y: 2728.79
            };
            const _0x26c2cf = {
                x: 3298.48,
                y: 1668.18
            };
            const _0x21173e = {
                x: 3225.76,
                y: 13.64
            };
            const _0xf4534a = {
                x: 3092.42,
                y: -804.55
            };
            const _0xb84f2f = {
                x: 1671.21,
                y: -898.48
            };
            const _0x3996f1 = {
                x: 1280.3,
                y: -146.97
            };
            const _0x31a45b = {
                x: 1019.7,
                y: -125.76
            };
            const _0x1c7d95 = {
                x: 783.33,
                y: -65.15
            };
            const _0xa8c829 = {
                x: 610.61,
                y: -537.88
            };
            const _0x4449fc = { id: 'fa-gangsystem:blockedZone' };
            const _0x59c804 = {
                minZ: 0,
                maxZ: 800,
                data: _0x4449fc
            };
            exports['fa-polyzone'].AddPolyZone('fa-gangsystem:blockedZone', [
                _0x3737b8,
                _0x2b8a92,
                _0x46d45a,
                _0x5c23a5,
                _0x6b2742,
                _0x80421a,
                _0x2a5267,
                _0x406f87,
                _0x2be610,
                _0xdb7d,
                _0x40d21e,
                _0x1de2af,
                _0x2dee66,
                _0x38d03c,
                _0x72b998,
                _0x26c2cf,
                _0x21173e,
                _0xf4534a,
                _0xb84f2f,
                _0x3996f1,
                _0x31a45b,
                _0x1c7d95,
                _0xa8c829
            ], _0x59c804);
        }
        const _0x3ffb2e = {
            x: -172.25,
            y: -426.8
        };
        const _0x4e8fb2 = {
            x: -300.07,
            y: -835.61
        };
        const _0x4c7ceb = {
            x: -119,
            y: -1121.23
        };
        const _0x87e960 = {
            x: 90.91,
            y: -1124.24
        };
        const _0x341059 = {
            x: 590.91,
            y: -1133.33
        };
        const _0x6a9c98 = {
            x: 603.03,
            y: -624.24
        };
        const _0x34dc35 = {
            x: 540.91,
            y: -572.73
        };
        const _0x5291d7 = { id: 'fa-gangsystem:blockedZone_downtown' };
        const _0xd1e5ee = {
            minZ: -400,
            maxZ: 800,
            data: _0x5291d7
        };
        exports['fa-polyzone'].AddPolyZone('fa-gangsystem:blockedZone', [
            _0x3ffb2e,
            _0x4e8fb2,
            _0x4c7ceb,
            _0x87e960,
            _0x341059,
            _0x6a9c98,
            _0x34dc35
        ], _0xd1e5ee);
    };
    ;
    async function _0x3f757a() {
        await _0x198dc3();
        await _0x1b0d0d.execute('fa-datagrid:subscribe', 'gang-flags');
        _0x1b027b();
        await _0x3cac42();
        await _0x3770a8();
        _0x6439ec();
    }
    ;
    (async () => {
        await _0x3f757a();
    })();
})();