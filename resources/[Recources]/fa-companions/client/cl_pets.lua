local cids = {
    [70] = true, -- Soze
    [1004] = true, -- Dw
    [1005] = true, -- Derby
    [1242] = true, -- Ripley
    [3503] = true, -- Dean
}

local petInfo = {
    ["coyote"] = {
      key = "coyote",
      type = "coyote",
      image = "https://i.imgur.com/DSLIlIW.png",
    },
    ["panther"] = {
      key = "panther",
      type = "panther",
      image = "https://i.imgur.com/XyEEplC.png",
    },
    ["pit"] = {
      key = "pit",
      type = "pit",
      image = "https://i.imgur.com/ID7Q0rC.png",
    },
    ["cat"] = {
      key = "cat",
      type = "cat",
      image = "https://i.imgur.com/pOrdQNC.png",
    },
    ["pug"] = {
      key = "pug",
      type = "pug",
      image = "https://i.imgur.com/POlVhoO.png",
    },
    ["poodle"] = {
      key = "poodle",
      type = "poodle",
      image = "https://i.imgur.com/fTgoZFW.png",
    },
    ["westy"] = {
      key = "westy",
      type = "westy",
      image = "https://i.imgur.com/IeClsnO.png",
    },
    ["cow"] = {
      key = "cow",
      type = "cow",
      image = "https://i.imgur.com/TdSko7H.png",
    },
    ["hen"] = {
      key = "hen",
      type = "hen",
      image = "https://i.imgur.com/igYm4Mi.png",
    },
    ["rabbit"] = {
      key = "rabbit",
      type = "rabbit",
      image = "https://i.imgur.com/PRt9vi4.png",
    },
    ["pig"] = {
      key = "pig",
      type = "pig",
      image = "https://i.imgur.com/Wf5jpe0.png",
    },
}

local smallDogSkillList = {
    ["sit"] = true,
    ["bark"] = true,
    ["playdead"] = true,
}

local dogSkillList = {
    ["sit"] = true,
    ["laydown"] = true,
    ["bark"] = true,
    ["beg"] = true,
    ["attack"] = true,
    ["taunt"] = true,
    ["paw"] = true,
    ["playdead"] = true,
}

local bigCatSkillList = {
    ["laydown"] = true,
    ["attack"] = true,
    ["taunt"] = true
}

local bigCatSkillListNoAttack = {
    ["laydown"] = true,
    ["taunt"] = true
}

local catSkillList = {
    ["stretch"] = true,
    ["laydown"] = true,
}

local animalSkillList = {
    ["a_c_chop"] = dogSkillList,
    ["a_c_husky"] = dogSkillList,
    ["a_c_husky_np"] = dogSkillList,
    ["a_c_retriever"] = dogSkillList,
    ["a_c_retriever_np"] = dogSkillList,
    ["a_c_shepherd"] = dogSkillList,
    ["a_c_shepherd_np"] = dogSkillList,
    ["a_c_pit_np"] = dogSkillList,
    ["a_c_panther"] = bigCatSkillList,
    ["a_c_coyote"] = {
        ["laydown"] = true,
        ["howl"] = true
    },
    ["a_c_cat_01"] = catSkillList,
    ["a_c_westy"] = smallDogSkillList,
    ["a_c_pug"] = smallDogSkillList,
    ["a_c_poodle"] = smallDogSkillList,
    ["a_c_cow"] = {
        ["graze"] = true,
    },
    ["a_c_hen"] = {
        ["peck"] = true,
    },
    ["a_c_rabbit_01"] = {},
    ["a_c_pig"] = {
        ["graze"] = true,
    },
}

local lastCompanionId = nil
local lastCompanionAction = nil
local attackNextTarget = false
local spawnedAnimals = {}
local spawnedAnimalsCount = 0
local spawnedK9Units = {}
local ignoreServerIds = {}
local lastActionPressTime = 0
local spawnedAnimalModels = {}

