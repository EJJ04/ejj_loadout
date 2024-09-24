lib.locale()

local ped = nil
local prop = nil
local playerCooldowns = {} 

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ClearAreaOfPeds(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z, 2.0, true)
    end
end)

function CreatePedEJJLoadout()
    lib.requestModel(Config.Ped)

    ped = CreatePed(4, Config.Ped, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 1, Config.PedHeading, false, true)
    
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {
        {
            name = Config.TargetBox.name, 
            icon = Config.TargetBox.icon, 
            label = Config.TargetBox.label,
            groups = Config.TargetBox.groups, 
            onSelect = function()

                if Config.UseCooldown then
                    local playerId = GetPlayerServerId(PlayerId()) 
                    local currentTime = GetGameTimer() / 1000 

                    if playerCooldowns[playerId] and (currentTime - playerCooldowns[playerId] < Config.CooldownTime) then
                        local remainingTime = math.ceil(Config.CooldownTime - (currentTime - playerCooldowns[playerId]))
                        lib.notify({
                            title = locale('cooldown_active'),  
                            description = locale('please_wait', remainingTime), 
                            type = "error"
                        })
                        return 
                    end

                    
                    playerCooldowns[playerId] = currentTime
                end

                lib.registerContext({
                    id = 'ejj_loadout:1', 
                    title = locale('loadout_menu_title'),  
                    options = Config.LoadoutOptions 
                })
                
                lib.showContext('ejj_loadout:1')
            end
        },
    }

    exports.ox_target:addModel(Config.Ped, options)
    SetModelAsNoLongerNeeded(Config.Ped)
end

function playLoadoutAnimation()
    local carryDict = "anim@heists@box_carry@"
    local giveDict = "mp_common"
    local propModel = `hei_prop_heist_box`

    lib.requestAnimDict(carryDict)
    lib.requestAnimDict(giveDict)

    lib.requestModel(propModel)

    TaskPlayAnim(ped, carryDict, "idle", 8.0, -8.0, -1, 49, 0, false, false, false)

    prop = CreateObject(propModel, 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)

    Wait(2000)
    ClearPedTasks(ped)

    TaskPlayAnim(ped, giveDict, "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)

    Wait(1500)
    if DoesEntityExist(prop) then
        DeleteObject(prop)
        prop = nil

        ClearPedTasks(ped)

        TriggerServerEvent('ejj_loadout:propDeleted')
    end

    RemoveAnimDict(carryDict)
    RemoveAnimDict(giveDict)

    SetModelAsNoLongerNeeded(propModel)
end

RegisterNetEvent('ejj_loadout:playLoadoutAnimation')
AddEventHandler('ejj_loadout:playLoadoutAnimation', function()
    playLoadoutAnimation()
end)

if Config.UsePed then
    CreatePedEJJLoadout()
end