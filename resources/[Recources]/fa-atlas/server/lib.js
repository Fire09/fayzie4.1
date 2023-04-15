!(function () {
    'use strict'
    var desirerp = {
      g: (function () {
        if ('object' == typeof globalThis) {
          return globalThis
        }
        try {
          return this || new Function('return this')()
        } catch (err) {
          if ('object' == typeof window) {
            return window
          }
        }
      })(),
    }
    console.log('[LPX] Loaded!')
    const pName = GetCurrentResourceName(),
      pMap = new Map()
    let pDate = new Date().getTime()
    const pLPXUtilTable = {
      getMapRange: (pMap, pRange, pArgs) =>
        pRange[0] +
        ((pArgs - pMap[0]) * (pRange[1] - pRange[0])) /
          (pMap[1] - pMap[0]),
      getDistance: (
        [pCoordsX, pCoordsY, pCoordsZ],
        [tCoordsX, tCoordsY, tCoordsZ]
      ) => {
        const [dX, dY, dZ] = [
          pCoordsX - tCoordsX,
          pCoordsY - tCoordsY,
          pCoordsZ - tCoordsZ,
        ]
        return Math.sqrt(
          dX * dX + dY * dY + dZ * dZ
        )
      },
      getRandomNumber: (pMin, pMax) =>
        Math.floor(
          pMax
            ? Math.random() * (pMax - pMin) + pMin
            : Math.random() * pMin
        ),
    }
    function cacheableMapEvent(pName, pData) {
      const TimeToLive = pData.timeToLive || 60000,
        cacheableMapEventTable = {}
      var cacheableMapEventFunctions = {
        get: async function (pFunctionName, ...pFunctionData) {
          return await (async function (pFunctionName1, ...pFunctionData1) {
            let pFunc = cacheableMapEventTable[pFunctionName1]
            pFunc ||
              ((pFunc = {
                value: null,
                lastUpdated: 0,
              }),
              (cacheableMapEventTable[pFunctionName1] = pFunc))
            const pFuncLastUpdated = Date.now()
            if (
              0 === pFunc.lastUpdated ||
              pFuncLastUpdated - pFunc.lastUpdated > TimeToLive
            ) {
              const [pFuncData, pFuncValue] = await pRandomEvent.jPOim(
                pName,
                pFunc,
                pFunctionName1,
                ...pFunctionData1
              )
              return (
                pFuncData &&
                  ((pFunc.lastUpdated = pFuncLastUpdated),
                  (pFunc.value = pFuncValue)),
                pFuncValue
              )
            }
            return await new Promise((_0x4f2d83) =>
              setTimeout(() => _0x4f2d83(pFunc.value), 0)
            )
          })(pFunctionName, ...pFunctionData)
        },
        reset: function (pName) {
          var pResetFunc = cacheableMapEventTable[pName]
          pResetFunc && (pResetFunc.lastUpdated = 0)
        },
      }
      return cacheableMapEventFunctions
    }
    let pCacheTable = []

    pCacheTable.cacheableMap = cacheableMapEvent
    pCacheTable.waitForCondition = function (pTime, pGivenTime) {
      return new Promise((pConditionPromise) => {
        const pDateNow = Date.now(),
          setConditionTick = setTick(() => {
            const DateNow = Date.now() - pDateNow > pGivenTime
            if (pTime() || DateNow) {
              return clearTick(setConditionTick), pConditionPromise(DateNow)
            }
          })
      })
    }
    const LPXUTILS = Object.assign(pCacheTable, pLPXUtilTable),
      pEncodeDecode = {
        encodePayload: (string) => {
          try {
            return JSON.stringify(string)
          } catch (err) {
            console.error('Failed to encode payload')
          }
        },
        decodePayload: (string) => {
          try {
            return JSON.parse(string)
          } catch (err) {
            console.error('Failed to decode payload')
          }
        },
      },
      LPXEVENTS = {
        on: (pName, pData) => on(pName, pData),
        onNet: (pName, pData) => onNet(pName, pData),
        emit: (pName, ...pData) => {
          emit(pName, ...pData)
        },
        emitNet: (pName, pArgs, ...pData) => {
          const pEventName = pName,
            pMsgPackData = msgpack_pack(pData)
          pMsgPackData.length < 16000
            ? TriggerClientEventInternal(
                pEventName,
                pArgs,
                pMsgPackData,
                pMsgPackData.length
              )
            : TriggerLatentClientEventInternal(
                pEventName,
                pArgs,
                pMsgPackData,
                pMsgPackData.length,
                128000
              )
        },
        remove: (pName, pData) => {
          removeEventListener(pName, pData)
        },
      }
    LPXEVENTS.onNet('__lpx_res:' + pName, (pResOnNetName, pResOnNetData) => {
      const pGetResOnNetName = pMap.get(pResOnNetName)
      if (void 0 === pGetResOnNetName) {
        return
      }
      clearTimeout(pGetResOnNetName.timeout)
      const [keyOnNet, valueOnNet] = pResOnNetData
      keyOnNet
        ? pGetResOnNetName.resolve(valueOnNet)
        : pGetResOnNetName.reject(new Error(valueOnNet))
    })
    const LPXPROCEDURES = {
      register: (pName, pData) => {
        LPXEVENTS.onNet(
          '__lpx_req:' + pName,
          async (pRegisterName, pRegisterData) => {
            let pResData, pResName
            console.log('Received request: ' + pName, pRegisterName, pRegisterData)
            const Decoded = pEncodeDecode.decodePayload(pRegisterName)
            if (void 0 === Decoded) {
              return console.log('[RPC] Received malformed packet:', pRegisterName)
            }
            try {
              ;(pResData = await pData(Decoded.src, ...pRegisterData)),
                (pResName = true)
            } catch (_0x484adc) {
              pResData = _0x484adc
              pResName = false
            }
            'remote' === Decoded.type
              ? LPXEVENTS.emitNet(
                  '__lpx_res:' + Decoded.origin,
                  Decoded.src,
                  Decoded.id,
                  [pResName, pResData]
                )
              : 'local' === Decoded.type &&
                LPXEVENTS.emit('__lpx_res:' + Decoded.origin, Decoded.id, [
                  pResName,
                  pResData,
                ])
          }
        )
      },
      execute: (pName, ...pData) => {
        var pDataTable = {
          id: ++pDate,
          type: 'remote',
          origin: pName,
        }
        const pNameData = pDataTable,
          pExecutePromise = new Promise((pResolve, pReject) => {
            const pRemoteTimeout = +setTimeout(
              () => pReject(new Error('Remote call timed out | ' + pName)),
              60000
            )
            var pEventTable = {
              resolve: pResolve,
              reject: pReject,
              timeout: pRemoteTimeout,
            }
            pMap.set(pNameData.id, pEventTable)
          })
        return (
          LPXEVENTS.emitNet(
            '__lpx_req:' + pName,
            pEncodeDecode.encodePayload(pNameData),
            pData
          ),
          pExecutePromise.finally(() => pMap.delete(pNameData.id)),
          pExecutePromise
        )
      },
    }
    let LPX = {
      Events: LPXEVENTS,
      Procedures: LPXPROCEDURES,
      Utils: LPXUTILS,
    }
    const LPXLib = LPX
    desirerp.g.LPX = LPXLib
    setImmediate(() => {
      desirerp.g.exports('GetLibrary', () => LPXLib)
    })
  })()
  