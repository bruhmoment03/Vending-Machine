Config = {}

Config.Machine = {
    [1] = {
        ['Model'] = "prop_vend_snak_01", -- machine model
        ['icon'] = 'fas fa-candy-cane', -- qb-target icon
        ['label'] = "零食販賣機", -- qb-target display text
        ['type'] = "Snacks", -- type DO NOT CHANGE
    },
    [2] = {
        ['Model'] = "prop_vend_soda_01",
        ['icon'] = 'fas fa-glass-whiskey',
        ['label'] = "飲品販賣機",
        ['type'] = "Drinks",
    },
    [3] = {
        ['Model'] ="prop_vend_soda_02",
        ['icon'] = 'fas fa-glass-whiskey',
        ['label'] = "飲品販賣機",
        ['type'] = "Drinks",
    }
}

Config.Items = {
    ["Snacks"] = { -- DO NOT CHANGE
        [1] = {
            name = "Sandwich", -- Display name
            item = "sandwich", -- Item name from shared.lua
            txt = "yummy sandwich from ws!", -- Display text
            icon = "fas fa-ice-cream", -- Display icon
            price = 150 -- items price
        },
        [2] = {
            name = "Sandwich With Cheese",
            item = "tosti",
            txt = "extra fat",
            icon = "fas fa-poo",
            price = 650
        },
    },

    ["Drinks"] = {
        [1] = {
            name = "Coke",
            item = "kurkakola",
            txt = "definitely not the one you can sniff",
            icon = "fas fa-bottle-water",
            price = 500
        }
    }
}
