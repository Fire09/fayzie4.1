local blips = {
    {id = "casino1", name = "Casino Resort", color = 5, sprite = 207, x = 925.329, y = 46.152, z = 80.908 },
    {id = "hosp3", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = -449.67, y= -340.83, z= 34.50},
    {id = "recycling", name = "Recycling plant", color = 2, sprite = 467, x = 892.37, y=-2171.84, z=32.29},
    {id = "bar1", name = "Bahama Mamas", sprite = 93, x = -1388.53430175781, y=-586.615295410156, z=29.2186660766602},
    {id = "ttruckjob", name = "Impound Lot", color = 17, sprite = 68, x = -189.88, y = -1163.99, z = 23.68},
    {id = "lsbb", name = "Los Santos Billboards", color = 32, sprite = 475, x = -915.05, y = -452.75, z = 39.38},
    {id = "police-station-1", name = "Police Station 1", scale = 0.8, color = 3, sprite = 60, x=425.130, y=-979.558, z=30.711},
    {id = "vespucci-pd", name = "Vespucci PD", scale = 0.8, color = 3, sprite = 60, x=-1097.14, y=-829.4, z=37.68},
    {id = "fishingsales", name = "Fish Sales", scale = 0.7, color = 3, sprite = 304, x=-1507.86, y=1503.53, z=114.29},
    {id = "bobcatsecurity", name = "Bobcat Security", scale = 0.7, color = 2, sprite = 498, x=880.8951, y=-2258.308, z=32.53486},
    {id = "airshop", name = "Aircraft Sales & Rentals", scale = 0.7, color = 2, sprite = 307, x=-1621.42, y=-3152.99, z=14.0},
    {id = "boatshop", name = "Boat Sales", scale = 0.7, color = 2, sprite = 427, x=-876.42, y=-1324.7, z=1.61},
    {id = "veh_rentals", name = "Vespucci Vehicle Rentals", scale = 0.5, color = 2, sprite = 326, x=108.77, y=-1088.88, z=29.3},
    {id = "bennys", name = "Benny's Repair", scale = 0.5, color = 2, sprite = 446, x=-33.5335, y=-1053.1345, z=28.39650},
    {id = "uwucafe", name = "UwU Cafe", color = 61, sprite = 621, x=-579.83, y=-1065.2, z=22.35},
    {id = "courthouse", name = "Los Santos City Hall", scale = 0.7, color = 5, sprite = 419, x=-549.5550079345, y=-195.0076904298, z=38.402359008789315},
    {id = "galleryvlc", name = "Gallery", scale = 0.6, color = 18, sprite = 617, x=-424.47, y=22.29, z=46.27},
    {id = "PDM", name = "Premium Deluxe Motorsports", scale = 0.7, color = 7, sprite = 326, x=-33.737, y=-1102.322, z= 26.422},
    {id = "Tuner", name = "Tuner Shop", scale = 0.7, color = 7, sprite = 326, x=155.79, y = -3031.23, z = 7.04},
    {id = 'winery', name = 'The Winery', scale = 0.6, color = 6, sprite = 478, x = -1889.86, y = 2036.54, z = 140.83},
    {id = 'HarmonyRepairs', name = 'Harmony Repairs', scale = 0.7, color = 12, sprite = 478, x = 1183.18, y = 2651.66, z = 37.81},
    {id = 'HayesAutos', name = 'Hayes Autos Repairs', scale = 0.7, color = 12, sprite = 478, x = -1416.86, y = -447.97, z = 35.91},
    {id = "burgies", name = "Burger Shot", scale = 0.7, color = 8, sprite = 106, x = -1199.61, y = -899.79, z = 14.0},
    {id = "roosters", name = "Roosters Rest", scale = 0.6, color = 8, sprite = 93, x = -163.40, y = 297.81, z = 98.50},   
    {id = "apartments", name = "Apartments", scale = 0.7, color = 0, sprite = 475, x = -267.9704284668, y = -958.87335205078, z = 31.230913162231},
    {id = "jacksons_autos", name = "Jacksons Autos", scale = 0.7, color = 20, sprite = 227, x = -783.6882, y = -1024.03, z = 13.532898},

    {id = "magamall", name = "Mega Mall", scale = 0.7, color = 50, sprite = 176, x = -551.9854, y = -600.9188, z = 34.681777}, 


}

AddEventHandler("fa-base:playerSessionStarted", function()
    Citizen.CreateThread(function()
        for k,v in ipairs(blips) do
            DPX.BlipManager:CreateBlip(v.id, v)
        end
    end)
end)

AddEventHandler('fa-island:hideBlips', function(pState)
    for k,v in ipairs(blips) do
        DPX.BlipManager:HideBlip(v.id, pState)
    end
end)