local k9types = {
    [1] = {
      key = "chop",
      type = "rott",
      image = "https://i.imgur.com/rwKGt2b.png",
    },
    [2] = {
      key = "husky",
      type = "shep",
      image = "https://i.imgur.com/Kc51atn.png",
    },
    [3] = {
      key = "retriever",
      type = "retriever",
      image = "https://i.imgur.com/U2EjWoU.png",
    },
    [4] = {
      key = "shepherd",
      type = "shepherd",
      image = "https://i.imgur.com/ZK58r7W.png",
    },
    [5] = {
      key = "pit",
      type = "pit",
      image = "https://i.imgur.com/ID7Q0rC.png",
    },
}

local k9Depts = {
    [1] = {
      key = "lspd",
    },
    [2] = {
      key = "bcso",
    },
    [3] = {
      key = "troopers",
    },
    [4] = {
      key = "rangers",
    },
    [5] = {
      key = "doc",
    },
    [6] = {
      key = "therapy",
    },
}

local function supportedAnimals()
    return {
        ["chop_lspd"] = {
            id = "chop_lspd",
            name = "lspd Chop",
            appearance = {
                model = "a_c_chop",
                components = {
                    {
                        componentId = 3,
                        drawableId = 1,
                        textureId = 0,
                        paletteId = 0,
                    },
                },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
        ["chop_bcso"] = {
            id = "chop_bcso",
            name = "BCSO Chop",
            appearance = {
            model = "a_c_chop",
            components = {
                {
                    componentId = 3,
                    drawableId = 1,
                    textureId = 2,
                    paletteId = 0,
                },
            },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
      ["chop_troopers"] = {
        id = "chop_troopers",
        name = "Troopers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_doc"] = {
        id = "chop_doc",
        name = "DOC Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_rangers"] = {
        id = "chop_rangers",
        name = "Rangers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_therapy"] = {
        id = "chop_therapy",
        name = "Therapy Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_lspd"] = {
        id = "husky_lspd",
        name = "lspd Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_bcso"] = {
        id = "husky_bcso",
        name = "BCSO Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_troopers"] = {
        id = "husky_troopers",
        name = "Troopers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_doc"] = {
        id = "husky_doc",
        name = "DOC Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_rangers"] = {
        id = "husky_rangers",
        name = "Rangers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_therapy"] = {
        id = "husky_therapy",
        name = "Therapy Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_lspd"] = {
        id = "retriever_lspd",
        name = "lspd Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_bcso"] = {
        id = "retriever_bcso",
        name = "BCSO Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_troopers"] = {
        id = "retriever_troopers",
        name = "Troopers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_doc"] = {
        id = "retriever_doc",
        name = "DOC Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_rangers"] = {
        id = "retriever_rangers",
        name = "Rangers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_therapy"] = {
        id = "retriever_therapy",
        name = "Therapy Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_lspd"] = {
        id = "shepherd_lspd",
        name = "lspd Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_bcso"] = {
        id = "shepherd_bcso",
        name = "BCSO Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_troopers"] = {
        id = "shepherd_troopers",
        name = "Troopers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_doc"] = {
        id = "shepherd_doc",
        name = "DOC Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_rangers"] = {
        id = "shepherd_rangers",
        name = "Rangers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_therapy"] = {
        id = "shepherd_therapy",
        name = "Therapy Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_lspd"] = {
        id = "pit_lspd",
        name = "lspd Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_bcso"] = {
        id = "pit_bcso",
        name = "BCSO Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_troopers"] = {
        id = "pit_troopers",
        name = "Troopers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_doc"] = {
        id = "pit_doc",
        name = "DOC Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_rangers"] = {
        id = "pit_rangers",
        name = "Rangers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_therapy"] = {
        id = "pit_therapy",
        name = "Therapy Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["panther"] = {
        id = "panther",
        name = "Panther",
        appearance = {
          model = "a_c_panther",
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["coyote"] = {
        id = "coyote",
        name = "Coyote",
        appearance = {
          model = "a_c_coyote",
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["pit"] = {
        id = "pit",
        name = "pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["cat"] = {
        id = "cat",
        name = "cat",
        appearance = {
          model = "a_c_cat_01"
        },
        speedModifier = 2,
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pug"] = {
        id = "pug",
        name = "pug",
        appearance = {
          model = "a_c_pug"
        },
        maxHealth = 1000,
      },
      ["poodle"] = {
        id = "poodle",
        name = "poodle",
        appearance = {
          model = "a_c_poodle"
        },
        maxHealth = 1000,
      },
      ["westy"] = {
        id = "westy",
        name = "westy",
        appearance = {
          model = "a_c_westy"
        },
        maxHealth = 1000,
      },
      ["cow"] = {
        id = "cow",
        name = "cow",
        appearance = {
          model = "a_c_cow"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["hen"] = {
        id = "hen",
        name = "hen",
        appearance = {
          model = "a_c_hen"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["rabbit"] = {
        id = "rabbit",
        name = "rabbit",
        appearance = {
          model = "a_c_rabbit_01"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pig"] = {
        id = "pig",
        name = "pig",
        appearance = {
          model = "a_c_pig"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
    }
end

local function hasSpawnedK9Unit()
    local k9UnitSpawned = false
    for k, v in pairs(spawnedK9Units) do
        k9UnitSpawned = k9UnitSpawned or spawnedK9Units[k]
    end
    return k9UnitSpawned
end

local function modelHasSkill(id, skill)
    return animalSkillList[spawnedAnimalModels[id]][skill]
end

local function showCompanionOptions(companionId)
    local items = {}

    items[#items + 1] = {
        title = "Move",
        description = "Move to the next target",
        action = "fa-pets:companionAction",
        key = { companionId = companionId, action = "move" },
    }

    items[#items + 1] = {
        title = "Follow",
        description = "Make him follow you",
        action = "fa-pets:companionAction",
        key = { companionId = companionId, action = "follow" },
    }

    if modelHasSkill(companionId, "sit") then
        items[#items + 1] = {
            title = "Sit",
            description = "Make him sit!",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "sit" },
        }
    end

    if modelHasSkill(companionId, "laydown") then
        items[#items + 1] = {
            title = "Lay Down",
            description = "Rest a little.",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "laydown" },
        }
    end

    if modelHasSkill(companionId, "bark") then
        items[#items + 1] = {
            title = "Bark",
            description = "Woof woof",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "bark" },
        }
    end

    items[#items + 1] = {
        title = "Wander Around",
        description = "Keep him busy",
        action = "fa-pets:companionAction",
        key = { companionId = companionId, action = "wander" },
    }

    if spawnedK9Units[companionId] then
        items[#items + 1] = {
            title = "Track",
            description = "Start tracking for someone",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "track" },
        }
    end

    if modelHasSkill(companionId, "taunt") then
        items[#items + 1] = {
            title = "Tunt",
            description = "Show who is the boss",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "taunt" },
        }
    end

    if modelHasSkill(companionId, "stretch") then
        items[#items + 1] = {
            title = "Stretch",
            description = "Get ready to race",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "stretch" },
        }
    end

    if modelHasSkill(companionId, "beg") then
        items[#items + 1] = {
            title = "Beg",
            description = "Who is the good boy?",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "beg" },
        }
    end

    if modelHasSkill(companionId, "paw") then
        items[#items + 1] = {
            title = "Pata",
            description = "Da a pata",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "paw" },
        }
    end

    if modelHasSkill(companionId, "peck") then
        items[#items + 1] = {
            title = "Peck",
            description = "Look for things to chew",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "peck" },
        }
    end

    if modelHasSkill(companionId, "graze") then
        items[#items + 1] = {
            title = "Feed",
            description = "Nom nom nom",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "graze" },
        }
    end

    if modelHasSkill(companionId, "howl") then
        items[#items + 1] = {
            title = "Howl",
            description = "Awooooooooo",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "howl" },
        }
    end

    if modelHasSkill(companionId, "playdead") then
        items[#items + 1] = {
            title = "Dead Alive",
            description = "Play dead",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "playdead" },
        }
    end

    if modelHasSkill(companionId, "attack") then
        items[#items + 1] = {
            title = "Attack",
            description = "Attack the desired target",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "attack" },
        }
    end

    exports["fa-ui"]:showContextMenu(items)
end

local function hasAnimalWithSkill(skill)
    for k, v in pairs(spawnedAnimals) do
        if v and modelHasSkill(k, skill) then
            return true
        end
    end
    return false
end

local function showPlayerOptions(companionId, pedId)
    local items = {
        {
            title = "Move",
            description = "Move to that person",
            action = "fa-pets:companionPlayerAction",
            key = { companionId = companionId, action = "move", pedId = pedId },
        },
        {
            title = "Watch",
            description = "Keep your eyes open'",
            action = "fa-pets:companionAction",
            key = { companionId = companionId, action = "watch", pedId = pedId },
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Sniff",
            description = "Any smuggling?",
            action = "fa-pets:companionPlayerAction",
            key = { companionId = companionId, action = "sniff", pedId = pedId },
        }
    end

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Ignore",
            description = "Don't look for something in that person",
            action = "fa-pets:companionPlayerAction",
            key = { companionId = companionId, action = "untrack", pedId = pedId },
        }
    end

    if hasAnimalWithSkill("attack") then
        items[#items + 1] = {
            title = "Attack",
            description = "Attack!",
            action = "fa-pets:companionPlayerAction",
            key = { companionId = companionId, action = "attack", pedId = pedId },
        }
    end

    exports["fa-ui"]:showContextMenu(items)
end

local function showVehicleOptions(vehicleId)
    local items = {
        {
            title = "Move",
            description = "Go to the vehicle",
            action = "fa-pets:companionVehicleAction",
            key = { vehicleId = vehicleId, action = "move" },
        },
        {
            title = "Enter",
            description = "Enter the Vehicle",
            action = "fa-pets:companionVehicleAction",
            key = { vehicleId = vehicleId, action = "vehicle" },
        },
        {
            title = "Watch",
            description = "Keep your eyes open'",
            action = "fa-pets:companionVehicleAction",
            key = { vehicleId = vehicleId, action = "watch" },
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
            title = "Sniff",
            description = "Any smuggling?",
            action = "fa-pets:companionVehicleAction",
            key = { vehicleId = vehicleId, action = "sniff" },
        }
    end

    exports["fa-ui"]:showContextMenu(items)
end

function trackPlayers(companionId)
    ignoreServerIds[GetPlayerServerId(PlayerId())] = true

    local closestCoords = RPC.execute("fa-pets:getClosestPlayer", GetEntityCoords(PlayerPedId()), ignoreServerIds)
    if not closestCoords then
        exports["fa-companions"]:perform("sit", companionId or "")
        TriggerEvent("DoLongHudText", "Ele não parece estar interessado")
        exports["fa-companions"]:deselect()
        return
    end

    local coords = { x = closestCoords.coords.x, y = closestCoords.coords.y, z = closestCoords.coords.z, speed = 0.8 }
    exports["fa-companions"]:perform("move", companionId or "", coords)
    exports["fa-companions"]:deselect()
end

local function doSniffAction(pType, pCompanionId)
  exports["fa-companions"]:perform("move", pCompanionId)

  Wait(1000)

  local target = exports["fa-companions"]:getSelection()
  local hasContraband = false

  if pType == "ped" then
      hasContraband = RPC.execute("fa-pets:sniffTarget", pType, GetPlayerServerId(NetworkGetPlayerIndexFromPed(target.entityId)))
  elseif pType == "vehicle" then
      local vid = exports["fa-vehicles"]:GetVehicleIdentifier(target.entityId)
      local plate = exports["fa-vehicles"]:GetVehiclePlate(target.entityId)

      hasContraband = RPC.execute("fa-pets:sniffTarget", pType, (true and vid or plate))
  end

  exports["fa-companions"]:deselect()

  if hasContraband then
      TriggerEvent("DoLongHudText", "Your pet has found something!")
      exports["fa-companions"]:perform("bark", pCompanionId)
      Wait(1000)
      exports["fa-companions"]:perform("sit", pCompanionId)
  else
      TriggerEvent("DoLongHudText", "Your pet didn't find anything.")
  end
end

RegisterNetEvent("fa-pets:k9create")
AddEventHandler("fa-pets:k9create", function(pCid, pType, pDept, pName, pVariation)
    local typeConfig = k9types[tonumber(pType)] or k9types[1]
    local deptConfig = k9Depts[tonumber(pDept)] or k9Depts[1]

    TriggerEvent("player:receiveItem", "summonablepet", 1, false, {}, {
        Owner = pCid,
        Name = pName or "No Name",
        type = typeConfig.type,
        key = typeConfig.key .. "_" .. deptConfig.key,
        k9 = true,
        id = tostring(math.random(1000000, 9999999)),
        cVariation = pVariation and tonumber(pVariation) or -1,
        _image_url = typeConfig.image,
        _hideKeys = { "_image_url", "type", "key", "id", "k9", "cVariation" },
    })
end)

RegisterNetEvent("fa-pets:petCreate")
AddEventHandler("fa-pets:petCreate", function(pCid, pType, pName, pVariation)
    local info = petInfo[pType]
    if not info then return end

    TriggerEvent("player:receiveItem", "summonablepet", 1, false, {}, {
        Owner = pCid,
        Name = pName or "No Name",
        type = info.type,
        key = info.key,
        k9 = false,
        id = tostring(math.random(1000000, 9999999)),
        cVariation = pVariation and tonumber(pVariation) or -1,
        _image_url = info.image,
        _hideKeys = { "_image_url", "type", "key", "id", "k9", "cVariation" },
    })
end)

AddEventHandler("fa-inventory:itemUsed", function(item, info)
    if item ~= "summonablepet" then return end

    local info = json.decode(info)
    local characterId = exports["isPed"]:isPed("cid")

    if tonumber(info.Owner) ~= tonumber(characterId) then
        TriggerEvent("DoLongHudText", "They don't recognize you.", 2)
        return
    end

    local id = info.id

    if spawnedAnimals[id] then
        spawnedAnimals[id] = false
        spawnedK9Units[id] = false
        spawnedAnimalsCount = spawnedAnimalsCount - 1
        exports["fa-companions"]:dismiss(id)
        exports["fa-companions"]:deselect()
        return
    end

    spawnedAnimals[id] = true
    spawnedAnimalsCount = spawnedAnimalsCount + 1
    spawnedK9Units[id] = info.k9

    local animal = supportedAnimals()[info.key]

    if  info.cVariation ~= -1 and animal.appearance and animal.appearance.components and animal.appearance.components[2] then
        animal.appearance.components[2].textureId = info.cVariation
    end

    animal.id = id
    spawnedAnimalModels[id] = animal.appearance.model

    exports["fa-companions"]:summon({ animal }, function()
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if not veh or veh == 0 then
            exports["fa-companions"]:perform("follow", animal.id)
        end
    end)
end)

RegisterUICallback("fa-pets:companionAction", function(data, cb)
  if data.key.action == "move" or data.key.action == "attack" then
    lastCompanionId = data.key.companionId
    lastCompanionAction = data.key.action
    return
  end

  if data.key.action == "track" then
      trackPlayers(data.key.companionId)
      return
  end

  exports["fa-companions"]:perform(data.key.action, data.key.companionId)
  exports["fa-companions"]:deselect()

  cb({ data = {}, meta = { ok = true, message = "" } })
  exports["fa-ui"]:closeApplication("context")
end)

RegisterUICallback("fa-pets:companionPlayerAction", function(data, cb)
  if data.key.action == "sniff" then
    doSniffAction("ped", data.key.companionId)
    return
  end

  if data.key.action == "untrack" then
      local sid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.key.pedId))
      ignoreServerIds[sid] = not ignoreServerIds[sid]
      exports["fa-companions"]:deselect()
      return
  end

  if data.key.companionId == nil or data.key.companionId == "" then
      for k, v in pairs(spawnedAnimals) do
          if spawnedAnimals[k] and modelHasSkill(k, data.key.action) then
              exports["fa-companions"]:perform(data.key.action, k)
          end
      end
  else
      exports["fa-companions"]:perform(data.key.action, data.key.companionId)
  end

  exports["fa-companions"]:deselect()

  cb({ data = {}, meta = { ok = true, message = "" } })
  exports["fa-ui"]:closeApplication("context")
end)

RegisterUICallback("fa-pets:companionVehicleAction", function(data, cb)
  if data.key.action == "sniff" then
    doSniffAction("vehicle", data.key.companionId)
    return
  end

  exports["fa-companions"]:perform(data.key.action)
  exports["fa-companions"]:deselect()

  cb({ data = {}, meta = { ok = true, message = "" } })
  exports["fa-ui"]:closeApplication("context")
end)  

AddEventHandler("fa-companions:pedSelected", function(pedId, companionId)
    if lastActionPressTime + 250 > GetGameTimer() then
        exports["fa-companions"]:deselect()
        return
    end

    if companionId then
        showCompanionOptions(companionId)
        return
    end

    if lastCompanionId then
        exports["fa-companions"]:perform(lastCompanionAction, lastCompanionId)
        exports["fa-companions"]:deselect()
        lastCompanionId = nil
        return
    end

    if attackNextTarget then
        exports["fa-companions"]:perform("attack")
        exports["fa-companions"]:deselect()
        attackNextTarget = false
        return
    end

    if IsPedAPlayer(pedId) then
        showPlayerOptions(companionId, pedId)
    end
end)

AddEventHandler("fa-companions:vehicleSelected", function(vehicleId)
    if lastActionPressTime + 400 > GetGameTimer() then
        exports["fa-companions"]:deselect()
        return
    end

    showVehicleOptions(vehicleId)
end)

AddEventHandler("fa-companions:groundSelected", function()
    if lastActionPressTime + 400 > GetGameTimer() then
      exports["fa-companions"]:deselect()
      return
    end
    exports["fa-companions"]:perform("move", lastCompanionId)
    lastCompanionId = nil
end)

AddEventHandler("fa-companions:tooBigForVehicle", function()
    TriggerEvent("DoLongHudText", "Too big for this vehicle!")
end)

Citizen.CreateThread(function()
    local pointActionEnabled = true

    RegisterCommand("+petAction", function()
        if not pointActionEnabled then return end
        if spawnedAnimalsCount <= 0 then return end
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if not veh or veh == 0 then
            lastActionPressTime = GetGameTimer()
            exports["fa-companions"]:startSelecting()
        end
    end, false)

    RegisterCommand("-petAction", function()
        exports["fa-companions"]:stopSelecting()
        if lastActionPressTime + 400 > GetGameTimer() then
            exports["fa-companions"]:deselect()
            return
        end
    end, false)

    RegisterCommand("+petActionToggle", function()
        pointActionEnabled = not pointActionEnabled
    end, false)
    RegisterCommand("-petActionToggle", function() end, false)

    RegisterCommand("+petActionFollow", function()
        exports["fa-companions"]:perform("follow")
    end, false)
    RegisterCommand("-petActionFollow", function() end, false)

    RegisterCommand("+petActionVehicle", function()
        exports["fa-companions"]:perform("vehicle")
    end, false)
    RegisterCommand("-petActionVehicle", function() end, false)

    RegisterCommand("+petActionAttack", function()
        attackNextTarget = true
        lastCompanionId = nil
    end, false)
    RegisterCommand("-petActionAttack", function() end, false)

    RegisterCommand("+petActionTrack", function()
        trackPlayers()
    end, false)
    RegisterCommand("-petActionTrack", function() end, false)

    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Action Pet", "+petAction", "-petAction", "")
    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Action Enable / Disable", "+petActionToggle", "-petActionToggle", "")
    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Follow Self", "+petActionFollow", "-petActionFollow", "")
    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Get in Vehicle", "+petActionVehicle", "-petActionVehicle", "")
    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Attack Next Target", "+petActionAttack", "-petActionAttack", "")
    exports["fa-keybinds"]:registerKeyMapping("", "Pets", "Track Target", "+petActionTrack", "-petActionTrack", "")
end)