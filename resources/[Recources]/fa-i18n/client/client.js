(() => {
    const _0x1e9cd6 = {
        '256': (_0x458000, _0x517597, _0x5d286a) => {
            const _0x3023e5 = _0x5d286a(147);
            const _0x26a5e2 = _0x3023e5.translations;
            const _0x195217 = _0x3023e5.hashes;
            let _0x2c741b = null;
            setTimeout(async () => {
                while (!_0x5d286a.g.exports['fa-config'].IsConfigReady()) {
                    await new Promise(_0x259eac => setTimeout(_0x259eac, 1000));
                }
                _0x2c741b = _0x5d286a.g.exports['fa-config'].GetMiscConfig('language.code') || 'en';
            }, 2500);
            _0x5d286a.g.exports('IsReady', () => !!_0x2c741b);
            _0x5d286a.g.exports('GetStringSwap', (_0x4e1b7, _0x1ef258 = false) => {
                var _0x237866;
                var _0x6a9e1c;
                var _0x55b9d1;
                var _0x216eec;
                var _0x2d4d97;
                if (!_0x2c741b || !_0x4e1b7 || _0x2c741b === 'en') {
                    return _0x4e1b7;
                }
                let _0x27b093 = _0x4e1b7;
                try {
                    if (!_0x1ef258) {
                        _0x27b093 = ((_0x237866 = _0x26a5e2 === null || _0x26a5e2 === void 0 ? void 0 : _0x26a5e2[_0x4e1b7]) === null || _0x237866 === void 0 ? void 0 : _0x237866[_0x2c741b]) || _0x4e1b7;
                    } else {
                        if (typeof _0x1ef258 === 'string') {
                            _0x27b093 = _0x27b093.replace(_0x1ef258, ((_0x6a9e1c = _0x26a5e2 === null || _0x26a5e2 === void 0 ? void 0 : _0x26a5e2[_0x1ef258]) === null || _0x6a9e1c === void 0 ? void 0 : _0x6a9e1c[_0x2c741b]) || _0x1ef258);
                        } else {
                            if (Array.isArray(_0x1ef258)) {
                                for (const _0x4d7e03 of _0x1ef258) {
                                    _0x27b093 = _0x27b093.replace(_0x4d7e03, ((_0x55b9d1 = _0x26a5e2 === null || _0x26a5e2 === void 0 ? void 0 : _0x26a5e2[_0x4d7e03]) === null || _0x55b9d1 === void 0 ? void 0 : _0x55b9d1[_0x2c741b]) || _0x4d7e03);
                                }
                            } else {
                                if (typeof _0x1ef258 === 'object' && _0x1ef258.i18n === 'string') {
                                    _0x27b093 = _0x27b093.replace(_0x1ef258.i18n, ((_0x216eec = _0x26a5e2 === null || _0x26a5e2 === void 0 ? void 0 : _0x26a5e2[_0x1ef258.i18n]) === null || _0x216eec === void 0 ? void 0 : _0x216eec[_0x2c741b]) || _0x1ef258.i18n);
                                } else {
                                    if (typeof _0x1ef258 === 'object' && Array.isArray(_0x1ef258.i18n)) {
                                        for (const _0x583136 of _0x1ef258.i18n) {
                                            _0x27b093 = _0x27b093.replace(_0x583136, ((_0x2d4d97 = _0x26a5e2 === null || _0x26a5e2 === void 0 ? void 0 : _0x26a5e2[_0x583136]) === null || _0x2d4d97 === void 0 ? void 0 : _0x2d4d97[_0x2c741b]) || _0x583136);
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch (_0xe0846d) {
                    console.log('getstringswap err', _0xe0846d, JSON.stringify(_0xe0846d));
                }
                const _0x18e349 = _0x27b093 || _0x4e1b7;
                if (!_0x541a6d[_0x18e349]) {
                    _0x541a6d[_0x18e349] = {};
                }
                _0x541a6d[_0x18e349][_0x2c741b] = _0x4e1b7;
                return _0x18e349;
            });
            _0x5d286a.g.exports('GetStringReverse', _0x5dbf15 => {
                var _0x273e1a;
                if (!_0x2c741b || !_0x5dbf15 || _0x2c741b === 'en') {
                    return _0x5dbf15;
                }
                return ((_0x273e1a = _0x541a6d === null || _0x541a6d === void 0 ? void 0 : _0x541a6d[_0x5dbf15]) === null || _0x273e1a === void 0 ? void 0 : _0x273e1a[_0x2c741b]) || _0x5dbf15;
            });
            RegisterUICallback('fa-ui:i18n:getTranslations', (_0x22a387, _0x304b60) => {
                if (!_0x2c741b) {
                    const _0x215889 = { ok: false };
                    const _0x496510 = {
                        data: {},
                        meta: _0x215889
                    };
                    _0x304b60(_0x496510);
                    return;
                }
                const _0x36be08 = GetCurrentLanguage();
                const _0x4b69d1 = {
                    langCode: _0x2c741b,
                    nativeLangCode: _0x36be08,
                    translationsObject: _0x26a5e2,
                    translationHashes: _0x195217
                };
                const _0x5fc6f1 = { ok: true };
                const _0x28f991 = {
                    data: _0x4b69d1,
                    meta: _0x5fc6f1
                };
                _0x304b60(_0x28f991);
            });
            RegisterUICallback('fa-ui:i18n:getCurrentLangCode', (_0x4444d7, _0xff8453) => {
                if (!_0x2c741b) {
                    const _0x45991b = { ok: false };
                    const _0x5a63bc = {
                        data: {},
                        meta: _0x45991b
                    };
                    _0xff8453(_0x5a63bc);
                    return;
                }
                const _0x25a1c6 = { langCode: _0x2c741b };
                const _0x31fb1c = { ok: true };
                const _0x38c370 = {
                    data: _0x25a1c6,
                    meta: _0x31fb1c
                };
                _0xff8453(_0x38c370);
            });
            onNet('fa-i18n:switchLanguage', _0x1ce7eb => {
                _0x2c741b = _0x1ce7eb;
                const _0x5e2c4d = {
                    langCode: _0x2c741b,
                    source: 'fa-nui-i18n',
                    type: 'updateLangCode'
                };
                _0x5d286a.g.exports['fa-ui'].SendUIMessage(_0x5e2c4d);
                emit('fa-i18n:languageChanged');
                emitNet('fa-i18n:languageChanged', _0x2c741b);
            });
            onNet('i18n:translate', (_0x532bad, _0x2a8eab) => {
                if (!_0x2c741b || _0x2c741b !== 'en') {
                    return;
                }
                const _0x88815c = {
                    source: 'fa-nui-i18n',
                    text: _0x532bad,
                    i18nSource: _0x2a8eab
                };
                _0x5d286a.g.exports['fa-ui'].SendUIMessage(_0x88815c);
            });
            RegisterUICallback('fa-ui:i18n:addStringsForTranslation', async (_0x3f8b87, _0x4f722a) => {
                const _0x3878b4 = { ok: true };
                const _0x4e965d = {
                    data: {},
                    meta: _0x3878b4
                };
                _0x4f722a(_0x4e965d);
                for (const _0x3e016e of _0x3f8b87.strings) {
                    emit('i18n:translate', _0x3e016e.string, _0x3e016e.source);
                    await new Promise(_0x36d8e5 => setTimeout(_0x36d8e5, 500));
                }
            });
        },
        '147': _0x483648 => {
            'use strict';
        }
    };
    var _0x148970 = _0x1e9cd6;
    function _0x205a8d(_0x2725e9) {
        if (_0x234eb4[_0x2725e9]) {
            return _0x234eb4[_0x2725e9].exports;
        }
        const _0x1384b3 = { exports: {} };
        var _0xd06c71 = _0x234eb4[_0x2725e9] = _0x1384b3;
        _0x148970[_0x2725e9](_0xd06c71, _0xd06c71.exports, _0x205a8d);
        return _0xd06c71.exports;
    }
    (() => {
        _0x205a8d.g = function () {
            if (typeof globalThis === 'object') {
                return globalThis;
            }
            try {
                return this || new Function('return this')();
            } catch (_0x5eed5f) {
                if (typeof window === 'object') {
                    return window;
                }
            }
        }();
    })();
    (() => {
        'use strict';
        ;
        async function _0x31d3a8() {
        }
        ;
        const _0x2780e7 = GetCurrentResourceName();
        on('onClientResourceStart', async _0x34a196 => {
            if (_0x34a196 !== _0x2780e7) {
                return;
            }
            await _0x31d3a8();
            _0x205a8d(256);
        });
    })();
})();