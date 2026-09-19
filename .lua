-- Load library
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Nevaeh Free"
Junkie.identifier = "12345" 
Junkie.provider = "Eclipse"

-- GUI Implementation
local function showUI()
    -- Get key link first
    local link = Junkie.get_key_link()
    if link then
        setclipboard(link) 
        print("Link copied to clipboard!")
    else
        warn("Wait 5 minutes before generating a new link.")
        return nil
    end

    -- Create UI
    local CoreGui = game:GetService("CoreGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "JunkieAuthGUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 180)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = "🔑 Authentication Required"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = MainFrame

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 0, 20)
    StatusText.Position = UDim2.new(0, 0, 0.25, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Key link has been copied to your clipboard!"
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 12
    StatusText.TextColor3 = Color3.fromRGB(150, 255, 150)
    StatusText.Parent = MainFrame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(0.9, 0, 0, 35)
    KeyInput.Position = UDim2.new(0.05, 0, 0.45, 0)
    KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.PlaceholderText = "Paste your key here..."
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextSize = 14
    KeyInput.Text = ""
    KeyInput.Parent = MainFrame
    Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 5)

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.42, 0, 0, 35)
    SubmitBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Text = "Verify Key"
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 14
    SubmitBtn.Parent = MainFrame
    Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 5)

    local CopyLinkBtn = Instance.new("TextButton")
    CopyLinkBtn.Size = UDim2.new(0.42, 0, 0, 35)
    CopyLinkBtn.Position = UDim2.new(0.53, 0, 0.7, 0)
    CopyLinkBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 160)
    CopyLinkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyLinkBtn.Text = "Copy Link Again"
    CopyLinkBtn.Font = Enum.Font.GothamBold
    CopyLinkBtn.TextSize = 14
    CopyLinkBtn.Parent = MainFrame
    Instance.new("UICorner", CopyLinkBtn).CornerRadius = UDim.new(0, 5)

    -- Yielding mechanism to pause the script until the user finishes
    local completionEvent = Instance.new("BindableEvent")

    -- Button Logic
    CopyLinkBtn.MouseButton1Click:Connect(function()
        if link then
            setclipboard(link)
            StatusText.Text = "Link copied to clipboard!"
            StatusText.TextColor3 = Color3.fromRGB(150, 255, 150)
        end
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userKey = KeyInput.Text
        if userKey and userKey ~= "" then
            StatusText.Text = "Checking key..."
            StatusText.TextColor3 = Color3.fromRGB(255, 255, 150)
            
            local validation = Junkie.check_key(userKey)
            
            if validation.valid then
                StatusText.Text = "Key Valid! Loading script..."
                StatusText.TextColor3 = Color3.fromRGB(150, 255, 150)
                task.wait(1)
                ScreenGui:Destroy()
                completionEvent:Fire(userKey) -- Pass the key and resume the script
            else
                StatusText.Text = "Error: " .. tostring(validation.error or "Invalid key")
                StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        else
            StatusText.Text = "Please enter a key first!"
            StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Wait here until completionEvent is fired
    return completionEvent.Event:Wait()
end

-- Run the UI and wait for the validated key
local validatedKey = showUI()

if not validatedKey then
    warn("No valid key provided. Script terminated.")
    return
end

-- Store key globally for Junkie script to use
getgenv().SCRIPT_KEY = validatedKey

print("Authentication successful. Loading main script...")

-- Place the loadstring for your actual main script below this line
-- Example: loadstring(game:HttpGet("YOUR_MAIN_SCRIPT_URL"))()
