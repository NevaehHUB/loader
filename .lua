local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Load Junkie SDK
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh premium"
Junkie.identifier = "1202510"
Junkie.provider = "Eclipse" -- Strictly enforces the Eclipse provider

-- Dynamically generate the correct key link for the user
local KEY_LINK = Junkie.get_key_link()

-- Initial Clipboard Copy
if KEY_LINK and setclipboard then
    setclipboard(KEY_LINK)
end

-- ==========================================
-- UI CONSTRUCTION (MODERN REVAMP)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NevaehPremiumUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 240)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Neon Glow Border
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(120, 80, 255) -- Sleek Purple
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Top Accent Line
local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, 0, 0, 4)
AccentLine.Position = UDim2.new(0, 0, 0, 0)
AccentLine.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
AccentLine.BorderSizePixel = 0
AccentLine.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "NEVAEH PREMIUM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.Parent = MainFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 0.25, 0)
StatusText.BackgroundTransparency = 1
-- Check if we successfully got a link on startup
if KEY_LINK then
    StatusText.Text = "Link copied to clipboard. Awaiting Key..."
    StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
else
    StatusText.Text = "Please wait 5 minutes to generate a new link."
    StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
end
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextSize = 13
StatusText.Parent = MainFrame

local KeyInputBox = Instance.new("TextBox")
KeyInputBox.Size = UDim2.new(0.85, 0, 0, 45)
KeyInputBox.Position = UDim2.new(0.075, 0, 0.42, 0)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInputBox.PlaceholderText = "Paste your authentication key here..."
KeyInputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInputBox.Font = Enum.Font.Gotham
KeyInputBox.TextSize = 14
KeyInputBox.Text = ""
KeyInputBox.ClearTextOnFocus = false
KeyInputBox.Parent = MainFrame

Instance.new("UICorner", KeyInputBox).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(60, 60, 70)
InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InputStroke.Parent = KeyInputBox

-- Buttons Container
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.4, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.72, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 14
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = MainFrame
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.4, 0, 0, 40)
VerifyBtn.Position = UDim2.new(0.525, 0, 0.72, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Text = "Verify"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.AutoButtonColor = false
VerifyBtn.Parent = MainFrame
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 8)

-- ==========================================
-- ANIMATIONS & LOGIC
-- ==========================================
local completionEvent = Instance.new("BindableEvent")
local attempts = 0
local maxAttempts = 5

-- Hover Animations
local function createHoverEffect(button, defaultColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = defaultColor}):Play()
    end)
end

createHoverEffect(GetKeyBtn, Color3.fromRGB(40, 40, 45), Color3.fromRGB(60, 60, 65))
createHoverEffect(VerifyBtn, Color3.fromRGB(120, 80, 255), Color3.fromRGB(140, 100, 255))

-- Input Focus Animation
KeyInputBox.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(120, 80, 255)}):Play()
end)
KeyInputBox.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 70)}):Play()
end)

-- Button Functionality
GetKeyBtn.MouseButton1Click:Connect(function()
    -- Always try to grab a fresh link in case they hit the rate limit earlier
    local freshLink = Junkie.get_key_link()
    
    if freshLink then
        if setclipboard then
            setclipboard(freshLink)
        end
        StatusText.Text = "Link copied to clipboard!"
        StatusText.TextColor3 = Color3.fromRGB(120, 255, 120)
    else
        StatusText.Text = "Rate limited. Please wait 5 minutes."
        StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

VerifyBtn.MouseButton1Click:Connect(function()
    local rawInput = KeyInputBox.Text
    -- Fix the bug where players paste spaces at the beginning or end of the key
    local userKey = rawInput:match("^%s*(.-)%s*$")
    
    if userKey and #userKey > 0 then
        attempts = attempts + 1
        StatusText.Text = "Authenticating..."
        StatusText.TextColor3 = Color3.fromRGB(255, 200, 100)
        
        -- Use Junkie API to validate the cleaned key dynamically
        local validation = Junkie.check_key(userKey)
        
        if validation.valid then
            StatusText.Text = "Access Granted! Loading..."
            StatusText.TextColor3 = Color3.fromRGB(120, 255, 120)
            
            -- Store key globally for external loader
            getgenv().SCRIPT_KEY = userKey
            
            -- Smooth fade out
            local fadeOut = TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1})
            fadeOut:Play()
            fadeOut.Completed:Wait()
            
            ScreenGui:Destroy()
            completionEvent:Fire(true) -- Success
        else
            local errorMsg = validation.message or "Invalid Key"
            StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
            
            if errorMsg == "KEY_EXPIRED" then
                StatusText.Text = "Key expired. Please get a new one."
            elseif errorMsg == "HWID_BANNED" then
                game.Players.LocalPlayer:Kick("You are hardware banned from Nevaeh Premium.")
            elseif errorMsg == "SERVICE_MISMATCH" then
                StatusText.Text = "Invalid key for Nevaeh Premium."
            elseif errorMsg == "HWID_MISMATCH" then
                StatusText.Text = "HWID limit reached."
            else
                StatusText.Text = "Error: " .. errorMsg
            end
            
            -- Shake animation for incorrect key
            local originalPos = MainFrame.Position
            for i = 1, 4 do
                MainFrame.Position = originalPos + UDim2.new(0, (i%2==0 and 10 or -10), 0, 0)
                task.wait(0.05)
            end
            MainFrame.Position = originalPos
            
            if attempts >= maxAttempts then
                StatusText.Text = "Too many failed attempts!"
                task.wait(2)
                ScreenGui:Destroy()
                completionEvent:Fire(false)
            end
        end
    else
        StatusText.Text = "Please enter a valid key."
        StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- Wait for UI completion
local isSuccess = completionEvent.Event:Wait()

-- Load Main Script if successful
if isSuccess then
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download"))()
else
    warn("Nevaeh Premium: Key validation failed.")
end
