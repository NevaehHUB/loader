-- Load library
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh premium"
Junkie.identifier = "1202510"
Junkie.provider = "Eclipse"

-- Get and copy the link first
local link = Junkie.get_key_link()
if link then
    if setclipboard then
        setclipboard(link)
    end
    print("Link copied to clipboard!")
else
    warn("Please wait 5 minutes before generating a new link")
end

-- Create the GUI
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JunkieKeySystem"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 160)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Nevaeh Premium - Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 0.25, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = link and "Key link copied to clipboard!" or "Please wait 5 minutes"
StatusText.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 13
StatusText.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.9, 0, 0, 35)
KeyInput.Position = UDim2.new(0.05, 0, 0.45, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "Paste your key here..."
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.Text = ""
KeyInput.Parent = MainFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 5)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.9, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Verify Key"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.Parent = MainFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 5)

-- System Variables
local completionEvent = Instance.new("BindableEvent")
local attempts = 0
local maxAttempts = 5

-- Button Logic
SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text
    
    if userKey and #userKey > 0 then
        attempts = attempts + 1
        StatusText.Text = "Checking key..."
        StatusText.TextColor3 = Color3.fromRGB(255, 255, 150)
        
        -- Use official Junkie logic to check key
        local validation = Junkie.check_key(userKey)
        
        if validation.valid then
            StatusText.Text = "Key validated successfully!"
            StatusText.TextColor3 = Color3.fromRGB(150, 255, 150)
            
            -- Store key globally for external loader
            getgenv().SCRIPT_KEY = userKey
            
            task.wait(1)
            ScreenGui:Destroy()
            completionEvent:Fire(true) -- Success
        else
            local errorMsg = validation.message or "Unknown error"
            StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            -- Handle specific backend error messages from your code
            if errorMsg == "KEY_EXPIRED" then
                StatusText.Text = "Key expired - get a new one"
            elseif errorMsg == "HWID_BANNED" then
                game.Players.LocalPlayer:Kick("Hardware banned")
            elseif errorMsg == "SERVICE_MISMATCH" then
                StatusText.Text = "Key is for a different service"
            elseif errorMsg == "HWID_MISMATCH" then
                StatusText.Text = "HWID limit reached"
            else
                StatusText.Text = "Error: " .. errorMsg
            end
            
            if attempts >= maxAttempts then
                StatusText.Text = "Too many failed attempts!"
                task.wait(2)
                ScreenGui:Destroy()
                completionEvent:Fire(false) -- Failed
            end
        end
    else
        StatusText.Text = "Error: No key entered"
        StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Wait for the user to complete the GUI interaction
local isSuccess = completionEvent.Event:Wait()

-- Load main script ONLY if validation was successful
if isSuccess then
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download"))()
else
    warn("Key validation failed or was cancelled.")
end
