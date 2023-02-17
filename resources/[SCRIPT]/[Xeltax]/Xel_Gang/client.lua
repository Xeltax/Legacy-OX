local isHandcuffed = false
local dragStatus, dragSource = false
local job2 = ''
local hotage = false
local personnal_plate = ''

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	TriggerServerEvent('Xel_Gang:RegisterSociety', ESX.PlayerData.job2.name)
	TriggerServerEvent('Xel_Gang:RegisterStashes', ESX.PlayerData.job2.name)
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	TriggerEvent('Xel_Gang:Demenotter')
	TriggerServerEvent('Xel_Gang:RegisterSociety', job2)
	TriggerServerEvent('Xel_Gang:RegisterStashes', job2)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('Xel_Gang:Demenotter')
	end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 750
        local ped = PlayerPedId()
        for k, v in pairs(Config.Gang) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == k then
				job2 = k
                local dist = #(GetEntityCoords(ped) - v.PosCoffre)
                local dist2 = #(GetEntityCoords(ped) - v.PosGarage)
                local dist3 = #(GetEntityCoords(ped) - v.PosBoss)

				if dist <= 10 then
					wait = 0
					DrawMarker(20, v.PosCoffre, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.colorMarker.r, v.colorMarker.g, v.colorMarker.b, v.colorMarker.a, false, true, 2, false, false, false, false)
					if dist <= 1.5 then
						wait = 0
						ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
						if IsControlJustPressed(0, 38) then
							--OpenCoffre(job2)
							exports.ox_inventory:openInventory('stash', {id = 'society_'..job2})
						end
					end
				end

				if dist2 <= 10 then
					wait = 0
					DrawMarker(36, v.PosGarage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, v.colorMarker.r, v.colorMarker.g, v.colorMarker.b, v.colorMarker.a, false, true, 2, false, false, false, false)
					if dist2 <= 1.5 then
						ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
						if IsControlJustPressed(0, 38) then
							OpenGarage(job2, v.VehicleGang, v.PosSpawnCar)
						end
					end
				end

				if dist3 <= 10 then
					if ESX.PlayerData.job2.grade_name == 'boss' then
						wait = 0
						DrawMarker(22, v.PosBoss, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.colorMarker.r, v.colorMarker.g, v.colorMarker.b, v.colorMarker.a, false, true, 2, false, false, false, false)
						if dist3 <= 1.5 then
							ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la gestion du gang")
							if IsControlJustPressed(0, 38) then
								OpenBoss(job2)
							end
						end
					end
				end
            end
        end
        Citizen.Wait(wait)
    end
end)

RegisterCommand('gangMenu', function()
	if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == job2 then
		MenuF6(job2)
	end
end, false)

RegisterKeyMapping('gangMenu', 'Ouvrir le Menu Gang', 'keyboard', 'F6')

