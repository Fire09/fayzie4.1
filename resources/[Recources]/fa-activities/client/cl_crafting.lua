RegisterNetEvent("fa-crafting:publicCrafting")
AddEventHandler("fa-crafting:publicCrafting", function()
    TriggerEvent("server-inventory-open", "29999999", "Craft")
end)

exports["fa-polytarget"]:AddBoxZone("public_crafting",  vector3(857.34, -1038.44, 33.07), 2.8, 0.6, {
    heading=359,
    minZ=30.87,
    maxZ=34.47
})

exports["fa-interact"]:AddPeekEntryByPolyTarget("public_crafting", {{
    event = "fa-crafting:publicCrafting",
    id = "public_crafting",
    icon = "circle",
    label = "What dis?",
    parameters = {},
}}, {
    distance = { radius = 3.0 },
});
