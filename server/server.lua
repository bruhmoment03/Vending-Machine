QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:purchase')
AddEventHandler("server:purchase", function(item, price)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetMoney("cash") >= price then
        Player.Functions.AddItem(item, 1)
        Player.Functions.RemoveMoney("cash", price)
        TriggerClientEvent('QBCore:Notify', source, "You've bought a "..item.." for "..price, 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough money to buy "..item, 'error')
    end
end)