function MenuF6(job2)
    local F6Gang = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Action IllÉgal", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);
    local Fouille = RageUI.CreateSubMenu(F6Gang, "Poches", " ")

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    ESX.TriggerServerCallback('Xel_Gang:getOtherPlayerData', function(data)
        function RageUI.PoolMenus:Example()
            F6Gang:IsVisible(function(Items)
                -- Item
                Items:AddSeparator("~r~↓~s~    Actions sur civils    ~r~↓~s~")

                Items:AddButton("~r~→~s~ Fouiller", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)

                end, Fouille)

                Items:AddButton("~r~→~s~ Mettre/Enlever les colliers de serrage", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance < 3.0 then
                            TriggerServerEvent('Xel_Gang:MenotteServer', GetPlayerServerId(closestPlayer), job2)
                        end
                    end
                end)

                Items:AddButton("~r~→~s~ Escorter", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance < 3.0 then
                            TriggerServerEvent('Xel_Gang:EscorterServer', GetPlayerServerId(closestPlayer), job2)
                        end
                    end
                end)

                Items:AddButton("~r~→~s~ Mettre dans le véhicule", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance < 3.0 then
                            TriggerServerEvent('Xel_Gang:MettreDansVehiculeServer', GetPlayerServerId(closestPlayer), job2)
                        end
                    end
                end)

                Items:AddButton("~r~→~s~ Sortir du véhicule", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance < 3.0 then
                            TriggerServerEvent('Xel_Gang:SortirVehiculeServer', GetPlayerServerId(closestPlayer), job2)
                        end
                    end
                end)

                Items:AddButton("~r~→~s~ Position d'otage", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						TriggerServerEvent('Xel_Gang:PosHotageServer', GetPlayerServerId(closestPlayer), job2)
                    end
                end)

            end, function(Panels)
            end)

            Fouille:IsVisible(function(Items)
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    Items:AddButton("~r~→~s~ Aucun joueur proche", nil, { IsDisabled = true , RightLabel = ""}, function(onSelected)
                    end)
                else

                    Items:AddSeparator("~r~↓~s~    Portefeuille de la personne    ~r~↓~s~")
                    
                    Items:AddSeparator("Argent sale : ~r~" .. ESX.Math.GroupDigits(data.accounts[1].money) .. ' ~s~$')
    
                    Items:AddSeparator("~r~↓~s~    Armes de la personne    ~r~↓~s~")
    
                    for i=1, #data.weapons, 1 do
                        Items:AddButton("Arme : ~o~" ..  ESX.GetWeaponLabel(data.weapons[i].name), nil, { IsDisabled = false , RightLabel = "Munitions : ~o~" .. data.weapons[i].ammo}, function(onSelected)
                            if (onSelected) then
                            end
                        end)
                    end
    
                    Items:AddSeparator("~r~↓~s~    Poches de la personne    ~r~↓~s~")
    
                    for i=1, #data.inventory, 1 do
                        if data.inventory[i].count > 0 then
                            -- Items:AddSeparator("Objet : ~o~" ..  data.inventory[i].label .. " x" .. data.inventory[i].count)
                            Items:AddButton("Objet : ~o~" ..  data.inventory[i].label, nil, { IsDisabled = false , RightLabel = "x ~o~" .. data.inventory[i].count}, function(onSelected)
                                if (onSelected) then
                                end
                            end)
                        end
                    end
                end

                -- Items
            end, function()
                -- Panels
            end)

        end

    end, GetPlayerServerId(closestPlayer))
	RageUI.Visible(F6Gang, not RageUI.Visible(F6Gang))
end

RegisterNetEvent('Xel_Gang:Menotte')
AddEventHandler('Xel_Gang:Menotte', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)
	else
		dragStatus = false
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('Xel_Gang:Demenotter')
AddEventHandler('Xel_Gang:Demenotter', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('Xel_Gang:Escorter')
AddEventHandler('Xel_Gang:Escorter', function(copId)
	if isHandcuffed and dragStatus == false then
		dragStatus = true
		dragSource = copId
	else
		dragStatus = false
		dragSource = 0
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragSource))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('Xel_Gang:MettreDansVehicule')
AddEventHandler('Xel_Gang:MettreDansVehicule', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local vehicle, distance = ESX.Game.GetClosestVehicle()

		if vehicle and distance < 5 then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus = false
			end
		end
	end
end)

