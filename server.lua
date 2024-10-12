local loadoutQueue = {}

function giveLoadoutItems(playerId, loadoutLabel)
    local player = nil
    local isESX = GetResourceState('es_extended') == 'started'
    local isQBCore = GetResourceState('qb-core') == 'started'

    if isESX then
        player = ESX.GetPlayerFromId(playerId)
        if player.job.name ~= "police" then
            return
        end
    elseif isQBCore then
        player = QBCore.Functions.GetPlayer(playerId)
        if player.PlayerData.job.name ~= "police" then
            return
        end
    else
        return
    end

    for _, target in ipairs(Config.Targets) do
        if target.label == loadoutLabel then
            for _, item in ipairs(target.items) do
                local success, response = exports.ox_inventory:AddItem(playerId, item.item, item.amount)
                if not success then
                    
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
