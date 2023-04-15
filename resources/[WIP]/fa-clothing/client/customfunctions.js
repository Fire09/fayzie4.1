const FACE_FEATURES = [
  "noseWidth",
  "nosePeakHigh",
  "nosePeakSize",
  "noseBoneHigh",
  "nosePeakLowering",
  "noseBoneTwist",
  "eyeBrownHigh",
  "eyeBrownForward",
  "cheeksBoneHigh",
  "cheeksBoneWidth",
  "cheeksWidth",
  "eyesOpening",
  "lipsThickness",
  "jawBoneWidth",
  "jawBoneBackSize",
  "chinBoneLowering",
  "chinBoneLenght",
  "chinBoneSize",
  "chinHole",
  "neckThickness",
];

function getPedFaceFeatures(ped) {
  const faceFeatures = FACE_FEATURES.reduce((object, feature, index) => {
    const normalizedValue = parseFloat(
      GetPedFaceFeature(ped, index).toFixed(1)
    );

    // console.log(index, normalizedValue);

    return { ...object, [feature]: normalizedValue };
  }, {});

  return faceFeatures;
}

exports("getPedFaceFeatures", getPedFaceFeatures);

function setPedFaceFeaturesJS(ped, faceFeatures) {
  if (!faceFeatures) return;

  FACE_FEATURES.forEach((key, index) => {
    const faceFeature = faceFeatures[key];

    SetPedFaceFeature(ped, index, faceFeature);
  });
}

exports("setPedFaceFeaturesJS", setPedFaceFeaturesJS);

const GET_PED_HEAD_BLEND_DATA = "0x2746bd9d88c5c5d0";
function getPedHeadBlend(ped) {
  // int, int, int, int, int, int, float, float, float, bool
  const buffer = new ArrayBuffer(80);

  global.Citizen.invokeNative(
    GET_PED_HEAD_BLEND_DATA,
    ped,
    new Uint32Array(buffer)
  );

  /*   
      0: shapeFirst,
      2: shapeSecond,
      4: shapeThird,
      6: skinFirst,
      8: skinSecond,
      10: skinThird,
      18: isParent,
    */
  const {
    0: shapeFirst,
    2: shapeSecond,
    6: skinFirst,
    8: skinSecond,
  } = new Uint32Array(buffer);

  // 0: shapeMix, 2: skinMix, 4: thirdMix
  const { 0: shapeMix, 2: skinMix } = new Float32Array(buffer, 48);

  const normalizedShapeMix = parseFloat(shapeMix.toFixed(1));
  const normalizedSkinMix = parseFloat(skinMix.toFixed(1));

  return {
    shapeFirst,
    shapeSecond,
    skinFirst,
    skinSecond,
    shapeMix: normalizedShapeMix,
    skinMix: normalizedSkinMix,
  };
}

exports("getPedHeadBlend", getPedHeadBlend);

function setPedHeadBlend(ped, headBlend) {
  if (!headBlend) return;

  const { shapeFirst, shapeSecond, shapeMix, skinFirst, skinSecond, skinMix } =
    headBlend;

    if (exports.isPed.isPedFreemodeModel(ped)) {
    SetPedHeadBlendData(
      ped,
      shapeFirst,
      shapeSecond,
      0,
      skinFirst,
      skinSecond,
      0,
      shapeMix,
      skinMix,
      0,
      false
    );
  }
}

exports("setPedHeadBlend", setPedHeadBlend);

const HEAD_OVERLAYS = [
  "blemishes",
  "beard",
  "eyebrows",
  "ageing",
  "makeUp",
  "blush",
  "complexion",
  "sunDamage",
  "lipstick",
  "moleAndFreckles",
  "chestHair",
  "bodyBlemishes",
];

function getPedHeadOverlays(ped) {
  const headOverlays = HEAD_OVERLAYS.reduce((object, overlay, index) => {
    // success, value, colorType, firstColor, secondColor, opacity
    const [, value, , firstColor, , opacity] = GetPedHeadOverlayData(
      ped,
      index
    );

    const hasOverlay = value !== 255;

    const safeValue = hasOverlay ? value : 0;
    const normalizedOpacity = hasOverlay ? parseFloat(opacity.toFixed(1)) : 0;

    return {
      ...object,
      [overlay]: {
        style: safeValue,
        opacity: normalizedOpacity,
        color: firstColor,
      },
    };
  }, {});

  return headOverlays;
}

exports("getPedHeadOverlays", getPedHeadOverlays);

function setPedHeadOverlays(ped, headOverlays) {
  if (!headOverlays) return;

  HEAD_OVERLAYS.forEach((key, index) => {
    const headOverlay = headOverlays[key];

    SetPedHeadOverlay(ped, index, headOverlay.style, headOverlay.opacity);

    if (headOverlay.color || headOverlay.color === 0) {
      let colorType = 1;

      const isMakeupColor = {
        blush: true,
        lipstick: true,
        makeUp: true,
      };

      if (isMakeupColor[key]) {
        colorType = 2;
      }
      
      SetPedHeadOverlayColor(ped, index, colorType, headOverlay.color, headOverlay.secondColor);
    }
  });
}

exports("setPedHeadOverlays", setPedHeadOverlays);