RegisterNetEvent('Xel_Gang:SortirVehicule')
AddEventHandler('Xel_Gang:SortirVehicule', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

RegisterNetEvent('Xel_Gang:PosHotage')
AddEventHandler('Xel_Gang:PosHotage', function()
	local playerPed = PlayerPedId()

	if hotage == false then
		if IsEntityPlayingAnim(playerPed, 'random@arrests@busted', 'idle_c', 3) ~= 1 then
			ESX.Streaming.RequestAnimDict('random@arrests@busted', function()
				TaskPlayAnim(playerPed, 'random@arrests@busted', 'idle_c', 8.0, -8.0, -1, 1, 0.0, false, false, false)
			end)
		end
		hotage = true
	else
		ClearPedTasksImmediately(playerPed)
		hotage = false
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		local wait = 750
		Citizen.Wait(wait)
		if isHandcuffed then
			wait = 0
			local playerPed = PlayerPedId()

			if isHandcuffed then
				DisableControlAction(0, 1, true) -- Disable pan
				DisableControlAction(0, 2, true) -- Disable tilt
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Aim
				DisableControlAction(0, 263, true) -- Melee Attack 1
				DisableControlAction(0, 32, true) -- W
				DisableControlAction(0, 34, true) -- A
				DisableControlAction(0, 31, true) -- S
				DisableControlAction(0, 30, true) -- D

				DisableControlAction(0, 45, true) -- Reload
				DisableControlAction(0, 22, true) -- Jump
				DisableControlAction(0, 44, true) -- Cover
				DisableControlAction(0, 37, true) -- Select Weapon
				DisableControlAction(0, 23, true) -- Also 'enter'?

				DisableControlAction(0, 288,  true) -- Disable phone
				DisableControlAction(0, 289, true) -- Inventory
				DisableControlAction(0, 170, true) -- Animations
				DisableControlAction(0, 167, true) -- Job

				DisableControlAction(0, 0, true) -- Disable changing view
				DisableControlAction(0, 26, true) -- Disable looking behind
				DisableControlAction(0, 73, true) -- Disable clearing animation
				DisableControlAction(2, 199, true) -- Disable pause screen

				DisableControlAction(0, 59, true) -- Disable steering in vehicle
				DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
				DisableControlAction(0, 72, true) -- Disable reversing in vehicle

				DisableControlAction(2, 36, true) -- Disable going stealth

				DisableControlAction(0, 47, true)  -- Disable weapon
				DisableControlAction(0, 264, true) -- Disable melee
				DisableControlAction(0, 257, true) -- Disable melee
				DisableControlAction(0, 140, true) -- Disable melee
				DisableControlAction(0, 141, true) -- Disable melee
				DisableControlAction(0, 142, true) -- Disable melee
				DisableControlAction(0, 143, true) -- Disable melee
				DisableControlAction(0, 75, true)  -- Disable exit vehicle
				DisableControlAction(27, 75, true) -- Disable exit vehicle

				if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
					ESX.Streaming.RequestAnimDict('mp_arresting', function()
						TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					end)
				end
			else
				Citizen.Wait(500)
			end
		end
	end
end)

-- Gestion du menu Coffre

function OpenCoffre(job2)
	local CoffreGang = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Coffre du Gang", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

		function RageUI.PoolMenus:Example()

			CoffreGang:IsVisible(function(Items)
				-- Item
				Items:AddSeparator("~r~↓~s~   Coffre Objets / Armes "..string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50) .."    ~r~↓~s~")

				Items:AddButton("~r~→~s~ Mettre Objets / Armes", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
					if onSelected then
						putObject(job2)
					end
				end)

				Items:AddButton("~r~→~s~ Prendre Objets / Armes", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
					if onSelected then
						takeObject(job2)
					end
				end)

				-- Items:AddSeparator("~r~↓~s~    Arme coffre ".. job2 .."    ~r~↓~s~")

				-- Items:AddButton("~r~→~s~ Mettre Arme", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
				-- end, putWeapon)

				-- Items:AddButton("~r~→~s~ Prendre Arme", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
				-- end, takeWeapon)
			end, function(Panels)
			end)

		end

	RageUI.Visible(CoffreGang, not RageUI.Visible(CoffreGang))
end

