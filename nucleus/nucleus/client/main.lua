-- Nucleus Framework Client
-- Main client-side file

local PlayerData = {}
local isLoggedIn = false

-- Initialize Framework
Citizen.CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent('nucleus:server:playerLoaded')
            break
        end
        Citizen.Wait(100)
    end
end)

-- Framework Functions
function GetPlayerData()
    return PlayerData
end

function IsLoggedIn()
    return isLoggedIn
end

-- Player Data Management
RegisterNetEvent('nucleus:client:setPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('nucleus:client:playerLoaded', function()
    isLoggedIn = true
    Nucleus.DebugPrint('Player loaded successfully')
end)

RegisterNetEvent('nucleus:client:onPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
end)

-- Notification System
RegisterNetEvent('nucleus:client:showNotification', function(message, type)
    -- Basic notification system
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0, 1)
end)

-- Job System
RegisterNetEvent('nucleus:client:setJob', function(job)
    PlayerData.job = job
end)

-- Money System
RegisterNetEvent('nucleus:client:setMoney', function(money)
    PlayerData.money = money
end)

-- Position System
RegisterNetEvent('nucleus:client:setPosition', function(position)
    PlayerData.position = position
end)

-- Utility Functions
function ShowNotification(message, type)
    TriggerEvent('nucleus:client:showNotification', message, type)
end

function GetPlayerFromId(source)
    return Nucleus.GetPlayerFromId(source)
end

-- Export Functions
exports('GetPlayerData', GetPlayerData)
exports('IsLoggedIn', IsLoggedIn)
exports('ShowNotification', ShowNotification)
exports('GetPlayerFromId', GetPlayerFromId)
