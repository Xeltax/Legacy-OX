RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

AddEventHandler('Xel_Gang:hasEnteredMarker', function(station, part, partNum)
	if part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu"
		CurrentActionData = {}
	end
end)

AddEventHandler('Xel_Gang:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.CloseContext()
	end

	CurrentAction = nil
end)

-- Draw markers and more
CreateThread(function()
	while true do
		local Sleep = 1500
		if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ballas' then
			Sleep = 500
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local distanceCoffre = #(playerCoords - Config.PosCoffre)

			if distanceCoffre <= 5.0 then
				Sleep = 0
				DrawMarker(20, Config.PosCoffre, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if distanceCoffre <= 1.0 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au coffre")
					if IsControlJustReleased(0, 38) then
						exports.ox_inventory:openInventory('stash', {id = 'society_ballas'})
					end
				end
			end


			if ESX.PlayerData.job2.grade_name == 'boss' then

				local distance = #(playerCoords - Config.BossAction)

				if distance < 5.0 then
					DrawMarker(2, Config.BossAction, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
					Sleep = 0

					if distance < 1.0 then
						ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu")
						if IsControlJustReleased(0, 38) then
							TriggerEvent('esx_society:openBossMenu2', 'ballas', function(data, menu)
								menu.close()
							end, {wash = false})
						end
					end
				end

			end
		end
	Wait(Sleep)
	end
end)