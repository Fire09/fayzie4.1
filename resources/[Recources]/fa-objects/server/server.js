!(function () {
    'use strict'
    onNet('fa-objects/requestObjects', async () => {
      let src = source,
        query = await SQL.execute('SELECT * FROM __objects', {}),
        objTable = []
      for (let i = 0; i < query.length; i++) {
        let pCoords = JSON.parse(query[Number(i)].coordinates),
          coordsTable = {
            x: pCoords.x,
            y: pCoords.y,
            z: pCoords.z,
            h: pCoords.h,
          }
        objTable.push({
          id: query[Number(i)].id,
          model: query[Number(i)].model,
          coordinates: coordsTable,
          metaData: JSON.parse(query[Number(i)].metaData),
        })
      }
      emitNet('fa-objects/loadObjects', src, objTable)
    })
    onNet(
      'fa-objects/prepareObject',
      async (
        pModel,
        pCoordsX,
        pCoordsY,
        pCoordsZ,
        pCoordsH,
        pMetaData
      ) => {
        let coordinatesTable = {
            x: pCoordsX,
            y: pCoordsY,
            z: pCoordsZ,
            h: pCoordsH,
          },
          randomInt =
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString()
        if (
          !(await SQL.execute(
            'INSERT INTO __objects (model, coordinates, metaData, randomId) VALUES (@model, @coordinates, @metaData, @randomId)',
            {
              model: pModel,
              coordinates: JSON.stringify(coordinatesTable),
              metaData: JSON.stringify(pMetaData),
              randomId: randomInt,
            }
          ))
        ) {
          return
        }
        let propId = await SQL.execute(
          'SELECT * FROM __objects WHERE randomId = @randomId',
          { randomId: randomInt }
        )
        if (!propId[0]) {
          return
        }
        let stackedData = {
          id: propId[0].id,
          model: pModel,
          coordinates: coordinatesTable,
          metaData: pMetaData,
        }
        emitNet('arp:objects:prepareNewObject', -1, stackedData)
      }
    )
    RPC.register(
      'fa-objects/SaveObject',
      async (
        pSrc,
        pRando,
        pObjectModel,
        pCoords,
        pHeading,
        pMetaData
      ) => {
        let coordsTable = {
            x: pCoords.x,
            y: pCoords.y,
            z: pCoords.z,
            h: pHeading,
          },
          randomInt =
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString() +
            Math.floor(10 * Math.random()).toString()
        if (
          !(await SQL.execute(
            'INSERT INTO __objects (model, coordinates, metaData, randomId) VALUES (@model, @coordinates, @metaData, @randomId)',
            {
              model: pObjectModel,
              coordinates: JSON.stringify(coordsTable),
              metaData: JSON.stringify(pMetaData),
              randomId: randomInt,
            }
          ))
        ) {
          return false
        }
        let query = await SQL.execute(
          'SELECT * FROM __objects WHERE randomId = @randomId',
          { randomId: randomInt }
        )
        if (!query[0]) {
          return false
        }
        let stackedData = {
          id: query[0].id,
          model: pObjectModel,
          coordinates: coordsTable,
          metaData: pMetaData,
        }
        return emitNet('arp:objects:prepareNewObject', -1, stackedData), true
      }
    )
    RPC.register('fa-objects/DeleteObject', async (pSrc, pId) => {
      let query = await SQL.execute(
        'SELECT * FROM __objects WHERE id = @id',
        { id: pId }
      )
      if (!query[0]) {
        return false
      }
      let stackedData = {
        id: query[0].id,
        model: query[0].model,
        coordinates: JSON.parse(query[0].coordinates),
        metaData: JSON.parse(query[0].metaData),
        randomId: query[0].randomId,
      }
      return (
        !!(await SQL.execute('DELETE FROM __objects WHERE id = @id', {
          id: pId,
        })) && (emitNet('fa-objects/clearObjects', -1, stackedData), true)
      )
    })
    RPC.register(
      'fa-objects/UpdateObject',
      async (pSrc, pId, pModel) => {
        if (
          !(await SQL.execute(
            'UPDATE __objects SET model = @model WHERE id = @id',
            {
              model: pModel,
              id: pId,
            }
          ))
        ) {
          return false
        }
        let query = await SQL.execute(
          'SELECT * FROM __objects WHERE id = @id',
          { id: pId }
        )
        if (!query[0]) {
          return false
        }
        let stackedData = {
          id: query[0].id,
          model: query[0].model,
          coordinates: JSON.parse(query[0].coordinates),
          metaData: JSON.parse(query[0].metaData),
          randomId: query[0].randomId,
        }
        return emitNet('fa-objects/updateObjects', -1, stackedData), true
      }
    )
  })()
  