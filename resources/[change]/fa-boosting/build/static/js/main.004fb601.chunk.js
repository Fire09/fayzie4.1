;(this.webpackJsonpboost = this.webpackJsonpboost || []).push([
    [0],
    {
      136: function (e, t, n) {},
      147: function (e, t, n) {
        'use strict'
        n.r(t)
        var c = n(0),
          s = n.n(c),
          a = n(31),
          i = n.n(a),
          o = n(5),
          r = (n(136), n(18)),
          l = n(1),
          j = function (e) {
            var t = e.completed,
              n = { width: ''.concat(t, '%') }
            return Object(l.jsx)(l.Fragment, {
              children: Object(l.jsx)('div', {
                className: 'proggresBoosting',
                children: Object(l.jsx)('div', {
                  style: n,
                  className: 'proggresBoosting2',
                }),
              }),
            })
          },
          b = n(222),
          u = n(235),
          d = n(246),
          m = n(236),
          O = n(88),
          p = n.n(O),
          h = n(102),
          x = function () {
            return !window.invokeNative
          }
        function f(e, t) {
          return g.apply(this, arguments)
        }
        function g() {
          return (g = Object(h.a)(
            p.a.mark(function e(t, n) {
              var c, s, a, i
              return p.a.wrap(function (e) {
                for (;;) {
                  switch ((e.prev = e.next)) {
                    case 0:
                      if (x()) {
                        e.next = 10
                        break
                      }
                      return (
                        (c = {
                          method: 'post',
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: JSON.stringify(n),
                        }),
                        (s = window.GetParentResourceName
                          ? window.GetParentResourceName()
                          : 'nui-frame-app'),
                        (e.next = 5),
                        fetch('https://'.concat(s, '/').concat(t), c)
                      )
                    case 5:
                      return (a = e.sent), (e.next = 8), a.json()
                    case 8:
                      return (i = e.sent), e.abrupt('return', i)
                    case 10:
                    case 'end':
                      return e.stop()
                  }
                }
              }, e)
            })
          )).apply(this, arguments)
        }
        var v = function (e) {
            var t = Object(c.useState)(true),
              n = Object(o.a)(t, 2),
              s = n[0],
              a = n[1],
              i = Object(c.useState)(false),
              r = Object(o.a)(i, 2),
              j = r[0],
              O = r[1],
              p = Object(c.useState)(false),
              h = Object(o.a)(p, 2),
              x = h[0],
              g = h[1],
              v = Object(c.useState)(false),
              N = Object(o.a)(v, 2),
              C = N[0],
              y = N[1],
              w = Object(c.useState)(false),
              S = Object(o.a)(w, 2),
              B = S[0],
              E = S[1],
              I = Object(c.useState)(false),
              k = Object(o.a)(I, 2),
              T = k[0],
              P = k[1],
              A = Object(c.useState)(false),
              L = Object(o.a)(A, 2),
              M = L[0],
              R = L[1],
              G = Object(c.useState)(false),
              F = Object(o.a)(G, 2),
              U = F[0],
              _ = F[1],
              V = Object(c.useState)(''),
              D = Object(o.a)(V, 2),
              z = D[0],
              J = D[1],
              q = Object(c.useState)(e.expires || 30),
              Y = Object(o.a)(q, 2),
              K = Y[0],
              X = Y[1],
              Z = Object(c.useState)(99999),
              Q = Object(o.a)(Z, 2),
              W = Q[0],
              H = Q[1],
              $ = Object(c.useState)(false),
              ee = Object(o.a)($, 2),
              te = ee[0],
              ne = ee[1]
            Object(c.useEffect)(
              function () {
                var e =
                  K > 0 &&
                  !te &&
                  s &&
                  setInterval(function () {
                    return X(K - 1)
                  }, 1000)
                return function () {
                  return clearInterval(e)
                }
              },
              [K]
            )
            Object(c.useEffect)(
              function () {
                0 === K &&
                  (f('faye-boosting:DeclineContract', {
                    props: e,
                    IsInProgress: U,
                  }),
                  a(false))
              },
              [K]
            )
            Object(c.useEffect)(
              function () {
                var t =
                  W > 0 &&
                  !te &&
                  s &&
                  setInterval(function () {
                    return H(W - 1)
                  }, 5000)
                return function () {
                  return (function (t) {
                    clearInterval(t)
                    f('faye-boosting:updateTime', {
                      props: e,
                      counter: K,
                    })
                  })(t)
                }
              },
              [W]
            )
            Object(c.useEffect)(function () {
              window.addEventListener('message', function (e) {
                e.data && ce(e.data)
              })
            }, [])
            var ce = function (t) {
                'UpdateValueUI' === t.action &&
                  ('SetDisableButtons' === t.app
                    ? _(false)
                    : 'RemoveContractInfo' === t.app &&
                      t.data.IdToRemove === e.id &&
                      a(false))
              },
              se = function (e) {
                J(e.target.value)
              },
              ae = function () {
                y(true)
                O(true)
              },
              ie = function () {
                E(true)
                y(true)
              },
              oe = function () {
                y(false)
                E(false)
                P(false)
                R(false)
                O(false)
              },
              re = function (e) {
                E(false)
                y(true)
                P(true)
                R(e)
              },
              le = Object(m.a)({
                root: {
                  '& .MuiInput-underline:after': { borderBottomColor: 'white' },
                  '& .MuiInput-underline:before': { borderBottomColor: 'white' },
                  '& .MuiInput-underline:hover:not(.Mui-focused):before': {
                    borderBottomColor: 'white',
                  },
                  '& .MuiInputBase-root': { color: 'white' },
                },
              })()
            return Object(l.jsx)(l.Fragment, {
              children:
                s &&
                Object(l.jsxs)('div', {
                  className: 'ContractsInformationContainter',
                  children: [
                    Object(l.jsx)(b.a, {
                      direction: 'down',
                      in: j,
                      mountOnEnter: true,
                      unmountOnExit: true,
                      children: Object(l.jsxs)('div', {
                        className: 'setInputZone',
                        children: [
                          Object(l.jsx)('button', {
                            className: 'closeRemove',
                            style: {
                              left: '85%',
                              top: '-60px',
                            },
                            onClick: oe,
                            children: Object(l.jsx)('i', {
                              className: 'fas fa-times',
                              style: { color: 'white' },
                            }),
                          }),
                          Object(l.jsx)('div', {
                            className: 'transferinfo',
                            children:
                              'Are you sure you want to transfer the contract?',
                          }),
                          Object(l.jsx)('div', {
                            className: 'submitfix',
                            children: Object(l.jsx)('form', {
                              onSubmit: function (t) {
                                t.preventDefault()
                                z.trim().length > 0 &&
                                  (O(false),
                                  a(false),
                                  f('faye-boosting:transferContract', {
                                    props: e,
                                    imputValue: z,
                                  }))
                              },
                              autoComplete: 'off',
                              children: Object(l.jsx)(
                                u.a,
                                {
                                  className: 'textfix',
                                  id: 'input-with-icon-textfield',
                                  label: 'Enter ID',
                                  classes: le,
                                  onChange: se,
                                  InputLabelProps: { style: { color: 'white' } },
                                  InputProps: {
                                    startAdornment: Object(l.jsx)(d.a, {
                                      position: 'start',
                                      children: Object(l.jsx)('i', {
                                        className: 'fas fa-people-arrows',
                                        style: { color: 'white' },
                                      }),
                                    }),
                                  },
                                  variant: 'standard',
                                },
                                se
                              ),
                            }),
                          }),
                        ],
                      }),
                    }),
                    Object(l.jsx)(b.a, {
                      direction: 'down',
                      in: x,
                      mountOnEnter: true,
                      unmountOnExit: true,
                      children: Object(l.jsxs)('div', {
                        className: 'startContracZone',
                        children: [
                          Object(l.jsx)('h1', { children: 'Starting Contract' }),
                          Object(l.jsx)('div', {
                            className: 'inLoad',
                            children: Object(l.jsx)('img', {
                              alt: 'img',
                              src: 'https://c.tenor.com/I6kN-6X7nhAAAAAj/loading-buffering.gif',
                              width: '64',
                              height: '64',
                            }),
                          }),
                        ],
                      }),
                    }),
                    C
                      ? Object(l.jsx)(l.Fragment, {})
                      : Object(l.jsxs)(l.Fragment, {
                          children: [
                            Object(l.jsx)('div', {
                              className: 'typeContainer',
                              children: Object(l.jsx)('span', {
                                className: 'typeReal',
                                children: ''.concat(e.type),
                              }),
                            }),
                            Object(l.jsxs)('div', {
                              className: 'infoContainer1',
                              children: [
                                Object(l.jsx)('div', {
                                  style: { marginTop: '4%' },
                                  children: ''.concat(e.owner),
                                }),
                                Object(l.jsx)('div', {
                                  style: { marginTop: '4%' },
                                  children: Object(l.jsx)('b', {
                                    children: ''.concat(e.vehicle),
                                  }),
                                }),
                                Object(l.jsx)('div', {
                                  style: { marginTop: '4%' },
                                  children: 'Buy in: '.concat(e.units, ' GNE'),
                                }),
                                Object(l.jsxs)('div', {
                                  style: { marginTop: '4%' },
                                  children: [
                                    'Expires in:',
                                    Object(l.jsx)('span', {
                                      style: { color: 'green' },
                                      children: Object(l.jsxs)('span', {
                                        children: [
                                          ' ',
                                          ''
                                            .concat(
                                              Math.floor(Math.round(K) / 3600),
                                              'h '
                                            )
                                            .concat(
                                              Math.floor(
                                                (Math.round(K) % 3600) / 60
                                              ),
                                              'm '
                                            )
                                            .concat(
                                              Math.ceil(
                                                (Math.round(K) % 3600) % 60
                                              ),
                                              's'
                                            ),
                                        ],
                                      }),
                                    }),
                                  ],
                                }),
                              ],
                            }),
                            Object(l.jsx)('div', {
                              className: 'buttonContractsInformationContainer',
                              children: e.status
                                ? Object(l.jsxs)(l.Fragment, {
                                    children: [
                                      Object(l.jsx)('button', {
                                        disabled: true,
                                        onClick: ie,
                                        className: 'DisabledButtons',
                                        children: 'Contract In Progress',
                                      }),
                                      Object(l.jsx)('button', {
                                        disabled: true,
                                        onClick: ae,
                                        className: 'DisabledButtons',
                                        children: 'Transfer Contract',
                                      }),
                                      Object(l.jsx)('button', {
                                        onClick: function () {
                                          f('faye-boosting:cancelContract', {
                                            props: e,
                                            IsInProgress: U,
                                          })
                                          a(false)
                                        },
                                        className: 'CancelButton',
                                        children: 'Cancel Contract',
                                      }),
                                    ],
                                  })
                                : Object(l.jsxs)(l.Fragment, {
                                    children: [
                                      Object(l.jsx)('button', {
                                        disabled: e.disableButtons,
                                        onClick: ie,
                                        className: 'ContractsButon',
                                        children: 'Start Contract',
                                      }),
                                      Object(l.jsx)('button', {
                                        disabled: e.disableButtons,
                                        onClick: ae,
                                        className: 'ContractsButon',
                                        children: 'Transfer Contract',
                                      }),
                                      Object(l.jsx)('button', {
                                        disabled: e.disableButtons,
                                        onClick: function () {
                                          f('faye-boosting:DeclineContract', {
                                            props: e,
                                            IsInProgress: U,
                                          })
                                          a(false)
                                        },
                                        className: 'ContractsButon',
                                        children: 'Decline Contract',
                                      }),
                                    ],
                                  }),
                            }),
                          ],
                        }),
                    B
                      ? Object(l.jsxs)(l.Fragment, {
                          children: [
                            Object(l.jsx)('button', {
                              className: 'closeRemove',
                              onClick: oe,
                              children: Object(l.jsx)('i', {
                                className: 'fas fa-times',
                                style: { color: 'white' },
                              }),
                            }),
                            Object(l.jsxs)('div', {
                              className: 'infoContainer1',
                              children: [
                                Object(l.jsx)('div', {
                                  style: {
                                    marginTop: '4%',
                                    fontSize: '20px',
                                  },
                                  children: Object(l.jsx)('b', {
                                    children: 'Select Type',
                                  }),
                                }),
                                Object(l.jsx)('div', {
                                  style: {
                                    marginTop: '4%',
                                    fontSize: '0.9rem',
                                    color: '#a1a1a1',
                                  },
                                  children:
                                    'If you choose vin scratch it will cost and additional '.concat(
                                      e.ExtraVin,
                                      ' GNE to claim ownership.'
                                    ),
                                }),
                                Object(l.jsx)('button', {
                                  onClick: function () {
                                    re(true)
                                  },
                                  className: 'ContractsButon',
                                  style: {
                                    top: '25px',
                                    left: '0%',
                                  },
                                  children: 'Vin Scratch',
                                }),
                                Object(l.jsx)('button', {
                                  onClick: function () {
                                    re(false)
                                  },
                                  className: 'ContractsButon',
                                  style: {
                                    top: '25px',
                                    left: '0%',
                                  },
                                  children: 'Normal Dropoff',
                                }),
                              ],
                            }),
                          ],
                        })
                      : Object(l.jsx)(l.Fragment, {}),
                    T
                      ? Object(l.jsx)(l.Fragment, {
                          children: Object(l.jsxs)('div', {
                            className: 'infoContainer1',
                            children: [
                              Object(l.jsx)('div', {
                                style: {
                                  marginTop: '4%',
                                  fontSize: '20px',
                                },
                                children: Object(l.jsx)('b', {
                                  children: 'Start Contract?',
                                }),
                              }),
                              Object(l.jsx)('button', {
                                onClick: function () {
                                  O(false)
                                  g(true)
                                  P(false)
                                  ne(true)
                                  setTimeout(function () {
                                    y(false)
                                    g(false)
                                    f('faye-boosting:startContract', {
                                      props: e,
                                      IsVin: M,
                                    }).then(function (t) {
                                      t.Contract
                                        ? (_(true), e.AffectArray(e.id))
                                        : (ne(false), _(false))
                                    })
                                  }, 3000)
                                },
                                className: 'ContractsButon',
                                style: {
                                  top: '25px',
                                  left: '0%',
                                },
                                children: 'Continue',
                              }),
                              Object(l.jsx)('button', {
                                onClick: oe,
                                className: 'ContractsButon',
                                style: {
                                  top: '25px',
                                  left: '0%',
                                },
                                children: 'Cancel',
                              }),
                            ],
                          }),
                        })
                      : Object(l.jsx)(l.Fragment, {}),
                  ],
                }),
            })
          },
          N = n(52),
          C = n.n(N),
          y = s.a.memo(function (e) {
            var t = e.counter,
              n = e.setCounter,
              s = Object(c.useRef)(),
              a = Object(c.useState)([]),
              i = Object(o.a)(a, 2),
              b = i[0],
              u = i[1],
              d = Object(c.useState)(false),
              m = Object(o.a)(d, 2),
              O = m[0],
              p = m[1],
              h = Object(c.useState)(false),
              x = Object(o.a)(h, 2),
              g = x[0],
              N = x[1],
              y = Object(c.useState)(80),
              w = Object(o.a)(y, 2),
              S = w[0],
              B = w[1],
              E = Object(c.useState)(0),
              I = Object(o.a)(E, 2),
              k = I[0],
              T = I[1],
              P = Object(c.useState)('A'),
              A = Object(o.a)(P, 2),
              L = A[0],
              M = A[1],
              R = Object(c.useState)('B'),
              G = Object(o.a)(R, 2),
              F = G[0],
              U = G[1],
              _ = function (e) {
                var t = Object(r.a)(b),
                  n = t.findIndex(function (t) {
                    return t.id === e
                  })
                t[n].status = true
                u(t)
              }
            Object(c.useEffect)(function () {
              window.addEventListener('message', function (e) {
                var t
                e.data &&
                  'UpdateValueUI' === (t = e.data).action &&
                  ('ContractsBoosting' === t.app
                    ? u(function (e) {
                        return [].concat(Object(r.a)(e), [t.data.contracts])
                      })
                    : 'SetBoostingLevel' === t.app
                    ? (M(t.data.type1), U(t.data.type2), B(t.data.level))
                    : 'SetDisableButtons' === t.app
                    ? p(t.data.enableButtons)
                    : 'SetExtraVin' === t.app && T(t.data.ExtraVin))
              })
            }, [])
            var V = function (e) {
              N(e)
              f('faye-boosting:JoinQueue', { queue: e })
            }
            return Object(l.jsx)('div', {
              children: Object(l.jsx)(C.a, {
                defaultPosition: {
                  x: 120,
                  y: 60,
                },
                ref: s,
                children: Object(l.jsx)('div', {
                  className: t ? '' : 'hiddenComponent',
                  children: Object(l.jsxs)('div', {
                    className: 'browser1',
                    ref: s,
                    children: [
                      Object(l.jsxs)('div', {
                        className: 'boosting-b-buttons',
                        children: [
                          Object(l.jsx)('div', {
                            className: 'texto boosting-text',
                            children: 'Boosting Contracts',
                          }),
                          Object(l.jsxs)('div', {
                            className: 'boosting-close-container',
                            children: [
                              Object(l.jsx)(
                                'button',
                                { className: 'btn min-btn' },
                                'cmin-btn'
                              ),
                              Object(l.jsx)(
                                'button',
                                {
                                  className: 'btn close-btn',
                                  onClick: function () {
                                    n(false)
                                  },
                                },
                                'cclose-btn'
                              ),
                            ],
                          }),
                        ],
                      }),
                      Object(l.jsxs)('div', {
                        className: 'boostin-buttons',
                        children: [
                          Object(l.jsx)(
                            'button',
                            {
                              disabled: O,
                              className: 'butMycontracts',
                              children: 'MY CONTRACTS',
                            },
                            'ContractOpen1'
                          ),
                          g
                            ? Object(l.jsx)(
                                'button',
                                {
                                  onClick: function () {
                                    return V(false)
                                  },
                                  className: 'butMyqueue',
                                  children: 'LEAVE QUEUE',
                                },
                                'ContractOpen2'
                              )
                            : Object(l.jsx)(
                                'button',
                                {
                                  onClick: function () {
                                    return V(true)
                                  },
                                  disabled: O,
                                  className: 'butMyqueue',
                                  children: 'JOIN QUEUE',
                                },
                                'ContractOpen3'
                              ),
                        ],
                      }),
                      Object(l.jsx)('div', {
                        className: 'gholsi',
                        children: Object(l.jsxs)('div', {
                          className: 'contracts_container',
                          children: [
                            Object(l.jsx)(j, { completed: S }),
                            Object(l.jsx)('div', {
                              className: 'levelProggres1',
                              children: L,
                            }),
                            Object(l.jsx)('span', {
                              className: 'levelProggres2',
                              children: F,
                            }),
                            Object(l.jsx)('div', {
                              className: 'contractsContainers',
                              children: b.map(function (e) {
                                return Object(l.jsx)(v, {
                                  disableButtons: O,
                                  id: e.id,
                                  vehicle: e.vehicle,
                                  type: e.type,
                                  owner: e.owner,
                                  expires: e.expires,
                                  units: e.units,
                                  coords: e.coords,
                                  identifier: e.identifier,
                                  status: e.status,
                                  ExtraVin: k,
                                  AffectArray: _,
                                })
                              }),
                            }),
                          ],
                        }),
                      }),
                    ],
                  }),
                }),
              }),
            })
          }),
          w = function (e) {
            var t = e.props,
              n = Object(c.useState)(true),
              s = Object(o.a)(n, 2),
              a = s[0],
              i = s[1]
            return (
              setTimeout(function () {
                i(false)
              }, 3500),
              Object(l.jsx)(b.a, {
                direction: 'left',
                in: a,
                mountOnEnter: true,
                unmountOnExit: true,
                children: Object(l.jsxs)('div', {
                  className: 'NotificationBack2',
                  children: [
                    Object(l.jsxs)('div', {
                      className: 'NotiText',
                      children: [
                        Object(l.jsx)('span', {
                          children: Object(l.jsx)('b', {
                            children: ''.concat(t.app),
                          }),
                        }),
                        Object(l.jsx)('div', {
                          style: { marginTop: '3px' },
                          children: t.msg,
                        }),
                      ],
                    }),
                    Object(l.jsx)('div', {
                      className: 'NotiIcon',
                      children: Object(l.jsx)('img', {
                        alt: 'img',
                        src: t.img,
                        height: 32,
                        width: 32,
                      }),
                    }),
                  ],
                }),
              })
            )
          },
          S = function (e) {
            var t = e.counter,
              n = e.setCounter,
              s = new Audio(
                'https://freesound.org/data/previews/434/434379_6965625-lq.mp3'
              ),
              a = Object(c.useRef)(),
              i = Object(c.useState)([]),
              j = Object(o.a)(i, 2),
              u = j[0],
              d = j[1],
              m = Object(c.useState)([]),
              O = Object(o.a)(m, 2),
              p = O[0],
              h = O[1]
            Object(c.useEffect)(
              function () {
                var e = function (e) {
                  t && a.current && !a.current.contains(e.target) && n(false)
                }
                return (
                  document.addEventListener('mousedown', e),
                  function () {
                    document.removeEventListener('mousedown', e)
                  }
                )
              },
              [t, n]
            )
            return (
              Object(c.useEffect)(function () {
                window.addEventListener('message', function (e) {
                  var t
                  e.data &&
                    'UpdateValueUI' === (t = e.data).action &&
                    'BoostingNotification' === t.app &&
                    (JSON.parse(localStorage.getItem('popaudio')).pop && s.play(),
                    d(function (e) {
                      return [].concat(Object(r.a)(e), [t.data.notify])
                    }),
                    h(function (e) {
                      return [].concat(Object(r.a)(e), [t.data.notify])
                    }))
                })
              }, []),
              Object(l.jsxs)('div', {
                children: [
                  Object(l.jsx)(b.a, {
                    direction: 'left',
                    in: t,
                    mountOnEnter: true,
                    unmountOnExit: true,
                    timeout: 250,
                    children: Object(l.jsxs)('div', {
                      className: 'notificationContainer',
                      ref: a,
                      children: [
                        Object(l.jsx)('div', {
                          className: 'texto notification-text',
                          children: 'Notifications',
                        }),
                        Object(l.jsx)('div', {
                          className: 'nContainer',
                          children: u.map(function (e) {
                            return Object(l.jsxs)('div', {
                              className: 'NotificationBack',
                              children: [
                                Object(l.jsxs)('div', {
                                  className: 'NotiText',
                                  children: [
                                    Object(l.jsx)('span', {
                                      children: Object(l.jsx)('b', {
                                        children: ''.concat(e.app),
                                      }),
                                    }),
                                    Object(l.jsx)('div', {
                                      style: { marginTop: '3px' },
                                      children: e.msg,
                                    }),
                                  ],
                                }),
                                Object(l.jsx)('div', {
                                  className: 'NotiIcon',
                                  children: Object(l.jsx)('img', {
                                    alt: 'img',
                                    src: e.img,
                                    height: 32,
                                    width: 32,
                                  }),
                                }),
                              ],
                            })
                          }),
                        }),
                      ],
                    }),
                  }),
                  Object(l.jsx)('div', {
                    className: 'remove',
                    children: p.map(function (e) {
                      return Object(l.jsx)(w, {
                        props: e,
                        OutNotifications: p,
                        setOutNotifications: h,
                      })
                    }),
                  }),
                ],
              })
            )
          },
          B = n(244),
          E = n(240),
          I = n(247),
          k = [
            {
              name: 'Ferrar',
              url: 'https://imgur.com/wgUqskt.png',
            },
            {
              name: 'Yung',
              url: 'https://imgur.com/1KFfsh7.png',
            },
            {
              name: 'Dirft',
              url: 'https://cdnb.artstation.com/p/assets/images/images/003/233/947/4k/khyzyl-saleem-gtr2017nismo.jpg',
            },
            {
              name: 'GTR',
              url: 'https://imgur.com/ifTiZfC.jpg',
            },
            {
              name: 'AMG',
              url: 'https://imgur.com/K6mwCI1.png',
            },
            {
              name: 'R34',
              url: 'https://cdnb.artstation.com/p/assets/images/images/033/476/155/4k/christophe-desse-3.jpg',
            },
            {
              name: 'Lambo',
              url: 'https://cdna.artstation.com/p/assets/images/images/001/667/318/large/khyzyl-saleem-rapideeditfinallow.jpg',
            },
            {
              name: 'R342',
              url: 'https://imgur.com/aLaieBN.png',
            },
            {
              name: 'MCLAREN',
              url: 'https://imgur.com/UN94OX0.png',
            },
            {
              name: 'bmw',
              url: 'https://imgur.com/x1UPjBm.png',
            },
            {
              name: 'MCLAREN2',
              url: 'https://imgur.com/MxoBDb4.png',
            },
            {
              name: 'carrito',
              url: 'https://imgur.com/WYtC6YK.jpg',
            },
          ],
          T = function (e) {
            var t = e.counter,
              n = e.setCounter,
              s = e.setWallpaper,
              a = Object(c.useRef)(),
              i = Object(c.useRef)(),
              r = Object(c.useState)(function () {
                return (
                  JSON.parse(localStorage.getItem('popaudio')) || { pop: true }
                )
              }),
              j = Object(o.a)(r, 2),
              O = j[0],
              p = j[1],
              h = Object(c.useState)(''),
              x = Object(o.a)(h, 2),
              f = x[0],
              g = x[1],
              v = Object(c.useState)(false),
              N = Object(o.a)(v, 2),
              C = N[0],
              y = N[1],
              w = function (e) {
                g(e.target.value)
              }
            Object(c.useEffect)(
              function () {
                localStorage.setItem('popaudio', JSON.stringify(O))
              },
              [O]
            )
            Object(c.useEffect)(
              function () {
                var e = function (e) {
                  t && a.current && !a.current.contains(e.target) && n(false)
                }
                return (
                  document.addEventListener('mousedown', e),
                  function () {
                    document.removeEventListener('mousedown', e)
                  }
                )
              },
              [t, n]
            )
            Object(c.useEffect)(
              function () {
                var e = function (e) {
                  C && i.current && !i.current.contains(e.target) && y(false)
                }
                return (
                  document.addEventListener('mousedown', e),
                  function () {
                    document.removeEventListener('mousedown', e)
                  }
                )
              },
              [C, y]
            )
            var S = Object(m.a)({
              root: {
                '& .MuiInput-underline:after': { borderBottomColor: 'grey' },
                '& .MuiInput-underline:before': { borderBottomColor: 'grey' },
                '& .MuiInput-underline:hover:not(.Mui-focused):before': {
                  borderBottomColor: 'grey',
                },
                '& .MuiInputBase-root': { color: 'grey' },
              },
            })()
            return Object(l.jsxs)('div', {
              children: [
                Object(l.jsx)(b.a, {
                  direction: 'left',
                  in: t,
                  mountOnEnter: true,
                  unmountOnExit: true,
                  timeout: 250,
                  children: Object(l.jsxs)('div', {
                    className: 'settingsContainer',
                    ref: a,
                    children: [
                      Object(l.jsx)('div', {
                        className: 'texto settings-text',
                        children: 'Settings',
                      }),
                      Object(l.jsx)('form', {
                        onSubmit: function (e) {
                          e.preventDefault()
                          f.trim().length > 10 && s(f)
                        },
                        autoComplete: 'off',
                        children: Object(l.jsx)(
                          u.a,
                          {
                            className: 'textfix',
                            id: 'input-with-icon-textfield',
                            label: 'Enter Background',
                            classes: S,
                            InputLabelProps: { style: { color: 'white' } },
                            onChange: w,
                            InputProps: {
                              startAdornment: Object(l.jsx)(d.a, {
                                position: 'start',
                                children: Object(l.jsx)('i', {
                                  className: 'fas fa-photo-video',
                                  style: { color: 'white' },
                                }),
                              }),
                            },
                            variant: 'standard',
                          },
                          w
                        ),
                      }),
                      Object(l.jsxs)('div', {
                        className: 'btnfix',
                        children: [
                          Object(l.jsxs)('label', {
                            htmlFor: 'contained-button-file',
                            children: [
                              Object(l.jsx)(B.a, {
                                variant: 'contained',
                                component: 'span',
                                sx: {
                                  bgcolor: 'rgb(19, 85, 167)',
                                  fontSize: '0.8125rem',
                                  ':hover': {
                                    bgcolor: '#69a74f',
                                    color: 'white',
                                  },
                                },
                                onClick: function () {},
                                children: 'SAVE',
                              }),
                              Object(l.jsx)(B.a, {
                                variant: 'contained',
                                component: 'span',
                                className: 'fixbtn2',
                                sx: {
                                  bgcolor: 'rgb(19, 85, 167)',
                                  fontSize: '0.8125rem',
                                  ':hover': {
                                    bgcolor: '#69a74f',
                                    color: 'white',
                                  },
                                },
                                onClick: function () {
                                  n(false)
                                  y(true)
                                },
                                children: 'PRESETS',
                              }),
                            ],
                          }),
                          Object(l.jsx)('div', {
                            className: 'checkboxFix',
                            children: Object(l.jsx)(I.a, {
                              control: Object(l.jsx)(E.a, {
                                checked: O.pop,
                                onChange: function (e) {
                                  p({ pop: e.target.checked })
                                },
                                style: { color: '#F2A365' },
                              }),
                              color: 'primary',
                              label: Object(l.jsx)('span', {
                                style: { color: 'white' },
                                children: 'Notification Audio',
                              }),
                            }),
                          }),
                        ],
                      }),
                    ],
                  }),
                }),
                Object(l.jsx)(b.a, {
                  direction: 'up',
                  in: C,
                  mountOnEnter: true,
                  unmountOnExit: true,
                  timeout: 250,
                  children: Object(l.jsxs)('div', {
                    className: 'PresetsContainer',
                    ref: i,
                    children: [
                      Object(l.jsx)('div', {
                        className: 'texto settings-config ',
                        children: 'Preset Backgrounds',
                      }),
                      Object(l.jsx)('div', {
                        className: 'bgPresetsContainer',
                        children: k.map(function (e) {
                          return Object(l.jsx)(
                            'button',
                            {
                              onClick: function () {
                                return s(e.url)
                              },
                              className: 'bgButton',
                              children: Object(l.jsx)('img', {
                                alt: 'img',
                                src: e.url,
                                className: 'bgcontainer',
                              }),
                            },
                            e.url
                          )
                        }),
                      }),
                    ],
                  }),
                }),
              ],
            })
          },
          P = function (e) {
            var t = e.icon,
              n = e.label,
              s = e.price,
              a = e.item,
              i = e.GenCounter,
              j = e.SetGenCounter,
              b = e.SetCartItems,
              u = e.ToPay,
              d = e.SetToPay,
              m = Object(c.useState)(0),
              O = Object(o.a)(m, 2),
              p = O[0],
              h = O[1]
            return Object(l.jsxs)('div', {
              className: 'bennysItems',
              children: [
                p > 0
                  ? Object(l.jsx)('button', {
                      className: 'CounterBennys',
                      children: p,
                    })
                  : Object(l.jsx)(l.Fragment, {}),
                Object(l.jsx)('div', {
                  className: 'bennysIcon',
                  children: Object(l.jsx)('img', {
                    alt: 'img',
                    src: t,
                    style: { left: '-50px' },
                  }),
                }),
                Object(l.jsxs)('div', {
                  className: 'BennysText',
                  children: [
                    Object(l.jsx)('p', { children: n }),
                    Object(l.jsx)('p', { children: 'Price: '.concat(s, ' GNE') }),
                  ],
                }),
                Object(l.jsx)('button', {
                  className: 'BennysAddCartBTN',
                  onClick: function () {
                    h(p + 1)
                    j(i + 1)
                    d(u + s)
                    b(function (e) {
                      return [
                        {
                          label: n,
                          item: a,
                          price: s,
                          icon: t,
                          index: i + 1,
                        },
                      ].concat(Object(r.a)(e))
                    })
                  },
                  children: 'ADD TO CART',
                }),
              ],
            })
          },
          A = s.a.memo(function (e) {
            var t = e.counter,
              n = e.setCounter,
              s = Object(c.useRef)(),
              a = Object(c.useState)(0),
              i = Object(o.a)(a, 2),
              j = i[0],
              b = i[1],
              u = Object(c.useState)(0),
              d = Object(o.a)(u, 2),
              m = d[0],
              O = d[1],
              p = Object(c.useState)(false),
              h = Object(o.a)(p, 2),
              x = h[0],
              g = h[1],
              v = Object(c.useState)(false),
              N = Object(o.a)(v, 2),
              y = N[0],
              w = N[1],
              S = Object(c.useState)(false),
              B = Object(o.a)(S, 2),
              E = B[0],
              I = B[1],
              k = Object(c.useState)(false),
              T = Object(o.a)(k, 2),
              A = T[0],
              L = T[1],
              M = Object(c.useState)([]),
              R = Object(o.a)(M, 2),
              G = R[0],
              F = R[1],
              U = Object(c.useState)([]),
              _ = Object(o.a)(U, 2),
              V = _[0],
              D = _[1],
              z = Object(c.useState)([]),
              J = Object(o.a)(z, 2),
              q = J[0],
              Y = J[1],
              K = Object(c.useState)([]),
              X = Object(o.a)(K, 2),
              Z = X[0],
              Q = X[1],
              W = Object(c.useState)([]),
              H = Object(o.a)(W, 2),
              $ = H[0],
              ee = H[1],
              te = Object(c.useState)([]),
              ne = Object(o.a)(te, 2),
              ce = ne[0],
              se = ne[1],
              ae = Object(c.useState)([]),
              ie = Object(o.a)(ae, 2),
              oe = ie[0],
              re = ie[1],
              le = Object(c.useState)(true),
              je = Object(o.a)(le, 2),
              be = je[0],
              ue = je[1],
              de = Object(c.useState)(true),
              me = Object(o.a)(de, 2),
              Oe = me[0],
              pe = me[1],
              he = Object(c.useState)(true),
              xe = Object(o.a)(he, 2),
              fe = xe[0],
              ge = xe[1]
            Object(c.useEffect)(function () {
              window.addEventListener('message', function (e) {
                var t
                e.data &&
                  'UpdateValueUI' === (t = e.data).action &&
                  ('SetConsumableItems' === t.app
                    ? (Q(t.data.ConsumableItems), ge(t.data.enable))
                    : 'SetPerformanceObject' === t.app
                    ? (ee(t.data.PerformanceObject), ue(t.data.enable))
                    : 'SetCosmeticObject' === t.app &&
                      (se(t.data.CosmeticObject), pe(t.data.enable)))
              })
            }, [])
            return Object(l.jsx)('div', {
              children: Object(l.jsx)(C.a, {
                defaultPosition: {
                  x: 120,
                  y: 60,
                },
                children: Object(l.jsx)('div', {
                  className: t ? '' : 'hiddenComponent',
                  children: Object(l.jsxs)('div', {
                    className: 'BennysApp',
                    children: [
                      Object(l.jsxs)('div', {
                        className: 'boosting-bb-buttons',
                        ref: s,
                        children: [
                          Object(l.jsx)('div', {
                            className: 'texto boosting-text',
                            children: 'Bennys Online Shop',
                          }),
                          Object(l.jsxs)('div', {
                            className: 'boosting-close-container',
                            children: [
                              Object(l.jsx)(
                                'button',
                                { className: 'btn min-btn' },
                                'cmin-btn'
                              ),
                              Object(l.jsx)(
                                'button',
                                {
                                  className: 'btn close-btn',
                                  onClick: function () {
                                    n(false)
                                  },
                                },
                                'cclose-btn'
                              ),
                            ],
                          }),
                        ],
                      }),
                      Oe &&
                        Object(l.jsx)(
                          'button',
                          {
                            className: E ? 'ButBennys' : 'ButBennys2',
                            onClick: function () {
                              I(true)
                              w(false)
                              g(false)
                              L(false)
                              Y(ce)
                            },
                            children: 'COSMETIC PARTS',
                          },
                          'Cometic3'
                        ),
                      be &&
                        Object(l.jsx)(
                          'button',
                          {
                            className: y ? 'ButBennys' : 'ButBennys2',
                            onClick: function () {
                              w(true)
                              g(false)
                              I(false)
                              L(false)
                              D($)
                            },
                            children: 'PERFORMANCE PARTS',
                          },
                          'Performance3'
                        ),
                      fe &&
                        Object(l.jsx)(
                          'button',
                          {
                            className: x ? 'ButBennys' : 'ButBennys2',
                            onClick: function () {
                              g(true)
                              w(false)
                              I(false)
                              L(false)
                              F(Z)
                            },
                            children: 'CONSUMABLE PARTS',
                          },
                          'Consumable3'
                        ),
                      Object(l.jsxs)(
                        'button',
                        {
                          className: 'CarritoBennys',
                          onClick: function () {
                            I(false)
                            w(false)
                            g(false)
                            L(true)
                            Y(ce)
                          },
                          children: [
                            Object(l.jsx)('i', {
                              className: 'fa-solid fa-cart-shopping',
                              style: { color: 'white' },
                            }),
                            'CART',
                            Object(l.jsx)('button', {
                              className: 'CounterBennysItems',
                              children: j,
                            }),
                          ],
                        },
                        'Consumable4'
                      ),
                      Object(l.jsx)('input', {
                        className: 'InputBennys',
                        onChange: function (e) {
                          var t,
                            n =
                              ((t = e.target.value),
                              x
                                ? Z.filter(function (e) {
                                    return e.item
                                      .toLowerCase()
                                      .includes(t.toLowerCase())
                                  })
                                : performance
                                ? $.filter(function (e) {
                                    return e.item
                                      .toLowerCase()
                                      .includes(t.toLowerCase())
                                  })
                                : E
                                ? ce.filter(function (e) {
                                    return e.item
                                      .toLowerCase()
                                      .includes(t.toLowerCase())
                                  })
                                : void 0)
                          x ? F(n) : performance ? D(n) : E && Y(n)
                        },
                        placeholder: ' Search',
                        style: {
                          color: 'white',
                          fontSize: '12px',
                        },
                      }),
                      Object(l.jsxs)('div', {
                        className: 'bennysContainer',
                        children: [
                          x &&
                            G.map(function (e) {
                              return Object(l.jsx)(P, {
                                icon: e.icon,
                                label: e.label,
                                price: e.price,
                                item: e.item,
                                GenCounter: j,
                                SetGenCounter: b,
                                SetCartItems: re,
                                ToPay: m,
                                SetToPay: O,
                              })
                            }),
                          y &&
                            V.map(function (e) {
                              return Object(l.jsx)(P, {
                                icon: e.icon,
                                label: e.label,
                                price: e.price,
                                item: e.item,
                                GenCounter: j,
                                SetGenCounter: b,
                                SetCartItems: re,
                                ToPay: m,
                                SetToPay: O,
                              })
                            }),
                          E &&
                            q.map(function (e) {
                              return Object(l.jsx)(P, {
                                icon: e.icon,
                                label: e.label,
                                price: e.price,
                                item: e.item,
                                GenCounter: j,
                                SetGenCounter: b,
                                SetCartItems: re,
                                ToPay: m,
                                SetToPay: O,
                              })
                            }),
                          A &&
                            oe.map(function (e) {
                              return Object(l.jsxs)('div', {
                                className: 'bennysItemsCart',
                                children: [
                                  Object(l.jsx)('div', {
                                    className: 'bennysItemIcon',
                                    children: Object(l.jsx)('img', {
                                      alt: 'img',
                                      src: e.icon,
                                      style: {},
                                      width: 32,
                                      height: 32,
                                    }),
                                  }),
                                  Object(l.jsx)('p', {
                                    className: 'CartItemText',
                                    children: '- '
                                      .concat(e.label, '(1x) - ')
                                      .concat(e.price, ' GNE'),
                                  }),
                                  Object(l.jsx)(
                                    'button',
                                    {
                                      className: 'ButBennysCart',
                                      onClick: function () {
                                        return (function (e) {
                                          b(j - 1)
                                          O(m - e.price)
                                          re(function (t) {
                                            var n = Object(r.a)(t),
                                              c = n.findIndex(function (t) {
                                                return t.index === e.index
                                              })
                                            return n.splice(c, 1), n
                                          })
                                        })(e)
                                      },
                                      children: 'REMOVE ITEM',
                                    },
                                    'CartItems'
                                  ),
                                ],
                              })
                            }),
                          A &&
                            Object(l.jsx)(l.Fragment, {
                              children: Object(l.jsxs)('div', {
                                className: 'CartCheckout',
                                children: [
                                  Object(l.jsx)('p', {
                                    className: 'CheckoutText',
                                    children: 'Total '.concat(m, ' GNE'),
                                  }),
                                  Object(l.jsx)(
                                    'button',
                                    {
                                      className: 'CheckOut',
                                      onClick: function () {
                                        f('faye-boosting:BennysItem', {
                                          CartItems: oe,
                                          ToPay: m,
                                        }).then(function (e) {
                                          e.Continue && (re([]), b(0), O(0))
                                        })
                                      },
                                      children: 'CHECKOUT',
                                    },
                                    'CartItems'
                                  ),
                                ],
                              }),
                            }),
                        ],
                      }),
                    ],
                  }),
                }),
              }),
            })
          }),
          L = n.p + 'static/media/cog.540ab5dc.svg',
          M = n.p + 'static/media/comment.c11482d5.svg',
          R = n.p + 'static/media/wifi.71ec6722.svg',
          G = n(234),
          F = n(241),
          U = n(238),
          _ = n(237),
          V = function (e) {
            var t = e.counter,
              n = e.setCounter,
              s = Object(c.useState)(true),
              a = Object(o.a)(s, 2),
              i = a[0],
              r = a[1],
              j = Object(c.useState)({
                open: false,
                page: 'https://google.com',
                id: 'google',
              }),
              b = Object(o.a)(j, 2),
              u = b[0],
              d = b[1],
              m = Object(c.useState)(''),
              O = Object(o.a)(m, 2),
              p = O[0],
              h = O[1],
              x = Object(c.useState)(0),
              g = Object(o.a)(x, 2),
              v = g[0],
              N = g[1],
              y = Object(c.useState)(0),
              w = Object(o.a)(y, 2),
              S = w[0],
              B = w[1],
              E = function (e) {
                h(e.target.value)
              }
            Object(c.useEffect)(function () {
              window.addEventListener('message', function (e) {
                var t
                e.data &&
                  'UpdateValueUI' === (t = e.data).action &&
                  ('SetBoostingLevel' === t.app
                    ? N(t.data.gne)
                    : 'UpdateGnes' === t.app
                    ? B(t.data.gne)
                    : 'EnableApps' === t.app && r(t.data.BuyApp))
              })
            }, [])
            var I = Object(_.a)({
              root: {
                '& .MuiInput-underline:after': { borderBottomColor: 'white' },
                '& .MuiInput-underline:before': { borderBottomColor: 'white' },
                '& .MuiInput-underline:hover:not(.Mui-focused):before': {
                  borderBottomColor: 'white',
                },
                '& .MuiInputBase-root': { color: 'white' },
              },
            })()
            return Object(l.jsx)('div', {
              children: Object(l.jsx)(C.a, {
                defaultPosition: {
                  x: 120,
                  y: 60,
                },
                children: Object(l.jsx)('div', {
                  className: t ? '' : 'hiddenComponent',
                  children: Object(l.jsxs)('div', {
                    className: 'GneFinance',
                    children: [
                      Object(l.jsxs)('div', {
                        className: 'browser-b-buttons',
                        children: [
                          Object(l.jsxs)('div', {
                            className: 'browser_tab',
                            onClick: function () {
                              i &&
                                d({
                                  open: true,
                                  page: 'https://gne.com',
                                  id: 'gne',
                                })
                            },
                            children: [
                              Object(l.jsx)('img', {
                                src: 'https://imgur.com/O10Rx0A.png',
                                style: { marginRight: '0.5rem' },
                                alt: 'img',
                                width: '16px',
                                height: '16px',
                              }),
                              Object(l.jsx)('h1', {
                                className: 'gne_tab',
                                children: 'Finance Tab',
                              }),
                            ],
                          }),
                          Object(l.jsxs)('div', {
                            className: 'boosting-close-container',
                            children: [
                              Object(l.jsx)(
                                'button',
                                { className: 'btn min-btn' },
                                'cmin-btn'
                              ),
                              Object(l.jsx)(
                                'button',
                                {
                                  className: 'btn close-btn',
                                  onClick: function () {
                                    n(false)
                                  },
                                },
                                'cclose-btn'
                              ),
                            ],
                          }),
                        ],
                      }),
                      Object(l.jsx)('div', {
                        className: 'input_browser',
                        children: Object(l.jsx)('input', {
                          className: 'inputStyles',
                          type: 'text',
                          name: 'name',
                          value: u.page,
                        }),
                      }),
                      'google' === u.id &&
                        Object(l.jsx)('div', {
                          className: 'google',
                          children: Object(l.jsx)('img', {
                            src: 'https://pngimg.com/uploads/google/google_PNG19644.png',
                            alt: 'img',
                            width: 720,
                            height: 320,
                          }),
                        }),
                      u.open &&
                        'gne' === u.id &&
                        Object(l.jsxs)('div', {
                          className: 'financePage',
                          children: [
                            Object(l.jsxs)('div', {
                              className: 'design',
                              children: [
                                Object(l.jsx)('img', {
                                  src: 'https://imgur.com/ihdYdZm.png',
                                  alt: 'img',
                                  width: '202px',
                                  height: '143px',
                                }),
                                Object(l.jsx)('span', {
                                  style: {
                                    color: '#505051',
                                    fontSize: '18px',
                                  },
                                  children: 'GNE available to buy',
                                }),
                                Object(l.jsxs)('span', {
                                  style: {
                                    color: '#1a936f',
                                    fontSize: '30px',
                                  },
                                  children: [
                                    S,
                                    Object(l.jsx)('span', {
                                      style: {
                                        color: '#505051',
                                        fontSize: '18px',
                                      },
                                      children: ' credits',
                                    }),
                                  ],
                                }),
                              ],
                            }),
                            Object(l.jsxs)('div', {
                              className: 'design2',
                              children: [
                                Object(l.jsxs)('span', {
                                  style: {
                                    color: 'white',
                                    fontSize: '18px',
                                  },
                                  children: [
                                    'You have ',
                                    Object(l.jsxs)('span', {
                                      style: {
                                        color: '#1a936f',
                                        fontSize: '18px',
                                      },
                                      children: [' ', v],
                                    }),
                                    ' credits',
                                  ],
                                }),
                                Object(l.jsx)('h3', { children: 'GNE Checkout' }),
                                Object(l.jsx)(
                                  G.a,
                                  {
                                    className: 'textfix',
                                    id: 'input-with-icon-textfield',
                                    label: 'How many units do you want to buy?',
                                    classes: I,
                                    value: p,
                                    onChange: E,
                                    InputLabelProps: {
                                      style: { color: 'white' },
                                    },
                                    InputProps: {
                                      startAdornment: Object(l.jsx)(F.a, {
                                        position: 'start',
                                        children: Object(l.jsx)('i', {
                                          className: 'fa-brands fa-buy-n-large',
                                          style: { color: 'white' },
                                        }),
                                      }),
                                    },
                                    variant: 'standard',
                                  },
                                  E
                                ),
                                Object(l.jsx)('div', {
                                  children: Object(l.jsxs)(U.a, {
                                    variant: 'contained',
                                    onClick: function () {
                                      '' !== p &&
                                        S > p &&
                                        (f('ps-purchaseGNE', { imputValue: p }),
                                        h(''))
                                    },
                                    sx: {
                                      margin: '10px',
                                      bgcolor: '#169776',
                                      ':hover': {
                                        bgcolor: '#5a5a5a',
                                        color: 'white',
                                      },
                                    },
                                    children: [
                                      Object(l.jsx)('i', {
                                        className: 'fa-solid fa-check',
                                        style: { marginRight: '3px' },
                                      }),
                                      'Purchase',
                                    ],
                                  }),
                                }),
                              ],
                            }),
                          ],
                        }),
                    ],
                  }),
                }),
              }),
            })
          }
        var D = function () {
            var e = Object(c.useState)(false),
              t = Object(o.a)(e, 2),
              n = t[0],
              s = t[1],
              a = Object(c.useState)(false),
              i = Object(o.a)(a, 2),
              r = i[0],
              j = i[1],
              b = Object(c.useState)(false),
              u = Object(o.a)(b, 2),
              d = u[0],
              m = u[1],
              O = Object(c.useState)(false),
              p = Object(o.a)(O, 2),
              h = p[0],
              x = p[1],
              g = Object(c.useState)(true),
              v = Object(o.a)(g, 2),
              N = v[0],
              C = v[1],
              w = Object(c.useState)(function () {
                return (
                  JSON.parse(localStorage.getItem('boostingLaptop')) ||
                  'https://cdn.discordapp.com/attachments/982104385679159296/1047363972367646730/wp3986102.jpg' 
                )
              }),
              B = Object(o.a)(w, 2),
              E = B[0],
              I = B[1],
              k = Object(c.useState)(false),
              P = Object(o.a)(k, 2),
              G = P[0],
              F = P[1],
              U = Object(c.useState)({ visible: !window.invokeNative }),
              _ = Object(o.a)(U, 2),
              D = _[0],
              z = _[1],
              J = Object(c.useState)({ time: '00:00 12/12/2022' }),
              q = Object(o.a)(J, 2),
              Y = q[0],
              K = q[1]
            return (
              Object(c.useEffect)(function () {
                window.addEventListener('message', function (e) {
                  var t
                  e.data &&
                    ('openApplication' === (t = e.data).action
                      ? 'OpenBoostingApp' === t.app && z({ visible: t.show })
                      : 'UpdateValueUI' === t.action &&
                        ('BoostingApp' === t.app
                          ? K({ time: t.data.time })
                          : 'EnableApps' === t.app && C(t.data.BennysApp)))
                })
              }, []),
              Object(c.useEffect)(
                function () {
                  localStorage.setItem('boostingLaptop', JSON.stringify(E))
                },
                [E]
              ),
              Object(c.useEffect)(
                function () {
                  function e(e) {
                    'Escape' === e.code &&
                      (z({ visible: false }),
                      f('faye-boosting:closeBoostingApp', {}))
                  }
                  return (
                    document.addEventListener('keydown', e),
                    function () {
                      return document.removeEventListener('keydown', e)
                    }
                  )
                },
                [D, z]
              ),
              Object(l.jsx)('div', {
                style: D.visible
                  ? { visibility: 'visible' }
                  : { visibility: 'hidden' },
                children: Object(l.jsx)('div', {
                  className: 'rectangule',
                  children: Object(l.jsxs)('div', {
                    className: 'container',
                    style: { backgroundImage: "URL('".concat(E, "')") },
                    children: [
                      Object(l.jsxs)('div', {
                        className: 'windows_apps',
                        children: [
                          Object(l.jsxs)('button', {
                            className: 'win_apps',
                            children: [
                              Object(l.jsx)('img', {
                                height: 50,
                                width: 50,
                                alt: 'img',
                                src: 'https://imgur.com/6RPZ0KP.png',
                              }),
                              'Recyle Bin',
                            ],
                          }),
                          Object(l.jsxs)('button', {
                            className: 'win_apps',
                            children: [
                              Object(l.jsx)('img', {
                                alt: 'img',
                                src: 'https://imgur.com/X1kbasV.png',
                              }),
                              'Stuff',
                            ],
                          }),
                          Object(l.jsxs)('button', {
                            onClick: function () {
                              s(true)
                            },
                            className: 'win_apps',
                            children: [
                              Object(l.jsx)('img', {
                                height: 40,
                                width: 40,
                                alt: 'img',
                                src: 'https://imgur.com/FEPqpLc.png',
                              }),
                              'Boosting',
                            ],
                          }),
                          N &&
                            Object(l.jsxs)('button', {
                              onClick: function () {
                                j(true)
                              },
                              className: 'win_apps',
                              children: [
                                Object(l.jsx)('img', {
                                  height: 40,
                                  width: 40,
                                  alt: 'img',
                                  src: 'https://imgur.com/kGxkXTk.png',
                                }),
                                'Bennys Parts',
                              ],
                            }),
                        ],
                      }),
                      Object(l.jsx)(V, {
                        counter: G,
                        setCounter: F,
                      }),
                      Object(l.jsx)(A, {
                        counter: r,
                        setCounter: j,
                      }),
                      Object(l.jsx)(y, {
                        counter: n,
                        setCounter: s,
                      }),
                      Object(l.jsx)(S, {
                        counter: h,
                        setCounter: x,
                      }),
                      Object(l.jsx)(T, {
                        counter: d,
                        setCounter: m,
                        setWallpaper: I,
                      }),
                      Object(l.jsxs)('div', {
                        className: 'windows_bar',
                        children: [
                          Object(l.jsxs)('div', {
                            className: 'fix_bar',
                            children: [
                              Object(l.jsx)('button', {
                                className: 'color4',
                                style: {},
                                children: Object(l.jsx)('img', {
                                  alt: 'img',
                                  src: 'https://cdn.discordapp.com/attachments/982104385679159296/1047293450380386384/L8w5avL.png', 
                                  width: '35',
                                  height: '35',
                                }),
                              }),
                              Object(l.jsx)('button', {
                                className: 'color4',
                                style: {},
                                children: Object(l.jsx)('img', {
                                  alt: 'img',
                                  src: 'https://imgur.com/QFOk7B1.png',
                                  width: '24',
                                  height: '24',
                                }),
                              }),
                              Object(l.jsx)('button', {
                                className: G ? 'OpenedButton' : 'color4',
                                style: {},
                                onClick: function () {
                                  F(true)
                                },
                                children: Object(l.jsx)('img', {
                                  alt: 'img',
                                  src: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Google_Chrome_icon_%28February_2022%29.svg/768px-Google_Chrome_icon_%28February_2022%29.svg.png',
                                  width: '24',
                                  height: '24',
                                }),
                              }),
                              n &&
                                Object(l.jsx)('button', {
                                  className: 'OpenedButton',
                                  style: {},
                                  children: Object(l.jsx)('img', {
                                    alt: 'img',
                                    src: 'https://imgur.com/FEPqpLc.png',
                                    height: 24,
                                    width: 24,
                                  }),
                                }),
                              r &&
                                Object(l.jsx)('button', {
                                  className: 'OpenedButton',
                                  style: {},
                                  children: Object(l.jsx)('img', {
                                    alt: 'img',
                                    src: 'https://imgur.com/kGxkXTk.png',
                                    height: 24,
                                    width: 24,
                                  }),
                                }),
                            ],
                          }),
                          Object(l.jsx)('button', {
                            onClick: function () {
                              m(true)
                            },
                            className: 'color',
                            children: Object(l.jsx)('img', {
                              alt: 'img',
                              src: L,
                              className: 'filter-white',
                              style: { color: 'white' },
                              height: 17,
                              width: 17,
                            }),
                          }),
                          Object(l.jsx)('button', {
                            className: 'color',
                            children: Object(l.jsx)('img', {
                              alt: 'img',
                              src: R,
                              style: { color: 'white' },
                              className: 'filter-white',
                              height: 17,
                              width: 17,
                            }),
                          }),
                          Object(l.jsx)('div', {
                            className: 'textohora',
                            children: Y.time,
                          }),
                          Object(l.jsx)('button', {
                            onClick: function () {
                              x(true)
                            },
                            className: 'color',
                            children: Object(l.jsx)('img', {
                              alt: 'img',
                              src: M,
                              style: { color: 'white' },
                              className: 'filter-white',
                              height: 17,
                              width: 17,
                            }),
                          }),
                        ],
                      }),
                    ],
                  }),
                }),
              })
            )
          },
          z = function () {
            return Object(l.jsx)('div', { children: Object(l.jsx)(D, {}) })
          }
        i.a.render(Object(l.jsx)(z, {}), document.getElementById('root'))
      },
    },
    [[147, 1, 2]],
  ])
  