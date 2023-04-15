;(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [0],
  {
    105: function (e, t, s) {},
    106: function (e, t, s) {},
    107: function (e, t, s) {},
    120: function (e, t, s) {
      'use strict'
      s.r(t)
      var a = s(1),
        r = s(34),
        c = s.n(r),
        i = (s(105), s(88)),
        n = s(180),
        o = s(169),
        l = (s(106), s(2)),
        d = (s(107), function () {}),
        h = function (e, t) {
          var s = Object(a.useRef)(d)
          Object(a.useEffect)(
            function () {
              s.current = t
            },
            [t]
          )
          Object(a.useEffect)(
            function () {
              var t = function (t) {
                var a = t.data,
                  r = a.action,
                  c = a.data
                s.current && r === e && s.current(c)
              }
              return (
                window.addEventListener('message', t),
                function () {
                  return window.removeEventListener('message', t)
                }
              )
            },
            [e]
          )
        },
        j = s(31),
        b = s.n(j),
        u = s(59)
      function x(e, t) {
        return f.apply(this, arguments)
      }
      function f() {
        return (f = Object(u.a)(
          b.a.mark(function e(t, s) {
            var a, r, c, i
            return b.a.wrap(function (e) {
              for (;;) {
                switch ((e.prev = e.next)) {
                  case 0:
                    return (
                      (a = {
                        method: 'post',
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: JSON.stringify(s),
                      }),
                      (r = window.GetParentResourceName
                        ? window.GetParentResourceName()
                        : 'nui-frame-app'),
                      (e.next = 4),
                      fetch('https://'.concat(r, '/').concat(t), a)
                    )
                  case 4:
                    return (c = e.sent), (e.next = 7), c.json()
                  case 7:
                    return (i = e.sent), e.abrupt('return', i)
                  case 9:
                  case 'end':
                    return e.stop()
                }
              }
            }, e)
          })
        )).apply(this, arguments)
      }
      var p = ['Escape'],
        O = s(178),
        m = s(181),
        v = s(175),
        w = s(182),
        g = s(183),
        y = s(171),
        k = s(176),
        S = s(172),
        N = s(186),
        I = s(177),
        C = s(168),
        M = s(173),
        W = Object(o.a)({
          root: {
            top: '0px',
            left: '0px',
            width: '100vw',
            height: '100vh',
            position: 'absolute',
            maxWidth: '100vw',
            minWidth: '100vw',
            maxHeight: '100vh',
            minHeight: '100vh',
            pointerEvents: 'none',
            border: '0px',
            margin: '0px',
            outline: '0px',
            padding: '0px',
            overflow: 'hidden',
            '& .MuiInput-root': {
              color: 'white',
              fontSize: '1.3vmin',
            },
            '& .MuiInput-underline:hover:not(.Mui-disabled):before': {
              borderColor: 'darkgray',
            },
            '& .MuiInput-underline:before': {
              borderColor: 'darkgray',
              color: 'blue',
            },
            '& .MuiInput-underline:after': {
              borderColor: 'white',
              color: 'blue',
            },
            '& .MuiInputLabel-animated': {
              color: 'darkgray',
              fontSize: '1.5vmin',
            },
            '& .MuiInputAdornment-root': { color: 'darkgray' },
          },
          checkbox: {
            '&:hover': { backgroundColor: 'transparent !important' },
          },
          hudOuterContainer: {
            width: '100vw',
            height: '100vh',
            display: 'flex',
            zIndex: '50',
            position: 'relative',
            flexDirection: 'column',
          },
          hudInnerContainer: {
            top: '0px',
            left: '0px',
            width: '100vw',
            height: '100vh',
            display: 'flex',
            position: 'absolute',
            alignItems: 'flex-end',
          },
          hudIconWrapper: {
            width: '54px',
            height: '54px',
            display: 'flex',
            position: 'relative',
            alignItems: 'center',
            justifyContent: 'center',
            opacity: 0,
            maxWidth: '54px',
          },
          hudIcon: {
            top: '0px',
            left: '0px',
            width: '100%',
            height: '100%',
            display: 'flex',
            position: 'absolute',
            alignItems: 'center',
            justifyContent: 'center',
          },
          iconWrapper: {
            width: '34px',
            height: '34px',
            display: 'flex',
            alignItems: 'center',
            borderRadius: '100%',
            justifyContent: 'center',
            backgroundColor: 'rgb(33, 33, 33)',
          },
          radioChannelWrapper: {
            color: 'white',
            zIndex: '250',
            position: 'absolute',
          },
          vehicleHudContainer: {
            top: '0px',
            left: '0px',
            width: '100vw',
            height: '100vh',
            position: 'absolute',
          },
          minimapBorder: {
            top: 'calc(74vh - 4px)',
            left: '0.3125vw',
            width: '13.125vw',
            border: '4px solid rgb(189, 189, 189)',
            height: '20vh',
            position: 'absolute',
            boxSizing: 'content-box',
            borderRadius: '100%',
          },
        }),
        z = s(0),
        B = function () {
          var e = W(),
            t = Object(a.useState)(false),
            s = Object(l.a)(t, 2),
            r = s[0],
            c = s[1],
            i = Object(a.useState)(false),
            n = Object(l.a)(i, 2),
            o = n[0],
            j = n[1],
            b = Object(a.useState)(false),
            u = Object(l.a)(b, 2),
            f = u[0],
            B = u[1],
            F = Object(a.useState)(''),
            T = Object(l.a)(F, 2),
            D = T[0],
            P = T[1],
            A = Object(a.useState)(false),
            E = Object(l.a)(A, 2),
            V = E[0],
            R = E[1],
            H = Object(a.useState)(true),
            L = Object(l.a)(H, 2),
            J = L[0],
            K = L[1],
            G = Object(a.useState)(true),
            U = Object(l.a)(G, 2),
            q = U[0],
            X = U[1],
            Q = Object(a.useState)(true),
            Y = Object(l.a)(Q, 2),
            Z = Y[0],
            $ = Y[1],
            _ = Object(a.useState)(true),
            ee = Object(l.a)(_, 2),
            te = ee[0],
            se = ee[1],
            ae = Object(a.useState)(true),
            re = Object(l.a)(ae, 2),
            ce = re[0],
            ie = re[1],
            ne = Object(a.useState)(true),
            oe = Object(l.a)(ne, 2),
            le = oe[0],
            de = oe[1],
            he = Object(a.useState)(false),
            je = Object(l.a)(he, 2),
            be = je[0],
            ue = je[1],
            xe = Object(a.useState)(false),
            fe = Object(l.a)(xe, 2),
            pe = fe[0],
            Oe = fe[1],
            me = Object(a.useState)(false),
            ve = Object(l.a)(me, 2),
            we = ve[0],
            ge = ve[1],
            ye = Object(a.useState)(false),
            ke = Object(l.a)(ye, 2),
            Se = ke[0],
            Ne = ke[1],
            Ie = Object(a.useState)(false),
            Ce = Object(l.a)(Ie, 2),
            Me = Ce[0],
            We = Ce[1],
            ze = Object(a.useState)(''),
            Be = Object(l.a)(ze, 2),
            Fe = Be[0],
            Te = Be[1],
            De = Object(a.useState)(''),
            Pe = Object(l.a)(De, 2),
            Ae = Pe[0],
            Ee = Pe[1],
            Ve = Object(a.useState)(''),
            Re = Object(l.a)(Ve, 2),
            He = Re[0],
            Le = Re[1],
            Je = Object(a.useState)(''),
            Ke = Object(l.a)(Je, 2),
            Ge = Ke[0],
            Ue = Ke[1],
            qe = Object(a.useState)(''),
            Xe = Object(l.a)(qe, 2),
            Qe = Xe[0],
            Ye = Xe[1],
            Ze = Object(a.useState)(''),
            $e = Object(l.a)(Ze, 2),
            _e = $e[0],
            et = $e[1],
            tt = Object(a.useState)(''),
            st = Object(l.a)(tt, 2),
            at = st[0],
            rt = st[1],
            ct = Object(a.useState)(''),
            it = Object(l.a)(ct, 2),
            nt = it[0],
            ot = it[1],
            lt = Object(a.useState)(''),
            dt = Object(l.a)(lt, 2),
            ht = dt[0],
            jt = dt[1],
            bt = Object(a.useState)(''),
            ut = Object(l.a)(bt, 2),
            xt = ut[0],
            ft = ut[1],
            pt = Object(a.useState)(0),
            Ot = Object(l.a)(pt, 2),
            mt = Ot[0],
            vt = Ot[1],
            wt = Object(a.useState)(0),
            gt = Object(l.a)(wt, 2),
            yt = gt[0],
            kt = gt[1],
            St = Object(a.useState)(0),
            Nt = Object(l.a)(St, 2),
            It = (Nt[0], Nt[1]),
            Ct = Object(a.useState)(0),
            Mt = Object(l.a)(Ct, 2),
            Wt = Mt[0],
            zt = Mt[1],
            Bt = Object(a.useState)(true),
            Ft = Object(l.a)(Bt, 2),
            Tt = Ft[0],
            Dt = Ft[1],
            Pt = Object(a.useState)(true),
            At = Object(l.a)(Pt, 2),
            Et = At[0],
            Vt = At[1],
            Rt = Object(a.useState)(false),
            Ht = Object(l.a)(Rt, 2),
            Lt = Ht[0],
            Jt = Ht[1],
            Kt = Object(a.useState)(false),
            Gt = Object(l.a)(Kt, 2),
            Ut = Gt[0],
            qt = Gt[1],
            Xt = Object(a.useState)(false),
            Qt = Object(l.a)(Xt, 2),
            Yt = Qt[0],
            Zt = Qt[1],
            $t = Object(a.useState)('16'),
            _t = Object(l.a)($t, 2),
            es = _t[0],
            ts = _t[1],
            ss = Object(a.useState)('16'),
            as = Object(l.a)(ss, 2),
            rs = (as[0], as[1]),
            cs = Object(a.useState)('10'),
            is = Object(l.a)(cs, 2),
            ns = is[0],
            os = is[1],
            ls = Object(a.useState)(false),
            ds = Object(l.a)(ls, 2),
            hs = ds[0],
            js = ds[1],
            bs = Object(a.useState)(false),
            us = Object(l.a)(bs, 2),
            xs = us[0],
            fs = us[1],
            ps = Object(a.useState)(false),
            Os = Object(l.a)(ps, 2),
            ms = Os[0],
            vs = Os[1],
            ws = Object(a.useState)(true),
            gs = Object(l.a)(ws, 2),
            ys = gs[0],
            ks = gs[1],
            Ss = Object(a.useState)(false),
            Ns = Object(l.a)(Ss, 2),
            Is = Ns[0],
            Cs = Ns[1],
            Ms = Object(a.useState)(true),
            Ws = Object(l.a)(Ms, 2),
            zs = Ws[0],
            Bs = Ws[1],
            Fs = Object(a.useState)('Android'),
            Ts = Object(l.a)(Fs, 2),
            Ds = Ts[0],
            Ps = Ts[1],
            As = Object(a.useState)('https://i.imgur.com/3KTfLIV.jpg'),
            Es = Object(l.a)(As, 2),
            Vs = Es[0],
            Rs = Es[1],
            Hs = Object(a.useState)(true),
            Ls = Object(l.a)(Hs, 2),
            Js = Ls[0],
            Ks = Ls[1],
            Gs = Object(a.useState)(true),
            Us = Object(l.a)(Gs, 2),
            qs = Us[0],
            Xs = Us[1],
            Qs = Object(a.useState)(true),
            Ys = Object(l.a)(Qs, 2),
            Zs = Ys[0],
            $s = Ys[1],
            _s = Object(a.useState)(true),
            ea = Object(l.a)(_s, 2),
            ta = ea[0],
            sa = ea[1],
            aa = Object(a.useState)(0),
            ra = Object(l.a)(aa, 2),
            ca = ra[0],
            ia = ra[1],
            na = Object(a.useState)(false),
            oa = Object(l.a)(na, 2),
            la = oa[0],
            da = oa[1],
            ha = Object(a.useState)('3'),
            ja = Object(l.a)(ha, 2),
            ba = ja[0],
            ua = ja[1],
            xa = Object(a.useState)(false),
            fa = Object(l.a)(xa, 2),
            pa = fa[0],
            Oa = fa[1],
            ma = Object(a.useState)(false),
            va = Object(l.a)(ma, 2),
            wa = va[0],
            ga = va[1],
            ya = Object(a.useState)(false),
            ka = Object(l.a)(ya, 2),
            Sa = ka[0],
            Na = ka[1],
            Ia = Object(a.useState)(false),
            Ca = Object(l.a)(Ia, 2),
            Ma = (Ca[0], Ca[1], Object(a.useState)(false)),
            Wa = Object(l.a)(Ma, 2),
            za = (Wa[0], Wa[1], Object(a.useState)(false)),
            Ba = Object(l.a)(za, 2),
            Fa = Ba[0],
            Ta = Ba[1],
            Da = Object(a.useState)(false),
            Pa = Object(l.a)(Da, 2),
            Aa = Pa[0],
            Ea = Pa[1],
            Va = Object(a.useState)(false),
            Ra = Object(l.a)(Va, 2),
            Ha = Ra[0],
            La = Ra[1],
            Ja = Object(a.useState)(false),
            Ka = Object(l.a)(Ja, 2),
            Ga = Ka[0],
            Ua = Ka[1],
            qa = Object(a.useState)(false),
            Xa = Object(l.a)(qa, 2),
            Qa = Xa[0],
            Ya = Xa[1],
            Za = Object(a.useState)(false),
            $a = Object(l.a)(Za, 2),
            _a = $a[0],
            er = $a[1],
            tr = Object(a.useState)(false),
            sr = Object(l.a)(tr, 2),
            ar = sr[0],
            rr = sr[1],
            cr = function () {
              x('fa-hud:hudSetPreferences', {
                'hud.compass.enabled': Tt,
                'hud.compass.fps': es,
                'hud.compass.roadnames.enabled': Et,
                'hud.vehicle.speedometer.fps': 64,
                'hud.vehicle.minimap.enabled': ys,
                'hud.vehicle.minimap.default': Is,
                'hud.misc.circle.taskbar.enabled': Ut,
                'phone.misc.brand': Ds,
                'phone.misc.background': Vs,
                'phone.misc.receive.sms': Js,
                'phone.misc.new.tweet': qs,
                'phone.misc.receive.email': Zs,
                'phone.misc.embedded.images': ta,
              })
              x('fa-hud:setKVPValue', {
                key: 'fa-preferences',
                value: {
                  'hud.misc.circle.taskbar.enabled': Ut,
                  'hud.status.health.enabled': J,
                  'hud.status.armor.enabled': q,
                  'hud.status.hunger.enabled': Z,
                  'hud.status.thirst.enabled': te,
                  'hud.status.oxygen.enabled': ce,
                  'hud.status.stress.enabled': le,
                  'hud.status.enhancements.enabled': Yt,
                  'hud.status.health.hideValue': Jr,
                  'hud.status.armor.hideValue': Dc,
                  'hud.status.hunger.hideValue': bi,
                  'hud.status.thirst.hideValue': Gi,
                  'hud.status.radio.channel.visibility': ba,
                  'hud.vehicle.minimap.enabled': ys,
                  'hud.vehicle.minimap.default': Is,
                  'hud.vehicle.minimap.outline': zs,
                  'hud.vehicle.speedometer.fps': 64,
                  'hud.compass.enabled': Tt,
                  'hud.compass.fps': es,
                  'hud.compass.roadnames.enabled': Et,
                  'hud.blackbars.enabled': Lt,
                  'hud.blackbars.value': ns,
                  'phone.misc.brand': Ds,
                  'phone.misc.background': Vs,
                  'phone.misc.receive.sms': Js,
                  'phone.misc.new.tweet': qs,
                  'phone.misc.receive.email': Zs,
                  'phone.misc.embedded.images': ta,
                },
              })
            },
            ir = function (e, t) {
              var s = 0
              if (t) {
                if (((s = Number(e.target.value)), 'Enter' !== e.key)) {
                  return
                }
              } else {
                s = Number(e)
              }
              Kr(s)
              Xr(s)
              Vr >= s && 100 !== s
                ? (ic(0),
                  $r(false),
                  setTimeout(function () {
                    sc(false)
                  }, 2000))
                : true === J && (sc(true), ic(1))
            },
            nr = function (e, t) {
              var s = 0
              if (t) {
                if (((s = Number(e.target.value)), 'Enter' !== e.key)) {
                  return
                }
              } else {
                s = Number(e)
              }
              Pc(s)
              Rc(s)
              zc >= s && 100 !== s
                ? ($c(0),
                  Kc(false),
                  setTimeout(function () {
                    Xc(false)
                  }, 2000))
                : true === q && (Xc(true), $c(1))
            },
            or = function (e, t) {
              var s = 0
              if (t) {
                if (((s = Number(e.target.value)), 'Enter' !== e.key)) {
                  return
                }
              } else {
                s = Number(e)
              }
              ui(s)
              Oi(s)
              li >= s && 100 !== s
                ? (Wi(0),
                  gi(false),
                  setTimeout(function () {
                    Ni(false)
                  }, 2000))
                : true === Z && (Ni(true), Wi(1))
            },
            lr = function (e, t) {
              var s = 0
              if (t) {
                if (((s = Number(e.target.value)), 'Enter' !== e.key)) {
                  return
                }
              } else {
                s = Number(e)
              }
              Ui(s)
              Yi(s)
              Hi >= s && 100 !== s
                ? (ln(0),
                  en(false),
                  setTimeout(function () {
                    rn(false)
                  }, 2000))
                : true === te && (rn(true), ln(1))
            },
            dr = Object(a.useState)(true),
            hr = Object(l.a)(dr, 2),
            jr = hr[0],
            br = hr[1],
            ur = Object(a.useState)('white'),
            xr = Object(l.a)(ur, 2),
            fr = (xr[0], xr[1]),
            pr = Object(a.useState)(false),
            Or = Object(l.a)(pr, 2),
            mr = Or[0],
            vr = Or[1],
            wr = Object(a.useState)(false),
            gr = Object(l.a)(wr, 2),
            yr = gr[0],
            kr = gr[1],
            Sr = Object(a.useState)(1),
            Nr = Object(l.a)(Sr, 2),
            Ir = Nr[0],
            Cr = Nr[1],
            Mr = Object(a.useState)('125.66370614359172'),
            Wr = Object(l.a)(Mr, 2),
            zr = Wr[0],
            Br = Wr[1],
            Fr = Object(a.useState)('125.66370614359172'),
            Tr = Object(l.a)(Fr, 2),
            Dr = Tr[0],
            Pr = Tr[1],
            Ar = Object(a.useState)(0),
            Er = Object(l.a)(Ar, 2),
            Vr = Er[0],
            Rr = Er[1],
            Hr = Object(a.useState)(99),
            Lr = Object(l.a)(Hr, 2),
            Jr = Lr[0],
            Kr = Lr[1],
            Gr = Object(a.useState)(99),
            Ur = Object(l.a)(Gr, 2),
            qr = Ur[0],
            Xr = Ur[1],
            Qr = Object(a.useState)(false),
            Yr = Object(l.a)(Qr, 2),
            Zr = Yr[0],
            $r = Yr[1],
            _r = Object(a.useState)(true),
            ec = Object(l.a)(_r, 2),
            tc = ec[0],
            sc = ec[1],
            ac = Object(a.useState)(1),
            rc = Object(l.a)(ac, 2),
            cc = rc[0],
            ic = rc[1],
            nc = Object(a.useState)('125.66370614359172'),
            oc = Object(l.a)(nc, 2),
            lc = oc[0],
            dc = oc[1],
            hc = Object(a.useState)('125.66370614359172'),
            jc = Object(l.a)(hc, 2),
            bc = jc[0],
            uc = jc[1],
            xc = Object(a.useState)(0),
            fc = Object(l.a)(xc, 2),
            pc = (fc[0], fc[1], Object(a.useState)(false)),
            Oc = Object(l.a)(pc, 2),
            mc = Oc[0],
            vc = (Oc[1], Object(a.useState)(0)),
            wc = Object(l.a)(vc, 2),
            gc = wc[0],
            yc = (wc[1], Object(a.useState)('125.66370614359172')),
            kc = Object(l.a)(yc, 2),
            Sc = kc[0],
            Nc = (kc[1], Object(a.useState)('125.66370614359172')),
            Ic = Object(l.a)(Nc, 2),
            Cc = Ic[0],
            Mc = (Ic[1], Object(a.useState)(0)),
            Wc = Object(l.a)(Mc, 2),
            zc = Wc[0],
            Bc = Wc[1],
            Fc = Object(a.useState)(99),
            Tc = Object(l.a)(Fc, 2),
            Dc = Tc[0],
            Pc = Tc[1],
            Ac = Object(a.useState)(99),
            Ec = Object(l.a)(Ac, 2),
            Vc = Ec[0],
            Rc = Ec[1],
            Hc = Object(a.useState)(false),
            Lc = Object(l.a)(Hc, 2),
            Jc = Lc[0],
            Kc = Lc[1],
            Gc = Object(a.useState)(true),
            Uc = Object(l.a)(Gc, 2),
            qc = Uc[0],
            Xc = Uc[1],
            Qc = Object(a.useState)(1),
            Yc = Object(l.a)(Qc, 2),
            Zc = Yc[0],
            $c = Yc[1],
            _c = Object(a.useState)('125.66370614359172'),
            ei = Object(l.a)(_c, 2),
            ti = ei[0],
            si = ei[1],
            ai = Object(a.useState)('125.66370614359172'),
            ri = Object(l.a)(ai, 2),
            ci = ri[0],
            ii = ri[1],
            ni = Object(a.useState)(0),
            oi = Object(l.a)(ni, 2),
            li = oi[0],
            di = oi[1],
            hi = Object(a.useState)(99),
            ji = Object(l.a)(hi, 2),
            bi = ji[0],
            ui = ji[1],
            xi = Object(a.useState)(99),
            fi = Object(l.a)(xi, 2),
            pi = fi[0],
            Oi = fi[1],
            mi = Object(a.useState)(false),
            vi = Object(l.a)(mi, 2),
            wi = vi[0],
            gi = vi[1],
            yi = Object(a.useState)(true),
            ki = Object(l.a)(yi, 2),
            Si = ki[0],
            Ni = ki[1],
            Ii = Object(a.useState)(1),
            Ci = Object(l.a)(Ii, 2),
            Mi = Ci[0],
            Wi = Ci[1],
            zi = Object(a.useState)('125.66370614359172'),
            Bi = Object(l.a)(zi, 2),
            Fi = Bi[0],
            Ti = Bi[1],
            Di = Object(a.useState)('125.66370614359172'),
            Pi = Object(l.a)(Di, 2),
            Ai = Pi[0],
            Ei = Pi[1],
            Vi = Object(a.useState)(0),
            Ri = Object(l.a)(Vi, 2),
            Hi = Ri[0],
            Li = Ri[1],
            Ji = Object(a.useState)(99),
            Ki = Object(l.a)(Ji, 2),
            Gi = Ki[0],
            Ui = Ki[1],
            qi = Object(a.useState)(99),
            Xi = Object(l.a)(qi, 2),
            Qi = Xi[0],
            Yi = Xi[1],
            Zi = Object(a.useState)(false),
            $i = Object(l.a)(Zi, 2),
            _i = $i[0],
            en = $i[1],
            tn = Object(a.useState)(true),
            sn = Object(l.a)(tn, 2),
            an = sn[0],
            rn = sn[1],
            cn = Object(a.useState)(1),
            nn = Object(l.a)(cn, 2),
            on = nn[0],
            ln = nn[1],
            dn = Object(a.useState)('125.66370614359172'),
            hn = Object(l.a)(dn, 2),
            jn = hn[0],
            bn = hn[1],
            un = Object(a.useState)('125.66370614359172'),
            xn = Object(l.a)(un, 2),
            fn = xn[0],
            pn = xn[1],
            On = Object(a.useState)(0),
            mn = Object(l.a)(On, 2),
            vn = (mn[0], mn[1], Object(a.useState)(true)),
            wn = Object(l.a)(vn, 2),
            gn = wn[0],
            yn = wn[1],
            kn = Object(a.useState)(1),
            Sn = Object(l.a)(kn, 2),
            Nn = Sn[0],
            In = Sn[1],
            Cn = Object(a.useState)('125.66370614359172'),
            Mn = Object(l.a)(Cn, 2),
            Wn = Mn[0],
            zn = Mn[1],
            Bn = Object(a.useState)('125.66370614359172'),
            Fn = Object(l.a)(Bn, 2),
            Tn = Fn[0],
            Dn = Fn[1],
            Pn = Object(a.useState)(0),
            An = Object(l.a)(Pn, 2),
            En = An[0],
            Vn = An[1],
            Rn = Object(a.useState)(0),
            Hn = Object(l.a)(Rn, 2),
            Ln = (Hn[0], Hn[1], Object(a.useState)(true)),
            Jn = Object(l.a)(Ln, 2),
            Kn = Jn[0],
            Gn = Jn[1],
            Un = Object(a.useState)(1),
            qn = Object(l.a)(Un, 2),
            Xn = qn[0],
            Qn = qn[1],
            Yn = Object(a.useState)('125.66370614359172'),
            Zn = Object(l.a)(Yn, 2),
            $n = Zn[0],
            _n = Zn[1],
            eo = Object(a.useState)('125.66370614359172'),
            to = Object(l.a)(eo, 2),
            so = to[0],
            ao = to[1],
            ro = Object(a.useState)(0),
            co = Object(l.a)(ro, 2),
            io = (co[0], co[1]),
            no = Object(a.useState)(false),
            oo = Object(l.a)(no, 2),
            lo = oo[0],
            ho = oo[1],
            jo = Object(a.useState)(0),
            bo = Object(l.a)(jo, 2),
            uo = bo[0],
            xo = bo[1],
            fo = Object(a.useState)('125.66370614359172'),
            po = Object(l.a)(fo, 2),
            Oo = po[0],
            mo = po[1],
            vo = Object(a.useState)('125.66370614359172'),
            wo = Object(l.a)(vo, 2),
            go = wo[0],
            yo = wo[1],
            ko = Object(a.useState)(false),
            So = Object(l.a)(ko, 2),
            No = So[0],
            Io = So[1],
            Co = Object(a.useState)(0),
            Mo = Object(l.a)(Co, 2),
            Wo = (Mo[0], Mo[1], Object(a.useState)(false)),
            zo = Object(l.a)(Wo, 2),
            Bo = zo[0],
            Fo = zo[1],
            To = Object(a.useState)(0),
            Do = Object(l.a)(To, 2),
            Po = Do[0],
            Ao = Do[1],
            Eo = Object(a.useState)('125.66370614359172'),
            Vo = Object(l.a)(Eo, 2),
            Ro = Vo[0],
            Ho = (Vo[1], Object(a.useState)('125.66370614359172')),
            Lo = Object(l.a)(Ho, 2),
            Jo = Lo[0],
            Ko = (Lo[1], Object(a.useState)(false)),
            Go = Object(l.a)(Ko, 2),
            Uo = Go[0],
            qo = (Go[1], Object(a.useState)(0)),
            Xo = Object(l.a)(qo, 2),
            Qo = (Xo[0], Xo[1]),
            Yo = Object(a.useState)(false),
            Zo = Object(l.a)(Yo, 2),
            $o = Zo[0],
            _o = Zo[1],
            el = Object(a.useState)(0),
            tl = Object(l.a)(el, 2),
            sl = tl[0],
            al = tl[1],
            rl = Object(a.useState)('125.66370614359172'),
            cl = Object(l.a)(rl, 2),
            il = cl[0],
            nl = cl[1],
            ol = Object(a.useState)('125.66370614359172'),
            ll = Object(l.a)(ol, 2),
            dl = ll[0],
            hl = ll[1],
            jl = Object(a.useState)(false),
            bl = Object(l.a)(jl, 2),
            ul = bl[0],
            xl = bl[1],
            fl = Object(a.useState)(0),
            pl = Object(l.a)(fl, 2),
            Ol = (pl[0], pl[1]),
            ml = Object(a.useState)(false),
            vl = Object(l.a)(ml, 2),
            wl = vl[0],
            gl = vl[1],
            yl = Object(a.useState)(0),
            kl = Object(l.a)(yl, 2),
            Sl = kl[0],
            Nl = kl[1],
            Il = Object(a.useState)('125.66370614359172'),
            Cl = Object(l.a)(Il, 2),
            Ml = Cl[0],
            Wl = Cl[1],
            zl = Object(a.useState)('125.66370614359172'),
            Bl = Object(l.a)(zl, 2),
            Fl = Bl[0],
            Tl = Bl[1],
            Dl = Object(a.useState)(false),
            Pl = Object(l.a)(Dl, 2),
            Al = Pl[0],
            El = Pl[1],
            Vl = Object(a.useState)(0),
            Rl = Object(l.a)(Vl, 2),
            Hl = (Rl[0], Rl[1], Object(a.useState)(false)),
            Ll = Object(l.a)(Hl, 2),
            Jl = Ll[0],
            Kl = Ll[1],
            Gl = Object(a.useState)(0),
            Ul = Object(l.a)(Gl, 2),
            ql = Ul[0],
            Xl = Ul[1],
            Ql = Object(a.useState)('125.66370614359172'),
            Yl = Object(l.a)(Ql, 2),
            Zl = Yl[0],
            $l = (Yl[1], Object(a.useState)('125.66370614359172')),
            _l = Object(l.a)($l, 2),
            ed = _l[0],
            td = (_l[1], Object(a.useState)(false)),
            sd = Object(l.a)(td, 2),
            ad = sd[0],
            rd = (sd[1], Object(a.useState)(0)),
            cd = Object(l.a)(rd, 2),
            id = (cd[0], cd[1]),
            nd = Object(a.useState)(false),
            od = Object(l.a)(nd, 2),
            ld = od[0],
            dd = od[1],
            hd = Object(a.useState)(0),
            jd = Object(l.a)(hd, 2),
            bd = jd[0],
            ud = jd[1],
            xd = Object(a.useState)('125.66370614359172'),
            fd = Object(l.a)(xd, 2),
            pd = fd[0],
            Od = fd[1],
            md = Object(a.useState)('125.66370614359172'),
            vd = Object(l.a)(md, 2),
            wd = vd[0],
            gd = vd[1],
            yd = Object(a.useState)(false),
            kd = Object(l.a)(yd, 2),
            Sd = kd[0],
            Nd = kd[1],
            Id = Object(a.useState)(0),
            Cd = Object(l.a)(Id, 2),
            Md = (Cd[0], Cd[1], Object(a.useState)(false)),
            Wd = Object(l.a)(Md, 2),
            zd = Wd[0],
            Bd = Wd[1],
            Fd = Object(a.useState)(0),
            Td = Object(l.a)(Fd, 2),
            Dd = Td[0],
            Pd = Td[1],
            Ad = Object(a.useState)('125.66370614359172'),
            Ed = Object(l.a)(Ad, 2),
            Vd = Ed[0],
            Rd = (Ed[1], Object(a.useState)('125.66370614359172')),
            Hd = Object(l.a)(Rd, 2),
            Ld = Hd[0],
            Jd = (Hd[1], Object(a.useState)(false)),
            Kd = Object(l.a)(Jd, 2),
            Gd = Kd[0],
            Ud = (Kd[1], Object(a.useState)(0)),
            qd = Object(l.a)(Ud, 2),
            Xd = (qd[0], qd[1]),
            Qd = Object(a.useState)(false),
            Yd = Object(l.a)(Qd, 2),
            Zd = Yd[0],
            $d = Yd[1],
            _d = Object(a.useState)(0),
            eh = Object(l.a)(_d, 2),
            th = eh[0],
            sh = eh[1],
            ah = Object(a.useState)('125.66370614359172'),
            rh = Object(l.a)(ah, 2),
            ch = rh[0],
            ih = rh[1],
            nh = Object(a.useState)('125.66370614359172'),
            oh = Object(l.a)(nh, 2),
            lh = oh[0],
            dh = oh[1],
            hh = Object(a.useState)(false),
            jh = Object(l.a)(hh, 2),
            bh = jh[0],
            uh = jh[1],
            xh = Object(a.useState)(0),
            fh = Object(l.a)(xh, 2),
            ph = (fh[0], fh[1], Object(a.useState)(false)),
            Oh = Object(l.a)(ph, 2),
            mh = Oh[0],
            vh = Oh[1],
            wh = Object(a.useState)(0),
            gh = Object(l.a)(wh, 2),
            yh = gh[0],
            kh = gh[1],
            Sh = Object(a.useState)('125.66370614359172'),
            Nh = Object(l.a)(Sh, 2),
            Ih = Nh[0],
            Ch = Nh[1],
            Mh = Object(a.useState)('125.66370614359172'),
            Wh = Object(l.a)(Mh, 2),
            zh = Wh[0],
            Bh = Wh[1],
            Fh = Object(a.useState)(0),
            Th = Object(l.a)(Fh, 2),
            Dh = (Th[0], Th[1], Object(a.useState)(false)),
            Ph = Object(l.a)(Dh, 2),
            Ah = Ph[0],
            Eh = Ph[1],
            Vh = Object(a.useState)(false),
            Rh = Object(l.a)(Vh, 2),
            Hh = Rh[0],
            Lh = Rh[1],
            Jh = Object(a.useState)(0),
            Kh = Object(l.a)(Jh, 2),
            Gh = Kh[0],
            Uh = Kh[1],
            qh = Object(a.useState)('125.66370614359172'),
            Xh = Object(l.a)(qh, 2),
            Qh = Xh[0],
            Yh = Xh[1],
            Zh = Object(a.useState)('125.66370614359172'),
            $h = Object(l.a)(Zh, 2),
            _h = $h[0],
            ej = $h[1],
            tj = Object(a.useState)(0),
            sj = Object(l.a)(tj, 2),
            aj = (sj[0], sj[1], Object(a.useState)(false)),
            rj = Object(l.a)(aj, 2),
            cj = rj[0],
            ij = (rj[1], Object(a.useState)(0)),
            nj = Object(l.a)(ij, 2),
            oj = nj[0],
            lj = (nj[1], Object(a.useState)('125.66370614359172')),
            dj = Object(l.a)(lj, 2),
            hj = dj[0],
            jj = (dj[1], Object(a.useState)('125.66370614359172')),
            bj = Object(l.a)(jj, 2),
            uj = bj[0],
            xj = (bj[1], Object(a.useState)(0)),
            fj = Object(l.a)(xj, 2),
            pj = (fj[0], fj[1], Object(a.useState)(false)),
            Oj = Object(l.a)(pj, 2),
            mj = Oj[0],
            vj = (Oj[1], Object(a.useState)(0)),
            wj = Object(l.a)(vj, 2),
            gj = wj[0],
            yj = (wj[1], Object(a.useState)('125.66370614359172')),
            kj = Object(l.a)(yj, 2),
            Sj = kj[0],
            Nj = (kj[1], Object(a.useState)('125.66370614359172')),
            Ij = Object(l.a)(Nj, 2),
            Cj = Ij[0],
            Mj = (Ij[1], Object(a.useState)(0)),
            Wj = Object(l.a)(Mj, 2),
            zj = (Wj[0], Wj[1], Object(a.useState)(false)),
            Bj = Object(l.a)(zj, 2),
            Fj = Bj[0],
            Tj = (Bj[1], Object(a.useState)(0)),
            Dj = Object(l.a)(Tj, 2),
            Pj = Dj[0],
            Aj = (Dj[1], Object(a.useState)('125.66370614359172')),
            Ej = Object(l.a)(Aj, 2),
            Vj = Ej[0],
            Rj = (Ej[1], Object(a.useState)('125.66370614359172')),
            Hj = Object(l.a)(Rj, 2),
            Lj = Hj[0],
            Jj = (Hj[1], Object(a.useState)(100)),
            Kj = Object(l.a)(Jj, 2),
            Gj = (Kj[0], Kj[1], Object(a.useState)(false)),
            Uj = Object(l.a)(Gj, 2),
            qj = Uj[0],
            Xj = Uj[1],
            Qj = Object(a.useState)(0),
            Yj = Object(l.a)(Qj, 2),
            Zj = Yj[0],
            $j = Yj[1],
            _j = Object(a.useState)('125.66370614359172'),
            eb = Object(l.a)(_j, 2),
            tb = (eb[0], eb[1], Object(a.useState)('125.66370614359172')),
            sb = Object(l.a)(tb, 2),
            ab = (sb[0], sb[1], Object(a.useState)(0)),
            rb = Object(l.a)(ab, 2),
            cb = (rb[0], rb[1], Object(a.useState)(false)),
            ib = Object(l.a)(cb, 2),
            nb = ib[0],
            ob = ib[1],
            lb = Object(a.useState)(0),
            db = Object(l.a)(lb, 2),
            hb = db[0],
            jb = db[1],
            bb = Object(a.useState)('125.66370614359172'),
            ub = Object(l.a)(bb, 2),
            xb = ub[0],
            fb = ub[1],
            pb = Object(a.useState)('125.66370614359172'),
            Ob = Object(l.a)(pb, 2),
            mb = Ob[0],
            vb = Ob[1],
            wb = Object(a.useState)(0),
            gb = Object(l.a)(wb, 2),
            yb = (gb[0], gb[1], Object(a.useState)(false)),
            kb = Object(l.a)(yb, 2),
            Sb = kb[0],
            Nb = (kb[1], Object(a.useState)(0)),
            Ib = Object(l.a)(Nb, 2),
            Cb = Ib[0],
            Mb = (Ib[1], Object(a.useState)('125.66370614359172')),
            Wb = Object(l.a)(Mb, 2),
            zb = Wb[0],
            Bb = (Wb[1], Object(a.useState)('125.66370614359172')),
            Fb = Object(l.a)(Bb, 2),
            Tb = Fb[0],
            Db = (Fb[1], Object(a.useState)(100)),
            Pb = Object(l.a)(Db, 2),
            Ab = (Pb[0], Pb[1], Object(a.useState)(false)),
            Eb = Object(l.a)(Ab, 2),
            Vb = Eb[0],
            Rb = Eb[1],
            Hb = Object(a.useState)(0),
            Lb = Object(l.a)(Hb, 2),
            Jb = Lb[0],
            Kb = Lb[1],
            Gb = Object(a.useState)('125.66370614359172'),
            Ub = Object(l.a)(Gb, 2),
            qb = (Ub[0], Ub[1], Object(a.useState)('125.66370614359172')),
            Xb = Object(l.a)(qb, 2)
          Xb[0]
          Xb[1]
          return (
            h('uiMessage', function (e) {
              var t = e.data,
                s = e.app,
                a = t
              if (
                ('main' === s && 'restart' === a.action && c(false),
                'preferences' === s &&
                  (void 0 !== a['hud.misc.circle.taskbar.enabled'] &&
                    qt(a['hud.misc.circle.taskbar.enabled']),
                  void 0 !== a['hud.status.health.enabled'] &&
                    K(a['hud.status.health.enabled']),
                  void 0 !== a['hud.status.armor.enabled'] &&
                    X(a['hud.status.armor.enabled']),
                  void 0 !== a['hud.status.hunger.enabled'] &&
                    $(a['hud.status.hunger.enabled']),
                  void 0 !== a['hud.status.thirst.enabled'] &&
                    se(a['hud.status.thirst.enabled']),
                  void 0 !== a['hud.status.oxygen.enabled'] &&
                    ie(a['hud.status.oxygen.enabled']),
                  void 0 !== a['hud.status.stress.enabled'] &&
                    de(a['hud.status.stress.enabled']),
                  void 0 !== a['hud.status.enhancements.enabled'] &&
                    Zt(a['hud.status.enhancements.enabled']),
                  void 0 !== a['hud.status.health.hideValue'] &&
                    ir(a['hud.status.health.hideValue'], false),
                  void 0 !== a['hud.status.armor.hideValue'] &&
                    nr(a['hud.status.armor.hideValue'], false),
                  void 0 !== a['hud.status.hunger.hideValue'] &&
                    or(a['hud.status.hunger.hideValue'], false),
                  void 0 !== a['hud.status.thirst.hideValue'] &&
                    lr(a['hud.status.thirst.hideValue'], false),
                  void 0 !== a['hud.status.radio.channel.visibility'] &&
                    ua(a['hud.status.radio.channel.visibility']),
                  void 0 !== a['hud.vehicle.minimap.enabled'] &&
                    ks(a['hud.vehicle.minimap.enabled']),
                  void 0 !== a['hud.vehicle.minimap.default'] &&
                    Cs(a['hud.vehicle.minimap.default']),
                  void 0 !== a['hud.vehicle.minimap.outline'] &&
                    Bs(a['hud.vehicle.minimap.outline']),
                  void 0 !== a['hud.vehicle.speedometer.fps'] && rs('64'),
                  void 0 !== a['hud.compass.enabled'] &&
                    Dt(a['hud.compass.enabled']),
                  void 0 !== a['hud.compass.fps'] && ts(a['hud.compass.fps']),
                  void 0 !== a['hud.compass.roadnames.enabled'] &&
                    Vt(a['hud.compass.roadnames.enabled']),
                  void 0 !== a['hud.blackbars.enabled'] &&
                    Jt(a['hud.blackbars.enabled']),
                  void 0 !== a['hud.blackbars.value'] &&
                    os(a['hud.blackbars.value']),
                  void 0 !== a['phone.misc.brand'] && Ps(a['phone.misc.brand']),
                  void 0 !== a['phone.misc.background'] &&
                    Rs(a['phone.misc.background']),
                  void 0 !== a['phone.misc.receive.sms'] &&
                    Ks(a['phone.misc.receive.sms']),
                  void 0 !== a['phone.misc.new.tweet'] &&
                    Xs(a['phone.misc.new.tweet']),
                  void 0 !== a['phone.misc.receive.email'] &&
                    $s(a['phone.misc.receive.email']),
                  void 0 !== a['phone.misc.embedded.images'] &&
                    sa(a['phone.misc.embedded.images']),
                  x('fa-hud:hudSetPreferences', a)),
                'buffs' === s &&
                  (void 0 !== a.buffedBikeStats
                    ? 'number' === typeof a.buffedBikeStats &&
                      (a.buffedBikeStats > 0
                        ? (uh(true),
                          Xd(a.buffedBikeStats),
                          $d(true),
                          sh(1),
                          setTimeout(function () {
                            var e = Number(a.buffedBikeStats),
                              t = 40 * Math.PI,
                              s = -(t - ((100 * e) / 100 / 100) * t)
                            ih(''.concat(t))
                            dh(''.concat(s))
                          }, 500))
                        : 0 === a.buffedBikeStats &&
                          (sh(0),
                          uh(false),
                          ih('125.66370614359172'),
                          dh('125.66370614359172'),
                          setTimeout(function () {
                            $d(false)
                          }, 2000)))
                    : (sh(0),
                      uh(false),
                      ih('125.66370614359172'),
                      dh('125.66370614359172'),
                      setTimeout(function () {
                        $d(false)
                      }, 2000)),
                  void 0 !== a.buffedOxygen &&
                    (true === a.buffedOxygen ? Oa(true) : Oa(false)),
                  void 0 !== a.buffedHunger &&
                    (true === a.buffedHunger
                      ? (ga(true), Si || Yt || (Ni(true), Wi(1)))
                      : (ga(false),
                        li >= bi &&
                          (Wi(0),
                          setTimeout(function () {
                            Ni(false)
                          }, 2000)))),
                  void 0 !== a.buffedStress &&
                    (true === a.buffedStress
                      ? (Na(true), Kn || Yt || (Gn(true), Qn(1)))
                      : (Na(false),
                        En <= 1 &&
                          (Qn(0),
                          setTimeout(function () {
                            Gn(false)
                          }, 2000)))),
                  void 0 !== a.buffedInt
                    ? 'number' === typeof a.buffedInt &&
                      (a.buffedInt > 0
                        ? (Io(true),
                          io(a.buffedInt),
                          ho(true),
                          xo(1),
                          setTimeout(function () {
                            var e = Number(a.buffedInt),
                              t = 40 * Math.PI,
                              s = -(t - ((100 * e) / 100 / 100) * t)
                            mo(''.concat(t))
                            yo(''.concat(s))
                          }, 500))
                        : 0 === a.buffedInt &&
                          (xo(0),
                          Io(false),
                          mo('125.66370614359172'),
                          yo('125.66370614359172'),
                          setTimeout(function () {
                            ho(false)
                          }, 2000)))
                    : (xo(0),
                      Io(false),
                      mo('125.66370614359172'),
                      yo('125.66370614359172'),
                      setTimeout(function () {
                        ho(false)
                      }, 2000)),
                  void 0 !== a.buffedStrength
                    ? 'number' === typeof a.buffedStrength &&
                      (a.buffedStrength > 0
                        ? (xl(true),
                          Qo(a.buffedStrength),
                          _o(true),
                          al(1),
                          setTimeout(function () {
                            var e = Number(a.buffedStrength),
                              t = 40 * Math.PI,
                              s = t - ((100 * e) / 100 / 100) * t
                            nl(''.concat(t))
                            hl(''.concat(s))
                          }, 500))
                        : 0 === a.buffedStrength &&
                          (al(0),
                          xl(false),
                          nl('125.66370614359172'),
                          hl('125.66370614359172'),
                          setTimeout(function () {
                            _o(false)
                          }, 2000)))
                    : (al(0),
                      xl(false),
                      nl('125.66370614359172'),
                      hl('125.66370614359172'),
                      setTimeout(function () {
                        _o(false)
                      }, 2000)),
                  void 0 !== a.buffedJobpay &&
                    (true === a.buffedJobpay
                      ? (El(true),
                        Ol(1),
                        gl(true),
                        Nl(1),
                        setTimeout(function () {
                          var e = 40 * Math.PI,
                            t = e - 0.01 * e
                          Wl(''.concat(e))
                          Tl(''.concat(t))
                        }, 500))
                      : false === a.buffedJobpay &&
                        (Nl(0),
                        El(false),
                        Wl('125.66370614359172'),
                        Tl('125.66370614359172'),
                        setTimeout(function () {
                          gl(false)
                        }, 2000))),
                  void 0 !== a.buffedAlertness &&
                    (true === a.buffedAlertness
                      ? (Nd(true),
                        id(1),
                        dd(true),
                        ud(1),
                        setTimeout(function () {
                          var e = 40 * Math.PI,
                            t = e - 0.01 * e
                          Od(''.concat(e))
                          gd(''.concat(t))
                        }, 500))
                      : false === a.buffedAlertness &&
                        (ud(0),
                        Nd(false),
                        Od('125.66370614359172'),
                        gd('125.66370614359172'),
                        setTimeout(function () {
                          dd(false)
                        }, 2000)))),
                'hud' === s)
              ) {
                if (
                  (void 0 !== a.displayRadioChannel && R(a.displayRadioChannel),
                  void 0 !== a.displayAllForce &&
                    (true === a.displayAllForce
                      ? (Ta(true),
                        tc || (sc(true), ic(1), Ea(true)),
                        qc || (Xc(true), $c(1), La(true)),
                        Si || (Ni(true), Wi(1), Ua(true)),
                        an || (rn(true), ln(1), Ya(true)),
                        gn || (yn(true), In(1), er(true)),
                        Kn || (Gn(true), Qn(1), rr(true)))
                      : (Aa &&
                          (ic(0),
                          setTimeout(function () {
                            sc(false)
                          }, 2000)),
                        Ha &&
                          ($c(0),
                          setTimeout(function () {
                            Xc(false)
                          }, 2000)),
                        Ga &&
                          (Wi(0),
                          setTimeout(function () {
                            Ni(false)
                          }, 2000)),
                        Qa &&
                          (ln(0),
                          setTimeout(function () {
                            rn(false)
                          }, 2000)),
                        _a &&
                          (In(0),
                          setTimeout(function () {
                            yn(false)
                          }, 2000)),
                        ar &&
                          (Qn(0),
                          setTimeout(function () {
                            Gn(false)
                          }, 2000)),
                        Ea(false),
                        La(false),
                        Ua(false),
                        Ya(false),
                        er(false),
                        rr(false),
                        Ta(false))),
                  void 0 !== a.display)
                ) {
                  if ((c(a.display), a.display)) {
                    br(true)
                    Cr(1)
                    var r = 40 * Math.PI,
                      i = r - 0.66 * r
                    Br(''.concat(r))
                    Pr(''.concat(i))
                  } else {
                    ho(false)
                    xo(0)
                    Fo(false)
                    Ao(0)
                    _o(false)
                    al(0)
                    gl(false)
                    Nl(0)
                    Kl(false)
                    Xl(0)
                    dd(false)
                    ud(0)
                    Bd(false)
                    Pd(0)
                    $d(false)
                    sh(0)
                    vh(false)
                    kh(0)
                    Eh(false)
                    Uh(0)
                  }
                }
                if (void 0 !== a.voiceRange) {
                  var n = 33
                  1 === a.voiceRange
                    ? (n = 33)
                    : 2 === a.voiceRange
                    ? (n = 66)
                    : 3 === a.voiceRange && (n = 100)
                  var o = 40 * Math.PI,
                    l = o - ((100 * n) / 100 / 100) * o
                  Br(''.concat(o))
                  Pr(''.concat(l))
                }
                if (void 0 !== a.health) {
                  if (
                    (Rr(a.health),
                    setTimeout(function () {
                      var e = Number(a.health),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      dc(''.concat(t))
                      uc(''.concat(s))
                      a.health < 10 ? $r(true) : $r(false)
                    }, 500),
                    a.health <= Jr || 100 === Jr)
                  ) {
                    ;((true === J && a.health <= Jr) || 100 === Jr) &&
                      (sc(true), ic(1))
                    false !== J || Fa || (sc(false), ic(0))
                  } else {
                    if ((100 === a.health || a.health > 100) && !Fa) {
                      var d = Number(a.health),
                        h = 40 * Math.PI,
                        j = h - ((100 * d) / 100 / 100) * h
                      dc(''.concat(h))
                      uc(''.concat(j))
                      ic(0)
                      $r(false)
                      setTimeout(function () {
                        sc(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.armor) {
                  if (
                    (Bc(a.armor),
                    setTimeout(function () {
                      var e = Number(a.armor),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      si(''.concat(t))
                      ii(''.concat(s))
                      a.armor < 10 ? Kc(true) : Kc(false)
                    }, 500),
                    a.armor <= Dc || 100 === Dc)
                  ) {
                    ;((true === q && a.armor <= Dc) || 100 === Dc) &&
                      (Xc(true), $c(1))
                    false !== q || Fa || (Xc(false), $c(0))
                  } else {
                    if ((100 === a.armor || a.armor > 100) && !Fa) {
                      var b = Number(a.armor),
                        u = 40 * Math.PI,
                        f = u - ((100 * b) / 100 / 100) * u
                      si(''.concat(u))
                      ii(''.concat(f))
                      $c(0)
                      Kc(false)
                      setTimeout(function () {
                        Xc(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.hunger) {
                  if (
                    (di(a.hunger),
                    setTimeout(function () {
                      var e = Number(a.hunger),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      Ti(''.concat(t))
                      Ei(''.concat(s))
                      a.hunger < 10 ? gi(true) : gi(false)
                    }, 500),
                    Number(a.hunger) <= bi || 100 === bi)
                  ) {
                    ;((true === Z && a.hunger <= bi) || 100 === bi) &&
                      (Ni(true), Wi(1))
                    false !== Z || Fa || (Ni(false), Wi(0))
                  } else {
                    if ((100 === a.hunger || a.hunger > 100) && !Fa && !wa) {
                      var p = Number(a.hunger),
                        O = 40 * Math.PI,
                        m = O - ((100 * p) / 100 / 100) * O
                      Ti(''.concat(O))
                      Ei(''.concat(m))
                      Wi(0)
                      gi(false)
                      setTimeout(function () {
                        Ni(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.thirst) {
                  if (
                    (Li(a.thirst),
                    setTimeout(function () {
                      var e = Number(a.thirst),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      bn(''.concat(t))
                      pn(''.concat(s))
                      a.thirst < 10 ? en(true) : en(false)
                    }, 500),
                    a.thirst <= Gi || 100 === Gi)
                  ) {
                    ;((true === te && a.thirst <= Gi) || 100 === Gi) &&
                      (rn(true), ln(1))
                    false !== te || Fa || (rn(false), ln(0))
                  } else {
                    if ((100 === a.thirst || a.thirst > 100) && !Fa) {
                      var v = Number(a.thirst),
                        w = 40 * Math.PI,
                        g = w - ((100 * v) / 100 / 100) * w
                      bn(''.concat(w))
                      pn(''.concat(g))
                      ln(0)
                      en(false)
                      setTimeout(function () {
                        rn(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.oxygen) {
                  if (a.oxygen < 25) {
                    true === ce && a.oxygen < 25 && (yn(true), In(1))
                    false !== ce || Fa || (yn(false), In(0))
                    setTimeout(function () {
                      var e = Number(a.oxygen),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      zn(''.concat(t))
                      Dn(''.concat(s))
                    }, 500)
                  } else {
                    if (a.oxygen >= 25 && !Fa) {
                      var y = Number(a.oxygen),
                        k = 40 * Math.PI,
                        S = k - ((100 * y) / 100 / 100) * k
                      zn(''.concat(k))
                      Dn(''.concat(S))
                      In(0)
                      setTimeout(function () {
                        yn(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.stress) {
                  if ((Vn(a.stress), a.stress >= 1)) {
                    true === le && (Gn(true), Qn(1))
                    false !== le || Fa || (Gn(false), Qn(0))
                    setTimeout(function () {
                      var e = Number(a.stress),
                        t = 40 * Math.PI,
                        s = t - ((100 * e) / 100 / 100) * t
                      _n(''.concat(t))
                      ao(''.concat(s))
                    }, 500)
                  } else {
                    if ((a.stress <= 1 || 0 === a.stress) && !Fa) {
                      var N = Number(a.stress),
                        I = 40 * Math.PI,
                        C = I - ((100 * N) / 100 / 100) * I
                      _n(''.concat(I))
                      ao(''.concat(C))
                      Qn(0)
                      setTimeout(function () {
                        Gn(false)
                      }, 2000)
                    }
                  }
                }
                if (void 0 !== a.fuel) {
                  var M = Number(a.fuel),
                    W = 27 * Math.PI,
                    z = -(W - ((145 * -((100 * M) / 220)) / 100 / 100) * W)
                  Ue(''.concat(W))
                  Ye(''.concat(z))
                  It(M)
                  et('#fff')
                  M <= 15 && et('red')
                }
                if (
                  (void 0 !== a.altitudeShow && Ne(a.altitudeShow),
                  void 0 !== a.voiceActive &&
                    (true === a.voiceActive
                      ? (fr('rgb(213, 205, 49)'), vr(true))
                      : (fr('#fff'), vr(false))),
                  void 0 !== a.voiceActiveRadio &&
                    (true === a.voiceActiveRadio
                      ? (fr('#C05D5D'), kr(true))
                      : (fr('#fff'), kr(false))),
                  void 0 !== a.hasRadio && B(a.hasRadio),
                  void 0 !== a.carHudShow && Oe(a.carHudShow),
                  void 0 !== a.waypointActive && ue(a.waypointActive),
                  void 0 !== a.waypointDistance &&
                    Te(a.waypointDistance.toFixed(2).toString()),
                  void 0 !== a.beltShow && ge(a.beltShow),
                  void 0 !== a.engineDamageShow && We(a.engineDamageShow),
                  void 0 !== a.harnessDurability)
                ) {
                  var F = 0
                  if (
                    (1 === a.harnessDurability
                      ? (F = 35)
                      : 2 === a.harnessDurability
                      ? (F = 50)
                      : 3 === a.harnessDurability && (F = 100),
                    a.harnessDurability > 0)
                  ) {
                    vh(true)
                    kh(1)
                    var T = 40 * Math.PI,
                      D = T - ((100 * F) / 100 / 100) * T
                    Ch(''.concat(T))
                    Bh(''.concat(D))
                  } else {
                    kh(0)
                    Ch('125.66370614359172')
                    Bh('125.66370614359172')
                    setTimeout(function () {
                      vh(false)
                    }, 2000)
                  }
                }
                if (
                  void 0 !== a.nosShow &&
                  void 0 !== a.nosEnabled &&
                  void 0 !== a.nos
                ) {
                  if (a.nos > 0 && true === a.nosShow) {
                    var A = a.nos
                    ob(true)
                    jb(1)
                    var E = 40 * Math.PI,
                      V = E - ((100 * A) / 100 / 100) * E
                    fb(''.concat(E))
                    vb(''.concat(V))
                  } else {
                    jb(0)
                    fb('125.66370614359172')
                    vb('125.66370614359172')
                    setTimeout(function () {
                      ob(false)
                    }, 2000)
                  }
                }
                if (
                  (void 0 !== a.showWeaponFireRate &&
                    (true === a.showWeaponFireRate
                      ? (Xj(true), $j(1))
                      : ($j(0),
                        setTimeout(function () {
                          Xj(false)
                        }, 2000))),
                  void 0 !== a.pursuit)
                ) {
                  var H = 0
                  1 === a.pursuit
                    ? (H = 35)
                    : 2 === a.pursuit
                    ? (H = 50)
                    : 3 === a.pursuit && (H = 100)
                  var L = 40 * Math.PI,
                    G = L - ((100 * H) / 100 / 100) * L
                  Yh(''.concat(L))
                  ej(''.concat(G))
                }
                void 0 !== a.pursuitShow &&
                  (true === a.pursuitShow && true === la
                    ? (Lh(true), Eh(true), Uh(1))
                    : (Uh(0),
                      setTimeout(function () {
                        Lh(false)
                        Eh(false)
                      }, 2000)))
                a.harnessShow
              } else {
                if ('game' === s) {
                  void 0 !== a.modeDev &&
                    (true === a.modeDev
                      ? (Rb(a.modeDev), Kb(1))
                      : (Kb(0),
                        setTimeout(function () {
                          Rb(a.modeDev)
                        }, 2000)))
                  void 0 !== a.modeGod &&
                    (true === a.modeGod ? vs(true) : vs(false))
                  void 0 !== a.inVehicle && da(a.inVehicle)
                  void 0 !== a.radioChannel && P(a.radioChannel)
                } else {
                  if ('hud.compass' === s) {
                    if (
                      (void 0 !== a.showCompass && js(a.showCompass),
                      void 0 !== a.showRoadNames && fs(a.showRoadNames),
                      void 0 !== a.alt)
                    ) {
                      var U = Number(a.alt),
                        Q = 54 * Math.PI,
                        Y = -(Q - ((50 * -((100 * U) / 220)) / 100 / 100) * Q)
                      rt(''.concat(Q, ' ').concat(Q))
                      ot(''.concat(Y))
                      zt(U)
                    }
                    if (
                      (void 0 !== a.area && jt(a.area),
                      void 0 !== a.street && ft(a.street),
                      void 0 !== a.heading)
                    ) {
                      var _ = Number(a.heading) + 90
                      360 === a.heading ? vt(0) : vt(-_)
                    }
                    if (void 0 !== a.speed) {
                      var ee = Number(a.speed),
                        ae = 54 * Math.PI,
                        re = -(
                          ae -
                          ((50 * -((100 * ee) / 220)) / 100 / 100) * ae
                        )
                      Ee(''.concat(ae, ' ').concat(ae))
                      Le(''.concat(re))
                      kt(ee)
                    }
                  }
                }
              }
            }),
            h('toggleSettings', function (e) {
              e.show && (ia(0), j(true))
            }),
            Object(a.useEffect)(function () {
              window.invokeNative ||
                (br(true),
                Cr(1),
                setTimeout(function () {
                  var e = 40 * Math.PI,
                    t = -(e - 1 * e)
                  Br(''.concat(e))
                  Pr(''.concat(t))
                }, 500))
            }),
            (function (e) {
              var t = Object(a.useRef)(d)
              Object(a.useEffect)(
                function () {
                  t.current = e
                },
                [e]
              )
              Object(a.useEffect)(function () {
                var e = function (e) {
                  p.includes(e.code) && (t.current(false), x('hideFrame'))
                }
                return (
                  window.addEventListener('keydown', e),
                  function () {
                    return window.removeEventListener('keydown', e)
                  }
                )
              }, [])
            })(j),
            Object(z.jsxs)(z.Fragment, {
              children: [
                Object(z.jsx)(O.a, {
                  container: true,
                  className: e.root,
                  style: {
                    display: Lt ? '' : 'none',
                    zIndex: 1000000,
                  },
                  children: Object(z.jsxs)('div', {
                    style: {
                      display: 'flex',
                      width: '100vw',
                      height: '100vh',
                      position: 'absolute',
                      left: '0px',
                      top: '0px',
                      flexDirection: 'column',
                    },
                    children: [
                      Object(z.jsx)('div', {
                        style: {
                          backgroundColor: 'black',
                          height: ''.concat(
                            Number(ns) >= 40 ? '40vh' : ''.concat(ns, 'vh')
                          ),
                          width: '100vw',
                        },
                      }),
                      Object(z.jsx)('div', {
                        style: {
                          flex: '1 1 0%',
                          width: '100vw',
                          height: '100%',
                        },
                      }),
                      Object(z.jsx)('div', {
                        style: {
                          backgroundColor: 'black',
                          height: ''.concat(
                            Number(ns) >= 40 ? '40vh' : ''.concat(ns, 'vh')
                          ),
                          width: '100vw',
                        },
                      }),
                    ],
                  }),
                }),
                Object(z.jsx)(O.a, {
                  container: true,
                  className: e.root,
                  children: Object(z.jsx)('div', {
                    className: 'hud.compass-app-wrapper',
                    style: {
                      display: hs && Tt ? 'flex' : 'none',
                      position: 'absolute',
                      top: '0px',
                      left: '0px',
                      width: '100vw',
                      height: '32px',
                      pointerEvents: 'none',
                      placeContent: 'center',
                      color: 'white',
                    },
                    children: Object(z.jsx)('div', {
                      style: {
                        width: '100vw',
                        height: '52px',
                        display: 'flex',
                        justifyContent: 'unset',
                        flexDirection: 'column',
                      },
                      children: Object(z.jsxs)('div', {
                        style: {
                          width: '100vw',
                          height: '32px',
                          display: 'flex',
                          justifyContent: 'center',
                        },
                        children: [
                          Object(z.jsx)('div', {
                            style: {
                              flex: '1 1 0%',
                              display: 'flex',
                              justifyContent: 'center',
                              alignItems: 'center',
                              margin: '0px 16px',
                              textAlign: 'right',
                              opacity: xs ? '1' : '0',
                            },
                            children: Object(z.jsx)(m.a, {
                              style: {
                                textShadow:
                                  'rgb(55, 71, 79) -1px 1px 0px, rgb(55, 71, 79) 1px 1px 0px, rgb(55, 71, 79) 1px -1px 0px, rgb(55, 71, 79) -1px -1px 0px',
                                fontFamily: 'Arial, Helvetica, sans-serif',
                                letterSpacing: '0px',
                                fontWeight: 600,
                                textDecoration: 'none',
                                fontStyle: 'normal',
                                fontVariant: 'small-caps',
                                textTransform: 'none',
                                width: '100%',
                              },
                              variant: 'body1',
                              gutterBottom: true,
                              children: ht,
                            }),
                          }),
                          Object(z.jsx)('div', {
                            style: {
                              width: '180px',
                              position: 'relative',
                              overflow: 'hidden',
                              backgroundImage:
                                'url(https://gta-assets.nopixel.net/images/compass.png)',
                              backgroundRepeat: 'repeat',
                              backgroundSize: '360px 32px',
                              display: 'flex',
                              justifyContent: 'center',
                              backgroundPositionX: mt,
                            },
                            children: Object(z.jsx)('img', {
                              src: 'https://gta-assets.nopixel.net/images/compass-marker.png',
                              alt: '',
                              style: { height: '12px' },
                            }),
                          }),
                          Object(z.jsx)('div', {
                            style: {
                              flex: '1 1 0%',
                              display: 'flex',
                              justifyContent: 'center',
                              alignItems: 'center',
                              margin: '0px 16px',
                              textAlign: 'left',
                              opacity: xs && Et ? '1' : '0',
                            },
                            children: Object(z.jsx)(m.a, {
                              style: {
                                textShadow:
                                  'rgb(55, 71, 79) -1px 1px 0px, rgb(55, 71, 79) 1px 1px 0px, rgb(55, 71, 79) 1px -1px 0px, rgb(55, 71, 79) -1px -1px 0px',
                                fontFamily: 'Arial, Helvetica, sans-serif',
                                letterSpacing: '0px',
                                fontWeight: 600,
                                textDecoration: 'none',
                                fontStyle: 'normal',
                                fontVariant: 'small-caps',
                                textTransform: 'none',
                                width: '100%',
                              },
                              variant: 'body1',
                              gutterBottom: true,
                              children: xt,
                            }),
                          }),
                        ],
                      }),
                    }),
                  }),
                }),
                Object(z.jsx)(O.a, {
                  container: true,
                  className: e.root,
                  style: {
                    display: o ? '' : 'none',
                    justifyContent: 'center',
                    alignItems: 'center',
                  },
                  children: Object(z.jsxs)('div', {
                    className: 'hud-settings-container',
                    children: [
                      Object(z.jsxs)('div', {
                        className: 'hud-settings-sidebar',
                        children: [
                          Object(z.jsx)('div', {
                            onClick: function () {
                              return ia(1)
                            },
                            className: 'hud-settings-sidebar-tab',
                            style: {
                              backgroundColor:
                                1 === ca
                                  ? 'rgb(34, 40, 49)'
                                  : 'rgb(48, 71, 94)',
                            },
                            children: Object(z.jsx)(m.a, {
                              style: {
                                color: '#fff',
                                wordBreak: 'break-word',
                              },
                              variant: 'body1',
                              gutterBottom: true,
                              children: 'HUD',
                            }),
                          }),
                          Object(z.jsx)('div', {
                            onClick: function () {
                              return ia(2)
                            },
                            className: 'hud-settings-sidebar-tab null',
                            style: {
                              backgroundColor:
                                2 === ca
                                  ? 'rgb(34, 40, 49)'
                                  : 'rgb(48, 71, 94)',
                            },
                            children: Object(z.jsx)(m.a, {
                              style: {
                                color: '#fff',
                                wordBreak: 'break-word',
                              },
                              variant: 'body1',
                              gutterBottom: true,
                              children: 'Phone',
                            }),
                          }),
                        ],
                      }),
                      Object(z.jsxs)('div', {
                        className: 'hud-settings-body',
                        children: [
                          Object(z.jsxs)('div', {
                            className: 'hud-settings-hud-container',
                            style: { display: 1 === ca ? 'flex' : 'none' },
                            children: [
                              Object(z.jsx)('div', {
                                children: Object(z.jsxs)('div', {
                                  className: 'hud-row-double',
                                  children: [
                                    Object(z.jsx)(m.a, {
                                      style: {
                                        color: '#fff',
                                        wordBreak: 'break-word',
                                      },
                                      variant: 'h6',
                                      gutterBottom: true,
                                      children: 'Settings',
                                    }),
                                    Object(z.jsx)('div', {
                                      style: {
                                        display: 'flex',
                                        justifyContent: 'flex-end',
                                      },
                                      children: Object(z.jsx)('div', {
                                        children: Object(z.jsx)(v.a, {
                                          onClick: cr,
                                          size: 'small',
                                          color: 'success',
                                          variant: 'contained',
                                          children: 'Save',
                                        }),
                                      }),
                                    }),
                                  ],
                                }),
                              }),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Misc',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: Ut,
                                          onChange: function (e) {
                                            return qt(e.target.checked)
                                          },
                                        }),
                                        label: 'Enable Circle Taskbar',
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Status',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'hud-row-double',
                                      children: [
                                        Object(z.jsx)('div', {
                                          style: { maxWidth: '35%' },
                                          children: Object(z.jsx)(w.a, {
                                            className: 'jss255',
                                            children: Object(z.jsx)(g.a, {
                                              control: Object(z.jsx)(y.a, {
                                                color: 'warning',
                                                checked: J,
                                                onChange: function (e) {
                                                  true === e.target.checked
                                                    ? (K(true), sc(true), ic(1))
                                                    : (K(false),
                                                      ic(0),
                                                      setTimeout(function () {
                                                        sc(false)
                                                      }, 2000))
                                                },
                                              }),
                                              label: 'Show Health',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'input-wrapper',
                                          style: { display: J ? '' : 'none' },
                                          children: Object(z.jsx)(k.a, {
                                            fullWidth: true,
                                            sx: { width: '100%' },
                                            children: Object(z.jsx)(S.a, {
                                              sx: {
                                                '& .MuiInput-root': {
                                                  color: 'white !important',
                                                },
                                                '& label.Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                    color:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:after': {
                                                  borderColor:
                                                    'white !important',
                                                  color: 'darkgray !important',
                                                },
                                                '& .Mui-focused:after': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInputAdornment-root': {
                                                  color: 'darkgray !important',
                                                },
                                              },
                                              id: 'input-with-icon-textfield',
                                              label:
                                                'Hide when more than... (100 = never hide)',
                                              variant: 'standard',
                                              value: qr,
                                              onChange: function (e) {
                                                return Xr(
                                                  Number(e.target.value)
                                                )
                                              },
                                              onKeyDown: function (e) {
                                                return ir(e, true)
                                              },
                                              InputProps: {
                                                startAdornment: Object(z.jsx)(
                                                  N.a,
                                                  {
                                                    position: 'start',
                                                    children: Object(z.jsx)(
                                                      'i',
                                                      {
                                                        className:
                                                          'fas fa-percent',
                                                      }
                                                    ),
                                                  }
                                                ),
                                              },
                                            }),
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'hud-row-double',
                                      children: [
                                        Object(z.jsx)('div', {
                                          style: { maxWidth: '35%' },
                                          children: Object(z.jsx)(w.a, {
                                            className: 'jss255',
                                            children: Object(z.jsx)(g.a, {
                                              control: Object(z.jsx)(y.a, {
                                                color: 'warning',
                                                checked: q,
                                                onChange: function (e) {
                                                  true === e.target.checked
                                                    ? (X(true), Xc(true), $c(1))
                                                    : (X(false),
                                                      $c(0),
                                                      setTimeout(function () {
                                                        Xc(false)
                                                        X(false)
                                                      }, 2000))
                                                },
                                              }),
                                              label: 'Show Armor',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'input-wrapper',
                                          style: { display: q ? '' : 'none' },
                                          children: Object(z.jsx)(k.a, {
                                            fullWidth: true,
                                            sx: { width: '100%' },
                                            children: Object(z.jsx)(S.a, {
                                              sx: {
                                                '& .MuiInput-root': {
                                                  color: 'white !important',
                                                },
                                                '& label.Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                    color:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:after': {
                                                  borderColor:
                                                    'white !important',
                                                  color: 'darkgray !important',
                                                },
                                                '& .Mui-focused:after': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInputAdornment-root': {
                                                  color: 'darkgray !important',
                                                },
                                              },
                                              id: 'input-with-icon-textfield',
                                              label:
                                                'Hide when more than... (100 = never hide)',
                                              variant: 'standard',
                                              value: Vc,
                                              onChange: function (e) {
                                                return Rc(
                                                  Number(e.target.value)
                                                )
                                              },
                                              onKeyDown: function (e) {
                                                return nr(e, true)
                                              },
                                              InputProps: {
                                                startAdornment: Object(z.jsx)(
                                                  N.a,
                                                  {
                                                    position: 'start',
                                                    children: Object(z.jsx)(
                                                      'i',
                                                      {
                                                        className:
                                                          'fas fa-percent',
                                                      }
                                                    ),
                                                  }
                                                ),
                                              },
                                            }),
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'hud-row-double',
                                      children: [
                                        Object(z.jsx)('div', {
                                          style: { maxWidth: '35%' },
                                          children: Object(z.jsx)(w.a, {
                                            className: 'jss255',
                                            children: Object(z.jsx)(g.a, {
                                              control: Object(z.jsx)(y.a, {
                                                color: 'warning',
                                                checked: Z,
                                                onChange: function (e) {
                                                  true === e.target.checked
                                                    ? ($(true), Ni(true), Wi(1))
                                                    : ($(false),
                                                      Wi(0),
                                                      setTimeout(function () {
                                                        Ni(false)
                                                      }, 2000))
                                                },
                                              }),
                                              label: 'Show Food',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'input-wrapper',
                                          style: { display: Z ? '' : 'none' },
                                          children: Object(z.jsx)(k.a, {
                                            fullWidth: true,
                                            sx: { width: '100%' },
                                            children: Object(z.jsx)(S.a, {
                                              sx: {
                                                '& .MuiInput-root': {
                                                  color: 'white !important',
                                                },
                                                '& label.Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                    color:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:after': {
                                                  borderColor:
                                                    'white !important',
                                                  color: 'darkgray !important',
                                                },
                                                '& .Mui-focused:after': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInputAdornment-root': {
                                                  color: 'darkgray !important',
                                                },
                                              },
                                              id: 'input-with-icon-textfield',
                                              label:
                                                'Hide when more than... (100 = never hide)',
                                              variant: 'standard',
                                              value: pi,
                                              onChange: function (e) {
                                                return Oi(
                                                  Number(e.target.value)
                                                )
                                              },
                                              onKeyDown: function (e) {
                                                return or(e, true)
                                              },
                                              InputProps: {
                                                startAdornment: Object(z.jsx)(
                                                  N.a,
                                                  {
                                                    position: 'start',
                                                    children: Object(z.jsx)(
                                                      'i',
                                                      {
                                                        className:
                                                          'fas fa-percent',
                                                      }
                                                    ),
                                                  }
                                                ),
                                              },
                                            }),
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'hud-row-double',
                                      children: [
                                        Object(z.jsx)('div', {
                                          style: { maxWidth: '35%' },
                                          children: Object(z.jsx)(w.a, {
                                            className: 'jss255',
                                            children: Object(z.jsx)(g.a, {
                                              control: Object(z.jsx)(y.a, {
                                                color: 'warning',
                                                checked: te,
                                                onChange: function (e) {
                                                  true === e.target.checked
                                                    ? (se(true),
                                                      rn(true),
                                                      ln(1))
                                                    : (se(false),
                                                      ln(0),
                                                      setTimeout(function () {
                                                        rn(false)
                                                      }, 2000))
                                                },
                                              }),
                                              label: 'Show Water',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'input-wrapper',
                                          style: { display: te ? '' : 'none' },
                                          children: Object(z.jsx)(k.a, {
                                            fullWidth: true,
                                            sx: { width: '100%' },
                                            children: Object(z.jsx)(S.a, {
                                              sx: {
                                                '& .MuiInput-root': {
                                                  color: 'white !important',
                                                },
                                                '& label.Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& Mui-focused': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:before':
                                                  {
                                                    borderColor:
                                                      'darkgray !important',
                                                    color:
                                                      'darkgray !important',
                                                  },
                                                '& .MuiInput-underline:after': {
                                                  borderColor:
                                                    'white !important',
                                                  color: 'darkgray !important',
                                                },
                                                '& .Mui-focused:after': {
                                                  color: 'darkgray !important',
                                                },
                                                '& .MuiInputAdornment-root': {
                                                  color: 'darkgray !important',
                                                },
                                              },
                                              id: 'input-with-icon-textfield',
                                              label:
                                                'Hide when more than... (100 = never hide)',
                                              variant: 'standard',
                                              value: Qi,
                                              onChange: function (e) {
                                                return Yi(
                                                  Number(e.target.value)
                                                )
                                              },
                                              onKeyDown: function (e) {
                                                return lr(e, true)
                                              },
                                              InputProps: {
                                                startAdornment: Object(z.jsx)(
                                                  N.a,
                                                  {
                                                    position: 'start',
                                                    children: Object(z.jsx)(
                                                      'i',
                                                      {
                                                        className:
                                                          'fas fa-percent',
                                                      }
                                                    ),
                                                  }
                                                ),
                                              },
                                            }),
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'hud-row-double',
                                      children: [
                                        Object(z.jsx)(w.a, {
                                          className: 'jss255',
                                          children: Object(z.jsx)(g.a, {
                                            control: Object(z.jsx)(y.a, {
                                              color: 'warning',
                                              checked: le,
                                              onChange: function (e) {
                                                true === e.target.checked
                                                  ? (de(true), Gn(true), Qn(1))
                                                  : (de(false),
                                                    Qn(0),
                                                    setTimeout(function () {
                                                      Gn(false)
                                                    }, 2000))
                                              },
                                            }),
                                            label: 'Show Stress when relevant',
                                          }),
                                        }),
                                        Object(z.jsx)(w.a, {
                                          className: 'jss255',
                                          children: Object(z.jsx)(g.a, {
                                            control: Object(z.jsx)(y.a, {
                                              color: 'warning',
                                              checked: ce,
                                              onChange: function (e) {
                                                true === e.target.checked
                                                  ? (ie(true), yn(true), In(1))
                                                  : (ie(false),
                                                    In(0),
                                                    setTimeout(function () {
                                                      yn(false)
                                                    }, 2000))
                                              },
                                            }),
                                            label: 'Show Oxygen when relevant',
                                          }),
                                        }),
                                        Object(z.jsx)(w.a, {
                                          className: 'jss255',
                                          children: Object(z.jsx)(g.a, {
                                            control: Object(z.jsx)(y.a, {
                                              color: 'warning',
                                              checked: Yt,
                                              onChange: function (e) {
                                                true === e.target.checked
                                                  ? (Zt(true),
                                                    wa &&
                                                      Si &&
                                                      li >= bi &&
                                                      (Wi(0),
                                                      setTimeout(function () {
                                                        Ni(false)
                                                      }, 2000)),
                                                    Sa &&
                                                      Kn &&
                                                      En <= 1 &&
                                                      (Qn(0),
                                                      setTimeout(function () {
                                                        Gn(false)
                                                      }, 2000)))
                                                  : (Zt(false),
                                                    wa &&
                                                      (Si || (Ni(true), Wi(1))),
                                                    Sa &&
                                                      (Kn || (Gn(true), Qn(1))))
                                              },
                                            }),
                                            label: 'Hide Enhancements',
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)(k.a, {
                                      className: 'formControlClass',
                                      variant: 'standard',
                                      fullWidth: true,
                                      children: [
                                        Object(z.jsx)(I.a, {
                                          id: 'demo-simple-select-label',
                                          children: 'Radio Channel Visibility',
                                        }),
                                        Object(z.jsxs)(C.a, {
                                          labelId: 'demo-simple-select-label',
                                          id: 'demo-simple-select',
                                          label: 'Radio Channel Visibility',
                                          defaultValue: '3',
                                          value: ba,
                                          onChange: function (e) {
                                            return ua(e.target.value)
                                          },
                                          children: [
                                            Object(z.jsx)(M.a, {
                                              value: '1',
                                              children: 'Never',
                                            }),
                                            Object(z.jsx)(M.a, {
                                              value: '2',
                                              children: 'Always',
                                            }),
                                            Object(z.jsx)(M.a, {
                                              value: '3',
                                              children: 'Relevant',
                                            }),
                                          ],
                                        }),
                                      ],
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Vehicle',
                                  }),
                                  Object(z.jsxs)('div', {
                                    className: 'hud-row',
                                    children: [
                                      Object(z.jsx)('div', {
                                        className: 'jss1417 hud-row-double',
                                        children: Object(z.jsx)('div', {
                                          children: Object(z.jsx)(w.a, {
                                            className: 'jss255',
                                            children: Object(z.jsx)(g.a, {
                                              control: Object(z.jsx)(y.a, {
                                                color: 'warning',
                                                checked: ys,
                                                onChange: function (e) {
                                                  return ks(e.target.checked)
                                                },
                                              }),
                                              label: 'Minimap Enabled',
                                            }),
                                          }),
                                        }),
                                      }),
                                      Object(z.jsx)('div', {
                                        className: 'jss1418 hud-row',
                                        children: Object(z.jsx)(w.a, {
                                          className: 'jss255',
                                          children: Object(z.jsx)(g.a, {
                                            control: Object(z.jsx)(y.a, {
                                              color: 'warning',
                                              checked: Is,
                                              onChange: function (e) {
                                                return Cs(e.target.checked)
                                              },
                                            }),
                                            label:
                                              'Use Default Minimap (may require game restart)',
                                          }),
                                        }),
                                      }),
                                      Object(z.jsx)('div', {
                                        className: 'jss1418 hud-row',
                                        children: Object(z.jsx)(w.a, {
                                          className: 'jss255',
                                          children: Object(z.jsx)(g.a, {
                                            control: Object(z.jsx)(y.a, {
                                              color: 'warning',
                                              checked: zs,
                                              onChange: function (e) {
                                                return Bs(e.target.checked)
                                              },
                                            }),
                                            label: 'Show Minimap Outline',
                                          }),
                                        }),
                                      }),
                                    ],
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Compass',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)('div', {
                                      className: 'jss1417 hud-inner-row',
                                      children: [
                                        Object(z.jsxs)('div', {
                                          children: [
                                            Object(z.jsx)(w.a, {
                                              className: 'jss255',
                                              children: Object(z.jsx)(g.a, {
                                                control: Object(z.jsx)(y.a, {
                                                  color: 'warning',
                                                  checked: Tt,
                                                  onChange: function (e) {
                                                    return Dt(e.target.checked)
                                                  },
                                                }),
                                                label: 'Enabled',
                                              }),
                                            }),
                                            Object(z.jsx)(m.a, {
                                              style: {
                                                color: '#fff',
                                                wordBreak: 'break-word',
                                              },
                                              variant: 'body2',
                                              gutterBottom: true,
                                              children:
                                                'Disabling the compass entirely can vastly improve performance',
                                            }),
                                          ],
                                        }),
                                        Object(z.jsxs)('div', {
                                          style: { display: Tt ? '' : 'none' },
                                          children: [
                                            Object(z.jsxs)(k.a, {
                                              className: 'formControlClass',
                                              variant: 'standard',
                                              fullWidth: true,
                                              children: [
                                                Object(z.jsx)(I.a, {
                                                  id: 'demo-simple-select-label',
                                                  children: 'Compass FPS',
                                                }),
                                                Object(z.jsxs)(C.a, {
                                                  labelId:
                                                    'demo-simple-select-label',
                                                  id: 'demo-simple-select',
                                                  label: 'Compass FPS',
                                                  defaultValue: '16',
                                                  value: es,
                                                  onChange: function (e) {
                                                    return ts(e.target.value)
                                                  },
                                                  children: [
                                                    Object(z.jsx)(M.a, {
                                                      value: '64',
                                                      children: '15',
                                                    }),
                                                    Object(z.jsx)(M.a, {
                                                      value: '32',
                                                      children: '30',
                                                    }),
                                                    Object(z.jsx)(M.a, {
                                                      value: '24',
                                                      children: '45',
                                                    }),
                                                    Object(z.jsx)(M.a, {
                                                      value: '16',
                                                      children: '60',
                                                    }),
                                                  ],
                                                }),
                                              ],
                                            }),
                                            Object(z.jsx)(m.a, {
                                              style: {
                                                color: '#fff',
                                                wordBreak: 'break-word',
                                              },
                                              variant: 'body2',
                                              gutterBottom: true,
                                              children:
                                                'The higher the FPS, the more demanding this is on your machine',
                                            }),
                                          ],
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsxs)('div', {
                                    className: 'hud-row',
                                    children: [
                                      Object(z.jsx)(w.a, {
                                        className: 'jss255',
                                        children: Object(z.jsx)(g.a, {
                                          control: Object(z.jsx)(y.a, {
                                            color: 'warning',
                                            checked: Et,
                                            onChange: function (e) {
                                              return Vt(e.target.checked)
                                            },
                                          }),
                                          label:
                                            'Show street names when in a vehicle',
                                        }),
                                      }),
                                      Object(z.jsx)(m.a, {
                                        style: {
                                          color: '#fff',
                                          wordBreak: 'break-word',
                                        },
                                        variant: 'body2',
                                        gutterBottom: true,
                                        children:
                                          'Disabling this can help improve performance',
                                      }),
                                    ],
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Black Bars',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: Lt,
                                          onChange: function (e) {
                                            return Jt(e.target.checked)
                                          },
                                        }),
                                        label: 'Enabled',
                                      }),
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)('div', {
                                      className: 'input-wrapper',
                                      children: Object(z.jsx)(k.a, {
                                        fullWidth: true,
                                        sx: { width: '100%' },
                                        children: Object(z.jsx)(S.a, {
                                          sx: {
                                            '& .MuiInput-root': {
                                              color: 'white !important',
                                            },
                                            '& label.Mui-focused': {
                                              color: 'darkgray !important',
                                            },
                                            '& Mui-focused': {
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                              {
                                                borderColor:
                                                  'darkgray !important',
                                              },
                                            '& .MuiInput-underline:before': {
                                              borderColor:
                                                'darkgray !important',
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInput-underline:after': {
                                              borderColor: 'white !important',
                                              color: 'darkgray !important',
                                            },
                                            '& .Mui-focused:after': {
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInputAdornment-root': {
                                              color: 'darkgray !important',
                                            },
                                          },
                                          id: 'input-with-icon-textfield',
                                          label: 'Percentage of screen',
                                          variant: 'standard',
                                          value: ns,
                                          onChange: function (e) {
                                            return os(e.target.value)
                                          },
                                          InputProps: {
                                            startAdornment: Object(z.jsx)(N.a, {
                                              position: 'start',
                                              children: Object(z.jsx)('i', {
                                                className:
                                                  'fas fa-mask fa-w-20 fa-fw',
                                              }),
                                            }),
                                          },
                                        }),
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Crosshair',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                        }),
                                        label: 'Enabled',
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: 'hud-settings-phone-container',
                            style: { display: 2 === ca ? 'flex' : 'none' },
                            children: [
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsxs)('div', {
                                    className: 'hud-row-double',
                                    children: [
                                      Object(z.jsx)(m.a, {
                                        style: {
                                          color: '#fff',
                                          wordBreak: 'break-word',
                                        },
                                        variant: 'h6',
                                        gutterBottom: true,
                                        children: 'Misc',
                                      }),
                                      Object(z.jsx)('div', {
                                        style: {
                                          display: 'flex',
                                          justifyContent: 'flex-end',
                                        },
                                        children: Object(z.jsx)('div', {
                                          children: Object(z.jsx)(v.a, {
                                            onClick: cr,
                                            size: 'small',
                                            color: 'success',
                                            variant: 'contained',
                                            children: 'Save',
                                          }),
                                        }),
                                      }),
                                    ],
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsxs)(k.a, {
                                      className: 'formControlClass',
                                      variant: 'standard',
                                      fullWidth: true,
                                      children: [
                                        Object(z.jsx)(I.a, {
                                          id: 'demo-simple-select-label',
                                          children: 'Brand',
                                        }),
                                        Object(z.jsxs)(C.a, {
                                          labelId: 'demo-simple-select-label',
                                          id: 'demo-simple-select',
                                          label: 'Brand',
                                          defaultValue: 'Android',
                                          value: Ds,
                                          onChange: function (e) {
                                            return Ps(e.target.value)
                                          },
                                          children: [
                                            Object(z.jsx)(M.a, {
                                              value: 'ios',
                                              children: 'iOS',
                                            }),
                                            Object(z.jsx)(M.a, {
                                              value: 'Android',
                                              children: 'Android',
                                            }),
                                          ],
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)('div', {
                                      className: 'input-wrapper',
                                      children: Object(z.jsx)(k.a, {
                                        fullWidth: true,
                                        sx: { width: '100%' },
                                        children: Object(z.jsx)(S.a, {
                                          sx: {
                                            '& .MuiInput-root': {
                                              color: 'white !important',
                                            },
                                            '& label.Mui-focused': {
                                              color: 'darkgray !important',
                                            },
                                            '& Mui-focused': {
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInput-underline:hover:not(.Mui-disabled):before':
                                              {
                                                borderColor:
                                                  'darkgray !important',
                                              },
                                            '& .MuiInput-underline:before': {
                                              borderColor:
                                                'darkgray !important',
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInput-underline:after': {
                                              borderColor: 'white !important',
                                              color: 'darkgray !important',
                                            },
                                            '& .Mui-focused:after': {
                                              color: 'darkgray !important',
                                            },
                                            '& .MuiInputAdornment-root': {
                                              color: 'darkgray !important',
                                            },
                                          },
                                          id: 'input-with-icon-textfield',
                                          label: 'Background URL (1:2.2 res)',
                                          variant: 'standard',
                                          value: Vs,
                                          onChange: function (e) {
                                            return Rs(e.target.value)
                                          },
                                          InputProps: {
                                            startAdornment: Object(z.jsx)(N.a, {
                                              position: 'start',
                                              children: Object(z.jsx)('i', {
                                                className:
                                                  'fas fa-images fa-w-20 fa-fw',
                                              }),
                                            }),
                                          },
                                        }),
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Notifications',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: Js,
                                          onChange: function (e) {
                                            return Ks(e.target.checked)
                                          },
                                        }),
                                        label: 'Receive SMS',
                                      }),
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: qs,
                                          onChange: function (e) {
                                            return Xs(e.target.checked)
                                          },
                                        }),
                                        label: 'New Tweet',
                                      }),
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: Zs,
                                          onChange: function (e) {
                                            return $s(e.target.checked)
                                          },
                                        }),
                                        label: 'Receive Email',
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('hr', {}),
                              Object(z.jsxs)('div', {
                                children: [
                                  Object(z.jsx)(m.a, {
                                    style: {
                                      color: '#fff',
                                      wordBreak: 'break-word',
                                    },
                                    variant: 'h6',
                                    gutterBottom: true,
                                    children: 'Images',
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'hud-row',
                                    children: Object(z.jsx)(w.a, {
                                      className: 'jss255',
                                      children: Object(z.jsx)(g.a, {
                                        control: Object(z.jsx)(y.a, {
                                          color: 'warning',
                                          checked: ta,
                                          onChange: function (e) {
                                            return sa(e.target.checked)
                                          },
                                        }),
                                        label: 'Embedded Images Enabled',
                                      }),
                                    }),
                                  }),
                                ],
                              }),
                            ],
                          }),
                        ],
                      }),
                    ],
                  }),
                }),
                Object(z.jsx)(O.a, {
                  container: true,
                  className: e.root,
                  children: Object(z.jsxs)('div', {
                    className: e.hudOuterContainer,
                    style: { display: r ? 'flex' : 'none' },
                    children: [
                      Object(z.jsxs)('div', {
                        className: e.vehicleHudContainer,
                        style: { display: pe ? '' : 'none' },
                        children: [
                          Object(z.jsx)('div', {
                            className: 'waypointDistContainer',
                            style: { display: be ? '' : 'none' },
                            children: Object(z.jsxs)(m.a, {
                              style: {
                                color: '#fff',
                                wordBreak: 'break-word',
                              },
                              variant: 'body1',
                              gutterBottom: true,
                              children: [Fe, ' mi'],
                            }),
                          }),
                          Object(z.jsx)('div', {
                            className: e.minimapBorder,
                            style: { display: !Is && ys && zs ? '' : 'none' },
                          }),
                          Object(z.jsxs)('div', {
                            className: 'vehicleHud',
                            style: {
                              display: ys ? 'flex' : 'none',
                              left: Is ? 'calc(16.375vw)' : 'calc(14.375vw)',
                            },
                            children: [
                              Object(z.jsxs)('div', {
                                className: 'speedoMeterContainer',
                                children: [
                                  Object(z.jsx)('div', {
                                    className: 'speedoMeter',
                                    children: Object(z.jsxs)('div', {
                                      className: 'speedoMeterInner',
                                      children: [
                                        Object(z.jsx)('div', {
                                          className: 'speedoMeterSvg',
                                          children: Object(z.jsx)('svg', {
                                            version: '1.1',
                                            xmlns: 'http://www.w3.org/2000/svg',
                                            style: {
                                              height: '62px',
                                              width: '62px',
                                              transform: 'rotate(120deg)',
                                            },
                                            children: Object(z.jsx)('circle', {
                                              r: '27',
                                              cx: '31',
                                              cy: '31',
                                              fill: 'transparent',
                                              stroke: '#9E9E9E',
                                              'stroke-width': '6',
                                              'stroke-dasharray':
                                                '169.64600329384882',
                                              'stroke-dashoffset':
                                                '56.54866776461626',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'speedoMeterSvg',
                                          children: Object(z.jsx)('svg', {
                                            version: '1.1',
                                            xmlns: 'http://www.w3.org/2000/svg',
                                            style: {
                                              height: '62px',
                                              width: '62px',
                                              transform: 'rotate(120deg)',
                                            },
                                            children: Object(z.jsx)('circle', {
                                              r: '27',
                                              cx: '31',
                                              cy: '31',
                                              fill: 'transparent',
                                              stroke: 'white',
                                              'stroke-width': '6',
                                              'stroke-dasharray': Ae,
                                              'stroke-dashoffset': He,
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'speedoMeterSpeed',
                                          style: { marginTop: '-6px' },
                                          children: Object(z.jsx)(m.a, {
                                            style: {
                                              color: '#fff',
                                              wordBreak: 'break-word',
                                            },
                                            variant: 'body2',
                                            gutterBottom: true,
                                            children: yt,
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'speedoMeterMph',
                                          style: { marginTop: '-12px' },
                                          children: Object(z.jsx)(m.a, {
                                            style: {
                                              color: '#fff',
                                              wordBreak: 'break-word',
                                            },
                                            variant: 'body2',
                                            gutterBottom: true,
                                            children: 'mph',
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'fuelPump',
                                    children: Object(z.jsxs)('div', {
                                      className: 'fuelPumpInner',
                                      children: [
                                        Object(z.jsx)('div', {
                                          className: 'fuelPumpSvg',
                                          children: Object(z.jsx)('svg', {
                                            style: {
                                              height: '32px',
                                              width: '32px',
                                              transform: 'rotate(150deg)',
                                            },
                                            children: Object(z.jsx)('circle', {
                                              r: '13.5',
                                              cx: '16',
                                              cy: '16',
                                              fill: 'transparent',
                                              stroke: '#9E9E9E',
                                              'stroke-width': '3',
                                              'stroke-dasharray':
                                                '84.82300164692441',
                                              'stroke-dashoffset':
                                                '28.27433388230813',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'fuelPumpSvg',
                                          children: Object(z.jsx)('svg', {
                                            style: {
                                              height: '32px',
                                              width: '32px',
                                              transform: 'rotate(150deg)',
                                            },
                                            children: Object(z.jsx)('circle', {
                                              r: '13.5',
                                              cx: '16',
                                              cy: '16',
                                              fill: 'transparent',
                                              stroke: _e,
                                              'stroke-width': '3',
                                              'stroke-dasharray': Ge,
                                              'stroke-dashoffset': Qe,
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'fuelPumpIcon',
                                          style: { marginTop: '0px' },
                                          children: Object(z.jsx)('svg', {
                                            'aria-hidden': 'true',
                                            focusable: 'false',
                                            'data-prefix': 'fas',
                                            'data-icon': 'gas-pump',
                                            className:
                                              'svg-inline--fa fa-gas-pump fa-w-16 fa-fw fa-2x ',
                                            role: 'img',
                                            xmlns: 'http://www.w3.org/2000/svg',
                                            viewBox: '0 0 512 512',
                                            children: Object(z.jsx)('path', {
                                              fill: 'currentColor',
                                              d: 'M336 448H16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h320c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm157.2-340.7l-81-81c-6.2-6.2-16.4-6.2-22.6 0l-11.3 11.3c-6.2 6.2-6.2 16.4 0 22.6L416 97.9V160c0 28.1 20.9 51.3 48 55.2V376c0 13.2-10.8 24-24 24s-24-10.8-24-24v-32c0-48.6-39.4-88-88-88h-8V64c0-35.3-28.7-64-64-64H96C60.7 0 32 28.7 32 64v352h288V304h8c22.1 0 40 17.9 40 40v27.8c0 37.7 27 72 64.5 75.9 43 4.3 79.5-29.5 79.5-71.7V152.6c0-17-6.8-33.3-18.8-45.3zM256 192H96V64h160v128z',
                                            }),
                                          }),
                                        }),
                                        Object(z.jsx)('div', {
                                          className: 'fuelPumpAlt',
                                          style: { marginTop: '0px' },
                                          children: Object(z.jsx)(m.a, {
                                            style: {
                                              color: '#fff',
                                              wordBreak: 'break-word',
                                            },
                                            variant: 'body2',
                                            gutterBottom: true,
                                          }),
                                        }),
                                      ],
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsxs)('div', {
                                className: 'altContainer',
                                style: { display: Se ? '' : 'none' },
                                children: [
                                  Object(z.jsx)('div', {
                                    className: 'altSvg',
                                    children: Object(z.jsx)('svg', {
                                      version: '1.1',
                                      xmlns: 'http://www.w3.org/2000/svg',
                                      style: {
                                        height: '62px',
                                        width: '62px',
                                        transform: 'rotate(150deg)',
                                      },
                                      children: Object(z.jsx)('circle', {
                                        r: '27',
                                        cx: '31',
                                        cy: '31',
                                        fill: 'transparent',
                                        stroke: '#9E9E9E',
                                        'stroke-width': '6',
                                        'stroke-dasharray':
                                          '169.64600329384882',
                                        'stroke-dashoffset':
                                          '56.54866776461626',
                                      }),
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'altSvg',
                                    children: Object(z.jsx)('svg', {
                                      version: '1.1',
                                      xmlns: 'http://www.w3.org/2000/svg',
                                      style: {
                                        height: '62px',
                                        width: '62px',
                                        transform: 'rotate(150deg)',
                                      },
                                      children: Object(z.jsx)('circle', {
                                        r: '27',
                                        cx: '31',
                                        cy: '31',
                                        fill: 'transparent',
                                        stroke: 'white',
                                        'stroke-width': '6',
                                        'stroke-dasharray': at,
                                        'stroke-dashoffset': nt,
                                      }),
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'altSpeed',
                                    style: { marginTop: '-6px' },
                                    children: Object(z.jsx)(m.a, {
                                      style: {
                                        color: '#fff',
                                        wordBreak: 'break-word',
                                      },
                                      variant: 'body2',
                                      gutterBottom: true,
                                      children: Wt,
                                    }),
                                  }),
                                  Object(z.jsx)('div', {
                                    className: 'altAlt',
                                    style: { marginTop: '-12px' },
                                    children: Object(z.jsx)(m.a, {
                                      style: {
                                        color: '#fff',
                                        wordBreak: 'break-word',
                                      },
                                      variant: 'body2',
                                      gutterBottom: true,
                                      children: 'alt',
                                    }),
                                  }),
                                ],
                              }),
                              Object(z.jsx)('div', {
                                className: 'seatBeltIcon',
                                style: { display: we ? '' : 'none' },
                                children: Object(z.jsx)('svg', {
                                  'aria-hidden': 'true',
                                  focusable: 'false',
                                  'data-prefix': 'fas',
                                  'data-icon': 'user-slash',
                                  className:
                                    'svg-inline--fa fa-user-slash fa-w-20 fa-fw fa-lg ',
                                  role: 'img',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  viewBox: '0 0 640 512',
                                  style: { color: 'rgb(216, 67, 21)' },
                                  children: Object(z.jsx)('path', {
                                    fill: 'currentColor',
                                    d: 'M633.8 458.1L362.3 248.3C412.1 230.7 448 183.8 448 128 448 57.3 390.7 0 320 0c-67.1 0-121.5 51.8-126.9 117.4L45.5 3.4C38.5-2 28.5-.8 23 6.2L3.4 31.4c-5.4 7-4.2 17 2.8 22.4l588.4 454.7c7 5.4 17 4.2 22.5-2.8l19.6-25.3c5.4-6.8 4.1-16.9-2.9-22.3zM96 422.4V464c0 26.5 21.5 48 48 48h350.2L207.4 290.3C144.2 301.3 96 356 96 422.4z',
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: 'engineDamagedIcon',
                                style: { display: Me ? '' : 'none' },
                                children: Object(z.jsx)('svg', {
                                  'aria-hidden': 'true',
                                  focusable: 'false',
                                  'data-prefix': 'fas',
                                  'data-icon': 'oil-can',
                                  className:
                                    'svg-inline--fa fa-oil-can fa-w-20 fa-fw fa-lg ',
                                  role: 'img',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  viewBox: '0 0 640 512',
                                  style: { color: 'rgb(216, 67, 21)' },
                                  children: Object(z.jsx)('path', {
                                    fill: 'currentColor',
                                    d: 'M629.8 160.31L416 224l-50.49-25.24a64.07 64.07 0 0 0-28.62-6.76H280v-48h56c8.84 0 16-7.16 16-16v-16c0-8.84-7.16-16-16-16H176c-8.84 0-16 7.16-16 16v16c0 8.84 7.16 16 16 16h56v48h-56L37.72 166.86a31.9 31.9 0 0 0-5.79-.53C14.67 166.33 0 180.36 0 198.34v94.95c0 15.46 11.06 28.72 26.28 31.48L96 337.46V384c0 17.67 14.33 32 32 32h274.63c8.55 0 16.75-3.42 22.76-9.51l212.26-214.75c1.5-1.5 2.34-3.54 2.34-5.66V168c.01-5.31-5.08-9.15-10.19-7.69zM96 288.67l-48-8.73v-62.43l48 8.73v62.43zm453.33 84.66c0 23.56 19.1 42.67 42.67 42.67s42.67-19.1 42.67-42.67S592 288 592 288s-42.67 61.77-42.67 85.33z',
                                  }),
                                }),
                              }),
                            ],
                          }),
                        ],
                      }),
                      Object(z.jsxs)('div', {
                        className: e.hudInnerContainer,
                        style: { left: Is ? '0.4vw' : '0px' },
                        children: [
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Ir,
                              transition: 'all 1s linear 1s',
                              maxWidth: jr ? '54px' : '0px',
                              display: jr ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: mr
                                      ? 'rgb(213, 205, 49)'
                                      : yr
                                      ? '#C05D5D'
                                      : 'white',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: mr
                                      ? 'rgb(213, 205, 49)'
                                      : yr
                                      ? '#C05D5D'
                                      : 'white',
                                    'stroke-width': '6',
                                    'stroke-dasharray': zr,
                                    'stroke-dashoffset': Dr,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsxs)('div', {
                                  className: e.iconWrapper,
                                  children: [
                                    Object(z.jsx)('i', {
                                      className: 'fas '.concat(
                                        f ? 'fa-headset' : 'fa-microphone',
                                        ' fa-w-11 fa-fw'
                                      ),
                                      style: {
                                        color:
                                          (f &&
                                            void 0 !== D &&
                                            '' !== D &&
                                            V &&
                                            '1' !== ba) ||
                                          (f &&
                                            void 0 !== D &&
                                            '' !== D &&
                                            '2' === ba)
                                            ? 'rgb(96, 96, 96)'
                                            : 'white',
                                        fontSize: '18px',
                                      },
                                    }),
                                    Object(z.jsx)('div', {
                                      className: e.radioChannelWrapper,
                                      style: {
                                        display:
                                          (f &&
                                            void 0 !== D &&
                                            '' !== D &&
                                            V &&
                                            '1' !== ba) ||
                                          (f &&
                                            void 0 !== D &&
                                            '' !== D &&
                                            '2' === ba)
                                            ? ''
                                            : 'none',
                                      },
                                      children: Object(z.jsx)(m.a, {
                                        style: {
                                          color: '#fff',
                                          fontSize: '11px',
                                        },
                                        variant: 'body1',
                                        gutterBottom: true,
                                        children: D,
                                      }),
                                    }),
                                  ],
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: cc,
                              transition: 'all 1s linear 1s',
                              maxWidth: tc ? '54px' : '0px',
                              display: tc ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: Zr ? 'red' : '#3BB273',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': Zr ? '1' : '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#3BB273',
                                    'stroke-width': '6',
                                    'stroke-dasharray': lc,
                                    'stroke-dashoffset': bc,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-heart fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: gc,
                              transition: 'all 1s linear 1s',
                              maxWidth: mc ? '54px' : '0px',
                              display: mc ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#33B8C1',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#33B8C1',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Sc,
                                    'stroke-dashoffset': Cc,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-burn fa-w-12 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Zc,
                              transition: 'all 1s linear 1s',
                              maxWidth: qc ? '54px' : '0px',
                              display: qc ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: Jc ? 'red' : '#1565C0',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': Jc ? '1' : '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#1565C0',
                                    'stroke-width': '6',
                                    'stroke-dasharray': ti,
                                    'stroke-dashoffset': ci,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-shield-alt fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Mi,
                              transition: 'all 1s linear 1s',
                              maxWidth: Si ? '54px' : '0px',
                              display: Si ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: wi ? 'red' : '#FF6D00',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': wi ? '1' : '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FF6D00',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Fi,
                                    'stroke-dashoffset': Ai,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-hamburger fa-w-16 fa-fw',
                                    style: {
                                      color: wa && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: on,
                              transition: 'all 1s linear 1s',
                              maxWidth: an ? '54px' : '0px',
                              display: an ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: _i ? 'red' : '#0277BD',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': _i ? '1' : '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#0277BD',
                                    'stroke-width': '6',
                                    'stroke-dasharray': jn,
                                    'stroke-dashoffset': fn,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-tint fa-w-11 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Nn,
                              transition: 'all 1s linear 1s',
                              maxWidth: gn ? '54px' : '0px',
                              display: gn ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#90A4AE',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#90A4AE',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Wn,
                                    'stroke-dashoffset': Tn,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-lungs fa-w-20 fa-fw',
                                    style: {
                                      color: pa && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Xn,
                              transition: 'all 1s linear 1s',
                              maxWidth: Kn ? '54px' : '0px',
                              display: Kn ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#d50000',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#d50000',
                                    'stroke-width': '6',
                                    'stroke-dasharray': $n,
                                    'stroke-dashoffset': so,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-brain fa-w-18 fa-fw',
                                    style: {
                                      color: Sa && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : uo,
                              transition: 'all 1s linear 1s',
                              maxWidth: lo && !Yt ? '54px' : '0px',
                              display: lo && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Oo,
                                    'stroke-dashoffset': go,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-lightbulb fa-w-14 fa-fw',
                                    style: {
                                      color: No && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : Po,
                              transition: 'all 1s linear 1s',
                              maxWidth: Bo && !Yt ? '54px' : '0px',
                              display: Bo && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Ro,
                                    'stroke-dashoffset': Jo,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-swimmer fa-w-16 fa-fw',
                                    style: {
                                      color: Uo && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : sl,
                              transition: 'all 1s linear 1s',
                              maxWidth: $o && !Yt ? '54px' : '0px',
                              display: $o && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': il,
                                    'stroke-dashoffset': dl,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-dumbbell fa-w-6 fa-fw',
                                    style: {
                                      color: ul && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : Sl,
                              transition: 'all 1s linear 1s',
                              maxWidth: wl && !Yt ? '54px' : '0px',
                              display: wl && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Ml,
                                    'stroke-dashoffset': Fl,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-dollar-sign fa-w-11 fa-fw',
                                    style: {
                                      color: Al && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : ql,
                              transition: 'all 1s linear 1s',
                              maxWidth: Jl && !Yt ? '54px' : '0px',
                              display: Jl && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Zl,
                                    'stroke-dashoffset': ed,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-database fa-w-9 fa-fw',
                                    style: {
                                      color: ad && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : bd,
                              transition: 'all 1s linear 1s',
                              maxWidth: ld && !Yt ? '54px' : '0px',
                              display: ld && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': pd,
                                    'stroke-dashoffset': wd,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-exclamation fa-w-20 fa-fw',
                                    style: {
                                      color: Sd && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : Dd,
                              transition: 'all 1s linear 1s',
                              maxWidth: zd && !Yt ? '54px' : '0px',
                              display: zd && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Vd,
                                    'stroke-dashoffset': Ld,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-wind fa-w-20 fa-fw',
                                    style: {
                                      color: Gd && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Yt ? 0 : th,
                              transition: 'all 1s linear 1s',
                              maxWidth: Zd && !Yt ? '54px' : '0px',
                              display: Zd && !Yt ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#FFD700',
                                    'stroke-width': '6',
                                    'stroke-dasharray': ch,
                                    'stroke-dashoffset': lh,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-bicycle fa-w-20 fa-fw',
                                    style: {
                                      color: bh && !Yt ? '#FFD700' : 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: yh,
                              transition: 'all 1s linear 1s',
                              maxWidth: mh ? '54px' : '0px',
                              display: mh ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#AB47BC',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#AB47BC',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Ih,
                                    'stroke-dashoffset': zh,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-user-slash fa-w-20 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Gh,
                              transition: 'all 1s linear 1s',
                              maxWidth: Ah && Hh ? '54px' : '0px',
                              display: Ah && Hh ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Qh,
                                    'stroke-dashoffset': _h,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-tachometer-alt fa-w-18 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: oj,
                              transition: 'all 1s linear 1s',
                              maxWidth: cj ? '54px' : '0px',
                              display: cj ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#47e10c',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#47e10c',
                                    'stroke-width': '6',
                                    'stroke-dasharray': hj,
                                    'stroke-dashoffset': uj,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-biohazard fa-w-18 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: gj,
                              transition: 'all 1s linear 1s',
                              maxWidth: mj ? '54px' : '0px',
                              display: mj ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#f08329',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#f08329',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Sj,
                                    'stroke-dashoffset': Cj,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-location-arrow fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Pj,
                              transition: 'all 1s linear 1s',
                              maxWidth: Fj ? '54px' : '0px',
                              display: Fj ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': Vj,
                                    'stroke-dashoffset': Lj,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-microchip fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Zj,
                              transition: 'all 1s linear 1s',
                              maxWidth: qj ? '54px' : '0px',
                              display: qj ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-stream fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: hb,
                              transition: 'all 1s linear 1s',
                              maxWidth: nb ? '54px' : '0px',
                              display: nb ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#e43f5a',
                                    'stroke-width': '6',
                                    'stroke-dasharray': xb,
                                    'stroke-dashoffset': mb,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-meteor fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Cb,
                              transition: 'all 1s linear 1s',
                              maxWidth: Sb ? '54px' : '0px',
                              display: Sb ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#7788de',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: '#7788de',
                                    'stroke-width': '6',
                                    'stroke-dasharray': zb,
                                    'stroke-dashoffset': Tb,
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className:
                                      'fas fa-stopwatch-20 fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                          Object(z.jsxs)('div', {
                            className: e.hudIconWrapper,
                            style: {
                              opacity: Jb,
                              transition: 'all 1s linear 1s',
                              maxWidth: Vb ? '54px' : '0px',
                              display: Vb ? 'flex' : 'none',
                            },
                            children: [
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 100,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: ms ? '#b8b679' : '#000',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '0.35',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('svg', {
                                  version: '1.1',
                                  xmlns: 'http://www.w3.org/2000/svg',
                                  style: {
                                    height: '48px',
                                    width: '48px',
                                    transform: 'rotate(-90deg)',
                                    zIndex: 200,
                                  },
                                  children: Object(z.jsx)('circle', {
                                    r: '20',
                                    cx: '24',
                                    cy: '24',
                                    fill: 'transparent',
                                    stroke: ms ? '#b8b679' : '#000',
                                    'stroke-width': '6',
                                    'stroke-dasharray': '125.66370614359172',
                                    'stroke-dashoffset': '0',
                                    'stroke-opacity': '1',
                                    style: {
                                      transition:
                                        'stroke-dashoffset 400ms linear 0s',
                                      willChange: 'transition',
                                    },
                                  }),
                                }),
                              }),
                              Object(z.jsx)('div', {
                                className: e.hudIcon,
                                children: Object(z.jsx)('div', {
                                  className: e.iconWrapper,
                                  children: Object(z.jsx)('i', {
                                    className: 'fas fa-terminal fa-w-16 fa-fw',
                                    style: {
                                      color: 'white',
                                      fontSize: '18px',
                                    },
                                  }),
                                }),
                              }),
                            ],
                          }),
                        ],
                      }),
                    ],
                  }),
                }),
              ],
            })
          )
        },
        F = Object(i.a)({
          components: {
            MuiTypography: { styleOverrides: { root: { margin: '0' } } },
            MuiMenuItem: {
              styleOverrides: {
                root: {
                  backgroundColor: 'rgba(255, 255, 255, 0.02)',
                  '&.Mui-selected': {
                    backgroundColor: 'rgba(255, 255, 255, 0.3)',
                    '&.Mui-focusVisible': { background: 'rgba(0, 0, 0, 0.3)' },
                  },
                  '&.Mui-selected:hover': {
                    backgroundColor: 'rgba(255, 255, 255, 0.3)',
                  },
                },
              },
            },
            MuiCircularProgress: {
              styleOverrides: { circle: { strokeLinecap: 'butt' } },
            },
            MuiInput: {
              styleOverrides: {
                root: {
                  '& .MuiInput-root': {
                    color: 'darkgray !important',
                    fontSize: '1.3vmin !important',
                  },
                  '& label.Mui-focused': { color: 'darkgray !important' },
                  '& Mui-focused': { color: 'darkgray !important' },
                  '& .MuiInput-underline:hover:not(.Mui-disabled):before': {
                    borderColor: 'darkgray !important',
                  },
                  '& .MuiInput-underline:before': {
                    borderColor: 'darkgray !important',
                    color: 'darkgray !important',
                  },
                  '& .MuiInput-underline:after': {
                    borderColor: 'white !important',
                    color: 'darkgray !important',
                  },
                  '& .Mui-focused:after': {
                    color: 'darkgray !important',
                    fontSize: '1.5vmin !important',
                  },
                  '& .MuiInputAdornment-root': { color: 'darkgray !important' },
                },
              },
            },
            MuiTooltip: {
              styleOverrides: {
                tooltip: {
                  fontSize: '1em',
                  maxWidth: '1000px',
                },
              },
            },
          },
          palette: {
            mode: 'dark',
            primary: { main: '#95ef77' },
            secondary: { main: '#424cab' },
            success: { main: '#95ef77' },
            warning: { main: '#f2a365' },
            error: { main: '#ffffff' },
            info: { main: '#2d465b' },
          },
        }),
        T =
          (Object(o.a)(function (e) {
            return {
              root: {
                top: '0px',
                left: '0px',
                width: '100vw',
                height: '100vh',
                position: 'absolute',
                maxWidth: '100vw',
                minWidth: '100vw',
                maxHeight: '100vh',
                minHeight: '100vh',
                border: '0px',
                margin: '0px',
                outline: '0px',
                padding: '0px',
                overflow: 'hidden',
                '& .MuiInput-root': {
                  color: 'white',
                  fontSize: '1.3vmin',
                },
                '& .MuiInput-underline:hover:not(.Mui-disabled):before': {
                  borderColor: 'darkgray',
                },
                '& .MuiInput-underline:before': {
                  borderColor: 'darkgray',
                  color: 'darkgray',
                },
                '& .MuiInput-underline:after': {
                  borderColor: 'white',
                  color: 'darkgray',
                },
                '& .MuiInputLabel-animated': {
                  color: 'darkgray',
                  fontSize: '1.5vmin',
                },
                '& .MuiInputAdornment-root': { color: 'darkgray' },
                '& label.Mui-focused': { color: 'darkgray' },
              },
              input: {
                '& input[type=number]': { '-moz-appearance': 'textfield' },
                '& input[type=number]::-webkit-outer-spin-button': {
                  '-webkit-appearance': 'none',
                  margin: 0,
                },
                '& input[type=number]::-webkit-inner-spin-button': {
                  '-webkit-appearance': 'none',
                  margin: 0,
                },
              },
            }
          }),
          function () {
            return Object(z.jsx)(z.Fragment, {
              children: Object(z.jsx)(n.a, {
                theme: F,
                children: Object(z.jsx)(B, {}),
              }),
            })
          }),
        D = s(89),
        P = (s(114), s(115), s(116), s(117), s(87))
      c.a.render(
        Object(z.jsx)(D.a, {
          basename: '/',
          children: Object(z.jsx)(P.a, { children: Object(z.jsx)(T, {}) }),
        }),
        document.getElementById('root')
      )
    },
  },
  [[120, 1, 2]],
])
