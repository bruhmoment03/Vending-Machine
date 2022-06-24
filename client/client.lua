QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while not QBCore do
        Wait(0)
    end
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for type, v in pairs(Config.Machine) do
        for i=1, #v do
            local machine = GetClosestObjectOfType(pedCoords.x ,pedCoords.y, pedCoords.z, 1.0, GetHashKey(v[i]), 0, 0, 0)
            local machinepos = GetEntityCoords(machine)
            local dist = GetDistanceBetweenCoords(pedCoords, machinepos.x, machinepos.y, machinepos.z, false)
            if dist <= 1.8 then
                exports['qb-target']:AddTargetModel(v, {
                    options = {
                        {
                            type = "client",
                            event = "vm:client:snackmenu",
                            icon = "fas fa-cookie",
                            label = "打開選單",
                        },
                    },
                    distance = 1.8
                })
            end
        end
    end
end)

RegisterNetEvent('vm:client:snackmenu', function()
    local vm = {
        {
            header = "販賣機",
            isMenuHeader = true,
        },
        {
            header = "商品",
            txt = "販賣機食品",
            params = {
                event = "vm:client:snackmenu:food",
                args = {}
            }
        }
    }
    exports['qb-menu']:openMenu(vm)
end)

RegisterNetEvent('vm:client:snackmenu:food', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local vm = {
        {
            header = "食物",
            isMenuHeader = true,
        }
    }
    for i, k in pairs(Config.Items) do
        vm[#vm + 1] = {
            header = i,
            txt = k.txt,
            icon  = k.icon,
            params = {
                event = "client:purchase",
                args = {
                    item = k.item,
                    price = k.price
                }
            }
        }
    end
    exports['qb-menu']:openMenu(vm)
end)

RegisterNetEvent('client:purchase', function(args)
    TriggerServerEvent('server:purchase', args.item, args.price)
end)
