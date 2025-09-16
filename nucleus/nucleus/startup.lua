-- Nucleus Framework Startup Script
-- This script handles initial framework setup and checks

local FrameworkStarted = false

-- Startup function
function StartFramework()
    if FrameworkStarted then
        return
    end
    
    print("^3[Nucleus]^7 Starting Nucleus Framework...")
    
    -- Check dependencies
    if GetResourceState('oxmysql') == 'started' then
        print("^2[Nucleus]^7 oxmysql dependency found")
    else
        print("^1[Nucleus]^7 WARNING: oxmysql not found! Database functionality will not work.")
    end
    
    -- Initialize framework
    FrameworkStarted = true
    print("^2[Nucleus]^7 Framework started successfully!")
    print("^3[Nucleus]^7 Version: " .. Config.FrameworkVersion)
    print("^3[Nucleus]^7 Debug Mode: " .. tostring(Config.Debug))
    
    -- Run framework tests
    if TestFramework then
        TestFramework()
    end
end

-- Start framework on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Citizen.Wait(100) -- Small delay to ensure everything loads
        StartFramework()
    end
end)

-- Export startup function
exports('StartFramework', StartFramework)
