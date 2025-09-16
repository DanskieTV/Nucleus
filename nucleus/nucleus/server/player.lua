-- Nucleus Framework Player Management
-- Advanced player functions and management

-- Player Object Functions
function Player:GetMoney(moneyType)
    return GetMoney(self.PlayerData.source, moneyType)
end

function Player:AddMoney(amount, moneyType)
    return AddMoney(self.PlayerData.source, amount, moneyType)
end

function Player:RemoveMoney(amount, moneyType)
    return RemoveMoney(self.PlayerData.source, amount, moneyType)
end

function Player:SetJob(job, grade)
    return SetJob(self.PlayerData.source, job, grade)
end

function Player:GetJob()
    return self.PlayerData.job
end

function Player:GetName()
    return self.PlayerData.name
end

function Player:GetCitizenId()
    return self.PlayerData.citizenid
end

function Player:GetSource()
    return self.PlayerData.source
end

function Player:GetPosition()
    return self.PlayerData.position
end

function Player:SetPosition(coords)
    self.PlayerData.position = coords
    TriggerClientEvent('nucleus:client:teleport', self.PlayerData.source, coords)
end

function Player:GetMetadata()
    return self.PlayerData.metadata
end

function Player:SetMetadata(key, value)
    self.PlayerData.metadata[key] = value
end

function Player:GetMetadataValue(key)
    return self.PlayerData.metadata[key]
end

-- Player Status Functions
function Player:SetHealth(health)
    self.PlayerData.metadata.health = health
    TriggerClientEvent('nucleus:client:setHealth', self.PlayerData.source, health)
end

function Player:SetArmor(armor)
    self.PlayerData.metadata.armor = armor
    TriggerClientEvent('nucleus:client:setArmor', self.PlayerData.source, armor)
end

function Player:SetDead(isDead)
    self.PlayerData.metadata.isdead = isDead
    if isDead then
        TriggerClientEvent('nucleus:client:onPlayerDeath', self.PlayerData.source)
    else
        TriggerClientEvent('nucleus:client:onPlayerRevive', self.PlayerData.source)
    end
end

function Player:IsDead()
    return self.PlayerData.metadata.isdead
end

-- Player Notification
function Player:ShowNotification(message, type)
    TriggerClientEvent('nucleus:client:showNotification', self.PlayerData.source, message, type)
end

-- Player Vehicle Functions
function Player:SpawnVehicle(model, coords, heading)
    TriggerClientEvent('nucleus:client:spawnVehicle', self.PlayerData.source, model, coords, heading)
end

-- Player Item Functions
function Player:UseItem(item, amount)
    TriggerClientEvent('nucleus:client:useItem', self.PlayerData.source, item, amount)
end

-- Player Permission Functions
function Player:HasPermission(permission)
    -- Basic permission system
    if self.PlayerData.job.name == 'admin' then
        return true
    end
    return false
end

function Player:IsAdmin()
    return self.PlayerData.job.name == 'admin'
end

-- Player Data Export
function Player:ExportData()
    return {
        source = self.PlayerData.source,
        citizenid = self.PlayerData.citizenid,
        name = self.PlayerData.name,
        money = self.PlayerData.money,
        job = self.PlayerData.job,
        position = self.PlayerData.position,
        metadata = self.PlayerData.metadata
    }
end

-- Player Data Import
function Player:ImportData(data)
    if data.source then self.PlayerData.source = data.source end
    if data.citizenid then self.PlayerData.citizenid = data.citizenid end
    if data.name then self.PlayerData.name = data.name end
    if data.money then self.PlayerData.money = data.money end
    if data.job then self.PlayerData.job = data.job end
    if data.position then self.PlayerData.position = data.position end
    if data.metadata then self.PlayerData.metadata = data.metadata end
    
    -- Update client
    TriggerClientEvent('nucleus:client:setPlayerData', self.PlayerData.source, self.PlayerData)
end

-- Player Utility Functions
function Player:GetDistanceFromCoords(coords)
    local playerCoords = self.PlayerData.position
    return #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(coords.x, coords.y, coords.z))
end

function Player:GetDistanceFromPlayer(targetPlayer)
    local targetCoords = targetPlayer:GetPosition()
    return self:GetDistanceFromCoords(targetCoords)
end

function Player:IsInRange(coords, range)
    return self:GetDistanceFromCoords(coords) <= range
end

function Player:IsInRangeOfPlayer(targetPlayer, range)
    return self:GetDistanceFromPlayer(targetPlayer) <= range
end

-- Player Event Triggers
function Player:TriggerEvent(eventName, ...)
    TriggerClientEvent(eventName, self.PlayerData.source, ...)
end

function Player:TriggerServerEvent(eventName, ...)
    TriggerServerEvent(eventName, self.PlayerData.source, ...)
end
