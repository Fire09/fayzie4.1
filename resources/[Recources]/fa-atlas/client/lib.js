;(function () {
    'use strict'
    var loadLPX = {
        50: function (pNothing, exportz, lol) {
          var setVal
          setVal = { value: true }
          console.log('[LPX] Loaded!')
          const pOrigin = GetCurrentResourceName(),
            artificalBag = new Map(),
            setEvent = new Set(),
            mapEvent = new Map()
          let pTime = new Date().getTime()
          const blipCreationEvent = (pName, ...pData) => {
              switch (pName) {
                case 'coord': {
                  const [pCoordX, pCoordY, pCoordZ] = pData
                  return AddBlipForCoord(pCoordX, pCoordY, pCoordZ)
                }
                case 'area': {
                  const [x, y, z, width, height] =
                    pData
                  return AddBlipForArea(
                    x,
                    y,
                    z,
                    width,
                    height
                  )
                }
                case 'radius': {
                  const [posX, posY, posZ, radius] = pData
                  return AddBlipForRadius(
                    posX,
                    posY,
                    posZ,
                    radius
                  )
                }
                case 'pickup': {
                  const [pPickup] = pData
                  return AddBlipForPickup(pPickup)
                }
                case 'entity': {
                  const [pEntity] = pData
                  return AddBlipForEntity(pEntity)
                }
                default: {
                  return console.error(new Error('Invalid Blip Type')), 0
                }
              }
            },
            applyBlipSettingsEvent = (
              blip,
              spriteText,
              spriteID,
              spriteColor,
              spriteAlpha,
              spriteScale,
              spriteRoute,
              spriteShortRange
            ) => {
              if (typeof spriteID === 'number') {
                SetBlipSprite(blip, spriteID)
              }
              if (typeof spriteColor === 'number') {
                SetBlipColour(blip, spriteColor)
              }
              if (typeof spriteAlpha === 'number') {
                SetBlipAlpha(blip, spriteAlpha)
              }
              if (typeof spriteScale === 'number') {
                SetBlipScale(blip, spriteScale)
              }
              if (typeof spriteRoute === 'boolean') {
                SetBlipRoute(blip, spriteRoute)
              }
              if (typeof spriteShortRange === 'boolean') {
                SetBlipAsShortRange(blip, spriteShortRange)
              }
              typeof spriteText === 'string' &&
                (BeginTextCommandSetBlipName('STRING'),
                AddTextComponentString(spriteText),
                EndTextCommandSetBlipName(blip))
            }
          let pBlipTable = { applyBlipSettings: applyBlipSettingsEvent }
          pBlipTable.createBlip = blipCreationEvent
          const LPXHUD = pBlipTable,
            getMapRangeEvent = (pMap, pRange, pArgs) => {
              return (
                pRange[0] +
                ((pArgs - pMap[0]) * (pRange[1] - pRange[0])) /
                  (pMap[1] - pMap[0])
              )
            },
            getDistanceEvent = (
              [pCoordsX, pCoordsY, pCoordsZ],
              [tCoordsX, tCoordsY, tCoordsZ]
            ) => {
              const [dCoordsX, dCoordsY, dCoordsZ] = [
                pCoordsX - tCoordsX,
                pCoordsY - tCoordsY,
                pCoordsZ - tCoordsZ,
              ]
              return Math.sqrt(
                dCoordsX * dCoordsX +
                  dCoordsY * dCoordsY +
                  dCoordsZ * dCoordsZ
              )
            },
            getRandomNumberEvent = (pMin, pMax) => {
              return Math.floor(
                pMax
                  ? Math.random() * (pMax - pMin) + pMin
                  : Math.random() * pMin
              )
            }
          let pGetEntityCoordinates = {}
          pGetEntityCoordinates.getMapRange = getMapRangeEvent
          pGetEntityCoordinates.getDistance = getDistanceEvent
          pGetEntityCoordinates.getRandomNumber = getRandomNumberEvent
          const pEntityCoordinateTable = pGetEntityCoordinates
          function cacheEvent(pEvent, pData) {
            const pCache = cacheableMapEvent((pArgs, pArgs2, ...pDatah) => {
              return whatthefuck.XHcpF(pEvent, pArgs, ...pDatah)
            }, pData)
            var pCacheEventTable = {}
            return (
              (pCacheEventTable.get = function (...pAction) {
                return pCache.get('_', ...pAction)
              }),
              (pCacheEventTable.reset = function () {
                pCache.reset('_')
              }),
              pCacheEventTable
            )
          }
          function cacheableMapEvent(pEvent, pData) {
            const pTime = pData.timeToLive || 60000,
              pCacheableMapEvent = { pFuck: pShit }
            async function cacheMeDaddy(pFuck, ...pParams) {
              let pShit = pCacheableMapEvent[pFuck]
              if (!pShit) {
                pCachedData.lastUpdated = 0
                pShit = pCachedData
              }
              const pDateNow = Date.now()
              if (
                pShit.lastUpdated === 0 ||
                pDateNow - pShit.lastUpdated > pTime
              ) {
                const [keyCacheVal, valueCacheVal] = await pEvent(
                  pShit,
                  pFuck,
                  ...pParams
                )
                return (
                  keyCacheVal &&
                    ((pShit.lastUpdated = pDateNow),
                    (pShit.value = valueCacheVal)),
                  valueCacheVal
                )
              }
              return await new Promise((promposal) =>
                setTimeout(() => promposal(pShit.value), 0)
              )
            }
            var pCacheableDatah = {}
            return (
              (pCacheableDatah.get = async function (pNamee, ...pDatahh) {
                return await cacheMeDaddy(pNamee, ...pDatahh)
              }),
              (pCacheableDatah.reset = function (reset) {
                var resetData = pCacheableMapEvent[reset]
                if (resetData) {
                  resetData.lastUpdated = 0
                }
              }),
              pCacheableDatah
            )
          }
          function waitForConditionEvent(pNameee, pDatahhh) {
            return new Promise((_0x1c6ba8) => {
              const pDate = Date.now(),
                setTickConditionEvent = setTick(() => {
                  const pDateMath = Date.now() - pDate > pDatahhh
                  if (pNameee() || pDateMath) {
                    return clearTick(setTickConditionEvent), _0x1c6ba8(pDateMath)
                  }
                })
            })
          }
          let pCacheablesTable = { cache: cacheEvent }
          pCacheablesTable.cacheableMap = cacheableMapEvent
          pCacheablesTable.waitForCondition = waitForConditionEvent
          const LPXUTILS = Object.assign(pCacheablesTable, pEntityCoordinateTable)
          on('arp-polyzone:enter', (pZone, pData) => {
            setEvent.add(pZone)
            if (
              pData === null || pData === void 0 ? void 0 : pData.id
            ) {
              setEvent.add(pZone + '-' + pData.id)
            }
            const pEnteredZone = mapEvent.get(pZone + '-enter')
            if (pEnteredZone === undefined) {
              return
            }
            for (const zone of pEnteredZone) {
              try {
                zone(pData)
              } catch (err) {
                console.log(err)
              }
            }
          })
          on('arp-polyzone:exit', (pName, pData) => {
            setEvent.delete(pName)
            if (
              pData === null || pData === void 0 ? void 0 : pData.id
            ) {
              setEvent.delete(pName + '-' + pData.id)
            }
            const pMapEventPData = mapEvent.get(pName + '-exit')
            if (pMapEventPData === undefined) {
              return
            }
            for (const mapData of pMapEventPData) {
              try {
                mapData(pData)
              } catch (err) {
                console.log(err)
              }
            }
          })
          const pIsActive = (pName, pData) => {
              return setEvent.has(
                pData ? pName + '-' + pData : pName
              )
            },
            onEnterEvent = (pName, pData) => {
              var pGetData
              const pEnterName = pName + '-enter',
                pGottenName =
                  (pGetData = mapEvent.get(pEnterName)) !== null &&
                  pGetData !== void 0
                    ? pGetData
                    : []
              if (!mapEvent.has(pEnterName)) {
                mapEvent.set(pEnterName, pGottenName)
              }
              pGottenName.push(pData)
            },
            pOnExit = (pName, pData) => {
              var pGetData
              const pEnterName = pName + '-exit',
                pGottenName =
                  (pGetData = mapEvent.get(pEnterName)) !== null &&
                  pGetData !== void 0
                    ? pGetData
                    : []
              if (!mapEvent.has(pEnterName)) {
                mapEvent.set(pEnterName, pGottenName)
              }
              pGottenName.push(pData)
            },
            addBoxZoneEvent = (
              pOptionsID,
              pName,
              pVectors,
              pLength,
              pWidth,
              pOptionAssign,
              pData = {}
            ) => {
              var pArgs = {}
              pArgs.data =
                pData !== null && pData !== void 0 ? pData : {}
              const pOptions = Object.assign(
                Object.assign({}, pOptionAssign),
                pArgs
              )
              pOptions.data.id = pOptionsID
              exportz['arp-polyzone'].AddBoxZone(
                pName,
                pVectors,
                pLength,
                pWidth,
                pOptions
              )
            },
            addBoxTargetEvent = (
              pOptionsID,
              pName,
              pVectors,
              pLength,
              pWidth,
              pOptionAssign,
              pData = {}
            ) => {
              var pArgs = { data: pData }
              const pOptions = Object.assign(
                Object.assign({}, pOptionAssign),
                pArgs
              )
              pOptions.data.id = pOptionsID
              exportz['arp-polytarget'].AddBoxZone(
                pName,
                pVectors,
                pLength,
                pWidth,
                pOptions
              )
            }
          let pZoneEvent = {
            isActive: pIsActive,
            onExit: pOnExit,
          }
          pZoneEvent.onEnter = onEnterEvent
          pZoneEvent.addBoxZone = addBoxZoneEvent
          pZoneEvent.addBoxTarget = addBoxTargetEvent
          const LPXZONES = pZoneEvent,
            encodePayloadEvent = (pString) => {
              try {
                return JSON.stringify(pString)
              } catch (err) {
                console.error('Failed to encode payload')
              }
            },
            decodePayloadEvent = (pString) => {
              try {
                return JSON.parse(pString)
              } catch (err) {
                console.error('Failed to decode payload')
              }
            }
          let pEncodeDecodeData = {}
          pEncodeDecodeData.encodePayload = encodePayloadEvent
          pEncodeDecodeData.decodePayload = decodePayloadEvent
          const encodeDecode = pEncodeDecodeData,
            onEvent = (pName, pData) => {
              return on(pName, pData)
            },
            onNetEvent = (pName, pData) => {
              return onNet(pName, pData)
            },
            removeEvent = (pName, pData) => {
              removeEventListener(pName, pData)
            },
            emitEvent = (pName, ...pData) => {
              emit(pName, ...pData)
            },
            emitNetEvent = (pEvent, ...pData) => {
              const pEventName = pEvent,
                pArgsData = msgpack_pack(pData)
              pArgsData.length < 16000
                ? TriggerServerEventInternal(
                    pEventName,
                    pArgsData,
                    pArgsData.length
                  )
                : TriggerLatentServerEventInternal(
                    pEventName,
                    pArgsData,
                    pArgsData.length,
                    128000
                  )
            }
          let pEventsTable = {
            on: onEvent,
            onNet: onNetEvent,
            remove: removeEvent,
          }
          pEventsTable.emit = emitEvent
          pEventsTable.emitNet = emitNetEvent
          const LPXEVENTS = pEventsTable,
            loadModelEvent = async (_0x2912ea) => {
              const pModel =
                typeof _0x2912ea === 'number' ? _0x2912ea : GetHashKey(_0x2912ea)
              if (HasModelLoaded(pModel)) {
                return true
              }
              RequestModel(pModel)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasModelLoaded(pModel),
                30000
              )
              return !pCondition
            },
            loadAnimEvent = async (pAnimDict) => {
              if (HasAnimDictLoaded(pAnimDict)) {
                return true
              }
              RequestAnimDict(pAnimDict)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasAnimDictLoaded(pAnimDict),
                30000
              )
              return !pCondition
            },
            loadClipSetEvent = async (pClipSet) => {
              if (HasClipSetLoaded(pClipSet)) {
                return true
              }
              RequestClipSet(pClipSet)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasClipSetLoaded(pClipSet),
                30000
              )
              return !pCondition
            },
            loadTextureEvent = async (pTextureDict) => {
              if (HasStreamedTextureDictLoaded(pTextureDict)) {
                return true
              }
              RequestStreamedTextureDict(pTextureDict, true)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasStreamedTextureDictLoaded(pTextureDict),
                30000
              )
              return !pCondition
            },
            loadWeaponAssetEvent = async (pModel, intP1, intP2) => {
              const pWeaponAsset =
                typeof pModel === 'number' ? pModel : GetHashKey(pModel)
              if (HasWeaponAssetLoaded(pWeaponAsset)) {
                return true
              }
              RequestWeaponAsset(pWeaponAsset, intP1, intP2)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasWeaponAssetLoaded(pWeaponAsset),
                30000
              )
              return !pCondition
            },
            loadNamedPtfxAssetEvent = async (pPtfxAsset) => {
              if (HasNamedPtfxAssetLoaded(pPtfxAsset)) {
                return true
              }
              RequestNamedPtfxAsset(pPtfxAsset)
              const pCondition = await LPXUTILS.waitForCondition(
                () => HasNamedPtfxAssetLoaded(pPtfxAsset),
                30000
              )
              return !pCondition
            }
          let pLoadTable = {
            loadModel: loadModelEvent,
            loadTexture: loadTextureEvent,
            loadClipSet: loadClipSetEvent,
          }
          pLoadTable.loadAnim = loadAnimEvent
          pLoadTable.loadWeaponAsset = loadWeaponAssetEvent
          pLoadTable.loadNamedPtfxAsset = loadNamedPtfxAssetEvent
          const LPXSTREAMING = pLoadTable,
            registerEvent = (pEventName, _0x5332b9) => {
              LPXEVENTS.onNet(
                '__lpx_req:' + pEventName,
                async (pEvent, pArgs) => {
                  let pParams, pTrigger
                  const pEventData = encodeDecode.decodePayload(pEvent)
                  if (pEventData === undefined) {
                    return console.log(
                      '[RPC] Received malformed packet:',
                      pEvent
                    )
                  }
                  try {
                    pParams = await _0x3f516e.Xlzdy(_0x5332b9, ...pArgs)
                    pTrigger = true
                  } catch (err) {
                    pParams = err
                    pTrigger = false
                  }
                  if (pEventData.type === 'remote') {
                    LPXEVENTS.emitNet(
                      '__lpx_res:' + pEventData.origin,
                      pEventData.id,
                      [pTrigger, pParams]
                    )
                  } else {
                    pEventData.type === 'local' &&
                      LPXEVENTS.emit(
                        '__lpx_res:' + pEventData.origin,
                        pEventData.id,
                        [pTrigger, pParams]
                      )
                  }
                }
              )
            },
            executeEvent = (pName, ...pData) => {
              console.log('[RPC] Executing procedure:', pName, pData)
              const sID = GetPlayerServerId(PlayerId())
              var eventSwitch = {
                id: ++pTime,
                origin: pOrigin,
              }
              eventSwitch.type = 'remote'
              eventSwitch.src = sID
              const pPayload = eventSwitch,
                pDummyPromise = new Promise((promiseString, error) => {
                  const timeout = +setTimeout(
                    () =>
                      error(
                        new Error('Remote call timed out | ' + pName)
                      ),
                    60000
                  )
                  var stateBag = { resolve: promiseString }
                  stateBag.reject = error
                  stateBag.timeout = timeout
                  artificalBag.set(pPayload.id, stateBag)
                })
              return (
                LPXEVENTS.emitNet(
                  '__lpx_req:' + pName,
                  encodeDecode.encodePayload(pPayload),
                  pData
                ),
                pDummyPromise.finally(() => artificalBag.delete(pPayload.id)),
                pDummyPromise
              )
            }
          LPXEVENTS.onNet('__lpx_res:' + pOrigin, (pName, pData) => {
            const artificialBagPName = artificalBag.get(pName)
            if (artificialBagPName === undefined) {
              return
            }
            clearTimeout(artificialBagPName.timeout)
            const [keyOnNet, valueOnNet] = pData
            if (keyOnNet) {
              artificialBagPName.resolve(valueOnNet)
            } else {
              artificialBagPName.reject(new Error(valueOnNet))
            }
          })
          let pEventTable = {}
          pEventTable.register = registerEvent
          pEventTable.execute = executeEvent
          const LPXPROCEDURES = pEventTable,
            peakEntryModelEvent = (pModel, pData, pOptions) => {
              lol.g.exports['arp-interact'].AddPeekEntryByModel(
                pModel,
                pData,
                pOptions
              )
            },
            peakEntryPolytargetEvent = (pEvent, pData, pOptions) => {
              lol.g.exports['arp-interact'].AddPeekEntryByPolyTarget(
                pEvent,
                pData,
                pOptions
              )
            },
            peakEntryFlagEvent = (pFlag, pData, pOptions) => {
              lol.g.exports['arp-interact'].AddPeekEntryByFlag(
                pFlag,
                pData,
                pOptions
              )
            },
            startTaskBarEvent = (
              pLength,
              pName,
              pRunCheck = false,
              pCb = null
            ) => {
              return new Promise((promize) => {
                lol.g.exports['arp-taskbar'].taskBar(
                  pLength,
                  pName,
                  pRunCheck,
                  true,
                  null,
                  false,
                  promize,
                  pCb === null || pCb === void 0
                    ? void 0
                    : pCb.distance,
                  pCb === null || pCb === void 0
                    ? void 0
                    : pCb.entity
                )
              })
            }
          let LPXUI = {
            addPeekEntryByModel: peakEntryModelEvent,
          }
          LPXUI.addPeekEntryByTarget = peakEntryPolytargetEvent
          LPXUI.addPeekEntryByFlag = peakEntryFlagEvent
          LPXUI.taskBar = startTaskBarEvent
          const LPXINTERFACE = LPXUI
          let LPX = {
            Zones: LPXZONES,
            Hud: LPXHUD,
          }
          LPX.Events = LPXEVENTS
          LPX.Procedures = LPXPROCEDURES
          LPX.Streaming = LPXSTREAMING
          LPX.Utils = LPXUTILS
          LPX.Interface = LPXINTERFACE
          const LPXLib = LPX
          lol.g.LPX = LPXLib
          setImmediate(() => {
            lol.g.exports('GetLibrary', () => {
              return LPXLib
            })
          })
        },
      },
      Obj = {
        g: (function () {
          if (typeof globalThis === 'object') {
            return globalThis
          }
          try {
            return this || new Function('return this')()
          } catch (_0x308f50) {
            if (typeof window === 'object') {
              return window
            }
          }
        })(),
      }
    !(function () {})()
    var LPXTable = {}
    loadLPX[50](0, LPXTable, Obj)
  })()
  