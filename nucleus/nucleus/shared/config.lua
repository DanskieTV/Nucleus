Config = {}

-- Framework Settings
Config.FrameworkName = 'Nucleus'
Config.FrameworkVersion = '1.0.0'
Config.Debug = true

-- Database Settings
Config.Database = {
    enabled = true,
    table_prefix = 'nucleus_'
}

-- Player Settings
Config.Player = {
    default_money = 5000,
    default_bank = 10000,
    default_job = 'unemployed',
    default_grade = 0
}

-- Job Settings
Config.Jobs = {
    ['unemployed'] = {
        label = 'Unemployed',
        grades = {
            [0] = { name = 'Unemployed', payment = 0 }
        }
    },
    ['police'] = {
        label = 'Police',
        grades = {
            [0] = { name = 'Recruit', payment = 50 },
            [1] = { name = 'Officer', payment = 75 },
            [2] = { name = 'Sergeant', payment = 100 },
            [3] = { name = 'Lieutenant', payment = 125 },
            [4] = { name = 'Captain', payment = 150 }
        }
    },
    ['ambulance'] = {
        label = 'Ambulance',
        grades = {
            [0] = { name = 'Recruit', payment = 50 },
            [1] = { name = 'Paramedic', payment = 75 },
            [2] = { name = 'Doctor', payment = 100 },
            [3] = { name = 'Surgeon', payment = 125 },
            [4] = { name = 'Chief', payment = 150 }
        }
    }
}

-- Items
Config.Items = {
    ['bread'] = {
        label = 'Bread',
        weight = 1,
        type = 'item',
        image = 'bread.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A loaf of bread'
    },
    ['water'] = {
        label = 'Water',
        weight = 1,
        type = 'item',
        image = 'water.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'A bottle of water'
    }
}

-- Vehicles
Config.Vehicles = {
    ['adder'] = {
        name = 'Adder',
        brand = 'Truffade',
        model = 'adder',
        price = 1000000,
        category = 'super'
    },
    ['zentorno'] = {
        name = 'Zentorno',
        brand = 'Pegassi',
        model = 'zentorno',
        price = 725000,
        category = 'super'
    }
}

-- Locations
Config.Locations = {
    ['spawn'] = {
        vector3(-1035.71, -2731.87, 12.86),
        vector3(-1035.71, -2731.87, 12.86),
        vector3(-1035.71, -2731.87, 12.86)
    }
}
