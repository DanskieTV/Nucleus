-- Nucleus Framework Test Script
-- This script tests basic framework functionality

-- Test function to verify framework is working
function TestFramework()
    print("^2[Nucleus Test]^7 Testing framework functionality...")
    
    -- Test 1: Check if Config is loaded
    if Config then
        print("^2[PASS]^7 Config loaded successfully")
        print("^3[INFO]^7 Framework: " .. Config.FrameworkName .. " v" .. Config.FrameworkVersion)
    else
        print("^1[FAIL]^7 Config not loaded")
        return false
    end
    
    -- Test 2: Check if Nucleus object exists
    if Nucleus then
        print("^2[PASS]^7 Nucleus object created successfully")
    else
        print("^1[FAIL]^7 Nucleus object not created")
        return false
    end
    
    -- Test 3: Check if PlayerData structure exists
    if PlayerData then
        print("^2[PASS]^7 PlayerData structure loaded")
    else
        print("^1[FAIL]^7 PlayerData structure not loaded")
        return false
    end
    
    -- Test 4: Check if jobs are configured
    if Config.Jobs and Config.Jobs['unemployed'] then
        print("^2[PASS]^7 Jobs configured successfully")
        print("^3[INFO]^7 Available jobs: " .. #Config.Jobs)
    else
        print("^1[FAIL]^7 Jobs not configured")
        return false
    end
    
    -- Test 5: Check if items are configured
    if Config.Items and Config.Items['bread'] then
        print("^2[PASS]^7 Items configured successfully")
        print("^3[INFO]^7 Available items: " .. #Config.Items)
    else
        print("^1[FAIL]^7 Items not configured")
        return false
    end
    
    print("^2[Nucleus Test]^7 All tests passed! Framework is ready to use.")
    return true
end

-- Run tests on resource start
Citizen.CreateThread(function()
    Citizen.Wait(1000) -- Wait for everything to load
    TestFramework()
end)

-- Export test function
exports('TestFramework', TestFramework)
