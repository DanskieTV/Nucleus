-- Nucleus Framework Server Events
-- Event handlers for server-side functionality

-- Player Events
RegisterNetEvent('nucleus:server:playerLoaded', function()
    local src = source
    local license = GetPlayerIdentifiers(src)[1]
    local name = GetPlayerName(src)
    
    Nucleus.DebugPrint('Player loaded: ' .. name .. ' (' .. license .. ')')
    
    -- Create or load player data
    local PlayerData = CreatePlayerData(src, license, name)
    
    -- Create player object
    local Player = {
        PlayerData = PlayerData,
        Functions = {
            GetMoney = function(moneyType)
                return GetMoney(src, moneyType)
            end,
            AddMoney = function(amount, moneyType)
                return AddMoney(src, amount, moneyType)
            end,
            RemoveMoney = function(amount, moneyType)
                return RemoveMoney(src, amount, moneyType)
            end,
            SetJob = function(job, grade)
                return SetJob(src, job, grade)
            end
        }
    }
    
    Players[src] = Player
    Nucleus.Players[src] = Player
    
    -- Send player data to client
    TriggerClientEvent('nucleus:client:setPlayerData', src, PlayerData)
    TriggerClientEvent('nucleus:client:playerLoaded', src)
    
    Nucleus.DebugPrint('Player data created for: ' .. name)
end)

RegisterNetEvent('nucleus:server:onPlayerSpawn', function()
    local src = source
    local Player = GetPlayer(src)
    
    if Player then
        Nucleus.DebugPrint('Player spawned: ' .. Player.PlayerData.name)
        
        -- Set player position
        local coords = Player.PlayerData.position
        TriggerClientEvent('nucleus:client:teleport', src, coords)
    end
end)

RegisterNetEvent('nucleus:server:updatePlayerData', function(data)
    local src = source
    local Player = GetPlayer(src)
    
    if Player then
        if data.position then
            Player.PlayerData.position = data.position
        end
        if data.health then
            Player.PlayerData.metadata.health = data.health
        end
        if data.armor then
            Player.PlayerData.metadata.armor = data.armor
        end
    end
end)

-- Player Disconnect
AddEventHandler('playerDropped', function(reason)
    local src = source
    local Player = GetPlayer(src)
    
    if Player then
        Nucleus.DebugPrint('Player disconnected: ' .. Player.PlayerData.name .. ' (' .. reason .. ')')
        
        -- Save player data to database
        if Config.Database.enabled then
            SavePlayerData(src)
        end
        
        -- Remove player from tables
        Players[src] = nil
        Nucleus.Players[src] = nil
    end
end)

-- Database Functions
function SavePlayerData(source)
    local Player = GetPlayer(source)
    if Player then
        MySQL.update('UPDATE `' .. Config.Database.table_prefix .. 'players` SET `money` = ?, `job` = ?, `position` = ?, `metadata` = ? WHERE `citizenid` = ?', {
            json.encode(Player.PlayerData.money),
            json.encode(Player.PlayerData.job),
            json.encode(Player.PlayerData.position),
            json.encode(Player.PlayerData.metadata),
            Player.PlayerData.citizenid
        })
    end
end

-- Commands
RegisterCommand('nucleus', function(source, args, rawCommand)
    if source == 0 then
        if args[1] == 'info' then
            print('Nucleus Framework v' .. Config.FrameworkVersion)
        elseif args[1] == 'players' then
            local count = 0
            for k, v in pairs(Players) do
                count = count + 1
            end
            print('Online players: ' .. count)
        end
    else
        local Player = GetPlayer(source)
        if Player then
            if args[1] == 'info' then
                TriggerClientEvent('nucleus:client:showNotification', source, 'Nucleus Framework v' .. Config.FrameworkVersion, 'info')
            end
        end
    end
end, false)

-- Admin Commands
RegisterCommand('givemoney', function(source, args, rawCommand)
    if source == 0 then
        local targetId = tonumber(args[1])
        local amount = tonumber(args[2])
        local moneyType = args[3] or 'cash'
        
        if targetId and amount then
            if AddMoney(targetId, amount, moneyType) then
                print('Gave $' .. amount .. ' ' .. moneyType .. ' to player ' .. targetId)
            else
                print('Failed to give money to player ' .. targetId)
            end
        else
            print('Usage: givemoney [playerid] [amount] [cash/bank]')
        end
    end
end, true)

RegisterCommand('setjob', function(source, args, rawCommand)
    if source == 0 then
        local targetId = tonumber(args[1])
        local job = args[2]
        local grade = tonumber(args[3]) or 0
        
        if targetId and job then
            if SetJob(targetId, job, grade) then
                print('Set job to ' .. job .. ' grade ' .. grade .. ' for player ' .. targetId)
            else
                print('Failed to set job for player ' .. targetId)
            end
        else
            print('Usage: setjob [playerid] [job] [grade]')
        end
    end
end, true)

-- Resource Events
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Nucleus.DebugPrint('Nucleus Framework started on server')
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Nucleus.DebugPrint('Nucleus Framework stopped on server')
        
        -- Save all player data
        for k, v in pairs(Players) do
            SavePlayerData(k)
        end
    end
end)
