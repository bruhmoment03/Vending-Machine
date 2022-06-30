QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while not QBCore do
        Wait(0)
    end
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for type, v in pairs(Config.Machine) do
        local machine = GetClosestObjectOfType(pedCoords.x ,pedCoords.y, pedCoords.z, 1.0, GetHashKey(v['Model']), 0, 0, 0)
        local machinepos = GetEntityCoords(machine)
        local dist = GetDistanceBetweenCoords(pedCoords, machinepos.x, machinepos.y, machinepos.z, false)
        if dist <= 1.8 then
            exports['qb-target']:AddTargetModel(v, {
                options = {
                    {
                        type = "client",
                        event = "vm:client:snackmenu",
                        icon = v['icon'],
                        label = v['label'],
                        Vtype = v['type'],
                        model = v['Model'],
                    },
                },
                distance = 1.8
            })
        end
    end
end)

RegisterNetEvent('vm:client:snackmenu', function(Data)
    local Vtype = Data['Vtype'] -- the vending machine type
    local Model = Data['model']
    local vm = {
        {
            header = "販賣機",
            isMenuHeader = true,
        },
        {
            header = "選單",
            txt = "點擊進入販賣機選單",
            params = {
                event = "vm:client:snackmenu:food",
                args = {
                    type = Vtype,
                    Model = Model
                }
            }
        }
    }
    exports['qb-menu']:openMenu(vm)
end)

RegisterNetEvent('vm:client:snackmenu:food', function(Data)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local Model = GetClosestObjectOfType(pedCoords.x ,pedCoords.y, pedCoords.z, 1.0, Data.Model, 0, 0, 0)
    local type = Data.type
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local vm = {
        {
            header = "販賣機商品",
            isMenuHeader = true,
        }
    }
    for i, k in pairs(Config.Items[type]) do
        vm[#vm + 1] = {
            header = k.name,
            txt = k.txt,
            icon  = k.icon,
            params = {
                event = "client:purchase",
                args = {
                    model = GetEntityCoords(Model),
                    item = k.item,
                    price = k.price
                }
            }
        }
    end
    exports['qb-menu']:openMenu(vm)
end)

RegisterNetEvent('client:purchase', function(args)
    TriggerServerEvent('server:purchase', args.item, args.price, args.model)
end)
