-- Nucleus Framework Client Events
-- Event handlers for client-side functionality

-- Player Events
RegisterNetEvent('playerSpawned', function()
    TriggerServerEvent('nucleus:server:onPlayerSpawn')
end)

RegisterNetEvent('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Nucleus.DebugPrint('Nucleus Framework started on client')
    end
end)

RegisterNetEvent('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Nucleus.DebugPrint('Nucleus Framework stopped on client')
    end
end)

-- Health and Death System
local isDead = false

RegisterNetEvent('nucleus:client:setHealth', function(health)
    local ped = PlayerPedId()
    SetEntityHealth(ped, health)
end)

RegisterNetEvent('nucleus:client:setArmor', function(armor)
    local ped = PlayerPedId()
    SetPedArmour(ped, armor)
end)

RegisterNetEvent('nucleus:client:onPlayerDeath', function()
    isDead = true
    local ped = PlayerPedId()
    SetEntityHealth(ped, 0)
end)

RegisterNetEvent('nucleus:client:onPlayerRevive', function()
    isDead = false
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
end)

-- Vehicle System
RegisterNetEvent('nucleus:client:spawnVehicle', function(model, coords, heading)
    local hash = GetHashKey(model)
    RequestModel(hash)
    
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    
    local vehicle = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end)

-- Teleport System
RegisterNetEvent('nucleus:client:teleport', function(coords)
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, true)
end)

-- Inventory System (Basic)
RegisterNetEvent('nucleus:client:useItem', function(item, amount)
    -- Basic item usage
    if item == 'bread' then
        ShowNotification('You ate some bread', 'success')
    elseif item == 'water' then
        ShowNotification('You drank some water', 'success')
    end
end)

-- Job System Events
RegisterNetEvent('nucleus:client:setJob', function(job)
    PlayerData.job = job
    ShowNotification('Job changed to: ' .. job.label, 'info')
end)

-- Money System Events
RegisterNetEvent('nucleus:client:addMoney', function(amount, moneyType)
    if moneyType == 'cash' then
        PlayerData.money.cash = PlayerData.money.cash + amount
    elseif moneyType == 'bank' then
        PlayerData.money.bank = PlayerData.money.bank + amount
    end
    ShowNotification('Added $' .. amount .. ' to ' .. moneyType, 'success')
end)

RegisterNetEvent('nucleus:client:removeMoney', function(amount, moneyType)
    if moneyType == 'cash' then
        PlayerData.money.cash = PlayerData.money.cash - amount
    elseif moneyType == 'bank' then
        PlayerData.money.bank = PlayerData.money.bank - amount
    end
    ShowNotification('Removed $' .. amount .. ' from ' .. moneyType, 'error')
end)

-- Commands
RegisterCommand('nucleus', function(source, args)
    if args[1] == 'info' then
        ShowNotification('Nucleus Framework v' .. Config.FrameworkVersion, 'info')
    elseif args[1] == 'debug' then
        ShowNotification('Debug mode: ' .. tostring(Config.Debug), 'info')
    end
end, false)

-- Threads
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        if isLoggedIn then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local health = GetEntityHealth(ped)
            local armor = GetPedArmour(ped)
            
            -- Update player data
            TriggerServerEvent('nucleus:server:updatePlayerData', {
                position = coords,
                health = health,
                armor = armor
            })
        end
    end
end)
