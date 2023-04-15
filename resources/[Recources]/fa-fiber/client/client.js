;(() => {
    'use strict'
    var _0x2d461a = {}
    const _0x26ae9f = globalThis.FYX,
      _0x4d0962 = _0x26ae9f.Hud,
      _0x374e76 = _0x26ae9f.Utils,
      _0x3ae7a7 = _0x26ae9f.Zones,
      _0x38712e = _0x26ae9f.Events,
      _0x36cbd5 = _0x26ae9f.Streaming,
      _0x2bb009 = _0x26ae9f.Procedures,
      _0x4a91cd = _0x26ae9f.Interface,
      _0x1b7621 = null && _0x26ae9f
    const _0x26f201 = globalThis
    async function _0x226790(_0x2a90e0) {
      return new Promise((_0x1f73be) => setTimeout(() => _0x1f73be(), _0x2a90e0))
    }
    function _0x12fefa(_0x340e6e, _0x1d7dbe) {
      return Math.floor(
        _0x1d7dbe
          ? Math.random() * (_0x1d7dbe - _0x340e6e) + _0x340e6e
          : Math.random() * _0x340e6e
      )
    }
    let _0xc4120f = false
    async function _0x226904() {}
    _0x26f201.on('fa-admin:currentDevmode', async (_0x30075e) => {
      const _0x3e1343 = await _0x2bb009.execute('fa-fiber:verify:userRank', 'dev')
      if (_0x3e1343 !== true) {
        return
      }
      _0xc4120f = _0x30075e
    })
    function _0x4fdc70(_0x115ab9, _0x27172e) {
      _0x26f201.RegisterNuiCallbackType(_0x115ab9)
      _0x26f201.on('__cfx_nui:' + _0x115ab9, _0x27172e)
    }
    function _0x2ec687(_0x23b67e) {
      _0x26f201.SendNuiMessage(JSON.stringify(_0x23b67e))
    }
    function _0x5e741c() {
      return {
        serverId: CFX.GetPlayerServerId(CFX.PlayerId()),
        characterId: exports.isPed.isPed('cid'),
        firstName: exports.isPed.isPed('firstname'),
        lastName: exports.isPed.isPed('lastname'),
        phoneNumber: exports.isPed.isPed('phone_number'),
      }
    }
    async function _0x27e129(_0x302537) {
      const _0x255308 =
        typeof _0x302537 === 'number' ? _0x302537 : CFX.GetHashKey(_0x302537)
      if (CFX.HasModelLoaded(_0x255308)) {
        return true
      } else {
        if (!CFX.IsModelInCdimage(_0x255308)) {
          return false
        }
      }
      CFX.RequestModel(_0x255308)
      let _0x425b39 = false
      const _0x54d8e8 = CFX.setTimeout(() => (_0x425b39 = true), 60000)
      while (!CFX.HasModelLoaded(_0x255308) && !_0x425b39) {
        await Wait(10)
      }
      return CFX.clearTimeout(_0x54d8e8), _0x425b39 === false
    }
    async function _0x4fab7f() {
      return new Promise(async (_0xe9497c) => {
        while (!_0x26f201.NetworkIsSessionStarted()) {
          await _0x226790(100)
        }
        _0xe9497c()
      })
    }
    let _0x891ae6 = false
    async function _0x4169c1() {}
    _0x4fdc70('pnp:fiber:api:setState', (_0x4daa07, _0x4621c6) => {
      _0x891ae6 = _0x4daa07.active
      const _0x5423b2 = { voipStatus: _0x891ae6 }
      exports['fa-ui'].sendAppEvent('hud', _0x5423b2)
      const _0x510039 = {
        success: true,
        message: '',
      }
      const _0x38c41f = {
        body: {},
        meta: _0x510039,
      }
      _0x4621c6(_0x38c41f)
    })
    _0x26f201.RegisterCommand('fiberToggleDebug', () => {
        if (!_0xc4120f) {
          return
        }
        const _0x1dac63 = {
          type: 'debug',
          payload: {},
        }
        _0x2ec687(_0x1dac63)
      },
      false
    )
    const _0x3b04e0 = {
      token: undefined,
      rest_api: undefined,
      socket_api: undefined,
      server_hash: undefined,
    }
    const _0x9ab023 = _0x3b04e0
    async function _0x275f9b() {
      try {
        const _0x149387 = await _0x2bb009.execute('pnp:fiber:player:init')
        if (!_0x149387) {
          throw new Error('Received no details from fiber for player.')
        }
        _0x3a0352(
          _0x149387.token,
          _0x149387.rest_api,
          _0x149387.socket_api,
          _0x149387.server_hash
        )
        const _0xae05d8 = {
          token: _0x149387.token,
          endpoint: _0x149387.rest_api,
        }
        exports['fa-ui'].sendAppEvent('game', _0xae05d8)
        _0x2ec687({
          type: 'init',
          payload: {
            token: _0x149387.token,
            endpoint: _0x149387.socket_api,
            serverHash: _0x149387.server_hash,
            serverId: GetPlayerServerId(PlayerId()),
          },
        })
      } catch (_0x5626ba) {
        console.error(
          'Unable to retrieve API details from server. Trying again...'
        )
        setTimeout(() => _0x275f9b(), 10000)
      }
    }
    function _0x3a0352(_0x455935, _0x3ff567, _0x45aabd, _0xd19518) {
      _0x9ab023.token = _0x455935
      _0x9ab023.rest_api = _0x3ff567
      _0x9ab023.socket_api = _0x45aabd
      _0x9ab023.server_hash = _0xd19518
    }
    function _0x59919e() {
      const _0x58685f = {}
      return (
        (_0x58685f.token = _0x9ab023.token),
        (_0x58685f.endpoint = _0x9ab023.rest_api),
        _0x58685f
      )
    }
    exports('GetGameDetails', _0x59919e)
    function _0x3ec4f5() {
      const _0x122635 = {}
      return (
        (_0x122635.token = _0x9ab023.token),
        (_0x122635.endpoint = _0x9ab023.socket_api),
        _0x122635
      )
    }
    async function _0x3e1c14() {
      await _0x4169c1()
      await _0x275f9b()
    }
    async function _0x784700() {}
    _0x4fdc70('pnp:fiber:datagrid:message', (_0x2f8dac, _0x3c1852) => {
      if (!_0x2f8dac.event) {
        return
      }
      _0x38712e.emit(_0x2f8dac.event, _0x2f8dac.data)
      const _0xdd4e24 = {
        success: true,
        message: '',
      }
      const _0x5bcfde = {
        body: {},
        meta: _0xdd4e24,
      }
      _0x3c1852(_0x5bcfde)
    })
    async function _0x55865a() {
      await _0x784700()
    }
    class _0x31a725 {
      constructor(_0x250d16, _0x4e873f, _0x3cc9f6 = 'interval') {
        this.callback = _0x250d16
        this.delay = _0x4e873f
        this.mode = _0x3cc9f6
        this.scheduled = {}
        this.tick = 0
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
      }
      get ['isActive']() {
        return this.active
      }
      async ['start']() {
        if (this.active) {
          return
        }
        this.aborted = false
        this.scheduled = {}
        const _0xa566df = this.hooks.get('preStart')
        try {
          for (const _0x34ac6d of _0xa566df) {
            if (!this.aborted) {
              await _0x34ac6d.call(this)
            }
          }
        } catch (_0x6f49dd) {
          this.aborted = true
          console.log('Error while calling pre-start hook', _0x6f49dd.message)
        }
        if (this.aborted) {
          try {
            const _0x58ce9b = this.hooks.get('startAborted')
            for (const _0x4c30a9 of _0x58ce9b) {
              await _0x4c30a9.call(this)
            }
          } catch (_0xe9536) {
            console.log(
              'Error while calling start-aborted hook',
              _0xe9536.message
            )
          }
          return
        }
        this.active = true
        const _0x3e0302 = this.hooks.get('active')
        switch (this.mode) {
          case 'tick': {
            this.threadId = _0x26f201.setTick(async () => {
              this.tick += 1
              try {
                await this.callback.call(this)
                for (const _0x5adf53 of _0x3e0302) {
                  await _0x5adf53.call(this)
                }
              } catch (_0x37ad1d) {
                console.log('Error while calling active hook', _0x37ad1d.message)
              }
              if (this.delay > 0) {
                await new Promise((_0x4ecee4) =>
                  _0x26f201.setTimeout(_0x4ecee4, this.delay)
                )
              }
            })
            break
          }
          case 'interval': {
            this.threadId = _0x26f201.setInterval(async () => {
              this.tick += 1
              try {
                await this.callback.call(this)
                for (const _0x1a8be4 of _0x3e0302) {
                  await _0x1a8be4.call(this)
                }
              } catch (_0x18a106) {
                console.log('Error while calling active hook', _0x18a106.message)
              }
            }, this.delay)
            break
          }
          case 'timeout': {
            const _0x40aad4 = () => {
              this.active &&
                (this.threadId = _0x26f201.setTimeout(async () => {
                  this.tick += 1
                  try {
                    await this.callback.call(this)
                    for (const _0xa3e633 of _0x3e0302) {
                      await _0xa3e633.call(this)
                    }
                  } catch (_0x4c784e) {
                    console.log(
                      'Error while calling active hook',
                      _0x4c784e.message
                    )
                  }
                  return _0x40aad4()
                }, this.delay))
            }
            _0x40aad4()
            break
          }
        }
        const _0x3d3206 = this.hooks.get('afterStart')
        try {
          for (const _0x420e5c of _0x3d3206) {
            await _0x420e5c.call(this)
          }
        } catch (_0x503c0b) {
          console.log('Error while calling after-start hook', _0x503c0b.message)
        }
      }
      async ['stop']() {
        if (!this.active) {
          return
        }
        const _0x2adc82 = this.hooks.get('preStop')
        try {
          for (const _0x14b143 of _0x2adc82) {
            if (!this.aborted) {
              await _0x14b143.call(this)
            }
          }
        } catch (_0x539124) {
          this.aborted = true
          console.log('Error while calling pre-stop hook', _0x539124.message)
        }
        this.active = false
        switch (this.mode) {
          case 'tick': {
            _0x26f201.clearTick(this.threadId)
            break
          }
          case 'interval': {
            _0x26f201.clearInterval(this.threadId)
            break
          }
          case 'timeout': {
            _0x26f201.clearTimeout(this.threadId)
            break
          }
        }
        if (this.aborted) {
          try {
            const _0x466880 = this.hooks.get('stopAborted')
            for (const _0x3188f7 of _0x466880) {
              await _0x3188f7.call(this)
            }
          } catch (_0x5410bc) {
            console.log(
              'Error while calling stop-aborted hook',
              _0x5410bc.message
            )
          }
          return
        }
        const _0x141fda = this.hooks.get('afterStop')
        try {
          for (const _0x5ccdff of _0x141fda) {
            await _0x5ccdff.call(this)
          }
        } catch (_0x5c5d9c) {
          console.log('Error while calling after-stop hook', _0x5c5d9c.message)
        }
      }
      ['abort']() {
        this.aborted = true
      }
      ['addHook'](_0x4664c9, _0x5eacb2) {
        var _0x40f154
        ;(_0x40f154 = this.hooks.get(_0x4664c9)) === null || _0x40f154 === void 0
          ? void 0
          : _0x40f154.push(_0x5eacb2)
      }
      ['setNextTick'](_0x5189d3, _0x32c3bb) {
        this.scheduled[_0x5189d3] = this.tick + _0x32c3bb
      }
      ['canTick'](_0x5732cc) {
        return (
          this.scheduled[_0x5732cc] === undefined ||
          this.tick >= this.scheduled[_0x5732cc]
        )
      }
    }
    const _0x3ebbfe = new _0x31a725(function () {}, 1000, 'tick')
    _0x3ebbfe.addHook('preStart', function () {
      this.data.checks = {}
    })
    _0x3ebbfe.addHook('active', function () {
      this.canTick('mainThread') &&
        (this.setNextTick('mainThread', 5),
        (this.data.playerId = _0x26f201.PlayerId()),
        (this.data.playerPed = _0x26f201.PlayerPedId()),
        (this.data.playerModel = _0x26f201.GetEntityModel(this.data.playerPed)),
        (this.data.playerCoords = _0x26f201.GetEntityCoords(
          this.data.playerPed,
          false
        )))
      this.delay = _0x12fefa(700, 1400)
    })
    async function _0x19f90f() {
      await _0x4fab7f()
      await _0x3ebbfe.start()
    }
    async function _0x36974a() {}
    const _0x3de3bf = {
      hasSpawned: false,
      hasSpawned: true,
      // isDead: !_0x3de3bf.isDead,
      onEditor: true,
      onEditor: false,
      hasSpawned: true,
      isDead: _0x26f201.exports.isPed.isPed('dead'),
    }
    async function _0x1b534d() {
      _0x26f201.emitNet('fa-fiber:phoneAPIReady')
    }
    _0x26f201.on('fa-base:spawnInitialized', () => {
      const _0x1e85bb = _0x26f201.GetEntityCoords(_0x26f201.PlayerPedId(), false),
        _0x4aa040 = _0x26f201.GetDistanceBetweenCoords(
          -682,
          -1092,
          200,
          _0x1e85bb[0],
          _0x1e85bb[1],
          _0x1e85bb[2],
          true
        )
      if (_0x4aa040 > 100) {
        return
      }
    })
    _0x26f201.on('fa-spawn:characterSpawned', () => {
      _0x26f201.setTimeout(() => {}, 5000)
    })
    _0x26f201.on('pd:deathcheck', () => {})
    _0x26f201.onNet('fa-editor:loadEditor', () => {})
    _0x26f201.onNet('fa-editor:closeEditor', () => {})
    _0x26f201.on('fa-fiber:hotreload', (_0xa8d3e3) => {
      if (_0xa8d3e3 === undefined || _0xa8d3e3 === 0) {
        return
      }
    })
    async function _0x2f73b8() {}
    _0x3ebbfe.addHook('active', async function () {
      _0x3de3bf.hasSpawned &&
        this.canTick('playerChecks') &&
        (this.setNextTick('playerChecks', _0x12fefa(4, 8)),
        (this.data.checks.invisible = await _0x352d71(this.data.playerPed)),
        (this.data.checks.invincible = await _0x307ab8(this.data.playerId)),
        (this.data.checks.spectating = await _0x516102(this.data.playerId)),
        (this.data.checks.noclip =
          this.data.checks.invisible && this.data.checks.invincible),
        (this.data.checks.infiniteArmor = await _0x1c6f52(this.data.playerPed)),
        (this.data.checks.infiniteHealth = await _0x1291b6(
          this.data.playerPed,
          this.data.playerModel
        )),
        _0x39a855(this.data.checks))
    })
    async function _0x352d71(_0x569e04) {
      if (!!_0x26f201.IsEntityVisible(_0x569e04)) {
        return false
      }
      if (_0x3de3bf.onEditor) {
        return false
      }
      return true
    }
    async function _0x307ab8(_0x1c8cb7) {
      if (!_0x26f201.GetPlayerInvincible_2(_0x1c8cb7)) {
        return false
      }
      if (_0x3de3bf.isDead) {
        return false
      }
      return true
    }
    async function _0x516102(_0x221d1a) {
      return !!_0x26f201.NetworkIsInSpectatorMode()
    }
    async function _0x1291b6(_0x3a8b50, _0x401fa9) {
      const _0x17dbe4 = _0x26f201.GetEntityHealth(_0x3a8b50)
      if (_0x17dbe4 > 200) {
        return true
      }
      _0x26f201.SetEntityHealth(_0x3a8b50, _0x17dbe4 - 2)
      await _0x226790(25)
      const _0x2a10ce = _0x26f201.GetEntityHealth(_0x3a8b50)
      return (
        _0x26f201.SetEntityHealth(_0x3a8b50, _0x2a10ce + 2),
        _0x17dbe4 === _0x2a10ce && _0x17dbe4 !== 0 && _0x2a10ce !== 0
      )
    }
    async function _0x1c6f52(_0x3eb325) {
      const _0x3d0dad = _0x26f201.GetPedArmour(_0x3eb325)
      if (_0x3d0dad > 100) {
        return true
      }
      _0x26f201.SetPedArmour(_0x3eb325, _0x3d0dad - 2)
      await _0x226790(25)
      const _0x5d2596 = _0x26f201.GetPedArmour(_0x3eb325)
      return (
        _0x26f201.SetPedArmour(_0x3eb325, _0x5d2596 + 2),
        _0x3d0dad === _0x5d2596 && _0x3d0dad !== 0 && _0x5d2596 !== 0
      )
    }
    function _0x39a855(_0x1903ff) {
      let _0x48b773 = false
      const _0x35ea51 = [
        'invisible',
        'invincible',
        'noclip',
        'infiniteArmor',
        'infiniteHealth',
      ]
      for (const [_0x27276b, _0x10544a] of Object.entries(_0x1903ff)) {
        if (_0x10544a && !_0x35ea51.includes(_0x27276b)) {
          _0x48b773 = true
          break
        }
      }
      if (_0x48b773 !== true) {
        return
      }
      _0x26f201.emitNet('fa-fiber:updatePhoneStatus', 'playerChecks', _0x1903ff)
    }
    async function _0x2e2e18() {
      await _0x36974a()
      await _0x2f73b8()
    }
    async function _0x217051() {
      await _0x1b534d()
      await _0x2e2e18()
      await _0x19f90f()
    }
    async function _0x519ea5() {
      await _0x217051()
      await _0x226904()
      await _0x3e1c14()
      await _0x55865a()
    }
    _0x26f201.on('onClientResourceStop', (_0x16cf18) => {
      _0x26f201.emitNet('baseevents:hotreload', _0x16cf18)
    })
    const _0x199906 = _0x26f201.GetCurrentResourceName()
    _0x26f201.on('onClientResourceStart', async (_0x8fbeb8) => {
      if (_0x8fbeb8 !== _0x199906) {
        return
      }
      await _0x519ea5()
    })
  })()
  