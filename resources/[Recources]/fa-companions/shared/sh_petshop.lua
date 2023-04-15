PetshopConfig = {
    {
        ["Type"] = "k9",
        ["Label"] = "K9",
        ["Job"] = "police",
        ["Department"] = 1,

        ["Pets"] = {
            { name = "Husky", model = 2, price = 100, variants = 2 },
            { name = "Retriever", model = 3, price = 100, variants = 3 },
            { name = "Shepherd", model = 4, price = 100, variants = 2 },
            { name = "Pitbull", model = 5, price = 100, variants = 2 },
        },

        ["NPC"] = {
            id = "police_petshop",
            name = "Police Petshop",
            pedType = 4,
            model = "a_c_shepherd_np",
            networked = false,
            distance = 50.0,
            position = {
                coords = vector3(469.86, -980.98, 26.28 - 1.0),
                heading = 175,
                random = false,
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ["isNPC"] = true,
                ["isPetshopSeller"] = true,
            },
            scenario = "WORLD_DOG_SITTING_SHEPHERD",
        },
    }
}