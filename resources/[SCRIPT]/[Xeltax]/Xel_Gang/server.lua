RegisterNetEvent('Xel_Gang:RegisterSociety')
AddEventHandler('Xel_Gang:RegisterSociety', function(job2)
	TriggerEvent('esx_society:registerSociety', job2, job2, 'society_'..job2, 'society_'..job2, 'society_'..job2, {type = 'public'})
end)


RegisterNetEvent('Xel_Gang:RegisterStashes')
AddEventHandler('Xel_Gang:RegisterStashes', function(job2)
	local stash = {
		id = 'society_'..job2,
		label = 'Coffre '..job2,
		slots = 50,
		weight = 100000
	}

	if resourceName == 'Xel_Gang' or resourceName == GetCurrentResourceName() then
		print(job2.." stash created successfully")
		exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
		print("Stash registered successfully")
	end
end)

ESX.RegisterServerCallback('Xel_Gang:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job2 = xPlayer.getJob2(),
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    else
        cb(nil)
    end
end)

RegisterNetEvent('Xel_Gang:MenotteServer')
AddEventHandler('Xel_Gang:MenotteServer', function(target, job2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name == job2 then
		TriggerClientEvent('Xel_Gang:Menotte', target)
	else
		print(('Xel_Gang: %s Un joueur à essayé de menotter alors qu\'il n\'est pas dans le gang '.. job2 ..' possible cheater'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('Xel_Gang:EscorterServer')
AddEventHandler('Xel_Gang:EscorterServer', function(target, job2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name == job2 then
        TriggerClientEvent('Xel_Gang:Escorter', target, source)
	else
		print(('Xel_Gang: %s Un joueur à essayé d\'escorter alors qu\'il n\'est pas dans le gang '.. job2 ..' possible cheater'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('Xel_Gang:MettreDansVehiculeServer')
AddEventHandler('Xel_Gang:MettreDansVehiculeServer', function(target, job2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name == job2 then
		TriggerClientEvent('Xel_Gang:MettreDansVehicule', target)
	else
		print(('Xel_Gang: %s Un joueur à essayé de mettre un autre dans un véhicule alors qu\'il n\'est pas dans le gang'.. job2 ..' possible cheater'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('Xel_Gang:SortirVehiculeServer')
AddEventHandler('Xel_Gang:SortirVehiculeServer', function(target, job2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name == job2 then
		TriggerClientEvent('Xel_Gang:SortirVehicule', target)
	else
        print(('Xel_Gang: %s Un joueur à essayé de sortir un autre d\'un véhicule alors qu\'il n\'est pas dans le gang'.. job2 ..' possible cheater'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('Xel_Gang:PosHotageServer')
AddEventHandler('Xel_Gang:PosHotageServer', function(target, job2)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name == job2 then
		TriggerClientEvent('Xel_Gang:PosHotage', target)
	else
        print(('Xel_Gang: %s Un joueur à essayé de mettre un autre en position hotage alors qu\'il n\'est pas dans le gang'.. job2 ..' possible cheater'):format(xPlayer.identifier))
	end
end)

-- Gestion des coffres

ESX.RegisterServerCallback('Xel_Gang:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local money = xPlayer.getAccount('black_money').money

	cb({items = items, money = money})
end)

RegisterNetEvent('Xel_Gang:putStockItems')
AddEventHandler('Xel_Gang:putStockItems', function(itemName, count, job2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job2, function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if itemName == 'black_money' then
			xPlayer.removeAccountMoney('black_money', count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification("Vous avez ~b~déposer~s~ "..count.." $~s~ ~r~ d'argent sale")
		elseif sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification("Vous avez ~b~déposer~s~ x "..count.."~s~ ~r~"..inventoryItem.label)
		else
			xPlayer.showNotification("Quantité Invalide")
		end
	end)
end)

ESX.RegisterServerCallback('Xel_Gang:getStockItems', function(source, cb, job2)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job2, function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('Xel_Gang:getStockItem')
AddEventHandler('Xel_Gang:getStockItem', function(itemName, count, job2)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ballas', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			-- if xPlayer.canCarryItem(itemName, count) then
			-- 	inventory.removeItem(itemName, count)
			-- 	xPlayer.addInventoryItem(itemName, count)
			-- 	xPlayer.showNotification("Vous avez ~b~récupéré x "..count.." ~r~"..inventoryItem.label)
			-- else
			-- 	xPlayer.showNotification("Quantité trop importante pour votre inventaire")
			-- end
			if itemName == 'black_money' then
				inventory.removeItem(itemName, count)
				xPlayer.addAccountMoney('black_money', count)
				xPlayer.showNotification("Vous avez ~b~retirer~s~ "..count.." $~s~ ~r~ d'argent sale")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification("Vous avez ~b~récupéré~s~ x "..count.." ~r~"..inventoryItem.label)
			end
		else
			xPlayer.showNotification("Quantité Invalide")
		end
	end)
end)

RegisterNetEvent('Xel_Gang:SpawnPersonalVehicle')
AddEventHandler('Xel_Gang:SpawnPersonalVehicle', function(model, PosSpawnCar, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('Xel_Gang:SpawnVehicle', source, job2, model, PosSpawnCar)
end)

ESX.RegisterServerCallback('Xel_Gang:getPersonnalVehicle', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type', { -- job = NULL
			['@owner'] = xPlayer.identifier,
			['@type'] = 'car',
		}, function(data)
			for k,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
			end
			cb(ownedCars)
		end)
end)

RegisterNetEvent('Xel_Gang:UpdateVehicle')
AddEventHandler('Xel_Gang:UpdateVehicle', function(plate, stored)
	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
		['@stored'] = stored,
		['@plate'] = plate
	})
end)