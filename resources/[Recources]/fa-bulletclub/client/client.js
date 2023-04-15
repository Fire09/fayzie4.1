;(function () {
    'use strict'
    var _0xac6993 = {
        678: function (_0x534c9f, _0x59ee9e) {
          Object.defineProperty(_0x59ee9e, '__esModule', { value: true })
          _0x59ee9e.Hud =
            _0x59ee9e.Interface =
            _0x59ee9e.Utils =
            _0x59ee9e.Streaming =
            _0x59ee9e.Zones =
            _0x59ee9e.Procedures =
            _0x59ee9e.Events =
              void 0
          _0x59ee9e.Events = {
            on: (_0x4af429, _0x12ba93) => {
              return DPX.Events.on(_0x4af429, _0x12ba93)
            },
            onNet: (_0x590ec8, _0x42e66e) => {
              return DPX.Events.onNet(_0x590ec8, _0x42e66e)
            },
            emit: (_0x48e122, ..._0x827523) => {
              return DPX.Events.emit(_0x48e122, ..._0x827523)
            },
            emitNet: (_0x4c7651, ..._0x56a753) => {
              return DPX.Events.emitNet(_0x4c7651, ..._0x56a753)
            },
            remove: (_0x210fa4, _0x69991a) => {
              return DPX.Events.remove(_0x210fa4, _0x69991a)
            },
          }
          _0x59ee9e.Procedures = {
            register: (_0x250d48, _0x99db80) => {
              return DPX.Procedures.register(_0x250d48, _0x99db80)
            },
            execute: (_0x2063ee, ..._0x599124) => {
              return (
                console.log('execute', _0x2063ee, _0x599124),
                DPX.Procedures.execute(_0x2063ee, ..._0x599124)
              )
            },
          }
          _0x59ee9e.Zones = {
            isActive: (_0x1a9aae, _0x2459cc) => {
              return DPX.Zones.isActive(_0x1a9aae, _0x2459cc)
            },
            onEnter: (_0x2845ef, _0x9eaa89) => {
              return DPX.Zones.onEnter(_0x2845ef, _0x9eaa89)
            },
            onExit: (_0x47dacf, _0xfcdb30) => {
              return DPX.Zones.onExit(_0x47dacf, _0xfcdb30)
            },
            addBoxZone: (
              _0xbcbd01,
              _0x45fd32,
              _0x177b02,
              _0x2b5297,
              _0x1625d8,
              _0x57071b,
              _0x54b51f = {}
            ) => {
              return DPX.Zones.addBoxZone(
                _0xbcbd01,
                _0x45fd32,
                _0x177b02,
                _0x2b5297,
                _0x1625d8,
                _0x57071b,
                _0x54b51f
              )
            },
            addBoxTarget: (
              _0x1499e3,
              _0x19df11,
              _0x1a02df,
              _0x522eaa,
              _0x33f5ec,
              _0x374d54,
              _0x528018 = {}
            ) => {
              return DPX.Zones.addBoxTarget(
                _0x1499e3,
                _0x19df11,
                _0x1a02df,
                _0x522eaa,
                _0x33f5ec,
                _0x374d54,
                _0x528018
              )
            },
          }
          _0x59ee9e.Streaming = {
            loadModel: (_0x2a80a1) => {
              return DPX.Streaming.loadModel(_0x2a80a1)
            },
            loadTexture: (_0x2923c5) => {
              return DPX.Streaming.loadTexture(_0x2923c5)
            },
            loadAnim: (_0x21c395) => {
              return DPX.Streaming.loadAnim(_0x21c395)
            },
            loadClipSet: (_0x5e9268) => {
              return DPX.Streaming.loadClipSet(_0x5e9268)
            },
            loadWeaponAsset: (_0xbf7be2, _0x294015, _0x5e144f) => {
              return DPX.Streaming.loadWeaponAsset(_0xbf7be2)
            },
            loadNamedPtfxAsset: (_0x22361b) => {
              return DPX.Streaming.loadNamedPtfxAsset(_0x22361b)
            },
          }
          _0x59ee9e.Utils = {
            cache: (_0x3bac3b, _0x53e624) => {
              return DPX.Utils.cache(_0x3bac3b, _0x53e624)
            },
            cacheableMap: (_0x569b73, _0x5ace11) => {
              return DPX.Utils.cacheableMap(_0x569b73, _0x5ace11)
            },
            waitForCondition: (_0x46ec18, _0xa7c1fb) => {
              return DPX.Utils.waitForCondition(_0x46ec18, _0xa7c1fb)
            },
            getMapRange: (_0x5bb90d, _0x2adc5b, _0x1f95a9) => {
              return DPX.Utils.getMapRange(_0x5bb90d, _0x2adc5b, _0x1f95a9)
            },
            getDistance: (
              [_0x53eca8, _0x545330, _0x140b91],
              [_0x1e844a, _0x1642a0, _0x53dbbe]
            ) => {
              return DPX.Utils.getDistance(
                [_0x53eca8, _0x545330, _0x140b91],
                [_0x1e844a, _0x1642a0, _0x53dbbe]
              )
            },
            getRandomNumber: (_0x5bb79e, _0x39625e) => {
              return DPX.Utils.getRandomNumber(_0x5bb79e, _0x39625e)
            },
          }
          _0x59ee9e.Interface = {
            addPeekEntryByModel: (_0x54dcee, _0xa2bab3, _0x2f031f) => {
              return DPX.Interface.addPeekEntryByModel(
                _0x54dcee,
                _0xa2bab3,
                _0x2f031f
              )
            },
            addPeekEntryByTarget: (_0x5f17ec, _0x2504dc, _0x482c7f) => {
              return DPX.Interface.addPeekEntryByTarget(
                _0x5f17ec,
                _0x2504dc,
                _0x482c7f
              )
            },
            addPeekEntryByFlag: (_0x1cc87b, _0x31884a, _0x537aec) => {
              return DPX.Interface.addPeekEntryByFlag(
                _0x1cc87b,
                _0x31884a,
                _0x537aec
              )
            },
            taskbar: (
              _0x38b0de,
              _0x13cdd1,
              _0x5b0a19 = false,
              _0x20fb74 = null
            ) => {
              return DPX.Interface.taskbar(
                _0x38b0de,
                _0x13cdd1,
                _0x5b0a19,
                _0x20fb74
              )
            },
            phoneConfirmation: (_0x16a8ed, _0x39aeae, _0x5d0910) => {
              return DPX.Interface.phoneConfirmation(
                _0x16a8ed,
                _0x39aeae,
                _0x5d0910
              )
            },
            phoneNotification: (
              _0x57b989,
              _0x130f0e,
              _0x4d63f6,
              _0x1bc1b2 = true
            ) => {
              return DPX.Interface.phoneNotification(
                _0x57b989,
                _0x130f0e,
                _0x4d63f6,
                _0x1bc1b2
              )
            },
          }
          _0x59ee9e.Hud = {
            createBlip: (_0xc4c11f, ..._0x515cbb) => {
              return DPX.Hud.createBlip(_0xc4c11f, ..._0x515cbb)
            },
            applyBlipSettings: (
              _0x210d13,
              _0x4d1009,
              _0x51620d,
              _0x11b73b,
              _0x3e9a7e,
              _0x4d7df3,
              _0x24ae8f,
              _0x39995d
            ) => {
              return DPX.Hud.applyBlipSettings(
                _0x210d13,
                _0x4d1009,
                _0x51620d,
                _0x11b73b,
                _0x3e9a7e,
                _0x4d7df3,
                _0x24ae8f,
                _0x39995d
              )
            },
          }
        },
        615: function (_0x5e3dae, _0x4b842a) {
          Object.defineProperty(_0x4b842a, '__esModule', { value: true })
          _0x4b842a.mathClass = _0x4b842a.loadAnimDict = _0x4b842a.Delay = void 0
          let _0x38c750 = (_0x23449e) =>
            new Promise((_0x3b68c7) => setTimeout(_0x3b68c7, _0x23449e))
          _0x4b842a.Delay = _0x38c750
          async function _0x602b91(_0x1b8bdb) {
            while (!HasAnimDictLoaded(_0x1b8bdb)) {
              RequestAnimDict(_0x1b8bdb)
              await (0, _0x4b842a.Delay)(5)
            }
          }
          _0x4b842a.loadAnimDict = _0x602b91
          class _0x40cffd {
            constructor(_0x54e3c7 = 0, _0x3e9b1c = 0, _0x3606f8 = 0) {
              this.x = _0x54e3c7
              this.y = _0x3e9b1c
              this.z = _0x3606f8
            }
            ['setFromArray'](_0x245cc2) {
              return (
                (this.x = _0x245cc2[0]),
                (this.y = _0x245cc2[1]),
                (this.z = _0x245cc2[2]),
                this
              )
            }
            ['getArray']() {
              return [this.x, this.y, this.z]
            }
            ['add'](_0x140bd9) {
              return (
                (this.x += _0x140bd9.x),
                (this.y += _0x140bd9.y),
                (this.z += _0x140bd9.z),
                this
              )
            }
            ['addScalar'](_0x42d127) {
              return (
                (this.x += _0x42d127),
                (this.y += _0x42d127),
                (this.z += _0x42d127),
                this
              )
            }
            ['sub'](_0x1fabf4) {
              return (
                (this.x -= _0x1fabf4.x),
                (this.y -= _0x1fabf4.y),
                (this.z -= _0x1fabf4.z),
                this
              )
            }
            ['equals'](_0x215e2d) {
              return (
                this.x === _0x215e2d.x &&
                this.y === _0x215e2d.y &&
                this.z === _0x215e2d.z
              )
            }
            ['subScalar'](_0x1a2c21) {
              return (
                (this.x -= _0x1a2c21),
                (this.y -= _0x1a2c21),
                (this.z -= _0x1a2c21),
                this
              )
            }
            ['multiply'](_0x4f3541) {
              return (
                (this.x *= _0x4f3541.x),
                (this.y *= _0x4f3541.y),
                (this.z *= _0x4f3541.z),
                this
              )
            }
            ['multiplyScalar'](_0x12654b) {
              return (
                (this.x *= _0x12654b),
                (this.y *= _0x12654b),
                (this.z *= _0x12654b),
                this
              )
            }
            ['round']() {
              return (
                (this.x = Math.round(this.x)),
                (this.y = Math.round(this.y)),
                (this.z = Math.round(this.z)),
                this
              )
            }
            ['floor']() {
              return (
                (this.x = Math.floor(this.x)),
                (this.y = Math.floor(this.y)),
                (this.z = Math.floor(this.z)),
                this
              )
            }
            ['ceil']() {
              return (
                (this.x = Math.ceil(this.x)),
                (this.y = Math.ceil(this.y)),
                (this.z = Math.ceil(this.z)),
                this
              )
            }
            ['magnitude']() {
              return Math.sqrt(
                this.x * this.x + this.y * this.y + this.z * this.z
              )
            }
            ['normalize']() {
              let _0x4f0dff = this.magnitude
              if (isNaN(_0x4f0dff)) {
                _0x4f0dff = 0
              }
              return this.multiplyScalar(1 / _0x4f0dff)
            }
            ['forward']() {
              const _0x3c2c24 = _0x40cffd
                .fromObject(this)
                .multiplyScalar(Math.PI / 180)
              return new _0x40cffd(
                -Math.sin(_0x3c2c24.z) * Math.abs(Math.cos(_0x3c2c24.x)),
                Math.cos(_0x3c2c24.z) * Math.abs(Math.cos(_0x3c2c24.x)),
                Math.sin(_0x3c2c24.x)
              )
            }
            ['getDistance'](_0x53d82b) {
              const [_0x5b6186, _0x170b95, _0x20cb58] = [
                this.x - _0x53d82b.x,
                this.y - _0x53d82b.y,
                this.z - _0x53d82b.z,
              ]
              return Math.sqrt(
                _0x5b6186 * _0x5b6186 +
                  _0x170b95 * _0x170b95 +
                  _0x20cb58 * _0x20cb58
              )
            }
            ['getDistanceFromArray'](_0x51bd90) {
              const [_0x4371f5, _0x3230b4, _0xa830af] = [
                this.x - _0x51bd90[0],
                this.y - _0x51bd90[1],
                this.z - _0x51bd90[2],
              ]
              return Math.sqrt(
                _0x4371f5 * _0x4371f5 +
                  _0x3230b4 * _0x3230b4 +
                  _0xa830af * _0xa830af
              )
            }
            static ['fromArray'](_0x37451b) {
              return new _0x40cffd(_0x37451b[0], _0x37451b[1], _0x37451b[2])
            }
            static ['fromObject'](_0x9f32d8) {
              return new _0x40cffd(_0x9f32d8.x, _0x9f32d8.y, _0x9f32d8.z)
            }
          }
          _0x4b842a.mathClass = _0x40cffd
        },
      },
      _0x5da375 = {}
    function _0x518d14(_0xe92355) {
      var _0x37ced8 = _0x5da375[_0xe92355]
      if (_0x37ced8 !== undefined) {
        return _0x37ced8.exports
      }
      var _0x31ca91 = (_0x5da375[_0xe92355] = { exports: {} })
      _0xac6993[_0xe92355](_0x31ca91, _0x31ca91.exports, _0x518d14)
      return _0x31ca91.exports
    }
    !(function () {
      _0x518d14.g = (function () {
        if (typeof globalThis === 'object') {
          return globalThis
        }
        try {
          return this || new Function('return this')()
        } catch (_0x5cf35d) {
          if (typeof window === 'object') {
            return window
          }
        }
      })()
    })()
    var _0x45fa42 = {}
    !(function () {
      var _0xf087b6 = _0x45fa42,
        _0x3f7b2d
      _0x3f7b2d = { value: true }
      const _0x5c080c = _0x518d14(615),
        _0x38b1ca = _0x518d14(678)
      let _0x5f16c3 = false,
        _0x576290 = 0,
        _0x2b4ee2 = null,
        _0x5971ad = 0
      const _0x1b1ac3 = new Set(),
        _0x1e05ce = {
          name: 'Airsoft Gun',
          item: '-2084633992',
        },
        _0x302bff = {
          name: 'FN FNX-45',
          item: '1593441988',
        },
        _0x50e666 = {
          name: 'Desert Eagle',
          item: '-1716589765',
        },
        _0xf2c705 = [_0x1e05ce, _0x302bff, _0x50e666]
      _0x38b1ca.Events.onNet(
        'fa-bulletclub:gameStarted',
        (_0x5ad20c, _0x4fdc60, _0x5884b1) => {
          return _0x278f2e(_0x5ad20c, _0x4fdc60, _0x5884b1)
        }
      )
      _0x38b1ca.Events.on('fa-bulletclub:startGame', () => {
        const _0x3c9078 = GetPlayerServerId(PlayerId())
        return _0x38b1ca.Events.emitNet('fa-bulletclub:startGame', _0x3c9078)
      })
      _0x38b1ca.Events.on('fa-bulletclub:modifySettings', () => {
        return _0x12898d()
      })
      _0x38b1ca.Events.on('fa-bulletclub:viewLeaderBoard', (_0x11fb49) => {
        _0x4890c3(_0x11fb49.type)
      })
      _0x38b1ca.Events.onNet('fa-bulletclub:getWeapon', () => {
        _0xc88e74()
      })
      _0x38b1ca.Events.on('fa-bulletclub:resetGameState', () => {
        _0x38b1ca.Events.emitNet('fa-bulletclub:resetGameState')
      })
      _0x38b1ca.Events.onNet('fa-bulletclub:gameReset', () => {
        _0x1ed868()
      })
      RegisterInterfaceCallback(
        'fa-bulletclub:purchaseWeapon',
        (_0x396fca, _0x3c4f20) => {
          const _0x4470e0 = {
              ok: true,
              message: 'done',
            },
            _0x7d11ee = {
              data: {},
              meta: _0x4470e0,
            }
          _0x3c4f20(_0x7d11ee)
          const _0x15d183 = _0x518d14.g.exports[
            'fa-inventory'
          ].GetItemsByItemMetaKV(_0x396fca?.key?.weapon, 'BulletClub', true)
          if (_0x15d183.length > 0) {
            return emit('DoLongHudText', 'You already have this weapon.', 2)
          }
          const _0x580ce9 = {
            BulletClub: true,
            _hideKeys: ['BulletClub'],
          }
          emit(
            'player:receiveItem',
            _0x396fca?.key?.weapon,
            1,
            false,
            _0x580ce9,
            JSON.stringify({})
          )
        }
      )
      onNet('fa-bulletclub:updateHud', (_0x21a871) => {
        if (!_0x3d9643('bullet_club')) {
          return
        }
        const _0x2caba9 = {
          show: true,
          title: 'Bullet Club Range',
          values: _0x21a871,
        }
        _0x518d14.g.exports['fa-interface'].sendAppEvent('status-hud', _0x2caba9)
      })
      onNet('current-items', () => {
        if (_0x3d9643('bullet_club')) {
          return
        }
        _0x450127()
      })
      const _0x3af51e = [
          'cs_orleans',
          'cs_old_man2',
          's_m_m_movalien_01',
          'u_m_y_juggernaut_01',
          'csb_ballasog',
          'csb_rashcosvki',
          'csb_ramp_mex',
          'g_f_y_families_01',
          'g_m_m_chicold_01',
        ],
        _0x278f2e = async (_0x3531be, _0x2e82bb, _0x34dd06) => {
          for (let _0x555b59 = 0; _0x555b59 < _0x3af51e.length; _0x555b59++) {
            await _0x38b1ca.Streaming.loadModel(_0x3af51e[_0x555b59])
          }
          const _0x4618e2 = _0x54a5e1(_0x3531be)
          PlaySoundFrontend(
            -1,
            'Beep_Red',
            'DLC_HEIST_HACKING_SNAKE_SOUNDS',
            false
          )
          emit('DoLongHudText', 'Starting in 3', 1)
          await (0, _0x5c080c.Delay)(1000)
          PlaySoundFrontend(
            -1,
            'Beep_Red',
            'DLC_HEIST_HACKING_SNAKE_SOUNDS',
            false
          )
          emit('DoLongHudText', 'Starting in 2', 1)
          await (0, _0x5c080c.Delay)(1000)
          PlaySoundFrontend(
            -1,
            'Beep_Red',
            'DLC_HEIST_HACKING_SNAKE_SOUNDS',
            false
          )
          emit('DoLongHudText', 'Starting in 1', 1)
          await (0, _0x5c080c.Delay)(1000)
          PlaySoundFrontend(
            -1,
            'Checkpoint_Hit',
            'GTAO_FM_Events_Soundset',
            false
          )
          emit('DoLongHudText', 'Started!', 1)
          _0x576290 = 0
          _0x5f16c3 = true
          const _0x5a8970 = setInterval(() => {
            if (!_0x5f16c3) {
              return clearInterval(_0x5a8970)
            }
            if (_0x2b4ee2 && IsEntityDead(_0x2b4ee2)) {
              if (GetPedSourceOfDeath(_0x2b4ee2) === PlayerPedId()) {
                _0x576290 += 1
                _0x38b1ca.Events.emitNet('fa-bulletclub:targetKilled')
              }
              DeleteEntity(_0x2b4ee2)
              _0x2b4ee2 = null
              const _0x14f44b = _0x17f261(_0x4618e2, _0x34dd06)
              _0x4618e2.splice(_0x14f44b, 1)
              _0x38b1ca.Events.emitNet(
                'fa-bulletclub:updateEnemiesRemaining',
                _0x4618e2.length
              )
            }
            if (GetGameTimer() > _0x5971ad + _0x2e82bb && _0x4618e2.length > 0) {
              DeleteEntity(_0x2b4ee2)
              const _0x294bd7 = _0x17f261(_0x4618e2, _0x34dd06)
              _0x4618e2.splice(_0x294bd7, 1)
              _0x38b1ca.Events.emitNet(
                'fa-bulletclub:updateEnemiesRemaining',
                _0x4618e2.length
              )
            }
            if (
              _0x4618e2.length === 0 &&
              GetGameTimer() > _0x5971ad + _0x2e82bb
            ) {
              clearInterval(_0x5a8970)
              DeleteEntity(_0x2b4ee2)
              emit('DoLongHudText', 'Completed! Score: ' + _0x576290, 1, 12000)
              const _0x5743e6 = GetPlayerServerId(PlayerId())
              _0x38b1ca.Events.emitNet(
                'fa-bulletclub:gameCompleted',
                _0x5743e6,
                _0x576290
              )
              _0x38b1ca.Events.emitNet(
                'fa-bulletclub:updateEnemiesRemaining',
                _0x4618e2.length
              )
              _0x5d255e()
              PlaySoundFrontend(-1, 'RANK_UP', 'HUD_AWARDS', false)
            }
          }, 100)
        },
        _0x12898d = async () => {
          let _0x2147dc
          const _0x39fa20 = {
              id: 'easy',
              name: 'easy',
            },
            _0x15cce6 = {
              id: 'medium',
              name: 'medium',
            },
            _0x1a3225 = {
              id: 'hard',
              name: 'hard',
            },
            _0x3c6b2f = {
              id: 'aimbot',
              name: 'aimbot',
            },
            _0x4c5147 = {
              name: 'difficulty',
              label: 'Mode Difficulty',
              icon: 'time',
              _type: 'select',
              options: [_0x39fa20, _0x15cce6, _0x1a3225, _0x3c6b2f],
            },
            _0x42055b = {
              id: 'true',
              name: 'True',
            },
            _0x2bcc81 = {
              id: 'false',
              name: 'False',
            },
            _0x10fb2d = {
              name: 'strafeEnabled',
              label: 'Strafe Enabled',
              icon: 'shield-alt',
              _type: 'select',
              options: [_0x42055b, _0x2bcc81],
            },
            _0x1253f2 = [_0x4c5147, _0x10fb2d],
            _0x42dcf0 = await _0x518d14.g.exports['fa-interface'].OpenInputMenu(
              _0x1253f2
            )
          if (!_0x42dcf0) {
            return
          }
          const _0x48deb9 =
              (_0x2147dc = _0x42dcf0.difficulty) !== null && _0x2147dc !== void 0
                ? _0x2147dc
                : 'easy',
            _0x4168aa = _0x42dcf0.strafeEnabled === 'true',
            _0x4090bb = {
              difficulty: _0x48deb9,
              strafeEnabled: _0x4168aa,
            }
          _0x38b1ca.Events.emitNet('fa-bulletclub:updateSettings', _0x4090bb)
        },
        _0x4890c3 = async (_0x566cdf) => {
          const _0x24f0f5 = await _0x38b1ca.Procedures.execute(
              'fa-bulletclub:getLeaderBoard',
              _0x566cdf
            ),
            _0x3cbfda = _0x24f0f5.map((_0x2f5e3a) => {
              const _0x36b870 = {
                icon: 'user',
                title: _0x2f5e3a.name,
                description: 'Avg Score: ' + _0x2f5e3a.score,
              }
              return _0x36b870
            })
          if (_0x3cbfda.length <= 0) {
            const _0x5c7503 = {
              icon: 'frown-open',
              title: 'No players yet',
            }
            _0x3cbfda.push(_0x5c7503)
          }
          const _0x3e967b =
              _0x566cdf.charAt(0).toUpperCase() + _0x566cdf.slice(1),
            _0x474f4e = {
              icon: 'user',
              title: 'Leaderboard (' + _0x3e967b + ')',
            }
          _0x3cbfda.unshift(_0x474f4e)
          _0x518d14.g.exports['fa-interface'].showContextMenu(_0x3cbfda)
        },
        _0xc88e74 = () => {
          const _0x18d817 = [],
            _0x349ca3 = {
              icon: 'info-circle',
              title: 'Weapon List',
            }
          _0x18d817.push(_0x349ca3)
          for (const _0x1ba8b2 of _0xf2c705) {
            const _0xfe183a = {
              icon: 'circle',
              title: _0x1ba8b2.name,
              action: 'fa-bulletclub:purchaseWeapon',
              key: { weapon: _0x1ba8b2.item },
            }
            _0x18d817.push(_0xfe183a)
          }
          _0x518d14.g.exports['fa-interface'].showContextMenu(_0x18d817)
        },
        _0x450127 = () => {
          let _0x3110c1 = false
          for (const _0x55c525 of _0xf2c705) {
            const _0x5e7a1a = _0x518d14.g.exports[
              'fa-inventory'
            ].GetItemsByItemMetaKV(_0x55c525.item, 'BulletClub', true)
            _0x5e7a1a.length > 0 &&
              ((_0x3110c1 = true),
              emit(
                'inventory:removeItemByMetaKV',
                _0x55c525.item,
                _0x5e7a1a.length,
                'BulletClub',
                true
              ))
          }
          _0x3110c1 &&
            emit('DoLongHudText', 'Range weapons have been returned...', 1)
        },
        _0x3d9643 = (_0x569395) => {
          return _0x1b1ac3.has(_0x569395)
        }
      on('fa-polyzone:enter', (_0x27dff7) => {
        _0x1b1ac3.add(_0x27dff7)
      })
      on('fa-polyzone:exit', (_0x40fc2) => {
        _0x1b1ac3.delete(_0x40fc2)
      })
      on('fa-polyzone:enter', (_0x38da11) => {
        if (_0x38da11 !== 'bullet_club') {
          return
        }
        _0x38b1ca.Events.emitNet('fa-bulletclub:enteredBuilding')
        SetPedInfiniteAmmoClip(PlayerPedId(), true)
      })
      on('fa-polyzone:exit', (_0x587634) => {
        if (_0x587634 !== 'bullet_club') {
          return
        }
        _0x518d14.g.exports['fa-interface'].sendAppEvent('status-hud', _0x208bee)
        SetPedInfiniteAmmoClip(PlayerPedId(), false)
        _0x450127()
      })
      const _0x17f261 = (_0x218b36, _0x336906) => {
          const _0x398e87 =
              _0x3af51e[Math.floor(Math.random() * _0x3af51e.length)],
            _0x8affc = Math.floor(Math.random() * _0x218b36.length),
            _0x1e8fee = _0x218b36[_0x8affc]
          if (!_0x1e8fee) {
            return -1
          }
          _0x2b4ee2 = CreatePed(
            4,
            GetHashKey(_0x398e87),
            _0x1e8fee.x,
            _0x1e8fee.y,
            _0x1e8fee.z - 1,
            90.666,
            true,
            false
          )
          _0x5971ad = GetGameTimer()
          SetBlockingOfNonTemporaryEvents(_0x2b4ee2, true)
          if (!_0x336906) {
            FreezeEntityPosition(_0x2b4ee2, true)
          }
          PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', false)
          if (_0x336906) {
            const _0x198c51 = _0x36f21e(0, 100) > 50,
              [_0x12bdbd, _0xfb2288, _0xa89cca] =
                GetOffsetFromEntityInWorldCoords(
                  _0x2b4ee2,
                  _0x198c51 ? 4 : -4,
                  0,
                  0
                )
            TaskGoStraightToCoord(
              _0x2b4ee2,
              _0x12bdbd,
              _0xfb2288,
              _0xa89cca,
              10,
              20000,
              0,
              0
            )
          }
          return _0x8affc
        },
        _0x54a5e1 = (_0x1c5dd0) => {
          const _0x104666 = [],
            _0x659142 = [-817.08, -796.41, 19.43]
          let _0x237a50 = _0x1c5dd0
          while (_0x237a50) {
            const _0x187d24 = Math.random() * 2 * Math.PI,
              _0x208b30 = Math.random() * 5 * 5,
              _0x510c22 =
                Math.sqrt(_0x208b30) * Math.cos(_0x187d24) + _0x659142[0],
              _0x456c89 =
                Math.sqrt(_0x208b30) * Math.sin(_0x187d24) + _0x659142[1],
              _0x59133b = {
                x: _0x510c22,
                y: _0x456c89,
                z: _0x659142[2],
              }
            _0x104666.push(_0x59133b)
            _0x237a50--
          }
          return _0x104666
        },
        _0x5d255e = () => {
          _0x5f16c3 = false
          _0x576290 = 0
          _0x2b4ee2 = null
          _0x5971ad = 0
        },
        _0x1ed868 = () => {
          _0x5f16c3 = false
          DeleteEntity(_0x2b4ee2)
          _0x5d255e()
        },
        _0x112e00 = (_0x107a3c, _0xfd3f9) => {
          const [_0x1047d4, _0x28a819, _0x266d79] = [
            _0x107a3c[0] - _0xfd3f9[0],
            _0x107a3c[1] - _0xfd3f9[1],
            _0x107a3c[2] - _0xfd3f9[2],
          ]
          return Math.sqrt(
            _0x1047d4 * _0x1047d4 + _0x28a819 * _0x28a819 + _0x266d79 * _0x266d79
          )
        },
        _0x36f21e = (_0x41413b, _0xe1fbc4) => {
          return Math.floor(
            _0xe1fbc4
              ? Math.random() * (_0xe1fbc4 - _0x41413b) + _0x41413b
              : Math.random() * _0x41413b
          )
        },
        _0x1a5e7c = () => {
          console.log('[Bullet Club] Initializing zones...')
          const _0x3d9631 = {
              x: -821.33,
              y: -796.58,
              z: 19.43,
            },
            _0x20c227 = {
              heading: 0,
              minZ: 18.43,
              maxZ: 22.83,
              zoneEvents: 'fa-bulletclub:updateHud',
              data: { id: 'bullet_club' },
              debugPoly: false,
            }
          _0x518d14.g.exports['fa-polyzone'].AddBoxZone(
            'bullet_club',
            _0x3d9631,
            22.9,
            24.6,
            _0x20c227
          )
          const _0x3e78ec = {
              x: -830,
              y: -796.47,
              z: 19.43,
            },
            _0x36b946 = {
              heading: 0,
              minZ: 18.51,
              maxZ: 19.31,
              data: { id: 'bullet_club_controls' },
              debugPoly: false,
            }
          _0x518d14.g.exports['fa-polytarget'].AddBoxZone(
            'bullet_club_controls',
            _0x3e78ec,
            3.85,
            0.3,
            _0x36b946
          )
          const _0x63a7be = {
              x: -834.04,
              y: -798.08,
              z: 19.42,
            },
            _0x57ca2d = {
              heading: 0,
              minZ: 19.52,
              maxZ: 20.42,
              data: { id: 'bullet_club_leaderboards' },
              debugPoly: false,
            }
          _0x518d14.g.exports['fa-polytarget'].AddBoxZone(
            'bullet_club_leaderboards',
            _0x63a7be,
            1.5,
            0.2,
            _0x57ca2d
          )
        },
        _0x35dc5b = () => {
          console.log('[Bullet Club] Initializing peek entries...')
          const _0x4c168d = {
              APXEvent: 'fa-bulletclub:startGame',
              id: 'bullet_club_start',
              icon: 'play',
              label: 'Start Game ($500)',
            },
            _0x47f55f = { distance: { radius: 3.5 } }
          _0x518d14.g.exports['fa-interact'].AddPeekEntryByPolyTarget(
            'bullet_club_controls',
            [_0x4c168d],
            _0x47f55f
          )
          const _0x51840 = {
            APXEvent: 'fa-bulletclub:resetGameState',
            id: 'bullet_club_reset',
            icon: 'exclamation',
            label: 'Force Reset Game',
          }
          _0x518d14.g.exports['fa-interact'].AddPeekEntryByPolyTarget(
            'bullet_club_controls',
            [_0x51840],
            {
              distance: { radius: 3.5 },
              isEnabled: async () => {
                const _0xd5045e = await _0x518d14.g.exports[
                  'fa-business'
                ].IsEmployedAt('the_bullet_club')
                return _0xd5045e
              },
            }
          )
          const _0x7be691 = {
            APXEvent: 'fa-bulletclub:modifySettings',
            id: 'bullet_club_setting',
            icon: 'cog',
            label: 'Change Settings',
          }
          _0x518d14.g.exports['fa-interact'].AddPeekEntryByPolyTarget(
            'bullet_club_controls',
            [_0x7be691],
            {
              distance: { radius: 3.5 },
              isEnabled: async () => {
                const _0x2faa0a = await _0x518d14.g.exports[
                  'fa-business'
                ].IsEmployedAt('the_bullet_club')
                return _0x2faa0a
              },
            }
          )
          const _0x4acabc = {
            APXEvent: 'fa-bulletclub:getWeapon',
            id: 'bullet_club_getweapon',
            icon: 'hand-paper',
            label: 'Get Weapon',
          }
          _0x518d14.g.exports['fa-interact'].AddPeekEntryByPolyTarget(
            'bullet_club_controls',
            [_0x4acabc],
            _0x47f55f
          )
          const _0x5b2891 = {
              APXEvent: 'fa-bulletclub:viewLeaderBoard',
              id: 'bullet_club_leaderboard',
              icon: 'list',
              label: 'Leaderboard (Easy)',
              parameters: { type: 'easy' },
            },
            _0x2154d5 = {
              APXEvent: 'fa-bulletclub:viewLeaderBoard',
              id: 'bullet_club_leaderboard_medium',
              icon: 'list',
              label: 'Leaderboard (Medium)',
              parameters: { type: 'medium' },
            },
            _0x59eb2c = {
              APXEvent: 'fa-bulletclub:viewLeaderBoard',
              id: 'bullet_club_leaderboard_hard',
              icon: 'list',
              label: 'Leaderboard (Hard)',
              parameters: { type: 'hard' },
            },
            _0x377aa2 = {
              APXEvent: 'fa-bulletclub:viewLeaderBoard',
              id: 'bullet_club_leaderboard_aimbot',
              icon: 'list',
              label: 'Leaderboard (Aimbot)',
              parameters: { type: 'aimbot' },
            }
          _0x518d14.g.exports['fa-interact'].AddPeekEntryByPolyTarget(
            'bullet_club_leaderboards',
            [_0x5b2891, _0x2154d5, _0x59eb2c, _0x377aa2],
            _0x47f55f
          )
        }
      setImmediate(() => {
        console.log('[Bullet Club] Loaded.'), _0x1a5e7c(), _0x35dc5b()
      })
    })()
  })()
  