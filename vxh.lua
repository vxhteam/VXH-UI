--[[
    VXH Enhanced Framework v3.0.0 - Professional Edition
    
    🚀 MASSIVE ENHANCEMENT OVER v2.0.0:
    - Upgraded from 4 to 8 advanced components
    - Expanded from 1 to 6 professional themes
    - Added enterprise configuration management
    - Implemented statistics tracking and analytics
    - Enhanced event system with custom callbacks
    - Added auto-save and theme persistence
    - Professional loading screens and transitions
    - Comprehensive error handling and debugging
    - Mobile optimization and accessibility features
    - Performance monitoring and memory tracking
    
    Enhanced by: VXH Enhanced Team
    License: MIT
    GitHub: https://github.com/vxhteam/VXH-Enhanced
    
    PROFESSIONAL FEATURES:
    ✓ Advanced UI components with smooth animations
    ✓ Multiple professional themes with real-time switching
    ✓ Configuration auto-save and persistence
    ✓ Statistics tracking and performance monitoring
    ✓ Event system for advanced scripting
    ✓ Mobile-responsive design
    ✓ Anti-detection and security features
    ✓ Comprehensive error handling
    ✓ Debug tools and memory tracking
    ✓ Loading screens and professional UX
]]

-- ========================================
-- CORE VXH ENHANCED OBJECT v3.0.0
-- ========================================
local VXH = {
    Version = "3.0.0",
    Flags = {},
    Themes = {},
    Windows = {},
    IsToggled = false,
    
    -- Enhanced features
    Build = "2025.01.13",
    Author = "VXH Enhanced Team",
    License = "MIT",
    
    -- Professional configuration
    Configuration = {
        DefaultTheme = "discord",
        AnimationSpeed = 0.25,
        SoundEnabled = true,
        SaveConfiguration = true,
        AntiDetection = false,
        MobileSupport = true,
        DiscordIntegration = false,
        KeySystemEnabled = false,
        LoadingScreenEnabled = true,
        NotificationsEnabled = true,
        PerformanceMode = false,
        AccessibilityMode = false,
        DebugMode = false,
        GlobalToggleKey = Enum.KeyCode.Insert,
        AutoSaveInterval = 30
    },
    
    -- Statistics tracking
    Stats = {
        WindowsCreated = 0,
        ComponentsCreated = 0,
        ThemesLoaded = 0,
        NotificationsSent = 0,
        SessionStartTime = tick(),
        TotalInteractions = 0,
        Performance = {
            AverageFrameTime = 0,
            MemoryUsage = 0,
            CPUUsage = 0
        }
    },
    
    -- Event system
    Events = {
        WindowCreated = {},
        WindowDestroyed = {},
        ThemeChanged = {},
        ToggleChanged = {},
        ComponentCreated = {},
        ConfigurationChanged = {}
    },
    
    -- State management
    State = {
        IsInitialized = false,
        CurrentTheme = "discord",
        LastSaveTime = 0,
        ActiveWindows = {},
        KeyBinds = {},
        CustomThemes = {}
    }
}

-- ========================================
-- ENHANCED SERVICES MANAGEMENT
-- ========================================
local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    HttpService = game:GetService("HttpService"),
    SoundService = game:GetService("SoundService"),
    Lighting = game:GetService("Lighting"),
    GuiService = game:GetService("GuiService"),
    TextService = game:GetService("TextService"),
    MarketplaceService = game:GetService("MarketplaceService"),
    StarterGui = game:GetService("StarterGui"),
    
    LocalPlayer = nil,
    Mouse = nil,
    Camera = nil,
    IsInitialized = false
}

function Services:Initialize()
    if self.IsInitialized then return end
    
    self.LocalPlayer = self.Players.LocalPlayer
    if self.LocalPlayer then
        self.Mouse = self.LocalPlayer:GetMouse()
    end
    self.Camera = workspace.CurrentCamera
    
    self.IsInitialized = true
end

-- ========================================
-- PROFESSIONAL THEME SYSTEM (6 THEMES)
-- ========================================
local Themes = {
    Themes = {
        discord = {
            Name = "Discord",
            Colors = {
                Primary = Color3.fromRGB(88, 101, 242),
                Secondary = Color3.fromRGB(114, 137, 218),
                Tertiary = Color3.fromRGB(139, 92, 246),
                Background = Color3.fromRGB(32, 34, 37),
                Card = Color3.fromRGB(47, 49, 54),
                Sidebar = Color3.fromRGB(40, 43, 48),
                Surface = Color3.fromRGB(54, 57, 63),
                Text = Color3.fromRGB(255, 255, 255),
                TextSecondary = Color3.fromRGB(181, 186, 193),
                TextMuted = Color3.fromRGB(114, 118, 125),
                TextDisabled = Color3.fromRGB(79, 84, 92),
                Success = Color3.fromRGB(87, 242, 135),
                Warning = Color3.fromRGB(255, 202, 40),
                Error = Color3.fromRGB(237, 66, 69),
                Info = Color3.fromRGB(0, 176, 255),
                Border = Color3.fromRGB(79, 84, 92),
                Hover = Color3.fromRGB(64, 68, 75),
                Active = Color3.fromRGB(88, 101, 242),
                Focus = Color3.fromRGB(114, 137, 218)
            }
        },
        
        cyberpunk = {
            Name = "Cyberpunk",
            Colors = {
                Primary = Color3.fromRGB(0, 255, 255),
                Secondary = Color3.fromRGB(255, 0, 255),
                Tertiary = Color3.fromRGB(255, 255, 0),
                Background = Color3.fromRGB(15, 15, 23),
                Card = Color3.fromRGB(25, 25, 35),
                Sidebar = Color3.fromRGB(20, 20, 30),
                Surface = Color3.fromRGB(30, 30, 40),
                Text = Color3.fromRGB(0, 255, 255),
                TextSecondary = Color3.fromRGB(255, 255, 255),
                TextMuted = Color3.fromRGB(150, 150, 150),
                TextDisabled = Color3.fromRGB(100, 100, 100),
                Success = Color3.fromRGB(0, 255, 0),
                Warning = Color3.fromRGB(255, 255, 0),
                Error = Color3.fromRGB(255, 0, 0),
                Info = Color3.fromRGB(0, 255, 255),
                Border = Color3.fromRGB(0, 255, 255),
                Hover = Color3.fromRGB(40, 40, 50),
                Active = Color3.fromRGB(0, 255, 255),
                Focus = Color3.fromRGB(255, 0, 255)
            }
        },
        
        dark = {
            Name = "Dark",
            Colors = {
                Primary = Color3.fromRGB(106, 90, 205),
                Secondary = Color3.fromRGB(138, 43, 226),
                Tertiary = Color3.fromRGB(75, 0, 130),
                Background = Color3.fromRGB(20, 20, 20),
                Card = Color3.fromRGB(30, 30, 30),
                Sidebar = Color3.fromRGB(25, 25, 25),
                Surface = Color3.fromRGB(35, 35, 35),
                Text = Color3.fromRGB(255, 255, 255),
                TextSecondary = Color3.fromRGB(200, 200, 200),
                TextMuted = Color3.fromRGB(150, 150, 150),
                TextDisabled = Color3.fromRGB(100, 100, 100),
                Success = Color3.fromRGB(76, 175, 80),
                Warning = Color3.fromRGB(255, 193, 7),
                Error = Color3.fromRGB(244, 67, 54),
                Info = Color3.fromRGB(33, 150, 243),
                Border = Color3.fromRGB(60, 60, 60),
                Hover = Color3.fromRGB(45, 45, 45),
                Active = Color3.fromRGB(106, 90, 205),
                Focus = Color3.fromRGB(138, 43, 226)
            }
        },
        
        light = {
            Name = "Light",
            Colors = {
                Primary = Color3.fromRGB(33, 150, 243),
                Secondary = Color3.fromRGB(63, 81, 181),
                Tertiary = Color3.fromRGB(103, 58, 183),
                Background = Color3.fromRGB(250, 250, 250),
                Card = Color3.fromRGB(255, 255, 255),
                Sidebar = Color3.fromRGB(245, 245, 245),
                Surface = Color3.fromRGB(240, 240, 240),
                Text = Color3.fromRGB(33, 33, 33),
                TextSecondary = Color3.fromRGB(117, 117, 117),
                TextMuted = Color3.fromRGB(158, 158, 158),
                TextDisabled = Color3.fromRGB(189, 189, 189),
                Success = Color3.fromRGB(76, 175, 80),
                Warning = Color3.fromRGB(255, 193, 7),
                Error = Color3.fromRGB(244, 67, 54),
                Info = Color3.fromRGB(33, 150, 243),
                Border = Color3.fromRGB(224, 224, 224),
                Hover = Color3.fromRGB(245, 245, 245),
                Active = Color3.fromRGB(33, 150, 243),
                Focus = Color3.fromRGB(63, 81, 181)
            }
        },
        
        ocean = {
            Name = "Ocean",
            Colors = {
                Primary = Color3.fromRGB(0, 123, 192),
                Secondary = Color3.fromRGB(0, 188, 212),
                Tertiary = Color3.fromRGB(0, 150, 136),
                Background = Color3.fromRGB(13, 39, 51),
                Card = Color3.fromRGB(21, 53, 66),
                Sidebar = Color3.fromRGB(17, 46, 58),
                Surface = Color3.fromRGB(25, 60, 75),
                Text = Color3.fromRGB(224, 247, 250),
                TextSecondary = Color3.fromRGB(178, 223, 219),
                TextMuted = Color3.fromRGB(120, 144, 156),
                TextDisabled = Color3.fromRGB(84, 110, 122),
                Success = Color3.fromRGB(102, 187, 106),
                Warning = Color3.fromRGB(255, 183, 77),
                Error = Color3.fromRGB(239, 83, 80),
                Info = Color3.fromRGB(41, 182, 246),
                Border = Color3.fromRGB(55, 71, 79),
                Hover = Color3.fromRGB(29, 74, 90),
                Active = Color3.fromRGB(0, 123, 192),
                Focus = Color3.fromRGB(0, 188, 212)
            }
        },
        
        forest = {
            Name = "Forest",
            Colors = {
                Primary = Color3.fromRGB(76, 175, 80),
                Secondary = Color3.fromRGB(139, 195, 74),
                Tertiary = Color3.fromRGB(102, 187, 106),
                Background = Color3.fromRGB(27, 40, 27),
                Card = Color3.fromRGB(46, 66, 46),
                Sidebar = Color3.fromRGB(36, 53, 36),
                Surface = Color3.fromRGB(56, 76, 56),
                Text = Color3.fromRGB(232, 245, 233),
                TextSecondary = Color3.fromRGB(200, 230, 201),
                TextMuted = Color3.fromRGB(129, 199, 132),
                TextDisabled = Color3.fromRGB(102, 187, 106),
                Success = Color3.fromRGB(129, 199, 132),
                Warning = Color3.fromRGB(255, 183, 77),
                Error = Color3.fromRGB(229, 115, 115),
                Info = Color3.fromRGB(79, 195, 247),
                Border = Color3.fromRGB(102, 187, 106),
                Hover = Color3.fromRGB(66, 86, 66),
                Active = Color3.fromRGB(76, 175, 80),
                Focus = Color3.fromRGB(139, 195, 74)
            }
        }
    },
    
    CurrentTheme = "discord",
    IsInitialized = false
}

