-- Nucleus Framework Server
-- Main server-side file

local Players = {}
local Objects = {}

-- Initialize Framework
Citizen.CreateThread(function()
    Nucleus.DebugPrint('Nucleus Framework starting...')
    
    -- Initialize database
    if Config.Database.enabled then
        InitializeDatabase()
    end
    
    Nucleus.DebugPrint('Nucleus Framework started successfully')
end)

-- Database Functions
function InitializeDatabase()
    -- Create basic tables
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `]] .. Config.Database.table_prefix .. [[players` (
            `citizenid` varchar(50) NOT NULL,
            `license` varchar(50) NOT NULL,
            `name` varchar(50) NOT NULL,
            `money` text NOT NULL,
            `job` text NOT NULL,
            `position` text NOT NULL,
            `metadata` text NOT NULL,
            PRIMARY KEY (`citizenid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])
    
    Nucleus.DebugPrint('Database initialized')
end

-- Player Management
function GetPlayer(source)
    return Players[source]
end

function GetPlayerFromId(source)
    return Players[source]
end

function GetPlayerFromCitizenId(citizenid)
    for k, v in pairs(Players) do
        if v.PlayerData.citizenid == citizenid then
            return v
        end
    end
    return nil
end

function GetPlayers()
    return Players
end

-- Player Data Functions
function CreatePlayerData(source, license, name)
    local citizenid = GenerateCitizenId()
    local PlayerData = {
        source = source,
        citizenid = citizenid,
        license = license,
        name = name,
        money = {
            cash = Config.Player.default_money,
            bank = Config.Player.default_bank
        },
        job = {
            name = Config.Player.default_job,
            label = Config.Jobs[Config.Player.default_job].label,
            payment = Config.Jobs[Config.Player.default_job].grades[Config.Player.default_grade].payment,
            onduty = false,
            grade = {
                name = Config.Jobs[Config.Player.default_job].grades[Config.Player.default_grade].name,
                level = Config.Player.default_grade
            }
        },
        position = {
            x = Config.Locations.spawn[1].x,
            y = Config.Locations.spawn[1].y,
            z = Config.Locations.spawn[1].z
        },
        metadata = {
            hunger = 100,
            thirst = 100,
            stress = 0,
            isdead = false,
            armor = 0,
            ishandcuffed = false,
            tracker = false,
            injail = 0,
            jailitems = {},
            status = {},
            phone = {},
            rep = {},
            callsign = 'NO CALLSIGN',
            bloodtype = 'A+',
            fingerprint = '',
            walletid = '',
            criminalrecord = {
                hasRecord = false,
                date = nil
            },
            licences = {
                driver = true,
                business = false,
                weapon = false
            },
            inside = {
                house = nil,
                apartment = {
                    apartmentType = nil,
                    apartmentId = nil,
                }
            },
            phonedata = {
                SerialNumber = nil,
                InstalledApps = {}
            }
        }
    }
    
    return PlayerData
end

function GenerateCitizenId()
    local citizenid = 'NUC' .. math.random(100000, 999999)
    return citizenid
end

-- Money Functions
function AddMoney(source, amount, moneyType)
    local Player = GetPlayer(source)
    if Player then
        if moneyType == 'cash' then
            Player.PlayerData.money.cash = Player.PlayerData.money.cash + amount
        elseif moneyType == 'bank' then
            Player.PlayerData.money.bank = Player.PlayerData.money.bank + amount
        end
        
        TriggerClientEvent('nucleus:client:setMoney', source, Player.PlayerData.money)
        return true
    end
    return false
end

function RemoveMoney(source, amount, moneyType)
    local Player = GetPlayer(source)
    if Player then
        if moneyType == 'cash' then
            if Player.PlayerData.money.cash >= amount then
                Player.PlayerData.money.cash = Player.PlayerData.money.cash - amount
                TriggerClientEvent('nucleus:client:setMoney', source, Player.PlayerData.money)
                return true
            end
        elseif moneyType == 'bank' then
            if Player.PlayerData.money.bank >= amount then
                Player.PlayerData.money.bank = Player.PlayerData.money.bank - amount
                TriggerClientEvent('nucleus:client:setMoney', source, Player.PlayerData.money)
                return true
            end
        end
    end
    return false
end

function GetMoney(source, moneyType)
    local Player = GetPlayer(source)
    if Player then
        if moneyType == 'cash' then
            return Player.PlayerData.money.cash
        elseif moneyType == 'bank' then
            return Player.PlayerData.money.bank
        end
    end
    return 0
end

-- Job Functions
function SetJob(source, job, grade)
    local Player = GetPlayer(source)
    if Player and Config.Jobs[job] then
        local jobData = Config.Jobs[job]
        local gradeData = jobData.grades[grade] or jobData.grades[0]
        
        Player.PlayerData.job = {
            name = job,
            label = jobData.label,
            payment = gradeData.payment,
            onduty = false,
            grade = {
                name = gradeData.name,
                level = grade
            }
        }
        
        TriggerClientEvent('nucleus:client:setJob', source, Player.PlayerData.job)
        return true
    end
    return false
end

-- Export Functions
exports('GetPlayer', GetPlayer)
exports('GetPlayerFromId', GetPlayerFromId)
exports('GetPlayerFromCitizenId', GetPlayerFromCitizenId)
exports('GetPlayers', GetPlayers)
exports('AddMoney', AddMoney)
exports('RemoveMoney', RemoveMoney)
exports('GetMoney', GetMoney)
exports('SetJob', SetJob)
