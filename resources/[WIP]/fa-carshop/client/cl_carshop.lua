listening = false
currentVehicle = nil
local spawnedvehicles = {}

local function getCurrentVehicle(pEntity, pShop)
	local vehiclePos = GetEntityCoords(pEntity)
	local index = false
	for i, v in ipairs(config[pShop].carSpawns) do
		local coords = vector3(v["coords"][1], v["coords"][2], v["coords"][3])
		if #(vehiclePos - coords) < 1.0 then
			index = i
			break
		end
	end

	currentVehicle = index
end

function getTestDriveLocation(shop)
	return config[shop].testDriveSpawnPoint
end

exports("getTestDriveLocation", getTestDriveLocation)

AddEventHandler("fa-carshop:check", function(pParams, pEntity, pContext)
	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return print("fa-carshop | no current vehicle has been found") end

	local info = RPC.execute("fa-carshop:getInformations", currentLocation, currentVehicle)
	if not info then return end

	local baseprice = info.price
	local commissionprice = math.floor(baseprice * info.commission / 100)
	local tax = RPC.execute("PriceWithTaxString", baseprice, "Vehicle Sales")

	local finalprice = math.floor(baseprice + commissionprice + tax.total)

	local infos = {
		{ title = "Vehicle: " .. GetLabelText(GetDisplayNameFromVehicleModel(info.model)), icon = "car" },
		{ title = "Tier: " .. GetVehicleClassFromName(pEntity) , icon = "registered" },
		{ title = "Price: $" .. tax.text ..".", icon = "money-bill" },
		{ title = "Inventory: " .. info.stock .. " in Stock.", icon = "warehouse" },
	}

	local cid = exports["isPed"]:isPed("cid")
	local a, b, c, d = RPC.execute("fa-business:businessGetEmploymentInformationBusinessID", cid, currentLocation)
	if d > 0 then
		table.insert(infos, { title = "Information:", description = "", icon = "info"})
		table.insert(infos, { title = "Commission: ".. "%" .. info.commission, icon = "percentage"} )
		table.insert(infos, { title = "Base Price: $" .. baseprice, icon = "money-bill"} )
		table.insert(infos, { title = "Commission Price: $" .. commissionprice, icon = "coins"} )
		table.insert(infos, { title = "Taxas: $" .. tax.text .. ".", icon = "file-invoice-dollar"} )
	end

	local data = {}

    for i, v in ipairs(infos) do
		table.insert(data, {
            title = v.title,
			icon = v.icon,
        })
    end

    exports["fa-ui"]:showContextMenu(data)
end)

AddEventHandler("fa-carshop:change", function(pParams, pEntity, pContext)
	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return end
	
	openShowroom(currentLocation, true)
end)

RegisterNetEvent("fa-carshop:updateDisplay")
AddEventHandler("fa-carshop:updateDisplay", function(shop)
	if "tuner" or "pdm" == shop then
		spawn(shop)
	end
end)

AddEventHandler("fa-carshop:commission", function(pParams, pEntity, pContext)
	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return end

	exports['fa-ui']:openApplication('textbox', {
		callbackUrl = 'fa-carshop:commission',
		key = 1,
		items = {
		  {
			icon = "percentage",
			label = "Commission",
			name = "commission",
		  }
		},
		show = true,
	  })
end)

RegisterNUICallback("fa-carshop:commission", function(data, cb)
	cb({ data = {}, meta = { ok = true, message = "done" } })

	print(json.encode(data))
	local comission = tonumber(input["commission"])
	if not comission then
		TriggerEvent("DoLongHudText", "Commission needs to be 1-30", 2)
		return
	end

	if comission < 1 or comission > 30 then
		TriggerEvent("DoLongHudText", "Commission needs to be 1-30", 2)
		return
	end

	TriggerServerEvent("fa-carshop:commission", currentLocation, currentVehicle, comission)
end)

AddEventHandler("fa-carshop:testdrive", function(pParams, pEntity, pContext)
	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return end

	local model = pContext.model
	local pos = getTestDriveLocation(currentLocation)

	-- local vehicle = exports["fa-vehicles"]:spawnVehicle(model, pos, false, "TD" .. shop, 100, false, false, false, false, false, true)

	exports["fa-flags"]:SetVehicleFlag(vehicle, "isTestDriveVehicle", true)
end)

AddEventHandler("fa-carshop:testdriveReturn", function(pParams, pEntity, pContext)
	Sync.DeleteVehicle(pEntity)
    Sync.DeleteEntity(pEntity)
end)

AddEventHandler("fa-carshop:sell", function(pParams, pEntity, pContext)
	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return end

	-- local plate = exports["fa-vehicles"]:GetVehiclePlate(pEntity)

	TriggerServerEvent("fa-carshop:sell", plate, currentLocation, currentVehicle)
end)

AddEventHandler("fa-carshop:buy", function(pParams, pEntity, pContext)

	getCurrentVehicle(pEntity, currentLocation)
	if not currentVehicle then return end

	local info = RPC.execute("fa-carshop:getInformations", currentLocation, currentVehicle)
	if not info then return end

	local baseprice = info.price
	local commissionprice = math.floor(baseprice * info.commission / 100)
	local tax = RPC.execute("PriceWithTaxString", baseprice, "Vehicle Sales")
	local financing = math.floor(baseprice / 10)
	local finalprice = math.floor(baseprice + commissionprice + tax.total)
	local downpayment = math.floor(commissionprice + tax.tax + financing)

	local vehicle = GetLabelText(GetDisplayNameFromVehicleModel(info.model))
	if vehicle == "NULL" then vehicle = GetDisplayNameFromVehicleModel(info.model) end


	local document = {
        headerTitle = "Vehicle Purchase",
        headerSubtitle = "Vehicle financing agreement.",
        elements = {
            { label = "SELLER", type = "input", value = info.seller.name, can_be_emtpy = false, can_be_edited = false },
			{ label = "SHOP", type = "input", value = "groupname", can_be_emtpy = false, can_be_edited = false },
			{ label = "VEHICLE", type = "input", value = vehicle, can_be_emtpy = false, can_be_edited = false },
			{ label = "TOTAL PRICE", type = "input", value = "$" .. finalprice, can_be_emtpy = false, can_be_edited = false },
			{ label = "INITIAL PAYMENT", type = "input", value = "$" .. downpayment .. " Incl. " .. tax.porcentage .. "% tax", can_be_emtpy = false, can_be_edited = false },
			{ label = "FINANCING", type = "input", value = "10x $" .. financing, can_be_emtpy = false, can_be_edited = false },
			{ label = "TERMS", type = "textarea", value = "By signing this, you must be sure that in case you do not pay " .. groupname .. " will confiscate your vehicle.", can_be_emtpy = false, can_be_edited = false },
        },
		group = "pdm",
		callback = {
			event = "fa-carshop:buycallback",
			params = {
				shop = currentLocation,
				model = info.model,
				name = vehicle,
				seller = info.seller.sid,
				sellername = info.seller.name,
				downpayment = downpayment,
				commission = commissionprice,
				finalprice = finalprice,
				tax = tax.tax,
				financing = financing,
				buyer = exports["isPed"]:isPed("fullname")
			},
		},
    }

	TriggerEvent("fa-documents:CreateNewForm", document)
end)

AddEventHandler("fa-carshop:buycallback", function(pParams)
	TriggerServerEvent("fa-carshop:buy", pParams)
end)

