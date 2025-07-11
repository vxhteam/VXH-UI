# VXH UI Library - Quick Start Guide

Get up and running with VXH UI Library in just 5 minutes!

## 🚀 Installation

Copy and paste this code to load VXH UI Library:

```lua
local VXH = loadstring(game:HttpGet("https://raw.githubusercontent.com/vxhteam/VXH-UI/refs/heads/main/vxh.lua"))()
```

## 📝 Basic Template

Here's a complete basic script hub template:

```lua
-- Load VXH Library
local VXH = loadstring(game:HttpGet("https://raw.githubusercontent.com/vxhteam/VXH-UI/refs/heads/main/vxh.lua"))()

-- Create Window
local Window = VXH:CreateWindow({
    Name = "My First Script Hub",
    LoadingTitle = "VXH Interface Suite",
    LoadingSubtitle = "by Your Name"
})

-- Create Tab
local Tab = Window:CreateTab("Main", "Home")

-- Add Button
Tab:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Hello from VXH!")
    end
})

-- Add Toggle
Tab:CreateToggle({
    Name = "Cool Feature",
    CurrentValue = false,
    Callback = function(value)
        if value then
            print("Feature enabled!")
        else
            print("Feature disabled!")
        end
    end
})

-- Add Slider
Tab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})
```

## 🎯 Step-by-Step Tutorial

### Step 1: Load the Library
```lua
local VXH = loadstring(game:HttpGet("https://raw.githubusercontent.com/vxhteam/VXH-UI/refs/heads/main/vxh.lua"))()
```

### Step 2: Create a Window
```lua
local Window = VXH:CreateWindow({
    Name = "My Script Hub"
})
```

### Step 3: Add a Tab
```lua
local Tab = Window:CreateTab("Main", "Home")
```

### Step 4: Add Elements
```lua
-- Button
Tab:CreateButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})

-- Toggle
Tab:CreateToggle({
    Name = "Enable Feature",
    CurrentValue = false,
    Callback = function(value)
        print("Toggle: " .. tostring(value))
    end
})

-- Slider
Tab:CreateSlider({
    Name = "Value",
    Range = {1, 100},
    CurrentValue = 50,
    Callback = function(value)
        print("Value: " .. value)
    end
})
```

## 🎮 Player Features Example

```lua
local PlayerTab = Window:CreateTab("Player", "User")

-- Walk Speed
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

-- Jump Power
PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    CurrentValue = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

-- Infinite Jump
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value)
        getgenv().InfiniteJump = value
        -- Add infinite jump logic here
    end
})
```

## 👁️ ESP Example

```lua
local VisualTab = Window:CreateTab("Visuals", "Eye")

VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Callback = function(value)
        if value then
            -- Enable ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.Parent = player.Character
                end
            end
        else
            -- Disable ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("Highlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
})
```

## 🤖 Auto Farm Example

```lua
local FarmTab = Window:CreateTab("Auto Farm", "Bot")

FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(value)
        getgenv().AutoFarm = value
        if value then
            spawn(function()
                while getgenv().AutoFarm do
                    -- Your auto farm logic here
                    print("Farming...")
                    wait(1)
                end
            end)
        end
    end
})
```

## ⚙️ Settings Example

```lua
local SettingsTab = Window:CreateTab("Settings", "Settings")

-- Theme Selector
SettingsTab:CreateDropdown({
    Name = "Theme",
    Options = {"Default", "Dark", "Light"},
    CurrentOption = "Default",
    Callback = function(option)
        VXH:SetTheme(option)
    end
})

-- Save Configuration
SettingsTab:CreateButton({
    Name = "Save Config",
    Callback = function()
        VXH:SaveConfiguration("MyHub", "Config")
        print("Configuration saved!")
    end
})

-- Load Configuration
SettingsTab:CreateButton({
    Name = "Load Config",
    Callback = function()
        if VXH:LoadConfiguration("MyHub", "Config") then
            print("Configuration loaded!")
        else
            print("No saved configuration found")
        end
    end
})
```

## 🔧 Useful Utilities

### Notifications
```lua
VXH:Notify({
    Title = "Success!",
    Content = "Feature enabled successfully",
    Duration = 3
})
```

### Quick GUI Toggle
```lua
VXH:CreateQuickToggle("GUI Toggle", function()
    VXH:ToggleWindow("My Script Hub")
end)
```

### Chat Commands
```lua
VXH:CreateCommand("speed", function(args)
    local speed = tonumber(args[1])
    if speed then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        print("Speed set to: " .. speed)
    end
end)
```

## 📋 Available Elements

| Element | Use Case |
|---------|----------|
| **Button** | One-time actions |
| **Toggle** | On/off features |
| **Slider** | Adjustable values |
| **Input** | Text entry |
| **Dropdown** | Multiple choice |
| **ColorPicker** | Color selection |
| **Keybind** | Key bindings |
| **Label** | Information display |
| **Section** | Organization |

## 🎨 Icons Reference

Popular icons for tabs:

- `"Home"` - Home page
- `"User"` - Player features
- `"Eye"` - Visual features
- `"Sword"` - Combat features
- `"Bot"` - Auto features
- `"Settings"` - Settings
- `"MapPin"` - Teleport
- `"Shield"` - Security

## 🔑 Configuration System

### Enable Auto-Save
```lua
local Window = VXH:CreateWindow({
    Name = "My Hub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyHub",
        FileName = "Config"
    }
})
```

### Use Flags
```lua
-- Create element with flag
Tab:CreateSlider({
    Name = "Walk Speed",
    Flag = "WalkSpeed",
    -- ... other options
})

-- Access flag value later
local speed = VXH:GetFlag("WalkSpeed")
```

## 🔐 Key System

```lua
local Window = VXH:CreateWindow({
    Name = "Protected Hub",
    KeySystem = true,
    KeySettings = {
        Title = "Enter Key",
        Subtitle = "Get key from Discord",
        Key = {"MySecretKey2024"}
    }
})
```

## 🐛 Common Issues

### GUI Not Showing
- Make sure you're in a compatible executor
- Check if the script URL is correct
- Ensure you have CoreGui access

### Elements Not Working
- Check your callback functions
- Look for error messages in console (F9)
- Make sure you're using the correct syntax

### Configuration Not Saving
- Enable configuration saving in window creation
- Check folder and file names
- Ensure you have write permissions

## 📚 Next Steps

1. **Read the [Complete Tutorial](TUTORIAL.md)** for detailed explanations
2. **Check out [Examples](../examples/)** for more complex script hubs  
3. **Explore the [API Reference](API.md)** for all available functions
4. **Join our [Discord](https://discord.gg/vxh)** for help and updates

## 🎉 You're Ready!

Congratulations! You now know the basics of VXH UI Library. Start building your own script hub and join the VXH community!

---

*Need help? Join our [Discord server](https://discord.gg/vxh) for support!*
