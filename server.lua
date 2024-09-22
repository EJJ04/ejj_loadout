function giveLoadoutItems(playerId, loadoutLabel)
    for _, target in ipairs(Config.Targets) do
        if target.label == loadoutLabel then
            for _, item in ipairs(target.items) do
                local success, response = exports.ox_inventory:AddItem(playerId, item.weapon, item.amount)
                if not success then
                    print("Failed to add item:", response) 
                end
            end
        end
    end
end

RegisterServerEvent('ejj_loadout:giveLoadout')
AddEventHandler('ejj_loadout:giveLoadout', function(loadoutLabel)
    local playerId = source
    giveLoadoutItems(playerId, loadoutLabel) 
end)