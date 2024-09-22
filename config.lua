Config = {}

-- Define the location for the loadout. Change the coordinates as needed.
Config.LoadoutLocation = {
    location = vec3(455.0667, -999.8232, 30.7109) -- XYZ coordinates for the loadout area
}

-- Define the different loadout options available to players.
Config.Targets = {
    {
        label = 'Almen', -- Name of the loadout
        items = { -- Items included in this loadout
            { weapon = 'WEAPON_PISTOL', amount = 1 }, -- Weapon and its amount
            { weapon = 'AMMO', amount = 250 } -- Ammo and its amount
        }
    },
    {
        label = 'Romeo', -- Name of the loadout
        items = { -- Items included in this loadout
            { weapon = 'WEAPON_CARBINERIFLE', amount = 1 }, -- Weapon and its amount
            { weapon = 'AMMO', amount = 150 } -- Ammo and its amount
        }
    }
}

-- Define the loadout options that will be shown in the loadout menu.
Config.LoadoutOptions = {
    {
        title = 'Almen', -- Display title for the loadout option
        icon = "fa-solid fa-box-open", -- Icon displayed next to the title
        onSelect = function() -- Function to call when this option is selected
            TriggerServerEvent('ejj_loadout:giveLoadout', 'Almen') -- Triggers the server event to give this loadout
        end
    },
    {
        title = 'Romeo', -- Display title for the loadout option
        icon = "fa-solid fa-box-open", -- Icon displayed next to the title
        onSelect = function() -- Function to call when this option is selected
            TriggerServerEvent('ejj_loadout:giveLoadout', 'Romeo') -- Triggers the server event to give this loadout
        end
    }
}

-- Define the target box zone for the loadout interaction.
Config.TargetBox = {
    name = 'ejj_loadout:1', -- Unique identifier for the target
    icon = 'fa-solid fa-box-archive', -- Icon for the target
    label = 'Receive your loadout', -- Display label for the target
    groups = 'police', -- Group permission to access this target
    title = 'Police | Loadout' -- Title displayed at the top of the context menu
}