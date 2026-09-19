-- Load library
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh Free"
Junkie.identifier = "12345" 
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
