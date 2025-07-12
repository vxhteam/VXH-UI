-- VXH Enhanced Framework v2.0.0
-- Enhanced version of the official VXH UI with toggle functionality
-- Developer-friendly framework for script hub makers

local VXH = {
    Version = "2.0.0",
    Flags = {},
    Themes = {},
    Windows = {},
    IsToggled = false
}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Enhanced Configuration
local VXHConfig = {
    Version = "2.0.0",
    Creator = "VXH Enhanced Team",
    DefaultFont = Enum.Font.GothamBold,
    DefaultFontSize = 14,
    AnimationSpeed = 0.25,
    ToggleKey = Enum.KeyCode.Insert,
    Colors = {
        -- Enhanced Discord-inspired theme
        Primary = Color3.fromRGB(88, 101, 242),
        Secondary = Color3.fromRGB(114, 137, 218),
        Tertiary = Color3.fromRGB(139, 92, 246),
        
        -- Dark backgrounds
        Background = Color3.fromRGB(32, 34, 37),
        Card = Color3.fromRGB(47, 49, 54),
        Sidebar = Color3.fromRGB(40, 43, 48),
        
        -- Text colors
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(181, 186, 193),
        TextMuted = Color3.fromRGB(114, 118, 125),
        
        -- Status colors
        Success = Color3.fromRGB(87, 242, 135),
        Warning = Color3.fromRGB(255, 202, 40),
        Error = Color3.fromRGB(237, 66, 69),
        
        -- Interactive elements
        Border = Color3.fromRGB(79, 84, 92),
        Hover = Color3.fromRGB(64, 68, 75),
        Active = Color3.fromRGB(88, 101, 242),
        
        -- Special effects
        Glow = Color3.fromRGB(88, 101, 242),
        Shadow = Color3.fromRGB(0, 0, 0),
    }
}

