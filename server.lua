local loadoutQueue = {}

function giveLoadoutItems(playerId, loadoutLabel)
    for _, target in ipairs(Config.Targets) do
        if target.label == loadoutLabel then
            for _, item in ipairs(target.items) do
                local success, response = exports.ox_inventory:AddItem(playerId, item.item, item.amount) 
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

    loadoutQueue[playerId] = loadoutLabel

    if Config.UseAnimation then
        TriggerClientEvent('ejj_loadout:playLoadoutAnimation', playerId)
    else
        giveLoadoutItems(playerId, loadoutLabel)
        loadoutQueue[playerId] = nil 
    end
end)

RegisterServerEvent('ejj_loadout:propDeleted')
AddEventHandler('ejj_loadout:propDeleted', function()
    local playerId = source

    if loadoutQueue[playerId] then
        giveLoadoutItems(playerId, loadoutQueue[playerId])

        loadoutQueue[playerId] = nil
    end
end)