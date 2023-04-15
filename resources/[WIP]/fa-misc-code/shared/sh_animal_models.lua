local animalModels = json.decode(LoadResourceFile(GetCurrentResourceName(), "shared/animalModels.json"))

local animalModelStringToHash = {}
local animalModelHashToString = {}

for modelString, _ in pairs(animalModels) do
    local modelHash = GetHashKey(modelString)
    animalModelStringToHash[modelString] = modelHash
    animalModelHashToString[modelHash] = modelString
end

function isAnimalModel(modelStringOrHash)
    if type(modelStringOrHash) == "string" then
        return animalModelStringToHash[modelStringOrHash] ~= nil
    else
        return animalModelHashToString[modelStringOrHash] ~= nil
    end
end
exports("isAnimalModel", isAnimalModel)

function getAnimalModelDict(modelStringOrHash)
    local modelString = type(modelStringOrHash) == "string" and modelStringOrHash or animalModelHashToString[modelStringOrHash]
    if not modelString then return nil end
    if not animalModels[modelString] then return nil end
    return animalModels[modelString]["dict"]
end
exports("getAnimalModelDict", getAnimalModelDict)

function getAnimalModelAnim(modelStringOrHash, anim)
    local modelString = type(modelStringOrHash) == "string" and modelStringOrHash or animalModelHashToString[modelStringOrHash]
    if not modelString then return nil end
    if not animalModels[modelString] then return nil end
    local anims = animalModels[modelString]["anims"]
    if not anims then return nil end
    return anims[anim]
end
exports("getAnimalModelAnim", getAnimalModelAnim)
