-- Nucleus Framework Shared
-- This file contains shared functions and variables

Nucleus = {}
Nucleus.Players = {}
Nucleus.Objects = {}

-- Framework Functions
function Nucleus.GetPlayer(source)
    return Nucleus.Players[source]
end

function Nucleus.GetPlayerFromId(source)
    return Nucleus.Players[source]
end

function Nucleus.GetPlayerFromCitizenId(citizenid)
    for k, v in pairs(Nucleus.Players) do
        if v.PlayerData.citizenid == citizenid then
            return v
        end
    end
    return nil
end

function Nucleus.GetPlayers()
    return Nucleus.Players
end

-- Utility Functions
function Nucleus.DebugPrint(message)
    if Config.Debug then
        print('^3[Nucleus Debug]^7 ' .. tostring(message))
    end
end

function Nucleus.ShowNotification(source, message, type)
    TriggerClientEvent('nucleus:client:showNotification', source, message, type)
end

function Nucleus.GetConfig()
    return Config
end

-- Player Data Structure
PlayerData = {
    source = nil,
    citizenid = nil,
    license = nil,
    name = nil,
    money = {
        cash = 0,
        bank = 0
    },
    job = {
        name = 'unemployed',
        label = 'Unemployed',
        payment = 0,
        onduty = false,
        grade = {
            name = 'Unemployed',
            level = 0
        }
    },
    position = {
        x = 0.0,
        y = 0.0,
        z = 0.0
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
