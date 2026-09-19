-- Load library
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh Free"
Junkie.identifier = "1202510" 
Junkie.provider = "Eclipse"

-- UI Implementation
local validatedKey = nil

-- Show custom UI 
local function showUI()
    local link = Junkie.get_key_link()
    if link then
        setclipboard(link)  -- Copy to clipboard
        print("Link copied to clipboard!")
    else
        warn("Wait 5 minutes")
        return nil
    end
    
    -- Wait for user to input key (your UI logic here)
    local userKey = promptUserForKey()  -- Replace with your UI input
    
    if userKey then
        local validation = Junkie.check_key(userKey)
        if validation.valid then
            return userKey
        else
            warn("Error: " .. (validation.error or "Invalid key"))
            return nil
        end
    end
end

validatedKey = showUI()

if not validatedKey then
    warn("No valid key provided")
    return
end

-- Store key globally for Junkie script to use
getgenv().SCRIPT_KEY = validatedKey

-- Now load the actual Junkie script
User loads external loader:
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download"))()
Loader shows UI and validates key using Junkie.check_key()
Loader stores key in getgenv().SCRIPT_KEY
Loader loads Junkie script which reads the key from getgenv()
Main script runs with validated key

local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh premium"
Junkie.identifier = "1202510"
Junkie.provider = "Eclipse"

local maxAttempts = 5
local attempts = 0
local validated = false

while not validated and attempts < maxAttempts do
    local link = Junkie.get_key_link()
    if link then
        if setclipboard then
            setclipboard(link)
        end
    else
        warn("Please wait 5 minutes")
    end
    
    -- Get user input (replace with your UI)
    print("\nEnter your key:")
    local userKey = getUserInput()  -- Your UI logic
    
    if userKey and #userKey > 0 then
        attempts = attempts + 1
        
        local validation = Junkie.check_key(userKey)
        if validation.valid then
            validated = true
            getgenv().SCRIPT_KEY = userKey
            print("\nKey validated successfully!")
            break
        else
            local errorMsg = validation.message or "Unknown error"
            warn("[ERROR] " .. errorMsg)
            
            -- Handle specific backend error messages
            if errorMsg == "KEY_EXPIRED" then
                print("[INFO] Key expired - get a new one")
            elseif errorMsg == "HWID_BANNED" then
                game.Players.LocalPlayer:Kick("Hardware banned")
                return
            elseif errorMsg == "SERVICE_MISMATCH" then
                print("[INFO] Key is for a different service")
            elseif errorMsg == "HWID_MISMATCH" then
                print("[INFO] HWID limit reached")
            end
        end
    else
        warn("Error: No key entered")
    end
    
    if attempts >= maxAttempts then
        warn("Error: Too many failed attempts!")
        return
    end
    
    task.wait(1)
end

if not validated then
    warn("Error: Validation failed")
    return
end

-- Load main script