-- Utility Functions
local function CreateTween(object, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or VXHConfig.AnimationSpeed,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    return TweenService:Create(object, tweenInfo, properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

local function CreateStroke(parent, thickness, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or VXHConfig.Colors.Border
    stroke.Transparency = transparency or 0
    stroke.Parent = parent
    return stroke
end

local function CreateShadow(parent, size, transparency)
    size = size or 6
    transparency = transparency or 0.5

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = VXHConfig and VXHConfig.Colors.Shadow or Color3.new(0, 0, 0)
    shadow.ImageTransparency = transparency
    shadow.ScaleType   = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size     = UDim2.new(1, size * 2, 1, size * 2)
    shadow.Position = UDim2.new(0, -size, 0, -size)
    shadow.ZIndex   = (parent.ZIndex or 1) - 1
    shadow.Parent   = parent

    return shadow
end


local function PlaySound(soundId, volume, pitch)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId or "rbxasset://sounds/electronicpingshort.wav"
        sound.Volume = volume or 0.3
        sound.Pitch = pitch or 1
        sound.Parent = SoundService
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end

-- Main VXH Framework
function VXH:CreateWindow(config)
    local WindowConfig = {
        Name = config.Name or "VXH Framework",
        LoadingTitle = config.LoadingTitle or "VXH Enhanced Interface",
        LoadingSubtitle = config.LoadingSubtitle or "by VXH Enhanced Team",
        ConfigurationSaving = config.ConfigurationSaving or {
            Enabled = false,
            FolderName = "VXH",
            FileName = "Config"
        },
        KeySystem = config.KeySystem or false,
        KeySettings = config.KeySettings or {
            Title = "VXH Hub",
            Subtitle = "Key System",
            Note = "Join our Discord for the key",
            Key = {"VXH2024"}
        },
        Discord = config.Discord or {
            Enabled = false,
            Invite = "discord.gg/vxh",
            RememberJoins = true
        }
    }

    local Window = {}
    local Tabs = {}
    local CurrentTab = nil

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VXH_" .. HttpService:GenerateGUID(false)
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Blur Effect
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Parent = Lighting

    -- Toggle Button (Always visible)
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "VXHToggleButton"
    ToggleButton.Size = UDim2.new(0, 65, 0, 65)
    ToggleButton.Position = UDim2.new(0, 25, 0, 25)
    ToggleButton.BackgroundColor3 = VXHConfig.Colors.Primary
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.ZIndex = 1000
    ToggleButton.Active = true
    ToggleButton.Draggable = true
    ToggleButton.Parent = ScreenGui

    CreateCorner(ToggleButton, 32)
    CreateStroke(ToggleButton, 2, VXHConfig.Colors.Border, 0.5)
    CreateShadow(ToggleButton, 12, 0.7)

    -- Toggle Button Gradient
    CreateGradient(ToggleButton, {
        ColorSequenceKeypoint.new(0, VXHConfig.Colors.Primary),
        ColorSequenceKeypoint.new(0.5, VXHConfig.Colors.Secondary),
        ColorSequenceKeypoint.new(1, VXHConfig.Colors.Tertiary)
    }, 45)

    -- Toggle Button Icon
    local ToggleIcon = Instance.new("TextLabel")
    ToggleIcon.Name = "ToggleIcon"
    ToggleIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
    ToggleIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
    ToggleIcon.BackgroundTransparency = 1
    ToggleIcon.Text = "VXH"
    ToggleIcon.TextColor3 = VXHConfig.Colors.Text
    ToggleIcon.TextSize = 18
    ToggleIcon.Font = VXHConfig.DefaultFont
    ToggleIcon.ZIndex = 1001
    ToggleIcon.Parent = ToggleButton

    -- Status Indicator
    local StatusDot = Instance.new("Frame")
    StatusDot.Name = "StatusDot"
    StatusDot.Size = UDim2.new(0, 14, 0, 14)
    StatusDot.Position = UDim2.new(1, -10, 0, -4)
    StatusDot.BackgroundColor3 = VXHConfig.Colors.Success
    StatusDot.BorderSizePixel = 0
    StatusDot.ZIndex = 1002
    StatusDot.Parent = ToggleButton

    CreateCorner(StatusDot, 7)
    CreateStroke(StatusDot, 2, VXHConfig.Colors.Text, 0)

    -- Main Frame (Initially hidden)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 680, 0, 520)
    MainFrame.Position = UDim2.new(0.5, -340, 0.5, -260)
    MainFrame.BackgroundColor3 = VXHConfig.Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false
    MainFrame.ZIndex = 10

    CreateCorner(MainFrame, 16)
    CreateStroke(MainFrame, 1, VXHConfig.Colors.Border, 0.3)
    CreateShadow(MainFrame, 20, 0.6)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 65)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = VXHConfig.Colors.Card
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 11
    TitleBar.Parent = MainFrame

    CreateCorner(TitleBar, 16)
    CreateGradient(TitleBar, {
        ColorSequenceKeypoint.new(0, VXHConfig.Colors.Primary),
        ColorSequenceKeypoint.new(0.3, VXHConfig.Colors.Secondary),
        ColorSequenceKeypoint.new(0.7, VXHConfig.Colors.Tertiary),
        ColorSequenceKeypoint.new(1, VXHConfig.Colors.Primary)
    }, 45)

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 400, 0, 28)
    Title.Position = UDim2.new(0, 20, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = WindowConfig.Name
    Title.TextColor3 = VXHConfig.Colors.Text
    Title.TextSize = 20
    Title.Font = VXHConfig.DefaultFont
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 12
    Title.Parent = TitleBar

    -- Version Label
    local Version = Instance.new("TextLabel")
    Version.Name = "Version"
    Version.Size = UDim2.new(0, 300, 0, 18)
    Version.Position = UDim2.new(0, 20, 0, 35)
    Version.BackgroundTransparency = 1
    Version.Text = "v" .. VXHConfig.Version .. " • Enhanced Framework"
    Version.TextColor3 = VXHConfig.Colors.SubText
    Version.TextSize = 12
    Version.Font = Enum.Font.Gotham
    Version.TextXAlignment = Enum.TextXAlignment.Left
    Version.ZIndex = 12
    Version.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(1, -45, 0, 15)
    CloseButton.BackgroundColor3 = VXHConfig.Colors.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = VXHConfig.Colors.Text
    CloseButton.TextSize = 20
    CloseButton.Font = VXHConfig.DefaultFont
    CloseButton.ZIndex = 13
    CloseButton.Parent = TitleBar

    CreateCorner(CloseButton, 8)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 200, 1, -75)
    Sidebar.Position = UDim2.new(0, 10, 0, 75)
    Sidebar.BackgroundColor3 = VXHConfig.Colors.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 11
    Sidebar.Parent = MainFrame

    CreateCorner(Sidebar, 14)
    CreateStroke(Sidebar, 1, VXHConfig.Colors.Border, 0.5)

    -- Tab List
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 4
    TabList.ScrollBarImageColor3 = VXHConfig.Colors.Primary
    TabList.ZIndex = 12
    TabList.Parent = Sidebar

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8)
    TabListLayout.Parent = TabList

    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -220, 1, -75)
    ContentArea.Position = UDim2.new(0, 210, 0, 75)
    ContentArea.BackgroundColor3 = VXHConfig.Colors.Card
    ContentArea.BorderSizePixel = 0
    ContentArea.ZIndex = 11
    ContentArea.Parent = MainFrame

    CreateCorner(ContentArea, 14)
    CreateStroke(ContentArea, 1, VXHConfig.Colors.Border, 0.5)

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, 0, 1, 0)
    ContentContainer.Position = UDim2.new(0, 0, 0, 0)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 12
    ContentContainer.Parent = ContentArea

    -- Toggle Functionality
    local function ToggleWindow()
        VXH.IsToggled = not VXH.IsToggled
        
        if VXH.IsToggled then
            -- Show window
            PlaySound("rbxasset://sounds/popup_open.wav", 0.4)
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            
            CreateTween(MainFrame, {
                Size = UDim2.new(0, 680, 0, 520),
                Position = UDim2.new(0.5, -340, 0.5, -260)
            }, VXHConfig.AnimationSpeed * 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
            
            CreateTween(ToggleButton, {
                BackgroundColor3 = VXHConfig.Colors.Success,
                Rotation = 180
            }, VXHConfig.AnimationSpeed):Play()
            
            CreateTween(BlurEffect, {Size = 6}, VXHConfig.AnimationSpeed):Play()
            
            ToggleIcon.Text = "✓"
            StatusDot.BackgroundColor3 = VXHConfig.Colors.Success
            
        else
            -- Hide window
            PlaySound("rbxasset://sounds/popup_close.wav", 0.4)
            CreateTween(MainFrame, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }, VXHConfig.AnimationSpeed, Enum.EasingStyle.Back, Enum.EasingDirection.In):Play()
            
            CreateTween(ToggleButton, {
                BackgroundColor3 = VXHConfig.Colors.Primary,
                Rotation = 0
            }, VXHConfig.AnimationSpeed):Play()
            
            CreateTween(BlurEffect, {Size = 0}, VXHConfig.AnimationSpeed):Play()
            
            ToggleIcon.Text = "VXH"
            StatusDot.BackgroundColor3 = VXHConfig.Colors.Warning
            
            wait(VXHConfig.AnimationSpeed)
            MainFrame.Visible = false
        end
    end

    -- Event Connections
    ToggleButton.MouseButton1Click:Connect(ToggleWindow)
    
    CloseButton.MouseButton1Click:Connect(function()
        VXH.IsToggled = false
        PlaySound("rbxasset://sounds/popup_close.wav", 0.4)
        
        CreateTween(MainFrame, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, VXHConfig.AnimationSpeed, Enum.EasingStyle.Back, Enum.EasingDirection.In):Play()
        
        CreateTween(ToggleButton, {
            BackgroundColor3 = VXHConfig.Colors.Primary,
            Rotation = 0
        }, VXHConfig.AnimationSpeed):Play()
        
        CreateTween(BlurEffect, {Size = 0}, VXHConfig.AnimationSpeed):Play()
        
        ToggleIcon.Text = "VXH"
        StatusDot.BackgroundColor3 = VXHConfig.Colors.Warning
        
        wait(VXHConfig.AnimationSpeed)
        MainFrame.Visible = false
    end)

    -- Keyboard shortcut
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == VXHConfig.ToggleKey then
            ToggleWindow()
        end
    end)

    -- Hover effects
    ToggleButton.MouseEnter:Connect(function()
        CreateTween(ToggleButton, {
            Size = UDim2.new(0, 70, 0, 70)
        }, 0.1):Play()
    end)

    ToggleButton.MouseLeave:Connect(function()
        CreateTween(ToggleButton, {
            Size = UDim2.new(0, 65, 0, 65)
        }, 0.1):Play()
    end)

    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, {
            BackgroundColor3 = Color3.fromRGB(255, 100, 100),
            Size = UDim2.new(0, 38, 0, 38)
        }, 0.1):Play()
    end)

    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, {
            BackgroundColor3 = VXHConfig.Colors.Error,
            Size = UDim2.new(0, 35, 0, 35)
        }, 0.1):Play()
    end)

    -- Window Methods
    function Window:CreateTab(name, image)
        local Tab = {
            Name = name,
            Image = image,
            Elements = {},
            Visible = false
        }

        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton_" .. name
        TabButton.Size = UDim2.new(1, 0, 0, 50)
        TabButton.BackgroundColor3 = VXHConfig.Colors.Background
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.ZIndex = 13
        TabButton.Parent = TabList

        CreateCorner(TabButton, 12)
        CreateStroke(TabButton, 1, VXHConfig.Colors.Border, 0.7)

        -- Tab Icon
        local TabIcon = Instance.new("TextLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.Size = UDim2.new(0, 28, 0, 28)
        TabIcon.Position = UDim2.new(0, 12, 0, 11)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Text = image or "📋"
        TabIcon.TextColor3 = VXHConfig.Colors.SubText
        TabIcon.TextSize = 20
        TabIcon.Font = VXHConfig.DefaultFont
        TabIcon.ZIndex = 14
        TabIcon.Parent = TabButton

        -- Tab Label
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "TabLabel"
        TabLabel.Size = UDim2.new(1, -50, 0, 28)
        TabLabel.Position = UDim2.new(0, 45, 0, 11)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = name
        TabLabel.TextColor3 = VXHConfig.Colors.SubText
        TabLabel.TextSize = 15
        TabLabel.Font = VXHConfig.DefaultFont
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.ZIndex = 14
        TabLabel.Parent = TabButton

        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. name
        TabContent.Size = UDim2.new(1, -10, 1, -10)
        TabContent.Position = UDim2.new(0, 5, 0, 5)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = VXHConfig.Colors.Primary
        TabContent.Visible = false
        TabContent.ZIndex = 13
        TabContent.Parent = ContentContainer

        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 10)
        TabContentLayout.Parent = TabContent

        local TabContentPadding = Instance.new("UIPadding")
        TabContentPadding.PaddingTop = UDim.new(0, 15)
        TabContentPadding.PaddingBottom = UDim.new(0, 15)
        TabContentPadding.PaddingLeft = UDim.new(0, 15)
        TabContentPadding.PaddingRight = UDim.new(0, 15)
        TabContentPadding.Parent = TabContent

        -- Tab Selection
        local function SelectTab()
            if CurrentTab then
                CurrentTab.Visible = false
                ContentContainer:FindFirstChild("TabContent_" .. CurrentTab.Name).Visible = false
                
                -- Reset previous tab button
                for _, child in pairs(TabList:GetChildren()) do
                    if child.Name == "TabButton_" .. CurrentTab.Name then
                        CreateTween(child, {BackgroundColor3 = VXHConfig.Colors.Background}):Play()
                        CreateTween(child.TabIcon, {TextColor3 = VXHConfig.Colors.SubText}):Play()
                        CreateTween(child.TabLabel, {TextColor3 = VXHConfig.Colors.SubText}):Play()
                        break
                    end
                end
            end

            CurrentTab = Tab
            Tab.Visible = true
            TabContent.Visible = true

            -- Highlight current tab button
            CreateTween(TabButton, {BackgroundColor3 = VXHConfig.Colors.Primary}):Play()
            CreateTween(TabIcon, {TextColor3 = VXHConfig.Colors.Text}):Play()
            CreateTween(TabLabel, {TextColor3 = VXHConfig.Colors.Text}):Play()
        end

        TabButton.MouseButton1Click:Connect(function()
            PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.2)
            SelectTab()
        end)

        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            if CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = VXHConfig.Colors.Hover}):Play()
                CreateTween(TabIcon, {TextColor3 = VXHConfig.Colors.Text}):Play()
                CreateTween(TabLabel, {TextColor3 = VXHConfig.Colors.Text}):Play()
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if CurrentTab ~= Tab then
                CreateTween(TabButton, {BackgroundColor3 = VXHConfig.Colors.Background}):Play()
                CreateTween(TabIcon, {TextColor3 = VXHConfig.Colors.SubText}):Play()
                CreateTween(TabLabel, {TextColor3 = VXHConfig.Colors.SubText}):Play()
            end
        end)

        -- Select first tab by default
        if not CurrentTab then
            SelectTab()
        end

        -- Tab Element Creation Methods
        function Tab:CreateSection(name)
            local Section = Instance.new("Frame")
            Section.Name = "Section_" .. name
            Section.Size = UDim2.new(1, 0, 0, 40)
            Section.BackgroundTransparency = 1
            Section.LayoutOrder = #Tab.Elements + 1
            Section.ZIndex = 14
            Section.Parent = TabContent

            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Name = "SectionLabel"
            SectionLabel.Size = UDim2.new(1, 0, 1, 0)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = name
            SectionLabel.TextColor3 = VXHConfig.Colors.Text
            SectionLabel.TextSize = 18
            SectionLabel.Font = VXHConfig.DefaultFont
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.ZIndex = 15
            SectionLabel.Parent = Section

            -- Add underline
            local Underline = Instance.new("Frame")
            Underline.Name = "Underline"
            Underline.Size = UDim2.new(0, 60, 0, 2)
            Underline.Position = UDim2.new(0, 0, 1, -5)
            Underline.BackgroundColor3 = VXHConfig.Colors.Primary
            Underline.BorderSizePixel = 0
            Underline.ZIndex = 15
            Underline.Parent = Section

            CreateCorner(Underline, 1)

            table.insert(Tab.Elements, Section)
            return Section
        end

        function Tab:CreateButton(config)
            local ButtonConfig = {
                Name = config.Name or "Button",
                Callback = config.Callback or function() end
            }

            local Button = Instance.new("TextButton")
            Button.Name = "Button_" .. ButtonConfig.Name
            Button.Size = UDim2.new(1, 0, 0, 50)
            Button.BackgroundColor3 = VXHConfig.Colors.Background
            Button.BorderSizePixel = 0
            Button.Text = ButtonConfig.Name
            Button.TextColor3 = VXHConfig.Colors.Text
            Button.TextSize = 16
            Button.Font = VXHConfig.DefaultFont
            Button.LayoutOrder = #Tab.Elements + 1
            Button.ZIndex = 14
            Button.Parent = TabContent

            CreateCorner(Button, 12)
            CreateStroke(Button, 1, VXHConfig.Colors.Border, 0.7)

            -- Enhanced gradient
            CreateGradient(Button, {
                ColorSequenceKeypoint.new(0, VXHConfig.Colors.Background),
                ColorSequenceKeypoint.new(1, VXHConfig.Colors.Card)
            }, 90)

            -- Button effects
            Button.MouseButton1Click:Connect(function()
                PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.4)
                
                CreateTween(Button, {
                    BackgroundColor3 = VXHConfig.Colors.Success,
                    TextColor3 = VXHConfig.Colors.Background
                }, 0.1):Play()
                
                wait(0.15)
                
                CreateTween(Button, {
                    BackgroundColor3 = VXHConfig.Colors.Background,
                    TextColor3 = VXHConfig.Colors.Text
                }, 0.1):Play()
                
                ButtonConfig.Callback()
            end)

            Button.MouseEnter:Connect(function()
                CreateTween(Button, {
                    BackgroundColor3 = VXHConfig.Colors.Hover,
                    Size = UDim2.new(1, 0, 0, 53)
                }, 0.1):Play()
            end)

            Button.MouseLeave:Connect(function()
                CreateTween(Button, {
                    BackgroundColor3 = VXHConfig.Colors.Background,
                    Size = UDim2.new(1, 0, 0, 50)
                }, 0.1):Play()
            end)

            table.insert(Tab.Elements, Button)
            return Button
        end

        function Tab:CreateToggle(config)
            local ToggleConfig = {
                Name = config.Name or "Toggle",
                CurrentValue = config.CurrentValue or false,
                Flag = config.Flag or "Toggle1",
                Callback = config.Callback or function() end
            }

            local Toggle = Instance.new("Frame")
            Toggle.Name = "Toggle_" .. ToggleConfig.Name
            Toggle.Size = UDim2.new(1, 0, 0, 50)
            Toggle.BackgroundColor3 = VXHConfig.Colors.Background
            Toggle.BorderSizePixel = 0
            Toggle.LayoutOrder = #Tab.Elements + 1
            Toggle.ZIndex = 14
            Toggle.Parent = TabContent

            CreateCorner(Toggle, 12)
            CreateStroke(Toggle, 1, VXHConfig.Colors.Border, 0.7)

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = ToggleConfig.Name
            ToggleLabel.TextColor3 = VXHConfig.Colors.Text
            ToggleLabel.TextSize = 16
            ToggleLabel.Font = VXHConfig.DefaultFont
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.ZIndex = 15
            ToggleLabel.Parent = Toggle

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Size = UDim2.new(0, 50, 0, 28)
            ToggleButton.Position = UDim2.new(1, -60, 0, 11)
            ToggleButton.BackgroundColor3 = ToggleConfig.CurrentValue and VXHConfig.Colors.Success or VXHConfig.Colors.Border
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.ZIndex = 15
            ToggleButton.Parent = Toggle

            CreateCorner(ToggleButton, 14)

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "ToggleIndicator"
            ToggleIndicator.Size = UDim2.new(0, 24, 0, 24)
            ToggleIndicator.Position = ToggleConfig.CurrentValue and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
            ToggleIndicator.BackgroundColor3 = VXHConfig.Colors.Text
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.ZIndex = 16
            ToggleIndicator.Parent = ToggleButton

            CreateCorner(ToggleIndicator, 12)
            CreateShadow(ToggleIndicator, 4, 0.3)

            ToggleButton.MouseButton1Click:Connect(function()
                ToggleConfig.CurrentValue = not ToggleConfig.CurrentValue
                
                PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.3)
                
                CreateTween(ToggleButton, {
                    BackgroundColor3 = ToggleConfig.CurrentValue and VXHConfig.Colors.Success or VXHConfig.Colors.Border
                }, 0.15):Play()
                
                CreateTween(ToggleIndicator, {
                    Position = ToggleConfig.CurrentValue and UDim2.new(0, 24, 0, 2) or UDim2.new(0, 2, 0, 2)
                }, 0.15):Play()
                
                ToggleConfig.Callback(ToggleConfig.CurrentValue)
            end)

            Toggle.MouseEnter:Connect(function()
                CreateTween(Toggle, {
                    BackgroundColor3 = VXHConfig.Colors.Hover,
                    Size = UDim2.new(1, 0, 0, 53)
                }, 0.1):Play()
            end)

            Toggle.MouseLeave:Connect(function()
                CreateTween(Toggle, {
                    BackgroundColor3 = VXHConfig.Colors.Background,
                    Size = UDim2.new(1, 0, 0, 50)
                }, 0.1):Play()
            end)

            table.insert(Tab.Elements, Toggle)
            return Toggle
        end

      function Tab:CreateSlider(options)
    local slider = Instance.new("Frame")
    slider.Name = "Slider"
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.BackgroundTransparency = 1
    slider.Parent = self.Content

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = options.Name or "Slider"
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = slider

    local sliderFrame = Instance.new("TextButton")
    sliderFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
    sliderFrame.Position = UDim2.new(0.45, 0, 0.35, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderFrame.Text = ""
    sliderFrame.AutoButtonColor = false
    sliderFrame.Parent = slider

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((options.Default - options.Min) / (options.Max - options.Min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    fill.BorderSizePixel = 0
    fill.Parent = sliderFrame

    local dragging = false

    local function update(input)
        local relativeX = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(relativeX, 0, 1, 0)

        local value = math.floor((options.Min + (options.Max - options.Min) * relativeX) / (options.Increment or 1)) * (options.Increment or 1)

        if options.Callback then
            options.Callback(value)
        end
    end

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

            }

            local Slider = Instance.new("Frame")
            Slider.Name = "Slider_" .. SliderConfig.Name
            Slider.Size = UDim2.new(1, 0, 0, 70)
            Slider.BackgroundColor3 = VXHConfig.Colors.Background
            Slider.BorderSizePixel = 0
            Slider.LayoutOrder = #Tab.Elements + 1
            Slider.ZIndex = 14
            Slider.Parent = TabContent

            CreateCorner(Slider, 12)
            CreateStroke(Slider, 1, VXHConfig.Colors.Border, 0.7)

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "SliderLabel"
            SliderLabel.Size = UDim2.new(1, -20, 0, 25)
            SliderLabel.Position = UDim2.new(0, 15, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = SliderConfig.Name
            SliderLabel.TextColor3 = VXHConfig.Colors.Text
            SliderLabel.TextSize = 16
            SliderLabel.Font = VXHConfig.DefaultFont
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.ZIndex = 15
            SliderLabel.Parent = Slider

            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "SliderValue"
            SliderValue.Size = UDim2.new(0, 60, 0, 25)
            SliderValue.Position = UDim2.new(1, -75, 0, 5)
            SliderValue.BackgroundColor3 = VXHConfig.Colors.Primary
            SliderValue.BorderSizePixel = 0
            SliderValue.Text = tostring(SliderConfig.CurrentValue)
            SliderValue.TextColor3 = VXHConfig.Colors.Text
            SliderValue.TextSize = 14
            SliderValue.Font = VXHConfig.DefaultFont
            SliderValue.ZIndex = 15
            SliderValue.Parent = Slider

            CreateCorner(SliderValue, 6)

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "SliderTrack"
            SliderTrack.Size = UDim2.new(1, -30, 0, 6)
            SliderTrack.Position = UDim2.new(0, 15, 0, 45)
            SliderTrack.BackgroundColor3 = VXHConfig.Colors.Border
            SliderTrack.BorderSizePixel = 0
            SliderTrack.ZIndex = 15
            SliderTrack.Parent = Slider

            CreateCorner(SliderTrack, 3)

            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "SliderFill"
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.BackgroundColor3 = VXHConfig.Colors.Primary
            SliderFill.BorderSizePixel = 0
            SliderFill.ZIndex = 16
            SliderFill.Parent = SliderTrack

            CreateCorner(SliderFill, 3)

            local SliderButton = Instance.new("TextButton")
            SliderButton.Name = "SliderButton"
            SliderButton.Size = UDim2.new(0, 16, 0, 16)
            SliderButton.Position = UDim2.new(0, -5, 0, -5)
            SliderButton.BackgroundColor3 = VXHConfig.Colors.Text
            SliderButton.BorderSizePixel = 0
            SliderButton.Text = ""
            SliderButton.ZIndex = 17
            SliderButton.Parent = SliderFill

            CreateCorner(SliderButton, 8)
            CreateShadow(SliderButton, 4, 0.3)

            -- Slider functionality
            local function UpdateSlider(value)
                local percent = (value - SliderConfig.Range[1]) / (SliderConfig.Range[2] - SliderConfig.Range[1])
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderValue.Text = tostring(value)
                SliderConfig.CurrentValue = value
                SliderConfig.Callback(value)
            end

            local dragging = false
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = math.clamp((Mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local value = SliderConfig.Range[1] + (SliderConfig.Range[2] - SliderConfig.Range[1]) * percent
                    value = math.floor(value / SliderConfig.Increment) * SliderConfig.Increment
                    UpdateSlider(value)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            -- Initialize slider
            UpdateSlider(SliderConfig.CurrentValue)

            table.insert(Tab.Elements, Slider)
            return Slider
        end

        function Tab:CreateDropdown(config)
            local DropdownConfig = {
                Name = config.Name or "Dropdown",
                Options = config.Options or {"Option 1", "Option 2", "Option 3"},
                CurrentOption = config.CurrentOption or config.Options[1],
                Flag = config.Flag or "Dropdown1",
                Callback = config.Callback or function() end
            }

            local Dropdown = Instance.new("Frame")
            Dropdown.Name = "Dropdown_" .. DropdownConfig.Name
            Dropdown.Size = UDim2.new(1, 0, 0, 50)
            Dropdown.BackgroundColor3 = VXHConfig.Colors.Background
            Dropdown.BorderSizePixel = 0
            Dropdown.LayoutOrder = #Tab.Elements + 1
            Dropdown.ZIndex = 14
            Dropdown.Parent = TabContent

            CreateCorner(Dropdown, 12)
            CreateStroke(Dropdown, 1, VXHConfig.Colors.Border, 0.7)

            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Name = "DropdownLabel"
            DropdownLabel.Size = UDim2.new(0, 150, 1, 0)
            DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = DropdownConfig.Name
            DropdownLabel.TextColor3 = VXHConfig.Colors.Text
            DropdownLabel.TextSize = 16
            DropdownLabel.Font = VXHConfig.DefaultFont
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.ZIndex = 15
            DropdownLabel.Parent = Dropdown

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Size = UDim2.new(1, -170, 0, 35)
            DropdownButton.Position = UDim2.new(0, 160, 0, 7.5)
            DropdownButton.BackgroundColor3 = VXHConfig.Colors.Card
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Text = DropdownConfig.CurrentOption
            DropdownButton.TextColor3 = VXHConfig.Colors.Text
            DropdownButton.TextSize = 14
            DropdownButton.Font = VXHConfig.DefaultFont
            DropdownButton.ZIndex = 15
            DropdownButton.Parent = Dropdown

            CreateCorner(DropdownButton, 8)
            CreateStroke(DropdownButton, 1, VXHConfig.Colors.Border, 0.5)

            -- Dropdown functionality would be implemented here
            -- For now, just basic button functionality
            DropdownButton.MouseButton1Click:Connect(function()
                PlaySound("rbxasset://sounds/electronicpingshort.wav", 0.3)
                print("Dropdown clicked:", DropdownConfig.Name)
            end)

            table.insert(Tab.Elements, Dropdown)
            return Dropdown
        end

        function Tab:CreateTextbox(config)
            local TextboxConfig = {
                Name = config.Name or "Textbox",
                CurrentText = config.CurrentText or "",
                PlaceholderText = config.PlaceholderText or "Enter text...",
                Flag = config.Flag or "Textbox1",
                Callback = config.Callback or function() end
            }

            local Textbox = Instance.new("Frame")
            Textbox.Name = "Textbox_" .. TextboxConfig.Name
            Textbox.Size = UDim2.new(1, 0, 0, 50)
            Textbox.BackgroundColor3 = VXHConfig.Colors.Background
            Textbox.BorderSizePixel = 0
            Textbox.LayoutOrder = #Tab.Elements + 1
            Textbox.ZIndex = 14
            Textbox.Parent = TabContent

            CreateCorner(Textbox, 12)
            CreateStroke(Textbox, 1, VXHConfig.Colors.Border, 0.7)

            local TextboxLabel = Instance.new("TextLabel")
            TextboxLabel.Name = "TextboxLabel"
            TextboxLabel.Size = UDim2.new(0, 150, 1, 0)
            TextboxLabel.Position = UDim2.new(0, 15, 0, 0)
            TextboxLabel.BackgroundTransparency = 1
            TextboxLabel.Text = TextboxConfig.Name
            TextboxLabel.TextColor3 = VXHConfig.Colors.Text
            TextboxLabel.TextSize = 16
            TextboxLabel.Font = VXHConfig.DefaultFont
            TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextboxLabel.ZIndex = 15
            TextboxLabel.Parent = Textbox

            local TextboxInput = Instance.new("TextBox")
            TextboxInput.Name = "TextboxInput"
            TextboxInput.Size = UDim2.new(1, -170, 0, 35)
            TextboxInput.Position = UDim2.new(0, 160, 0, 7.5)
            TextboxInput.BackgroundColor3 = VXHConfig.Colors.Card
            TextboxInput.BorderSizePixel = 0
            TextboxInput.Text = TextboxConfig.CurrentText
            TextboxInput.PlaceholderText = TextboxConfig.PlaceholderText
            TextboxInput.TextColor3 = VXHConfig.Colors.Text
            TextboxInput.PlaceholderColor3 = VXHConfig.Colors.SubText
            TextboxInput.TextSize = 14
            TextboxInput.Font = VXHConfig.DefaultFont
            TextboxInput.ZIndex = 15
            TextboxInput.Parent = Textbox

            CreateCorner(TextboxInput, 8)
            CreateStroke(TextboxInput, 1, VXHConfig.Colors.Border, 0.5)

            TextboxInput.FocusLost:Connect(function()
                TextboxConfig.CurrentText = TextboxInput.Text
                TextboxConfig.Callback(TextboxInput.Text)
            end)

            table.insert(Tab.Elements, Textbox)
            return Textbox
        end

        return Tab
    end

    -- Update canvas sizes
    spawn(function()
        while TabList.Parent do
            TabList.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 10)
            wait(0.1)
        end
    end)

    print("VXH Enhanced Framework v" .. VXHConfig.Version .. " loaded!")
    print("Toggle Key: " .. VXHConfig.ToggleKey.Name)
    print("Framework ready for script hub developers!")
    
    return Window
end

return VXH