function putObject(job2)
	local putObject = RageUI.CreateMenu(string.upper(job2), "~r~Mettre dans le coffre", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('Xel_Gang:getPlayerInventory', function(inventory)
		function RageUI.PoolMenus:Example()
			putObject:IsVisible(function(Items)
				-- Item
				Items:AddSeparator("~r~↓~s~    Votre Inventaire    ~r~↓~s~")

				Items:AddButton("~r~→~s~ Argent Sale", nil, { IsDisabled = false , RightLabel = "~r~"..inventory.money .. " ~s~$"}, function(onSelected)
					if onSelected then
						local amount = KeyboardInput("Montant à déposer :", "", 20)

						if amount ~= nil then
							amount = tonumber(amount)
			
							if type(amount) == 'number' then
								TriggerServerEvent('Xel_Gang:putStockItems', 'black_money', amount, job2)
								OpenCoffre(job2)
							end
						end
					end
				end)

				for i=1, #inventory.items, 1 do
					local item = inventory.items[i]
		
					if item.count > 0 then
						Items:AddButton("~r~→~s~ "..item.label, nil, { IsDisabled = false , RightLabel = "x ~r~"..item.count}, function(onSelected)
							if onSelected then
								local amount = KeyboardInput("Montant à déposer :", "", 20)

								if amount ~= nil then
									amount = tonumber(amount)
					
									if type(amount) == 'number' then
										TriggerServerEvent('Xel_Gang:putStockItems', item.name, amount, job2)
										OpenCoffre(job2)
									end
								end
							end
						end)
					end
				end

			end, function(Panels)
			end)
		end
	end)

	RageUI.Visible(putObject, not RageUI.Visible(putObject))
end

function takeObject(job2)
	local takeObject = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Prendre dans le coffre", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('Xel_Gang:getStockItems', function(items)
		function RageUI.PoolMenus:Example()
			takeObject:IsVisible(function(Items)
				-- Item
				for i=1, #items, 1 do

					if items[i].count > 0 then
						if items[i].name == 'black_money' then
							items[i].label = "Argent Sale"
						end
						if items[i].name == 'black_money' then
							Items:AddButton("~r~→~s~ "..items[i].label, nil, { IsDisabled = false , RightLabel = "~r~"..items[i].count.." ~s~$"}, function(onSelected)
								if onSelected then
									local amount = KeyboardInput("Montant à prendre :", "", 20)
	
									if amount ~= nil then
										amount = tonumber(amount)
						
										if type(amount) == 'number' then
											TriggerServerEvent('Xel_Gang:getStockItem', items[i].name, amount, job2)
											OpenCoffre(job2)
										end
									end
								end
							end)
						else
							Items:AddButton("~r~→~s~ "..items[i].label, nil, { IsDisabled = false , RightLabel = "x ~r~"..items[i].count}, function(onSelected)
								if onSelected then
									local amount = KeyboardInput("Montant à prendre :", "", 20)
	
									if amount ~= nil then
										amount = tonumber(amount)
						
										if type(amount) == 'number' then
											TriggerServerEvent('Xel_Gang:getStockItem', items[i].name, amount, job2)
											OpenCoffre(job2)
										end
									end
								end
							end)
						end
					end
				end
			end, function(Panels)
			end)
		end
	end, job2)

	RageUI.Visible(takeObject, not RageUI.Visible(takeObject))
end

-- Function utile

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

-- Gestion Garage

function OpenGarage(job2, VehicleGang, PosSpawnCar)
	local GarageGang = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Coffre du Gang", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('Xel_Gang:getPersonnalVehicle', function(ownedCars)
		function RageUI.PoolMenus:Example()

			GarageGang:IsVisible(function(Items)
				-- Item
				Items:AddSeparator("~r~↓~s~    Garage Gang ".. string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50) .."    ~r~↓~s~")
	
				for k, v in pairs(VehicleGang) do
					Items:AddButton("~r~→~s~ "..v.label, nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
						if onSelected then
							SpawnVehicle(job2, v.model, PosSpawnCar)
							Citizen.CreateThread(function()
								RageUI.CloseAll()
							end)
						end
					end)
				end
	
				Items:AddSeparator("~r~↓~s~    Véhicule Personnel   ~r~↓~s~")

				for k,v in pairs(ownedCars) do
					if v.stored == true then
						Items:AddButton("~r~→~s~ "..GetDisplayNameFromVehicleModel(v.vehicle.model), nil, { IsDisabled = false , RightLabel = "~o~"..v.plate}, function(onSelected)
							if onSelected then
								SpawnPersonnalVehicle(v.vehicle, v.plate, PosSpawnCar)
								personnal_plate = v.plate
								TriggerServerEvent('Xel_Gang:UpdateVehicle', v.plate, 0)
								Citizen.CreateThread(function()
									RageUI.CloseAll()
								end)
							end
						end)
					else
						Items:AddButton("~r~→~s~ "..GetDisplayNameFromVehicleModel(v.vehicle.model) .. " ~r~[Sortie]", nil, { IsDisabled = false , RightLabel = "~o~"..v.plate}, function(onSelected)
							if onSelected then
							end
						end)
					end
				end

				Items:AddSeparator("~r~↓~s~    Rentrer Véhicule   ~r~↓~s~")

				Items:AddButton("~r~→~s~ Ranger votre véhicule", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
					if onSelected then
						if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= 0 then
							local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
							local vehicle = ESX.Game.GetVehicleProperties(veh)
							local plate = vehicle.plate
							if plate == personnal_plate then
								TriggerServerEvent('Xel_Gang:UpdateVehicle', personnal_plate, 1)
								DeleteVehicle(veh)
								Citizen.CreateThread(function()
									RageUI.CloseAll()
								end)
								ESX.ShowNotification("Véhicule ~g~rangé ~s~!")
							elseif plate == string.upper(job2) then
								DeleteVehicle(veh)
								Citizen.CreateThread(function()
									RageUI.CloseAll()
								end)
								ESX.ShowNotification("Véhicule ~g~rangé ~s~!")
							elseif plate ~= personnal_plate or plate ~= job2 then
								ESX.ShowNotification("~r~Impossible de rentrer le véhicule !")
							end
						else
							ESX.ShowNotification("~r~Vous n'êtes pas dans un véhicule !")
						end
					end
				end)


			end, function(Panels)
			end)
	
		end
	end)

	RageUI.Visible(GarageGang, not RageUI.Visible(GarageGang))
