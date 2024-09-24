Config = {}

-- Cooldown settings
Config.UseCooldown = true           -- Enable or disable cooldown for loadout selection
Config.CooldownTime = 600           -- Cooldown duration in seconds before re-selection

-- Loadout location settings
Config.LoadoutLocation = { 
    location = vec3(455.0805, -996.6035, 30.7106) -- XYZ coordinates for the loadout area
}

-- Ped settings
Config.UsePed = true                 -- Enable or disable the creation of a ped for loadout interaction
Config.Ped = `s_m_y_cop_01`         -- Model of the ped for loadout requests
Config.PedCoords = Config.LoadoutLocation.location -- Coordinates for the ped spawn
Config.PedHeading = 359.3809         -- Heading (facing direction) of the ped at spawn
Config.UseAnimation = true            -- Enable or disable animations for the ped when giving the loadout

-- Loadout options
Config.Targets = {
    {
        label = 'Almen Loadout',  -- Localized name of the first loadout
        description = 'This option will give you, a loadout.', -- description for your option.
        icon = 'fa-solid fa-crown', -- icon for your option.
        items = {                         -- Items included in this loadout
            { item = 'weapon_pistol', label = 'Pistol', amount = 1 },   -- Item details
            { item = 'ammo', label = 'Ammo', amount = 250 }             -- Item details
        }
    },
    {
        label = 'Romeo Loadout',  -- Localized name of the second loadout
        description = 'This option will give you, a loadout.', -- description for your option.
        icon = 'fa-solid fa-crown', -- icon for your option.
        items = {                         -- Items included in this loadout
            { item = 'weapon_carbinerifle', label = 'Carbine Rifle', amount = 1 }, -- Item details
            { item = 'ammo', label = 'Ammo', amount = 150 }                     -- Item details
        }
    }
}

-- Loadout menu options with metadata
Config.LoadoutOptions = {}

for _, target in ipairs(Config.Targets) do
    local metadata = {}

    table.insert(metadata, {
        label = 'THIS LOADOUT HAS',  -- Localized label for the loadout
        progress = 100,
        colorScheme = '#e03131',
    })

    for _, item in ipairs(target.items) do
        table.insert(metadata, {
            label = item.label,           -- Display label for the item
            value = 'x' .. item.amount    -- Amount of the item formatted as x250
        })
    end

    -- Add the loadout option to the Config.LoadoutOptions
    table.insert(Config.LoadoutOptions, {
        title = target.label,           -- Localized title for the loadout option
        description = target.description,
        icon = "fa-solid fa-box-open",  -- Icon displayed next to the title
        metadata = metadata,             -- Metadata for items in the loadout
        onSelect = function()            -- Function called when this option is selected
            TriggerServerEvent('ejj_loadout:giveLoadout', target.label) -- Trigger server event for this loadout
        end
    })
end

-- Target box zone settings for loadout interaction
Config.TargetBox = {
    name = 'ejj_loadout:1',            -- Unique identifier for the target
    icon = 'fa-solid fa-box-archive',  -- Icon for the target
    label = 'Loadout',  -- Localized display label for the target
    groups = 'police',                  -- Group permission required to access this target
    title = 'Police | Loadout'    -- Localized title displayed at the top of the context menu
}