local isPaused = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    Citizen.Wait(1000)
    TriggerServerEvent('Xel_Hud:sendInfoS')
end)

RegisterNetEvent("Xel_Hud:sendInfo")
AddEventHandler("Xel_Hud:sendInfo", function(money, bank, black_money)

    SendNUIMessage({
        loaded = true,
        job = ESX.PlayerData.job,
        job2 = ESX.PlayerData.job2,
        money = money,
        bank = bank,
        black_money = black_money
    })


    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == "boss" then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(society_money)
            SendNUIMessage({
                job = ESX.PlayerData.job,
                society = society_money
            })
        end, ESX.PlayerData.job.name)
    end

    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == "boss" then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney2', function(society_money)
            SendNUIMessage({
                job2 = ESX.PlayerData.job2,
                society2 = society_money
            })
        end, ESX.PlayerData.job2.name)
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    SendNUIMessage({
        loaded = true,
        job = ESX.PlayerData.job,
    })

    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == "boss" then
        Citizen.Wait(100)
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            SendNUIMessage({
                loaded = true,
                job = ESX.PlayerData.job,
                society = money
            })
        end, ESX.PlayerData.job.name)
    end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2

    SendNUIMessage({
        loaded = true,
        job2 = ESX.PlayerData.job2,
    })

    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == "boss" then
        Citizen.Wait(100)
        ESX.TriggerServerCallback('esx_society:getSocietyMoney2', function(money)
            SendNUIMessage({
                loaded = true,
                job2 = ESX.PlayerData.job2,
                society2 = money
            })
        end, ESX.PlayerData.job2.name)
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for i=1, #(ESX.PlayerData.accounts) do
        if ESX.PlayerData.accounts[i].name == account.name then
            ESX.PlayerData.accounts[i] = account
            break
        end
    end

    if (account.name == "money") then
        SendNUIMessage({
            money = account.money,
        })
    elseif (account.name == "bank") then
        SendNUIMessage({
            bank = account.money,
        })
    elseif (account.name == "black_money") then
        SendNUIMessage({
            black_money = account.money,
        })
    end
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
    if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
        SendNUIMessage({
            loaded = true,
            job = ESX.PlayerData.job,
            society = money
        })
    end

    if ESX.PlayerData.job2 and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
        SendNUIMessage({
            loaded = true,
            job2 = ESX.PlayerData.job2,
            society2 = money
        })
    end
end)

CreateThread(function()
    while true do
        Wait(300)

        if IsPauseMenuActive() and not isPaused then
            isPaused = true
            SendNUIMessage({
                hide = true,
            })
        elseif not IsPauseMenuActive() and isPaused then
            isPaused = false
            SendNUIMessage({
                hide = false,
            })
        end
    end
end)