function Themes:Initialize()
    if self.IsInitialized then return end
    self.IsInitialized = true
end

function Themes:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = themeName
        return true
    end
    return false
end

function Themes:GetCurrent()
    return self.Themes[self.CurrentTheme]
end

function Themes:GetThemeNames()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    return names
end

-- ========================================
-- ENHANCED UTILITY FUNCTIONS
-- ========================================
local Utils = {
    IsInitialized = false
}

function Utils:Initialize()
    if self.IsInitialized then return end
    self.IsInitialized = true
end

function Utils:MergeTables(target, source)
    for key, value in pairs(source) do
        if type(value) == "table" and type(target[key]) == "table" then
            self:MergeTables(target[key], value)
        else
            target[key] = value
        end
    end
    return target
end

function Utils:GenerateId()
    return Services.HttpService:GenerateGUID(false):sub(1, 8)
end

function Utils:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

function Utils:CreateStroke(parent, thickness, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or Color3.fromRGB(79, 84, 92)
    stroke.Transparency = transparency or 0
    stroke.Parent = parent
    return stroke
end

function Utils:CreateShadow(parent, size, transparency)
    size = size or 6
    transparency = transparency or 0.5
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = transparency
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, size * 2, 1, size * 2)
    shadow.Position = UDim2.new(0, -size, 0, -size)
    shadow.ZIndex = (parent.ZIndex or 1) - 1
    shadow.Parent = parent
    
    return shadow
end

function Utils:CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

function Utils:PlaySound(soundId, volume, pitch)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId or "rbxasset://sounds/electronicpingshort.wav"
        sound.Volume = volume or 0.3
        sound.Pitch = pitch or 1
        sound.Parent = Services.SoundService
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end

function Utils:TableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-- ========================================
-- ENHANCED ANIMATION SYSTEM
-- ========================================
local Animations = {
    IsInitialized = false
}

function Animations:Initialize()
    if self.IsInitialized then return end
    self.IsInitialized = true
end

function Animations:Tween(object, properties, duration, style, direction, callback)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    
    local tween = Services.TweenService:Create(object, tweenInfo, properties)
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    tween:Play()
    return tween
end

function Animations:FadeIn(object, duration, callback)
    return self:Tween(object, {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }, duration, nil, nil, callback)
end

function Animations:FadeOut(object, duration, callback)
    return self:Tween(object, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    }, duration, nil, nil, callback)
end

function Animations:SlideIn(object, startPosition, endPosition, duration, callback)
    object.Position = startPosition
    return self:Tween(object, {Position = endPosition}, duration, nil, nil, callback)
end

function Animations:Bounce(object, scale, duration)
    local originalSize = object.Size
    local bounceSize = UDim2.new(originalSize.X.Scale * scale, originalSize.X.Offset, originalSize.Y.Scale * scale, originalSize.Y.Offset)
    
    self:Tween(object, {Size = bounceSize}, duration / 2)
    wait(duration / 2)
    self:Tween(object, {Size = originalSize}, duration / 2)
end

-- ========================================
-- PROFESSIONAL NOTIFICATION SYSTEM
-- ========================================
local Notifications = {
    Queue = {},
    ActiveNotifications = {},
    MaxNotifications = 5,
    IsInitialized = false
}

function Notifications:Initialize()
    if self.IsInitialized then return end
    self.IsInitialized = true
end

function Notifications:Create(config)
    config = config or {}
    
    local notification = {
        Title = config.Title or "Notification",
        Text = config.Text or "This is a notification",
        Type = config.Type or "info", -- info, success, warning, error
        Duration = config.Duration or 5,
        Position = config.Position or "TopRight"
    }
    
    if #self.ActiveNotifications >= self.MaxNotifications then
        table.insert(self.Queue, notification)
    else
        self:ShowNotification(notification)
    end
    
    return notification
end

