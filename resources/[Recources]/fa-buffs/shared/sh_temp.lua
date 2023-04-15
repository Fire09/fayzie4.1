Config = Config or {}

Config.TickTime = 6000

Config.Buffs = {
    -- Buff Section -- Do not change type, even if you know what you are doing
    -- You are free to change the index names, but other scripts that relie on this config might need it
    ['alert'] = {
        iconColor = "#ffffff",
        iconName = 'database',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },
    ['int'] = {
        iconColor = "#ffffff",
        iconName = 'lightbulb',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },
    ['jobluck'] = {
        iconColor = "#ffffff",
        iconName = 'dollarsign',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },
    ['stamina'] = {
        iconColor = "#ffffff",
        iconName = 'wind',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },
    ['strength'] = {
        iconColor = "#ffffff",
        iconName = 'dumbbell',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },
    ['swimming'] = {
        iconColor = "#ffffff",
        iconName = 'swimmer',
        maxTime = 3600000,
        progressColor = "#FFD700",
        type = 'buff'
    },

    -- Enhancement Section -- Do not change type, even if you know what you are doing
    -- Do not change the index names (super names) as they are used in the front end to determine which icon to change color
    ['super-hunger'] = {
        maxTime = 3600000,
        iconColor = '#FDE829',
        type = 'enhancement',
    },
    ['super-thirst'] = {
        maxTime = 3600000,
        iconColor = '#FDE829',
        type = 'enhancement',
    },
    ['super-health'] = {
        maxTime = 3600000,
        iconColor = '#FDE829',
        type = 'enhancement',
    },
    ['super-armor'] = {
        maxTime = 3600000,
        iconColor = '#FDE829',
        type = 'enhancement',
    },
    ['stressblock'] = {
        maxTime = 3600000,
        iconColor = '#FDE829',
        type = 'enhancement',
    }
}