end

function SpawnPersonnalVehicle(vehicle, plaque, PosSpawnCar)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = PosSpawnCar.x,
		y = PosSpawnCar.y,
		z = PosSpawnCar.z 
	}, GetEntityHeading(PlayerPedId()), function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)
end

function SpawnVehicle(job2, model, PosSpawnCar)
	local playerPed = PlayerPedId()

	RequestModel(model)
	while not HasModelLoaded(model) do Citizen.Wait(10) end

	local new_car = CreateVehicle(model, PosSpawnCar.x, PosSpawnCar.y, PosSpawnCar.z, PosSpawnCar.w, true, true)
	SetVehicleOnGroundProperly(new_car)
	SetVehicleNumberPlateText(new_car, job2)
end

-- Menu gestion boss

function OpenBoss(job2)
	local MenuBoss = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Action gÉrant de gang", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);
	local SubBoss = RageUI.CreateSubMenu(MenuBoss, string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Action gÉrant de gang", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

		function RageUI.PoolMenus:Example()

			MenuBoss:IsVisible(function(Items)
				-- Item
				Items:AddSeparator("~r~↓~s~    Gestion ".. string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50) .."    ~r~↓~s~")

				Items:AddButton("~r~→~s~ Retirer de l'argent", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						local amount = KeyboardInput("Montant à retirer :", "", 20)

						if amount ~= nil then
							amount = tonumber(amount)
			
							if type(amount) == 'number' then
								TriggerServerEvent('esx_society:withdrawMoney', job2, amount)
							end
						end
                    end
                end)	
				
				Items:AddButton("~r~→~s~ Déposer de l'argent", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						local amount = KeyboardInput("Montant à retirer :", "", 20)

						if amount ~= nil then
							amount = tonumber(amount)
			
							if type(amount) == 'number' then
								TriggerServerEvent('esx_society:depositMoney', job2, amount)
							end
						end
                    end
                end)
				
				Items:AddButton("~r~→~s~ Gestion membre", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
                    end
                end, SubBoss)

			end, function(Panels)
			end)

			SubBoss:IsVisible(function(Items)
				-- Item
				
				Items:AddButton("~r~→~s~ Liste des membres", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						OpenManageMemberMenu(job2)
                    end
                end)

				Items:AddButton("~r~→~s~ Recruter des membres", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
                    if (onSelected) then
						OpenRecruitMemberMenu(job2)
                    end
                end)

			end, function(Panels)
			end)

		end

	RageUI.Visible(MenuBoss, not RageUI.Visible(MenuBoss))
end