const PED_PROPS_IDS = [0, 1, 2, 6, 7];
function getPedProps(ped) {
  const props = [];

  PED_PROPS_IDS.forEach((propId) => {
    props.push({
      prop_id: propId,
      drawable: GetPedPropIndex(ped, propId),
      texture: GetPedPropTextureIndex(ped, propId),
    });
  });

  return props;
}

exports("getPedProps", getPedProps);

function setPedProp(ped, prop) {
  if (!prop) return;

  const { prop_id, drawable, texture } = prop;

  if (drawable === -1) {
    ClearPedProp(ped, prop_id);
  } else {
    SetPedPropIndex(ped, prop_id, drawable, texture, false);
  }
}

function setPedProps(ped, props) {
  if (!props) return;

  props.forEach((prop) => setPedProp(ped, prop));
}

exports("setPedProps", setPedProps);


async function setPlayerModel(model) {
  if (!model) return;

  if (!IsModelInCdimage(model)) return;

  RequestModel(model);

  while (!HasModelLoaded(model)) {
    await Delay(0);
  }

  SetPlayerModel(PlayerId(), model);
  SetModelAsNoLongerNeeded(model);

  const playerPed = PlayerPedId();

  if (isPedFreemodeModel(playerPed)) {
    SetPedDefaultComponentVariation(playerPed);
    SetPedHeadBlendData(playerPed, 0, 0, 0, 0, 0, 0, 0, 0, 0, false);
  }
}

exports("setPlayerModel", setPlayerModel)


const CAMERAS = [
  {
    //face baya yakın
    coords: { x: 0, y: 0.6, z: 0.70 },
    point: { x: 0, y: 0, z: 0.6 },
  },
  {
    //face
    coords: { x: 0, y: 0.9, z: 0.65 },
    point: { x: 0, y: 0, z: 0.6 },
  },
  {
    //body
    coords: { x: 0, y: 1.2, z: 0.2 },
    point: { x: 0, y: 0, z: 0.2 },
  },
  {
    //default
    coords: { x: 0, y: 2.2, z: 0.2 },
    point: { x: 0, y: 0, z: -0.05 },
  },
  {
    //bottom
    coords: { x: 0, y: 0.98, z: -0.7 },
    point: { x: 0, y: 0, z: -0.9 },
  },
]


let cameraHandle;
let currentCamera;
let reverseCamera;

let isCameraInterpolating;
let crcamera = 0

exports("updateCamera", function(data) {
  let index = 1
  if( data == "up") 
      index = -1

  setCamera(crcamera + index)

})

function arrayToVector3(coords) {
  return {
    x: coords[0],
    y: coords[1],
    z: coords[2],
  };
}

function setCamera(key) {
  if (isCameraInterpolating) {
    return;
  }

  if (key >= CAMERAS.length) key = 0; else if (key <= -1) key = CAMERAS.length

  currentCamera = key;
  crcamera = key
  

  const { coords, point } = CAMERAS[currentCamera];

  const reverseFactor = reverseCamera ? -1 : 1;

  if (cameraHandle) {
    const camCoords = arrayToVector3(
      GetOffsetFromEntityInWorldCoords(
        PlayerPedId(),
        coords.x * reverseFactor,
        coords.y * reverseFactor,
        coords.z,
      ),
    );

    const camPoint = arrayToVector3(
      GetOffsetFromEntityInWorldCoords(PlayerPedId(), point.x, point.y, point.z),
    );

    const tmpCamera = CreateCameraWithParams(
      'DEFAULT_SCRIPTED_CAMERA',
      camCoords.x,
      camCoords.y,
      camCoords.z,
      0.0,
      0.0,
      0.0,
      50.0,
      false,
      0,
    );
    PointCamAtCoord(tmpCamera, camPoint.x, camPoint.y, camPoint.z);
    SetCamActiveWithInterp(tmpCamera, cameraHandle, 600, 1, 1);

    isCameraInterpolating = true;

    const updateCameraInterval = setInterval(() => {
      if (!IsCamInterpolating(cameraHandle) && IsCamActive(tmpCamera)) {
        DestroyCam(cameraHandle, false);
        cameraHandle = tmpCamera;
        isCameraInterpolating = false;
        clearInterval(updateCameraInterval);
      }
    }, 500);
  } else {
    const camCoords = arrayToVector3(
      GetOffsetFromEntityInWorldCoords(PlayerPedId(), coords.x, coords.y, coords.z),
    );

    const camPoint = arrayToVector3(
      GetOffsetFromEntityInWorldCoords(PlayerPedId(), point.x, point.y, point.z),
    );

    cameraHandle = CreateCameraWithParams(
      'DEFAULT_SCRIPTED_CAMERA',
      camCoords.x,
      camCoords.y,
      camCoords.z,
      0.0,
      0.0,
      0.0,
      50.0,
      false,
      0,
    );
    PointCamAtCoord(cameraHandle, camPoint.x, camPoint.y, camPoint.z);
    SetCamActive(cameraHandle, true);
  }
}

exports("setCamera", setCamera)

function closeCamera() {
  RenderScriptCams(false, false, 0, true, true);
  DestroyCam(cameraHandle, false);
}

exports("closeCamera", closeCamera)

