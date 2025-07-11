# VXH UI Library - API Reference

Complete API documentation for VXH UI Library.

## Table of Contents

1. [Core Functions](#core-functions)
2. [Window Management](#window-management)
3. [Tab Management](#tab-management)
4. [UI Elements](#ui-elements)
5. [Advanced Features](#advanced-features)
6. [Utilities](#utilities)
7. [Events](#events)

## Core Functions

### `VXH:CreateWindow(config)`

Creates a new VXH window.

**Parameters:**
- `config` (table): Window configuration

**Returns:**
- `Window` object

**Example:**
```lua
local Window = VXH:CreateWindow({
    Name = "My Script Hub",
    LoadingTitle = "VXH Interface Suite",
    LoadingSubtitle = "by Your Name",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyHub",
        FileName = "Config"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key",
        Key = {"MyKey2024"}
    }
})
```

**Configuration Options:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `Name` | string | "VXH Script Hub" | Window title |
| `LoadingTitle` | string | "VXH Interface Suite" | Loading screen title |
| `LoadingSubtitle` | string | "by VXH Team" | Loading screen subtitle |
| `ConfigurationSaving` | table | `{Enabled = false}` | Auto-save configuration |
| `ConfigurationSaving.Enabled` | boolean | false | Enable configuration saving |
| `ConfigurationSaving.FolderName` | string | nil | Folder name for configs |
| `ConfigurationSaving.FileName` | string | nil | Config file name |
| `Discord` | table | `{Enabled = false}` | Discord integration |
| `Discord.Enabled` | boolean | false | Show Discord info |
| `Discord.Invite` | string | nil | Discord invite link |
| `Discord.RememberJoins` | boolean | true | Remember if user joined |
| `KeySystem` | boolean | false | Enable key system |
| `KeySettings` | table | `{}` | Key system configuration |
| `KeySettings.Title` | string | "VXH Key System" | Key system title |
| `KeySettings.Subtitle` | string | "Enter your key to continue" | Key system subtitle |
| `KeySettings.Note` | string | "Get your key from our Discord server" | Key system note |
| `KeySettings.FileName` | string | "VXH_Key" | Key file name |
| `KeySettings.SaveKey` | boolean | true | Save valid keys |
| `KeySettings.GrabKeyFromSite` | boolean | false | Grab key from website |
| `KeySettings.Key` | table | `{"VXH2024"}` | Valid keys |
| `KeySettings.KeyLink` | string | "https://discord.gg/vxh" | Key link |

## Window Management

### `Window:CreateTab(name, icon)`

Creates a new tab in the window.

**Parameters:**
- `name` (string): Tab display name
- `icon` (string): Tab icon (Lucide icon name or asset ID)

**Returns:**
- `Tab` object

**Example:**
```lua
local MainTab = Window:CreateTab("Main", "Home")
local PlayerTab = Window:CreateTab("Player", "User")
```

### `VXH:ToggleWindow(windowName)`

Toggles window visibility.

**Parameters:**
- `windowName` (string): Name of the window

**Example:**
```lua
VXH:ToggleWindow("My Script Hub")
```

### `VXH:DestroyWindow(windowName)`

Destroys a window completely.

**Parameters:**
- `windowName` (string): Name of the window

**Example:**
```lua
VXH:DestroyWindow("My Script Hub")
```

## Tab Management

### `Tab:CreateSection(name)`

Creates a section to organize elements.

**Parameters:**
- `name` (string): Section name

**Example:**
```lua
Tab:CreateSection("Player Features")
```

## UI Elements

### `Tab:CreateButton(config)`

Creates a clickable button.

**Parameters:**
- `config` (table): Button configuration

**Returns:**
- Button element

**Configuration:**
```lua
Tab:CreateButton({
    Name = "Button Name",      -- Required: Button text
    Callback = function()      -- Required: Function to call
        -- Button action
    end
})
```

### `Tab:CreateToggle(config)`

Creates an on/off toggle switch.

**Parameters:**
- `config` (table): Toggle configuration

**Returns:**
- Toggle element

**Configuration:**
```lua
Tab:CreateToggle({
    Name = "Toggle Name",      -- Required: Toggle label
    CurrentValue = false,      -- Optional: Default state (boolean)
    Flag = "ToggleFlag",       -- Optional: Unique identifier
    Callback = function(value) -- Required: Function called with new value
        -- Toggle action
    end
})
```

### `Tab:CreateSlider(config)`

Creates a value slider.

**Parameters:**
- `config` (table): Slider configuration

**Returns:**
- Slider element

**Configuration:**
```lua
Tab:CreateSlider({
    Name = "Slider Name",      -- Required: Slider label
    Range = {1, 100},          -- Required: {min, max} values
    Increment = 1,             -- Optional: Step size (default: 1)
    Suffix = " units",         -- Optional: Text after value
    CurrentValue = 50,         -- Optional: Default value
    Flag = "SliderFlag",       -- Optional: Unique identifier
    Callback = function(value) -- Required: Function called with new value
        -- Slider action
    end
})
```

### `Tab:CreateInput(config)`

Creates a text input field.

**Parameters:**
- `config` (table): Input configuration

**Returns:**
- Input element

**Configuration:**
```lua
Tab:CreateInput({
    Name = "Input Name",               -- Required: Input label
    PlaceholderText = "Enter text",    -- Optional: Placeholder text
    NumbersOnly = false,               -- Optional: Numbers only (boolean)
    OnEnter = false,                   -- Optional: Execute on Enter only (boolean)
    RemoveTextAfterFocusLost = false,  -- Optional: Clear on focus lost (boolean)
    Flag = "InputFlag",                -- Optional: Unique identifier
    Callback = function(text)          -- Required: Function called with text
        -- Input action
    end
})
```

### `Tab:CreateDropdown(config)`

Creates a selection dropdown.

**Parameters:**
- `config` (table): Dropdown configuration

**Returns:**
- Dropdown element

**Configuration:**
```lua
Tab:CreateDropdown({
    Name = "Dropdown Name",            -- Required: Dropdown label
    Options = {"Option 1", "Option 2"}, -- Required: Available options
    CurrentOption = "Option 1",        -- Optional: Default selection
    Flag = "DropdownFlag",             -- Optional: Unique identifier
    Callback = function(option)        -- Required: Function called with selection
        -- Dropdown action
    end
})
```

### `Tab:CreateColorPicker(config)`

Creates a color selection tool.

**Parameters:**
- `config` (table): ColorPicker configuration

**Returns:**
- ColorPicker element

**Configuration:**
```lua
Tab:CreateColorPicker({
    Name = "Color Name",               -- Required: ColorPicker label
    Color = Color3.fromRGB(255, 0, 0), -- Optional: Default color
    Flag = "ColorFlag",                -- Optional: Unique identifier
    Callback = function(color)         -- Required: Function called with Color3
        -- Color action
    end
})
```

### `Tab:CreateKeybind(config)`

Creates a key binding control.

**Parameters:**
- `config` (table): Keybind configuration

**Returns:**
- Keybind element

**Configuration:**
```lua
Tab:CreateKeybind({
    Name = "Keybind Name",       -- Required: Keybind label
    CurrentKeybind = "F",        -- Optional: Default key
    HoldToInteract = false,      -- Optional: Hold vs press (boolean)
    Flag = "KeybindFlag",        -- Optional: Unique identifier
    Callback = function()        -- Required: Function called when activated
        -- Keybind action
    end
})
```

### `Tab:CreateLabel(config)`

Creates an information label.

**Parameters:**
- `config` (table): Label configuration

**Returns:**
- Label element

**Configuration:**
```lua
Tab:CreateLabel({
    Name = "Label Name",         -- Required: Label identifier
    Text = "Information text"    -- Required: Label text content
})
```

## Advanced Features

### `VXH:Notify(config)`

Shows a notification to the user.

**Parameters:**
- `config` (table): Notification configuration

**Configuration:**
```lua
VXH:Notify({
    Title = "Notification Title",      -- Required: Notification title
    Content = "Notification content",  -- Required: Notification message
    Duration = 5,                      -- Optional: Duration in seconds (default: 5)
    Image = "rbxassetid://123456",     -- Optional: Image asset ID
    Actions = {                        -- Optional: Action buttons
        Ignore = {
            Name = "OK",
            Callback = function()
                -- Action callback
            end
        }
    }
})
```

### `VXH:SaveConfiguration(folderName, fileName)`

Saves current configuration.

**Parameters:**
- `folderName` (string): Folder name
- `fileName` (string): File name

**Returns:**
- `boolean`: Success status

**Example:**
```lua
local success = VXH:SaveConfiguration("MyHub", "Config")
if success then
    print("Configuration saved")
end
```

### `VXH:LoadConfiguration(folderName, fileName)`

Loads saved configuration.

**Parameters:**
- `folderName` (string): Folder name
- `fileName` (string): File name

**Returns:**
- `boolean`: Success status

**Example:**
```lua
local loaded = VXH:LoadConfiguration("MyHub", "Config")
if loaded then
    print("Configuration loaded")
end
```

### `VXH:SetTheme(themeName)`

Sets the UI theme.

**Parameters:**
- `themeName` (string): Theme name ("Default", "Dark", "Light", or custom)

**Example:**
```lua
VXH:SetTheme("Dark")
```

### `VXH:CreateKeySystem(config)`

Creates a standalone key system.

**Parameters:**
- `config` (table): Key system configuration

**Returns:**
- `boolean`: Authentication success

**Configuration:**
```lua
local authenticated = VXH:CreateKeySystem({
    Title = "Key System",
    Subtitle = "Enter your key",
    Note = "Get key from Discord",
    FileName = "MyKey",
    SaveKey = true,
    Key = {"ValidKey2024"}
})
```

## Utilities

### `VXH:GetFlag(flagName)`

Gets a flag value.

**Parameters:**
- `flagName` (string): Flag identifier

**Returns:**
- Flag value (any type)

**Example:**
```lua
local walkSpeed = VXH:GetFlag("WalkSpeed")
```

### `VXH:SetFlag(flagName, value)`

Sets a flag value.

**Parameters:**
- `flagName` (string): Flag identifier
- `value` (any): Flag value

**Example:**
```lua
VXH:SetFlag("WalkSpeed", 50)
```

### `VXH:CreateQuickToggle(name, callback)`

Creates a quick toggle (default: Insert key).

**Parameters:**
- `name` (string): Toggle name
- `callback` (function): Toggle callback

**Returns:**
- QuickToggle object

**Example:**
```lua
local quickToggle = VXH:CreateQuickToggle("GUI Toggle", function(value)
    VXH:ToggleWindow("My Hub")
end)
```

### `VXH:CreateCommand(commandName, callback)`

Creates a chat command.

**Parameters:**
- `commandName` (string): Command name (without /)
- `callback` (function): Command callback with args

**Example:**
```lua
VXH:CreateCommand("speed", function(args)
    local speed = tonumber(args[1])
    if speed then
        VXH:SetFlag("WalkSpeed", speed)
    end
end)
```

## Events

### Window Events

```lua
-- Window creation
local Window = VXH:CreateWindow({...})

-- Window destruction
VXH:DestroyWindow("Window Name")

-- Window toggle
VXH:ToggleWindow("Window Name")
```

### Element Events

All UI elements trigger their callback functions when interacted with:

```lua
-- Button click
Tab:CreateButton({
    Callback = function()
        -- Triggered on click
    end
})

-- Toggle change
Tab:CreateToggle({
    Callback = function(value)
        -- Triggered when toggled
        -- value: boolean (true/false)
    end
})

-- Slider change
Tab:CreateSlider({
    Callback = function(value)
        -- Triggered when slider moves
        -- value: number (within range)
    end
})

-- Input text
Tab:CreateInput({
    Callback = function(text)
        -- Triggered when text entered
        -- text: string (input content)
    end
})

-- Dropdown selection
Tab:CreateDropdown({
    Callback = function(option)
        -- Triggered when option selected
        -- option: string (selected option)
    end
})

-- Color change
Tab:CreateColorPicker({
    Callback = function(color)
        -- Triggered when color changes
        -- color: Color3 (selected color)
    end
})

-- Keybind activation
Tab:CreateKeybind({
    Callback = function()
        -- Triggered when key pressed/held
    end
})
```

## Error Handling

### Common Error Patterns

```lua
-- Safe element creation
local success, element = pcall(function()
    return Tab:CreateButton({
        Name = "Test Button",
        Callback = function()
            -- Button logic
        end
    })
end)

if not success then
    warn("Failed to create button: " .. tostring(element))
end

-- Safe configuration loading
local configLoaded = VXH:LoadConfiguration("MyHub", "Config")
if not configLoaded then
    -- Use default configuration
    VXH:SetFlag("WalkSpeed", 16)
    VXH:SetFlag("JumpPower", 50)
end

-- Safe flag access
local walkSpeed = VXH:GetFlag("WalkSpeed") or 16
local jumpPower = VXH:GetFlag("JumpPower") or 50
```

## Performance Considerations

### Best Practices

```lua
-- Use spawn for long-running operations
Tab:CreateToggle({
    Name = "Auto Farm",
    Callback = function(value)
        if value then
            spawn(function()
                while VXH:GetFlag("AutoFarm") do
                    -- Farm logic
                    wait(0.1) -- Prevent lag
                end
            end)
        end
    end
})

-- Clean up connections
local connections = {}

Tab:CreateToggle({
    Name = "Feature",
    Callback = function(value)
        if value then
            connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                -- Feature logic
            end)
        else
            if connections.heartbeat then
                connections.heartbeat:Disconnect()
                connections.heartbeat = nil
            end
        end
    end
})

-- Efficient flag updates
local lastWalkSpeed = nil
Tab:CreateSlider({
    Name = "Walk Speed",
    Callback = function(value)
        if value ~= lastWalkSpeed then
            lastWalkSpeed = value
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})
```

## Version Information

### Current Version: 2.0.0

#### Version History

- **2.0.0**: Enhanced VXH system with advanced features
- **1.0.0**: Initial VXH UI Library release

#### Compatibility

- **Roblox**: All current versions
- **Executors**: Synapse X, KRNL, Script-Ware, and others
- **Games**: Universal compatibility

#### Dependencies

- `Players` service
- `UserInputService` service  
- `TweenService` service
- `RunService` service
- `CoreGui` service
- `HttpService` service (for configuration)

---

*VXH UI Library API Reference - Version 2.0.0*