function Notifications:ShowNotification(notification)
    local theme = Themes:GetCurrent()
    
    -- Create notification GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VXH_Notification_" .. Utils:GenerateId()
    screenGui.Parent = Services.CoreGui
    screenGui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Name = "NotificationFrame"
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 0, 20 + (#self.ActiveNotifications * 90))
    frame.BackgroundColor3 = theme.Colors.Card
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    Utils:CreateCorner(frame, 8)
    Utils:CreateStroke(frame, 1, theme.Colors.Border, 0.3)
    Utils:CreateShadow(frame, 8, 0.5)
    
    -- Type indicator
    local typeColor = theme.Colors.Info
    if notification.Type == "success" then
        typeColor = theme.Colors.Success
    elseif notification.Type == "warning" then
        typeColor = theme.Colors.Warning
    elseif notification.Type == "error" then
        typeColor = theme.Colors.Error
    end
    
    local indicator = Instance.new("Frame")
    indicator.Name = "TypeIndicator"
    indicator.Size = UDim2.new(0, 4, 1, 0)
    indicator.Position = UDim2.new(0, 0, 0, 0)
    indicator.BackgroundColor3 = typeColor
    indicator.BorderSizePixel = 0
    indicator.Parent = frame
    
    Utils:CreateCorner(indicator, 4)
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 25)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = notification.Title
    title.TextColor3 = theme.Colors.Text
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    -- Text
    local text = Instance.new("TextLabel")
    text.Name = "Text"
    text.Size = UDim2.new(1, -20, 0, 45)
    text.Position = UDim2.new(0, 15, 0, 25)
    text.BackgroundTransparency = 1
    text.Text = notification.Text
    text.TextColor3 = theme.Colors.TextSecondary
    text.TextSize = 12
    text.Font = Enum.Font.Gotham
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.TextWrapped = true
    text.Parent = frame
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 5)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = theme.Colors.TextMuted
    closeButton.TextSize = 16
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = frame
    
    -- Animations
    frame.Position = UDim2.new(1, 0, 0, 20 + (#self.ActiveNotifications * 90))
    Animations:Tween(frame, {Position = UDim2.new(1, -320, 0, 20 + (#self.ActiveNotifications * 90))}, 0.3)
    
    -- Add to active notifications
    table.insert(self.ActiveNotifications, {frame = frame, screenGui = screenGui})
    
    -- Auto-remove after duration
    Services.Debris:AddItem(screenGui, notification.Duration)
    
    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        self:RemoveNotification(screenGui)
    end)
    
    -- Remove from active notifications after duration
    spawn(function()
        wait(notification.Duration)
        self:RemoveNotification(screenGui)
    end)
end

function Notifications:RemoveNotification(screenGui)
    for i, notification in ipairs(self.ActiveNotifications) do
        if notification.screenGui == screenGui then
            table.remove(self.ActiveNotifications, i)
            break
        end
    end
    
    if screenGui and screenGui.Parent then
        screenGui:Destroy()
    end
    
    -- Show next notification from queue
    if #self.Queue > 0 then
        local nextNotification = table.remove(self.Queue, 1)
        self:ShowNotification(nextNotification)
    end
end

-- ========================================
-- ENHANCED COMPONENT SYSTEM (8 COMPONENTS)
-- ========================================

-- Button Component
local Button = {}
Button.__index = Button

function Button:Create(config, parent)
    local self = setmetatable({}, Button)
    
    self.Config = Utils:MergeTables({
        Name = "Button",
        Text = "Button",
        Description = nil,
        Callback = function() end,
        Enabled = true,
        Visible = true,
        Flag = nil,
        Size = UDim2.new(1, -20, 0, 36)
    }, config or {})
    
    self.Parent = parent
    self.Tab = parent
    self.Window = parent.Window
    
    self.State = {
        IsHovered = false,
        IsPressed = false,
        IsEnabled = self.Config.Enabled,
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    VXH:FireEvent("ComponentCreated", self)
    
    return self
end

function Button:CreateUI()
    local theme = Themes:GetCurrent()
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Button_" .. self.Config.Name
    self.Container.Size = self.Config.Size
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 15
    self.Container.Parent = self.Tab.TabContent
    
    self.ButtonFrame = Instance.new("TextButton")
    self.ButtonFrame.Name = "ButtonFrame"
    self.ButtonFrame.Size = UDim2.new(1, 0, 1, 0)
    self.ButtonFrame.Position = UDim2.new(0, 0, 0, 0)
    self.ButtonFrame.BackgroundColor3 = theme.Colors.Primary
    self.ButtonFrame.BorderSizePixel = 0
    self.ButtonFrame.Text = ""
    self.ButtonFrame.ZIndex = 16
    self.ButtonFrame.Parent = self.Container
    
    Utils:CreateCorner(self.ButtonFrame, 8)
    Utils:CreateStroke(self.ButtonFrame, 1, theme.Colors.Border, 0.3)
    
    self.ButtonText = Instance.new("TextLabel")
    self.ButtonText.Name = "ButtonText"
    self.ButtonText.Size = UDim2.new(1, -20, 1, 0)
    self.ButtonText.Position = UDim2.new(0, 10, 0, 0)
    self.ButtonText.BackgroundTransparency = 1
    self.ButtonText.Text = self.Config.Text
    self.ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.ButtonText.TextSize = 14
    self.ButtonText.Font = Enum.Font.GothamBold
    self.ButtonText.ZIndex = 17
    self.ButtonText.Parent = self.ButtonFrame
end

function Button:SetupEventHandlers()
    local theme = Themes:GetCurrent()
    
    self.State.Connections[#self.State.Connections + 1] = self.ButtonFrame.MouseButton1Click:Connect(function()
        if not self.State.IsEnabled then return end
        
        Animations:Bounce(self.ButtonFrame, 0.95, 0.2)
        Utils:PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.5)
        
        VXH.Stats.TotalInteractions = VXH.Stats.TotalInteractions + 1
        
        if self.Config.Callback then
            local success, result = pcall(self.Config.Callback)
            if not success then
                warn("[VXH Enhanced] Button callback error: " .. tostring(result))
            end
        end
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.ButtonFrame.MouseEnter:Connect(function()
        if not self.State.IsEnabled then return end
        
        self.State.IsHovered = true
        Animations:Tween(self.ButtonFrame, {BackgroundColor3 = theme.Colors.Secondary}, 0.15)
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.ButtonFrame.MouseLeave:Connect(function()
        self.State.IsHovered = false
        Animations:Tween(self.ButtonFrame, {BackgroundColor3 = theme.Colors.Primary}, 0.15)
    end)
end

-- Toggle Component
local Toggle = {}
Toggle.__index = Toggle

function Toggle:Create(config, parent)
    local self = setmetatable({}, Toggle)
    
    self.Config = Utils:MergeTables({
        Name = "Toggle",
        Text = "Toggle",
        Description = nil,
        CurrentValue = false,
        Callback = function(value) end,
        Enabled = true,
        Visible = true,
        Flag = nil,
        Size = UDim2.new(1, -20, 0, 36)
    }, config or {})
    
    self.Parent = parent
    self.Tab = parent
    self.Window = parent.Window
    
    self.State = {
        IsHovered = false,
        IsEnabled = self.Config.Enabled,
        CurrentValue = self.Config.CurrentValue,
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    self:SetValue(self.Config.CurrentValue, false)
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    VXH:FireEvent("ComponentCreated", self)
    
    return self
end

function Toggle:CreateUI()
    local theme = Themes:GetCurrent()
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Toggle_" .. self.Config.Name
    self.Container.Size = self.Config.Size
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 15
    self.Container.Parent = self.Tab.TabContent
    
    self.ToggleFrame = Instance.new("TextButton")
    self.ToggleFrame.Name = "ToggleFrame"
    self.ToggleFrame.Size = UDim2.new(1, 0, 1, 0)
    self.ToggleFrame.Position = UDim2.new(0, 0, 0, 0)
    self.ToggleFrame.BackgroundColor3 = theme.Colors.Card
    self.ToggleFrame.BorderSizePixel = 0
    self.ToggleFrame.Text = ""
    self.ToggleFrame.ZIndex = 16
    self.ToggleFrame.Parent = self.Container
    
    Utils:CreateCorner(self.ToggleFrame, 8)
    Utils:CreateStroke(self.ToggleFrame, 1, theme.Colors.Border, 0.3)
    
    self.ToggleLabel = Instance.new("TextLabel")
    self.ToggleLabel.Name = "ToggleLabel"
    self.ToggleLabel.Size = UDim2.new(1, -80, 1, 0)
    self.ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
    self.ToggleLabel.BackgroundTransparency = 1
    self.ToggleLabel.Text = self.Config.Text
    self.ToggleLabel.TextColor3 = theme.Colors.Text
    self.ToggleLabel.TextSize = 14
    self.ToggleLabel.Font = Enum.Font.Gotham
    self.ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ToggleLabel.ZIndex = 17
    self.ToggleLabel.Parent = self.ToggleFrame
    
    self.ToggleSwitch = Instance.new("Frame")
    self.ToggleSwitch.Name = "ToggleSwitch"
    self.ToggleSwitch.Size = UDim2.new(0, 46, 0, 24)
    self.ToggleSwitch.Position = UDim2.new(1, -58, 0.5, -12)
    self.ToggleSwitch.BackgroundColor3 = theme.Colors.Border
    self.ToggleSwitch.BorderSizePixel = 0
    self.ToggleSwitch.ZIndex = 17
    self.ToggleSwitch.Parent = self.ToggleFrame
    
    Utils:CreateCorner(self.ToggleSwitch, 12)
    
    self.ToggleKnob = Instance.new("Frame")
    self.ToggleKnob.Name = "ToggleKnob"
    self.ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
    self.ToggleKnob.Position = UDim2.new(0, 3, 0.5, -9)
    self.ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.ToggleKnob.BorderSizePixel = 0
    self.ToggleKnob.ZIndex = 18
    self.ToggleKnob.Parent = self.ToggleSwitch
    
    Utils:CreateCorner(self.ToggleKnob, 9)
    Utils:CreateShadow(self.ToggleKnob, 2, 0.3)
end

function Toggle:SetupEventHandlers()
    self.State.Connections[#self.State.Connections + 1] = self.ToggleFrame.MouseButton1Click:Connect(function()
        if not self.State.IsEnabled then return end
        
        self:SetValue(not self.State.CurrentValue, true)
        Utils:PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.3)
        VXH.Stats.TotalInteractions = VXH.Stats.TotalInteractions + 1
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.ToggleFrame.MouseEnter:Connect(function()
        if not self.State.IsEnabled then return end
        
        self.State.IsHovered = true
        local theme = Themes:GetCurrent()
        Animations:Tween(self.ToggleFrame, {BackgroundColor3 = theme.Colors.Hover}, 0.15)
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.ToggleFrame.MouseLeave:Connect(function()
        self.State.IsHovered = false
        local theme = Themes:GetCurrent()
        Animations:Tween(self.ToggleFrame, {BackgroundColor3 = theme.Colors.Card}, 0.15)
    end)
end

function Toggle:SetValue(value, runCallback)
    runCallback = runCallback ~= false
    
    self.State.CurrentValue = value
    local theme = Themes:GetCurrent()
    
    if value then
        Animations:Tween(self.ToggleKnob, {Position = UDim2.new(0, 25, 0.5, -9)}, 0.2)
        Animations:Tween(self.ToggleSwitch, {BackgroundColor3 = theme.Colors.Primary}, 0.2)
    else
        Animations:Tween(self.ToggleKnob, {Position = UDim2.new(0, 3, 0.5, -9)}, 0.2)
        Animations:Tween(self.ToggleSwitch, {BackgroundColor3 = theme.Colors.Border}, 0.2)
    end
    
    if self.Config.Flag then
        self.Window:SetFlag(self.Config.Flag, value)
    end
    
    if runCallback and self.Config.Callback then
        local success, result = pcall(self.Config.Callback, value)
        if not success then
            warn("[VXH Enhanced] Toggle callback error: " .. tostring(result))
        end
    end
end

-- Slider Component (NEW)
local Slider = {}
Slider.__index = Slider

function Slider:Create(config, parent)
    local self = setmetatable({}, Slider)
    
    self.Config = Utils:MergeTables({
        Name = "Slider",
        Text = "Slider",
        Description = nil,
        Min = 0,
        Max = 100,
        Default = 50,
        CurrentValue = 50,
        Increment = 1,
        Suffix = "",
        Callback = function(value) end,
        Enabled = true,
        Visible = true,
        Flag = nil,
        Size = UDim2.new(1, -20, 0, 36)
    }, config or {})
    
    self.Parent = parent
    self.Tab = parent
    self.Window = parent.Window
    
    self.State = {
        IsHovered = false,
        IsDragging = false,
        IsEnabled = self.Config.Enabled,
        CurrentValue = self.Config.CurrentValue,
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    self:SetValue(self.Config.CurrentValue, false)
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    VXH:FireEvent("ComponentCreated", self)
    
    return self
end

function Slider:CreateUI()
    local theme = Themes:GetCurrent()
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Slider_" .. self.Config.Name
    self.Container.Size = self.Config.Size
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 15
    self.Container.Parent = self.Tab.TabContent
    
    self.SliderFrame = Instance.new("Frame")
    self.SliderFrame.Name = "SliderFrame"
    self.SliderFrame.Size = UDim2.new(1, 0, 1, 0)
    self.SliderFrame.Position = UDim2.new(0, 0, 0, 0)
    self.SliderFrame.BackgroundColor3 = theme.Colors.Card
    self.SliderFrame.BorderSizePixel = 0
    self.SliderFrame.ZIndex = 16
    self.SliderFrame.Parent = self.Container
    
    Utils:CreateCorner(self.SliderFrame, 8)
    Utils:CreateStroke(self.SliderFrame, 1, theme.Colors.Border, 0.3)
    
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "Label"
    self.Label.Size = UDim2.new(0.5, -10, 1, 0)
    self.Label.Position = UDim2.new(0, 12, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Config.Text
    self.Label.TextColor3 = theme.Colors.Text
    self.Label.TextSize = 14
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.ZIndex = 17
    self.Label.Parent = self.SliderFrame
    
    self.ValueLabel = Instance.new("TextLabel")
    self.ValueLabel.Name = "ValueLabel"
    self.ValueLabel.Size = UDim2.new(0, 60, 1, 0)
    self.ValueLabel.Position = UDim2.new(1, -70, 0, 0)
    self.ValueLabel.BackgroundTransparency = 1
    self.ValueLabel.Text = tostring(self.Config.CurrentValue) .. self.Config.Suffix
    self.ValueLabel.TextColor3 = theme.Colors.TextSecondary
    self.ValueLabel.TextSize = 12
    self.ValueLabel.Font = Enum.Font.Gotham
    self.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.ValueLabel.ZIndex = 17
    self.ValueLabel.Parent = self.SliderFrame
    
    self.Track = Instance.new("Frame")
    self.Track.Name = "Track"
    self.Track.Size = UDim2.new(0.4, -20, 0, 6)
    self.Track.Position = UDim2.new(0.5, 10, 0.5, -3)
    self.Track.BackgroundColor3 = theme.Colors.Border
    self.Track.BorderSizePixel = 0
    self.Track.ZIndex = 17
    self.Track.Parent = self.SliderFrame
    
    Utils:CreateCorner(self.Track, 3)
    
    self.Fill = Instance.new("Frame")
    self.Fill.Name = "Fill"
    self.Fill.Size = UDim2.new(0.5, 0, 1, 0)
    self.Fill.Position = UDim2.new(0, 0, 0, 0)
    self.Fill.BackgroundColor3 = theme.Colors.Primary
    self.Fill.BorderSizePixel = 0
    self.Fill.ZIndex = 18
    self.Fill.Parent = self.Track
    
    Utils:CreateCorner(self.Fill, 3)
    
    self.Thumb = Instance.new("Frame")
    self.Thumb.Name = "Thumb"
    self.Thumb.Size = UDim2.new(0, 16, 0, 16)
    self.Thumb.Position = UDim2.new(0.5, -8, 0.5, -8)
    self.Thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.Thumb.BorderSizePixel = 0
    self.Thumb.ZIndex = 19
    self.Thumb.Parent = self.Track
    
    Utils:CreateCorner(self.Thumb, 8)
    Utils:CreateShadow(self.Thumb, 4, 0.3)
end

function Slider:SetupEventHandlers()
    local dragging = false
    
    self.State.Connections[#self.State.Connections + 1] = self.Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            self.State.IsDragging = true
            self:UpdateSlider(input.Position.X)
        end
    end)
    
    self.State.Connections[#self.State.Connections + 1] = Services.UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            self:UpdateSlider(input.Position.X)
        end
    end)
    
    self.State.Connections[#self.State.Connections + 1] = Services.UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            self.State.IsDragging = false
        end
    end)
end

function Slider:UpdateSlider(mouseX)
    local trackAbsPos = self.Track.AbsolutePosition.X
    local trackAbsSize = self.Track.AbsoluteSize.X
    local relativeX = math.max(0, math.min(1, (mouseX - trackAbsPos) / trackAbsSize))
    
    local value = self.Config.Min + (relativeX * (self.Config.Max - self.Config.Min))
    value = math.floor(value / self.Config.Increment + 0.5) * self.Config.Increment
    value = math.max(self.Config.Min, math.min(self.Config.Max, value))
    
    self:SetValue(value, true)
    VXH.Stats.TotalInteractions = VXH.Stats.TotalInteractions + 1
end

function Slider:SetValue(value, runCallback)
    runCallback = runCallback ~= false
    
    self.State.CurrentValue = value
    
    local percentage = (value - self.Config.Min) / (self.Config.Max - self.Config.Min)
    
    self.Fill.Size = UDim2.new(percentage, 0, 1, 0)
    self.Thumb.Position = UDim2.new(percentage, -8, 0.5, -8)
    self.ValueLabel.Text = tostring(value) .. self.Config.Suffix
    
    if self.Config.Flag then
        self.Window:SetFlag(self.Config.Flag, value)
    end
    
    if runCallback and self.Config.Callback then
        local success, result = pcall(self.Config.Callback, value)
        if not success then
            warn("[VXH Enhanced] Slider callback error: " .. tostring(result))
        end
    end
end

-- Input Component (NEW)
local Input = {}
Input.__index = Input

function Input:Create(config, parent)
    local self = setmetatable({}, Input)
    
    self.Config = Utils:MergeTables({
        Name = "Input",
        Text = "Input",
        Description = nil,
        CurrentValue = "",
        PlaceholderText = "Enter text...",
        Callback = function(value) end,
        Enabled = true,
        Visible = true,
        Flag = nil,
        Size = UDim2.new(1, -20, 0, 36),
        ClearButton = false,
        RemoveTextAfterCallback = false
    }, config or {})
    
    self.Parent = parent
    self.Tab = parent
    self.Window = parent.Window
    
    self.State = {
        IsFocused = false,
        IsHovered = false,
        IsEnabled = self.Config.Enabled,
        CurrentValue = self.Config.CurrentValue,
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    self:SetValue(self.Config.CurrentValue, false)
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    VXH:FireEvent("ComponentCreated", self)
    
    return self
end

function Input:CreateUI()
    local theme = Themes:GetCurrent()
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Input_" .. self.Config.Name
    self.Container.Size = self.Config.Size
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 15
    self.Container.Parent = self.Tab.TabContent
    
    self.InputFrame = Instance.new("Frame")
    self.InputFrame.Name = "InputFrame"
    self.InputFrame.Size = UDim2.new(1, 0, 0, 36)
    self.InputFrame.Position = UDim2.new(0, 0, 0, 0)
    self.InputFrame.BackgroundColor3 = theme.Colors.Card
    self.InputFrame.BorderSizePixel = 0
    self.InputFrame.ZIndex = 16
    self.InputFrame.Parent = self.Container
    
    Utils:CreateCorner(self.InputFrame, 8)
    Utils:CreateStroke(self.InputFrame, 1, theme.Colors.Border, 0.3)
    
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "Label"
    self.Label.Size = UDim2.new(0, 100, 1, 0)
    self.Label.Position = UDim2.new(0, 12, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Config.Text
    self.Label.TextColor3 = theme.Colors.Text
    self.Label.TextSize = 14
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.ZIndex = 17
    self.Label.Parent = self.InputFrame
    
    self.TextBox = Instance.new("TextBox")
    self.TextBox.Name = "TextBox"
    self.TextBox.Size = UDim2.new(1, -120, 1, -8)
    self.TextBox.Position = UDim2.new(0, 110, 0, 4)
    self.TextBox.BackgroundColor3 = theme.Colors.Surface
    self.TextBox.BorderSizePixel = 0
    self.TextBox.Text = self.Config.CurrentValue
    self.TextBox.PlaceholderText = self.Config.PlaceholderText
    self.TextBox.TextColor3 = theme.Colors.Text
    self.TextBox.PlaceholderColor3 = theme.Colors.TextMuted
    self.TextBox.TextSize = 12
    self.TextBox.Font = Enum.Font.Gotham
    self.TextBox.ClearTextOnFocus = false
    self.TextBox.ZIndex = 17
    self.TextBox.Parent = self.InputFrame
    
    Utils:CreateCorner(self.TextBox, 6)
    Utils:CreateStroke(self.TextBox, 1, theme.Colors.Border, 0.5)
end

function Input:SetupEventHandlers()
    self.State.Connections[#self.State.Connections + 1] = self.TextBox.FocusLost:Connect(function(enterPressed)
        self.State.IsFocused = false
        
        if enterPressed then
            local value = self.TextBox.Text
            self:SetValue(value, true)
            VXH.Stats.TotalInteractions = VXH.Stats.TotalInteractions + 1
            
            if self.Config.RemoveTextAfterCallback then
                self.TextBox.Text = ""
            end
        end
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.TextBox.Focused:Connect(function()
        self.State.IsFocused = true
        
        local theme = Themes:GetCurrent()
        Utils:CreateStroke(self.TextBox, 1, theme.Colors.Primary, 0)
    end)
end

function Input:SetValue(value, runCallback)
    runCallback = runCallback ~= false
    
    self.State.CurrentValue = value
    self.TextBox.Text = value
    
    if self.Config.Flag then
        self.Window:SetFlag(self.Config.Flag, value)
    end
    
    if runCallback and self.Config.Callback then
        local success, result = pcall(self.Config.Callback, value)
        if not success then
            warn("[VXH Enhanced] Input callback error: " .. tostring(result))
        end
    end
end

-- Dropdown Component (NEW)
local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:Create(config, parent)
    local self = setmetatable({}, Dropdown)
    
    self.Config = Utils:MergeTables({
        Name = "Dropdown",
        Text = "Dropdown",
        Description = nil,
        Options = {"Option 1", "Option 2", "Option 3"},
        CurrentValue = nil,
        Callback = function(value) end,
        Enabled = true,
        Visible = true,
        Flag = nil,
        Size = UDim2.new(1, -20, 0, 36),
        PlaceholderText = "Select an option..."
    }, config or {})
    
    if not self.Config.CurrentValue then
        self.Config.CurrentValue = self.Config.Options[1] or ""
    end
    
    self.Parent = parent
    self.Tab = parent
    self.Window = parent.Window
    
    self.State = {
        IsOpen = false,
        IsHovered = false,
        IsEnabled = self.Config.Enabled,
        CurrentValue = self.Config.CurrentValue,
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    self:SetValue(self.Config.CurrentValue, false)
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    VXH:FireEvent("ComponentCreated", self)
    
    return self
end

function Dropdown:CreateUI()
    local theme = Themes:GetCurrent()
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Dropdown_" .. self.Config.Name
    self.Container.Size = self.Config.Size
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 15
    self.Container.Parent = self.Tab.TabContent
    
    self.DropdownFrame = Instance.new("TextButton")
    self.DropdownFrame.Name = "DropdownFrame"
    self.DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
    self.DropdownFrame.Position = UDim2.new(0, 0, 0, 0)
    self.DropdownFrame.BackgroundColor3 = theme.Colors.Card
    self.DropdownFrame.BorderSizePixel = 0
    self.DropdownFrame.Text = ""
    self.DropdownFrame.ZIndex = 16
    self.DropdownFrame.Parent = self.Container
    
    Utils:CreateCorner(self.DropdownFrame, 8)
    Utils:CreateStroke(self.DropdownFrame, 1, theme.Colors.Border, 0.3)
    
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "Label"
    self.Label.Size = UDim2.new(0, 100, 1, 0)
    self.Label.Position = UDim2.new(0, 12, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Config.Text
    self.Label.TextColor3 = theme.Colors.Text
    self.Label.TextSize = 14
    self.Label.Font = Enum.Font.Gotham
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.ZIndex = 17
    self.Label.Parent = self.DropdownFrame
    
    self.ValueLabel = Instance.new("TextLabel")
    self.ValueLabel.Name = "ValueLabel"
    self.ValueLabel.Size = UDim2.new(1, -140, 1, 0)
    self.ValueLabel.Position = UDim2.new(0, 110, 0, 0)
    self.ValueLabel.BackgroundTransparency = 1
    self.ValueLabel.Text = self.Config.PlaceholderText
    self.ValueLabel.TextColor3 = theme.Colors.TextSecondary
    self.ValueLabel.TextSize = 12
    self.ValueLabel.Font = Enum.Font.Gotham
    self.ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ValueLabel.ZIndex = 17
    self.ValueLabel.Parent = self.DropdownFrame
    
    self.Arrow = Instance.new("TextLabel")
    self.Arrow.Name = "Arrow"
    self.Arrow.Size = UDim2.new(0, 20, 1, 0)
    self.Arrow.Position = UDim2.new(1, -30, 0, 0)
    self.Arrow.BackgroundTransparency = 1
    self.Arrow.Text = "▼"
    self.Arrow.TextColor3 = theme.Colors.TextMuted
    self.Arrow.TextSize = 10
    self.Arrow.Font = Enum.Font.Gotham
    self.Arrow.ZIndex = 17
    self.Arrow.Parent = self.DropdownFrame
    
    self.OptionsList = Instance.new("ScrollingFrame")
    self.OptionsList.Name = "OptionsList"
    self.OptionsList.Size = UDim2.new(1, 0, 0, math.min(200, #self.Config.Options * 30))
    self.OptionsList.Position = UDim2.new(0, 0, 1, 2)
    self.OptionsList.BackgroundColor3 = theme.Colors.Card
    self.OptionsList.BorderSizePixel = 0
    self.OptionsList.ScrollBarThickness = 4
    self.OptionsList.ScrollBarImageColor3 = theme.Colors.Primary
    self.OptionsList.ZIndex = 100
    self.OptionsList.Parent = self.Container
    self.OptionsList.Visible = false
    
    Utils:CreateCorner(self.OptionsList, 8)
    Utils:CreateStroke(self.OptionsList, 1, theme.Colors.Border, 0.3)
    Utils:CreateShadow(self.OptionsList, 8, 0.5)
    
    self.OptionsLayout = Instance.new("UIListLayout")
    self.OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.OptionsLayout.Padding = UDim.new(0, 2)
    self.OptionsLayout.Parent = self.OptionsList
    
    self:CreateOptions()
end

function Dropdown:CreateOptions()
    local theme = Themes:GetCurrent()
    
    for i, option in ipairs(self.Config.Options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. i
        optionButton.Size = UDim2.new(1, -10, 0, 28)
        optionButton.Position = UDim2.new(0, 5, 0, 0)
        optionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        optionButton.BackgroundTransparency = 1
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = theme.Colors.Text
        optionButton.TextSize = 12
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.ZIndex = 101
        optionButton.Parent = self.OptionsList
        
        Utils:CreateCorner(optionButton, 6)
        
        optionButton.MouseButton1Click:Connect(function()
            self:SetValue(option, true)
            self:CloseDropdown()
            VXH.Stats.TotalInteractions = VXH.Stats.TotalInteractions + 1
        end)
        
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundColor3 = theme.Colors.Hover
            optionButton.BackgroundTransparency = 0
        end)
        
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundTransparency = 1
        end)
    end
end

function Dropdown:SetupEventHandlers()
    self.State.Connections[#self.State.Connections + 1] = self.DropdownFrame.MouseButton1Click:Connect(function()
        self:ToggleDropdown()
    end)
end

function Dropdown:ToggleDropdown()
    if self.State.IsOpen then
        self:CloseDropdown()
    else
        self:OpenDropdown()
    end
end

function Dropdown:OpenDropdown()
    self.State.IsOpen = true
    self.OptionsList.Visible = true
    self.Arrow.Text = "▲"
    
    Animations:FadeIn(self.OptionsList, 0.2)
end

function Dropdown:CloseDropdown()
    self.State.IsOpen = false
    self.Arrow.Text = "▼"
    
    Animations:FadeOut(self.OptionsList, 0.2, function()
        self.OptionsList.Visible = false
    end)
end

function Dropdown:SetValue(value, runCallback)
    runCallback = runCallback ~= false
    
    self.State.CurrentValue = value
    self.ValueLabel.Text = value
    
    if self.Config.Flag then
        self.Window:SetFlag(self.Config.Flag, value)
    end
    
    if runCallback and self.Config.Callback then
        local success, result = pcall(self.Config.Callback, value)
        if not success then
            warn("[VXH Enhanced] Dropdown callback error: " .. tostring(result))
        end
    end
end

-- ========================================
-- ENHANCED TAB SYSTEM
-- ========================================
local Tab = {}
Tab.__index = Tab

function Tab:Create(config, parent)
    local self = setmetatable({}, Tab)
    
    self.Config = Utils:MergeTables({
        Name = "Tab",
        Icon = nil,
        Visible = true
    }, config or {})
    
    self.Parent = parent
    self.Window = parent
    
    self.State = {
        IsActive = false,
        Components = {},
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    
    return self
end

function Tab:CreateUI()
    local theme = Themes:GetCurrent()
    
    -- Tab button
    self.TabButton = Instance.new("TextButton")
    self.TabButton.Name = "TabButton_" .. self.Config.Name
    self.TabButton.Size = UDim2.new(1, -10, 0, 36)
    self.TabButton.Position = UDim2.new(0, 5, 0, 0)
    self.TabButton.BackgroundColor3 = theme.Colors.Surface
    self.TabButton.BackgroundTransparency = 0.3
    self.TabButton.BorderSizePixel = 0
    self.TabButton.Text = ""
    self.TabButton.ZIndex = 13
    self.TabButton.Parent = self.Window.TabContainer
    
    Utils:CreateCorner(self.TabButton, 8)
    
    -- Tab icon (if provided)
    if self.Config.Icon then
        self.TabIcon = Instance.new("TextLabel")
        self.TabIcon.Name = "TabIcon"
        self.TabIcon.Size = UDim2.new(0, 16, 0, 16)
        self.TabIcon.Position = UDim2.new(0, 12, 0.5, -8)
        self.TabIcon.BackgroundTransparency = 1
        self.TabIcon.Text = self.Config.Icon
        self.TabIcon.TextColor3 = theme.Colors.TextMuted
        self.TabIcon.TextSize = 14
        self.TabIcon.Font = Enum.Font.Gotham
        self.TabIcon.ZIndex = 14
        self.TabIcon.Parent = self.TabButton
    end
    
    -- Tab text
    self.TabText = Instance.new("TextLabel")
    self.TabText.Name = "TabText"
    self.TabText.Size = UDim2.new(1, -40, 1, 0)
    self.TabText.Position = UDim2.new(0, self.Config.Icon and 32 or 12, 0, 0)
    self.TabText.BackgroundTransparency = 1
    self.TabText.Text = self.Config.Name
    self.TabText.TextColor3 = theme.Colors.TextMuted
    self.TabText.TextSize = 13
    self.TabText.Font = Enum.Font.Gotham
    self.TabText.TextXAlignment = Enum.TextXAlignment.Left
    self.TabText.ZIndex = 14
    self.TabText.Parent = self.TabButton
    
    -- Tab content area
    self.TabContent = Instance.new("ScrollingFrame")
    self.TabContent.Name = "TabContent_" .. self.Config.Name
    self.TabContent.Size = UDim2.new(1, -220, 1, 0)
    self.TabContent.Position = UDim2.new(0, 210, 0, 0)
    self.TabContent.BackgroundTransparency = 1
    self.TabContent.BorderSizePixel = 0
    self.TabContent.ScrollBarThickness = 4
    self.TabContent.ScrollBarImageColor3 = theme.Colors.Primary
    self.TabContent.ZIndex = 13
    self.TabContent.Parent = self.Window.ContentArea
    self.TabContent.Visible = false
    
    -- Tab content layout
    self.TabLayout = Instance.new("UIListLayout")
    self.TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabLayout.Padding = UDim.new(0, 10)
    self.TabLayout.Parent = self.TabContent
    
    -- Tab content padding
    self.TabPadding = Instance.new("UIPadding")
    self.TabPadding.PaddingTop = UDim.new(0, 10)
    self.TabPadding.PaddingBottom = UDim.new(0, 10)
    self.TabPadding.PaddingLeft = UDim.new(0, 10)
    self.TabPadding.PaddingRight = UDim.new(0, 10)
    self.TabPadding.Parent = self.TabContent
end

function Tab:SetupEventHandlers()
    self.State.Connections[#self.State.Connections + 1] = self.TabButton.MouseButton1Click:Connect(function()
        self.Window:SetActiveTab(self)
        Utils:PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.3)
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.TabButton.MouseEnter:Connect(function()
        if not self.State.IsActive then
            local theme = Themes:GetCurrent()
            Animations:Tween(self.TabButton, {BackgroundTransparency = 0.1}, 0.15)
        end
    end)
    
    self.State.Connections[#self.State.Connections + 1] = self.TabButton.MouseLeave:Connect(function()
        if not self.State.IsActive then
            Animations:Tween(self.TabButton, {BackgroundTransparency = 0.3}, 0.15)
        end
    end)
end

function Tab:SetActive(active)
    self.State.IsActive = active
    local theme = Themes:GetCurrent()
    
    if active then
        self.TabContent.Visible = true
        Animations:Tween(self.TabButton, {BackgroundTransparency = 0}, 0.2)
        Animations:Tween(self.TabText, {TextColor3 = theme.Colors.Text}, 0.2)
        if self.TabIcon then
            Animations:Tween(self.TabIcon, {TextColor3 = theme.Colors.Primary}, 0.2)
        end
    else
        self.TabContent.Visible = false
        Animations:Tween(self.TabButton, {BackgroundTransparency = 0.3}, 0.2)
        Animations:Tween(self.TabText, {TextColor3 = theme.Colors.TextMuted}, 0.2)
        if self.TabIcon then
            Animations:Tween(self.TabIcon, {TextColor3 = theme.Colors.TextMuted}, 0.2)
        end
    end
end

-- Create component methods
function Tab:CreateButton(config)
    local button = Button:Create(config, self)
    table.insert(self.State.Components, button)
    return button
end

function Tab:CreateToggle(config)
    local toggle = Toggle:Create(config, self)
    table.insert(self.State.Components, toggle)
    return toggle
end

function Tab:CreateSlider(config)
    local slider = Slider:Create(config, self)
    table.insert(self.State.Components, slider)
    return slider
end

function Tab:CreateInput(config)
    local input = Input:Create(config, self)
    table.insert(self.State.Components, input)
    return input
end

function Tab:CreateDropdown(config)
    local dropdown = Dropdown:Create(config, self)
    table.insert(self.State.Components, dropdown)
    return dropdown
end

-- Create label
function Tab:CreateLabel(config)
    local theme = Themes:GetCurrent()
    
    config = config or {}
    local labelConfig = {
        Name = config.Name or "Label",
        Text = config.Text or "Label",
        Size = config.Size or UDim2.new(1, -20, 0, 25),
        TextSize = config.TextSize or 16,
        Font = config.Font or Enum.Font.GothamBold,
        TextColor = config.TextColor or theme.Colors.Text
    }
    
    local container = Instance.new("Frame")
    container.Name = "Label_" .. labelConfig.Name
    container.Size = labelConfig.Size
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ZIndex = 15
    container.Parent = self.TabContent
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelConfig.Text
    label.TextColor3 = labelConfig.TextColor
    label.TextSize = labelConfig.TextSize
    label.Font = labelConfig.Font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 16
    label.Parent = container
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    
    return {
        Container = container,
        Label = label,
        SetText = function(text)
            label.Text = text
        end
    }
end

-- Create separator
function Tab:CreateSeparator(config)
    local theme = Themes:GetCurrent()
    
    config = config or {}
    local separatorConfig = {
        Size = config.Size or UDim2.new(1, -20, 0, 1),
        Color = config.Color or theme.Colors.Border,
        Transparency = config.Transparency or 0.5
    }
    
    local container = Instance.new("Frame")
    container.Name = "Separator"
    container.Size = UDim2.new(1, -20, 0, 15)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ZIndex = 15
    container.Parent = self.TabContent
    
    local separator = Instance.new("Frame")
    separator.Name = "Line"
    separator.Size = separatorConfig.Size
    separator.Position = UDim2.new(0, 0, 0.5, 0)
    separator.BackgroundColor3 = separatorConfig.Color
    separator.BackgroundTransparency = separatorConfig.Transparency
    separator.BorderSizePixel = 0
    separator.ZIndex = 16
    separator.Parent = container
    
    VXH.Stats.ComponentsCreated = VXH.Stats.ComponentsCreated + 1
    
    return {
        Container = container,
        Separator = separator
    }
end

-- ========================================
-- ENHANCED WINDOW SYSTEM
-- ========================================
local Window = {}
Window.__index = Window

function Window:Create(config)
    local self = setmetatable({}, Window)
    
    self.Config = Utils:MergeTables({
        Name = "VXH Enhanced Window",
        Size = UDim2.new(0, 680, 0, 520),
        CloseButton = true,
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "VXH",
            FileName = "Config"
        }
    }, config or {})
    
    self.State = {
        IsVisible = false,
        Tabs = {},
        CurrentTab = nil,
        Flags = {},
        Connections = {}
    }
    
    self:CreateUI()
    self:SetupEventHandlers()
    self:Show()
    
    VXH.Stats.WindowsCreated = VXH.Stats.WindowsCreated + 1
    VXH:FireEvent("WindowCreated", self)
    
    return self
end

function Window:CreateUI()
    local theme = Themes:GetCurrent()
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "VXH_Enhanced_" .. Utils:GenerateId()
    self.ScreenGui.Parent = Services.CoreGui
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create main frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = self.Config.Size
    self.MainFrame.Position = UDim2.new(0.5, -self.Config.Size.X.Offset/2, 0.5, -self.Config.Size.Y.Offset/2)
    self.MainFrame.BackgroundColor3 = theme.Colors.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.Active = true
    self.MainFrame.Visible = false
    self.MainFrame.ZIndex = 10
    
    Utils:CreateCorner(self.MainFrame, 16)
    Utils:CreateStroke(self.MainFrame, 1, theme.Colors.Border, 0.3)
    Utils:CreateShadow(self.MainFrame, 20, 0.6)
    
    self:CreateTitleBar()
    self:CreateContentArea()
end

function Window:CreateTitleBar()
    local theme = Themes:GetCurrent()
    
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 60)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    self.TitleBar.BackgroundColor3 = theme.Colors.Card
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.ZIndex = 11
    self.TitleBar.Parent = self.MainFrame
    
    Utils:CreateCorner(self.TitleBar, 16)
    Utils:CreateGradient(self.TitleBar, {
        ColorSequenceKeypoint.new(0, theme.Colors.Primary),
        ColorSequenceKeypoint.new(0.5, theme.Colors.Secondary),
        ColorSequenceKeypoint.new(1, theme.Colors.Tertiary)
    }, 45)
    
    -- Window title
    self.WindowTitle = Instance.new("TextLabel")
    self.WindowTitle.Name = "Title"
    self.WindowTitle.Size = UDim2.new(0, 300, 0, 25)
    self.WindowTitle.Position = UDim2.new(0, 20, 0, 8)
    self.WindowTitle.BackgroundTransparency = 1
    self.WindowTitle.Text = self.Config.Name
    self.WindowTitle.TextColor3 = theme.Colors.Text
    self.WindowTitle.TextSize = 18
    self.WindowTitle.Font = Enum.Font.GothamBold
    self.WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    self.WindowTitle.ZIndex = 12
    self.WindowTitle.Parent = self.TitleBar
    
    -- Window subtitle
    self.WindowSubtitle = Instance.new("TextLabel")
    self.WindowSubtitle.Name = "Subtitle"
    self.WindowSubtitle.Size = UDim2.new(0, 300, 0, 18)
    self.WindowSubtitle.Position = UDim2.new(0, 20, 0, 32)
    self.WindowSubtitle.BackgroundTransparency = 1
    self.WindowSubtitle.Text = "Enhanced UI Library v3.0.0"
    self.WindowSubtitle.TextColor3 = theme.Colors.TextSecondary
    self.WindowSubtitle.TextSize = 12
    self.WindowSubtitle.Font = Enum.Font.Gotham
    self.WindowSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    self.WindowSubtitle.ZIndex = 12
    self.WindowSubtitle.Parent = self.TitleBar
    
    -- Close button
    if self.Config.CloseButton then
        self.CloseButton = Instance.new("TextButton")
        self.CloseButton.Name = "CloseButton"
        self.CloseButton.Size = UDim2.new(0, 30, 0, 30)
        self.CloseButton.Position = UDim2.new(1, -40, 0, 15)
        self.CloseButton.BackgroundColor3 = theme.Colors.Error
        self.CloseButton.BorderSizePixel = 0
        self.CloseButton.Text = "×"
        self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.CloseButton.TextSize = 18
        self.CloseButton.Font = Enum.Font.GothamBold
        self.CloseButton.ZIndex = 13
        self.CloseButton.Parent = self.TitleBar
        
        Utils:CreateCorner(self.CloseButton, 6)
    end
end

function Window:CreateContentArea()
    local theme = Themes:GetCurrent()
    
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.Size = UDim2.new(1, -20, 1, -80)
    self.ContentArea.Position = UDim2.new(0, 10, 0, 70)
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.ZIndex = 11
    self.ContentArea.Parent = self.MainFrame
    
    -- Create sidebar
    self.Sidebar = Instance.new("Frame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 200, 1, 0)
    self.Sidebar.Position = UDim2.new(0, 0, 0, 0)
    self.Sidebar.BackgroundColor3 = theme.Colors.Sidebar
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.ZIndex = 12
    self.Sidebar.Parent = self.ContentArea
    
    Utils:CreateCorner(self.Sidebar, 12)
    Utils:CreateStroke(self.Sidebar, 1, theme.Colors.Border, 0.5)
    
    -- Tab container
    self.TabContainer = Instance.new("ScrollingFrame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(1, -10, 1, -10)
    self.TabContainer.Position = UDim2.new(0, 5, 0, 5)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.ScrollBarThickness = 4
    self.TabContainer.ScrollBarImageColor3 = theme.Colors.Primary
    self.TabContainer.ZIndex = 13
    self.TabContainer.Parent = self.Sidebar
    
    -- Tab layout
    self.TabLayout = Instance.new("UIListLayout")
    self.TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabLayout.Padding = UDim.new(0, 5)
    self.TabLayout.Parent = self.TabContainer
    
    -- Tab padding
    self.TabPadding = Instance.new("UIPadding")
    self.TabPadding.PaddingTop = UDim.new(0, 10)
    self.TabPadding.PaddingBottom = UDim.new(0, 10)
    self.TabPadding.Parent = self.TabContainer
end

function Window:SetupEventHandlers()
    -- Dragging functionality
    local dragToggle = nil
    local dragSpeed = 0.25
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        Services.TweenService:Create(self.MainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end
    
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)
    
    -- Close button
    if self.CloseButton then
        self.CloseButton.MouseButton1Click:Connect(function()
            self:Destroy()
        end)
    end
end

function Window:CreateTab(config)
    local tab = Tab:Create(config, self)
    table.insert(self.State.Tabs, tab)
    
    -- Set as active tab if it's the first one
    if #self.State.Tabs == 1 then
        self:SetActiveTab(tab)
    end
    
    return tab
end

function Window:Show()
    self.State.IsVisible = true
    self.MainFrame.Visible = true
    
    -- Animate in
    self.MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Animations:Tween(self.MainFrame, {Size = self.Config.Size}, 0.3, Enum.EasingStyle.Back)
end

function Window:Hide()
    self.State.IsVisible = false
    Animations:Tween(self.MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2, nil, nil, function()
        self.MainFrame.Visible = false
    end)
end

function Window:Destroy()
    for _, connection in pairs(self.State.Connections) do
        connection:Disconnect()
    end
    
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    
    VXH:FireEvent("WindowDestroyed", self)
end

-- Set active tab
function Window:SetActiveTab(tab)
    -- Deactivate current tab
    if self.State.CurrentTab then
        self.State.CurrentTab:SetActive(false)
    end
    
    -- Activate new tab
    self.State.CurrentTab = tab
    tab:SetActive(true)
end

-- Set flag value
function Window:SetFlag(flag, value)
    self.State.Flags[flag] = value
end

-- Get flag value
function Window:GetFlag(flag)
    return self.State.Flags[flag]
end

-- ========================================
-- MAIN VXH ENHANCED LIBRARY FUNCTIONS
-- ========================================

-- Initialize the library
function VXH:Initialize()
    if self.State.IsInitialized then
        return
    end
    
    -- Initialize core systems
    Services:Initialize()
    Utils:Initialize()
    Animations:Initialize()
    Themes:Initialize()
    Notifications:Initialize()
    
    -- Set up input handling
    self:SetupInputHandling()
    
    -- Mark as initialized
    self.State.IsInitialized = true
    
    print("[VXH Enhanced] Professional framework initialized v" .. self.Version)
end

-- Set up input handling for global features
function VXH:SetupInputHandling()
    Services.UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        
        -- Toggle UI with Insert key (configurable)
        if input.KeyCode == self.Configuration.GlobalToggleKey then
            self:ToggleUI()
        end
    end)
end

-- Toggle UI visibility
function VXH:ToggleUI()
    self.IsToggled = not self.IsToggled
    
    for _, window in pairs(self.Windows) do
        if self.IsToggled then
            window:Show()
        else
            window:Hide()
        end
    end
    
    -- Play toggle sound
    if self.Configuration.SoundEnabled then
        Utils:PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.5)
    end
    
    -- Fire event
    self:FireEvent("ToggleChanged", self.IsToggled)
end

-- Create a new window
function VXH:CreateWindow(config)
    if not self.State.IsInitialized then
        self:Initialize()
    end
    
    local window = Window:Create(config)
    table.insert(self.Windows, window)
    
    -- Update statistics
    self.State.ActiveWindows[window] = true
    
    return window
end

-- Create notification
function VXH:CreateNotification(config)
    if not self.Configuration.NotificationsEnabled then
        return
    end
    
    self.Stats.NotificationsSent = self.Stats.NotificationsSent + 1
    return Notifications:Create(config)
end

-- Set theme
function VXH:SetTheme(themeName)
    local oldTheme = self.State.CurrentTheme
    self.State.CurrentTheme = themeName
    Themes:SetTheme(themeName)
    
    -- Update statistics
    self.Stats.ThemesLoaded = self.Stats.ThemesLoaded + 1
    
    -- Fire event
    self:FireEvent("ThemeChanged", {
        oldTheme = oldTheme,
        newTheme = themeName
    })
    
    -- Save configuration if enabled
    if self.Configuration.SaveConfiguration then
        self:SaveConfiguration()
    end
end

-- Get current theme
function VXH:GetTheme()
    return Themes:GetCurrent()
end

-- Add custom theme
function VXH:AddCustomTheme(name, themeData)
    self.State.CustomThemes[name] = themeData
    Themes.Themes[name] = themeData
    
    if self.Configuration.DebugMode then
        print("[VXH Enhanced] Custom theme '" .. name .. "' added successfully")
    end
end

-- Fire event
function VXH:FireEvent(eventName, data)
    if self.Events[eventName] then
        for _, callback in pairs(self.Events[eventName]) do
            pcall(callback, data)
        end
    end
end

-- Connect to event
function VXH:ConnectEvent(eventName, callback)
    if not self.Events[eventName] then
        self.Events[eventName] = {}
    end
    
    table.insert(self.Events[eventName], callback)
    
    return function()
        for i, cb in pairs(self.Events[eventName]) do
            if cb == callback then
                table.remove(self.Events[eventName], i)
                break
            end
        end
    end
end

-- Update configuration
function VXH:UpdateConfiguration(config)
    for key, value in pairs(config) do
        if self.Configuration[key] ~= nil then
            self.Configuration[key] = value
        end
    end
    
    self:FireEvent("ConfigurationChanged", config)
    
    if self.Configuration.SaveConfiguration then
        self:SaveConfiguration()
    end
end

-- Get configuration value
function VXH:GetConfiguration(key)
    return self.Configuration[key]
end

-- Save configuration
function VXH:SaveConfiguration()
    if not self.Configuration.SaveConfiguration then
        return
    end
    
    local configData = {
        Configuration = self.Configuration,
        CurrentTheme = self.State.CurrentTheme,
        CustomThemes = self.State.CustomThemes,
        Flags = self.Flags,
        SaveTime = tick()
    }
    
    -- Attempt to save (will fail gracefully if no write access)
    pcall(function()
        writefile("VXH_Enhanced_Config.json", Services.HttpService:JSONEncode(configData))
    end)
    
    self.State.LastSaveTime = tick()
end

-- Load configuration
function VXH:LoadConfiguration()
    if not self.Configuration.SaveConfiguration then
        return
    end
    
    local success, configData = pcall(function()
        if isfile("VXH_Enhanced_Config.json") then
            return Services.HttpService:JSONDecode(readfile("VXH_Enhanced_Config.json"))
        end
        return nil
    end)
    
    if success and configData then
        -- Load configuration
        for key, value in pairs(configData.Configuration or {}) do
            if self.Configuration[key] ~= nil then
                self.Configuration[key] = value
            end
        end
        
        -- Load theme
        if configData.CurrentTheme then
            self.State.CurrentTheme = configData.CurrentTheme
        end
        
        -- Load custom themes
        if configData.CustomThemes then
            for name, theme in pairs(configData.CustomThemes) do
                self:AddCustomTheme(name, theme)
            end
        end
        
        -- Load flags
        if configData.Flags then
            self.Flags = configData.Flags
        end
        
        if self.Configuration.DebugMode then
            print("[VXH Enhanced] Configuration loaded successfully")
        end
    end
end

-- Get statistics
function VXH:GetStats()
    -- Update session time
    self.Stats.SessionTime = tick() - self.Stats.SessionStartTime
    
    -- Update memory usage if possible
    pcall(function()
        self.Stats.Performance.MemoryUsage = gcinfo()
    end)
    
    return self.Stats
end

-- Reset statistics
function VXH:ResetStats()
    self.Stats = {
        WindowsCreated = 0,
        ComponentsCreated = 0,
        ThemesLoaded = 0,
        NotificationsSent = 0,
        SessionStartTime = tick(),
        TotalInteractions = 0,
        Performance = {
            AverageFrameTime = 0,
            MemoryUsage = 0,
            CPUUsage = 0
        }
    }
end

-- Destroy window
function VXH:DestroyWindow(window)
    for i, w in pairs(self.Windows) do
        if w == window then
            table.remove(self.Windows, i)
            break
        end
    end
    
    self.State.ActiveWindows[window] = nil
    
    if window.ScreenGui then
        window.ScreenGui:Destroy()
    end
end

-- Destroy all windows
function VXH:DestroyAll()
    for _, window in pairs(self.Windows) do
        if window.ScreenGui then
            window.ScreenGui:Destroy()
        end
    end
    
    self.Windows = {}
    self.State.ActiveWindows = {}
    
    if self.Configuration.DebugMode then
        print("[VXH Enhanced] All windows destroyed")
    end
end

-- Set flag globally
function VXH:SetFlag(flag, value)
    self.Flags[flag] = value
    
    -- Save configuration if enabled
    if self.Configuration.SaveConfiguration then
        self:SaveConfiguration()
    end
end

-- Get flag globally
function VXH:GetFlag(flag)
    return self.Flags[flag]
end

-- Debug information
function VXH:GetDebugInfo()
    return {
        Version = self.Version,
        Build = self.Build,
        Author = self.Author,
        License = self.License,
        Stats = self:GetStats(),
        Configuration = self.Configuration,
        State = self.State,
        WindowCount = #self.Windows,
        ThemeCount = Utils:TableLength(Themes.Themes),
        CustomThemeCount = Utils:TableLength(self.State.CustomThemes),
        EventListeners = Utils:TableLength(self.Events)
    }
end

-- Print debug information
function VXH:PrintDebugInfo()
    local info = self:GetDebugInfo()
    
    print("=== VXH Enhanced Debug Info ===")
    print("Version: " .. info.Version)
    print("Build: " .. info.Build)
    print("Author: " .. info.Author)
    print("Windows Created: " .. info.Stats.WindowsCreated)
    print("Components Created: " .. info.Stats.ComponentsCreated)
    print("Notifications Sent: " .. info.Stats.NotificationsSent)
    print("Memory Usage: " .. info.Stats.Performance.MemoryUsage .. " KB")
    print("Session Time: " .. math.floor(info.Stats.SessionTime or 0) .. " seconds")
    print("Active Windows: " .. info.WindowCount)
    print("Available Themes: " .. info.ThemeCount)
    print("Custom Themes: " .. info.CustomThemeCount)
    print("=======================")
end

-- Auto-save functionality
function VXH:StartAutoSave()
    if not self.Configuration.SaveConfiguration then
        return
    end
    
    spawn(function()
        while self.Configuration.SaveConfiguration do
            wait(self.Configuration.AutoSaveInterval)
            
            if tick() - self.State.LastSaveTime > self.Configuration.AutoSaveInterval then
                self:SaveConfiguration()
            end
        end
    end)
end

-- Enhanced initialization with loading screen
function VXH:InitializeWithLoadingScreen(config)
    config = config or {}
    
    if self.Configuration.LoadingScreenEnabled and config.ShowLoadingScreen ~= false then
        -- Create loading screen notification
        self:CreateNotification({
            Title = "VXH Enhanced",
            Text = "Initializing professional UI library...",
            Type = "info",
            Duration = 2
        })
    end
    
    -- Initialize library
    self:Initialize()
    
    -- Load configuration
    self:LoadConfiguration()
    
    -- Start auto-save
    self:StartAutoSave()
    
    if self.Configuration.LoadingScreenEnabled and config.ShowLoadingScreen ~= false then
        wait(0.5)
        self:CreateNotification({
            Title = "VXH Enhanced",
            Text = "Ready! Press Insert to toggle UI",
            Type = "success",
            Duration = 3
        })
    end
end

-- ========================================
-- EXPORT THE ENHANCED LIBRARY
-- ========================================
_G.VXH = VXH
return VXH
