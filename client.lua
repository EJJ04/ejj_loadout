exports.ox_target:addBoxZone({
    coords = Config.LoadoutLocation.location, 
    size = vec3(1, 1, 1), 
    options = {
        {
            name = Config.TargetBox.name, 
            icon = Config.TargetBox.icon, 
            label = Config.TargetBox.label,
            groups = Config.TargetBox.groups, 
            onSelect = function() 
                lib.registerContext({
                    id = 'ejj_loadout:1', 
                    title = Config.TargetBox.title, 
                    options = Config.LoadoutOptions 
                })

                lib.showContext('ejj_loadout:1') 
            end
        },
    }
})