function OpenManageMemberMenu(job2)
	local ManageMember = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Liste des membres", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);
	local SubManageMember = RageUI.CreateSubMenu(ManageMember, string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Choix de l'action", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('esx_society:getEmployees2', function(employees)
		function RageUI.PoolMenus:Example()

			ManageMember:IsVisible(function(Items)
				-- Item
				Items:AddSeparator("~r~↓~s~    Membres du gang ".. string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50) .."    ~r~↓~s~")

				for i=1, #employees, 1 do
					local gradeLabel = (employees[i].job2.grade_label == '' and employees[i].job2.label or employees[i].job2.grade_label)

					Items:AddButton("~r~→~s~ "..employees[i].name, nil, { IsDisabled = false , RightLabel = "~r~Grade : ~s~"..gradeLabel}, function(onSelected)
						if (onSelected) then
							OpenManageMemberSubMenu(job2, employees[i])
						end
					end)
				end
				

			end, function(Panels)
			end)

			SubManageMember:IsVisible(function(Items)
				-- Item
				Items:AddButton("~r~→~s~ Promouvoir", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
					if (onSelected) then
					end
				end)

				Items:AddButton("~r~→~s~ Virer", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
					if (onSelected) then
						ESX.TriggerServerCallback('esx_society:setJob2', function()
							OpenManageMemberMenu(job2)
						end, employees.identifier, 'unemployed', 0, 'fire')
					end
				end)

			end, function(Panels)
			end)

		end

	end, job2)

	RageUI.Visible(ManageMember, not RageUI.Visible(ManageMember))
end

function OpenManageMemberSubMenu(job2, employee)
	local ManageMemberSubMenu = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Liste des membres", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	function RageUI.PoolMenus:Example()
		ManageMemberSubMenu:IsVisible(function(Items)
			-- Item
			Items:AddButton("~r~→~s~ Promouvoir", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
				if (onSelected) then
					OpenGradeMemberMenu(job2, employee)
				end
			end)

			Items:AddButton("~r~→~s~ Virer", nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
				if (onSelected) then
					ESX.TriggerServerCallback('esx_society:setJob2', function()
						OpenManageMemberMenu(job2)
					end, employee.identifier, 'unemployed', 0, 'fire')
				end
			end)
			
		end, function(Panels)
		end)
	end

	RageUI.Visible(ManageMemberSubMenu, not RageUI.Visible(ManageMemberSubMenu))
end

function OpenGradeMemberMenu(job2s, employee)

	local ManageGradeMember = RageUI.CreateMenu(string.upper(string.sub(job2s, 1, 1)) .. string.sub(job2s, 2, 50), "~r~Liste des grades", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('esx_society:getJob2', function(job2)

		function RageUI.PoolMenus:Example()
			ManageGradeMember:IsVisible(function(Items)
				-- Item

				for i=1, #job2.grades, 1 do
					local gradeLabel = (job2.grades[i].label == '' and job2.label or job2.grades[i].label)
		
					-- table.insert(elements, {
					-- 	label = gradeLabel,
					-- 	value = job2.grades[i].grade,
					-- 	selected = (employee.job2.grade == job2.grades[i].grade)
					-- })

					
					Items:AddButton("~r~→~s~ "..gradeLabel, nil, { IsDisabled = false , RightLabel = ""}, function(onSelected)
						if (onSelected) then
							ESX.TriggerServerCallback('esx_society:setJob2', function()
								OpenManageMemberMenu(job2s)
							end, employee.identifier, job2s, job2.grades[i].grade, 'promote')
							Citizen.CreateThread(function()
								RageUI.CloseAll()
							end)
						end
					end)
				end

				
			end, function(Panels)
			end)
		end

	end, job2s)

	RageUI.Visible(ManageGradeMember, not RageUI.Visible(ManageGradeMember))
end

function OpenRecruitMemberMenu(job2)
	local RecruitMenu = RageUI.CreateMenu(string.upper(string.sub(job2, 1, 1)) .. string.sub(job2, 2, 50), "~r~Liste des personnes", 1, 1, "commonmenu", "gradient_nav", 255, --[[Rouge]] 0, --[[Vert]] 0, --[[Bleu]] 0);

	ESX.TriggerServerCallback('esx_society:getOnlinePlayers2', function(players)
		function RageUI.PoolMenus:Example()
			RecruitMenu:IsVisible(function(Items)

				for i=1, #players, 1 do
					if players[i].job2.name ~= job2 then
						Items:AddButton("~r~→~s~ "..players[i].name, nil, { IsDisabled = false , RightLabel = "~o~ [Recruter]"}, function(onSelected)
							if (onSelected) then
								ESX.TriggerServerCallback('esx_society:setJob2', function()
									OpenManageMemberMenu(job2)
								end, players[i].identifier, job2, 0, 'hire')
							end
						end)
					end
				end
				-- Item

			end, function(Panels)
			end)
		end
	end)

	RageUI.Visible(RecruitMenu, not RageUI.Visible(RecruitMenu))
end