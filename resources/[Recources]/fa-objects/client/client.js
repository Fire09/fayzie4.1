;(function () {
  'use strict'
  var newContainerExportThread = {
      678: function (_0x2783f9, _0x4f4e18) {
        Object.defineProperty(_0x4f4e18, '__esModule', { value: true })
        _0x4f4e18.Hud =
          _0x4f4e18.Interface =
          _0x4f4e18.Utils =
          _0x4f4e18.Streaming =
          _0x4f4e18.Zones =
          _0x4f4e18.Procedures =
          _0x4f4e18.Events =
            void 0
        _0x4f4e18.Events = {
          on: (_0x4f239c, _0x188b24) => {
            return LPX.Events.on(_0x4f239c, _0x188b24)
          },
          onNet: (_0x1f2082, _0x561486) => {
            return LPX.Events.onNet(_0x1f2082, _0x561486)
          },
          emit: (_0x3c6294, ..._0x4b36be) => {
            return LPX.Events.emit(_0x3c6294, ..._0x4b36be)
          },
          emitNet: (_0x2a2b31, ..._0x222c54) => {
            return LPX.Events.emitNet(_0x2a2b31, ..._0x222c54)
          },
          remove: (_0x50be3a, _0x52b798) => {
            return LPX.Events.remove(_0x50be3a, _0x52b798)
          },
        }
        _0x4f4e18.Procedures = {
          register: (_0x5ded20, _0x28b3a3) => {
            return LPX.Procedures.register(_0x5ded20, _0x28b3a3)
          },
          execute: (_0x41a21f, ..._0x2e3772) => {
            return (
              console.log('execute', _0x41a21f, _0x2e3772),
              LPX.Procedures.execute(_0x41a21f, ..._0x2e3772)
            )
          },
        }
        _0x4f4e18.Zones = {
          isActive: (_0x4a4a63, _0x34bec2) => {
            return LPX.Zones.isActive(_0x4a4a63, _0x34bec2)
          },
          onEnter: (_0x494fad, _0x323903) => {
            return LPX.Zones.onEnter(_0x494fad, _0x323903)
          },
          onExit: (_0x541aec, _0x2ec5e1) => {
            return LPX.Zones.onExit(_0x541aec, _0x2ec5e1)
          },
          addBoxZone: (
            _0xd67b49,
            _0x5dc9a6,
            _0x3bbcbc,
            _0x263cde,
            _0x121ac8,
            _0x3d6ce7,
            _0x1eae1d = {}
          ) => {
            return LPX.Zones.addBoxZone(
              _0xd67b49,
              _0x5dc9a6,
              _0x3bbcbc,
              _0x263cde,
              _0x121ac8,
              _0x3d6ce7,
              _0x1eae1d
            )
          },
          addBoxTarget: (
            _0x3cbdd1,
            _0x323eaf,
            _0x575aee,
            _0xd03814,
            _0xb6ba1e,
            _0x1a8e31,
            _0x18a195 = {}
          ) => {
            return LPX.Zones.addBoxTarget(
              _0x3cbdd1,
              _0x323eaf,
              _0x575aee,
              _0xd03814,
              _0xb6ba1e,
              _0x1a8e31,
              _0x18a195
            )
          },
        }
        _0x4f4e18.Streaming = {
          loadModel: (_0x175d5f) => {
            return LPX.Streaming.loadModel(_0x175d5f)
          },
          loadTexture: (_0x558b6d) => {
            return LPX.Streaming.loadTexture(_0x558b6d)
          },
          loadAnim: (_0x4b3aed) => {
            return LPX.Streaming.loadAnim(_0x4b3aed)
          },
          loadClipSet: (_0x3ab1c5) => {
            return LPX.Streaming.loadClipSet(_0x3ab1c5)
          },
          loadWeaponAsset: (_0x4cf4c9, _0x279398, _0x59e8c0) => {
            return LPX.Streaming.loadWeaponAsset(_0x4cf4c9)
          },
          loadNamedPtfxAsset: (_0x43533b) => {
            return LPX.Streaming.loadNamedPtfxAsset(_0x43533b)
          },
        }
        _0x4f4e18.Utils = {
          cache: (_0x3897c1, _0x4da209) => {
            return LPX.Utils.cache(_0x3897c1, _0x4da209)
          },
          cacheableMap: (_0x230c78, _0x18cc83) => {
            return LPX.Utils.cacheableMap(_0x230c78, _0x18cc83)
          },
          waitForCondition: (_0x315e22, _0x28f3fe) => {
            return LPX.Utils.waitForCondition(_0x315e22, _0x28f3fe)
          },
          getMapRange: (_0xff253a, _0x3979bc, _0x4c0284) => {
            return LPX.Utils.getMapRange(_0xff253a, _0x3979bc, _0x4c0284)
          },
          getDistance: (
            [_0x1e608f, _0x162771, _0x497e1a],
            [_0x540f5e, _0x3cd531, _0x17b643]
          ) => {
            return LPX.Utils.getDistance(
              [_0x1e608f, _0x162771, _0x497e1a],
              [_0x540f5e, _0x3cd531, _0x17b643]
            )
          },
          getRandomNumber: (_0x55841f, _0x44bb75) => {
            return LPX.Utils.getRandomNumber(_0x55841f, _0x44bb75)
          },
        }
        _0x4f4e18.Interface = {
          addPeekEntryByModel: (_0x78e684, _0xc8ee38, _0x237162) => {
            return LPX.Interface.addPeekEntryByModel(
              _0x78e684,
              _0xc8ee38,
              _0x237162
            )
          },
          addPeekEntryByTarget: (_0x2eea22, _0x5e960d, _0x4ea8a0) => {
            return LPX.Interface.addPeekEntryByTarget(
              _0x2eea22,
              _0x5e960d,
              _0x4ea8a0
            )
          },
          addPeekEntryByFlag: (_0x28c072, _0x52b60d, _0x2274c2) => {
            return LPX.Interface.addPeekEntryByFlag(
              _0x28c072,
              _0x52b60d,
              _0x2274c2
            )
          },
          taskbar: (
            _0x25f34b,
            _0x44fcc6,
            _0x5a8f98 = false,
            _0x3c3787 = null
          ) => {
            return LPX.Interface.taskbar(
              _0x25f34b,
              _0x44fcc6,
              _0x5a8f98,
              _0x3c3787
            )
          },
          phoneConfirmation: (_0x318877, _0x108705, _0x43fe2c) => {
            return LPX.Interface.phoneConfirmation(
              _0x318877,
              _0x108705,
              _0x43fe2c
            )
          },
          phoneNotification: (
            _0x2ba57c,
            _0x4f62da,
            _0x2d2fa2,
            _0x3976df = true
          ) => {
            return LPX.Interface.phoneNotification(
              _0x2ba57c,
              _0x4f62da,
              _0x2d2fa2,
              _0x3976df
            )
          },
        }
        _0x4f4e18.Hud = {
          createBlip: (_0x4f96dd, ..._0x40abf5) => {
            return LPX.Hud.createBlip(_0x4f96dd, ..._0x40abf5)
          },
          applyBlipSettings: (
            _0x2cf4c7,
            _0x3f71e5,
            _0x68e810,
            _0x5b3cc5,
            _0x1128e1,
            _0xfd6b65,
            _0x526167,
            _0x40463b
          ) => {
            return LPX.Hud.applyBlipSettings(
              _0x2cf4c7,
              _0x3f71e5,
              _0x68e810,
              _0x5b3cc5,
              _0x1128e1,
              _0xfd6b65,
              _0x526167,
              _0x40463b
            )
          },
        }
      },
      615: function (_0x293865, _0xd0e178) {
        Object.defineProperty(_0xd0e178, '__esModule', { value: true })
        _0xd0e178.mathClass = _0xd0e178.loadAnimDict = _0xd0e178.Delay = void 0
        let _0x1d5a62 = (_0x31cc1f) =>
          new Promise((_0x292590) => setTimeout(_0x292590, _0x31cc1f))
        _0xd0e178.Delay = _0x1d5a62
        async function _0x3cf421(_0x10a763) {
          while (!HasAnimDictLoaded(_0x10a763)) {
            RequestAnimDict(_0x10a763)
            await (0, _0xd0e178.Delay)(5)
          }
        }
        _0xd0e178.loadAnimDict = _0x3cf421
        class _0x2651c0 {
          constructor(_0x2b87b9 = 0, _0x27f5f9 = 0, _0x5a3376 = 0) {
            this.x = _0x2b87b9
            this.y = _0x27f5f9
            this.z = _0x5a3376
          }
          ['setFromArray'](_0x23b335) {
            return (
              (this.x = _0x23b335[0]),
              (this.y = _0x23b335[1]),
              (this.z = _0x23b335[2]),
              this
            )
          }
          ['getArray']() {
            return [this.x, this.y, this.z]
          }
          ['add'](_0x5f40ff) {
            return (
              (this.x += _0x5f40ff.x),
              (this.y += _0x5f40ff.y),
              (this.z += _0x5f40ff.z),
              this
            )
          }
          ['addScalar'](_0x2e777e) {
            return (
              (this.x += _0x2e777e),
              (this.y += _0x2e777e),
              (this.z += _0x2e777e),
              this
            )
          }
          ['sub'](_0x4343e2) {
            return (
              (this.x -= _0x4343e2.x),
              (this.y -= _0x4343e2.y),
              (this.z -= _0x4343e2.z),
              this
            )
          }
          ['equals'](_0x36700a) {
            return (
              this.x === _0x36700a.x &&
              this.y === _0x36700a.y &&
              this.z === _0x36700a.z
            )
          }
          ['subScalar'](_0x3b9604) {
            return (
              (this.x -= _0x3b9604),
              (this.y -= _0x3b9604),
              (this.z -= _0x3b9604),
              this
            )
          }
          ['multiply'](_0x16c4ed) {
            return (
              (this.x *= _0x16c4ed.x),
              (this.y *= _0x16c4ed.y),
              (this.z *= _0x16c4ed.z),
              this
            )
          }
          ['multiplyScalar'](_0x546a9d) {
            return (
              (this.x *= _0x546a9d),
              (this.y *= _0x546a9d),
              (this.z *= _0x546a9d),
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
            let _0x53346c = this.magnitude
            if (isNaN(_0x53346c)) {
              _0x53346c = 0
            }
            return this.multiplyScalar(1 / _0x53346c)
          }
          ['forward']() {
            const _0x5e4c59 = _0x2651c0
              .fromObject(this)
              .multiplyScalar(Math.PI / 180)
            return new _0x2651c0(
              -Math.sin(_0x5e4c59.z) * Math.abs(Math.cos(_0x5e4c59.x)),
              Math.cos(_0x5e4c59.z) * Math.abs(Math.cos(_0x5e4c59.x)),
              Math.sin(_0x5e4c59.x)
            )
          }
          ['getDistance'](_0x354a27) {
            const [_0x319dc9, _0x327f35, _0x4db30c] = [
              this.x - _0x354a27.x,
              this.y - _0x354a27.y,
              this.z - _0x354a27.z,
            ]
            return Math.sqrt(
              _0x319dc9 * _0x319dc9 +
                _0x327f35 * _0x327f35 +
                _0x4db30c * _0x4db30c
            )
          }
          ['getDistanceFromArray'](_0x12865d) {
            const [_0x60b8, _0x29a21c, _0x39b7b7] = [
              this.x - _0x12865d[0],
              this.y - _0x12865d[1],
              this.z - _0x12865d[2],
            ]
            return Math.sqrt(
              _0x60b8 * _0x60b8 + _0x29a21c * _0x29a21c + _0x39b7b7 * _0x39b7b7
            )
          }
          static ['fromArray'](_0x5ad084) {
            return new _0x2651c0(_0x5ad084[0], _0x5ad084[1], _0x5ad084[2])
          }
          static ['fromObject'](_0x54700a) {
            return new _0x2651c0(_0x54700a.x, _0x54700a.y, _0x54700a.z)
          }
        }
        _0xd0e178.mathClass = _0x2651c0
      },
    },
    currExportTable = {}
  function globe(newExport) {
    var _0x320f1e = currExportTable[newExport]
    if (_0x320f1e !== undefined) {
      return _0x320f1e.exports
    }
    var newCurrExportTImer = (currExportTable[newExport] = { exports: {} })
    return (
      newContainerExportThread[newExport](newCurrExportTImer, newCurrExportTImer.exports, globe),
      newCurrExportTImer.exports
    )
  }
  !(function () {
    globe.g = (function () {
      if (typeof globalThis === 'object') {
        return globalThis
      }
      try {
        return this || new Function('return this')()
      } catch (_0x1fbfb4) {
        if (typeof window === 'object') {
          return window
        }
      }
    })()
  })()
  var _0x38b2af = {}
  !(function () {
    var _0x43e553 = {},
      prepObj
    prepObj = { value: true }
    prepObj = void 0
    const _0x3ea73a = globe(678),
      _0x1bac61 = globe(615)
    let objectTable = [],
      newObjTable = []
    setImmediate(async () => {
      await (0, _0x1bac61.Delay)(5000)
      Number(objectTable.length) === 0 && emitNet('fa-objects/requestObjects')
    })
    onNet('fa-objects/loadObjects', async (pObjectData) => {
      console.log('[fa-objects] Load Objects')
      let objectTable = pObjectData
      Object.entries(objectTable).forEach(([k, v]) => {
        prepareObject(v)
      })
    })
    onNet('lol:objects:prepareNewObject', async (newObject) => {
      prepareObject(newObject)
    })
    on('fa-polyzone:enter', async (name, data) => {
      if (name !== 'object_zone') {
        return
      }
      let fountData = objectTable.findIndex(
        (pData) => pData.id.toString() === data.id.toString()
      )
      if (!objectTable[fountData]) {
        return
      }
      if (objectTable[fountData].obj) {
        return
      }
      console.log('[fa-objects] Entered zone, load objects in distance.')
      let pCoordsTable = objectTable[fountData].coordinates
      objectTable[fountData].obj = await createAndLoadObject(
        objectTable[fountData].model,
        pCoordsTable.x,
        pCoordsTable.y,
        pCoordsTable.z,
        pCoordsTable.h
      )
      let findData = newObjTable.findIndex(
        (fountdata) => fountdata.id.toString() === data.id.toString()
      )
      newObjTable[findData] = {
        x: pCoordsTable.x,
        y: pCoordsTable.y,
        z: pCoordsTable.z,
      }
    })
    on('fa-polyzone:exit', (name, data) => {
      if (name !== 'object_zone') {
        return
      }
      let findData = objectTable.findIndex(
        (fountData) => fountData.id.toString() === data.id.toString()
      )
      if (!objectTable[findData]) {
        return
      }
      if (!objectTable[findData].obj) {
        return
      }
      console.log('[fa-objects] Left zone, unload objects in distance.')
      DeleteObject(objectTable[findData].obj)
      objectTable[findData].obj = 0
      let filteredData = newObjTable.filter(
        (_0x4926c1) => Number(_0x4926c1.id) !== Number(data.id)
      )
      newObjTable = filteredData
    })
    onNet('fa-objects/clearObjects', (objectData) => {
      Object.entries(objectData).forEach(([k, v]) => {
        let findIndex = newObjTable.findIndex(
          (fountIndex) => fountIndex.id.toString() === v.toString()
        )
        if (newObjTable[findIndex]) {
          let filterData = newObjTable.filter(
            (filteredData) => Number(filteredData.id) !== Number(v)
          )
          newObjTable = filterData
        }
        let findData = objectTable.findIndex(
          (fountData) => fountData.id.toString() === v.toString()
        )
        if (objectTable[findData]) {
          objectTable[findData].obj &&
            DeleteObject(Number(objectTable[findData].obj))
          let filterIndex = objectTable.filter(
            (filteredIndex) => Number(filteredIndex.id) !== Number(v)
          )
          objectTable = filterIndex
        }
      })
    })
    onNet('fa-objects/updateObjects', (objectData) => {
      Object.entries(objectData).forEach(([k, v]) => {
        let findData = newObjTable.findIndex(
          (fountData) => fountData.id.toString() === v.toString()
        )
        if (newObjTable[findData]) {
          let filterData = newObjTable.filter(
            (filteredData) => Number(filteredData.id) !== Number(v)
          )
          newObjTable = filterData
        }
        let findInd = objectTable.findIndex(
          (fountInd) => fountInd.id.toString() === v.toString()
        )
        if (objectTable[findInd]) {
          objectTable[findInd].obj && DeleteObject(objectTable[findInd].obj)
          let filterObjTable = objectTable.filter(
            (filteredObjTable) => Number(filteredObjTable.id) !== Number(v)
          )
          objectTable = filterObjTable
        }
      }),
        prepareObject(objectData)
    })
    async function prepareObject(objectData) {
      console.log('[fa-objects] Adding object: ', objectData)
      let coords = {
        x: objectData.coordinates.x,
        y: objectData.coordinates.y,
        z: objectData.coordinates.z,
      }
      PolyZone.addCircleZone(
        'object_zone',
        {
          x: objectData.coordinates.x,
          y: objectData.coordinates.y,
          z: objectData.coordinates.z,
        },
        Math.max(75, 40),
        { data: { id: objectData.id } }
      )
      let pObject = undefined,
        entityCoords = GetEntityCoords(PlayerPedId(), false),
        dist = GetDistanceBetweenCoords(
          entityCoords[0],
          entityCoords[1],
          entityCoords[2],
          coords.x,
          coords.y,
          coords.z,
          true
        )
      if (Number(dist) < 25) {
        let heading = objectData.coordinates.h
        if (heading === undefined) {
          heading = 0
        }
        pObject = await createAndLoadObject(
          objectData.model,
          coords.x,
          coords.y,
          coords.z,
          heading
        )
        newObjTable.push({
          id: objectData.id,
          vector: coords,
        })
      }
      objectTable.push({
        id: objectData.id,
        model: objectData.model,
        coordinates: objectData.coordinates,
        metaData: objectData.metaData,
        obj: pObject,
      })
    }
    prepObj = prepareObject
    async function createAndLoadObject(
      pObject,
      coordsX,
      coordsY,
      coordsZ,
      coordsH
    ) {
      await _0x3ea73a.Streaming.loadModel(pObject)
      const pObjHash = GetHashKey(pObject)
      let createdEntity = CreateObjectNoOffset(
        pObjHash,
        coordsX,
        coordsY,
        coordsZ,
        false,
        false,
        false
      )
      if (!coordsH) {
        coordsH = 0
      }
      if (typeof coordsH === 'number') {
        SetEntityHeading(createdEntity, coordsH + 0)
      } else {
        SetEntityRotation(
          createdEntity,
          coordsH.x,
          coordsH.y,
          coordsH.z,
          2,
          true
        )
      }
      return FreezeEntityPosition(createdEntity, true), createdEntity
    }
    on('onResourceStop', (resName) => {
      if (resName !== 'fa-objects') {
        return
      }
      Object.entries(objectTable).forEach(([k, v]) => {
        if (v.obj) {
          DeleteObject(Number(v.obj))
        }
      })
    })
    function GetObjectByEntity(pEntity) {
      let pFountData = false
      return (
        Object.entries(objectTable).forEach(([k, v]) => {
          if (Number(v.obj) === Number(pEntity)) {
            let findInd = objectTable.findIndex(
              (fountInd) => Number(fountInd.id) === Number(v.id)
            )
            objectTable[findInd] && (pFountData = objectTable[findInd])
          }
        }),
        pFountData
      )
    }
    exports('GetObjectByEntity', GetObjectByEntity)
    function GetObject(pObject) {
      let pFountData = false,
        findInd = objectTable.findIndex(
          (fountInd) => fountInd.id.toString() === pObject.toString()
        )
      return (
        objectTable[findInd] && (pFountData = objectTable[findInd]), pFountData
      )
    }
    exports('GetObject', GetObject)
    function DelObject(obj) {
      let deleted = RPC.execute('fa-objects/DeleteObject', obj)
      return deleted
    }
    exports('DelObject', DelObject)
    function UpdateObject(object, updatedObject) {
      RPC.execute('fa-objects/UpdateObject', object, updatedObject)
    }
    exports('UpdateObject', UpdateObject)
    RegisterCommand(
      'getObject',
      (src, args, user) => {
        let obj = args[0],
          consoleObj = _0x14414e(obj)
        console.log('[fa-objects] getObject return: ', consoleObj)
      },
      false
    )
    RegisterCommand(
      'objects:print',
      () => {
        console.log(objectTable)
      },
      false
    )
  })()
  !(function () {
    var _0x2dcc1b = _0x38b2af,
      _0x3cb0b3
    _0x3cb0b3 = { value: true }
    const findArrayCoords = globe(615)
    let eModel = undefined,
      pMetaData = undefined,
      preparedObject = false,
      pCoordsH = 0,
      someUndefinedGlobal = undefined,
      _0x1e299c = undefined
    const PlaceAndSaveObject = async (
      pObjectModel,
      pHeading = {},
      _0x72d15e,
      _0x46e724 = () => true,
      pRando = 'objects',
      pMetaData
    ) => {
      const [_0x5447e5, pCoords] = await PlaceObject(
        pObjectModel,
        _0x72d15e,
        _0x46e724
      )
      if (!_0x5447e5) {
        return null
      }
      return await RPC.execute(
        'fa-objects/SaveObject',
        pRando,
        pObjectModel,
        pCoords.coords,
        pCoords.rotation,
        pHeading,
        pMetaData
      )
    }
    exports('PlaceAndSaveObject', PlaceAndSaveObject)
    let _0x49ebb8 = false
    const PlaceObject = async (hash, options, _0x65c686 = () => true) => {
      var _0x3deadd, _0x3e8019, _0x54e9e9, _0x1e7782
      if (_0x49ebb8) {
        return [false, null]
      }
      const modelHash =
        typeof hash === 'string' ? hash.trim() : hash
      if (!IsModelValid(modelHash)) {
        return [false, null]
      }
      _0x49ebb8 = true
      await createAndRequestModel(modelHash)
      const [min, max] = GetModelDimensions(modelHash),
        minArray = findArrayCoords.mathClass.fromArray(min),
        maxArray = findArrayCoords.mathClass.fromArray(max),
        maxArrayMinArray = maxArray.sub(minArray),
        playerPed = PlayerPedId()
      let pPlacing =
          (_0x3deadd = options.groundSnap) !== null && _0x3deadd !== void 0
            ? _0x3deadd
            : options.forceGroundSnap,
        newSnap = GetEntityHeading(playerPed),
        useModelOffset = options.useModelOffset,
        isPreparingObject = true,
        _0x137066 = true,
        drawingOutline = true,
        _0xe78988 =
          (_0x3e8019 = options.zOffset) !== null && _0x3e8019 !== void 0
            ? _0x3e8019
            : 0,
        notSnapped = false
      const _0x184686 =
          (_0x54e9e9 = options.alignToSurface) !== null &&
          _0x54e9e9 !== void 0
            ? _0x54e9e9
            : false,
        _0x10b75f =
          (_0x1e7782 = options.surfaceOffset) !== null && _0x1e7782 !== void 0
            ? _0x1e7782
            : 0,
        pObject = CreateObjectNoOffset(
          modelHash,
          0,
          0,
          0,
          false,
          false,
          false
        )
      SetEntityAlpha(pObject, 200, false)
      SetEntityCollision(pObject, false, false)
      SetCanClimbOnEntity(pObject, false)
      SetEntityDrawOutlineColor(255, 0, 0, 128)
      const _0x3366e4 = setTick(() => {
          var optionsDistance
          const [
            _0x3810f3,
            isEntityRendering,
            pRegularCoords,
            mathAtanValues,
            _0x2cd1d1,
            _0x32b274,
          ] = _0x39cbec(
            19,
            pObject,
            (optionsDistance = options.distance) !== null && optionsDistance !== void 0
              ? optionsDistance
              : 10
          )
          if (isEntityRendering) {
            const pCoordsArray = findArrayCoords.mathClass.fromArray(pRegularCoords)
            !pPlacing && useModelOffset && (pCoordsArray.z += maxArrayMinArray.z / 2)
            let _0x47ac2e = [0, 0, 0]
            _0x184686
              ? ((newSnap =
                  -Math.atan2(mathAtanValues[0], mathAtanValues[1]) * 57.2958 + 180),
                SetEntityHeading(pObject, newSnap),
                (_0x47ac2e = GetEntityForwardVector(pObject).map(
                  (_0xcff0c3) => _0xcff0c3 * _0x10b75f
                )))
              : SetEntityHeading(pObject, newSnap)
            SetEntityCoords(
              pObject,
              pCoordsArray.x - _0x47ac2e[0],
              pCoordsArray.y - _0x47ac2e[1],
              pCoordsArray.z - _0x47ac2e[2],
              false,
              false,
              false,
              false
            )
            pPlacing && PlaceObjectOnGroundProperly_2(pObject)
            if (_0xe78988 !== 0) {
              const pCoordsArray = findArrayCoords.mathClass.fromArray(
                GetEntityCoords(pObject, false)
              )
              pCoordsArray.z += _0xe78988
              SetEntityCoords(
                pObject,
                pCoordsArray.x,
                pCoordsArray.y,
                pCoordsArray.z + _0xe78988,
                false,
                false,
                false,
                false
              )
            }
            const isFinishedPlacingObject = pPlacing
                ? findArrayCoords.mathClass.fromArray(
                    GetEntityCoords(pObject, true)
                  )
                : pCoordsArray,
              hasCollision = options.collision
                ? !objectShapeTestRotation(
                    pObject,
                    playerPed,
                    maxArrayMinArray,
                    isFinishedPlacingObject,
                    options.colZOffset
                  )
                : true
            drawingOutline =
              hasCollision &&
              true &&
              _0x65c686(isFinishedPlacingObject, _0x2cd1d1, pObject, _0x32b274)
            if (drawingOutline) {
              SetEntityDrawOutline(pObject, false)
            } else {
              SetEntityDrawOutline(pObject, true)
            }
          } else {
            drawingOutline = false
          }
          options.afterRender &&
            options.afterRender(pObject, !!isEntityRendering, drawingOutline)
        }),
        disabledControlClickTick = setTick(() => {
          DisableControlAction(0, 44, true)
          DisableControlAction(0, 46, true)
          DisableControlAction(0, 140, true)
          DisableControlAction(0, 20, true)
          DisableControlAction(0, 16, true)
          DisableControlAction(0, 17, true)
          DisableControlAction(0, 36, true)
          const disabledControl = IsDisabledControlPressed(0, 36)
          if (IsDisabledControlPressed(2, 17)) {
            if (notSnapped) {
              _0xe78988 += disabledControl ? 0.1 : 0.5
            } else {
              newSnap += disabledControl ? 1 : 5
              if (!disabledControl) {
                newSnap = Math.round(newSnap)
              }
            }
          } else {
            if (IsDisabledControlPressed(2, 16)) {
              if (notSnapped) {
                _0xe78988 -= disabledControl ? 0.1 : 0.5
              } else {
                newSnap -= disabledControl ? 1 : 5
                if (!disabledControl) {
                  newSnap = Math.round(newSnap)
                }
              }
            }
          }
          if (newSnap > 360) {
            newSnap -= 360
          } else {
            newSnap < 0 && (newSnap += 360)
          }
          options.groundSnap &&
            !options.forceGroundSnap &&
            IsDisabledControlJustPressed(0, 44) &&
            (pPlacing = !pPlacing)
          options.useModelOffset &&
            IsDisabledControlJustPressed(0, 140) &&
            (useModelOffset = !useModelOffset)
          if (options.adjustZ && IsDisabledControlJustPressed(0, 20)) {
            notSnapped = !notSnapped
            SetEntityAlpha(pObject, notSnapped ? 255 : 200, false)
          }
          ;(IsDisabledControlJustPressed(0, 200) ||
            IsDisabledControlJustPressed(0, 177)) &&
            (isPreparingObject = false)
          if (drawingOutline && IsDisabledControlJustPressed(0, 46)) {
            _0x137066 = false
            isPreparingObject = false
          }
        })
      while (isPreparingObject) {
        await (0, findArrayCoords.Delay)(1)
      }
      clearTick(_0x3366e4)
      clearTick(disabledControlClickTick)
      const _0x24265a = findArrayCoords.mathClass.fromArray(
          GetEntityCoords(pObject, true)
        ),
        _0x389bbc = findArrayCoords.mathClass.fromArray(
          GetEntityRotation(pObject, 2)
        ),
        _0x4fd77b = GetEntityQuaternion(pObject)
      DoIExistToUsers(pObject)
      _0x49ebb8 = false
      if (_0x137066) {
        return [false, null]
      }
      const _0xa47eb9 = {}
      return (
        (_0xa47eb9.coords = _0x24265a),
        (_0xa47eb9.rotation = _0x389bbc),
        (_0xa47eb9.quaternion = _0x4fd77b),
        [true, _0xa47eb9]
      )
    }
    exports('PlaceObject', PlaceObject)
    function objectShapeTestRotation(_0x5574d5, _0x3fb1d4, _0x38236a, _0x35feb8, _0x598e5e) {
      const _0x2e96b9 = findArrayCoords.mathClass.fromArray(
          GetEntityRotation(_0x5574d5, 2)
        ),
        _0x2dfde1 = findArrayCoords.mathClass
          .fromObject(_0x38236a)
          .multiplyScalar(0.75),
        _0x2b915a = StartShapeTestBox(
          _0x35feb8.x,
          _0x35feb8.y,
          _0x35feb8.z +
            (_0x598e5e !== null && _0x598e5e !== void 0 ? _0x598e5e : 0),
          _0x2dfde1.x,
          _0x2dfde1.y,
          _0x2dfde1.z,
          _0x2e96b9.x,
          _0x2e96b9.y,
          _0x2e96b9.z,
          2,
          83,
          _0x3fb1d4,
          4
        ),
        [_0x2a362f, _0x705c34] = GetShapeTestResultIncludingMaterial(_0x2b915a)
      return _0x705c34
    }
    const _0x39cbec = (_0x36924d, _0x2fd1b4, _0x5a38ab = 5) => {
        const _0xb7f809 = GetGameplayCamCoord(),
          [_0xa67fc1, , _0x291295] = GetGameplayCamRot(0).map(
            (_0x57f2d5) => (Math.PI / 180) * _0x57f2d5
          ),
          _0x1fea0d = Math.abs(Math.cos(_0xa67fc1)),
          _0x5909ba = [
            -Math.sin(_0x291295) * _0x1fea0d,
            Math.cos(_0x291295) * _0x1fea0d,
            Math.sin(_0xa67fc1),
          ],
          _0x1b61b8 = _0x5909ba.map(
            (_0x37f1b5, _0x240f83) => _0xb7f809[_0x240f83] + _0x37f1b5
          ),
          _0x301e4a = findArrayCoords.mathClass
            .fromArray(GetEntityCoords(PlayerPedId(), false))
            .getDistanceFromArray(GetGameplayCamCoord()),
          _0x4f1617 = _0x5909ba.map(
            (_0x3d2695, _0x39094c) =>
              _0xb7f809[_0x39094c] + _0x3d2695 * (_0x5a38ab + _0x301e4a)
          ),
          _0xb721b8 = StartShapeTestSweptSphere(
            _0x1b61b8[0],
            _0x1b61b8[1],
            _0x1b61b8[2],
            _0x4f1617[0],
            _0x4f1617[1],
            _0x4f1617[2],
            0.2,
            _0x36924d,
            _0x2fd1b4,
            7
          )
        return GetShapeTestResultIncludingMaterial(_0xb721b8)
      },
      DoIExistToUsers = (pEntity) => {
        DoesEntityExist(pEntity) && DeleteObject(pEntity)
      }
    async function createAndRequestModel(pModel) {
      if (IsModelValid(pModel)) {
        RequestModel(pModel)
        let isLoaded = false
        setTimeout(() => (isLoaded = true), 3000)
        while (!HasModelLoaded(pModel) && !isLoaded) {
          await (0, findArrayCoords.Delay)(10)
        }
        return !isLoaded
      }
      return false
    }
    function canIPlaceThisObject(pCoords, pArgs) {
      if (someUndefinedGlobal === undefined) {
        return resetCurrObjData()
      }
      let pCoords2 = {
          x: pCoords[0],
          y: pCoords[1],
          z: pCoords[2],
        },
        eCoords = GetEntityCoords(PlayerPedId(), false),
        dist = GetDistanceBetweenCoords(
          eCoords[0],
          eCoords[1],
          eCoords[2],
          pCoords2.x,
          pCoords2.y,
          pCoords2.z,
          true
        )
      if (Number(dist) > 50) {
        emit('DoLongHudText', 'You cannot place the object this far away', 2)
        return
      }
      preparedObject = true
      prepCurrentObject(pCoords)
    }
    function prepCurrentObject(dCoords) {
      emitNet(
        'fa-objects/prepareObject',
        eModel,
        dCoords.x,
        dCoords.y,
        dCoords.z,
        pCoordsH,
        pMetaData
      )
      resetCurrObjData()
    }
    function resetCurrObjData() {
      pCoordsH = 0
      eModel = undefined
      someUndefinedGlobal = undefined
      preparedObject = false
    }
    function startGameplayCamFunction(_0x79df0, _0x3028f9) {
      let pGameplayCamCoords = GetGameplayCamCoord(),
        pGameplayCamRot = GetGameplayCamRot(0),
        pCamRotX = (Math.PI / 180) * pGameplayCamRot[0],
        pCamRotZ = (Math.PI / 180) * pGameplayCamRot[2],
        mathAbsCamRotX = Math.abs(Math.cos(pCamRotX)),
        pCoordsCamRotX = -Math.sin(pCamRotZ) * mathAbsCamRotX,
        pCoordsCamRotY = Math.cos(pCamRotZ) * mathAbsCamRotX,
        pCoordsCamRotZ = Math.sin(pCamRotX),
        pCamCoordsNew = {
          x: pCoordsCamRotX,
          y: pCoordsCamRotY,
          z: pCoordsCamRotZ,
        },
        startTestSphere = StartShapeTestSweptSphere(
          pGameplayCamCoords[0] + pCamCoordsNew.x,
          pGameplayCamCoords[1] + pCamCoordsNew.y,
          pGameplayCamCoords[2] + pCamCoordsNew.z,
          pGameplayCamCoords[0] + pCamCoordsNew.x * 200,
          pGameplayCamCoords[1] + pCamCoordsNew.y * 200,
          pGameplayCamCoords[2] + pCamCoordsNew.z * 200,
          0.2,
          _0x79df0,
          _0x3028f9,
          7
        )
      return GetShapeTestResult(startTestSphere)
    }
    function _0x264aed() {
      const [_0x141562, _0x5dbe5f, _0x4e1d48, _0x1112a4, _0x4c46e3] = startGameplayCamFunction(
        1,
        0
      )
      Number(_0x5dbe5f) === 1 && (someUndefinedGlobal = _0x4e1d48)
    }
    on('onResourceStop', (resName) => {
      if (resName !== 'fa-objects') {
        return
      }
      false && DeleteObject(0)
    })
  })()
})()
