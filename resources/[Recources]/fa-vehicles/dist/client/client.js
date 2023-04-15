;(() => {
  'use strict'
  var _0x3b9876 = {
      997: (_0x2fd40d, _0x4013f1, _0x38cb75) => {
        Object.defineProperty(_0x4013f1, '__esModule', { value: true })
        _0x4013f1.AnimationTask = void 0
        const _0x3be3a9 = _0x38cb75(615)
        class _0x1ebc2c {
          constructor(
            _0x45237c,
            _0x11ffe6,
            _0x4a818b,
            _0x11625b,
            _0x4b60f2,
            _0x2c140f,
            _0xdbedd0 = 1
          ) {
            this.ped = _0x45237c
            this.type = _0x11ffe6
            this.flag = _0xdbedd0
            this.text = _0x4a818b
            this.active = false
            this.duration = _0x11625b
            this.dictionary = _0x4b60f2
            this.animation = _0x2c140f
            this.tickId = 0
            this.task = ''
          }
          ['start'](_0x178ebd) {
            if (this.active) {
              return
            }
            this.active = true
            _0x178ebd && _0x178ebd()
            this.tickId = setTick(async () => {
              if (
                this.animation &&
                !IsEntityPlayingAnim(
                  this.ped,
                  this.dictionary,
                  this.animation,
                  3
                )
              ) {
                ;(0, _0x3be3a9.requestAnimDict)(this.dictionary)
                TaskPlayAnim(
                  this.ped,
                  this.dictionary,
                  this.animation,
                  -8,
                  -8,
                  -1,
                  this.flag,
                  0,
                  false,
                  false,
                  false
                )
              } else {
                !this.animation &&
                  !IsPedUsingScenario(this.ped, this.dictionary) &&
                  TaskStartScenarioInPlace(this.ped, this.dictionary, 0, true)
              }
              await (0, _0x3be3a9.Delay)(100)
            })
            this.task = ''
            if (this.type === 'skill' && this.duration instanceof Array) {
              this.task = new Promise(async (_0x116add) => {
                const _0x26ceac = this.duration
                for (const _0x34d31d of _0x26ceac) {
                  const _0x405119 = await (0, _0x3be3a9.taskBarSkill)(
                    _0x34d31d.difficulty,
                    _0x34d31d.gap
                  )
                  if (_0x405119 !== 100) {
                    return _0x116add(0)
                  }
                }
                _0x116add(100)
              })
            } else {
              this.type === 'normal' &&
                typeof this.duration === 'number' &&
                (this.task = (0, _0x3be3a9.taskBar)(this.duration, this.text))
            }
            return (
              this.task.then(() => {
                this.stop()
              }),
              this.task
            )
          }
          ['stop']() {
            if (!this.active) {
              return
            }
            this.active = false
            clearTick(this.tickId)
            if (
              !this.animation &&
              IsPedUsingScenario(this.ped, this.dictionary)
            ) {
              ClearPedTasks(this.ped)
              ClearPedTasksImmediately(this.ped)
            } else {
              StopAnimTask(this.ped, this.dictionary, this.animation, 3)
            }
          }
          ['abort']() {
            if (!this.active) {
              return
            }
            _0x38cb75.g.exports['fa-taskbar'].taskCancel()
            this.stop()
          }
        }
        _0x4013f1.AnimationTask = _0x1ebc2c
      },
      769: (_0x127be2, _0x110623) => {
        Object.defineProperty(_0x110623, '__esModule', { value: true })
        _0x110623.Hooks = void 0
        class _0xbdb1f3 {
          constructor(_0x18e5c5, _0x4902a1, _0x4f3c2e = 'interval') {
            this.callback = _0x18e5c5
            this.delay = _0x4902a1
            this.mode = _0x4f3c2e
            this.data = {}
            this.hooks = new Map([
              ['active', []],
              ['preStop', []],
              ['preStart', []],
              ['afterStop', []],
              ['afterStart', []],
              ['stopAborted', []],
              ['startAborted', []],
            ])
            this.active = false
            this.aborted = false
            this.threadId = null
          }
          get ['isActive']() {
            return this.active
          }
          async ['start']() {
            if (this.active) {
              return
            }
            this.aborted = false
            const _0x322a0f = this.hooks.get('preStart')
            try {
              for (const _0x565438 of _0x322a0f) {
                if (!this.aborted) {
                  await _0x565438.call(this)
                }
              }
            } catch (_0x37066a) {
              this.aborted = true
              console.log('Error while calling pre-start hook ' + _0x37066a.message)
            }
            if (this.aborted) {
              try {
                const _0xa679a3 = this.hooks.get('startAborted')
                for (const _0x5da7d9 of _0xa679a3) {
                  await _0x5da7d9.call(this)
                }
              } catch (_0x2c61ac) {
                console.log('Error while calling start-aborted hook ' + _0x2c61ac.message)
              }
              return
            }
            this.active = true
            const _0x122a36 = this.hooks.get('active')
            switch (this.mode) {
              case 'tick': {
                this.threadId = setTick(async () => {
                  await this.callback.call(this)
                  for (const _0x532a0b of _0x122a36) {
                    await _0x532a0b.call(this)
                  }
                  this.delay > 0 &&
                    (await new Promise((_0x12a75c) =>
                      setTimeout(_0x12a75c, this.delay)
                    ))
                })
                break
              }
              case 'interval': {
                this.threadId = setInterval(async () => {
                  await this.callback.call(this)
                  for (const _0x350d90 of _0x122a36) {
                    await _0x350d90.call(this)
                  }
                }, this.delay)
                break
              }
              case 'timeout': {
                if (this.active) {
                  this.threadId = setTimeout(async () => {
                    await this.callback.call(this)
                    for (const _0x1e2e24 of _0x122a36) {
                      await _0x1e2e24.call(this)
                    }
                  }, this.delay)
                }
                break
              }
            }
            const _0x514684 = this.hooks.get('afterStart')
            try {
              for (const _0x725100 of _0x514684) {
                await _0x725100.call(this)
              }
            } catch (_0x3e44cd) {
              console.log('Error while calling after-start hook ' + _0x3e44cd.message)
            }
          }
          async ['stop']() {
            if (!this.active) {
              return
            }
            const _0x3a0da2 = this.hooks.get('preStop')
            try {
              for (const _0x52a346 of _0x3a0da2) {
                if (!this.aborted) {
                  await _0x52a346.call(this)
                }
              }
            } catch (_0x49a40c) {
              ;(this.aborted = true),
                console.log('Error while calling pre-stop hook ' + _0x49a40c.message)
            }
            this.active = false
            switch (this.mode) {
              case 'tick': {
                clearTick(this.threadId)
                break
              }
              case 'interval': {
                clearInterval(this.threadId)
                break
              }
              case 'timeout': {
                clearTimeout(this.threadId)
                break
              }
            }
            if (this.aborted) {
              try {
                const _0x2f9b32 = this.hooks.get('stopAborted')
                for (const _0x5924fc of _0x2f9b32) {
                  await _0x5924fc.call(this)
                }
              } catch (_0x5b2b64) {
                console.log('Error while calling stop-aborted hook ' + _0x5b2b64.message)
              }
            }
            const _0x423530 = this.hooks.get('afterStop')
            try {
              for (const _0x73d974 of _0x423530) {
                await _0x73d974.call(this)
              }
            } catch (_0x31eab8) {
              console.log('Error while calling after-stop hook ' + _0x31eab8.message)
            }
          }
          ['abort']() {
            this.aborted = true
          }
          ['addHook'](_0xcd2892, _0x252ca4) {
            let _0x1506f3 = this.hooks.get(_0xcd2892)
            if (_0x1506f3 !== null) {
              _0x1506f3.push(_0x252ca4)
            }
          }
        }
        _0x110623.Hooks = _0xbdb1f3
      },
      957: function (_0x410d15, _0xec029f, _0x35983a) {
        var _0x56ca86 =
            (this && this['__createBinding']) ||
            (Object.create
              ? function (_0x56bd01, _0xfc2fb, _0x57313a, _0x15a025) {
                  if (_0x15a025 === undefined) {
                    _0x15a025 = _0x57313a
                  }
                  Object.defineProperty(_0x56bd01, _0x15a025, {
                    enumerable: true,
                    get: function () {
                      return _0xfc2fb[_0x57313a]
                    },
                  })
                }
              : function (_0x39fbe3, _0x3b5bae, _0x17036e, _0x1a2104) {
                  if (_0x1a2104 === undefined) {
                    _0x1a2104 = _0x17036e
                  }
                  _0x39fbe3[_0x1a2104] = _0x3b5bae[_0x17036e]
                }),
          _0x534b95 =
            (this && this['__setModuleDefault']) ||
            (Object.create
              ? function (_0x39e5da, _0x297b9a) {
                  Object.defineProperty(_0x39e5da, 'default', {
                    enumerable: true,
                    value: _0x297b9a,
                  })
                }
              : function (_0xf941ed, _0x4ddaf1) {
                  _0xf941ed.default = _0x4ddaf1
                }),
          _0x55fb27 =
            (this && this['__importStar']) ||
            function (_0x403b7b) {
              if (_0x403b7b && _0x403b7b['__esModule']) {
                return _0x403b7b
              }
              var _0x371a16 = {}
              if (_0x403b7b != null) {
                for (var _0x260696 in _0x403b7b)
                  if (
                    _0x260696 !== 'default' &&
                    Object.prototype.hasOwnProperty.call(_0x403b7b, _0x260696)
                  ) {
                    _0x56ca86(_0x371a16, _0x403b7b, _0x260696)
                  }
              }
              return _0x534b95(_0x371a16, _0x403b7b), _0x371a16
            }
        Object.defineProperty(_0xec029f, '__esModule', { value: true })
        _0xec029f.stalled = _0xec029f.InitEvents = void 0
        const _0x41654d = _0x55fb27(_0x35983a(450)),
          _0x5f5965 = _0x55fb27(_0x35983a(908)),
          _0x489412 = _0x55fb27(_0x35983a(302)),
          _0x79d560 = _0x55fb27(_0x35983a(130)),
          _0xa96701 = _0x35983a(615),
          _0x5f3b8c = _0x35983a(710),
          _0x4f2a55 = _0x35983a(348),
          _0x4c0576 = _0x35983a(235),
          _0x13a6f3 = _0x35983a(450),
          _0x180d9f = _0x35983a(396),
          _0x41d541 = _0x35983a(369),
          _0x4daad8 = _0x35983a(256),
          _0x338ab1 = _0x35983a(996),
          _0x17e240 = _0x35983a(965),
          _0x465121 = _0x35983a(17),
          _0x3f41d9 = _0x35983a(628),
          _0x40670d = _0x35983a(547),
          _0x4a8133 = _0x35983a(343)
        async function _0x54d8b6() {}
        _0xec029f.InitEvents = _0x54d8b6
        RPC.register('SetVehicleNumberPlateText', (src, _0x32c621, plateText) => {
          const netId = NetworkGetEntityFromNetworkId(_0x32c621)
          if (DoesEntityExist(netId)) {
            return SetVehicleNumberPlateText(netId, plateText)
          }
        })
        RPC.register('GetVehicleMod', (src, _0x4f0ca6, _0x58f1cc) => {
          const _0x1bd43a = NetworkGetEntityFromNetworkId(_0x4f0ca6)
          if (DoesEntityExist(_0x1bd43a)) {
            return _0x79d560.GetMod(_0x1bd43a, _0x58f1cc)
          }
        })
        RPC.register('GetVehicleMods', (src, _0x14862d) => {
          const _0x43854b = NetworkGetEntityFromNetworkId(_0x14862d)
          if (DoesEntityExist(_0x43854b)) {
            return exports["fa-vehicles"].GetVehicleMods(_0x43854b)
          }
        })
        RPC.register('SetVehicleMod', (src, _0x5496f8, _0x35d294, _0x43422b) => {
          const _0x22713a = NetworkGetEntityFromNetworkId(_0x5496f8)
          if (DoesEntityExist(_0x22713a)) {
            return _0x79d560.SetMod(_0x22713a, _0x35d294, _0x43422b)
          }
        })
        RPC.register('SetVehicleMods', (src, _0x265987, _0x2ac3fe) => {
          const _0x361b98 = NetworkGetEntityFromNetworkId(_0x265987)
          if (DoesEntityExist(_0x361b98)) {
            return _0x79d560.SetMods(_0x361b98, _0x2ac3fe)
          }
        })
        RPC.register('GetVehicleColor', (src, _0x36fbd9, _0x36f210) => {
          const _0x1ad263 = NetworkGetEntityFromNetworkId(_0x36fbd9)
          if (DoesEntityExist(_0x1ad263)) {
            return _0x489412.GetVehicleColor(_0x1ad263, _0x36f210)
          }
        })
        RPC.register('SetVehicleColor', (src, _0x5f486b, _0x16702d, _0x428d81) => {
          const _0x474aba = NetworkGetEntityFromNetworkId(_0x5f486b)
          if (DoesEntityExist(_0x474aba)) {
            return _0x489412.SetVehicleColor(_0x474aba, _0x16702d, _0x428d81)
          }
        })
        RPC.register('SetVehicleColors', (src, _0x4206bd, _0x54472a) => {
          const _0x388e67 = NetworkGetEntityFromNetworkId(_0x4206bd)
          if (DoesEntityExist(_0x388e67)) {
            return _0x489412.SetVehicleColors(_0x388e67, _0x54472a)
          }
        })
        RPC.register('GetVehicleAdditional', (src, _0x26c508, _0x4f3591) => {
          const _0x3ff0ee = NetworkGetEntityFromNetworkId(_0x26c508)
          if (DoesEntityExist(_0x3ff0ee)) {
            return _0x489412.GetVehicleAdditional(_0x3ff0ee, _0x4f3591)
          }
        })
        RPC.register('SetVehicleAdditional', (src, _0x1fb580, _0x1bdfc5, _0x3a551a) => {
            const _0x3a621d = NetworkGetEntityFromNetworkId(_0x1fb580)
            if (DoesEntityExist(_0x3a621d)) {
              return _0x489412.SetVehicleAdditional(
                _0x3a621d,
                _0x1bdfc5,
                _0x3a551a
              )
            }
          }
        )
        RPC.register('GetVehicleAppearance', (src, _0x5be0ed) => {
          const _0x5914bd = NetworkGetEntityFromNetworkId(_0x5be0ed)
          if (DoesEntityExist(_0x5914bd)) {
            return _0x489412.GetVehicleAppearance(_0x5914bd)
          }
        })
        RPC.register('SetVehicleAppearance', (src, _0x322cbb, _0x1ad178) => {
          const _0x4dcf54 = NetworkGetEntityFromNetworkId(_0x322cbb)
          if (DoesEntityExist(_0x4dcf54)) {
            return _0x489412.SetVehicleAppearance(_0x4dcf54, _0x1ad178)
          }
        })
        RPC.register('FetchVehicleDamage', (src, _0x57a0c0) => {
          const _0x11ee8e = NetworkGetEntityFromNetworkId(_0x57a0c0)
          if (DoesEntityExist(_0x11ee8e)) {
            return _0x489412.FetchVehicleDamage(_0x11ee8e)
          }
        })
        RPC.register('RestoreVehicleDamage', (src, _0x33c9ee, _0x313a5d) => {
          const _0x1282a2 = NetworkGetEntityFromNetworkId(_0x33c9ee)
          if (DoesEntityExist(_0x1282a2)) {
            return _0x489412.RestoreVehicleDamage(_0x1282a2, _0x313a5d)
          }
        })
        RPC.register('GetVehicleClassFromName', (src, _0x2d49ce) => {
          const _0xef0947 = typeof _0x2d49ce === 'string' ? GetHashKey(_0x2d49ce) : _0x2d49ce
          return GetVehicleClassFromName(_0xef0947)
        })
        RPC.register('GetVehicleName', (src, _0x1655e4) => {
          const _0x6c191d = typeof _0x1655e4 === 'string' ? GetHashKey(_0x1655e4) : _0x1655e4
          return GetLabelText(GetDisplayNameFromVehicleModel(_0x6c191d))
        })
        onNet('pnp:vehicles:setKeys', (_0x56bae3) => {
          if (!_0x56bae3) {
            return
          }
          _0x5f3b8c.Keys.clear()
          _0x56bae3.forEach((_0x22f487) => _0x5f3b8c.Keys.add(_0x22f487))
          _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('pnp:vehicles:clearKeys', () => {
          _0x5f3b8c.Keys.clear(), _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('pnp:vehicles:addKey', (_0x6f922e) => {
          if (!_0x5f3b8c.Keys.has(_0x6f922e)) {
            _0x5f3b8c.Keys.add(_0x6f922e)
          }
          _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('pnp:vehicles:removeKey', (_0x564336) => {
          if (_0x5f3b8c.Keys.has(_0x564336)) {
            _0x5f3b8c.Keys.delete(_0x564336)
          }
          _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('pnp:vehicles:addSharedKeys', (_0x4d06c2) => {
          _0x4d06c2.forEach((_0x1b6cd5) => {
            if (!_0x5f3b8c.Keys.has(_0x1b6cd5)) {
              _0x5f3b8c.Keys.add(_0x1b6cd5)
            }
          }),
            _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('pnp:vehicles:removeSharedKeys', (_0x140996) => {
          _0x140996.forEach((_0x3ae592) => {
            if (_0x5f3b8c.Keys.has(_0x3ae592)) {
              _0x5f3b8c.Keys.delete(_0x3ae592)
            }
          }),
            _0x5f5965.ClearGarageVehicleCache(null, true)
        })
        onNet('vehicle:keys:give', async (_0x52f1da) => {
          const _0x49cc53 = PlayerPedId()
          let _0x31b286 = 0
          if (
            _0x52f1da === undefined ||
            _0x52f1da === null ||
            _0x52f1da === 0 ||
            !isNaN(_0x52f1da)
          ) {
            if (GetVehiclePedIsIn(_0x49cc53, false) !== 0) {
              _0x31b286 = GetVehiclePedIsIn(_0x49cc53, false)
            } else {
              _0x31b286 = Number(
                _0x35983a.g.exports['fa-target'].GetCurrentEntity()
              )
            }
          } else {
            _0x31b286 = Number(_0x52f1da)
          }
          if (!(0, _0x5f3b8c.HasVehicleKey)(_0x31b286)) {
            emit('DoLongHudText', 'No keys for target vehicle!', 2)
            return
          }
          const _0x2ecee1 = GetEntityCoords(_0x31b286, false),
            _0x15f6d0 = GetEntityCoords(_0x49cc53, false),
            _0x291294 = GetDistanceBetweenCoords(
              _0x2ecee1.x,
              _0x2ecee1.y,
              _0x2ecee1.z,
              _0x15f6d0.x,
              _0x15f6d0.y,
              _0x15f6d0.z,
              true
            )
          if (Number(_0x291294) > 5) {
            emit('DoLongHudText', 'You are to far away from the vehicle!', 2)
            return
          }
          if (IsPedInAnyVehicle(_0x49cc53, false)) {
            const _0x52f9f7 = _0x31b286
                ? _0x31b286
                : GetVehiclePedIsIn(_0x49cc53, false),
              _0x199ec9 = GetVehicleModelNumberOfSeats(
                GetEntityModel(_0x52f9f7)
              )
            for (
              let _0x22ecb7 = -1;
              _0x22ecb7 < _0x199ec9 - 1;
              _0x22ecb7 += 1
            ) {
              const _0x4ebc66 = GetPedInVehicleSeat(_0x52f9f7, _0x22ecb7)
              if (_0x4ebc66 && _0x4ebc66 !== _0x49cc53) {
                RPC.execute('pnp:vehicles:giveKey', GetPlayerServerId(NetworkGetPlayerIndexFromPed(_0x4ebc66)), GetVehicleNumberPlateText(_0x52f9f7))
              }
            }
          } else {
            const [_0x6a3613, _0x29780c] =
              _0x35983a.g.exports['fa-vehicles'].GetClosestPlayer()
            if (Number(_0x29780c) !== -1 && Number(_0x29780c) < 5) {
              let _0x1c054b = await RPC.execute('pnp:vehicles:giveKey', GetPlayerServerId(_0x6a3613), GetVehicleNumberPlateText(_0x31b286))
              if (!_0x1c054b) {
                return emit('DoLongHudText', 'Error giving keys!', 2)
              }
              emit('DoLongHudText', 'You just gave keys to your vehicles!', 1)
            } else {
              emit('DoLongHudText', 'No player near you!', 2)
            }
          }
        })
        onNet('vehicle:keys:addNew', (pNetId) => {
          const veh = NetworkGetNetworkIdFromEntity(pNetId)
          if (DoesEntityExist(pNetId) && veh !== 0) {
            const model = GetEntityModel(pNetId)
            emitNet('pnp:vehicles:gotKeys', veh, model)
          }
          SetVehRadioStation(Number(pNetId), 'OFF')
          SetVehicleDoorsLocked(Number(pNetId), 1)
        })
        onNet('vehicle:toggleEngine', (_0x10d9bc) => {
          const _0x4bab04 = _0x10d9bc
              ? _0x10d9bc
              : GetVehiclePedIsIn(PlayerPedId(), false),
            _0x1125e8 = IsVehicleEngineOn(_0x4bab04)
          if (_0x1125e8) {
            _0x41654d.TurnOffEngine(_0x4bab04)
          } else {
            _0x41654d.TurnOnEngine(_0x4bab04)
          }
        })
        onNet('vehicle:startEngine', (_0x1537a9) => {
          const _0x2837f9 = _0x1537a9
            ? Number(_0x1537a9)
            : GetVehiclePedIsIn(PlayerPedId(), false)
          _0x41654d.TurnOnEngine(_0x2837f9)
        })
        onNet('vehicle:haltEngine', (_0x4aaafe) => {
          const _0x22eaf5 = _0x4aaafe
            ? Number(_0x4aaafe)
            : GetVehiclePedIsIn(PlayerPedId(), false)
          _0x41654d.TurnOffEngine(_0x22eaf5)
        })
        onNet('vehicle:giveKey', (_0x2f5318, _0x31b6bb) => {
          const _0x1c460d = _0x31b6bb
              ? _0x31b6bb
              : _0x35983a.g.exports['fa-target'].GetCurrentEntity(),
            _0x3036ab = PlayerPedId()
          if (IsPedInAnyVehicle(_0x3036ab, false)) {
            const _0x1613cf = _0x1c460d
                ? _0x1c460d
                : GetVehiclePedIsIn(_0x3036ab, false),
              _0x44cb19 = GetVehicleModelNumberOfSeats(
                GetEntityModel(_0x1613cf)
              )
            for (
              let _0x52bbfa = -1;
              _0x52bbfa < _0x44cb19 - 1;
              _0x52bbfa += 1
            ) {
              const _0x1c7b86 = GetPedInVehicleSeat(_0x1613cf, _0x52bbfa)
              if (_0x1c7b86 && _0x1c7b86 !== _0x3036ab) {
                ;(0, _0x5f3b8c.GiveVehicleKey)(
                  _0x1613cf,
                  GetPlayerServerId(NetworkGetPlayerIndexFromPed(_0x1c7b86))
                )
              }
            }
          } else {
            const [_0x3722e8, _0x3c3a7c] = (0, _0xa96701.GetClosestPlayer)()
            if (_0x3722e8 && _0x3c3a7c <= 5) {
              if (_0x1c460d && _0x1c460d !== 0) {
                ;(0, _0x5f3b8c.GiveVehicleKey)(
                  _0x1c460d,
                  GetPlayerServerId(_0x3722e8)
                )
              } else {
                emit('DoLongHudText', 'Vehicle not found!', 2)
              }
            } else {
              emit('DoLongHudText', 'No player near you!', 2)
            }
          }
        })
        onNet('vehicle:refuel:showMenu', (_0x192057, _0x540ffe, _0x41ba60) => {
          const _0x1c5ff2 = exports["fa-vehicles"].GetVehicleFuel(_0x540ffe)
          let _0x33ca49 = 100 - _0x1c5ff2
          if (_0x33ca49 < 0) {
            _0x33ca49 = 0
          }
          if (_0x1c5ff2 >= 100) {
            return emit('DoLongHudText', 'Vehicle is already full!', 2)
          }
          _0x33ca49 = _0x33ca49 + _0x33ca49 * 0.1
          _0x33ca49 = Math.ceil(_0x33ca49)
          // const _0x15fa55 = [
          //   {
          //     title : "Gas Pump",
          //     description : "Select the kind of fuel you want to use",
          //     icon : 'info-circle',
          //     key : "EVENTS.GAS",
          //   },
          //   {
          //     title: 'Regular',
          //     description: "Octane: 87 | Price: $" + _0x33ca49,
          //     action: 'fa-fuel:FuelSelected',
          //     key: "EVENTS.REFUEL",
          //   },
          // ]
          const _0x15fa55 = [
            {
              title: 'Gas Station',
              description: 'The total cost is going to be $' + _0x33ca49 + ', including 10% in taxes.',
              action: 'vehicle:refuel:handler',
              key: {
                entity: _0x540ffe,
                cost: _0x33ca49,
              },
            },
          ]
          _0x35983a.g.exports['fa-ui'].showContextMenu(_0x15fa55)
        })
        onNet('vehicle:checkVIN', async (_0x5c5ae3, _0xc49e86) => {
          if (DoesEntityExist(_0xc49e86)) {
            const _0x221823 = (0, _0x5f3b8c.GetVehicleIdentifier)(_0xc49e86)
            if (_0x221823) {
              const _0x145522 = GetVehicleNumberPlateText(_0xc49e86).trim(),
                _0x576adb = await (0, _0x3f41d9.GetLicensePlate)(_0x221823),
                _0x4031a9 = _0x221823.slice(1, 2),
                _0x377a0e = (0, _0x5f3b8c.IsVinScratched)(_0x221823)
              if (!_0x221823.startsWith('3')) {
                return emit('chatMessage', 'DISPATCH', 2, 'The plate does match the VIN! (' + _0x4031a9 + ')', 'feed', false)
              }
              if (_0x377a0e) {
                emit('chatMessage', 'DISPATCH', 2, 'The VIN is scratched off.', 'feed', false)
              } else {
                if (
                  !_0x576adb.hasVehicleInfo ||
                  (_0x576adb.hasVehicleInfo &&
                    _0x576adb.licensePlate === _0x145522)
                ) {
                  emit('chatMessage', 'DISPATCH', 2, 'The plate does match the VIN! (' + _0x4031a9 + ')', 'feed', false)
                } else {
                  _0x576adb.hasVehicleInfo &&
                    _0x576adb.licensePlate !== _0x145522 &&
                    emit('chatMessage', 'DISPATCH', 3, 'The plate does not match the VIN! The original license plate is ' + _0x576adb.licensePlate, 'feed',  false)
                }
              }
            } else {
              emit('chatMessage', 'DISPATCH', 3, "Can't find anything on this vehicle, not good. Report this to the Government", 'feed', false)
            }
          }
        })
        onNet('vehicle:addFakePlate', async (_0x44a09f, _0x1dd7be) => {
          const _0x297f16 = (0, _0x5f3b8c.GetVehicleIdentifier)(_0x1dd7be)
          if (!_0x297f16.startsWith('3')) {
            return emit('DoLongHudText', "Can't apply fake plates to local cars.", 2)
          }
          ;(0, _0x3f41d9.SetVehicleFakeLicensePlate)(_0x1dd7be, true)
        })
        onNet('vehicle:removeFakePlate', async (_0x4ec6ea, _0x1f02b9) => {
          ;(0, _0x3f41d9.SetVehicleFakeLicensePlate)(_0x1f02b9, false)
        })
        on('vehicle:storeVehicle', (_0x1fbbb5, _0xc407fd) => {
          _0x5f5965.StoreVehicleInGarage(_0xc407fd)
        })
        on('vehicle:garageVehicleList', (_0x316156) => {
          _0x5f5965.OpenGarageVehicleList(_0x316156.nearby, _0x316156.radius)
        })
        onNet('pnp:vehicles:sellPhone', (_0x20d4c, _0x2423fa, _0x249d07) => {
          if (_0x20d4c && _0x5f3b8c.Keys.has(_0x20d4c)) {
            const _0x524e9c = _0x35983a.g.exports.isPed.isPed('cid')
            RPC.execute('pnp:vehicles:sellPhone', _0x524e9c, _0x2423fa, _0x20d4c, _0x249d07)
          } else {
            return emit('DoLongHudText', 'No keys for target vehicle!', 2)
          }
        })
        onNet('pnp:vehicles:sellNotify', (_0x1ed5dd, _0xa3682c, _0x4cbdc5, _0x2765f6, _0x153b40) => {
            const _0x5ba5c3 = _0x35983a.g.exports.isPed.isPed('cid')
            if (_0x1ed5dd === _0x5ba5c3) {
              const _0x9344a5 = _0x2765f6.toLocaleString('en-US', {
                  style: 'currency',
                  currency: 'USD',
                }),
                _0x24f1b8 = _0x9344a5 + ' incl. tax',
                _0x477852 = _0x35983a.g.exports['fa-hone'].DoPhoneConfirmation(30, 'Purchase Vehicle', _0x24f1b8, 'car')
              if (_0x477852) {
                emitNet('pnp:vehicles:sell:vehicle',
                  _0x1ed5dd,
                  _0xa3682c,
                  _0x153b40,
                  _0x2765f6,
                  _0x4cbdc5
                )
              }
            }
          }
        )
        on('vehicle:addNos', (_0x459c4f) => {
          const _0x3fb3f8 = GetVehiclePedIsIn(PlayerPedId(), false),
            _0x2f8f0d = NetworkGetNetworkIdFromEntity(_0x3fb3f8),
            _0x37bf0e = GetEntityModel(_0x3fb3f8),
            _0x10be4f = GetVehicleClass(_0x3fb3f8),
            _0x36f7a8 = (0, _0x5f3b8c.GetVehicleIdentifier)(_0x3fb3f8) || false
          if (_0x10be4f === 18) {
            return
          }
          if (
            IsThisModelACar(_0x37bf0e) ||
            IsThisModelABike(_0x37bf0e) ||
            IsThisModelAQuadbike(_0x37bf0e)
          ) {
            if (_0x36f7a8) {
              if (_0x36f7a8.startsWith('3')) {
                emitNet('pnp:vehicles:addNitro', _0x2f8f0d, _0x459c4f)
              } else {
                emit('DoLongHudText', 'You can only put nos inside a personal vehicle.', 2)
              }
            }
          }
        })
        on('vehicle:addHarness', (_0x57d80e) => {
          const _0x3d5bfa = GetVehiclePedIsIn(PlayerPedId(), false),
            _0x35eb4c = NetworkGetNetworkIdFromEntity(_0x3d5bfa),
            _0xa13c3c = (0, _0x5f3b8c.GetVehicleIdentifier)(_0x3d5bfa) || false
          if (_0xa13c3c) {
            if (_0xa13c3c.startsWith('3')) {
              emitNet('pnp:vehicles:addHarness', _0x35eb4c, _0x57d80e)
            } else {
              emit('DoLongHudText', 'You can only put a harness inside a personal vehicle.', 2)
            }
          }
        })
        onNet('vehicle:refuel:showMenu', async (_0x45e91f, _0x47de13) => {
          const _0x4c9ac4 = _0x45e91f.isJerryCan,
            _0x31eaa5 = _0x4c9ac4
              ? (0, _0x465121.GetJerryCanFuelLevel)()
              : (0, _0x465121.GetVehicleFuel)(_0x47de13),
            _0x49bde6 = GetVehicleClass(_0x47de13) === 15,
            [_0x2c4bde, _0x198aa6] = await (0, _0x465121.GetVehicleRefuelCost)(
              _0x31eaa5,
              _0x4c9ac4 ? 35 : 100,
              _0x49bde6
            )
          _0x35983a.g.exports['fa-ui'].showContextMenu([
            {
              title: 'Gas Station',
              description: 'The total cost is going to be $' + _0x198aa6 + ', including ' + _0x2c4bde + '% in taxes.',
              action: 'vehicle:refuel:handler',
              key: {
                pEntity: _0x47de13,
                pCost: _0x198aa6,
                isJerryCan: _0x4c9ac4,
                isHelicopter: _0x49bde6,
              },
            },
          ])
        })
        onNet('vehicle:refuel:jerryCan', async (_0x3d121f, _0x333e63) => {
          _0x333e63 && (0, _0x465121.RefuelVehicle)(_0x333e63, 0, false, true)
        })
        let _0xf5375d
        onNet('baseevents:enteringVehicle', (_0x3e0ca5, _0x4d31a6, _0x5e663b) => {
            if (_0x4d31a6 === -1 || _0x4d31a6 === 0) {
              if (_0xf5375d) {
                clearTimeout(_0xf5375d)
              }
              _0xf5375d = setTimeout(() => {
                const _0x3af534 = PlayerPedId(),
                  _0x175a8d = NetworkGetEntityIsNetworked(_0x3e0ca5),
                  _0x5643e1 = GetVehicleDoorAngleRatio(_0x3e0ca5, _0x4d31a6 + 1) > 0.1,
                  _0x28da84 = IsPedStill(_0x3af534)
                if (
                  !_0x175a8d ||
                  (!_0x28da84 &&
                    (_0x5643e1 || _0x5e663b === 8 || _0x5e663b === 13))
                ) {
                  TaskWarpPedIntoVehicle(_0x3af534, _0x3e0ca5, _0x4d31a6)
                }
                _0xf5375d = undefined
              }, 2000)
            }
            if (_0x4d31a6 == -1 && _0x3e0ca5) {
              ;(0, _0x17e240.DoorLockCheck)(_0x3e0ca5)
              const _0x3785d3 = IsVehicleSeatFree(_0x3e0ca5, -1) !== true
              if (_0x3785d3) {
                return
              }
              _0x41654d.VerifyEngineState(_0x3e0ca5)
            }
            SetVehicleCanEngineOperateOnFire(_0x3e0ca5, false)
          }
        )
        onNet('baseevents:enteringAborted', () => {
          if (!_0xf5375d) {
            return
          }
          const _0x3cf97c = _0xf5375d
          _0xf5375d = undefined
          clearTimeout(_0x3cf97c)
        })
        onNet('baseevents:enteredVehicle', (_0x4ae17e, _0x2f363d) => {
          _0x41654d.GenerateVehicleInformation(_0x4ae17e)
          _0x41654d.UpdateCurrentVehicle()
          const _0x519348 = GetVehicleClass(_0x4ae17e)
          if (_0x519348 === 18) {
            SetVehicleRadioEnabled(_0x4ae17e, false)
          }
          if (_0x2f363d === -1) {
            _0x41654d.VerifyEngineState(_0x4ae17e)
          }
          const _0x3e94b8 = GetEntityModel(_0x4ae17e)
          if (_0x3e94b8 == GetHashKey('taxi')) {
            emit('taximeter:enteredTaxi')
          }
          if (!_0xf5375d) {
            return
          }
          clearTimeout(_0xf5375d)
          if ((0, _0x40670d.VehicleHasNitro)(_0x4ae17e)) {
            emit('noshud', (0, _0x40670d.GetNitroLevel)(_0x4ae17e), true)
          }
          const _0x31a481 = GetVehicleEngineHealth(_0x4ae17e),
            _0x3532ac = GetVehicleBodyHealth(_0x4ae17e)
          ;(_0x31a481 < 150 || _0x3532ac < 100) &&
            _0x41654d.TurnOffEngine(_0x4ae17e, true)
        })
        onNet('baseevents:leftVehicle', (_0x26a7a4, _0x27fc98) => {
          _0xec029f.stalled = false
          _0x41654d.UpdateCurrentVehicle()
          ;(0, _0x41d541.SetHarness)(false)
          ;(0, _0x41d541.SetSeatBelt)(false)
          const _0x3371c8 = GetEntityModel(_0x26a7a4)
          if (_0x3371c8 == GetHashKey('taxi')) {
            emit('taximeter:ExitedTaxi')
          }
          if (_0x27fc98 === -1 && _0x4f2a55.DriverThread.isActive) {
            _0x4f2a55.DriverThread.stop()
          } else {
            _0x4c0576.PassengerThread.isActive &&
              _0x4c0576.PassengerThread.stop()
          }
        })
        onNet('baseevents:vehicleEngineOn', (_0x38ffec, _0x58991b) => {
          if (_0x58991b === -1 && !_0x4f2a55.DriverThread.isActive) {
            _0x4f2a55.DriverThread.start()
          } else {
            if (
              _0x13a6f3.CurrentSeat !== -1 &&
              !_0x4c0576.PassengerThread.isActive
            ) {
              _0x4c0576.PassengerThread.start()
            }
          }
        })
        onNet('baseevents:vehicleEngineOff', (_0x19fc79, _0x24f6fe) => {
          if (_0x24f6fe === -1 && _0x4f2a55.DriverThread.isActive) {
            _0x4f2a55.DriverThread.stop()
          } else {
            if (
              _0x13a6f3.CurrentSeat !== -1 &&
              _0x4c0576.PassengerThread.isActive
            ) {
              _0x4c0576.PassengerThread.stop()
            }
          }
        })
        onNet('baseevents:vehicleChangedSeat', (_0x1f5303, _0x5bbd57, _0x2405cf) => {
            _0x41654d.UpdateCurrentVehicle()
            ;(0, _0x41d541.SetHarness)(false)
            ;(0, _0x41d541.SetSeatBelt)(false)
            if (_0x5bbd57 === -1 && !_0x4f2a55.DriverThread.isActive) {
              _0x4f2a55.DriverThread.start()
            } else {
              _0x5bbd57 !== -1 &&
                !_0x4c0576.PassengerThread.isActive &&
                _0x4c0576.PassengerThread.start()
            }
            if (_0x2405cf === -1 && _0x4f2a55.DriverThread.isActive) {
              _0x4f2a55.DriverThread.stop()
            } else {
              if (
                _0x5bbd57 === -1 &&
                _0x2405cf !== -1 &&
                _0x4c0576.PassengerThread.isActive
              ) {
                _0x4c0576.PassengerThread.stop()
              }
            }
          }
        )
        _0xec029f.stalled = false
        const _0x13ec16 = (_0x2fe814) => {
          _0xec029f.stalled = _0x2fe814
        }
        _0x4f2a55.DriverThread.addHook('active', async function () {
          if (_0xec029f.stalled) {
            _0x41654d.TurnOffEngine(this.data.vehicle, true)
            await (0, _0xa96701.Delay)(1000)
            ;(0, _0xa96701.PlayEntitySound)(
              this.data.vehicle,
              'Landing_Tone',
              'DLC_PILOT_ENGINE_FAILURE_SOUNDS',
              1000
            )
            await (0, _0xa96701.Delay)(1000)
            ;(0, _0xa96701.PlayEntitySound)(
              this.data.vehicle,
              'Landing_Tone',
              'DLC_PILOT_ENGINE_FAILURE_SOUNDS',
              1000
            )
            _0xec029f.stalled = false
          }
        })
        _0x4f2a55.DriverThread.addHook('afterStart', function () {
          const _0x226d1c = GetEntityModel(this.data.vehicle),
            _0x3b860c = GetVehicleClass(this.data.vehicle),
            _0x2b4480 = GetHashKey('npolmm')
          if (_0x3b860c === 8 || _0x226d1c === _0x2b4480) {
            let _0xa4a255 = GetVehicleHandlingFloat(
              this.data.vehicle,
              'CHandlingData',
              'fSteeringLock'
            )
            _0xa4a255 = Math.ceil(_0xa4a255 * 0.6) + 0.1
            ;(0, _0x180d9f.SetHandlingContextMultiplier)(
              this.data.vehicle,
              'fSteeringLock',
              'bikes',
              'fixed',
              _0xa4a255,
              3
            )
            ;(0, _0x180d9f.ApplyHandlingMultipliers)(
              this.data.vehicle,
              'fSteeringLock'
            )
          }
        })
        onNet('baseevents:vehicleCrashed', async (
            _0x25f418,
            _0x48b346,
            _0x146a5d,
            _0x466652,
            _0xe5a3f4,
            _0x1859e2,
            _0x452eb5,
            _0x502950
          ) => {
            const _0x41ce48 = _0xe5a3f4.z <= -25,
              _0x23b6bb = _0x466652 - _0x146a5d
            let _0xe5c83b = 0
            if (_0x452eb5) {
              ;(0, _0x4daad8.DoRandomDegradation)(_0x25f418, 2, true)
              let _0x5bf4b0 = 0
              _0xe5c83b = Math.floor(50 + _0x1859e2 + _0x466652 * 4.5)
              _0x1859e2 > 40 &&
                (_0x1859e2 > 100 && (_0x1859e2 = 100),
                (_0x5bf4b0 = _0x41d541.HasSeatBeltOn
                  ? Math.floor(_0x1859e2 / 2)
                  : _0x1859e2))
              const _0x104849 = (0, _0xa96701.GetRandom)(100),
                _0x2755e1 = _0x5bf4b0
                  ? (0, _0xa96701.GetRandom)(100) < _0x5bf4b0
                  : false
              if (_0x2755e1 && _0x41d541.HasHarnessOn) {
                ;(0, _0x41d541.DoHarnessDamage)(1)
              } else {
                if (_0x2755e1 && !_0x41ce48) {
                  ;(0, _0x41d541.EjectLUL)(_0x25f418, _0xe5a3f4)
                }
              }
              if (_0x48b346 === -1 && !_0x41ce48) {
                const _0x57c09f = _0x23b6bb * _0x1859e2 * 10
              }
            }
            if (_0x48b346 !== -1) {
              return
            }
            const _0x469a27 = (0, _0xa96701.GetRandom)(50)
            if (_0x469a27 < 25) {
              _0xec029f.stalled = true
            }
            const _0x42abd9 = GetVehicleEngineHealth(_0x25f418),
              _0x117b3e = GetVehicleBodyHealth(_0x25f418),
              _0xf338fe = _0x23b6bb * 4
            let _0x52c895 = _0x42abd9 - _0xe5c83b
            if (isNaN(_0x52c895)) {
              return
            }
            if (_0x52c895 < 150 || _0x117b3e < 100) {
              _0x52c895 = 150
              _0x41654d.TurnOffEngine(_0x25f418, true)
            }
            SetVehicleEngineHealth(_0x25f418, _0x52c895)
            if (
              _0xf338fe < 5 ||
              (isNaN(_0xe5c83b) && (0, _0xa96701.GetRandom)(0, 1) !== 1)
            ) {
              return
            }
            const _0x17e0b3 = GetVehicleNumberOfWheels(_0x25f418)
            for (let _0xfdfb1e = 0; _0xfdfb1e < _0x17e0b3; _0xfdfb1e += 1) {
              ;(0, _0x4daad8.DoRandomTyreDamage)(
                _0x25f418,
                _0xfdfb1e,
                _0x41ce48 ? 500 : _0xf338fe,
                _0x41ce48 ? 1000 : undefined
              )
            }
          }
        )
        RPC.register('pnp:vehicles:getWaterHeight', (src) => {
          const [_0x3e5361, _0x522fcd, _0x56576d] = GetEntityCoords(src, false)
          return TestVerticalProbeAgainstAllWater(_0x3e5361, _0x522fcd, _0x56576d, 32, -1)
        })
        on('pnp:vehicles:examineVehicle', async (_0x2a7968, _0x21d5c3, _0x439e09) => {
            const _0x1953ee = _0x35983a.g.exports['fa-business'].IsEmployedAt('tuner')
            if (!_0x1953ee || (!_0x1953ee && !_0x35983a.g.exports['fa-inventory'].hasEnoughOfItem('advrepairkit', 1,  false))
            ) {
              if (_0x35983a.g.exports['fa-inventory'].hasEnoughOfItem('advrepairkit', 1,  false)) {
                (0, _0x4daad8.ShowVehicleDegradation)(_0x21d5c3, _0x1953ee)
              } else {
                return emit( 'DoLongHudText', 'I cannot examine the vehicle right now.', 2)
              }
            }
            ;(0, _0x4daad8.ShowVehicleDegradation)(_0x21d5c3, _0x1953ee)
          }
        )
        on('fa-vehicles:client:refillNoS', () => {
          return (0, _0x40670d.RefillNOSCan)(100)
        })
        onNet('fa-vehicles:giveNitrous', () => {
          emit('player:receiveItem', 'nitrous', 1, false, {}, JSON.stringify({ Status: 'Empty' }))
        })
        on('onResourceStop', (_0x439a89) => {
          if (_0x439a89 !== GetCurrentResourceName()) {
            return
          }
          ;(0, _0x338ab1.RemoveAllBlips)()
        })
        RegisterCommand('perfrating',  () => {
            const _0x43e739 = GetVehiclePedIsIn(PlayerPedId(), false)
            if (_0x43e739 === 0) {
              return
            }
            console.log('Class: ' + (0, _0x4a8133.GetVehicleRatingClass)(_0x43e739) + ' | Rating: ' + (0, _0x4a8133.GetVehicleRatingNumber)(_0x43e739))
          },
          false
        )
      },
      50: (_0x37d382, _0x1886e1, _0x298501) => {
        var _0x213388
        _0x213388 = { value: true }
        _0x1886e1.j = void 0
        const _0x5e4ced = _0x298501(895),
          _0x31fc98 = _0x298501(957),
          _0x44446e = _0x298501(908),
          _0x986ecf = _0x298501(450),
          _0xde78d3 = _0x298501(519),
          _0x2cd191 = _0x298501(839),
          _0x565d69 = _0x298501(343),
          _0x4c5a80 = _0x298501(413),
          _0xe64347 = _0x298501(230),
          _0x48703a = async () => {
            await (0, _0x5e4ced.InitConfig)()
            await (0, _0x31fc98.InitEvents)()
            await (0, _0x44446e.InitGarages)()
            await (0, _0x986ecf.InitVehicle)()
            await (0, _0xde78d3.InitThreads)()
            await (0, _0x2cd191.InitSystems)()
            await (0, _0x565d69.InitStats)()
            await (0, _0x4c5a80.InitUI)()
            await (0, _0xe64347.InitItem)()
          }
        _0x1886e1.j = _0x48703a
        setImmediate(async () => {
          await (0, _0x1886e1.j)()
        })
      },
      230: (_0x4b3ca0, _0x51d0b0, _0x363f86) => {
        Object.defineProperty(_0x51d0b0, '__esModule', { value: true })
        _0x51d0b0.InitItem = void 0
        const _0x3e6879 = _0x363f86(457),
          _0x2f666d = _0x363f86(784),
          _0x5046d3 = _0x363f86(809),
          _0x24da59 = _0x363f86(926)
        async function _0x55fc74() {
          await (0, _0x2f666d.InitVehicleItems)(),
            await (0, _0x3e6879.InitItemEvents)(),
            await (0, _0x5046d3.InitDegradationItems)(),
            await (0, _0x24da59.InitAnimationList)()
        }
        _0x51d0b0.InitItem = _0x55fc74
      },
      926: (_0x4bdb89, _0x253207, _0x317a36) => {
        Object.defineProperty(_0x253207, '__esModule', { value: true })
        _0x253207.HasAnimationSettings =
          _0x253207.SetAnimationSettings =
          _0x253207.GetAnimationSettings =
          _0x253207.InitAnimationList =
            void 0
        const _0x6436f5 = _0x317a36(615),
          _0x498d6a = new Map()
        async function _0x19a60f() {
          _0x4a58f8.forEach((_0x1e9a98) => {
            _0x2a4b65(_0x1e9a98.name, _0x1e9a98.animation)
          })
        }
        _0x253207.InitAnimationList = _0x19a60f
        const _0x4a58f8 = [
          {
            name: 'repairkit:engine',
            animation: {
              type: 'skill',
              text: 'Repairing vehicle...',
              duration: [
                {
                  difficulty: 60000,
                  gap: (0, _0x6436f5.GetRandom)(10, 18),
                },
              ],
              dictionary: 'mini@repair',
              animation: 'fixing_a_player',
              data: {
                distance: 1.8,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
          {
            name: 'tempmodkit',
            animation: {
              type: 'skill',
              text: 'Installing Vehicle Modification...',
              duration: [
                {
                  get difficulty() {
                    return (0, _0x6436f5.GetRandom)(1500, 3000)
                  },
                  get gap() {
                    return (0, _0x6436f5.GetRandom)(10, 18)
                  },
                },
                {
                  get diffuclty() {
                    return (0, _0x6436f5.GetRandom)(4000, 12000)
                  },
                  get gap() {
                    return (0, _0x6436f5.GetRandom)(10, 18)
                  },
                },
                {
                  get difficulty() {
                    return (0, _0x6436f5.GetRandom)(500, 2000)
                  },
                  get gap() {
                    return (0, _0x6436f5.GetRandom)(10, 18)
                  },
                },
                {
                  get difficulty() {
                    return (0, _0x6436f5.GetRandom)(2000, 3000)
                  },
                  get gap() {
                    return (0, _0x6436f5.GetRandom)(10, 18)
                  },
                },
              ],
              dictionary: 'mini@repair',
              animation: 'fixing_a_player',
              data: {
                distance: 2.5,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
          {
            name: 'degradation:brakes',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
              animation: 'machinic_loop_mechandplayer',
              data: {
                distance: 1.2,
                bones: [
                  'wheel_lf',
                  'wheel_rf',
                  'wheel_lm',
                  'wheel_rm',
                  'wheel_lr',
                  'wheel_rr',
                  'wheel_lm1',
                  'wheel_rm1',
                ],
              },
            },
          },
          {
            name: 'degradation:axle',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
              animation: 'machinic_loop_mechandplayer',
              data: {
                distance: 1.2,
                bones: [
                  'wheel_lf',
                  'wheel_rf',
                  'wheel_lm',
                  'wheel_rm',
                  'wheel_lr',
                  'wheel_rr',
                  'wheel_lm1',
                  'wheel_rm1',
                ],
              },
            },
          },
          {
            name: 'degradation:radiator',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'mp_car_bomb',
              animation: 'car_bomb_mechanic',
              flag: 17,
              data: {
                distance: 2.5,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
          {
            name: 'degradation:clutch',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'WORLD_HUMAN_WELDING',
              animation: '',
              data: {
                distance: 2.6,
                bones: ['bodyshell'],
              },
            },
          },
          {
            name: 'degradation:transmission',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'WORLD_HUMAN_WELDING',
              animation: '',
              data: {
                distance: 2.6,
                bones: ['bodyshell'],
              },
            },
          },
          {
            name: 'degradation:electronics',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'mp_car_bomb',
              animation: 'car_bomb_mechanic',
              data: {
                distance: 2.5,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
          {
            name: 'degradation:injector',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'mini@repair',
              animation: 'fixing_a_player',
              data: {
                distance: 2.5,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
          {
            name: 'degradation:tyres',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
              animation: 'machinic_loop_mechandplayer',
              data: {
                distance: 1.2,
                bones: [
                  'wheel_lf',
                  'wheel_rf',
                  'wheel_lm',
                  'wheel_rm',
                  'wheel_lr',
                  'wheel_rr',
                  'wheel_lm1',
                  'wheel_rm1',
                ],
              },
            },
          },
          {
            name: 'degradation:body',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'WORLD_HUMAN_WELDING',
              animation: '',
              data: {
                distance: 2.6,
                bones: ['bodyshell'],
              },
            },
          },
          {
            name: 'degradation:engine',
            animation: {
              type: 'normal',
              text: 'Repairing vehicle...',
              duration: 20000,
              dictionary: 'mini@repair',
              animation: 'fixing_a_player',
              data: {
                distance: 2.5,
                bones: ['engine', 'engine_l', 'engine_r'],
              },
            },
          },
        ]
        function _0xfe9792(_0x1a6ff8) {
          return _0x498d6a.get(_0x1a6ff8)
        }
        _0x253207.GetAnimationSettings = _0xfe9792
        function _0x2a4b65(_0x2f17a1, _0x2907ab) {
          _0x498d6a.set(_0x2f17a1, _0x2907ab)
        }
        _0x253207.SetAnimationSettings = _0x2a4b65
        function _0x17fd53(_0x1ffe7f) {
          return _0x498d6a.has(_0x1ffe7f)
        }
        _0x253207.HasAnimationSettings = _0x17fd53
      },
      457: (_0x3da443, _0x501dfb, _0x28ec67) => {
        Object.defineProperty(_0x501dfb, '__esModule', { value: true })
        _0x501dfb.RegisterItemCallback = _0x501dfb.InitItemEvents = void 0
        const _0x5e4515 = new Map()
        async function _0x2edbd6() {}
        _0x501dfb.InitItemEvents = _0x2edbd6
        function _0xed2d7b(_0x1b6482, _0x1ae792) {
          _0x5e4515.set(_0x1b6482, _0x1ae792)
        }
        _0x501dfb.RegisterItemCallback = _0xed2d7b
        onNet('RunUseItem', async (_0x357d8, _0x31cf1b, _0x7853a9, _0x2a6e27, _0x25cb35) => {
            if (!_0x5e4515.has(_0x357d8)) {
              return
            }
            const _0x2b93f9 =
                _0x28ec67.g.exports['fa-inventory'].GetItemInfo(_0x31cf1b),
              _0x4f90d0 = _0x5e4515.get(_0x357d8)
            if (!_0x4f90d0) {
              return
            }
            _0x4f90d0(
              _0x357d8,
              _0x31cf1b,
              _0x7853a9,
              _0x2b93f9.quality,
              _0x2a6e27,
              _0x25cb35,
              _0x2b93f9
            )
          }
        )
      },
      784: (_0x580ee1, _0x1d9e2a, _0x12307e) => {
        Object.defineProperty(_0x1d9e2a, '__esModule', { value: true })
        _0x1d9e2a.InstallPart =
          _0x1d9e2a.UseBodyRepairKit =
          _0x1d9e2a.UseHelicopterRepairKit =
          _0x1d9e2a.FixVehicleTire =
          _0x1d9e2a.FixVehicleDegredation =
          _0x1d9e2a.UseVehicleRepairKit =
          _0x1d9e2a.InitVehicleItems =
            void 0
        const _0x54e6f7 = _0x12307e(824),
          _0x15d4d0 = _0x12307e(926),
          _0x33559e = _0x12307e(615),
          _0x580cdc = _0x12307e(433),
          _0x194e77 = _0x12307e(130),
          _0x202fdf = _0x12307e(343),
          _0x167d75 = _0x12307e(256),
          _0x1a6290 = _0x12307e(809)
        async function _0x58fb0b() {}
        _0x1d9e2a.InitVehicleItems = _0x58fb0b
        async function _0x5c2088(_0x58c3aa, _0x1ac716) {
          const _0x50c979 = _0x58c3aa
            ? _0x58c3aa
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0x50c979) {
            return
          }
          const _0x2f3e25 = GetVehicleClass(_0x50c979),
            _0x2c1cb2 = GetVehicleEngineHealth(_0x50c979),
            _0x71e21e = GetVehicleBodyHealth(_0x50c979)
          if (_0x2f3e25 === 15 || _0x2f3e25 === 16) {
            return emit('DoLongHudText', 'Repair kit ineffective for this vehicle.', 2)
          } else {
            if (
              _0x12307e.g.exports['fa-flags'].HasVehicleFlag( _0x50c979,'isScrapVehicle')
            ) {
              return emit('DoLongHudText', 'The vehicle is beyond repair.', 2)
            } else {
              if (
                (_0x1ac716 && _0x2c1cb2 >= 750 && _0x71e21e >= 750) ||
                (!_0x1ac716 && _0x2c1cb2 >= 250 && _0x71e21e >= 250)
              ) {
                return emit('DoLongHudText', 'No further repairs required.', 2)
              }
            }
          }
          const _0x3e60cd = (0, _0x580cdc.GetDistanceFromEngine)(_0x50c979),
            _0x471ae0 = GetEntityCoords(PlayerPedId(), false),
            _0x12f2ae = (0, _0x580cdc.GetDistance)(_0x3e60cd, _0x471ae0)
          if (_0x12f2ae > 1) {
            return emit('DoLongHudText', 'Move closer to the engine.', 2)
          }
          const _0x5a3533 = (0, _0x580cdc.unkFunc41)(_0x50c979, 2, 'bonnet', _0x3e60cd ),
            _0x4647aa = _0x5a3533 <= 2.4 ? 4 : 5
          await (0, _0x580cdc.TurnPedEntity)(PlayerPedId(), _0x58c3aa)
          SetVehicleDoorOpen(_0x50c979, _0x4647aa, false, false)
          const _0x20a4b6 = await (0, _0x54e6f7.PlayAnimation)(PlayerPedId(), _0x58c3aa, 'repairkit:engine')
          SetVehicleDoorShut(_0x50c979, _0x4647aa, false)
          if (_0x20a4b6 !== 100) {
            return
          }
          const _0x9f8c00 = _0x1ac716 ? 750 : 250
          SetVehicleEngineHealth(
            _0x50c979,
            _0x9f8c00 >= _0x2c1cb2 ? _0x9f8c00 : _0x2c1cb2
          )
          SetVehicleBodyHealth(
            _0x50c979,
            _0x9f8c00 >= _0x71e21e ? _0x9f8c00 : _0x71e21e
          )
          emit('inventory:removeItem', _0x1ac716 ? 'advrepairkit' : 'repairkit', 1)
        }
        _0x1d9e2a.UseVehicleRepairKit = _0x5c2088
        async function _0x377aea(_0x41bb14, _0x4c85e9, _0x404f3b, _0x1af1ee = 10) {
          if (!_0x41bb14) {
            return
          }
          const _0x1df2f2 = NetworkGetNetworkIdFromEntity(_0x41bb14),
            _0x3abf0e = (0, _0x167d75.GetVehicleDegradation)(_0x41bb14),
            _0x3b3d19 = (0, _0x202fdf.GetVehicleRatingClass)(_0x41bb14)
          if (!_0x3abf0e) {
            return emit('DoLongHudText', "This vehicle doesn't need to be repaired.", 2)
          }
          const _0x1632fb = _0x3abf0e[_0x4c85e9]
          if (typeof _0x1632fb === 'undefined') {
            return emit('DoLongHudText', 'The vehicle is missing this part.', 2)
          }
          if (_0x404f3b !== _0x3b3d19) {
            return emit('DoLongHudText', 'Part not compatible with vehicle.', 2)
          }
          let _0x5c2235 = (0, _0x15d4d0.GetAnimationSettings)('degradation:' + _0x4c85e9),
            [_0x35e6b2, _0x45c6e1, _0x1db9ae, _0x46a49e] = (0,
            _0x580cdc.GetClosestBone)(_0x41bb14, _0x5c2235.data.bones),
            _0x46835e = false
          if (_0x1db9ae > 10) {
            const _0x488ad5 = GetEntityCoords(_0x41bb14, false),
              _0x218769 = GetEntityCoords(PlayerPedId(), false),
              _0x5a77ee = (0, _0x580cdc.GetDistance)(_0x488ad5, _0x218769)
            if (_0x5a77ee < _0x5c2235.data.distance) {
              _0x5c2235 = Object.assign(Object.assign({}, _0x5c2235), {
                data: Object.assign(Object.assign({}, _0x5c2235.data), {
                  distance: _0x5a77ee + 1,
                }),
              })
              _0x46835e = true
            }
          }
          if (!_0x35e6b2 || _0x46835e) {
            _0x46a49e = GetEntityCoords(_0x41bb14, false)
          } else {
            if (_0x1db9ae > _0x5c2235.data.distance) {
              return emit('DoLongHudText', 'Get closer to the area that needs to be repaired.', 2)
            }
          }
          await (0, _0x580cdc.TurnPedCoords)(PlayerPedId(), _0x46a49e)
          const _0x255f00 = await RPC.execute('pnp:vehicles:degradation:requestRepair',
            _0x1df2f2,
            _0x4c85e9,
            _0x1af1ee
          )
          if (!_0x255f00) {
            return emit('DoLongHudText', "I can't repair right now.", 2)
          }
          const _0x4afce9 = await (0, _0x54e6f7.PlayAnimation)(
            PlayerPedId(),
            _0x41bb14,
            _0x5c2235
          )
          if (_0x4afce9 !== 100) {
            return
          }
          return (
            RPC.execute('pnp:vehicles:degradation:doRepair',
              _0x1df2f2,
              _0x4c85e9,
              _0x1af1ee,
              _0x255f00
            ),
            _0x4afce9 === 100
          )
        }
        _0x1d9e2a.FixVehicleDegredation = _0x377aea
        async function _0x1626a5(_0x57cb05) {
          const _0xa23e71 = _0x57cb05
            ? _0x57cb05
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0xa23e71) {
            return
          }
          if (
            _0x12307e.g.exports['fa-flags'].HasVehicleFlag(_0xa23e71, 'isScrapVehicle')
          ) {
            return emit('DoLongHudText', 'The vehicle tire is beyond repair.', 2)
          }
          const _0x2d5bff = (0, _0x15d4d0.GetAnimationSettings)('degradation:tyres'),
            [_0x563ba2, _0x43f37a, _0x556b13, _0x13d85d] = (0,
            _0x580cdc.GetClosestBone)(_0xa23e71, _0x2d5bff.data.bones)
          if (_0x556b13 > 1.2) {
            return emit('DoLongHudText', 'Move closer to the tire.', 2)
          }
          await (0, _0x580cdc.TurnPedCoords)(PlayerPedId(), _0x13d85d)
          const _0x45fbcf = await (0, _0x54e6f7.PlayAnimation)(
            PlayerPedId(),
            _0xa23e71,
            _0x2d5bff
          )
          if (_0x45fbcf !== 100) {
            return
          }
          const _0x2491ae = (0, _0x1a6290.GetVehicleBoneIndex)(_0x43f37a)
          SetVehicleTyreFixed(_0xa23e71, _0x2491ae)
        }
        _0x1d9e2a.FixVehicleTire = _0x1626a5
        async function _0x3fd447(_0x392808, _0x1d03ad = 1000) {
          const _0x234a2a = _0x392808
            ? _0x392808
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0x234a2a) {
            return
          }
          const _0x55dc82 = await _0x488638(_0x234a2a, 2.4, 'repairkit:engine')
          if (!_0x55dc82) {
            return false
          }
          return (
            SetVehicleEngineHealth(_0x234a2a, _0x1d03ad),
            SetVehicleBodyHealth(_0x234a2a, _0x1d03ad),
            true
          )
        }
        _0x1d9e2a.UseHelicopterRepairKit = _0x3fd447
        async function _0x37af9c(_0x1bfbcb) {
          const _0xa702e4 = _0x1bfbcb
            ? _0x1bfbcb
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0xa702e4) {
            return
          }
          const _0x4fc4a7 = await _0x488638(_0xa702e4, 2.4, 'degradation:body')
          if (!_0x4fc4a7) {
            return false
          }
          return (
            SetVehicleDeformationFixed(_0xa702e4),
            SetVehicleBodyHealth(_0xa702e4, 1000),
            true
          )
        }
        _0x1d9e2a.UseBodyRepairKit = _0x37af9c
        async function _0x69e8c6(_0xc3c9f0, _0x2ede0f, _0x2a8d99, _0x36cc5c) {
          const _0x1654a7 = _0xc3c9f0
            ? _0xc3c9f0
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0x1654a7) {
            return
          }
          const _0x78ea33 = await _0x488638(_0x1654a7, 2.4, _0x2ede0f)
          if (!_0x78ea33) {
            return false
          }
          if (_0x36cc5c !== true) {
            return RPC.execute('fa-vehicles:applyIllegalMod', NetworkGetNetworkIdFromEntity(_0x1654a7), _0x2ede0f)
          }
          switch (_0x2ede0f) {
            case 'turbo': {
              ;(0, _0x194e77.SetMods)(_0x1654a7, { Turbo: 1 })
            }
            case 'engine': {
              ;(0, _0x194e77.SetMods)(_0x1654a7, {
                Engine: (0, _0x33559e.GetRandom)(1, 3),
              })
            }
            case 'transmission': {
              ;(0, _0x194e77.SetMods)(_0x1654a7, {
                Transmission: (0, _0x33559e.GetRandom)(1, 3),
              })
            }
          }
          return true
        }
        _0x1d9e2a.InstallPart = _0x69e8c6
        async function _0x488638(_0x5abfec, _0x51b261, _0x56a1b4) {
          const _0x4ecc4e = _0x5abfec
            ? _0x5abfec
            : _0x12307e.g.exports['fa-target'].GetCurrentEntity()
          if (!_0x4ecc4e) {
            return
          }
          if (
            _0x12307e.g.exports['fa-flags'].HasVehicleFlag(_0x4ecc4e, 'isScrapVehicle')
          ) {
            return emit('DoLongHudText', 'The vehicle is beyond repair.', 2)
          }
          const _0x78b7b9 = GetEntityCoords(_0x4ecc4e, false),
            _0xda308d = GetEntityCoords(PlayerPedId(), false),
            _0x21a4da = (0, _0x580cdc.GetDistance)(_0x78b7b9, _0xda308d)
          if (_0x21a4da > _0x51b261) {
            return emit('DoLongHudText', 'Move closer to the vehicle.', 2)
          }
          await (0, _0x580cdc.TurnPedEntity)(PlayerPedId(), _0x5abfec)
          const _0x4fe0fa = await (0, _0x54e6f7.PlayAnimation)(
            PlayerPedId(),
            _0x5abfec,
            _0x56a1b4
          )
          return _0x4fe0fa === 100
        }
      },
      809: (_0x554511, _0x3bf0db, _0x433d21) => {
        Object.defineProperty(_0x3bf0db, '__esModule', { value: true })
        _0x3bf0db.GetVehicleBoneIndex =
          _0x3bf0db.InitDegradationItems =
          _0x3bf0db.CanUseDegradationRepair =
            void 0
        const _0x13bd5a = _0x433d21(281),
          _0x2eff36 = _0x433d21(615),
          _0x14f3e4 = _0x433d21(710),
          _0xa86721 = _0x433d21(474),
          _0x3590c9 = _0x433d21(457),
          _0x1ba9ae = _0x433d21(784),
          _0x3e1a75 = new _0x13bd5a.Cache(),
          _0x49a828 = [
            'hayes_autos',
            'harmony_repairs',
            'ottos_auto',
            'iron_hog',
            'tuner',
          ],
          _0x4ef0b8 = {
            iron_hog: ['M', 'D', 'C', 'B'],
            harmony_repairs: ['M', 'D', 'C', 'B'],
            hayes_autos: ['M', 'D', 'C', 'B'],
            tuner: ['M', 'D', 'C', 'B', 'A', 'S', 'X'],
            ottos_auto: ['M', 'D', 'C', 'B', 'A', 'S', 'X'],
          },
          _0x5827cc = [
            {
              tier: 'high',
              days: 8,
            },
            {
              tier: 'medium',
              days: 4,
            },
            {
              tier: 'low',
              days: 1,
            },
          ],
          _0xde01ec = [
            {
              name: 'turbokit',
              type: 'turbo',
              health: 1000,
              temp: false,
            },
            {
              name: 'turbotempkit',
              type: 'turbo',
              health: 1000,
              temp: true,
            },
            {
              name: 'enginekit',
              type: 'engine',
              health: 1000,
              temp: false,
            },
            {
              name: 'enginetempkit',
              type: 'engine',
              health: 1000,
              temp: true,
            },
            {
              name: 'transmissionkit',
              type: 'transmission',
              health: 1000,
              temp: false,
            },
            {
              name: 'transmissiontempkit',
              type: 'transmission',
              health: 1000,
              temp: true,
            },
          ],
          _0x7fedc5 = ['M', 'X', 'S', 'A', 'B', 'C', 'D'],
          _0x22ebff = [
            {
              name: 'fixbrake',
              part: 'brakes',
              amount: 10,
            },
            {
              name: 'fixaxle',
              part: 'axle',
              amount: 10,
            },
            {
              name: 'fixradiator',
              part: 'radiator',
              amount: 10,
            },
            {
              name: 'fixclutch',
              part: 'clutch',
              amount: 10,
            },
            {
              name: 'fixtransmission',
              part: 'transmission',
              amount: 10,
            },
            {
              name: 'fixelectronics',
              part: 'electronics',
              amount: 10,
            },
            {
              name: 'fixinjector',
              part: 'injector',
              amount: 10,
            },
            {
              name: 'fixtire',
              part: 'tyres',
              amount: 10,
            },
            {
              name: 'fixbody',
              part: 'body',
              amount: 10,
            },
            {
              name: 'fixengine',
              part: 'engine',
              amount: 10,
            },
          ],
          _0x512b77 = [
            {
              bone: 'wheel_lf',
              index: 0,
            },
            {
              bone: 'wheel_rf',
              index: 1,
            },
            {
              bone: 'wheel_lm',
              index: 2,
            },
            {
              bone: 'wheel_rm',
              index: 3,
            },
            {
              bone: 'wheel_lr',
              index: 4,
            },
            {
              bone: 'wheel_rr',
              index: 5,
            },
            {
              bone: 'wheel_lm1',
              index: 2,
            },
            {
              bone: 'wheel_rm1',
              index: 3,
            },
            {
              bone: 'door_dside_f',
              index: 0,
            },
            {
              bone: 'door_pside_f',
              index: 1,
            },
            {
              bone: 'door_dside_r',
              index: 2,
            },
            {
              bone: 'door_pside_r',
              index: 3,
            },
            {
              bone: 'bonnet',
              index: 4,
            },
            {
              name: 'boot',
              index: 5,
            },
          ]
        function _0x76513(_0x43a55f) {
          if (
            _0x3e1a75.has('degradationRepair') &&
            !_0x3e1a75.isExpired('degradationRepair')
          ) {
            return _0x3e1a75.get('degradationRepair')
          }
          const [_0x2bd0d0, _0x33c7da, _0x3d2bda] = GetEntityCoords(
              PlayerPedId(),
              false
            ),
            _0x4d7c58 = {
              character: { id: _0x433d21.g.exports.isPed.isPed('cid') },
              business: { id: 'tuner' },
              distCheck: true,
              coords: {
                x: _0x2bd0d0,
                y: _0x33c7da,
                z: _0x3d2bda,
              },
            },
            _0x2b3732 = new Promise(async (_0x4748ee) => {
              for (const _0x27c11d of _0x49a828) {
                _0x4d7c58.business.id = _0x27c11d
                const [_0x47af2f] = await RPC.execute('IsEmployedAtBusiness', _0x4d7c58)
                if (_0x47af2f) {
                  const _0x2c9c47 = _0x4ef0b8[_0x4d7c58.business.id]
                  _0x2c9c47 && _0x43a55f && !_0x2c9c47.includes(_0x43a55f)
                    ? _0x4748ee(false)
                    : _0x4748ee(true)
                }
              }
              _0x4748ee(false)
            })
          return _0x3e1a75.set('degradationRepair', _0x2b3732, 15000), _0x2b3732
        }
        _0x3bf0db.CanUseDegradationRepair = _0x76513
        async function _0x5a866d(_0x81c56, _0x1babe3, _0x14106a, _0x85e30d) {
          const _0x14d08b = async () => {
            const _0x269f57 = await _0x76513(_0x14106a)
            if (!_0x269f57) {
              return emit('DoLongHudText', "You're not prepared to do repairs here.", 2)
            }
            if (!_0x433d21.g.exports['fa-inventory'].hasEnoughOfItem('repairtoolkit', 1)) {
              return emit('DoLongHudText', 'You need the proper tools to repair this.', 2)
            }
            const _0x5824b3 = _0x433d21.g.exports['fa-target'].GetCurrentEntity()
            if (!_0x5824b3) {
              return
            }
            let _0x4336c3 = 1
            if (
              _0x433d21.g.exports['fa-inventory'].hasEnoughOfItem(_0x81c56, 2, false)
            ) {
              const _0x14c97c = await (0, _0x2eff36.OpenInputMenu)(
                [
                  {
                    name: 'parts',
                    label: 'Amount of parts to use',
                    icon: 'cogs',
                  },
                ],
                (_0x5780cc) => {
                  return _0x5780cc.parts
                }
              )
              if (_0x14c97c === null) {
                return
              }
              if (!_0x433d21.g.exports['fa-inventory'].hasEnoughOfItem(_0x81c56, _0x14c97c.parts, false)) {
                return emit('DoLongHudText', "You don't have enough parts.", 2)
              }
              _0x4336c3 = _0x14c97c.parts
            }
            const _0x46356d = await (0, _0x1ba9ae.FixVehicleDegredation)(_0x5824b3, _0x1babe3, _0x14106a, _0x85e30d * _0x4336c3)
            if (!_0x46356d) {
              return
            }
            if (_0x1babe3 === 'engine') {
              SetVehicleEngineHealth(_0x5824b3, 1000)
              RPC.execute('fa-vehicles:damage:saveDamage',  NetworkGetNetworkIdFromEntity(_0x5824b3))
            } else {
              _0x1babe3 === 'body' &&
                (SetVehicleBodyHealth(_0x5824b3, 1000),
                SetVehicleFixed(_0x5824b3),
                RPC.execute('fa-vehicles:damage:saveDamage', NetworkGetNetworkIdFromEntity(_0x5824b3)))
            }
            emit('fa-mechanics:client:vehiclePartApplied', _0x4336c3, NetworkGetNetworkIdFromEntity(_0x5824b3), _0x1babe3)
            emit('inventory:removeItem', _0x81c56, _0x4336c3)
          }
          _0x22ebff.forEach((_0x3684db) => {
            for (const _0x514b5a of _0x7fedc5) {
              const _0x595dd5 = '' + _0x514b5a.toLowerCase() + _0x3684db.name
              ;(0, _0x3590c9.RegisterItemCallback)(_0x595dd5, () =>
                _0x14d08b(_0x595dd5, _0x3684db.part, _0x514b5a, _0x3684db.amount)
              )
            }
          })
          ;(0, _0x3590c9.RegisterItemCallback)('advrepairkit', () => {
            const _0x5bb3b9 = _0x433d21.g.exports['fa-target'].GetCurrentEntity()
            ;(0, _0x1ba9ae.UseVehicleRepairKit)(_0x5bb3b9, true)
          })
          ;(0, _0x3590c9.RegisterItemCallback)('repairkit', () => {
            const _0x3b38e4 = _0x433d21.g.exports['fa-target'].GetCurrentEntity()
            ;(0, _0x1ba9ae.UseVehicleRepairKit)(_0x3b38e4, false)
          })
          ;(0, _0x3590c9.RegisterItemCallback)('tirerepairkit', () => {
            const _0x32152c = _0x433d21.g.exports['fa-target'].GetCurrentEntity()
            ;(0, _0x1ba9ae.FixVehicleTire)(_0x32152c)
          })
          ;(0, _0x3590c9.RegisterItemCallback)('helicopterrepairkit', async () => {
              const _0x3ebd49 = _0x433d21.g.exports['fa-target'].GetCurrentEntity(),
                _0xdead96 = GetVehicleClass(_0x3ebd49)
              if (_0xdead96 !== 15) {
                return (emit('DoLongHudText', 'Repair kit ineffective for this vehicle.', 2 ), false)
              }
              const _0x3a7271 = await (0, _0x1ba9ae.UseHelicopterRepairKit)(
                _0x3ebd49
              )
              if (_0x3a7271 !== true) {
                return
              }
              emit('inventory:removeItem', 'helicopterrepairkit', 1)
            }
          )
          ;(0, _0x3590c9.RegisterItemCallback)('bodyrepairkit', async () => {
            const _0x47fd53 = _0x433d21.g.exports['fa-target'].GetCurrentEntity(), 
            _0x17eac7 = await (0, _0x1ba9ae.UseBodyRepairKit)(_0x47fd53)
            if (_0x17eac7 !== true) {
              return
            }
            emit('inventory:removeItem', 'bodyrepairkit', 1)
          })
          _0x5827cc.forEach((_0xe410f0) => {
            const _0x12f862 = 'carpolish_' + _0xe410f0.tier
            ;(0, _0x3590c9.RegisterItemCallback)(
              _0x12f862,
              async (_0x3e1e83) => {
                const _0xa54c2 =
                  _0x433d21.g.exports['fa-target'].GetCurrentEntity()
                if (!_0xa54c2) {
                  return
                }
                const _0xdacfb4 = NetworkGetNetworkIdFromEntity(_0xa54c2)
                if (!_0xdacfb4) {
                  return
                }
                await (0, _0xa86721.ApplyCarPolish)(_0xdacfb4, _0x3e1e83, _0xe410f0.days)
              }
            )
          })
          _0xde01ec.forEach((_0x223ab1) => {
            ;(0, _0x3590c9.RegisterItemCallback)(_0x223ab1.name, async (_0x11bbe8, _0x4a7530, _0x1e1042, _0x36d340) => {
                if (_0x36d340 < 50) {
                  return emit('DoLongHudText', 'Part too beaten-up to be installed.', 2)
                }
                const _0xcc7243 = _0x433d21.g.exports['fa-target'].GetCurrentEntity()
                if (!_0xcc7243) {
                  return
                }
                if (!_0x433d21.g.exports['fa-inventory'].hasEnoughOfItem('Toolbox', 1)) {
                  return emit('DoLongHudText', "You don't have the required tools to perform this action.", 2)
                }
                const _0x46343b = (0, _0x14f3e4.IsVinScratched)(_0xcc7243)
                if (
                  _0x46343b &&
                  _0x46343b.boostingInfo &&
                  _0x46343b.boostingInfo.vinScratch
                ) {
                  return emit('DoLongHudText', "Doesn't seem like I can apply that to this vehicle.", 2)
                }
                emit('inventory:removeItem', _0x223ab1.name, 1)
              }
            )
          })
        }
        _0x3bf0db.InitDegradationItems = _0x5a866d
        RegisterUICallback('pnp:vehicles:examineVehicleRepair', (data, cb) => {
          if (data.key === 'tire') {
            // (_0x1d9e2a.FixVehicleTire)(veh)
          } else {
            (0, _0x3bf0db.InitDegradationItems)(data.key.name, data.key.part, data.key.biz, data.key.amount)
          }

          cb({ data: {}, meta: { ok: true, message: ''} })
        })
        function _0x2e6979(_0x31dd70) {
          return _0x512b77.find((_0x30c47a) => _0x30c47a.bone === _0x31dd70)
            ?.index
        }
        _0x3bf0db.GetVehicleBoneIndex = _0x2e6979
      },
      
      302: (_0x5c83fe, _0x163108, _0x347b27) => {
        Object.defineProperty(_0x163108, '__esModule', { value: true })
        _0x163108.RestoreVehicleDamage =
          _0x163108.FetchVehicleDamage =
          _0x163108.SetVehicleAppearance =
          _0x163108.GetVehicleAppearance =
          _0x163108.SetVehicleColors =
          _0x163108.GetVehicleColors =
          _0x163108.SetVehicleDamage =
          _0x163108.GetVehicleDamage =
          _0x163108.SetVehicleAdditional =
          _0x163108.GetVehicleAdditional =
          _0x163108.SetVehicleColor =
          _0x163108.GetVehicleColor =
          _0x163108.SetVehicleNeons =
          _0x163108.GetVehicleNeons =
          _0x163108.SetVehicleExtras =
          _0x163108.GetVehicleWheelFitment =
          _0x163108.GetVehicleAfterMarket =
          _0x163108.GetVehicleExtras =
            void 0
        function _0x52c9b8(_0x101fb2) {
          const _0x35704f = []
          for (let _0x16596a = 0; _0x16596a < 12; _0x16596a += 1) {
            IsVehicleExtraTurnedOn(_0x101fb2, _0x16596a) &&
              _0x35704f.push(_0x16596a)
          }
          return _0x35704f
        }
        _0x163108.GetVehicleExtras = _0x52c9b8
        function _0x4dbf7b(_0x4af418, _0x3b174c) {
          for (let _0x393c96 = 0; _0x393c96 < 12; _0x393c96 += 1) {
            const _0x3b945f = _0x3b174c.some(
              (_0x2e51ab) => _0x2e51ab === _0x393c96
            )
            SetVehicleExtra(_0x4af418, _0x393c96, !_0x3b945f)
          }
        }
        _0x163108.SetVehicleExtras = _0x4dbf7b
        function _0x1c2505(_0x40dd02) {
          return {
            left: IsVehicleNeonLightEnabled(_0x40dd02, 0),
            right: IsVehicleNeonLightEnabled(_0x40dd02, 1),
            front: IsVehicleNeonLightEnabled(_0x40dd02, 2),
            back: IsVehicleNeonLightEnabled(_0x40dd02, 3),
          }
        }
        _0x163108.GetVehicleNeons = _0x1c2505
        function GetVehicleWheelFitment(vehicle) {
          return RPC.execute("pnp:vehicles:GetVehicleWheelFitment", vehicle)
        }
        _0x163108.GetVehicleWheelFitment = GetVehicleWheelFitment
        function GetVehicleAfterMarket(vehicle, pType) {
          return RPC.execute("pnp:vehicles:GetVehicleAfterMarket", vehicle, pType)
        }
        _0x163108.GetVehicleAfterMarket = GetVehicleAfterMarket
        function _0x499c7c(_0x387aba, _0x3b1123) {
          if (_0x3b1123.left) {
            SetVehicleNeonLightEnabled(_0x387aba, 0, _0x3b1123.left)
          }
          if (_0x3b1123.right) {
            SetVehicleNeonLightEnabled(_0x387aba, 1, _0x3b1123.right)
          }
          if (_0x3b1123.front) {
            SetVehicleNeonLightEnabled(_0x387aba, 2, _0x3b1123.front)
          }
          if (_0x3b1123.back) {
            SetVehicleNeonLightEnabled(_0x387aba, 3, _0x3b1123.back)
          }
        }
        _0x163108.SetVehicleNeons = _0x499c7c
        function _0x45f54f(_0xf0e398, _0x3c4492) {
          switch (_0x3c4492) {
            case 'primary': {
              return GetVehicleColours(_0xf0e398)[0]
            }
            case 'secondary': {
              return GetVehicleColours(_0xf0e398)[1]
            }
            case 'pearlescent': {
              return GetVehicleExtraColours(_0xf0e398)[0]
            }
            case 'wheels': {
              return GetVehicleExtraColours(_0xf0e398)[1]
            }
            case 'tyre': {
              const [_0x2d73d4, _0x4eae53, _0x57c50b] =
                GetVehicleTyreSmokeColor(_0xf0e398)
              return {
                r: _0x2d73d4,
                g: _0x4eae53,
                b: _0x57c50b,
              }
            }
            case 'neon': {
              const [_0x12bcd8, _0xb2308e, _0x31d916] =
                GetVehicleNeonLightsColour(_0xf0e398)
              return {
                r: _0x12bcd8,
                g: _0xb2308e,
                b: _0x31d916,
              }
            }
            case 'xenon': {
              return GetVehicleXenonLightsColour(_0xf0e398)
            }
            case 'dashboard': {
              return GetVehicleDashboardColour(_0xf0e398)
            }
            case 'interior': {
              return GetVehicleInteriorColour(_0xf0e398)
            }
          }
        }
        _0x163108.GetVehicleColor = _0x45f54f
        function _0x3707fb(_0x1e7aea, _0x4edb74, _0x5231fe) {
          switch (_0x4edb74) {
            case 'primary': {
              const [_0x11ba29, _0x2ad143] = GetVehicleColours(_0x1e7aea)
              return SetVehicleColours(_0x1e7aea, _0x5231fe, _0x2ad143)
            }
            case 'secondary': {
              const [_0x109208] = GetVehicleColours(_0x1e7aea)
              return SetVehicleColours(_0x1e7aea, _0x109208, _0x5231fe)
            }
            case 'pearlescent': {
              const [_0x196e52, _0x1b181d] = GetVehicleExtraColours(_0x1e7aea)
              return SetVehicleExtraColours(_0x1e7aea, _0x5231fe, _0x1b181d)
            }
            case 'wheels': {
              const [_0x5704c6] = GetVehicleExtraColours(_0x1e7aea)
              return SetVehicleExtraColours(_0x1e7aea, _0x5704c6, _0x5231fe)
            }
            case 'tyre': {
              return SetVehicleTyreSmokeColor(
                _0x1e7aea,
                _0x5231fe.r,
                _0x5231fe.g,
                _0x5231fe.b
              )
            }
            case 'neon': {
              return SetVehicleNeonLightsColour(
                _0x1e7aea,
                _0x5231fe.r,
                _0x5231fe.g,
                _0x5231fe.b
              )
            }
            case 'xenon': {
              return SetVehicleXenonLightsColour(_0x1e7aea, _0x5231fe)
            }
            case 'dashboard': {
              return SetVehicleDashboardColour(_0x1e7aea, _0x5231fe)
            }
            case 'interior': {
              return SetVehicleInteriorColour(_0x1e7aea, _0x5231fe)
            }
          }
        }
        _0x163108.SetVehicleColor = _0x3707fb
        function _0x3642b7(_0x145925, _0x4f0196) {
          switch (_0x4f0196) {
            case 'tint': {
              return GetVehicleWindowTint(_0x145925)
            }
            case 'neon': {
              return _0x1c2505(_0x145925)
            }
            case 'extras': {
              return _0x52c9b8(_0x145925)
            }
            case 'wheelType': {
              return GetVehicleWheelType(_0x145925)
            }
            case 'oldLivery': {
              return GetVehicleLivery(_0x145925)
            }
            case 'plateIndex': {
              return GetVehicleNumberPlateTextIndex(_0x145925)
            }
          }
        }
        _0x163108.GetVehicleAdditional = _0x3642b7
        function _0x1b8b83(_0x49f3be, _0x551e3f, _0x4490e5) {
          switch (_0x551e3f) {
            case 'tint': {
              return SetVehicleWindowTint(_0x49f3be, _0x4490e5)
            }
            case 'neon': {
              return _0x499c7c(_0x49f3be, _0x4490e5)
            }
            case 'extras': {
              return _0x4dbf7b(_0x49f3be, _0x4490e5)
            }
            case 'wheelType': {
              return SetVehicleWheelType(_0x49f3be, _0x4490e5)
            }
            case 'oldLivery': {
              return SetVehicleLivery(_0x49f3be, _0x4490e5)
            }
            case 'plateIndex': {
              return SetVehicleNumberPlateTextIndex(_0x49f3be, _0x4490e5)
            }
          }
        }
        _0x163108.SetVehicleAdditional = _0x1b8b83
        function _0x133741(_0x72e452, _0x189ab2) {
          switch (_0x189ab2) {
            case 'body': {
              return +GetVehicleBodyHealth(_0x72e452).toFixed(2)
            }
            case 'engine': {
              return +GetVehicleEngineHealth(_0x72e452).toFixed(2)
            }
            case 'dirt': {
              return +GetVehicleDirtLevel(_0x72e452).toFixed(2)
            }
            case 'windows': {
              const _0x3d4dc8 = []
              for (let _0x24dcad = 0; _0x24dcad < 8; _0x24dcad += 1) {
                _0x3d4dc8.push({
                  index: _0x24dcad,
                  broken: !IsVehicleWindowIntact(_0x72e452, _0x24dcad),
                })
              }
              return _0x3d4dc8
            }
            case 'doors': {
              const _0x293283 = []
              for (let _0x27b846 = 0; _0x27b846 < 7; _0x27b846 += 1) {
                DoesVehicleHaveDoor(_0x72e452, _0x27b846) &&
                  _0x293283.push({
                    index: _0x27b846,
                    broken: IsVehicleDoorDamaged(_0x72e452, _0x27b846),
                  })
              }
              return _0x293283
            }
            case 'wheels': {
              const _0x258359 = GetVehicleNumberOfWheels(_0x72e452),
                _0x128324 = []
              for (let _0x300d31 = 0; _0x300d31 < _0x258359; _0x300d31 += 1) {
                let _0x29eb4d = +GetVehicleWheelHealth(
                  _0x72e452,
                  _0x300d31
                ).toFixed(2)
                if (IsVehicleTyreBurst(_0x72e452, _0x300d31, false)) {
                  _0x29eb4d = 0.1
                }
                _0x128324.push({
                  index: _0x300d31,
                  health: _0x29eb4d,
                })
              }
              return _0x128324
            }
          }
        }
        _0x163108.GetVehicleDamage = _0x133741
        function _0x536068(_0x504771, _0x4d3c75, _0x133345) {
          switch (_0x4d3c75) {
            case 'body': {
              return SetVehicleBodyHealth(_0x504771, Number(_0x133345))
            }
            case 'engine': {
              return SetVehicleEngineHealth(_0x504771, Number(_0x133345))
            }
            case 'dirt': {
              return SetVehicleDirtLevel(_0x504771, Number(_0x133345))
            }
            case 'windows': {
              return _0x133345.forEach((_0x3e67f7) => {
                if (_0x3e67f7.broken) {
                  SmashVehicleWindow(_0x504771, Number(_0x3e67f7.index))
                }
              })
            }
            case 'doors': {
              return _0x133345.forEach((_0x5750e0) => {
                _0x5750e0.broken &&
                  SetVehicleDoorBroken(_0x504771, Number(_0x5750e0.index), true)
              })
            }
            case 'wheels': {
              return _0x133345.forEach((_0x556d08) => {
                if (_0x556d08.health < 50) {
                  SetVehicleTyreBurst(_0x504771, Number(_0x556d08.index), true, 1000)
                } else {
                  if (_0x556d08.health < 100) {
                    SetVehicleTyreBurst(_0x504771, Number(_0x556d08.index), false, 1)
                  } else {
                    SetVehicleWheelHealth(
                      _0x504771,
                      Number(_0x556d08.index),
                      _0x556d08.health
                    )
                  }
                }
              })
            }
          }
        }
        _0x163108.SetVehicleDamage = _0x536068
        function _0x2e4e44(_0x4ccdaf) {
          return {
            primary: _0x45f54f(_0x4ccdaf, 'primary'),
            secondary: _0x45f54f(_0x4ccdaf, 'secondary'),
            pearlescent: _0x45f54f(_0x4ccdaf, 'pearlescent'),
            wheels: _0x45f54f(_0x4ccdaf, 'wheels'),
            tyre: _0x45f54f(_0x4ccdaf, 'tyre'),
            neon: _0x45f54f(_0x4ccdaf, 'neon'),
            xenon: _0x45f54f(_0x4ccdaf, 'xenon'),
            dashboard: _0x45f54f(_0x4ccdaf, 'dashboard'),
            interior: _0x45f54f(_0x4ccdaf, 'interior'),
          }
        }
        _0x163108.GetVehicleColors = _0x2e4e44
        function _0x2d9214(_0x35de1a, _0xce5e9f) {
          for (const [_0x1f4d77, _0x4ed9b0] of Object.entries(_0xce5e9f)) {
            _0x3707fb(_0x35de1a, _0x1f4d77, _0x4ed9b0)
          }
          _0xce5e9f.dashboard &&
            _0xce5e9f.interior === undefined &&
            _0x3707fb(_0x35de1a, 'interior', _0xce5e9f.dashboard)
          _0xce5e9f.interior &&
            _0xce5e9f.dashboard === undefined &&
            _0x3707fb(_0x35de1a, 'dashboard', _0xce5e9f.interior)
        }
        _0x163108.SetVehicleColors = _0x2d9214
        function _0x2b536d(_0x310afd) {
          return {
            colors: _0x2e4e44(_0x310afd),
            tint: _0x3642b7(_0x310afd, 'tint'),
            neon: _0x3642b7(_0x310afd, 'neon'),
            extras: _0x3642b7(_0x310afd, 'extras'),
            wheelType: _0x3642b7(_0x310afd, 'wheelType'),
            oldLivery: _0x3642b7(_0x310afd, 'oldLivery'),
            plateIndex: _0x3642b7(_0x310afd, 'plateIndex'),
          }
        }
        _0x163108.GetVehicleAppearance = _0x2b536d
        function _0x3592f6(_0x275563, _0x1b4187) {
          for (const [_0x6d686e, _0xf3edae] of Object.entries(_0x1b4187)) {
            if (_0x6d686e !== 'colors') {
              _0x1b8b83(_0x275563, _0x6d686e, _0xf3edae)
            } else {
              _0x2d9214(_0x275563, _0xf3edae)
            }
          }
        }
        _0x163108.SetVehicleAppearance = _0x3592f6
        function _0x13d7b7(_0x5a9cfb) {
          return {
            body: _0x133741(_0x5a9cfb, 'body'),
            engine: _0x133741(_0x5a9cfb, 'engine'),
            dirt: _0x133741(_0x5a9cfb, 'dirt'),
            windows: _0x133741(_0x5a9cfb, 'windows'),
            doors: _0x133741(_0x5a9cfb, 'doors'),
            wheels: _0x133741(_0x5a9cfb, 'wheels'),
          }
        }
        _0x163108.FetchVehicleDamage = _0x13d7b7
        function _0xeef8c(_0x56a94f, _0x94f78b) {
          for (const [_0x2feabe, _0x40be28] of Object.entries(_0x94f78b)) {
            _0x536068(_0x56a94f, _0x2feabe, _0x40be28)
          }
        }
        _0x163108.RestoreVehicleDamage = _0xeef8c
        _0x347b27.g.exports('GetVehicleAppearance', _0x2b536d)
        _0x347b27.g.exports('SetVehicleAppearance', _0x3592f6)
        _0x347b27.g.exports('GetVehicleWheelFitment', GetVehicleWheelFitment)
        _0x347b27.g.exports('GetVehicleAfterMarket', GetVehicleAfterMarket)
      },
      628: (_0x20c7ed, _0x323133, _0x1486ff) => {
        Object.defineProperty(_0x323133, '__esModule', { value: true })
        _0x323133.SetVehicleFakeLicensePlate =
          _0x323133.GetLicensePlate =
          _0x323133.InitLicensePlate =
            void 0
        const _0x4685da = _0x1486ff(997)
        async function _0x13c955() {}
        _0x323133.InitLicensePlate = _0x13c955
        async function _0x471053(_0x33fdbf) {
          if (_0x33fdbf) {
            const _0x41242a = await RPC.execute('pnp:vehicles:getLicensePlate', _0x33fdbf)
            return _0x41242a
          }
        }
        _0x323133.GetLicensePlate = _0x471053
        async function _0x3d4d85(_0x249b2b, _0x554cc5) {
          const _0x165b6f = new _0x4685da.AnimationTask(
              PlayerPedId(),
              'normal',
              _0x554cc5 ? 'Adding fake plates' : 'Removing fake plates',
              5000,
              'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
              'machinic_loop_mechandplayer'
            ),
            _0x1700a3 = await _0x165b6f.start()
          if (_0x1700a3 === 100) {
            const _0x336dd1 = NetworkGetNetworkIdFromEntity(_0x249b2b),
              _0x35afd2 = await RPC.execute('pnp:vehicles:setFakeLicensePlate', _0x336dd1, _0x554cc5)
            _0x35afd2 && emit('inventory:removeItem', 'fakeplate', 1)
          }
        }
        _0x323133.SetVehicleFakeLicensePlate = _0x3d4d85
      },
      130: (_0x4f3319, _0x339e48, _0x5c5457) => {
        Object.defineProperty(_0x339e48, '__esModule', { value: true })
        _0x339e48.SetMods =
          _0x339e48.SetMod =
          _0x339e48.GetMods =
          _0x339e48.GetMod =
          _0x339e48.IsToggle =
            void 0
        const _0x566745 = _0x5c5457(543)
        function _0x244ece(_0x4a7580) {
          return _0x4a7580 >= 17 && _0x4a7580 <= 22
        }
        _0x339e48.IsToggle = _0x244ece
        function _0x5875e1(_0x2fc708, _0x13f00f) {
          const _0xdf9593 = Number(_0x566745.Mods[_0x13f00f])
          if (!isNaN(_0xdf9593)) {
            if (_0x244ece(_0xdf9593)) {
              return IsToggleModOn(_0x2fc708, _0xdf9593) ? 1 : 0
            } else {
              return GetVehicleMod(_0x2fc708, _0xdf9593)
            }
          }
        }
        _0x339e48.GetMod = _0x5875e1
        function _0x12ce0e(_0x39d255) {
          const _0x124b31 = {}
          for (const index in _0x566745.Mods) {
            if (isNaN(Number(index))) {
              _0x124b31[index] = _0x5875e1(_0x39d255, index)
            }
          }
          return _0x124b31
        }
        _0x339e48.GetMods = _0x12ce0e
        function _0x181a6a(_0x51320a, _0x5dbfd9, _0x4f3d89) {
          const _0x1622e9 = Number(_0x566745.Mods[_0x5dbfd9]),
            _0x36cf88 = (_0x1622e9 === 23 || _0x1622e9 === 24) && _0x4f3d89 !== -1
          if (!isNaN(_0x1622e9)) {
            if (_0x244ece(_0x1622e9)) {
              ToggleVehicleMod(_0x51320a, _0x1622e9, _0x4f3d89)
            } else {
              if (_0x4f3d89 === 255) {
                _0x4f3d89 = GetNumVehicleMods(_0x51320a, _0x1622e9) - 1
              }
              SetVehicleMod(_0x51320a, _0x1622e9, _0x4f3d89, false)
            }
          }
        }
        _0x339e48.SetMod = _0x181a6a
        function _0x24c208(_0x846fee, _0x4520d5) {
          SetVehicleModKit(_0x846fee, 0)
          for (const [_0x43f95d, _0xa30387] of Object.entries(_0x4520d5)) {
            _0x181a6a(_0x846fee, _0x43f95d, _0xa30387)
          }
        }
        _0x339e48.SetMods = _0x24c208
        _0x5c5457.g.exports('GetVehicleMods', _0x12ce0e)
        _0x5c5457.g.exports('SetVehicleMods', _0x24c208)
      },
      343: (_0x49ffba, _0x406154, _0x4d492e) => {
        Object.defineProperty(_0x406154, '__esModule', { value: true })
        _0x406154.GetLocale =
          _0x406154.GetVehicleRating =
          _0x406154.GetVehicleRatingClass =
          _0x406154.GetVehicleRatingNumber =
          _0x406154.GetRatingClass =
          _0x406154.GetVehicleStats =
          _0x406154.InitStats =
            void 0
        const _0x3beef0 = _0x4d492e(396),
          _0x250ccd = { [GetHashKey('npolmm')]: 'M' }
        async function _0x17fe41() {}
        _0x406154.InitStats = _0x17fe41
        function _0x24ea50(_0x23ee9f) {
          const _0x5928fe = (0, _0x3beef0.GetHandlingField)(_0x23ee9f),
            _0xb6cbbf = _0x5928fe.fBrakeForce,
            _0x3c5a89 = _0x5928fe.fInitialDragCoeff,
            _0x3b4138 = _0x5928fe.fInitialDriveForce,
            _0x2bc708 = _0x5928fe.fInitialDriveMaxFlatVel,
            _0x12a7b8 = _0x5928fe.fSuspensionReboundDamp,
            _0x354eba = _0x5928fe.fTractionCurveMax,
            _0x4bcea9 = _0x5928fe.fTractionCurveMin,
            _0x37cb71 = GetVehicleClass(_0x23ee9f)
          let _0x59a506 = _0x3b4138
          if (_0x3b4138 > 0 && _0x3b4138 < 1) {
            _0x59a506 *= 1.1
          }
          const _0x432139 = (_0x2bc708 * _0x59a506) / 10,
            _0x11185b = ((_0x2bc708 / _0x3c5a89) * (_0x354eba + _0x4bcea9)) / 40
          let _0x4ba43c = (_0x354eba + _0x12a7b8) * _0x4bcea9
          if (_0x37cb71 === 8) {
            _0x4ba43c /= 2
          }
          const _0x4eda35 = (_0x4bcea9 / _0x3c5a89) * _0xb6cbbf * 7
          return {
            force: _0x59a506,
            acceleration: _0x432139,
            speed: _0x11185b,
            handling: _0x4ba43c,
            braking: _0x4eda35,
            category: _0x37cb71,
          }
        }
        _0x406154.GetVehicleStats = _0x24ea50
        _0x4d492e.g.exports('GetVehicleStats', _0x24ea50)
        function _0x5411e0(_0x501ab1, _0x5b27fb = false) {
          if (_0x5b27fb) {
            return 'M'
          }
          if (_0x501ab1 > 900) {
            return 'X'
          } else {
            if (_0x501ab1 > 700) {
              return 'S'
            } else {
              if (_0x501ab1 > 550) {
                return 'A'
              } else {
                if (_0x501ab1 > 400) {
                  return 'B'
                } else {
                  return _0x501ab1 > 325 ? 'C' : 'D'
                }
              }
            }
          }
        }
        _0x406154.GetRatingClass = _0x5411e0
        _0x4d492e.g.exports('GetRatingClass', _0x5411e0)
        function _0x22ab31(_0x597add) {
          const _0x488b92 =
            typeof _0x597add === 'number' ? _0x24ea50(_0x597add) : _0x597add
          if (!_0x488b92) {
            return 0
          }
          return Math.round(
            (_0x488b92.acceleration * 5 +
              _0x488b92.speed +
              _0x488b92.handling +
              _0x488b92.braking) *
              15
          )
        }
        _0x406154.GetVehicleRatingNumber = _0x22ab31
        _0x4d492e.g.exports('GetVehicleRatingNumber', _0x22ab31)
        function _0x2e1711(_0x3edf26) {
          const _0x576b5a =
              typeof _0x3edf26 === 'number' ? _0x24ea50(_0x3edf26) : _0x3edf26,
            _0x19ef46 =
              typeof _0x3edf26 === 'number' ? GetEntityModel(_0x3edf26) : null
          if (!_0x576b5a) {
            return 'D'
          }
          if (_0x19ef46 && _0x250ccd[_0x19ef46]) {
            return _0x250ccd[_0x19ef46]
          }
          const _0x18781e = Math.round(
            (_0x576b5a.acceleration * 5 +
              _0x576b5a.speed +
              _0x576b5a.handling +
              _0x576b5a.braking) *
              15
          )
          return _0x5411e0(_0x18781e, _0x576b5a.category === 8)
        }
        _0x406154.GetVehicleRatingClass = _0x2e1711
        _0x4d492e.g.exports('GetVehicleRatingClass', _0x2e1711)
        function _0x2bb325(_0x538d61) {
          const _0x2a83c1 =
              typeof _0x538d61 === 'number' ? _0x24ea50(_0x538d61) : _0x538d61,
            _0x1d6046 =
              typeof _0x538d61 === 'number' ? GetEntityModel(_0x538d61) : null
          if (!_0x2a83c1) {
            return {
              power: 0,
              class: 'D',
            }
          }
          const _0xaf5668 = Math.round(
            (_0x2a83c1.acceleration * 5 +
              _0x2a83c1.speed +
              _0x2a83c1.handling +
              _0x2a83c1.braking) *
              15
          )
          if (_0x1d6046 && _0x250ccd[_0x1d6046]) {
            return {
              power: _0xaf5668,
              class: _0x250ccd[_0x1d6046],
            }
          }
          return {
            power: _0xaf5668,
            class: _0x5411e0(_0xaf5668, _0x2a83c1.category === 8),
          }
        }
        _0x406154.GetVehicleRating = _0x2bb325
        _0x4d492e.g.exports('GetVehicleRating', _0x2bb325)
        const _0x45849c = new Map([
          ['tyres', 'Tyres'],
          ['body', 'Body'],
          ['clutch', 'Clutch'],
          ['tank', 'Fuel Tank'],
          ['axle', 'Axle Tree'],
          ['brakes', 'Brake Discs'],
          ['engine', 'Engine Block'],
          ['injector', 'Fuel Injectors'],
          ['electronics', 'Electronics'],
          ['radiator', 'Engine Radiator'],
          ['transmission', 'Transmission'],
        ])
        function _0x2aeda3(_0x4e078e) {
          return _0x45849c.get(_0x4e078e)
        }
        _0x406154.GetLocale = _0x2aeda3
      },
      908: function (_0xe21590, _0x5d0117, _0x129452) {
        var _0x2ed8ef =
            (this && this['__createBinding']) ||
            (Object.create
              ? function (_0x2ecb4c, _0x3f95b6, _0x3fb63c, _0x320b9a) {
                  if (_0x320b9a === undefined) {
                    _0x320b9a = _0x3fb63c
                  }
                  Object.defineProperty(_0x2ecb4c, _0x320b9a, {
                    enumerable: true,
                    get: function () {
                      return _0x3f95b6[_0x3fb63c]
                    },
                  })
                }
              : function (_0x167773, _0x38cbfa, _0x1508dd, _0x2270c0) {
                  if (_0x2270c0 === undefined) {
                    _0x2270c0 = _0x1508dd
                  }
                  _0x167773[_0x2270c0] = _0x38cbfa[_0x1508dd]
                }),
          _0x2bc246 =
            (this && this['__setModuleDefault']) ||
            (Object.create
              ? function (_0x1159fc, _0x52a57c) {
                  Object.defineProperty(_0x1159fc, 'default', {
                    enumerable: true,
                    value: _0x52a57c,
                  })
                }
              : function (_0x41bf24, _0xc9148f) {
                  _0x41bf24.default = _0xc9148f
                }),
          _0x13bf22 =
            (this && this['__importStar']) ||
            function (_0xb0e0e4) {
              if (_0xb0e0e4 && _0xb0e0e4['__esModule']) {
                return _0xb0e0e4
              }
              var _0x1a4eaf = {}
              if (_0xb0e0e4 != null) {
                for (var _0x5a9439 in _0xb0e0e4)
                  if (
                    _0x5a9439 !== 'default' &&
                    Object.prototype.hasOwnProperty.call(_0xb0e0e4, _0x5a9439)
                  ) {
                    _0x2ed8ef(_0x1a4eaf, _0xb0e0e4, _0x5a9439)
                  }
              }
              _0x2bc246(_0x1a4eaf, _0xb0e0e4)
              return _0x1a4eaf
            }
        Object.defineProperty(_0x5d0117, '__esModule', { value: true })
        _0x5d0117.getPlayerVehiclesByCharacterId =
          _0x5d0117.SpawnGarageVehicle =
          _0x5d0117.PreviewCar =
          _0x5d0117.GetGarageVehicleCache =
          _0x5d0117.FindCarInGarageByVIN =
          _0x5d0117.StoreVehicleInGarage =
          _0x5d0117.OpenGarageVehicleList =
          _0x5d0117.ResetParkingSpot =
          _0x5d0117.IsOnParkingSpot =
          _0x5d0117.FindParkingSpot =
          _0x5d0117.GetCurrentParkingSpot =
          _0x5d0117.HasAccessToGarage =
          _0x5d0117.HasGarageSpace =
          _0x5d0117.GetGarageList =
          _0x5d0117.ClearGarageVehicleCache =
          _0x5d0117.GetAllGarages =
          _0x5d0117.GetGarageById =
          _0x5d0117.RemoveGarage =
          _0x5d0117.AddGarage =
          _0x5d0117.InitGarages =
          _0x5d0117.previewCar =
          _0x5d0117.currentParkingSpot =
          _0x5d0117.currentGarage =
          _0x5d0117.garageVehicleCache =
          _0x5d0117.garages =
            void 0
        const _0x55dee9 = _0x13bf22(_0x129452(130)),
          _0x3bffc3 = _0x13bf22(_0x129452(302)),
          _0x4c6339 = _0x13bf22(_0x129452(413)),
          _0x12c4d5 = _0x129452(895),
          _0x3819f7 = _0x129452(996),
          _0x4878a8 = _0x129452(849),
          _0x414ff4 = _0x129452(281),
          _0x57e56a = _0x129452(615)
        _0x5d0117.garages = new Map()
        _0x5d0117.garageVehicleCache = new _0x414ff4.Cache()
        _0x5d0117.currentGarage = null
        _0x5d0117.currentParkingSpot = null
        _0x5d0117.previewCar = 0
        async function InitGarages() {
          await (0, _0x12c4d5.IsConfigReady)()
          const _0x479d18 = (0, _0x12c4d5.GetModuleConfig)('fa-vehicles:garages')
          if (_0x479d18 !== undefined) {
            Object.entries(_0x479d18).forEach(([_0x1c5a8d, _0x455c87]) => {
              _0x3f10fe(_0x1c5a8d, _0x455c87)
            })
            const _0xa5ab16 = Object.keys(_0x479d18).length
            console.log('[INIT] Garages Loaded: ' + _0xa5ab16)
          } else {
            console.log('[ERROR] An error occured while loading garages.')
          }
        }
        _0x5d0117.InitGarages = InitGarages
        function _0x3f10fe(_0x467673, _0x34659c) {
          if (!_0x5d0117.garages.has(_0x34659c.garage_id)) {
            const _0x4e2556 = _0x34659c.location
            _0x4e2556.length
              ? _0x4878a8.PolyZone.addBoxZone(
                  _0x34659c.garage_id,
                  _0x4e2556.vectors,
                  _0x4e2556.length,
                  _0x4e2556.width,
                  _0x4e2556.options
                )
              : _0x4878a8.PolyZone.addCircleZone(
                  _0x34659c.garage_id,
                  _0x4e2556.vectors,
                  _0x4e2556.width,
                  _0x4e2556.options
                )
            if (_0x34659c.type === 'public' && !_0x4e2556.hidden) {
              ;(0, _0x3819f7.AddBlip)(
                _0x34659c.garage_id,
                _0x4e2556.vectors,
                _0x34659c.name,
                {
                  sprite: 357,
                  color: 3,
                  scale: 0.8,
                  category: 10,
                  short: true,
                }
              )
            }
          }
          _0x5d0117.garages.set(_0x34659c.garage_id, _0x34659c)
        }
        _0x5d0117.AddGarage = _0x3f10fe
        function _0x55684b(_0x509d48) {
          return _0x5d0117.garages.delete(_0x509d48)
        }
        _0x5d0117.RemoveGarage = _0x55684b
        function _0x302582(_0x276d1b) {
          return _0x5d0117.garages.get(_0x276d1b)
        }
        _0x5d0117.GetGarageById = _0x302582
        function _0x1de021() {
          return _0x5d0117.garages
        }
        _0x5d0117.GetAllGarages = _0x1de021
        function _0x5f9f6(_0x43789b, _0x591868 = false) {
          if (_0x591868) {
            _0x5d0117.garageVehicleCache.clear()
          } else {
            _0x5d0117.garageVehicleCache.delete(_0x43789b)
          }
        }
        _0x5d0117.ClearGarageVehicleCache = _0x5f9f6
        function _0x599c56() {
          const _0x55f5b8 = []
          return (
            _0x5d0117.garages.forEach((_0x1bae49) => {
              _0x55f5b8.push({
                id: _0x1bae49.garage_id,
                name: _0x1bae49.name,
              })
            }),
            _0x55f5b8
          )
        }
        _0x5d0117.GetGarageList = _0x599c56
        _0x129452.g.exports('GetGarageList', _0x599c56)
        async function _0x127481(_0x2a624b, _0x1a9f61) {
          const _0x585a5b = _0x2a624b
              ? _0x302582(_0x2a624b)
              : _0x302582(_0x5d0117.currentGarage),
            plate = GetVehicleNumberPlateText(_0x1a9f61)
          if (_0x585a5b && plate) {
            const _0x50b529 = await _0x5c947a(_0x2a624b),
              _0x4c04b7 = _0x1a9f61
                ? _0x50b529.find((_0x59dcdf) => _0x59dcdf.plate === plate)
                : false
            return _0x4c04b7 || _0x50b529.length + 1 < _0x585a5b.parking_limit
          }
        }
        _0x5d0117.HasGarageSpace = _0x127481
        async function _0xa8a77f(pGarage) {
          const _0x456ed6 = pGarage
            ? _0x302582(pGarage)
            : _0x302582(_0x5d0117.currentGarage)
          if (!_0x456ed6) {
            return false
          }
          let _0x590524 = undefined
          switch (_0x456ed6.type) {
            case 'housing': {
              _0x590524 = await new Promise((_0x27d707) => {
                setTimeout(() => _0x27d707(false), 5000)
                emit('pnp:vehicles:hasHouseGarageAccess', _0x456ed6.garage_id, _0x27d707)
              })
              break
            }
            case 'business': {
              if (_0x456ed6.publicOverride) {
                _0x590524 = true
                break
              }
              cid = exports.isPed.isPed('cid')
              _0x453cee = await RPC.execute('fa-business:hasGarageAccess', cid, _0x456ed6.business_id)
              if (!_0x453cee) {
                emit('DoLongHudText', "You don't have access to this parking spot.", 2)
                return
              }
              _0x590524 = await new Promise((_0x3376ce) => {
                setTimeout(() => _0x3376ce(_0x453cee), 250),
                  emit('pnp:vehicles:hasBusinessGarageAccess',_0x456ed6.garage_id, _0x456ed6.business_id, _0x3376ce)
              })
              break
            }
            case 'shared': {
              let myjob = exports.isPed.isPed('myjob')
              let _0x154fbf = false
              if (Array.isArray(_0x456ed6.job)) {
                for (
                  let _0x158ef9 = 0;
                  _0x158ef9 < _0x456ed6.job.length;
                  _0x158ef9++
                ) {
                  myjob === _0x456ed6.job[_0x158ef9] && (_0x154fbf = true)
                }
              } else {
                myjob === _0x456ed6.job && (_0x154fbf = true)
              }
              if (!_0x154fbf) {
                emit('DoLongHudText', "You don't have access to this parking spot.", 2)
                return
              }
              _0x590524 = await new Promise((_0x26a47a) => {
                setTimeout(() => _0x26a47a(_0x154fbf), 250)
                  emit('pnp:vehicles:hasJobGarageAccess', _0x456ed6.garage_id, _0x26a47a)
              })
              break
            }
            case 'state': {
              _0x590524 = await new Promise((_0x110253) => {
                setTimeout(() => _0x110253(false), 5000)
                emit('pnp:vehicles:hasStateGarageAccess', _0x456ed6.garage_id, _0x110253)
              })
              break
            }
            case 'public': {
              _0x590524 = true
            }
          }
          return _0x590524
        }
        _0x5d0117.HasAccessToGarage = _0xa8a77f
        function _0x5655b9(_0x58f42f, _0x425966) {
          const _0x55e76a = _0x302582(_0x58f42f)
          if (_0x55e76a) {
            for (const _0x246cfe of _0x55e76a.parking_spots) {
              const _0x2d5b1c = _0x246cfe.coords
              if (
                _0x246cfe.size >= _0x425966 &&
                !IsAnyVehicleNearPoint(
                  _0x2d5b1c.x,
                  _0x2d5b1c.y,
                  _0x2d5b1c.z,
                  _0x246cfe.distance
                )
              ) {
                return _0x246cfe
              }
            }
          }
          return false
        }
        _0x5d0117.GetCurrentParkingSpot = _0x5655b9
        _0x129452.g.exports('GetCurrentParkingSpot', _0x5655b9)
        function _0xbfb792(ped, _0x20d8b9 = false, distance) {
          let _0x1a6f22 = undefined,
            _0x5b2a9e = undefined
          if (!_0x5d0117.currentGarage) {
            return [false, _0x1a6f22]
          }
          const _0x492e00 = _0x302582(_0x5d0117.currentGarage)
          if (_0x492e00) {
            const [x, y, z] = GetEntityCoords(ped, false)
            for (const _0x353cc6 of _0x492e00.parking_spots) {
              const _0x5afdce = GetDistanceBetweenCoords(
                  _0x353cc6.coords.x,
                  _0x353cc6.coords.y,
                  _0x353cc6.coords.z,
                  x,
                  y,
                  z,
                  true
                ),
                _0x156792 = !IsAnyVehicleNearPoint(
                  _0x353cc6.coords.x,
                  _0x353cc6.coords.y,
                  _0x353cc6.coords.z,
                  _0x353cc6.distance
                ),
                _0x5a4405 = distance ? distance : _0x353cc6.distance
              ;(!_0x20d8b9 || _0x156792) &&
                _0x5afdce <= _0x5a4405 &&
                (!_0x1a6f22 || _0x5b2a9e > _0x5afdce) &&
                ((_0x1a6f22 = _0x353cc6), (_0x5b2a9e = _0x5afdce))
            }
          }
          if (typeof _0x1a6f22 !== 'undefined') {
            _0x5d0117.currentParkingSpot = _0x1a6f22
          }
          return [_0x1a6f22 !== undefined, _0x1a6f22]
        }
        _0x5d0117.FindParkingSpot = _0xbfb792
        _0x129452.g.exports('FindParkingSpot', _0xbfb792)
        function _0x42d22c(_0x46c8a9, _0x518f58 = false, _0x1efcfa) {
          return _0xbfb792(_0x46c8a9, _0x518f58, _0x1efcfa)[0]
        }
        _0x5d0117.IsOnParkingSpot = _0x42d22c
        _0x129452.g.exports('IsOnParkingSpot', _0x42d22c)
        function _0x4c1137() {
          _0x5d0117.currentParkingSpot = null
        }
        _0x5d0117.ResetParkingSpot = _0x4c1137
        async function _0x574841(_0x2ac7c5, _0x30d119, _0x2bf8b7 = false) {
          const _0x379d06 = await _0xa8a77f(_0x5d0117.currentGarage)
          if (!_0x379d06) {
            return emit('DoLongHudText', "You don't have access to this parking spot.", 2)
          }
          if (_0x2ac7c5) {
            const [_0x26f755, _0x1f7d2b] = _0xbfb792(PlayerPedId(), _0x2bf8b7, _0x30d119)
            _0x26f755 && (_0x5d0117.currentParkingSpot = _0x1f7d2b)
          }
          _0x4c6339.OpenGarageList(_0x5d0117.currentGarage)
        }
        _0x5d0117.OpenGarageVehicleList = _0x574841
        async function _0x47b2b4(_0x2d1d46) {
          const _0x2f7247 = await _0xa8a77f(_0x5d0117.currentGarage)
          if (!_0x2f7247) {
            return emit('DoLongHudText', "You don't have access to this parking spot.", 2)
          }
          const _0x4ffff9 = _0x42d22c(_0x2d1d46)
          if (
            GetVehicleNumberOfPassengers(_0x2d1d46) > 0 ||
            !IsVehicleSeatFree(_0x2d1d46, -1)
          ) {
            return emit('DoLongHudText', 'The vehicle is not empty!', 2)
          }
          if (!_0x4ffff9) {
            return emit('DoLongHudText', 'We cannot park here!', 2)
          }
          const _0x9160bd = await RPC.execute('pnp:vehicles:storeVehicle',  NetworkGetNetworkIdFromEntity(_0x2d1d46), _0x5d0117.currentGarage)
          if (!_0x9160bd) {
            return emit('DoLongHudText', 'Cannot park the vehicle here.', 2)
          }
          _0x9160bd && _0x5f9f6(_0x5d0117.currentGarage)
        }
        _0x5d0117.StoreVehicleInGarage = _0x47b2b4
        async function _0x5e2a45(_0x22ed9c, _0x2489a0) {
          const _0x48340c = await _0x5c947a(_0x2489a0)
          return _0x48340c.find((_0x1496db) => _0x1496db.vin === _0x22ed9c)
        }
        _0x5d0117.FindCarInGarageByVIN = _0x5e2a45
        async function _0x5c947a(GarageId) {
          if (
            _0x5d0117.garageVehicleCache.has(GarageId) &&
            !_0x5d0117.garageVehicleCache.isExpired(GarageId)
          ) {
            return _0x5d0117.garageVehicleCache.get(GarageId)
          }
          const _0x2d8840 = await RPC.execute('pnp:vehicles:getVehicles', GarageId)
          if (_0x2d8840) {
            return (
              _0x5d0117.garageVehicleCache.set(GarageId, _0x2d8840, 120000),
              _0x5d0117.garageVehicleCache.get(GarageId)
            )
          }
          return false
        }
        _0x5d0117.GetGarageVehicleCache = _0x5c947a
        async function _0x26ebfb(_0x129bca, _0x542d7b, _0x4eb9f) {
          const _0x402e5a = _0x4eb9f
            ? _0x4eb9f
            : await _0x5e2a45(_0x129bca, _0x542d7b)
          if (!_0x5d0117.currentParkingSpot) {
            _0x5d0117.currentParkingSpot = _0x5655b9(_0x542d7b, 1)
          }
          if (_0x402e5a) {
            const _0x3dad18 = GetHashKey(_0x402e5a.model),
              { coords: _0x19de1e, heading: _0x11e873 } = _0x5d0117.currentParkingSpot
            await (0, _0x57e56a.loadAndRequestModel)(_0x3dad18)
            const _0x504b93 = CreateVehicle(
              _0x3dad18,
              _0x19de1e.x,
              _0x19de1e.y,
              _0x19de1e.z - 50,
              _0x11e873,
              false,
              false
            )
            if (_0x504b93) {
              FreezeEntityPosition(_0x504b93, true)
              SetEntityCollision(_0x504b93, false, false)
              SetVehicleDoorsLocked(_0x504b93, 3)
              SetVehicleNumberPlateText(_0x504b93, _0x402e5a.plate)
              let _0x19dffe = [],
                _0x2e0d6f = []
              if (_0x402e5a.mods !== undefined) {
                _0x55dee9.SetMods(_0x504b93, JSON.parse(_0x402e5a.mods))
              }
              if (_0x402e5a.appearance !== undefined) {
                _0x3bffc3.SetVehicleAppearance(
                  _0x504b93,
                  JSON.parse(_0x402e5a.appearance)
                )
              }
              _0x402e5a.damage !== undefined &&
                _0x3bffc3.RestoreVehicleDamage(
                  _0x504b93,
                  JSON.parse(_0x402e5a.damage)
                )
              await (0, _0x57e56a.Delay)(100)
              if (DoesEntityExist(_0x5d0117.previewCar)) {
                DeleteEntity(_0x5d0117.previewCar)
              }
              SetEntityCoords(
                _0x504b93,
                _0x19de1e.x,
                _0x19de1e.y,
                _0x19de1e.z,
                false,
                false,
                false,
                false
              )
              _0x5d0117.previewCar = _0x504b93
              SetModelAsNoLongerNeeded(_0x3dad18)
            }
          }
        }
        _0x5d0117.PreviewCar = _0x26ebfb
        async function _0x2e8fea(pVin, pGarage, raid) {
          const { heading: _0x33a6ee, coords: _0x498c49 } = _0x5d0117.currentParkingSpot,
            _0xf8c0f6 = await RPC.execute('pnp:vehicles:spawnGarageVehicle', pVin, pGarage,
              {
                ..._0x498c49,
                h: _0x33a6ee,
              }
            )
          if (_0xf8c0f6) {
            _0x5f9f6(pGarage)
          } else {
            emit('DoLongHudText', 'Vehicle unavailable, Try again later.', 2)
          }
          return (
            (_0x5d0117.currentParkingSpot = null),
            DeleteEntity(_0x5d0117.previewCar),
            _0xf8c0f6
          )
        }
        _0x5d0117.SpawnGarageVehicle = _0x2e8fea
        async function _0x331a62(_0x5dd35b) {
          const _0xbc61ad = await RPC.execute('pnp:vehicles:getPlayerVehiclesByCharacterId', _0x5dd35b)
          return _0xbc61ad
        }
        _0x5d0117.getPlayerVehiclesByCharacterId = _0x331a62
        _0x129452.g.exports('getPlayerVehiclesByCharacterId', _0x331a62)
        on('fa-polyzone:enter', async (_0xc3c98a) => {
          if (!_0x5d0117.garages.has(_0xc3c98a)) {
            return
          }
          exports["fa-ui"].showInteraction("Parking")
          _0x5d0117.currentGarage = _0xc3c98a
        })
        on('fa-polyzone:exit', (_0x121383) => {
          if (_0x5d0117.currentGarage !== _0x121383) {
            return
          }
          exports["fa-ui"].hideInteraction()
          _0x5d0117.currentGarage = null
        })
      },
      710: (_0x3fe3be, _0x5ca661, _0x4539c3) => {
        Object.defineProperty(_0x5ca661, '__esModule', { value: true })
        _0x5ca661.IsVinScratched =
          _0x5ca661.GiveVehicleKey =
          _0x5ca661.HasVehicleKey =
          _0x5ca661.GetVehicleOwner =
          _0x5ca661.GetVehicleIdentifier =
          _0x5ca661.InitKeys =
          _0x5ca661.Keys =
            void 0
        _0x5ca661.Keys = new Set()
        async function _0x5a1dd8() {}
        _0x5ca661.InitKeys = _0x5a1dd8
        onNet('pnp:vehicles:giveKeys', async () => {
          const _0x2ad5da = _0x4539c3.g.exports.isPed.isPed('cid'),
            _0x5e9183 = await RPC.execute('pnp:vehicles:getAllPlayerVehicles', _0x2ad5da)
          Object.entries(_0x5e9183).forEach(([_0x93eec5, _0x10a1b8]) => {
            _0x5ca661.Keys.add(_0x10a1b8.vin)
          })
        })
        function _0x23aa39(_0x360f77) {
          if (!DoesEntityExist(_0x360f77)) {
            return false
          }
          const _0x48c7bd = Entity(_0x360f77)
          if (!_0x48c7bd.state) {
            return false
          }
          const _0x4464ee = _0x48c7bd.state,
            _0x3e20e3 = _0x4464ee.vin ? _0x4464ee.vin : false
          return _0x3e20e3
        }
        _0x5ca661.GetVehicleIdentifier = _0x23aa39
        function _0x3d32c9(_0x1e646b) {
          if (!DoesEntityExist(_0x1e646b)) {
            return false
          }
          const _0x180536 = Entity(_0x1e646b)
          if (!_0x180536.state) {
            return false
          }
          const _0x63eb82 = _0x180536.state
          return _0x63eb82.owner ? _0x63eb82.owner : 0
        }
        _0x5ca661.GetVehicleOwner = _0x3d32c9
        function _0x5148b6(_0x329dea) {
          const _0x1a3faf =
            typeof _0x329dea === 'number' ? _0x23aa39(_0x329dea) : _0x329dea
          return _0x5ca661.Keys.has(_0x1a3faf)
        }
        _0x5ca661.HasVehicleKey = _0x5148b6
        function _0x4ae268(_0x1a3d72, _0x19a40c) {
          if (_0x5ca661.Keys.size === 0) {
            return emit('DoLongHudText', 'You have no keys to give!', 2)
          }
          const _0x1dc56c =
            typeof _0x1a3d72 === 'number' ? _0x23aa39(_0x1a3d72) : _0x1a3d72
          if (_0x1dc56c && _0x5ca661.Keys.has(_0x1dc56c)) {
            RPC.execute('pnp:vehicles:giveKey', _0x1dc56c, _0x19a40c).then(
              (_0x2895e1) => {
                if (_0x2895e1) {
                  emit('DoLongHudText', 'You just gave the keys of your vehicle!', 1)
                }
              }
            )
          } else {
            return emit('DoLongHudText', 'No keys for target vehicle!', 2)
          }
        }
        _0x5ca661.GiveVehicleKey = _0x4ae268
        function _0x4edba0(_0xcb12c4) {
          if (!DoesEntityExist(_0xcb12c4)) {
            return false
          }
          const _0x20f019 = Entity(_0xcb12c4)
          if (!_0x20f019.state) {
            return false
          }
          const _0x48819a = _0x20f019.state
          return _0x48819a.vinScratched ? _0x48819a.vinScratched : false
        }
        _0x5ca661.IsVinScratched = _0x4edba0
        _0x4539c3.g.exports('GetVehicleIdentifier', _0x23aa39)
        _0x4539c3.g.exports('HasVehicleKey', _0x5148b6)
        _0x4539c3.g.exports('IsVinScratched', _0x4edba0)
      },
      474: (_0x29aec7, _0x5a2cc3, _0xd4438) => {
        Object.defineProperty(_0x5a2cc3, '__esModule', { value: true })
        _0x5a2cc3.HasCarPolishExpired =
          _0x5a2cc3.ApplyCarPolish =
          _0x5a2cc3.HasCarPolish =
          _0x5a2cc3.GetVehicleCarPolish =
          _0x5a2cc3.InitCarPolish =
            void 0
        const _0xef7fbf = _0xd4438(997),
          _0x12c011 = _0xd4438(348),
          _0x3c22f5 = _0xd4438(450)
        async function _0x302f6e() {}
        _0x5a2cc3.InitCarPolish = _0x302f6e
        function _0x190e18(_0xef347e) {
          const _0x47aeb2 = (0, _0x3c22f5.GetVehicleMetadata)(_0xef347e, 'carPolish')
          return typeof _0x47aeb2 === 'number' ? _0x47aeb2 : 0
        }
        _0x5a2cc3.GetVehicleCarPolish = _0x190e18
        _0xd4438.g.exports('GetVehicleCarPolish', _0x190e18)
        function _0x1d3a54(_0x5d2ac9) {
          const _0x50a573 = (0, _0x3c22f5.GetVehicleMetadata)(_0x5d2ac9, 'carPolish' )
          return typeof _0x50a573 === 'number' && _0x50a573 >= 0
        }
        _0x5a2cc3.HasCarPolish = _0x1d3a54
        async function _0x1169d4(_0x1748a6, _0x25dce6, _0x191c41) {
          const _0x16bc3f = NetworkGetEntityFromNetworkId(_0x1748a6)
          if (!_0x16bc3f) {
            return
          }
          const _0x37da43 = new _0xef7fbf.AnimationTask(
              PlayerPedId(),
              'normal',
              'Waxing vehicle',
              _0x191c41 + 20000,
              'WORLD_HUMAN_MAID_CLEAN',
              null
            ),
            _0x52fd46 = await _0x37da43.start()
          if (_0x52fd46 == 100) {
            SetVehicleDirtLevel(_0x16bc3f, 0)
            RemoveDecalsFromVehicle(_0x16bc3f)
            emitNet('pnp:vehicles:addCarPolish', _0x1748a6, _0x191c41)
            TriggerEvent('inventory:removeItem', _0x25dce6, 1)
          }
        }
        _0x5a2cc3.ApplyCarPolish = _0x1169d4
        const _0x539a6b = (_0x5a9d2b) => {
          return Math.round(Date.now() / 1000) > _0x5a9d2b
        }
        _0x5a2cc3.HasCarPolishExpired = _0x539a6b
        _0x12c011.DriverThread.addHook('afterStart', function () {
          this.data.carCleanTick = 0
          this.data.hasCarPolish = _0x1d3a54(this.data.vehicle)
          if (this.data.hasCarPolish) {
            this.data.carPolishExpires = _0x190e18(this.data.vehicle)
          }
        })
        _0x12c011.DriverThread.addHook('active', function () {
          if (this.data.hasCarPolish && ++this.data.carCleanTick > 60) {
            this.data.carCleanTick = 0
            if (
              GetVehicleDirtLevel(this.data.vehicle) > 0 &&
              !(0, _0x5a2cc3.HasCarPolishExpired)(this.data.carPolishExpires)
            ) {
              SetVehicleDirtLevel(this.data.vehicle, 0)
              RemoveDecalsFromVehicle(this.data.vehicle)
            }
          }
        })
        _0x12c011.DriverThread.addHook('afterStop', function () {
          if (
            _0x1d3a54(this.data.vehicle) &&
            (0, _0x5a2cc3.HasCarPolishExpired)(this.data.carPolishExpires)
          ) {
            emitNet('pnp:vehicles:removeCarPolish', this.data.netId)
          }
        })
      },
      256: (_0x133edd, _0x2733e3, _0x2b73f7) => {
        Object.defineProperty(_0x2733e3, '__esModule', { value: true })
        _0x2733e3.HasVehicleClass =
          _0x2733e3.DoRandomTyreDamage =
          _0x2733e3.SaveDegradation =
          _0x2733e3.DoRandomDegradation =
          _0x2733e3.ShowVehicleDegradation =
          _0x2733e3.GetDefaultDegradation =
          _0x2733e3.GetVehicleDegradation =
          _0x2733e3.InitDamage =
            void 0
        const _0x35020f = _0x2b73f7(615),
          _0x3cd642 = _0x2b73f7(343),
          _0x160793 = _0x2b73f7(348),
          _0x3ad81e = _0x2b73f7(450),
          _0x11aa22 = _0x2b73f7(396),
          _0x4fd263 = _0x2b73f7(141),
          _0x3c53fb = new Map()
        async function _0x58494d() {}
        _0x2733e3.InitDamage = _0x58494d
        function _0x255e45(_0x56110e) {
          if (!DoesEntityExist(_0x56110e)) {
            return false
          }
          const _0x429764 = Entity(_0x56110e)
          if (_0x429764) {
            const _0x20c7b6 = _0x429764.state?.degradation
              ? _0x429764.state?.degradation
              : _0x253f9a()
            return _0x20c7b6
          } else {
            return _0x253f9a()
          }
        }
        _0x2733e3.GetVehicleDegradation = _0x255e45
        _0x2b73f7.g.exports('GetVehicleDegradation', _0x255e45)
        function _0x253f9a() {
          return {
            axle: 100,
            brakes: 100,
            clutch: 100,
            electronics: 100,
            injector: 100,
            radiator: 100,
            tyres: 100,
            engine: 100,
            body: 100,
            transmission: 100,
          }
        }
        _0x2733e3.GetDefaultDegradation = _0x253f9a
        function _0x3c3057(_0x3a9400, _0x238895) {
          const _0x2986a6 = _0x255e45(_0x3a9400),
            _0x297041 = (0, _0x4fd263.GetVehicleMileage)(_0x3a9400)
          if (!_0x2986a6) {
            return
          }
          const _0x4bd2fa = (0, _0x3cd642.GetVehicleRating)(_0x3a9400)
          if (!_0x4bd2fa) {
            return
          }
          let _0x5b9190 = []
          for (const [_0x192808, _0x35cfa2] of Object.entries(_0x2986a6)) {
            let _0x50a31a = ''
            if (_0x238895) {
              _0x50a31a =
                'Current State: ' +
                _0x35cfa2.toFixed(2) +
                '% | Parts Required: ' +
                Math.floor((100 - _0x35cfa2) / 10)
            } else {
              const _0x199ab2 =
                _0x35cfa2 > 85
                  ? 'Excellent Condition'
                  : _0x35cfa2 > 75
                  ? 'Good Condition'
                  : _0x35cfa2 > 50
                  ? 'Bad Condition'
                  : _0x35cfa2 > 25
                  ? 'Terrible Condition'
                  : 'Absolutely Fucked'
              _0x50a31a = _0x199ab2
            }
            if (_0x238895) {
              _0x5b9190.push({
                title: (0, _0x3cd642.GetLocale)(_0x192808),
                description: _0x50a31a,
                action: 'pnp:vehicles:examineVehicleRepair',
                key : {
                  name : 'fix'+_0x192808,
                  part : _0x192808,
                  biz : 'tuner',
                  amount : Math.floor((100 - _0x35cfa2) / 10)
                }
              })
            } else {
              _0x5b9190.push({
                title: (0, _0x3cd642.GetLocale)(_0x192808),
                description: _0x50a31a,
              })
            }
          }
          _0x5b9190 = _0x5b9190.sort((_0x3af46d, _0x22b5aa) => {
            return _0x3af46d.title.localeCompare(_0x22b5aa.title)
          })
          _0x2b73f7.g.exports['fa-ui'].showContextMenu([
            {
              title: 'Vehicle Information',
              description:
                'Class: ' +
                _0x4bd2fa.class +
                ' | Rating: ' +
                (_0x238895 ? _0x4bd2fa.power : 'Unknown') +
                ' | Mileage: ' +
                Number(_0x297041).toFixed(1),
            },
            {
              title: 'Vehicle Diagnostics',
              description: '',
              children: _0x5b9190,
            },
          ])
        }
        _0x2733e3.ShowVehicleDegradation = _0x3c3057
        _0x2b73f7.g.exports('ShowVehicleDegradation', _0x3c3057)
        function _0x58f7bb(_0x44f8bc, _0x3c9669 = 2, _0x182006 = false) {
          if (!_0x182006 && (0, _0x35020f.GetRandom)(100) > 20) {
            return
          }
          if (!_0x3c53fb.has(_0x44f8bc)) {
            _0x3c53fb.set(_0x44f8bc, _0x255e45(_0x44f8bc))
          }
          const _0x57cbd6 = _0x3c53fb.get(_0x44f8bc)
          for (const [_0x64aa98] of Object.entries(_0x57cbd6)) {
            _0x57cbd6[_0x64aa98] = +(
              _0x57cbd6[_0x64aa98] - (0, _0x35020f.GetRandom)(_0x3c9669)
            ).toFixed(2)
          }
          _0x3f9bb3(_0x44f8bc)
        }
        _0x2733e3.DoRandomDegradation = _0x58f7bb
        async function _0x1e9b34(_0x2ffabe) {
          const _0x349ac6 = _0x3c53fb.get(_0x2ffabe)
          if (!_0x349ac6) {
            return
          }
          const _0x517cc3 = NetworkGetNetworkIdFromEntity(_0x2ffabe),
            _0x3e6462 = await RPC.execute('pnp:vehicles:addDegradation', _0x517cc3, _0x349ac6)
          _0x3e6462 && _0x3c53fb.delete(_0x2ffabe)
        }
        _0x2733e3.SaveDegradation = _0x1e9b34
        function _0x642c28(_0x1d9312, _0x2ff4bb, _0x2c90b8, _0x405c09) {
          const _0x94fb6d = GetVehicleWheelHealth(_0x1d9312, _0x2ff4bb),
            _0x2b1682 = _0x405c09
              ? (0, _0x35020f.GetRandom)(_0x2c90b8, _0x405c09)
              : (0, _0x35020f.GetRandom)(_0x2c90b8),
            _0x465223 = _0x94fb6d - _0x2b1682
          return (
            SetVehicleWheelHealth(_0x1d9312, _0x2ff4bb, _0x465223),
            _0x465223 < 300 &&
              !IsVehicleTyreBurst(_0x1d9312, _0x2ff4bb, false) &&
              SetVehicleTyreBurst(_0x1d9312, _0x2ff4bb, true, 100),
            _0x465223
          )
        }
        _0x2733e3.DoRandomTyreDamage = _0x642c28
        function _0x5ab197(_0x4c3cbc) {
          return (
            _0x4c3cbc === 13 ||
            _0x4c3cbc === 14 ||
            _0x4c3cbc === 15 ||
            _0x4c3cbc === 16
          )
        }
        _0x2733e3.HasVehicleClass = _0x5ab197
        let _0x1ecbb6 = 0,
          _0x398771 = false
        const _0xda90ef = {
            axle: [['fTractionBiasFront', false]],
            brakes: [
              ['fBrakeForce', true],
              ['fHandBrakeForce', true],
            ],
            clutch: [['fClutchChangeRateScaleUpShift', true]],
            electronics: [],
            injector: [['fInitialDriveMaxFlatVel', true]],
            radiator: [['fEngineDamageMult', false]],
            tyres: [['fLowSpeedTractionLossMult', false]],
            engine: [['fInitialDriveForce', true]],
            body: [
              ['fDeformationDamageMult', false],
              ['fCollisionDamageMult', false],
            ],
            transmission: [
              ['fClutchChangeRateScaleDownShift', true],
              ['fInitialDragCoeff', false],
            ],
          },
          _0x3f9bb3 = (_0x308cc3) => {
            const _0x3bdae5 = _0x255e45(_0x308cc3)
            if (!_0x3bdae5) {
              return
            }
            _0x398771 = false
            for (const [_0x33d889, _0x514003] of Object.entries(_0xda90ef)) {
              _0x514003.forEach((_0x36b5fc) => {
                const _0x32578b = _0x3bdae5[_0x33d889]
                let _0x5924fd = 1
                if (_0x32578b <= 75) {
                  _0x398771 = true
                  _0x36b5fc[1]
                    ? (_0x5924fd -= (1 - _0x32578b / 100) / 2)
                    : (_0x5924fd += (1 - _0x32578b / 100) / 2)
                }
                ;(0, _0x11aa22.SetHandlingContextMultiplier)(
                  _0x308cc3,
                  _0x36b5fc[0],
                  'degradation',
                  'multiplier',
                  _0x5924fd,
                  0
                )
              })
            }
            ;(0, _0x11aa22.ApplyHandlingMultipliers)(_0x308cc3)
          },
          _0x4210d0 = (_0x5921aa) => {
            const _0x1b38f4 = _0x255e45(_0x5921aa)
            if (!_0x1b38f4) {
              return
            }
            if (_0x1b38f4.brakes < 60 && (0, _0x35020f.GetRandom)(1, 4) > 3) {
              SetVehicleBrakeLights(_0x5921aa, true)
            }
            if (_0x1b38f4.clutch < 60 && (0, _0x35020f.GetRandom)(1, 4) > 3) {
              SetVehicleHandbrake(_0x5921aa, true)
              setTimeout(() => {
                SetVehicleHandbrake(_0x5921aa, false)
              }, 1000)
              SetVehicleEngineHealth(
                _0x5921aa,
                GetVehicleEngineHealth(_0x5921aa) - 50
              )
            }
            _0x1b38f4.electronics < 60 &&
              (SetVehicleLightMultiplier(
                _0x5921aa,
                (0, _0x35020f.GetRandom)(0, 10) / 10
              ),
              SetVehicleIndicatorLights(
                _0x5921aa,
                (0, _0x35020f.GetRandom)(0, 1),
                true
              ))
            if (
              _0x1b38f4.electronics < 30 &&
              (0, _0x35020f.GetRandom)(1, 4) > 3
            ) {
              ;(0, _0x3ad81e.TurnOffEngine)(_0x5921aa, true)
            }
            _0x1b38f4.injector < 60 &&
              (0, _0x35020f.GetRandom)(1, 4) > 3 &&
              ((0, _0x3ad81e.TurnOffEngine)(_0x5921aa, true),
              SetVehicleEngineHealth(
                _0x5921aa,
                GetVehicleEngineHealth(_0x5921aa) - 50
              ))
            if (
              _0x1b38f4.injector < 30 &&
              (0, _0x35020f.GetRandom)(1, 20) > 19
            ) {
              SetVehiclePetrolTankHealth(_0x5921aa, 500)
            }
            if (_0x1b38f4.radiator < 60 && (0, _0x35020f.GetRandom)(1, 4) > 3) {
              SetVehicleEngineHealth(
                _0x5921aa,
                GetVehicleEngineHealth(_0x5921aa) - 50
              )
              if (_0x1b38f4.body < 50 && (0, _0x35020f.GetRandom)(1, 20) > 19) {
                SetVehicleDoorBroken(_0x5921aa, (0, _0x35020f.GetRandom)(0, 5), false)
              }
              if (
                _0x1b38f4.transmission < 40 &&
                (0, _0x35020f.GetRandom)(1, 4) > 3
              ) {
                SetVehicleBurnout(_0x5921aa, true)
                setTimeout(() => {
                  SetVehicleBurnout(_0x5921aa, false)
                }, 2000)
                SetVehicleEngineHealth(_0x5921aa, GetVehicleEngineHealth(_0x5921aa) - 50)
              }
            }
          }
        _0x160793.DriverThread.addHook('preStart', function () {
          ;(this.data.damage = {}), (this.data.damageTick = 0)
        })
        _0x160793.DriverThread.addHook('afterStart', function () {
          this.data.degenTick = 0
          _0x398771 = false
          _0x1ecbb6 = this.data.vehicle
          SetDisableVehiclePetrolTankDamage(this.data.vehicle, true)
          SetVehicleEngineCanDegrade(this.data.vehicle, false)
          _0x3f9bb3(_0x1ecbb6)
        })
        _0x160793.DriverThread.addHook('active', function () {
          if (++this.data.damageTick > 30) {
            this.data.damageTick = 0
            const _0x2a4fd3 = this.data.averageSpeed * 0.00833,
              _0x5beb0f =
                (_0x2a4fd3 * 25) / 100 + (this.data.averageSpeed * 5) / 100,
              _0x2c616d = GetVehicleNumberOfWheels(this.data.vehicle)
            for (let _0x15a6f1 = 0; _0x15a6f1 < _0x2c616d; _0x15a6f1 += 1) {
              _0x642c28(this.data.vehicle, _0x15a6f1, _0x2a4fd3 + _0x5beb0f)
            }
          } else {
            if (++this.data.degenTick > 10 && _0x398771) {
              _0x4210d0(this.data.vehicle)
              this.data.degenTick = 0
            }
          }
        })
        _0x160793.DriverThread.addHook('preStop', function () {
          if (_0x5ab197(this.data.vehicleClass)) {
            return
          }
          _0x1e9b34(this.data.vehicle)
        })
        _0x160793.DriverThread.addHook('afterStop', function () {
          ;(_0x398771 = false),
            (this.data.damageTick = 0),
            (this.data.degenTick = 0)
        })
      },
      17: (_0x575311, _0x37a4b5, _0x4cc917) => {
        Object.defineProperty(_0x37a4b5, '__esModule', { value: true })
        _0x37a4b5.RefuelJerryCan =
          _0x37a4b5.GetJerryCanFuelLevel =
          _0x37a4b5.RefuelVehicle =
          _0x37a4b5.GetVehicleRefuelCost =
          _0x37a4b5.IsDoorOpen =
          _0x37a4b5.EmitLowFuelSound =
          _0x37a4b5.SetVehicleFuel =
          _0x37a4b5.CurrentFuel =
          _0x37a4b5.GetVehicleFuel =
          _0x37a4b5.InitFuel =
            void 0
        const _0x3d2280 = _0x4cc917(997),
          _0x35e406 = _0x4cc917(615),
          _0x5eeb81 = _0x4cc917(433),
          _0x45ba32 = _0x4cc917(348),
          _0x43f314 = _0x4cc917(235),
          _0x139fc5 = _0x4cc917(450)
        async function _0x1e4cdf() {
        }
        const _0x3b5eff = 35;
        const _0x42ff5e = GetHashKey('newsmav');
        const _0x956f06 = {
            fuelDrainBase: 0.99995,
            heliFuelDrainRate: 7,
            fuelHealthModifier: 400
        };
        let _0x521d3e = _0x956f06;
        _0x37a4b5.InitFuel = _0x1e4cdf
        const _0x15e962 = GetHashKey('newsmav')
        function _0x5d5922(_0x1a3984) {
          const fuel = (0, _0x139fc5.GetVehicleMetadata)(_0x1a3984, 'fuel')
          if (fuel) {
            return fuel
          } else {
            return 50
          }
        }
        _0x37a4b5.GetVehicleFuel = _0x5d5922
        function _0x543b3a() {
          return ((_0x139fc5.CurrentVehicle && _0x5d5922(_0x139fc5.CurrentVehicle)) || 50)
        }
        _0x37a4b5.CurrentFuel = _0x543b3a
        function _0x13b9ac(_0x32c621, pFuel) {
          const Fuel = Math.floor(pFuel)
          if (Fuel > 0) {
            emitNet('pnp:vehicles:reduceFuel', NetworkGetNetworkIdFromEntity(_0x32c621), Fuel)
          }
        }
        _0x37a4b5.SetVehicleFuel = _0x13b9ac
        async function _0x21aed7() {
          emit('DoLongHudText', 'Low fuel', 1)
          for (let _0x40d86f = 1; _0x40d86f < 4; _0x40d86f++) {
            PlaySound(-1, '5_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', false, 0, true)
            await (0, _0x35e406.Delay)(150 * _0x40d86f)
          }
        }
        _0x37a4b5.EmitLowFuelSound = _0x21aed7
        function _0x238e9d(_0x1496d1, _0x2b5848) {
          return GetVehicleDoorAngleRatio(_0x1496d1, _0x2b5848) > 0.1
        }
        _0x37a4b5.IsDoorOpen = _0x238e9d
        _0x45ba32.DriverThread.addHook('preStart', function () {
          this.data.fuelTick = 0
          this.data.fuelWarningTick = 0
          this.data.vehicleHealth = 1000
          // _0x521d3e = Object(_0x37a4b5)('fa-vehicles', 'fuel');
          const _0x20df2d = GetEntityModel(_0x139fc5.CurrentVehicle)
          this.data.isHelicopter = IsThisModelAHeli(_0x20df2d)
          this.data.isNewsHelicopter = _0x20df2d === _0x15e962
        })
        _0x45ba32.DriverThread.addHook('afterStart', function () {
          this.data.fuel = _0x5d5922(_0x139fc5.CurrentVehicle)
          SetVehicleFuelLevel(this.data.vehicle, this.data.fuel)
        })
        _0x45ba32.DriverThread.addHook('active', function () {
          const _0x4f628f = this.data.vehicleHealth / _0x521d3e.fuelHealthModifier
          let _0x23f56f = Math.max(2 - _0x4f628f, 1)
          if (this.data.isHelicopter && !this.data.isNewsHelicopter) {
            _0x23f56f = _0x521d3e.heliFuelDrainRate - _0x4f628f
          }
          let _0x1b9e8c = this.data.fuel 
          _0x1b9e8c -= (_0x521d3e.fuelDrainBase * (this.data.speed ^ 2) * _0x23f56f) / 1000
          this.data.fuel = _0x1b9e8c
          if (this.data.speed > 5 && _0x238e9d(_0x139fc5.CurrentVehicle, 5)) {
            SetVehicleDoorShut(_0x139fc5.CurrentVehicle, 5, true)
          }
          if (++this.data.fuelTick > 15) {
            this.data.fuelTick = 0
            _0x13b9ac(this.data.vehicle, this.data.fuel)
            SetVehicleFuelLevel(this.data.vehicle, this.data.fuel)
          }
        })
        _0x45ba32.DriverThread.addHook('active', function () {
          if (++this.data.fuelWarningTick > 45) {
            this.data.fuelWarningTick = 0
            if (this.data.fuel <= 15) {
              _0x21aed7()
            }
          }
          if (this.data.fuel <= 1) {
            _0x21aed7()
            ;(0, _0x139fc5.TurnOffEngine)(_0x139fc5.CurrentVehicle)
          }
        })
        _0x45ba32.DriverThread.addHook('afterStop', function () {
          _0x13b9ac(this.data.vehicle, this.data.fuel)
          this.data.fuel = 0
          this.data.fuelTick = 0
          this.data.fuelWarningTick = 0
        })
        _0x43f314.PassengerThread.addHook('preStart', function () {
          this.data.fuel = _0x5d5922(_0x139fc5.CurrentVehicle)
        })
        _0x43f314.PassengerThread.addHook('active', function () {
          this.data.fuel = _0x5d5922(_0x139fc5.CurrentVehicle)
        })
        _0x43f314.PassengerThread.addHook('afterStop', function () {
          this.data.fuel = 0
        })
        async function _0x49d508(
          _0x5e7b62,
          _0x189b20 = 100,
          _0x49e9de = false
        ) {
          const { taxLevel: _0x2f5f3e, fuelPrice: _0x2756f4 } =
              await RPC.execute('pnp:vehicles:getFuelPrice', 1),
            _0x1931c9 = _0x5e7b62 || 0
          let _0x428a42 = Math.floor(
            (_0x189b20 - _0x1931c9) * _0x2756f4 * (1 + _0x2f5f3e / 100)
          )
          if (_0x49e9de) {
            _0x428a42 = Math.floor(_0x428a42 * 0.25)
          }
          return [_0x2f5f3e, _0x428a42]
        }
        _0x37a4b5.GetVehicleRefuelCost = _0x49d508
        async function _0x36d9c7(_0x32c621icle, pAmount, _0x392aa0 = false, _0x58fbf6 = false,  _0x3f173a) {
          const ped = PlayerPedId(),
            _0x310058 = _0x5d5922(_0x32c621icle) || 0
          let _0x1e4ea9 = 100 - _0x310058,
            _0x26f983 = _0x1e4ea9 * 500
          if (_0x58fbf6) {
            _0x1e4ea9 = (((GetAmmoInPedWeapon(ped, 883325847) * 100) / 4500) * 35) / 100
            _0x26f983 = Math.floor(_0x1e4ea9 * 2 * 1000)
          }
          if (IsThisModelAHeli(GetEntityModel(_0x32c621icle))) {
            _0x26f983 *= 2
          }
          TaskTurnPedToFaceEntity(ped, _0x32c621icle, -1)
          const _0x4756b6 = new _0x3d2280.AnimationTask(PlayerPedId(), 'normal', 'Refueling', _0x26f983, 'weapon@w_sp_jerrycan', 'fire' ),
            _0x42e541 = await _0x4756b6.start((_0x3537bb) => {
              const _0x1c865f = setInterval(() => {
                if (!_0x4756b6.active) {
                  clearInterval(_0x1c865f)
                }
                if (
                  IsVehicleEngineOn(_0x32c621icle) &&
                  (0, _0x35e406.GetRandom)(100) > 98
                ) {
                  NetworkExplodeVehicle(_0x32c621icle, true, false, false)
                  _0x4756b6.abort()
                }
              }, 2000)
            }),
            pCash = await RPC.execute('GetCurrentCash')
          if (pCash < pAmount) {
            emit('DoLongHudText', "You can't afford it, you're missing $" + (pAmount - pCash), 1, 12000)
            return
          }
          const _0x3312ea = (_0x42e541 * _0x1e4ea9) / 100
          if (_0x58fbf6) {
            const _0x57c507 = Math.floor(
              ((((_0x1e4ea9 - _0x3312ea) * 100) / 30) * 4500) / 100
            )
            SetPedAmmo(ped, 883325847, _0x57c507)
          } else {
            const _0x5a23f6 = await RPC.execute('fa-vehicles:chargeForFuelRefill', pAmount )
            if (!_0x5a23f6) {
              emit('DoLongHudText', 'Error charging for fuel refill', 1, 12000)
            }
          }
          if (_0x3312ea > 0) {
            const pNetId = NetworkGetNetworkIdFromEntity(_0x32c621icle)
            await RPC.execute('pnp:vehicles:addFuel', pNetId, _0x3312ea, 1, _0x58fbf6, _0x392aa0, _0x3f173a)
            SetVehicleFuelLevel(_0x32c621icle, _0x310058 + _0x3312ea)
          }
        }
        _0x37a4b5.RefuelVehicle = _0x36d9c7
        function _0x529462() {
          return (
            (((GetAmmoInPedWeapon(PlayerPedId(), 883325847) * 100) / 4500) *
              35) /
            100
          )
        }
        _0x37a4b5.GetJerryCanFuelLevel = _0x529462
        async function _0x1d77cf(_0x31b608) {
          const _0x42ae0e = PlayerPedId(),
            _0x1c6154 =
              (((GetAmmoInPedWeapon(_0x42ae0e, 883325847) * 100) / 4500) * 35) /
              100,
            _0x154698 = 35 - _0x1c6154,
            _0x1907fc = _0x154698 * 800
          await (0, _0x5eeb81.TurnPedEntity)(_0x42ae0e, _0x31b608)
          const _0x5abb8c = new _0x3d2280.AnimationTask(
              PlayerPedId(),
              'normal',
              'Refilling Jerry Can',
              _0x1907fc,
              'weapon@w_sp_jerrycan',
              'fire'
            ),
            _0x3e974e = await _0x5abb8c.start(),
            _0x458939 = (_0x3e974e * _0x154698) / 100
          if (_0x458939 > 0) {
            await RPC.execute('pnp:vehicles:refillJerryCan', _0x458939)
          }
        }
        _0x37a4b5.RefuelJerryCan = _0x1d77cf
        _0x4cc917.g.exports('CurrentFuel', _0x543b3a)
        _0x4cc917.g.exports('GetVehicleFuel', _0x5d5922)
        _0x4cc917.g.exports('SetVehicleFuel', _0x13b9ac)
      },
      396: (_0x23cfb7, _0x1fe11f, _0x16e995) => {
        Object.defineProperty(_0x1fe11f, '__esModule', { value: true })
        _0x1fe11f.MassSetHandlingContextMultipier =
          _0x1fe11f.MassResetHandlingContextMultipier =
          _0x1fe11f.ApplyHandlingMultipliers =
          _0x1fe11f.ResetHandlingContextMultipier =
          _0x1fe11f.SetHandlingContextMultiplier =
          _0x1fe11f.GetVehicleHandling =
          _0x1fe11f.GetHandlingField =
          _0x1fe11f.InitHandling =
            void 0
        const _0x2581da = _0x16e995(348),
          _0x25168f = _0x16e995(450),
          _0x207cc4 = new Map()
        async function _0x48d150() {}
        _0x1fe11f.InitHandling = _0x48d150
        const _0x59bb5f = [
          'fBrakeForce',
          'fClutchChangeRateScaleDownShift',
          'fClutchChangeRateScaleUpShift',
          'fCollisionDamageMult',
          'fDeformationDamageMult',
          'fDriveBiasFront',
          'fDriveInertia',
          'fEngineDamageMult',
          'fHandBrakeForce',
          'fInitialDragCoeff',
          'fInitialDriveForce',
          'fInitialDriveMaxFlatVel',
          'fLowSpeedTractionLossMult',
          'fSteeringLock',
          'fSuspensionCompDamp',
          'fSuspensionForce',
          'fSuspensionReboundDamp',
          'fTractionBiasFront',
          'fTractionCurveMax',
          'fTractionCurveMin',
          'fTractionLossMult',
          'fWeaponDamageMult',
        ]
        function _0x74be1e(_0x32c621) { // GetHandlingField
          if (!DoesEntityExist(_0x32c621) || !IsEntityAVehicle(_0x32c621)) {
            return
          }
          if (!_0x207cc4.has(_0x32c621)) {
            const _0x535026 = {}
            for (const index of _0x59bb5f) {
              _0x535026[index] = GetVehicleHandlingFloat(_0x32c621, 'CHandlingData', index)
            }
            Object.freeze(_0x535026)
            _0x207cc4.set(_0x32c621, _0x535026)
          }
          return _0x207cc4.get(_0x32c621)
        }
        _0x1fe11f.GetHandlingField = _0x74be1e
        function _0x1b7b4a(_0x22fcda) {
          const _0x360393 = (0, _0x25168f.GetVehicleMetadata)(_0x22fcda, 'handling')
          if (!_0x360393) {
            return null
          }
          return _0x360393
        }
        _0x1fe11f.GetVehicleHandling = _0x1b7b4a
        function _0x4cccab(_0x43581e, _0x4e4787, _0x4b85eb, _0x1bc3e2, _0x13db8e, _0x5c6dc7 = 1) {
          const _0x363375 =
              _0x2581da.DriverThread.isActive &&
              _0x2581da.DriverThread.data.vehicle === _0x43581e,
            _0x29c7eb = _0x363375
              ? _0x2581da.DriverThread.data.handling
              : _0x1b7b4a(_0x43581e)
          if (!_0x29c7eb[_0x4e4787]) {
            _0x29c7eb[_0x4e4787] = {}
          }
          _0x29c7eb[_0x4e4787][_0x4b85eb] = {
            value: _0x13db8e,
            type: _0x1bc3e2,
            priority: _0x5c6dc7,
          }
        }
        _0x1fe11f.SetHandlingContextMultiplier = _0x4cccab
        function _0x2cce3d(_0x10e20f, _0x5e16a5, _0x5bf8bf) {
          const _0x5ab032 =
              _0x2581da.DriverThread.isActive &&
              _0x2581da.DriverThread.data.vehicle === _0x10e20f,
            _0x4e1456 = _0x5ab032
              ? _0x2581da.DriverThread.data.handling
              : _0x1b7b4a(_0x10e20f)
          if (!_0x4e1456[_0x5e16a5]) {
            _0x4e1456[_0x5e16a5] = {}
          }
          if (!_0x4e1456[_0x5e16a5][_0x5bf8bf]) {
            return
          }
          delete _0x4e1456[_0x5e16a5][_0x5bf8bf]
        }
        _0x1fe11f.ResetHandlingContextMultipier = _0x2cce3d
        function _0x48e554(_0x1b97ae, _0x19098f) {
          const _0x2aaede = _0x74be1e(_0x1b97ae),
            _0x5082dd = _0x359127(_0x1b97ae, _0x19098f),
            _0x14eb65 = (_0x46bf18, _0x2a406a) => {
              const _0x3a841a = _0x2aaede[_0x46bf18]
              if (_0x3a841a !== _0x2a406a) {
                console.log('Clean: ' + _0x3a841a + ' | Modified: ' + _0x2a406a + ' | Handling: ' + _0x46bf18)
              }
              SetVehicleHandlingFloat(_0x1b97ae, 'CHandlingData', _0x46bf18, _0x2a406a)
            }
          if (typeof _0x5082dd === 'number') {
            _0x14eb65(_0x19098f, _0x5082dd)
          } else {
            for (const [_0x295a16, _0x16b330] of Object.entries(_0x5082dd)) {
              _0x14eb65(_0x295a16, _0x16b330)
            }
          }
          SetVehicleEnginePowerMultiplier(_0x1b97ae, 0)
          SetVehiclePetrolTankHealth(_0x1b97ae, 4000)
          SetVehicleHasBeenOwnedByPlayer(_0x1b97ae, true)
        }
        _0x1fe11f.ApplyHandlingMultipliers = _0x48e554
        const _0x482a35 = (_0x3500e2, _0x29e1a0, _0x1ef0d0) => {
          for (const _0x59ae4e of _0x29e1a0) {
            _0x2cce3d(_0x3500e2, _0x1ef0d0, _0x59ae4e)
          }
          _0x48e554(_0x3500e2, _0x1ef0d0)
        }
        _0x1fe11f.MassResetHandlingContextMultipier = _0x482a35
        const _0xce9be4 = (_0x40b206, _0x58da3c, _0x4e8ca8, _0x2839d7 = 1) => {
          for (const [_0x4650c, _0x2a331c] of Object.entries(_0x58da3c)) {
            const _0x3686ca = _0x2a331c
            _0x4cccab(
              _0x40b206,
              _0x4650c,
              _0x4e8ca8,
              _0x3686ca.type,
              _0x3686ca.value,
              _0x2839d7
            )
          }
          _0x48e554(_0x40b206)
        }
        _0x1fe11f.MassSetHandlingContextMultipier = _0xce9be4
        function _0x359127(_0x5682f7, _0xd7d16d) {
          const _0x54a64c = _0x2581da.DriverThread.isActive && _0x2581da.DriverThread.data.vehicle === _0x5682f7,
            _0x3e2482 = _0x54a64c
              ? _0x2581da.DriverThread.data.handling
              : _0x1b7b4a(_0x5682f7)
          if (!_0x3e2482) {
            return
          }
          const _0x87d4c = (_0x3b148f, _0x38ba7b) => {
            const _0x4d5e38 = _0x3e2482[_0x38ba7b],
              _0x24ce21 = _0x74be1e(_0x3b148f)[_0x38ba7b]
            if (!_0x4d5e38) {
              return _0x24ce21
            }
            const _0xa2fc38 = Object.keys(_0x4d5e38).sort(
              (_0x45ef51, _0x9d2997) => {
                return _0x9d2997.priority - _0x45ef51.priority
              }
            )[0]
            if (!_0xa2fc38) {
              return _0x24ce21
            }
            const { value: _0x396cfa, type: _0x2f3917 } = _0x4d5e38[_0xa2fc38]
            let _0x34f3cc = _0x24ce21
            if (_0x2f3917 === 'fixed') {
              _0x34f3cc = _0x396cfa
            }
            _0x2f3917 === 'multiplier' && (_0x34f3cc = _0x24ce21 * _0x396cfa)
            _0x2f3917 === 'divider' && (_0x34f3cc = _0x24ce21 / _0x396cfa)
            for (const _0xae0ad6 of Object.keys(_0x4d5e38).filter(
              (_0x36bf42) => _0x36bf42.priority === 0
            )) {
              if (_0xae0ad6.type === 'multiplier') {
                _0x34f3cc = _0x34f3cc * _0xae0ad6.value
              }
              if (_0xae0ad6.type === 'divider') {
                _0x34f3cc = _0x34f3cc / _0xae0ad6.value
              }
            }
            return _0x34f3cc
          }
          if (_0xd7d16d) {
            return _0x87d4c(_0x5682f7, _0xd7d16d)
          }
          const _0x29dab5 = {}
          for (const _0x206bae of _0x59bb5f) {
            _0x29dab5[_0x206bae] = _0x87d4c(_0x5682f7, _0x206bae)
          }
          return _0x29dab5
        }
        _0x2581da.DriverThread.addHook('preStart', function () {
          this.data.handling = {}
        })
        _0x2581da.DriverThread.addHook('afterStart', function () {
          _0x48e554(this.data.vehicle)
        })
        on('onResourceStop', (_0x499fbd) => {
          if (_0x499fbd !== GetCurrentResourceName()) {
            return
          }
          _0x207cc4.entries((_0x53fce3, _0x6ee226) => {
            for (const [_0x2854bd, _0x1685b2] of Object.entries(_0x6ee226)) {
              SetVehicleHandlingFloat(_0x53fce3, 'CHandlingData', _0x2854bd, _0x1685b2)
            }
          })
        })
        on('baseevents:enteredVehicle', async (_0x5292c8) => {
          SetPedConfigFlag(PlayerPedId(), 35, false)
          const _0x9c837e = GetVehicleClass(_0x5292c8)
          ;(_0x9c837e == 15 || _0x9c837e == 16) &&
            (SetAudioSubmixEffectParamInt(0, 0, GetHashKey('enabled'), 1),
            SetAudioFlag('DisableFlightMusic', true))
        })
        on('baseevents:leftVehicle', () => {
          SetAudioSubmixEffectParamInt(0, 0, GetHashKey('enabled'), 0)
        })
        _0x16e995.g.exports('SetHandlingContextMultiplier', _0x4cccab)
        _0x16e995.g.exports('ResetHandlingContextMultipier', _0x2cce3d)
        _0x16e995.g.exports('ApplyHandlingMultipliers', _0x48e554)
        _0x16e995.g.exports('MassSetHandlingContextMultipier', _0x1fe11f.MassSetHandlingContextMultipier)
        _0x16e995.g.exports('MassResetHandlingContextMultipier', _0x1fe11f.MassResetHandlingContextMultipier)
      },
      369: (_0x431693, _0x481061, _0x533669) => {
        Object.defineProperty(_0x481061, '__esModule', { value: true })
        _0x481061.EjectLUL =
          _0x481061.SetHarness =
          _0x481061.SetSeatBelt =
          _0x481061.DoHarnessDamage =
          _0x481061.GetHarnessLevel =
          _0x481061.VehicleHasHarness =
          _0x481061.InitHarness =
          _0x481061.HasHarnessOn =
          _0x481061.HasSeatBeltOn =
            void 0
        const _0x5084fc = _0x533669(615),
          _0x46d5b3 = _0x533669(348),
          _0x528d29 = _0x533669(450)
        _0x481061.HasSeatBeltOn = false
        _0x481061.HasHarnessOn = false
        async function _0x3eff93() {}
        _0x481061.InitHarness = _0x3eff93
        function _0x32fe02(_0x3bab07) {
          const _0x33663e = (0, _0x528d29.GetVehicleMetadata)(_0x3bab07, 'harness')
          return _0x33663e ? _0x33663e > 0 : false
        }
        _0x481061.VehicleHasHarness = _0x32fe02
        function _0x8c7107(_0x12029a) {
          const _0x11a610 = (0, _0x528d29.GetVehicleMetadata)(_0x12029a, 'harness')
          return typeof _0x11a610 === 'number' ? _0x11a610 : 0
        }
        _0x481061.GetHarnessLevel = _0x8c7107
        function _0x472c1c(_0x582c18) {
          const _0x1d1b86 = NetworkGetNetworkIdFromEntity(_0x528d29.CurrentVehicle)
          if (!_0x1d1b86) {
            return
          }
          emitNet('pnp:vehicles:DoHarnessDamage', _0x1d1b86, _0x582c18)
        }
        _0x481061.DoHarnessDamage = _0x472c1c
        _0x533669.g.exports('GetHarnessLevel', _0x8c7107)
        _0x533669.g.exports('VehicleHasHarness', _0x32fe02)
        function _0x4677af(_0x14acf8) {
          if (_0x14acf8 && !_0x528d29.InVehicle) {
            return
          }
          _0x481061.HasSeatBeltOn = _0x14acf8
          emit('seatbelt', _0x14acf8)
        }
        _0x481061.SetSeatBelt = _0x4677af
        function _0x32d5bb(_0x1a1085) {
          if (_0x1a1085 && (!_0x528d29.InVehicle || !_0x32fe02(_0x528d29.CurrentVehicle))) {
            return
          }
          _0x481061.HasHarnessOn = _0x1a1085
          emit('harness', _0x1a1085, _0x8c7107(_0x528d29.CurrentVehicle))
        }
        _0x481061.SetHarness = _0x32d5bb
        _0x533669.g.exports('SetSeatBelt', _0x4677af)
        _0x533669.g.exports('SetHarness', _0x32d5bb)
        _0x46d5b3.DriverThread.addHook('preStart', function () {
          this.data.harnessTick = 0
          this.data.harnessLevel = _0x8c7107(this.data.vehicle)
        })
        _0x46d5b3.DriverThread.addHook('active', function () {
          if (++this.data.harnessTick < 3) {
            return
          }
          this.data.harnessTick = 0
          this.data.harnessLevel = _0x8c7107(this.data.vehicle)
          this.data.harnessLevel <= 0 &&
            _0x481061.HasHarnessOn &&
            _0x32d5bb(false)
        })
        _0x46d5b3.DriverThread.addHook('afterStop', function () {
          this.data.harnessTick = 0
        })
        function _0x7a3aa4(_0x2820fe, _0x50d1e3) {
          const _0x93c765 = PlayerPedId(),
            [_0x1f45bf, _0x49dd03, _0x221ce9] =
              GetOffsetFromEntityInWorldCoords(_0x2820fe, 1, 0, 1)
          SetEntityCoords(
            _0x93c765,
            _0x1f45bf,
            _0x49dd03,
            _0x221ce9,
            false,
            false,
            false,
            false
          )
          SetPedToRagdoll(_0x93c765, 5511, 5511, 0, false, false, false)
          SetEntityVelocity(_0x93c765, _0x50d1e3.x, _0x50d1e3.y, _0x50d1e3.z)
          const _0x30fdfb = Math.round(GetEntitySpeed(_0x93c765) * 1.5),
            _0x5d7e76 = GetEntityHealth(_0x93c765) - _0x30fdfb
          SetEntityHealth(_0x93c765, _0x5d7e76 >= 0 ? _0x5d7e76 : 0)
        }
        _0x481061.EjectLUL = _0x7a3aa4
        RegisterCommand('+toggleSeatbelt', async () => {
            if (!_0x528d29.InVehicle) {
              return
            }
            const _0x3c2176 = _0x32fe02(_0x528d29.CurrentVehicle),
              _0x93dbb7 = _0x528d29.CurrentSeat === -1
            if (!_0x481061.HasHarnessOn && _0x3c2176 && _0x93dbb7) {
              const _0x37613f = await (0, _0x5084fc.taskBar)(5000, 'Putting on Harness')
              if (_0x37613f !== 100) {
                return
              }
              _0x32d5bb(true)
              _0x4677af(true)
              emit('InteractSound_CL:PlayOnOne', 'seatbelt', 0.7)
            } else {
              if (_0x481061.HasHarnessOn) {
                const _0x57926c = await (0, _0x5084fc.taskBar)(1000, 'Taking off Harness')
                if (_0x57926c !== 100) {
                  return
                }
                _0x32d5bb(false)
                _0x4677af(false)
                emit('InteractSound_CL:PlayOnOne', 'seatbeltoff', 0.7)
              } else {
                if (!_0x481061.HasSeatBeltOn && !_0x3c2176) {
                  _0x4677af(true),
                    emit('InteractSound_CL:PlayOnOne', 'seatbelt', 0.7)
                } else {
                  _0x481061.HasSeatBeltOn &&
                    !_0x3c2176 &&
                    (_0x4677af(false),
                    emit('InteractSound_CL:PlayOnOne', 'seatbeltoff', 0.7))
                }
              }
            }
          },
          false
        )
        RegisterCommand('-toggleSeatbelt', () => {}, false)
        _0x533669.g.exports['fa-keybinds'].registerKeyMapping(
          '',
          'Vehicle',
          'Seatbelt Toggle',
          '+toggleSeatbelt',
          '-toggleSeatbelt',
          'B'
        )
      },
      839: (_0x4cd380, _0x53fbbc, _0x2bd251) => {
        Object.defineProperty(_0x53fbbc, '__esModule', { value: true })
        _0x53fbbc.InitSystems = void 0
        const _0x342afb = _0x2bd251(474),
          _0x1976e5 = _0x2bd251(256),
          _0x5a9d9e = _0x2bd251(17),
          _0xea67cd = _0x2bd251(396),
          _0x22f12c = _0x2bd251(369),
          _0x3e6038 = _0x2bd251(141),
          _0x2101bd = _0x2bd251(547)
        async function _0x342e9c() {
          await (0, _0x1976e5.InitDamage)(),
            await (0, _0x5a9d9e.InitFuel)(),
            await (0, _0xea67cd.InitHandling)(),
            await (0, _0x22f12c.InitHarness)(),
            await (0, _0x3e6038.InitMileage)(),
            await (0, _0x342afb.InitCarPolish)(),
            await (0, _0x2101bd.InitNosRefil)()
        }
        _0x53fbbc.InitSystems = _0x342e9c
      },
      965: (_0x4a069c, _0x22ddce, _0xde28c8) => {
        Object.defineProperty(_0x22ddce, '__esModule', { value: true })
        _0x22ddce.DoorLockCheck =
          _0x22ddce.HotwireVehicle =
          _0x22ddce.LockpickVehicleDoor =
            void 0
        const _0x39b2c8 = _0xde28c8(615),
          _0x5c9859 = _0xde28c8(710)
        let _0x460163 = false,
          _0x243116 = {
            active: false,
            data: {
              success: false,
              stage: 0,
            },
          }
        async function _0x394dcb(
          veh,
          _0x2812d4 = 'lockpick',
          _0x2b5956 = false,
          _0x4e5936
        ) {
          if (_0x460163) {
            return
          }
          _0x460163 = true
          emit('fa-vehicle:client:doorLockpicking', NetworkGetNetworkIdFromEntity(veh))
          const _0x24b733 = await _0xde28c8.g.exports['fa-ui'].taskBarSkill(15000, 3)
          if (_0x24b733 !== 100) {
            _0x460163 = false
            _0x4e5936({ success: false })
            return
          }
          const _0x47bc80 = await _0xde28c8.g.exports['fa-ui'].taskBarSkill(2200, 4)
          if (_0x47bc80 !== 100) {
            _0x460163 = false
            _0x4e5936({ success: false })
            return
          }
          ClearPedTasksImmediately(PlayerPedId())
          const _0x2d7635 = _0x24b733 === 100 && _0x47bc80 === 100
          if (!_0x2b5956) {
            emit('inventory:DegenLastUsedItem', _0x2d7635 ? 5 : 20)
          }
          if (_0x24b733 === 100 && _0x47bc80 === 100) {
            const _0x901dc6 = GetPedInVehicleSeat(veh, -1)
            if (_0x901dc6 !== 0 && IsEntityDead(_0x901dc6)) {
              SetVehicleDoorsLocked(veh, 0)
              setTimeout(() => SetControlNormal(0, 23, 2), 500)
              const _0x56c3e4 = await _0xde28c8.g.exports['fa-taskbar'].taskBar(5000, 'Taking car keys', false)
              emit('civilian:alertPolice', 20, 'lockpick', veh)
              if (!_0x2b5956) {
                _0xde28c8.g.exports['fa-flags'].SetVehicleFlag(veh,'isStolenVehicle', true)
              }
              if (_0x56c3e4 === 100) {
                emit('vehicle:keys:addNew', veh)
                emit('DoLongHudText', 'Got the vehicle keys.', 1)
              }
            }
            SetVehicleDoorsLocked(veh, 1)
            emit('DoLongHudText', 'Vehicle Unlocked.', 1)
            emitNet('fa-fx:sound:vehicles', 'unlock')
          }
          return (
            (_0x460163 = false), _0x4e5936({ success: true }), { success: true }
          )
        }
        _0x22ddce.LockpickVehicleDoor = _0x394dcb
        _0xde28c8.g.exports('LockpickVehicleDoor', (_0x20f234, _0x59e81a = 'lockpick', _0x456a2c = false, _0x5b54d8) => {
            return _0x394dcb(_0x20f234, _0x59e81a, _0x456a2c, _0x5b54d8)
          }
        )
        async function _0x404ad3(_0x4217ea, _0x2cd61e, _0x46e57d, cb) {
          const _0x161f35 = await _0xde28c8.g.exports['fa-ui'].taskBarSkill(Math.floor(Math.random() * 5000) + 5000, Math.floor(Math.random() * 5) + 10)
          if (_0x161f35 !== 100) {
            cb({
              success: false,
              stage: 1,
            })
            return
          }
          await _0xde28c8.g.exports['fa-taskbar'].taskBar(5000, 'Hotwiring Stage 1 Complete')
          const _0x44d803 = await _0xde28c8.g.exports['fa-ui'].taskBarSkill(Math.floor(Math.random() * 5000) + 5000, Math.floor(Math.random() * 5) + 10)
          if (_0x44d803 !== 100) {
            cb({
              success: false,
              stage: 2,
            })
            return
          }
          await _0xde28c8.g.exports['fa-taskbar'].taskBar(5000, 'Hotwiring Stage 2 Complete')
          const _0x1b2369 = await _0xde28c8.g.exports['fa-ui'].taskBarSkill(1500, Math.floor(Math.random() * 5) + 5)
          if (_0x1b2369 !== 100) {
            cb({
              success: false,
              stage: 3,
            })
            return
          }
          await _0xde28c8.g.exports['fa-taskbar'].taskBar(5000, 'Hotwiring Stage 3 Complete')
          await (0, _0x39b2c8.Delay)(500)
          if (_0x161f35 === 100 && _0x44d803 === 100 && _0x1b2369 === 100) {
            const _0x3ad0c3 = GetEntityCoords(_0x4217ea, false),
              _0x45e86a = GetEntityCoords(PlayerPedId(), false)
            if (
              GetDistanceBetweenCoords(
                _0x3ad0c3[0],
                _0x3ad0c3[1],
                _0x3ad0c3[2],
                _0x45e86a[0],
                _0x45e86a[1],
                _0x45e86a[2],
                true
              ) < 10 &&
              _0x4217ea !== 0 &&
              GetEntitySpeed(_0x4217ea) < 5
            ) {
              emit('vehicle:keys:addNew', _0x4217ea)
              emit('DoLongHudText', 'Ignition Working.', 1)
              await _0xde28c8.g.exports['fa-flags'].SetVehicleFlag(_0x4217ea, 'isStolenVehicle', true)
              await _0xde28c8.g.exports['fa-flags'].SetVehicleFlag(_0x4217ea, 'isHotwiredVehicle', true)
              cb({
                success: true,
                stage: 3,
              })
              return
            }
            cb({ success: false })
            return
          }
        }
        _0x22ddce.HotwireVehicle = _0x404ad3
        _0xde28c8.g.exports('HotwireVehicle', _0x404ad3)
        async function _0x3dd609(_0x2ace06) {
          if (!(0, _0x5c9859.HasVehicleKey)(_0x2ace06)) {
            const _0x4ed8bb = GetPedInVehicleSeat(_0x2ace06, -1)
            if (_0x4ed8bb !== 0 && !IsPedAPlayer(_0x4ed8bb)) {
              const _0x53b086 = GetVehicleDoorLockStatus(_0x2ace06)
              _0x53b086 === 1 && SetVehicleDoorsLocked(_0x2ace06, 2)
            }
          }
        }
        _0x22ddce.DoorLockCheck = _0x3dd609
        async function _0x3a7b63(_0x11a969, _0x26f029) {
          if ((0, _0x5c9859.HasVehicleKey)(_0x11a969)) {
            const _0x775619 = GetVehicleDoorLockStatus(_0x11a969),
              _0x41f042 = _0x775619 === 0 || _0x775619 === 1
            SetVehicleDoorsLocked(_0x11a969, _0x41f042 ? 2 : 1)
            _0x41f042
              ? (emit('DoLongHudText', 'Vehicle Locked.', 1) , emitNet('fa-fx:sound:vehicles', 'lock'))
              : (emit('DoLongHudText', 'Vehicle Unlocked.', 1), emitNet('fa-fx:sound:vehicles', 'unlock'))
            _0x26f029 &&
              (await (0, _0x39b2c8.loadAnimDict)('anim@heists@keycard@'),
              TaskPlayAnim(
                PlayerPedId(),
                'anim@heists@keycard@',
                'exit',
                8,
                1,
                -1,
                48,
                0,
                false,
                false,
                false
              ))
          }
        }
        RegisterCommand('+vehicleLock', () => {
            const _0x1a97c9 =
              _0xde28c8.g.exports['fa-target'].GetCurrentEntity()
            let _0x127af6
            if (_0x1a97c9 && DoesEntityExist(_0x1a97c9)) {
              _0x3a7b63(_0x1a97c9, true)
            } else {
              ;(_0x127af6 = GetVehiclePedIsIn(PlayerPedId(), false)) &&
                _0x3a7b63(_0x127af6, true)
            }
          },
          false
        )
        RegisterCommand('-vehicleLock', () => {}, false)
        _0xde28c8.g.exports['fa-keybinds'].registerKeyMapping(
          '',
          'Vehicle',
          'Lock Doors',
          '+vehicleLock',
          '-vehicleLock',
          'L'
        )
      },
      141: (_0x75b0e2, _0x4eae01, _0x5a8267) => {
        Object.defineProperty(_0x4eae01, '__esModule', { value: true })
        _0x4eae01.SetVehicleMileage =
          _0x4eae01.GetVehicleMileage =
          _0x4eae01.InitMileage =
            void 0
        const _0x810a23 = _0x5a8267(348),
          _0x117769 = _0x5a8267(450),
          _0x92b600 = _0x5a8267(256)
        async function _0x4dc271() {}
        _0x4eae01.InitMileage = _0x4dc271
        function _0x488a31(_0x791e1b) {
          const _0x27d176 = (0, _0x117769.GetVehicleMetadata)(_0x791e1b, 'mileage')
          return _0x27d176 ? _0x27d176 || 0 : 0
        }
        _0x4eae01.GetVehicleMileage = _0x488a31
        function _0x182ddd(_0x4c3da6, _0xaaab3) {
          const _0x2b4067 = _0x488a31(_0x4c3da6),
            _0x3a2a0f = _0xaaab3 - _0x2b4067
          if (_0x3a2a0f <= 0) {
            return
          }
          ;(0, _0x92b600.DoRandomDegradation)(_0x4c3da6, (_0x3a2a0f / 10) * 2, true)
          emitNet('pnp:vehicles:addMileage', NetworkGetNetworkIdFromEntity(_0x4c3da6), _0x3a2a0f)
        }
        _0x4eae01.SetVehicleMileage = _0x182ddd
        _0x810a23.DriverThread.addHook('preStart', function () {
          this.data.mileageTick = 0
          this.data.mileage = _0x488a31(this.data.vehicle)
          this.data.speedCount = 0
          this.data.averageSpeed = 0
        })
        _0x810a23.DriverThread.addHook('active', function () {
          this.data.speedCount += this.data.speed
          if (++this.data.mileageTick < 30) {
            return
          }
          this.data.averageSpeed = (this.data.speedCount / 30) * 2.236936
          this.data.mileageTick = 0
          this.data.speedCount = 0
          if (this.data.averageSpeed <= 0) {
            return
          }
          this.data.mileage += this.data.averageSpeed * 0.00833
        })
        _0x810a23.DriverThread.addHook('preStop', function () {
          _0x182ddd(this.data.vehicle, this.data.mileage)
        })
        _0x810a23.DriverThread.addHook('afterStop', function () {
          ;(this.data.mileage = 0),
            (this.data.mileageTick = 0),
            (this.data.speedCount = 0),
            (this.data.averageSpeed = 0)
        })
      },
      547: (_0x4519e6, _0x4494b5, _0x292651) => {
        Object.defineProperty(_0x4494b5, '__esModule', { value: true })
        _0x4494b5.RefillNOSCan =
          _0x4494b5.IsUsingNitro =
          _0x4494b5.GetNitroLevel =
          _0x4494b5.VehicleHasNitro =
          _0x4494b5.InitNosRefil =
            void 0
        const _0x598f6c = _0x292651(615),
          _0x3210c4 = _0x292651(570),
          _0x56af02 = _0x292651(450)
          const _0x2c8a4e = FYX.Utils.cacheableMap(async (_0x577cf9, _0x26abac) => {
              const _0x2d988e = _0x292651.g.exports['fa-business'].IsEmployedAt(_0x26abac)
              return [true, _0x2d988e]
            },
            { timeToLive: 60000 }
          ),
          _0x4a642d = FYX.Utils.cacheableMap(
            async (_0x27b4b2, _0x3a60b4, _0x495ba6, _0x1e1878) => {
              const _0xdfad91 = _0x292651.g.exports['fa-business'].HasPermission(_0x495ba6, _0x1e1878)
              return [true, _0xdfad91]
            },
            { timeToLive: 60000 }
          )
        async function _0x2b3180() {
          _0x292651.g.exports['fa-polytarget'].AddBoxZone('nitro_refill',
            {
              x: 137.51,
              y: -3051.41,
              z: 7.04,
            },
            0.8,
            0.6,
            {
              heading: 30,
              minZ: 5.84,
              maxZ: 7.44,
              data: {
                id: 'tuner_refill',
                business: 'tuner_shop',
              },
            }
          )
          _0x292651.g.exports['fa-polytarget'].AddBoxZone('nitro_refill',
            {
              x: 1185.08,
              y: 2636.82,
              z: 37.76,
            },
            0.6,
            0.6,
            {
              heading: 4,
              minZ: 36.76,
              maxZ: 38.16,
              data: {
                id: 'harmony_refill',
                business: 'harmony_repairs',
              },
            }
          )
          _0x292651.g.exports['fa-interact'].AddPeekEntryByPolyTarget('nitro_refill',
            [
              {
                id: 'bozo2309847239784234',
                event: 'fa-vehicles:client:refillNoS',
                icon: 'fill',
                label: 'Refill Nitro (2 GNE)',
              },
            ],
            {
              distance: { radius: 3.5 },
              isEnabled: (_0x235d72, _0x108157) => {
                var _0x478529, _0x4d135a
                const _0x566b82 = (_0x4d135a =
                    (_0x478529 = _0x108157 === null || _0x108157 === void 0
                        ? void 0
                        : _0x108157.zones) === null || _0x478529 === void 0
                      ? void 0
                      : _0x478529.nitro_refill) === null || _0x4d135a === void 0
                    ? void 0
                    : _0x4d135a.business
                return _0x566b82 && _0x2c8a4e(_0x566b82)
              },
            }
          )
        }
        _0x4494b5.InitNosRefil = _0x2b3180
        function _0x39eab0(_0x54cdef) {
          const _0x19e7e8 = (0, _0x56af02.GetVehicleMetadata)(_0x54cdef, 'nitro')
          return _0x19e7e8 ? _0x19e7e8 > 0 : false
        }
        _0x4494b5.VehicleHasNitro = _0x39eab0
        function _0x17fa2b(_0x26c41a) {
          const _0x423f19 = (0, _0x56af02.GetVehicleMetadata)(_0x26c41a, 'nitro')
          return typeof _0x423f19 === 'number' ? _0x423f19 : 0
        }
        _0x4494b5.GetNitroLevel = _0x17fa2b
        function _0x2c571e() {
          return _0x3210c4.NitroThread.isActive
        }
        _0x4494b5.IsUsingNitro = _0x2c571e
        async function _0x20ea75(_0x2357ae) {
          let _0x3c7271 = ''
          if (!_0x2357ae) {
            return false
          }
          const _0x35ded2 = _0x292651.g.exports['fa-inventory'].hasEnoughOfItem('nitrous', 1)
          if (!_0x35ded2) {
            return false
          }
          const _0x434ed9 =
            _0x292651.g.exports['fa-inventory'].GetInfoForFirstItemOfName('nitrous')
          if (!_0x434ed9) {
            return false
          }
          const _0x2f0c6e =
            (_0x3c7271 = JSON.parse(_0x434ed9.information).Status) !== null &&
            _0x3c7271 !== void 0
              ? _0x3c7271
              : 'Filled'
          if (_0x2f0c6e === 'Filled') {
            return emit('DoLongHudText', 'Nitrous can is already full.')
          }
          const _0x272681 = _0x434ed9.quantity,
            _0x10207d = _0x272681 * 2,
            _0x1f467e = await _0x292651.g.exports['fa-phone'].DoPhoneConfirmation(30, 'Nitrous Refill (' + _0x272681 + ')', 'Will cost ' + _0x10207d + ' GNE', 'file-invoice-dollar')
          if (!_0x1f467e) {
            return false
          }
          emit('animation:PlayAnimation', 'type')
          const _0x34962d = await (0, _0x598f6c.taskBar)(5000, 'Refill NOS Can')
          ClearPedTasks(PlayerPedId())
          if (_0x34962d !== 100) {
            return false
          }
          return (
            emit('inventory:updateItem', 'nitrous', _0x434ed9.slot, JSON.stringify({ Status: 'Filled' })),
            emit('DoLongHudText', 'Successfully refilled nitrous can.'),
            true
          )
        }
        _0x4494b5.RefillNOSCan = _0x20ea75
        _0x292651.g.exports('GetNitroLevel', _0x17fa2b)
        _0x292651.g.exports('IsUsingNitro', _0x2c571e)
        _0x292651.g.exports('VehicleHasNitro', _0x39eab0)
        _0x292651.g.exports('RefillNOSCan', _0x20ea75)
      },
      348: (_0x3389c5, _0x4a3d36, _0x58ebe5) => {
        Object.defineProperty(_0x4a3d36, '__esModule', { value: true })
        _0x4a3d36.DriverThread = _0x4a3d36.InitDriver = void 0
        const _0x321a5c = _0x58ebe5(769),
          _0x3032be = _0x58ebe5(450)
        async function _0x2f104c() {}
        _0x4a3d36.InitDriver = _0x2f104c
        DecorRegister('Vehicle:Temperature', 3)
        DecorRegister('PLAYER_VEHICLE', 3)
        _0x4a3d36.DriverThread = new _0x321a5c.Hooks(async function () {
          this.data.health = GetVehicleEngineHealth(this.data.vehicle)
          this.data.bodyHealth = GetVehicleBodyHealth(this.data.vehicle)
          this.data.speed = GetEntitySpeed(this.data.vehicle)
          await (0, _0x3032be.VerifyEngineState)(this.data.vehicle)
          ;(this.data.health <= 0 || this.data.bodyHealth <= 50) &&
            (0, _0x3032be.TurnOffEngine)(this.data.vehicle)
          if (this.data.temperature > 0 && ++this.data.temperatureTick >= 2) {
            this.data.temperatureTick = 0
            --this.data.temperature
          }
        }, 1000)
        _0x4a3d36.DriverThread.addHook('preStart', function () {
          if (!(0, _0x3032be.VerifyEngineState)(_0x3032be.CurrentVehicle)) {
            this.abort()
          }
          DecorSetInt(_0x3032be.CurrentVehicle, 'PLAYER_VEHICLE', 1)
          this.data.vehicle = _0x3032be.CurrentVehicle
          this.data.netId = NetworkGetNetworkIdFromEntity(_0x3032be.CurrentVehicle)
          this.data.hasLicense = true
          this.data.vehicleModel = GetEntityModel(this.data.vehicle)
          this.data.vehicleClass = GetVehicleClass(this.data.vehicle)
          this.data.temperatureTick = 0
          this.data.temperature =
            DecorGetInt(this.data.vehicle, 'Vehicle:Temperature') || 0
          ;(0, _0x3032be.GenerateVehicleInformation)(this.data.vehicle)
        })
        _0x4a3d36.DriverThread.addHook('preStop', function () {
          DecorSetInt(this.data.vehicle, 'Vehicle:Temperature', this.data.temperature)
        })
        _0x4a3d36.DriverThread.addHook('afterStop', function () {
          emit('noshud', 0, false)
        })
      },
      519: (_0x1e4784, _0x3ba229, _0x550d10) => {
        Object.defineProperty(_0x3ba229, '__esModule', { value: true })
        _0x3ba229.InitThreads = void 0
        const _0x3e1477 = _0x550d10(615),
          _0x580dbd = _0x550d10(348),
          _0x3e9fd5 = _0x550d10(235),
          _0x2201e0 = _0x550d10(570)
        async function _0x23e20a() {
          await (0, _0x3e1477.Delay)(1000)
          await (0, _0x580dbd.InitDriver)()
          await (0, _0x3e9fd5.InitPassenger)()
          await (0, _0x2201e0.InitNitro)()
        }
        _0x3ba229.InitThreads = _0x23e20a
      },
      570: (_0xacdd13, _0x1dbe26, _0x30b1e9) => {
        Object.defineProperty(_0x1dbe26, '__esModule', { value: true })
        _0x1dbe26.NitroThread = _0x1dbe26.InitNitro = void 0
        const _0x55051c = _0x30b1e9(769),
          _0x450f48 = _0x30b1e9(615),
          _0x1df199 = _0x30b1e9(396),
          _0x439326 = _0x30b1e9(547),
          _0x3b302f = _0x30b1e9(450),
          _0x189f07 = _0x30b1e9(348)
        async function _0x4c6e81() {}
        _0x1dbe26.InitNitro = _0x4c6e81
        _0x1dbe26.NitroThread = new _0x55051c.Hooks(async function () {}, 1000, 'tick')
        const _0x575ffe = {
          mode: 'Boost',
          flowRate: 5,
          blowoutTickThreshold: 15,
          blowoutPercentage: 5,
          blowoutSpeed: 95,
          highBurstSpeed: 15,
          lowBurstSpeed: 100,
          highBurst: 1,
          lowBurst: 0.1,
        }
        _0x1dbe26.NitroThread.addHook('active', function () {
          if (!this.data.driver || --this.data.nitroLevel <= 0) {
            return this.stop()
          }
          const _0x2ad070 = this.data.driver.speed * 2.236936,
            _0x15975a = this.data.driver.temperature
          if (
            this.data.mode === 'Boost' &&
            _0x2ad070 > _0x575ffe.highBurstSpeed
          ) {
            const _0x4af470 =
                _0x2ad070 >= _0x575ffe.lowBurstSpeed
                  ? _0x575ffe.lowBurst
                  : _0x575ffe.highBurst,
              _0x12e656 = 1 + (_0x4af470 * (_0x575ffe.flowRate * 10)) / 100
            this.data.multiplier !== _0x12e656 &&
              ((this.data.multiplier = _0x12e656),
              (0, _0x1df199.SetHandlingContextMultiplier)(
                this.data.vehicle,
                'fInitialDriveForce',
                'nitro',
                'multiplier',
                _0x12e656,
                2
              ),
              (0, _0x1df199.ApplyHandlingMultipliers)(this.data.vehicle, 'fInitialDriveForce'))
            ++this.data.driver.temperature
          }
          if (
            _0x2ad070 > _0x575ffe.blowoutSpeed &&
            _0x15975a > _0x575ffe.blowoutTickThreshold
          ) {
            const _0x56c469 = (0, _0x450f48.GetRandom)(100),
              _0x327c96 = this.data.vehicle,
              _0x311d47 = GetVehicleEngineHealth(_0x327c96)
            if (_0x311d47 <= 0 || _0x56c469 <= _0x575ffe.blowoutPercentage) {
              SetVehicleEngineHealth(_0x327c96, 0)
              ;(0, _0x3b302f.TurnOffEngine)(_0x327c96)
              ;(0, _0x450f48.PlayEntitySound)(
                _0x327c96,
                'Engine_fail',
                'DLC_PILOT_ENGINE_FAILURE_SOUNDS',
                1000
              )
            } else {
              _0x56c469 > 25 &&
                (SetVehicleEngineHealth(_0x327c96, _0x311d47 - 50),
                (0, _0x450f48.PlayEntitySound)(
                  _0x327c96,
                  'Landing_Tone',
                  'DLC_PILOT_ENGINE_FAILURE_SOUNDS',
                  1000
                ))
            }
          }
          emit('noshud', this.data.nitroLevel, true)
          this.delay = 1500 - _0x575ffe.flowRate * 100
        })
        _0x189f07.DriverThread.addHook('afterStart', async function () {
          _0x1dbe26.NitroThread.data.driver = this.data
          _0x1dbe26.NitroThread.data.vehicle = _0x3b302f.CurrentVehicle
          _0x1dbe26.NitroThread.data.netId = NetworkGetNetworkIdFromEntity(this.data.vehicle)
          _0x1dbe26.NitroThread.data.exhausts = (0,_0x450f48.GetVehicleExhausts)(this.data.vehicle)
        })
        _0x189f07.DriverThread.addHook('afterStop', async function () {
          await _0x1dbe26.NitroThread.stop()
          _0x1dbe26.NitroThread.data.driver = null
          _0x1dbe26.NitroThread.data.vehicle = null
          _0x1dbe26.NitroThread.data.netId = null
          _0x1dbe26.NitroThread.data.exhausts = null
        })
        _0x1dbe26.NitroThread.addHook('preStart', function () {
          this.data.nitroLevel = (0, _0x439326.GetNitroLevel)(this.data.vehicle)
          if (!this.data.vehicle || this.data.nitroLevel <= 0) {
            return this.abort()
          }
          this.data.mode = _0x575ffe.mode
          this.data.particleId = !this.data.particleId
            ? 1
            : ++this.data.particleId
          SetVehicleBoostActive(this.data.vehicle, true)
          if (this.data.mode === 'Purge') {
            emitNet('fx:purgeL', this.data.particleId, this.data.netId, _0x575ffe.flowRate)
            emitNet('fx:purgeR', this.data.particleId, this.data.netId, _0x575ffe.flowRate)
            emit('fx:purge', this.data.vehicle)
          } else {
            this.data.mode === 'Boost' &&
              (emitNet('fx:nitroSound', this.data.particleId, this.data.netId, this.data.exhausts, GetEntityPitch(_0x3b302f.CurrentVehicle)),
              emit('fx:nitrous', this.data.vehicle, this.data.exhausts, GetEntityPitch(_0x3b302f.CurrentVehicle), 0x575ffe.flowRate))
          }
          emit('noshud', this.data.nitroLevel, true)
          emit('vehicles:nitro:started')
        })
        _0x1dbe26.NitroThread.addHook('preStop', function () {
          this.data.multiplier = null
          const _0x58b650 = (0, _0x439326.GetNitroLevel)(this.data.vehicle),
            _0x371112 = this.data.nitroLevel
          SetVehicleBoostActive(this.data.vehicle, false)
          ;(0,
          _0x1df199.ResetHandlingContextMultipier)(this.data.vehicle, 'fInitialDriveForce', 'nitro')
          ;(0,
          _0x1df199.ApplyHandlingMultipliers)(this.data.vehicle, 'fInitialDriveForce')
          if (this.data.mode === 'Purge') {
            emitNet('fx:stopToggle', this.data.particleId, 'purgeL')
            emitNet('fx:stopToggle', this.data.particleId, 'purgeR')
            emit('fx:stopToggle', this.data.vehicle)
          } else {
            this.data.mode === 'Boost' &&
              (emitNet('fx:stopToggle', this.data.particleId, 'nitro'),
              emitNet('fx:stopToggle', this.data.particleId, 'nitroSound'),
              emit('fx:stopToggle', this.data.vehicle))
          }
          emit('vehicles:nitro:stopped')
          emit('noshud', this.data.nitroLevel, false)
          this.data.nitroLevel = false
          emitNet('pnp:vehicles:nitroUsed', this.data.netId, _0x371112)
        })
        function _0x234f30() {
          if (
            !_0x3b302f.CurrentVehicle ||
            _0x3b302f.CurrentSeat !== -1 ||
            (0, _0x450f48.IsThrottled)('nitro')
          ) {
            return
          }
          _0x1dbe26.NitroThread.start()
        }
        function _0x2d4a0c() {
          if (!_0x1dbe26.NitroThread.isActive) {
            return
          }
          _0x1dbe26.NitroThread.stop()
          ;(0, _0x450f48.Throttle)('nitro', 150)
        }
        function _0xaa65a9() {
          if (_0x3b302f.CurrentSeat !== -1) {
            return
          }
          if (_0x1dbe26.NitroThread.isActive) {
            _0x2d4a0c()
          }
          _0x575ffe.mode = _0x575ffe.mode === 'Boost' ? 'Purge' : 'Boost'
          emit('DoLongHudText', 'Nitro mode: ' + _0x575ffe.mode, 1)
        }
        function _0x694ad0() {
          if (
            _0x3b302f.CurrentSeat !== -1 ||
            !(0, _0x439326.VehicleHasNitro)(_0x3b302f.CurrentVehicle)
          ) {
            return
          }
          _0x575ffe.flowRate + 1 <= 10 ? _0x575ffe.flowRate++ : 10
          emit('DoLongHudText', 'Nitrous flow rate: ' + _0x575ffe.flowRate, 1, 12000)
        }
        function _0x465950() {
          if (
            _0x3b302f.CurrentSeat !== -1 ||
            !(0, _0x439326.VehicleHasNitro)(_0x3b302f.CurrentVehicle)
          ) {
            return
          }
          _0x575ffe.flowRate - 1 >= 1 ? _0x575ffe.flowRate-- : 1
          emit('DoLongHudText', 'Nitrous flow rate: ' + _0x575ffe.flowRate, 1, 12000)
        }
        RegisterCommand('+useNitro', _0x234f30, false)
        RegisterCommand('-useNitro', _0x2d4a0c, false)
        RegisterCommand('+increaseNitroFlow', _0x694ad0, false)
        RegisterCommand('-increaseNitroFlow', () => {}, false)
        RegisterCommand('+decreaseNitroFlow', _0x465950, false)
        RegisterCommand('-decreaseNitroFlow', () => {}, false)
        RegisterCommand('+toggleNitroMode', _0xaa65a9, false)
        RegisterCommand('-toggleNitroMode', () => {}, false)
        _0x30b1e9.g.exports['fa-keybinds'].registerKeyMapping('', 'Vehicle', 'Toggle Nos / Purge Mode', '+toggleNitroMode', '-toggleNitroMode')
        _0x30b1e9.g.exports['fa-keybinds'].registerKeyMapping('', 'Vehicle', 'Nos Flow Increase', '+increaseNitroFlow', '-increaseNitroFlow')
        _0x30b1e9.g.exports['fa-keybinds'].registerKeyMapping('', 'Vehicle', 'Nos Flow Decrease', '+decreaseNitroFlow', '-decreaseNitroFlow')
        _0x30b1e9.g.exports['fa-keybinds'].registerKeyMapping('', 'Vehicle', 'Activate Nos', '+useNitro', '-useNitro', 'LSHIFT')
      },
      235: (_0x3ee4f9, _0x478133, _0x36181e) => {
        Object.defineProperty(_0x478133, '__esModule', { value: true })
        _0x478133.InitPassenger = _0x478133.PassengerThread = void 0
        const _0x43de53 = _0x36181e(769),
          _0x23c9a1 = _0x36181e(450)
        _0x478133.PassengerThread = new _0x43de53.Hooks(async function () {},
        1000)
        async function _0x2fb0e9() {
          _0x23c9a1.CurrentVehicle &&
            _0x23c9a1.CurrentSeat !== -1 &&
            (await _0x478133.PassengerThread.start())
        }
        _0x478133.InitPassenger = _0x2fb0e9
      },
      413: (_0x507936, _0x5e9d5d, _0x19469a) => {
        Object.defineProperty(_0x5e9d5d, '__esModule', { value: true })
        _0x5e9d5d.OpenGarageList =
          _0x5e9d5d.GetGarageVehicleList =
          _0x5e9d5d.InitUI =
            void 0
        const _0x480a0b = _0x19469a(615),
          _0x2173f4 = _0x19469a(908),
          _0x354453 = _0x19469a(17)
        async function _0x53250f() {}
        _0x5e9d5d.InitUI = _0x53250f
        let _0x41310d = false
        RegisterUICallback('fa-ui:applicationClosed', (data, cb) => {
            data.name === 'contextmenu' && _0x41310d && ((_0x41310d = false),
              (0, _0x2173f4.ResetParkingSpot)(),
              DeleteEntity(_0x2173f4.previewCar))
          }
        )
        RegisterUICallback('pnp:vehicles:vehiclePreview', (data, cb) => {
            const _0xfb56b3 = data.key
            _0xfb56b3.state === 'stored' &&
              (0, _0x2173f4.PreviewCar)(_0xfb56b3.vin, _0xfb56b3.garage, _0xfb56b3?.data)
            cb({
              data: {},
              meta: {
                ok: true,
                message: '',
              },
            })
          }
        )
        RegisterUICallback('pnp:vehicles:spawnVehicle', async (data, cb) => {
            const veh = data.key
            veh.state === 'stored' && _0x2173f4.currentParkingSpot
              ? (0, _0x2173f4.SpawnGarageVehicle)(veh.vin, veh.garage, veh?.raid)
              : emit('DoLongHudText', 'Vehicle unavailable', 2)
            cb({
              data: {},
              meta: {
                ok: true,
                message: '',
              },
            })
          }
        )
        RegisterUICallback('vehicle:refuel:handler', async (data, cb) => {
            const {
              pEntity: _0xc67db4,
              pCost: _0x270d92,
              isJerryCan: _0x305951,
              isHeli: _0x2995cb,
            } = data.key
            if (_0xc67db4) {
              const _0x3202dd = await RPC.execute('GetCurrentCash')
              if (Math.floor(_0x270d92) === 0) {
                return (
                  cb({
                    data: {},
                    meta: {
                      ok: true,
                      message: '',
                    },
                  }),
                  emit('DoLongHudText', "You're already topped up.")
                )
              }
              _0x3202dd < _0x270d92
                ? emit('DoLongHudText', "You can't afford it, you're missing $" + (_0x270d92 - _0x3202dd), 1, 12000)
                : _0x305951
                ? (0, _0x354453.RefuelJerryCan)(_0xc67db4)
                : (0, _0x354453.RefuelVehicle)(_0xc67db4, _0x270d92, _0x2995cb, false)
            }
            // exports["fa-vehicles"].SetVehicleFuel(_0xc67db4)
            cb({
              data: {},
              meta: {
                ok: true,
                message: '',
              },
            })
          }
        )
        RegisterUICallback('fa-vehicles:fetchParkingLogs', async (data, cb) => {
            cb({
              data: {},
              meta: {
                ok: true,
                message: '',
              },
            })
            const _0x23badb = data.key
            DoesEntityExist(_0x2173f4.previewCar) &&
              ((0, _0x2173f4.ResetParkingSpot)(),
              DeleteEntity(_0x2173f4.previewCar))
            const _0x5d28a7 = await RPC.execute('pnp:vehicles:fetchParkingLogs', _0x23badb.vin, _0x23badb.garage),
              _0x398ebf = _0x5d28a7.map((_0x1cbb0a) => {
                return {
                  title:
                    ' State ID: ' +
                    _0x1cbb0a.cid +
                    ' | Action: ' +
                    _0x1cbb0a.action +
                    ' | Date: ' +
                    new Date(_0x1cbb0a.timestamp).toLocaleString('en-US'),
                  description:
                    'Engine: ' +
                    _0x1cbb0a.data.engine +
                    ' | Body: ' +
                    _0x1cbb0a.data.body +
                    ' | Fuel: ' +
                    _0x1cbb0a.data.fuel,
                }
              })
            _0x19469a.g.exports['fa-ui'].showContextMenu(_0x398ebf)
          }
        )
        function _0x1d4924(_0x524cbf) {
          return (
            'Engine: ' +
            Math.floor(
              ((_0x524cbf === null || _0x524cbf === void 0
                ? void 0
                : _0x524cbf.engine) /
                1000) *
                100
            ) +
            '% | Body: ' +
            Math.floor(
              ((_0x524cbf === null || _0x524cbf === void 0
                ? void 0
                : _0x524cbf.body) /
                1000) *
                100
            ) +
            '%'
          )
        }
        function _0x3408bb(_0x3b433e, _0x52732f, _0x10875f, _0x44f00d, _0x4ca168) {
          const _0x505340 = []
          return _0x3b433e.reduce((_0x47471d, data) => {
            const _0x20a838 = {
                title:'' + (data.name ? data.name : GetLabelText( GetDisplayNameFromVehicleModel(data.model))),
                description: 'Plate: ' +  data.plate + ' | ' + (0, _0x480a0b.Capitalize)(data.state),
                key: {
                state: data.state,
                garage: data.garage,
                vin: data.vin,
              },
              extraAction: 'pnp:vehicles:vehiclePreview',
              children: [
                {
                  title: 'Take Out Vehicle',
                  description: '',
                  action: 'pnp:vehicles:spawnVehicle',
                  disabled: _0x44f00d
                    ? data.state !== 'stored' &&
                      data.state !== 'locked'
                    : data.state !== 'stored',
                  key: {
                    state: data.state,
                    garage: data.garage,
                    vin: data.vin,
                    raid: _0x44f00d,
                  },
                },
                {
                  title: 'Vehicle Status',
                  description:
                    (0, _0x480a0b.Capitalize)(data.state) +
                    ' | ' +
                    _0x1d4924(
                      data.damage ? JSON.parse(data.damage || []) : []
                    ),
                },
              ],
            }
            return (
              _0x4ca168 &&
                (_0x20a838.children.push({
                  title: 'Set as Display Vehicle',
                  description: '',
                  action: 'fa-vehicles:setDisplayVehicle',
                  disabled: data.state !== 'stored',
                  key: {
                    vin: data.vin,
                    garage: data.garage,
                    state: data.state,
                  },
                }),
                _0x20a838.children.push({
                  title: 'Remove Display Vehicle',
                  description: '',
                  action: 'fa-vehicles:setDisplayVehicle',
                  disabled: data.state !== 'showcase',
                  key: {
                    vin: data.vin,
                    garage: data.garage,
                    state: data.state,
                    remove: true,
                  },
                })),
              _0x44f00d &&
                _0x20a838.children.push({
                  title: 'Toggle Vehicle Lockdown',
                  description: '',
                  action: 'fa-vehicles:toggleVehicleLockdown',
                  disabled:
                    data.state !== 'stored' &&
                    data.state !== 'locked',
                  key: {
                    vin: data.vin,
                    garage: data.garage,
                    state: data.state,
                  },
                }),
              _0x505340 &&
                _0x505340[data.model] &&
                ['pd_shared', 'pd_shared_bike'].includes(data.garage) &&
                _0x20a838.children.push({
                  title: 'Retrieve Vehicle',
                  description: '',
                  action: 'fa-vehicles:retrieveVehicle',
                  disabled: data.state === 'stored',
                  key: {
                    vin: data.vin,
                    garage: data.garage,
                  },
                }),
              (_0x10875f || true) &&
                _0x20a838.children.push({
                  title: 'Vehicle Parking Log',
                  description: '',
                  action: 'fa-vehicles:fetchParkingLogs',
                  key: {
                    vin: data.vin,
                    garage: data.garage,
                    state: data.state,
                  },
                }),
              _0x47471d.push(_0x20a838),
              _0x47471d
            )
          }, [])
        }
        function _0x193efc(_0x2b1949, _0x4f852d, _0x133f7d, _0x5c7d28, _0x18fd64) {
          const _0x19059c = {
            npolvic: 'Crown Vics',
            npolexp: 'Explorers',
            npolchar: 'Chargers',
            npolstang: 'Mustangs',
            npolvette: 'Corvettes',
            npolchal: 'Challengers',
            npolmm: 'Motorcycles',
            emsnspeedo: 'Speedos',
            emshoe: 'Tahoes',
          }
          return Object.values(_0x2b1949).reduce((_0x568e8b, _0x278e59) => {
            const _0x3a6938 = _0x3408bb(
                _0x278e59.sort((_0x533d6d, _0xd28799) =>
                  _0x533d6d.name.localeCompare(
                    _0xd28799.name ? _0xd28799.name : _0xd28799.model
                  )
                ),
                _0x4f852d,
                _0x133f7d,
                _0x5c7d28,
                _0x18fd64
              ),
              _0x1cd071 = ['LSPD', 'BCSO', 'SASPR', 'SASP', 'UM']
            if (_0x3a6938.length === 0) {
              return _0x568e8b
            }
            return (
              _0x568e8b.push({
                title:
                  '' +
                  (_0x19059c[_0x278e59[0].model] || _0x278e59[0].name
                    ? _0x278e59[0].name
                    : _0x278e59[0].model),
                description:
                  _0x278e59.length +
                  ' ' +
                  (_0x278e59.length === 1 ? 'Vehicle' : 'Vehicles'),
                children: _0x3a6938,
              }),
              _0x568e8b
            )
          }, [])
        }
        function _0x5afae1(
          _0x206f4a,
          _0x3cd9e4,
          _0x596e92,
          _0x3b59dc,
          _0x6def53
        ) {
          return _0x206f4a.reduce((_0x5906cc, _0x5dfffe) => {
            const _0x513a93 = _0x3408bb(
              _0x3cd9e4,
              _0x5dfffe,
              _0x596e92,
              _0x3b59dc,
              _0x6def53
            )
            return (
              _0x513a93 &&
                _0x5906cc.push({
                  title: 'Vehicle List (' + (0, _0x480a0b.Capitalize)(_0x5dfffe) + ')',
                  description: 'Stored Vehicles: ' + _0x513a93.length,
                  key: '',
                  action: '',
                  children: _0x513a93,
                }),
              _0x5906cc
            )
          }, [])
        }
        function _0x2e7182(_0x270feb, _0x2845b0, _0x406691, _0x1831c1, _0x10e529) {
          let _0x19a812 = undefined
          const _0x3d36db = (_0x3b68ee, _0x226e96, _0x57abeb = false) => {
            let _0xfd3d69 = undefined
            const _0x1a7204 = _0x3b68ee.reduce((_0x2db437, _0x534065) => {
              return (
                (_0x2db437[_0x534065.model] =
                  _0x2db437[_0x534065.model] || []).push(_0x534065),
                _0x2db437
              )
            }, {})
            if (_0x226e96.length > 1) {
              _0xfd3d69 = _0x5afae1(
                _0x226e96,
                _0x3b68ee,
                _0x57abeb,
                _0x1831c1,
                _0x10e529
              )
            } else {
              if (
                Object.values(_0x1a7204).some(
                  (_0x99e1e5) => _0x99e1e5.length > 3
                )
              ) {
                const [_0x11e6aa] = _0x226e96
                _0xfd3d69 = _0x193efc(
                  _0x1a7204,
                  _0x11e6aa,
                  _0x57abeb,
                  _0x1831c1,
                  _0x10e529
                )
              } else {
                const [_0x77434] = _0x226e96
                _0xfd3d69 = _0x3408bb(
                  _0x3b68ee,
                  _0x77434,
                  _0x57abeb,
                  _0x1831c1,
                  _0x10e529
                )
              }
            }
            return _0xfd3d69
          }
          if (_0x406691) {
            const _0x307e59 = _0x19469a.g.exports.isPed.isPed('cid'),
              _0x1e79e7 = _0x270feb.filter(
                (_0x23dbb6) => _0x23dbb6.cid === _0x307e59
              ),
              _0x176c44 = _0x270feb.filter(
                (_0x21bfb2) => _0x21bfb2.cid !== _0x307e59
              )
            _0x19a812 = [
              {
                title: 'Personal Vehicles',
                description: 'List of owned vehicles.',
                key: {},
                children: _0x3d36db(_0x1e79e7, _0x2845b0, true),
              },
              {
                title: 'Shared Vehicles',
                description: 'List of shared vehicles.',
                key: {},
                children: _0x3d36db(_0x176c44, _0x2845b0, true),
              },
            ]
          } else {
            const _0x115b47 = _0x19469a.g.exports.isPed.isPed('cid'),
              _0x5ebd56 = _0x270feb.filter(
                (_0x31dfdc) => _0x31dfdc.cid === _0x115b47
              )
            _0x19a812 = _0x3d36db(_0x5ebd56, _0x2845b0)
          }
          return _0x19a812
        }
        _0x5e9d5d.GetGarageVehicleList = _0x2e7182
        async function _0x58c2e8(_0x3f6151) {
          const _0x53cd0b = (0, _0x2173f4.GetGarageById)(_0x3f6151)
          if (!_0x53cd0b) {
            return
          }
          const _0x3e3bc7 = await (0, _0x2173f4.GetGarageVehicleCache)(
            _0x3f6151
          )
          if (!_0x3e3bc7) {
            return
          }
          const _0x267c55 = _0x2173f4.currentParkingSpot.type
              ? [_0x2173f4.currentParkingSpot.type]
              : _0x53cd0b.vehicle_types,
            _0x243823 = _0x2173f4.currentParkingSpot?.display === true,
            _0x2cbd42 = _0x2e7182(_0x3e3bc7, _0x267c55, _0x53cd0b.shared, false, _0x243823)
          if (_0x2cbd42.length === 0) {
            return emit('DoLongHudText', "You don't have any vehicles parked here.", 2)
          }
          _0x41310d = true
          _0x19469a.g.exports['fa-ui'].showContextMenu([..._0x2cbd42], 'right')
        }
        _0x5e9d5d.OpenGarageList = _0x58c2e8
      },
      450: (_0xcf1860, _0x8810cd, _0x3c7fc0) => {
        Object.defineProperty(_0x8810cd, '__esModule', { value: true })
        _0x8810cd.SetVehicleMetadata =
          _0x8810cd.GenerateVehicleInformation =
          _0x8810cd.VerifyEngineState =
          _0x8810cd.TurnOffEngine =
          _0x8810cd.TurnOnEngine =
          _0x8810cd.UpdateCurrentVehicle =
          _0x8810cd.GetVehicleMetadata =
          _0x8810cd.InitVehicle =
          _0x8810cd.curVehicle =
          _0x8810cd.InVehicle =
          _0x8810cd.PreviousSeat =
          _0x8810cd.CurrentSeat =
          _0x8810cd.PreviousVehicle =
          _0x8810cd.CurrentVehicle =
            void 0
        const _0x36ee34 = _0x3c7fc0(615),
          _0x1df7b4 = _0x3c7fc0(710)
        async function _0x1a876f() {
          const _0x5cccb2 = PlayerPedId()
          _0x8810cd.CurrentVehicle = GetVehiclePedIsIn(_0x5cccb2, false)
          _0x8810cd.CurrentSeat = _0x8810cd.CurrentVehicle
            ? (0, _0x36ee34.GetPedVehicleSeat)(
                _0x5cccb2,
                _0x8810cd.CurrentVehicle
              )
            : null
        }
        _0x8810cd.InitVehicle = _0x1a876f
        function _0x59c94d(_0x4b8a92, _0x5a6d76) {
          const _0x513d91 = Entity(_0x4b8a92)
          if (_0x513d91) {
            const _0x199246 = _0x513d91.state.data
            if (_0x199246) {
              return _0x5a6d76 ? _0x199246[_0x5a6d76] : _0x199246
            }
          } else {
            return null
          }
        }
        _0x8810cd.GetVehicleMetadata = _0x59c94d
        function _0x4426e6() {
          const _0x5c66ac = PlayerPedId()
          _0x8810cd.PreviousVehicle = _0x8810cd.CurrentVehicle
          _0x8810cd.CurrentVehicle = GetVehiclePedIsIn(_0x5c66ac, false)
          _0x8810cd.CurrentSeat = _0x8810cd.CurrentVehicle
            ? (0, _0x36ee34.GetPedVehicleSeat)(_0x5c66ac,_0x8810cd.CurrentVehicle)
            : null
          _0x8810cd.InVehicle = !!_0x8810cd.CurrentVehicle
        }
        _0x8810cd.UpdateCurrentVehicle = _0x4426e6
        function _0x133fb3(_0x5f5b8b, _0x2d9fdc = false) {
          if (GetPedInVehicleSeat(_0x5f5b8b, -1) !== PlayerPedId()) {
            return false
          }
          const _0x421b9f = GetVehicleEngineHealth(_0x5f5b8b),
            _0x5ab47d = GetVehicleBodyHealth(_0x5f5b8b)
          if (_0x421b9f <= 150 || _0x5ab47d <= 150) {
            return emit('DoLongHudText', 'Something seems to be damaged.', 2)
          }
          if (_0x5f5b8b !== _0x8810cd.curVehicle) {
            SetVehicleUndriveable(_0x5f5b8b, false)
          } else {
            return false
          }
          return (
            SetVehicleEngineOn(_0x5f5b8b, true, _0x2d9fdc, true),
            IsVehicleEngineOn(_0x5f5b8b)
          )
        }
        _0x8810cd.TurnOnEngine = _0x133fb3
        function _0x507ce8(_0x1e944b, _0x112d85 = false) {
          if (_0x8810cd.CurrentSeat !== -1) {
            return false
          }
          return (
            SetVehicleUndriveable(_0x1e944b, true),
            SetVehicleEngineOn(_0x1e944b, false, _0x112d85, true),
            !IsVehicleEngineOn(_0x1e944b)
          )
        }
        _0x8810cd.TurnOffEngine = _0x507ce8
        function _0x102bbb(_0x77bf84) {
          const _0x218bc2 = (0, _0x1df7b4.HasVehicleKey)(_0x77bf84)
          return (
            !_0x218bc2 &&
              (SetVehicleNeedsToBeHotwired(_0x77bf84, false),
              SetVehicleUndriveable(_0x77bf84, true),
              SetVehicleEngineOn(_0x77bf84, false, true, true)),
            _0x218bc2
          )
        }
        _0x8810cd.VerifyEngineState = _0x102bbb
        async function _0x50c23a(_0x386f34) {
          if ((0, _0x1df7b4.GetVehicleIdentifier)(_0x386f34)) {
            return
          }
          const _0x68347d = NetworkGetNetworkIdFromEntity(_0x386f34),
          _0x458e84 = GetEntityModel(_0x386f34),
          _0x2e6e2e = await RPC.execute('pnp:vehicles:generateVehicleInformation', _0x68347d, _0x458e84)
          return _0x2e6e2e
        }
        _0x8810cd.GenerateVehicleInformation = _0x50c23a
        RegisterCommand('+engineOn', () => {
            if (IsPauseMenuActive()) {
              return
            }
            const _0x6d1670 = GetVehiclePedIsIn(PlayerPedId(), false)
            _0x6d1670 && DoesEntityExist(_0x6d1670) && _0x133fb3(_0x6d1670)
          },
          false
        )
        RegisterCommand('-engineOn', () => {}, false)
        RegisterCommand('+engineOff', () => {
            if (IsPauseMenuActive()) {
              return
            }
            const _0x4b48dc = GetVehiclePedIsIn(PlayerPedId(), false)
            _0x4b48dc && DoesEntityExist(_0x4b48dc) && _0x507ce8(_0x4b48dc)
          },
          false
        )
        RegisterCommand('-engineOff', () => {}, false)
        _0x3c7fc0.g.exports['fa-keybinds'].registerKeyMapping(
          '',
          'Vehicle',
          'Engine On',
          '+engineOn',
          '-engineOn',
          'IOM_WHEEL_UP',
          false,
          'MOUSE_WHEEL'
        )
        _0x3c7fc0.g.exports['fa-keybinds'].registerKeyMapping(
          '',
          'Vehicle',
          'Engine Off',
          '+engineOff',
          '-engineOff',
          'IOM_WHEEL_DOWN',
          false,
          'MOUSE_WHEEL'
        )
        _0x3c7fc0.g.exports('GetVehicleMetadata', _0x59c94d)
        function _0x2dd6a8(_0x2c9752, _0x4bf9a1, _0x17d82c) {
          const _0x4bf5ad = Number(_0x2c9752)
          switch (_0x4bf9a1) {
            case 'fakePlate':
              DecorExistOn(_0x4bf5ad, 'fakePlate')
                ? DecorSetBool(_0x4bf5ad, 'fakePlate', _0x17d82c)
                : false
              break
            case 'harness':
              DecorExistOn(_0x4bf5ad, 'harness')
                ? DecorSetInt(_0x4bf5ad, 'harness', _0x17d82c)
                : false
              break
            case 'hasCarBomb':
              DecorExistOn(_0x4bf5ad, 'hasCarBomb')
                ? DecorSetBool(_0x4bf5ad, 'hasCarBomb', _0x17d82c)
                : false
              break
            case 'minSpeed':
              DecorExistOn(_0x4bf5ad, 'minSpeed')
                ? DecorSetInt(_0x4bf5ad, 'minSpeed', _0x17d82c)
                : false
              break
            case 'ticksBeforeExplode':
              DecorExistOn(_0x4bf5ad, 'ticksBeforeExplode')
                ? DecorSetInt(_0x4bf5ad, 'ticksBeforeExplode', _0x17d82c)
                : false
              break
            case 'ticksForRemoval':
              DecorExistOn(_0x4bf5ad, 'ticksForRemoval')
                ? DecorSetInt(_0x4bf5ad, 'ticksForRemoval', _0x17d82c)
                : false
              break
          }
        }
        _0x8810cd.SetVehicleMetadata = _0x2dd6a8
        _0x3c7fc0.g.exports('SetVehicleMetadata', _0x2dd6a8)
      },
      824: (_0x12c343, _0x28ff60, _0x2d1604) => {
        Object.defineProperty(_0x28ff60, '__esModule', { value: true })
        _0x28ff60.PlayAnimation = void 0
        const _0x10a166 = _0x2d1604(997),
          _0x38af92 = _0x2d1604(433),
          _0x496762 = _0x2d1604(926)
        async function _0x13a4fb(_0x2bf6ff, _0x145c9f, _0x436a0f) {
          const _0x498562 =
            typeof _0x436a0f === 'string'
              ? (0, _0x496762.GetAnimationSettings)(_0x436a0f)
              : _0x436a0f
          if (!_0x498562) {
            return
          }
          const _0x5d7002 = new _0x10a166.AnimationTask(
            _0x2bf6ff,
            _0x498562.type,
            _0x498562.text,
            _0x498562.duration,
            _0x498562.dictionary,
            _0x498562.animation,
            _0x498562.flag
          )
          let _0x2ebb3b = _0x498562.callback
          if (!_0x2ebb3b && _0x498562.data) {
            const _0x295968 = _0x498562.data
            _0x2ebb3b = (_0x16c7cf, _0x5db353) => {
              const [_0x5b2c48, _0x5e9e19, _0x4fd800] = (0,
              _0x38af92.GetClosestBone)(_0x5db353, _0x295968.bones)
              _0x4fd800 && _0x4fd800 > _0x295968.distance && _0x16c7cf.abort()
            }
          }
          return await _0x5d7002.start((_0x168f68) => {
            if (!_0x2ebb3b) {
              return
            }
            const _0xac9e18 = setInterval(() => {
              !_0x5d7002.active && (clearInterval(_0xac9e18), _0x5d7002.abort())
              _0x2ebb3b(_0x168f68, _0x145c9f)
            }, 1000)
          })
        }
        _0x28ff60.PlayAnimation = _0x13a4fb
      },
      996: (_0x23eb9e, _0x1d02de) => {
        Object.defineProperty(_0x1d02de, '__esModule', { value: true })
        _0x1d02de.ToggleBlip =
          _0x1d02de.RemoveAllBlips =
          _0x1d02de.RemoveBlip =
          _0x1d02de.AddBlip =
            void 0
        const _0x5e01bd = new Map()
        function _0x382404(_0x4d2a4c, _0xf18f2b, _0x4bc88c, _0x45517e) {
          if (_0x5e01bd.has(_0x4d2a4c)) {
            _0x3eae5d(_0x4d2a4c)
          }
          const _0x5f3573 = AddBlipForCoord(
            _0xf18f2b.x,
            _0xf18f2b.y,
            _0xf18f2b.z
          )
          if (_0x45517e) {
            if (typeof _0x45517e.sprite !== 'undefined') {
              SetBlipSprite(_0x5f3573, _0x45517e.sprite)
            }
            if (typeof _0x45517e.color !== 'undefined') {
              SetBlipColour(_0x5f3573, _0x45517e.color)
            }
            if (typeof _0x45517e.scale !== 'undefined') {
              SetBlipScale(_0x5f3573, _0x45517e.scale)
            }
            if (typeof _0x45517e.category !== 'undefined') {
              SetBlipCategory(_0x5f3573, _0x45517e.category)
            }
            if (typeof _0x45517e.short !== 'undefined') {
              SetBlipAsShortRange(_0x5f3573, _0x45517e.short)
            }
          }
          return (
            _0x4bc88c &&
              (BeginTextCommandSetBlipName('STRING'),
              AddTextComponentString(_0x4bc88c),
              EndTextCommandSetBlipName(_0x5f3573)),
            _0x5e01bd.set(_0x4d2a4c, _0x5f3573),
            _0x5f3573
          )
        }
        _0x1d02de.AddBlip = _0x382404
        function _0x3eae5d(_0x2f3b4b) {
          const _0x256418 = _0x5e01bd.get(_0x2f3b4b)
          return _0x256418 && _0x3eae5d(_0x256418), _0x5e01bd.delete(_0x2f3b4b)
        }
        _0x1d02de.RemoveBlip = _0x3eae5d
        function _0x3354fd() {
          _0x5e01bd.forEach((_0x63494b) => _0x3eae5d(_0x63494b))
        }
        _0x1d02de.RemoveAllBlips = _0x3354fd
        function _0x195335(_0xd4984, _0x4328d4) {
          const _0x2953e0 = _0x5e01bd.get(_0xd4984)
          if (!_0x2953e0) {
            return
          }
          _0x4328d4
            ? (SetBlipAlpha(_0x2953e0, 0),
              SetBlipHiddenOnLegend(_0x2953e0, true))
            : (SetBlipAlpha(_0x2953e0, 255),
              SetBlipHiddenOnLegend(_0x2953e0, false))
        }
        _0x1d02de.ToggleBlip = _0x195335
      },
      895: (_0x4fa86f, _0x5aa20a, _0x3a7f4e) => {
        Object.defineProperty(_0x5aa20a, '__esModule', { value: true })
        _0x5aa20a.IsConfigReady =
          _0x5aa20a.GetModuleConfig =
          _0x5aa20a.InitConfig =
            void 0
        let _0x1b0e39 = _0x3a7f4e.g.exports['fa-config'].GetModuleConfig('main')
        const _0x5aa110 = new Map(),
          _0x14b6ad = GetCurrentResourceName()
        async function _0x515f8c() {}
        _0x5aa20a.InitConfig = _0x515f8c
        on('fa-config:configLoaded', (_0x31742c, _0x188cc1) => {
          if (_0x31742c === 'main') {
            _0x1b0e39 = _0x188cc1
          } else {
            _0x5aa110.has(_0x31742c) && _0x5aa110.set(_0x31742c, _0x188cc1)
          }
        })
        function _0x5c1576(_0x4c27c6, _0x52a0a9) {
          if (!_0x5aa110.has(_0x4c27c6)) {
            const _0xfc67b0 =
              _0x3a7f4e.g.exports['fa-config'].GetModuleConfig(_0x4c27c6)
            if (_0xfc67b0 === undefined) {
              return
            }
            _0x5aa110.set(_0x4c27c6, _0xfc67b0)
          }
          const _0x4fa421 = _0x5aa110.get(_0x4c27c6)
          return _0x52a0a9
            ? _0x4fa421 === null || _0x4fa421 === void 0
              ? void 0
              : _0x4fa421[_0x52a0a9]
            : _0x4fa421
        }
        _0x5aa20a.GetModuleConfig = _0x5c1576
        const _0x321f21 = () => {
          return new Promise((_0x2a4051) => {
            let _0x1ec128 = 0
            const _0x18f6bd = setInterval(() => {
              if (_0x3a7f4e.g.exports['fa-config'].IsConfigReady()) {
                clearInterval(_0x18f6bd)
                _0x2a4051(true)
              } else {
                _0x1ec128++
                _0x1ec128 > 10 && (clearInterval(_0x18f6bd), _0x2a4051(false))
              }
            }, 3000)
          })
        }
        _0x5aa20a.IsConfigReady = _0x321f21
      },
      849: (_0x18f78e, _0x102990, _0x25284e) => {
        Object.defineProperty(_0x102990, '__esModule', { value: true })
        _0x102990.PolyZone = void 0
        class _0xfeed24 {
          static ['addBoxZone'](
            _0x3ffe1f,
            _0x10bb27,
            _0x187eab,
            _0x215e89,
            _0x42282c
          ) {
            return _0x25284e.g.exports['fa-polyzone'].AddBoxZone(
              _0x3ffe1f,
              _0x10bb27,
              _0x187eab,
              _0x215e89,
              _0x42282c
            )
          }
          static ['addCircleZone'](_0x59802f, _0x3cd7b6, _0x3fb7ee, _0x4746d0) {
            return _0x25284e.g.exports['fa-polyzone'].AddCircleZone(
              _0x59802f,
              _0x3cd7b6,
              _0x3fb7ee,
              _0x4746d0
            )
          }
        }
        _0x102990.PolyZone = _0xfeed24
      },
      615: (_0x49ffb2, _0x29a31c, _0x2a9cc1) => {
        Object.defineProperty(_0x29a31c, '__esModule', { value: true })
        _0x29a31c.OpenInputMenu =
          _0x29a31c.IsThrottled =
          _0x29a31c.Throttle =
          _0x29a31c.GetVehicleExhausts =
          _0x29a31c.loadAndRequestModel =
          _0x29a31c.requestAnimDict =
          _0x29a31c.taskBarSkill =
          _0x29a31c.taskBar =
          _0x29a31c.Capitalize =
          _0x29a31c.GetRandom =
          _0x29a31c.loadAnimDict =
          _0x29a31c.Delay =
          _0x29a31c.GetPedVehicleSeat =
          _0x29a31c.SyncedExecution =
          _0x29a31c.PlayEntitySound =
          _0x29a31c.GetClosestPlayer =
            void 0
        const _0x42fa4a = new Set()
        function _0x1cf96c() {
          const _0x5e966f = GetActivePlayers(),
            _0x3f99da = PlayerId(),
            [_0x26e143, _0x1815f7, _0x5a3933] = GetEntityCoords(
              PlayerPedId(),
              false
            )
          let _0x361776 = '',
            _0x2c5809 = '',
            _0x453668 = ''
          return (
            _0x5e966f.forEach((_0x95fd51) => {
              if (_0x95fd51 !== _0x3f99da) {
                const _0x8983c5 = GetPlayerPed(_0x95fd51),
                  [_0x5c2931, _0x56fd19, _0x65fa6f] = GetEntityCoords(
                    _0x8983c5,
                    false
                  ),
                  _0x3e5323 = GetDistanceBetweenCoords(
                    _0x26e143,
                    _0x1815f7,
                    _0x5a3933,
                    _0x5c2931,
                    _0x56fd19,
                    _0x65fa6f,
                    true
                  )
                ;(!_0x2c5809 || _0x3e5323 < _0x361776) &&
                  ((_0x2c5809 = _0x95fd51),
                  (_0x453668 = _0x8983c5),
                  (_0x361776 = _0x3e5323))
              }
            }),
            [_0x2c5809, _0x361776, _0x453668]
          )
        }
        _0x29a31c.GetClosestPlayer = _0x1cf96c
        async function _0x253e45(
          _0x4696a0,
          _0x207aa7,
          _0x7e60be,
          _0x23d3bb = 1000
        ) {
          const _0x348c49 = GetSoundId()
          PlaySoundFromEntity(
            _0x348c49,
            _0x207aa7,
            _0x4696a0,
            _0x7e60be,
            false,
            0
          )
          await (0, _0x29a31c.Delay)(_0x23d3bb)
          StopSound(_0x348c49)
          ReleaseSoundId(_0x348c49)
        }
        _0x29a31c.PlayEntitySound = _0x253e45
        function _0x196b21() {}
        _0x29a31c.SyncedExecution = _0x196b21
        function _0x1d10b8(_0x4752e4, _0x216b28) {
          const _0x69b991 = GetVehicleModelNumberOfSeats(
            GetEntityModel(_0x216b28)
          )
          for (let _0x188f78 = -1; _0x188f78 < _0x69b991 - 1; _0x188f78 += 1) {
            const _0xbfe1c2 = GetPedInVehicleSeat(_0x216b28, _0x188f78)
            if (_0xbfe1c2 && _0xbfe1c2 === _0x4752e4) {
              return _0x188f78
            }
          }
        }
        _0x29a31c.GetPedVehicleSeat = _0x1d10b8
        const _0x2443a8 = (_0x5bcacb) =>
          new Promise((_0x54dc03) => setTimeout(_0x54dc03, _0x5bcacb))
        _0x29a31c.Delay = _0x2443a8
        async function _0x585d43(_0x63fe67) {
          while (!HasAnimDictLoaded(_0x63fe67)) {
            RequestAnimDict(_0x63fe67)
            await (0, _0x29a31c.Delay)(5)
          }
        }
        _0x29a31c.loadAnimDict = _0x585d43
        function _0xcef5a5(_0x4e0b2f, _0x5086d9) {
          const _0xc8f04e = _0x5086d9
            ? Math.random() * (_0x5086d9 - _0x4e0b2f) + _0x4e0b2f
            : Math.random() * _0x4e0b2f
          return Number.isInteger(_0x4e0b2f) ? Math.round(_0xc8f04e) : _0xc8f04e
        }
        _0x29a31c.GetRandom = _0xcef5a5
        function _0x143a89(_0x44b749) {
          return _0x44b749.charAt(0).toUpperCase() + _0x44b749.slice(1)
        }
        _0x29a31c.Capitalize = _0x143a89
        function _0x1eea5b(_0x52ff4c, _0x4147aa, _0x10f704 = false) {
          return new Promise((_0x3f81c6) => {
            if (_0x4147aa) {
              _0x2a9cc1.g.exports['fa-taskbar'].taskBar(
                _0x52ff4c,
                _0x4147aa,
                _0x10f704,
                true,
                null,
                false,
                _0x3f81c6
              )
            } else {
              setTimeout(() => _0x3f81c6(100), _0x52ff4c)
            }
          })
        }
        _0x29a31c.taskBar = _0x1eea5b
        function _0x21d165(_0x2f7de5, _0x2960c0) {
          return new Promise((_0x2f6d58) => {
            _0x2a9cc1.g.exports['fa-ui'].taskBarSkill(
              _0x2f7de5,
              _0x2960c0,
              _0x2f6d58
            )
          })
        }
        _0x29a31c.taskBarSkill = _0x21d165
        async function _0x4453de(_0x1e540a) {
          if (!HasAnimDictLoaded(_0x1e540a)) {
            RequestAnimDict(_0x1e540a)
            let _0x4504d9 = false
            setTimeout(() => (_0x4504d9 = true), 60000)
            while (!HasAnimDictLoaded(_0x1e540a) && !_0x4504d9) {
              await (0, _0x29a31c.Delay)(10)
            }
          }
        }
        _0x29a31c.requestAnimDict = _0x4453de
        async function _0x25614b(_0x346cc4) {
          const _0x379804 =
            typeof _0x346cc4 === 'number' ? _0x346cc4 : GetHashKey(_0x346cc4)
          if (!HasModelLoaded(_0x379804) && IsModelInCdimage(_0x379804)) {
            RequestModel(_0x379804)
            let _0x1223b1 = false
            setTimeout(() => (_0x1223b1 = true), 60000)
            while (!HasModelLoaded(_0x379804) && !_0x1223b1) {
              await (0, _0x29a31c.Delay)(10)
            }
          }
        }
        _0x29a31c.loadAndRequestModel = _0x25614b
        const _0x3fc028 = ['exhaust']
        function _0x14751e(_0x2ad424) {
          const _0x3b1e84 = []
          if (_0x3fc028.length === 1) {
            for (let _0x350ba6 = 2; _0x350ba6 < 17; _0x350ba6 += 1) {
              _0x3fc028.push('exhaust_' + _0x350ba6)
            }
            return (
              _0x3fc028.forEach((_0x34927d) => {
                if (GetEntityBoneIndexByName(_0x2ad424, _0x34927d) !== -1) {
                  _0x3b1e84.push(_0x34927d)
                }
              }),
              _0x3b1e84
            )
          }
        }
        _0x29a31c.GetVehicleExhausts = _0x14751e
        function _0x5b9faa(_0x2d25bf, _0x3860c = 500) {
          if (!_0x42fa4a.has(_0x2d25bf)) {
            return (
              _0x42fa4a.add(_0x2d25bf),
              setTimeout(() => _0x42fa4a.delete(_0x2d25bf), _0x3860c),
              false
            )
          }
          return true
        }
        _0x29a31c.Throttle = _0x5b9faa
        function _0xad3bbd(_0x1c0557) {
          return _0x42fa4a.has(_0x1c0557)
        }
        _0x29a31c.IsThrottled = _0xad3bbd
        let _0x5cf44d = 0
        const _0x3d2d31 = new Map()
        RegisterUICallback('fa-ui:applicationClosed', (data, cb) => {
            if (
              data.name !== 'textbox' ||
              data.callbackUrl !== 'fa-ui:menu:input'
            ) {
              return
            }
            const _0x3a6ae5 = _0x3d2d31.get(data.key)
            if (!_0x3a6ae5) {
              return
            }
            _0x3a6ae5.resolve(null)
            _0x3d2d31.delete(data.key)
          }
        )
        RegisterUICallback('fa-ui:menu:input', (data, cb) => {
            cb({
              data: {},
              meta: {
                ok: true,
                message: '',
              },
            })
            const _0xa2e328 = _0x3d2d31.get(data.key)
            if (!_0xa2e328) {
              return
            }
            const _0x445edf = _0xa2e328.validation
              ? _0xa2e328.validation(data.values)
              : true
            if (!_0x445edf) {
              return
            }
            _0xa2e328.resolve(data.values)
            _0x3d2d31.delete(data.key)
            _0x2a9cc1.g.exports['fa-ui'].closeApplication('textbox')
          }
        )
        function _0x381b8f(_0x4f27c3, _0x333b23) {
          const _0x5af49f = ++_0x5cf44d,
            _0x45d0d8 = new Promise((_0x457510) => {
              _0x3d2d31.set(_0x5af49f, {
                resolve: _0x457510,
                validation: _0x333b23,
              })
            })
          return (
            _0x2a9cc1.g.exports['fa-ui'].openApplication('textbox', {
              callbackUrl: 'fa-ui:menu:input',
              key: _0x5af49f,
              items: _0x4f27c3,
              show: true,
            }),
            _0x45d0d8
          )
        }
        _0x29a31c.OpenInputMenu = _0x381b8f
      },
      433: (_0x9b9f15, _0xca466d, _0x3ee237) => {
        Object.defineProperty(_0xca466d, '__esModule', { value: true })
        _0xca466d.GetDistanceFromEngine =
          _0xca466d.unkFunc41 =
          _0xca466d.GetDistance =
          _0xca466d.TurnPedEntity =
          _0xca466d.TurnPedCoords =
          _0xca466d.GetClosestBone =
            void 0
        const _0x4446cd = _0x3ee237(615)
        function _0x5562bc(_0x11df56, _0x104991) {
          let _0x5de606 = 0,
            _0xf03452 = '',
            _0x4d29d1 = 0,
            _0x1398bf
          const _0x3fb7b4 = GetEntityCoords(PlayerPedId(), false)
          return (
            _0x104991.forEach((_0x4fdaed) => {
              let _0x5be97e = GetEntityBoneIndexByName(_0x11df56, _0x4fdaed)
              if (_0x5be97e === -1) {
                return
              }
              const _0x31a4b9 = GetWorldPositionOfEntityBone(
                  _0x11df56,
                  _0x5be97e
                ),
                _0x2cfe64 = _0x4c87b4(_0x3fb7b4, _0x31a4b9, false)
              ;(!_0x5de606 || _0x2cfe64 < _0x4d29d1) &&
                ((_0x5de606 = _0x5be97e),
                (_0xf03452 = _0x4fdaed),
                (_0x1398bf = _0x31a4b9),
                (_0x4d29d1 = _0x2cfe64))
            }),
            [_0x5de606, _0xf03452, _0x4d29d1, _0x1398bf]
          )
        }
        _0xca466d.GetClosestBone = _0x5562bc
        async function _0x41aaa1(_0x197e81, [_0x30b13a, _0xb63b18, _0x401fc5]) {
          TaskTurnPedToFaceCoord(_0x197e81, _0x30b13a, _0xb63b18, _0x401fc5, 0)
          await (0, _0x4446cd.Delay)(100)
          while (GetScriptTaskStatus(_0x197e81, 1464580341) === 1) {
            await (0, _0x4446cd.Delay)(0)
          }
        }
        _0xca466d.TurnPedCoords = _0x41aaa1
        async function _0x47c157(_0x456391, _0x1ce746) {
          TaskTurnPedToFaceEntity(_0x456391, _0x1ce746, 0)
          await (0, _0x4446cd.Delay)(100)
          while (GetScriptTaskStatus(_0x456391, 3419293077) === 1) {
            await (0, _0x4446cd.Delay)(0)
          }
        }
        _0xca466d.TurnPedEntity = _0x47c157
        function _0x4c87b4(
          [_0x23d255, _0x49415b, _0x512347],
          [_0x1ba2e5, _0x28a031, _0x19939d],
          _0x828efb = false
        ) {
          return GetDistanceBetweenCoords(
            _0x23d255,
            _0x49415b,
            _0x512347,
            _0x1ba2e5,
            _0x28a031,
            _0x19939d,
            _0x828efb
          )
        }
        _0xca466d.GetDistance = _0x4c87b4
        function _0x29b501(_0x40195c, _0x24f09a, _0x3c8c08) {
          let _0x3aa0d8
          if (_0x24f09a === 1 && typeof _0x3c8c08 === 'number') {
            _0x3aa0d8 = GetPedBoneIndex(_0x40195c, _0x3c8c08)
          } else {
            _0x24f09a === 2 &&
              typeof _0x3c8c08 === 'string' &&
              (_0x3aa0d8 = GetEntityBoneIndexByName(_0x40195c, _0x3c8c08))
          }
          return GetWorldPositionOfEntityBone(_0x40195c, _0x3aa0d8)
        }
        function _0x58df7c(_0x42ad19, _0x255a0b, _0x527312, _0x11b5ea) {
          const _0x55dcf5 = _0x11b5ea
            ? _0x11b5ea
            : GetEntityCoords(PlayerPedId(), false)
          return _0x4c87b4(
            _0x29b501(_0x42ad19, _0x255a0b, _0x527312),
            _0x55dcf5
          )
        }
        _0xca466d.unkFunc41 = _0x58df7c
        function _0x4a306f(_0x48d703) {
          const [_0x3225a0, _0x4df5d3] = GetModelDimensions(
            GetEntityModel(_0x48d703)
          )
          return GetOffsetFromEntityInWorldCoords(
            _0x48d703,
            0,
            _0x4df5d3[1] + 0.5,
            0
          )
        }
        function _0x335180(_0x57fd41) {
          const [_0x30a8bf] = GetModelDimensions(GetEntityModel(_0x57fd41))
          return GetOffsetFromEntityInWorldCoords(
            _0x57fd41,
            0,
            _0x30a8bf[1] - 0.5,
            0
          )
        }
        function _0x5e4c22(_0x4f7f54) {
          const _0x2866b4 = _0x335180(_0x4f7f54),
            _0x2f038f = _0x58df7c(_0x4f7f54, 2, 'engine', _0x2866b4)
          if (_0x2f038f <= 2) {
            return _0x2866b4
          }
          return _0x4a306f(_0x4f7f54)
        }
        _0xca466d.GetDistanceFromEngine = _0x5e4c22
      },
      281: (_0x4b44d4, _0x2bd86b) => {
        Object.defineProperty(_0x2bd86b, '__esModule', { value: true })
        _0x2bd86b.Cache = void 0
        class _0x365878 {
          constructor() {
            this['_entries'] = new Map()
          }
          ['has'](_0x4a57bd) {
            return this['_entries'].has(_0x4a57bd)
          }
          ['isExpired'](_0x1b13e7) {
            const { ttl: _0x56e291, timestamp: _0x52f03e } =
              this['_entries'].get(_0x1b13e7)
            return Date.now() - _0x52f03e > _0x56e291
          }
          ['get'](_0x233a69) {
            return this['_entries'].get(_0x233a69).value
          }
          ['set'](_0x382581, _0x59c45b, _0x45f97c = 1000) {
            this['_entries'].set(_0x382581, {
              value: _0x59c45b,
              timestamp: Date.now(),
              ttl: _0x45f97c,
            })
          }
          ['delete'](_0x53e814) {
            return this['_entries'].delete(_0x53e814)
          }
          ['clear']() {
            this['_entries'].clear()
          }
          ['forEach'](_0xcc09bf) {
            this['_entries'].forEach((_0x567ffc, _0x2533d5) =>
              _0xcc09bf(_0x567ffc.value, _0x2533d5)
            )
          }
          ['find'](_0x4fed31) {
            return [...this['_entries'].entries()].find((_0x378a71) =>
              _0x4fed31(_0x378a71.value)
            )
          }
          ['some'](_0x2d54aa) {
            return [...this['_entries'].entries()].some((_0x2f75a2) =>
              _0x2d54aa(_0x2f75a2.value)
            )
          }
        }
        _0x2bd86b.Cache = _0x365878
      },
      543: (_0x185428, _0x192291) => {
        Object.defineProperty(_0x192291, '__esModule', { value: true })
        _0x192291.Mods = void 0
        var _0x5a311f
        ;(function (_0x178bab) {
          _0x178bab[(_0x178bab.Spoilers = 0)] = 'Spoilers'
          _0x178bab[(_0x178bab.FrontBumper = 1)] = 'FrontBumper'
          _0x178bab[(_0x178bab.RearBumper = 2)] = 'RearBumper'
          _0x178bab[(_0x178bab.SideSkirt = 3)] = 'SideSkirt'
          _0x178bab[(_0x178bab.Exhaust = 4)] = 'Exhaust'
          _0x178bab[(_0x178bab.Frame = 5)] = 'Frame'
          _0x178bab[(_0x178bab.Grille = 6)] = 'Grille'
          _0x178bab[(_0x178bab.Hood = 7)] = 'Hood'
          _0x178bab[(_0x178bab.Fender = 8)] = 'Fender'
          _0x178bab[(_0x178bab.RightFender = 9)] = 'RightFender'
          _0x178bab[(_0x178bab.Roof = 10)] = 'Roof'
          _0x178bab[(_0x178bab.Engine = 11)] = 'Engine'
          _0x178bab[(_0x178bab.Brakes = 12)] = 'Brakes'
          _0x178bab[(_0x178bab.Transmission = 13)] = 'Transmission'
          _0x178bab[(_0x178bab.Horns = 14)] = 'Horns'
          _0x178bab[(_0x178bab.Suspension = 15)] = 'Suspension'
          _0x178bab[(_0x178bab.Armor = 16)] = 'Armor'
          _0x178bab[(_0x178bab.UNK17 = 17)] = 'UNK17'
          _0x178bab[(_0x178bab.Turbo = 18)] = 'Turbo'
          _0x178bab[(_0x178bab.UNK19 = 19)] = 'UNK19'
          _0x178bab[(_0x178bab.TireSmoke = 20)] = 'TireSmoke'
          _0x178bab[(_0x178bab.UNK21 = 21)] = 'UNK21'
          _0x178bab[(_0x178bab.XenonHeadlights = 22)] = 'XenonHeadlights'
          _0x178bab[(_0x178bab.FrontWheels = 23)] = 'FrontWheels'
          _0x178bab[(_0x178bab.BackWheels = 24)] = 'BackWheels'
          _0x178bab[(_0x178bab.PlateHolder = 25)] = 'PlateHolder'
          _0x178bab[(_0x178bab.VanityPlates = 26)] = 'VanityPlates'
          _0x178bab[(_0x178bab.InteriorTrim = 27)] = 'InteriorTrim'
          _0x178bab[(_0x178bab.Ornaments = 28)] = 'Ornaments'
          _0x178bab[(_0x178bab.Dashboard = 29)] = 'Dashboard'
          _0x178bab[(_0x178bab.Dials = 30)] = 'Dials'
          _0x178bab[(_0x178bab.DoorSpeakers = 31)] = 'DoorSpeakers'
          _0x178bab[(_0x178bab.Seats = 32)] = 'Seats'
          _0x178bab[(_0x178bab.SteeringWheel = 33)] = 'SteeringWheel'
          _0x178bab[(_0x178bab.ShiftLeavers = 34)] = 'ShiftLeavers'
          _0x178bab[(_0x178bab.Plaques = 35)] = 'Plaques'
          _0x178bab[(_0x178bab.Speakers = 36)] = 'Speakers'
          _0x178bab[(_0x178bab.Trunk = 37)] = 'Trunk'
          _0x178bab[(_0x178bab.Hydraulics = 38)] = 'Hydraulics'
          _0x178bab[(_0x178bab.EngineBlock = 39)] = 'EngineBlock'
          _0x178bab[(_0x178bab.AirFilter = 40)] = 'AirFilter'
          _0x178bab[(_0x178bab.Struts = 41)] = 'Struts'
          _0x178bab[(_0x178bab.ArchCover = 42)] = 'ArchCover'
          _0x178bab[(_0x178bab.Aerials = 43)] = 'Aerials'
          _0x178bab[(_0x178bab.ExteriorTrim = 44)] = 'ExteriorTrim'
          _0x178bab[(_0x178bab.Tank = 45)] = 'Tank'
          _0x178bab[(_0x178bab.Windows = 46)] = 'Windows'
          _0x178bab[(_0x178bab.UNK47 = 47)] = 'UNK47'
          _0x178bab[(_0x178bab.Livery = 48)] = 'Livery'
        })((_0x5a311f = _0x192291.Mods || (_0x192291.Mods = {})))
      },
    },
    _0x194db7 = {}
  function _0xe8b711(_0x166afb) {
    var _0x41c705 = _0x194db7[_0x166afb]
    if (_0x41c705 !== undefined) {
      return _0x41c705.exports
    }
    var _0x186566 = (_0x194db7[_0x166afb] = { exports: {} })
    _0x3b9876[_0x166afb].call(
      _0x186566.exports,
      _0x186566,
      _0x186566.exports,
      _0xe8b711
    )
    return _0x186566.exports
  }
  ;(() => {
    _0xe8b711.g = (function () {
      if (typeof globalThis === 'object') {
        return globalThis
      }
      try {
        return this || new Function('return this')()
      } catch (_0x456acd) {
        if (typeof window === 'object') {
          return window
        }
      }
    })()
  })()
  _0xe8b711(50)
  _0xe8b711(957)
  _0xe8b711(908)
  _0xe8b711(369)
  _0xe8b711(965)
  _0xe8b711(302)
  _0xe8b711(130)
  var _0x49742f = _0xe8b711(17)
})()
