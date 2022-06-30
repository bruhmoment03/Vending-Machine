QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('server:purchase')
AddEventHandler("server:purchase", function(item, price, model)
    local Player = QBCore.Functions.GetPlayer(source)
    if NearMachine(model) then
        if Player.Functions.GetMoney("cash") >= price then
            Player.Functions.AddItem(item, 1)
            Player.Functions.RemoveMoney("cash", price)
            TriggerClientEvent('QBCore:Notify', source, "You've bought a "..item.." for "..price, 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, "You don't have enough money to buy "..item, 'error')
        end
    else
        DropPlayer(source, "Attempted to exploit Vending Machine >:(")
    end
end)

function NearMachine(model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Ped = GetPlayerPed(src)
    local Coords = GetEntityCoords(Ped)
    local Dist = #(Coords - model)
    if Dist <= 1.8 then
        return true
    else
        return false
    end
end
