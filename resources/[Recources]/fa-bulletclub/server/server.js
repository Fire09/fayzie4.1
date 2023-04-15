!(function () {
    'use strict'
    var _0x17d06f = {
        804: function (_0x591532, _0x54e014, _0x380d09) {
          Object.defineProperty(_0x54e014, '__esModule', { value: true })
          _0x54e014.Base =
            _0x54e014.Utils =
            _0x54e014.Procedures =
            _0x54e014.Events =
              void 0
          _0x54e014.Events = {
            on: (_0x4ba7b8, _0x4fc631) => DPX.Events.on(_0x4ba7b8, _0x4fc631),
            onNet: (_0x361ded, _0x483a86) =>
              DPX.Events.onNet(_0x361ded, _0x483a86),
            emit: (_0x3ba514, ..._0x8bea33) =>
              DPX.Events.emit(_0x3ba514, ..._0x8bea33),
            emitNet: (_0x1a6a5c, ..._0x2fc510) =>
              DPX.Events.emitNet(_0x1a6a5c, ..._0x2fc510),
            remove: (_0x164812, _0x439151) =>
              DPX.Events.remove(_0x164812, _0x439151),
          }
          _0x54e014.Procedures = {
            register: (_0x46594b, _0x515e82) =>
              DPX.Procedures.register(_0x46594b, _0x515e82),
            execute: (_0x14c49c, ..._0x2fffa5) =>
              DPX.Procedures.execute(_0x14c49c, ..._0x2fffa5),
          }
          _0x54e014.Utils = {
            cache: (_0xeb7519, _0x2cc96d) =>
              DPX.Utils.cache(_0xeb7519, _0x2cc96d),
            cacheableMap: (_0x2a5037, _0x5ae2ec) =>
              DPX.Utils.cacheableMap(_0x2a5037, _0x5ae2ec),
            waitForCondition: (_0x2f32df, _0x38f94c) =>
              DPX.Utils.waitForCondition(_0x2f32df, _0x38f94c),
            getMapRange: (_0x5d76fd, _0x393a6f, _0x541b46) =>
              DPX.Utils.getMapRange(_0x5d76fd, _0x393a6f, _0x541b46),
            getDistance: (
              [_0x48dcd6, _0x1fc61f, _0x358ce3],
              [_0x169371, _0x1cdb88, _0x3edec7]
            ) =>
              DPX.Utils.getDistance(
                [_0x48dcd6, _0x1fc61f, _0x358ce3],
                [_0x169371, _0x1cdb88, _0x3edec7]
              ),
            getRandomNumber: (_0x4443ec, _0x5b1fba) =>
              DPX.Utils.getRandomNumber(_0x4443ec, _0x5b1fba),
          }
          _0x54e014.Base = {
            getCharacter: async (_0x3c2235) =>
              await _0x380d09.g.exports['fa-lib'].getCharacter(_0x3c2235),
          }
        },
      },
      _0x1755d1 = {}
    function _0x28abeb(_0x2421e0) {
      var _0x3bfb0c = _0x1755d1[_0x2421e0]
      if (void 0 !== _0x3bfb0c) {
        return _0x3bfb0c.exports
      }
      var _0x330a1d = (_0x1755d1[_0x2421e0] = { exports: {} })
      return (
        _0x17d06f[_0x2421e0](_0x330a1d, _0x330a1d.exports, _0x28abeb),
        _0x330a1d.exports
      )
    }
    _0x28abeb.g = (function () {
      if ('object' == typeof globalThis) {
        return globalThis
      }
      try {
        return this || new Function('return this')()
      } catch (_0xfd36f8) {
        if ('object' == typeof window) {
          return window
        }
      }
    })()
    ;(function () {
      const _0x3dbf5d = _0x28abeb(804)
      let _0x334b61 = 0,
        _0xa3dd03 = 0,
        _0x4edbd8 = false,
        _0x7f00c5 = false
      const _0x4ece0c = {
        easy: {
          gameTime: 5000,
          gameTargets: 12,
        },
        medium: {
          gameTime: 2500,
          gameTargets: 25,
        },
        hard: {
          gameTime: 1000,
          gameTargets: 50,
        },
        aimbot: {
          gameTime: 500,
          gameTargets: 100,
        },
      }
      let _0x1bfc13 = 'aimbot',
        _0x218690 = 0,
        _0x393dde = 0
      const _0x569c41 = () => {
        emitNet('fa-bulletclub:updateHud', -1, [
          'Status: ' +
            (_0x4edbd8 ? 'Active' : 'Pending') +
            ' | Difficulty: ' +
            _0x1bfc13,
          'Score: ' +
            _0x334b61 +
            ' | Remaining: ' +
            ('custom' === _0x1bfc13
              ? _0x393dde
              : _0x4edbd8
              ? _0xa3dd03
              : _0x4ece0c[_0x1bfc13].gameTargets),
          'Strafe Enabled: ' + (_0x7f00c5 ? 'true' : 'false'),
        ])
      }
      RegisterCommand(
        'setdiff',
        (_0x4b70c3, _0x1df4a0, _0x2aae58) => {
          ;(_0x1bfc13 = _0x1df4a0[0]),
            'custom' === _0x1df4a0[0] &&
              ((_0x218690 = parseInt(_0x1df4a0[1])),
              (_0x393dde = parseInt(_0x1df4a0[2]))),
            _0x569c41()
        },
        false
      )
      _0x3dbf5d.Events.onNet('fa-bulletclub:startGame', (_0x4201a8) => {
        if (!_0x4edbd8) {
          if (((_0x4edbd8 = true), 'custom' === _0x1bfc13)) {
            _0x334b61 = 0
            _0xa3dd03 = _0x393dde
            _0x3dbf5d.Events.emitNet(
              'fa-bulletclub:gameStarted',
              _0x4201a8,
              _0x393dde,
              _0x218690,
              _0x7f00c5
            )
          } else {
            _0x334b61 = 0
            _0xa3dd03 = _0x4ece0c[_0x1bfc13].gameTargets
            const _0x2cb4cd = _0x4ece0c[_0x1bfc13].gameTime,
              _0x496d4d = _0x4ece0c[_0x1bfc13].gameTargets
            _0x3dbf5d.Events.emitNet(
              'fa-bulletclub:gameStarted',
              _0x4201a8,
              _0x496d4d,
              _0x2cb4cd,
              _0x7f00c5
            )
          }
          _0x569c41()
        }
      })
      _0x3dbf5d.Events.onNet('fa-bulletclub:updateSettings', (_0x1c08fd) => {
        _0x4edbd8 ||
          ((_0x1bfc13 = _0x1c08fd.difficulty),
          (_0x7f00c5 = _0x1c08fd.strafeEnabled),
          _0x569c41())
      })
      _0x3dbf5d.Events.onNet('fa-bulletclub:targetKilled', () => {
        _0x4edbd8 && (_0x334b61++, _0x569c41())
      })
      _0x3dbf5d.Events.onNet(
        'fa-bulletclub:updateEnemiesRemaining',
        (_0x4bf0ac) => {
          _0x4edbd8 &&
            emitNet('fa-bulletclub:updateHud', -1, [
              'Status: ' +
                (_0x4edbd8 ? 'Active' : 'Pending') +
                ' | Difficulty: ' +
                _0x1bfc13,
              'Score: ' + _0x334b61 + ' | Remaining: ' + _0x4bf0ac,
              'Strafe Enabled: ' + (_0x7f00c5 ? 'true' : 'false'),
            ])
        }
      )
      _0x3dbf5d.Events.onNet(
        'fa-bulletclub:gameCompleted',
        async (_0x3f52fa, _0x3a1284) => {
          if (
            ((_0x4edbd8 = false),
            (_0x334b61 = 0),
            (_0xa3dd03 = 0),
            _0x569c41(),
            0 === _0x3a1284)
          ) {
            return
          }
          emitNet('player:receiveItem', _0x3f52fa, 'bclubtoken', 1)
          const _0x5bbdc8 = await _0x3dbf5d.Base.getCharacter(_0x3f52fa)
          if (!_0x5bbdc8) {
            return
          }
          const _0x460988 = await SQL.execute(
            'SELECT * FROM bulletclub_leaderboard WHERE difficulty = @difficulty AND cid = @cid',
            {
              difficulty: _0x1bfc13,
              cid: _0x5bbdc8.id,
            }
          )
          if (_0x460988[0]) {
            if (_0x460988[0].score > _0x3a1284) {
              return
            }
            await SQL.execute(
              'UPDATE bulletclub_leaderboard SET score = @score WHERE difficulty = @difficulty AND cid = @cid',
              {
                score: _0x3a1284,
                difficulty: _0x1bfc13,
                cid: _0x5bbdc8.id,
              }
            )
          } else {
            if (
              !(await SQL.execute(
                'INSERT INTO bulletclub_leaderboard (difficulty, name, score, cid) VALUES (@difficulty, @name, @score, @cid)',
                {
                  difficulty: _0x1bfc13,
                  name: _0x5bbdc8.first_name + ' ' + _0x5bbdc8.last_name,
                  score: _0x3a1284,
                  cid: _0x5bbdc8.id,
                }
              ))
            ) {
              return
            }
          }
        }
      )
      _0x3dbf5d.Events.onNet('fa-bulletclub:resetGameState', () => {
        _0x4edbd8 = false
        _0x334b61 = 0
        _0xa3dd03 = 0
        _0x569c41()
        _0x3dbf5d.Events.emitNet('fa-bulletclub:gameReset', -1)
      })
      _0x3dbf5d.Events.onNet('fa-bulletclub:enteredBuilding', () => {
        _0x569c41()
      })
      _0x3dbf5d.Procedures.register(
        'fa-bulletclub:getLeaderBoard',
        async (_0x41b636, _0x1af012) =>
          (await SQL.execute(
            'SELECT * FROM bulletclub_leaderboard WHERE difficulty\t= @difficulty ORDER BY score DESC',
            { difficulty: _0x1af012 }
          )) || []
      )
    })()
  })()
  