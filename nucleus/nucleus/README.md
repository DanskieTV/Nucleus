# Nucleus Framework

A basic FiveM framework built from scratch for roleplay servers.

## Features

- **Player Management**: Basic player data handling and persistence
- **Job System**: Simple job management with grades and payments
- **Money System**: Cash and bank account management
- **Database Integration**: MySQL database support with oxmysql
- **Event System**: Client-server communication
- **Notification System**: Basic notification system
- **Vehicle System**: Basic vehicle spawning and management
- **Item System**: Basic item handling

## Installation

1. Place the `nucleus` folder in your server's `resources` directory
2. Import the `database.sql` file into your MySQL database
3. Make sure you have `oxmysql` resource installed and running
4. Add `ensure nucleus` to your `server.cfg`
5. Restart your server

## Configuration

Edit `shared/config.lua` to customize:
- Framework settings
- Player defaults
- Jobs and grades
- Items and vehicles
- Locations

## Basic Usage

### Server-side
```lua
-- Get a player
local Player = Nucleus.GetPlayer(source)

-- Add money
Player.Functions.AddMoney(1000, 'cash')

-- Set job
Player.Functions.SetJob('police', 1)

-- Show notification
Player:ShowNotification('Hello!', 'success')
```

### Client-side
```lua
-- Get player data
local PlayerData = GetPlayerData()

-- Check if logged in
if IsLoggedIn() then
    -- Player is logged in
end

-- Show notification
ShowNotification('Hello!', 'info')
```

## Commands

- `/nucleus info` - Show framework information
- `/nucleus debug` - Toggle debug mode
- `/givemoney [playerid] [amount] [cash/bank]` - Give money to player (admin)
- `/setjob [playerid] [job] [grade]` - Set player job (admin)

## Database

The framework uses MySQL with the following main tables:
- `nucleus_players` - Player data
- `nucleus_vehicles` - Vehicle data
- `nucleus_items` - Player inventory
- `nucleus_houses` - House data
- `nucleus_jobs` - Job definitions
- `nucleus_items_data` - Item definitions
- `nucleus_vehicles_data` - Vehicle definitions

## Dependencies

- oxmysql (required for database functionality)

## Support

This is a basic framework. For advanced features, you'll need to extend it with additional scripts and functionality.

## Version

Current version: 1.0.0
