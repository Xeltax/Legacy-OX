RegisterServerEvent('Xel_Hud:sendInfoS')
AddEventHandler('Xel_Hud:sendInfoS', function()
    local xPlayer = source and ESX.GetPlayerFromId(source)
    TriggerClientEvent('Xel_Hud:sendInfo', source, xPlayer.getMoney(), xPlayer.getAccount('bank').money, xPlayer.getAccount('black_money').money)
end)