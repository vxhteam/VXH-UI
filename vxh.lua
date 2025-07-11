local VXH = {
    Version = "2.0.0",
    Flags = {},
    Themes = {},
    Windows = {}
}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Configuration
local VXHConfig = {
    Version = "1.0.0",
    Creator = "VXH Team",
    DefaultFont = Enum.Font.Gotham,
    DefaultFontSize = 14,
    AnimationSpeed = 0.3,
    Colors = {
        Primary = Color3.fromRGB(59, 130, 246),
        Secondary = Color3.fromRGB(99, 102, 241),
        Tertiary = Color3.fromRGB(139, 92, 246),
        Background = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(156, 163, 175),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Border = Color3.fromRGB(75, 85, 99)
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

-- Main VXH Object
function VXH:CreateWindow(config)
    local WindowConfig = {
        Name = config.Name or "VXH Script Hub",
        LoadingTitle = config.LoadingTitle or "VXH Interface Suite",
        LoadingSubtitle = config.LoadingSubtitle or "by VXH Team",
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
    local WindowFrame = {}
    local Tabs = {}
    local CurrentTab = nil

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VXH_" .. HttpService:GenerateGUID(false)
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 580, 0, 460)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -230)
    MainFrame.BackgroundColor3 = VXHConfig.Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true

    CreateCorner(MainFrame, 12)
    CreateStroke(MainFrame, 1, VXHConfig.Colors.Border, 0.5)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = VXHConfig.Colors.Card
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    CreateCorner(TitleBar, 12)
    CreateGradient(TitleBar, {
        ColorSequenceKeypoint.new(0, VXHConfig.Colors.Primary),
        ColorSequenceKeypoint.new(1, VXHConfig.Colors.Secondary)
    }, 45)

    -- VXH Logo/Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "VXH " .. WindowConfig.Name
    Title.TextColor3 = VXHConfig.Colors.Text
    Title.TextScaled = true
    Title.TextWrapped = true
    Title.Font = VXHConfig.DefaultFont
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.BackgroundColor3 = VXHConfig.Colors.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = VXHConfig.Colors.Text
    CloseButton.TextScaled = true
    CloseButton.Font = VXHConfig.DefaultFont
    CloseButton.Parent = TitleBar

    CreateCorner(CloseButton, 6)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 160, 1, -60)
    TabContainer.Position = UDim2.new(0, 10, 0, 60)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    -- Tab List
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, 0, 1, 0)
    TabList.Position = UDim2.new(0, 0, 0, 0)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 6
    TabList.ScrollBarImageColor3 = VXHConfig.Colors.Primary
    TabList.Parent = TabContainer

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8)
    TabListLayout.Parent = TabList

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -180, 1, -60)
    ContentContainer.Position = UDim2.new(0, 170, 0, 60)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

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
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = VXHConfig.Colors.Card
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.Parent = TabList

        CreateCorner(TabButton, 8)
        CreateStroke(TabButton, 1, VXHConfig.Colors.Border, 0.7)

        -- Tab Icon
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0, 10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = image or "rbxassetid://4483345998"
        TabIcon.ImageColor3 = VXHConfig.Colors.SubText
        TabIcon.Parent = TabButton

        -- Tab Label
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "TabLabel"
        TabLabel.Size = UDim2.new(1, -40, 1, 0)
        TabLabel.Position = UDim2.new(0, 35, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = name
        TabLabel.TextColor3 = VXHConfig.Colors.SubText
        TabLabel.TextScaled = true
        TabLabel.Font = VXHConfig.DefaultFont
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabButton

        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent_" .. name
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Position = UDim2.new(0, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 6
        TabContent.ScrollBarImageColor3 = VXHConfig.Colors.Primary
        TabContent.Visible = false
        TabContent.Parent = ContentContainer

        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 8)
        TabContentLayout.Parent = TabContent

        local TabContentPadding = Instance.new("UIPadding")
        TabContentPadding.PaddingTop = UDim.new(0, 10)
        TabContentPadding.PaddingBottom = UDim.new(0, 10)
        TabContentPadding.PaddingLeft = UDim.new(0, 10)
        TabContentPadding.PaddingRight = UDim.new(0, 10)
        TabContentPadding.Parent = TabContent

        -- Tab Selection
        local function SelectTab()
            if CurrentTab then
                CurrentTab.Visible = false
                ContentContainer:FindFirstChild("TabContent_" .. CurrentTab.Name).Visible = false
                
                -- Reset previous tab button
                for _, child in pairs(TabList:GetChildren()) do
                    if child.Name == "TabButton_" .. CurrentTab.Name then
                        CreateTween(child, {BackgroundColor3 = VXHConfig.Colors.Card}):Play()
                        CreateTween(child.TabIcon, {ImageColor3 = VXHConfig.Colors.SubText}):Play()
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
            CreateTween(TabIcon, {ImageColor3 = VXHConfig.Colors.Text}):Play()
            CreateTween(TabLabel, {TextColor3 = VXHConfig.Colors.Text}):Play()
        end

        TabButton.MouseButton1Click:Connect(SelectTab)

        -- If this is the first tab, select it
        if not CurrentTab then
            SelectTab()
        end

        -- Tab Element Creation Methods
        function Tab:CreateSection(name)
            local Section = Instance.new("Frame")
            Section.Name = "Section_" .. name
            Section.Size = UDim2.new(1, 0, 0, 30)
            Section.BackgroundTransparency = 1
            Section.LayoutOrder = #Tab.Elements + 1
            Section.Parent = TabContent

            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Name = "SectionLabel"
            SectionLabel.Size = UDim2.new(1, 0, 1, 0)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = name
            SectionLabel.TextColor3 = VXHConfig.Colors.Text
            SectionLabel.TextScaled = true
            SectionLabel.Font = VXHConfig.DefaultFont
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = Section

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
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.BackgroundColor3 = VXHConfig.Colors.Card
            Button.BorderSizePixel = 0
            Button.Text = ButtonConfig.Name
            Button.TextColor3 = VXHConfig.Colors.Text
            Button.TextScaled = true
            Button.Font = VXHConfig.DefaultFont
            Button.LayoutOrder = #Tab.Elements + 1
            Button.Parent = TabContent

            CreateCorner(Button, 8)
            CreateStroke(Button, 1, VXHConfig.Colors.Border, 0.7)

            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, {BackgroundColor3 = VXHConfig.Colors.Primary}):Play()
                wait(0.1)
                CreateTween(Button, {BackgroundColor3 = VXHConfig.Colors.Card}):Play()
                ButtonConfig.Callback()
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
            Toggle.Size = UDim2.new(1, 0, 0, 40)
            Toggle.BackgroundColor3 = VXHConfig.Colors.Card
            Toggle.BorderSizePixel = 0
            Toggle.LayoutOrder = #Tab.Elements + 1
            Toggle.Parent = TabContent

            CreateCorner(Toggle, 8)
            CreateStroke(Toggle, 1, VXHConfig.Colors.Border, 0.7)

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = ToggleConfig.Name
            ToggleLabel.TextColor3 = VXHConfig.Colors.Text
            ToggleLabel.TextScaled = true
            ToggleLabel.Font = VXHConfig.DefaultFont
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = Toggle

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Size = UDim2.new(0, 30, 0, 20)
            ToggleButton.Position = UDim2.new(1, -40, 0, 10)
            ToggleButton.BackgroundColor3 = ToggleConfig.CurrentValue and VXHConfig.Colors.Success or VXHConfig.Colors.Border
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = Toggle

            CreateCorner(ToggleButton, 10)

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "ToggleIndicator"
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = ToggleConfig.CurrentValue and UDim2.new(0, 12, 0, 2) or UDim2.new(0, 2, 0, 2)
            ToggleIndicator.BackgroundColor3 = VXHConfig.Colors.Text
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton

            CreateCorner(ToggleIndicator, 8)

            ToggleButton.MouseButton1Click:Connect(function()
                ToggleConfig.CurrentValue = not ToggleConfig.CurrentValue
                
                CreateTween(ToggleButton, {
                    BackgroundColor3 = ToggleConfig.CurrentValue and VXHConfig.Colors.Success or VXHConfig.Colors.Border
                }):Play()
                
                CreateTween(ToggleIndicator, {
                    Position = ToggleConfig.CurrentValue and UDim2.new(0, 12, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
                
                ToggleConfig.Callback(ToggleConfig.CurrentValue)
            end)

            table.insert(Tab.Elements, Toggle)
            return Toggle
        end

        function Tab:CreateSlider(config)
            local SliderConfig = {
                Name = config.Name or "Slider",
                Range = config.Range or {0, 100},
                Increment = config.Increment or 1,
                Suffix = config.Suffix or "",
                CurrentValue = config.CurrentValue or 0,
                Flag = config.Flag or "Slider1",
                Callback = config.Callback or function() end
            }

            local Slider = Instance.new("Frame")
            Slider.Name = "Slider_" .. SliderConfig.Name
            Slider.Size = UDim2.new(1, 0, 0, 50)
            Slider.BackgroundColor3 = VXHConfig.Colors.Card
            Slider.BorderSizePixel = 0
            Slider.LayoutOrder = #Tab.Elements + 1
            Slider.Parent = TabContent

            CreateCorner(Slider, 8)
            CreateStroke(Slider, 1, VXHConfig.Colors.Border, 0.7)

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "SliderLabel"
            SliderLabel.Size = UDim2.new(1, -100, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = SliderConfig.Name
            SliderLabel.TextColor3 = VXHConfig.Colors.Text
            SliderLabel.TextScaled = true
            SliderLabel.Font = VXHConfig.DefaultFont
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = Slider

            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "SliderValue"
            SliderValue.Size = UDim2.new(0, 80, 0, 20)
            SliderValue.Position = UDim2.new(1, -90, 0, 5)
            SliderValue.BackgroundTransparency = 1
            SliderValue.Text = SliderConfig.CurrentValue .. SliderConfig.Suffix
            SliderValue.TextColor3 = VXHConfig.Colors.Primary
            SliderValue.TextScaled = true
            SliderValue.Font = VXHConfig.DefaultFont
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.Parent = Slider

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "SliderTrack"
            SliderTrack.Size = UDim2.new(1, -20, 0, 4)
            SliderTrack.Position = UDim2.new(0, 10, 0, 30)
            SliderTrack.BackgroundColor3 = VXHConfig.Colors.Border
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = Slider

            CreateCorner(SliderTrack, 2)

            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "SliderFill"
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.BackgroundColor3 = VXHConfig.Colors.Primary
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack

            CreateCorner(SliderFill, 2)

            local SliderButton = Instance.new("TextButton")
            SliderButton.Name = "SliderButton"
            SliderButton.Size = UDim2.new(1, 0, 0, 30)
            SliderButton.Position = UDim2.new(0, 0, 0, 20)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = Slider

            local function UpdateSlider(value)
                value = math.clamp(value, SliderConfig.Range[1], SliderConfig.Range[2])
                value = math.floor(value / SliderConfig.Increment) * SliderConfig.Increment
                SliderConfig.CurrentValue = value
                
                local percentage = (value - SliderConfig.Range[1]) / (SliderConfig.Range[2] - SliderConfig.Range[1])
                SliderValue.Text = value .. SliderConfig.Suffix
                
                CreateTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                SliderConfig.Callback(value)
            end

            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local function Update()
                        local mousePos = Mouse.X
                        local sliderPos = SliderTrack.AbsolutePosition.X
                        local sliderSize = SliderTrack.AbsoluteSize.X
                        local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                        local value = SliderConfig.Range[1] + (SliderConfig.Range[2] - SliderConfig.Range[1]) * percentage
                        UpdateSlider(value)
                    end
                    
                    Update()
                    
                    local connection
                    connection = Mouse.Move:Connect(Update)
                    
                    UserInputService.InputEnded:Connect(function(endInput)
                        if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                            connection:Disconnect()
                        end
                    end)
                end
            end)

            UpdateSlider(SliderConfig.CurrentValue)
            table.insert(Tab.Elements, Slider)
            return Slider
        end

        function Tab:CreateInput(config)
            local InputConfig = {
                Name = config.Name or "Input",
                PlaceholderText = config.PlaceholderText or "Input text",
                NumbersOnly = config.NumbersOnly or false,
                OnEnter = config.OnEnter or false,
                RemoveTextAfterFocusLost = config.RemoveTextAfterFocusLost or false,
                Flag = config.Flag or ("Input" .. tostring(#Tab.Elements + 1)),
                Callback = config.Callback or function() end
            }

            local Input = Instance.new("Frame")
            Input.Name = "Input_" .. InputConfig.Name
            Input.Size = UDim2.new(1, 0, 0, 50)
            Input.BackgroundColor3 = VXHConfig.Colors.Card
            Input.BorderSizePixel = 0
            Input.LayoutOrder = #Tab.Elements + 1
            Input.Parent = TabContent

            CreateCorner(Input, 8)
            CreateStroke(Input, 1, VXHConfig.Colors.Border, 0.7)

            local InputLabel = Instance.new("TextLabel")
            InputLabel.Name = "InputLabel"
            InputLabel.Size = UDim2.new(1, -10, 0, 20)
            InputLabel.Position = UDim2.new(0, 10, 0, 5)
            InputLabel.BackgroundTransparency = 1
            InputLabel.Text = InputConfig.Name
            InputLabel.TextColor3 = VXHConfig.Colors.Text
            InputLabel.TextScaled = true
            InputLabel.Font = VXHConfig.DefaultFont
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left
            InputLabel.Parent = Input

            local InputBox = Instance.new("TextBox")
            InputBox.Name = "InputBox"
            InputBox.Size = UDim2.new(1, -20, 0, 20)
            InputBox.Position = UDim2.new(0, 10, 0, 25)
            InputBox.BackgroundColor3 = VXHConfig.Colors.Background
            InputBox.BorderSizePixel = 0
            InputBox.PlaceholderText = InputConfig.PlaceholderText
            InputBox.PlaceholderColor3 = VXHConfig.Colors.SubText
            InputBox.Text = ""
            InputBox.TextColor3 = VXHConfig.Colors.Text
            InputBox.TextScaled = true
            InputBox.Font = VXHConfig.DefaultFont
            InputBox.TextXAlignment = Enum.TextXAlignment.Left
            InputBox.Parent = Input

            CreateCorner(InputBox, 4)

            if InputConfig.NumbersOnly then
                InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    InputBox.Text = InputBox.Text:gsub("%D", "")
                end)
            end

            local function HandleInput()
                local text = InputBox.Text
                VXH.Flags[InputConfig.Flag] = text
                if InputConfig.RemoveTextAfterFocusLost then
                    InputBox.Text = ""
                end
                InputConfig.Callback(text)
            end

            if InputConfig.OnEnter then
                InputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        HandleInput()
                    end
                end)
            else
                InputBox.FocusLost:Connect(HandleInput)
            end

            -- Add to flags system
            VXH.Flags[InputConfig.Flag] = InputBox.Text
            Input.CurrentValue = InputBox.Text

            table.insert(Tab.Elements, Input)
            return Input
        end

        function Tab:CreateDropdown(config)
            local DropdownConfig = {
                Name = config.Name or "Dropdown",
                Options = config.Options or {"Option 1", "Option 2"},
                CurrentOption = config.CurrentOption or config.Options[1],
                Flag = config.Flag or ("Dropdown" .. tostring(#Tab.Elements + 1)),
                Callback = config.Callback or function() end
            }

            local Dropdown = Instance.new("Frame")
            Dropdown.Name = "Dropdown_" .. DropdownConfig.Name
            Dropdown.Size = UDim2.new(1, 0, 0, 50)
            Dropdown.BackgroundColor3 = VXHConfig.Colors.Card
            Dropdown.BorderSizePixel = 0
            Dropdown.LayoutOrder = #Tab.Elements + 1
            Dropdown.Parent = TabContent

            CreateCorner(Dropdown, 8)
            CreateStroke(Dropdown, 1, VXHConfig.Colors.Border, 0.7)

            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Name = "DropdownLabel"
            DropdownLabel.Size = UDim2.new(1, -10, 0, 20)
            DropdownLabel.Position = UDim2.new(0, 10, 0, 5)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = DropdownConfig.Name
            DropdownLabel.TextColor3 = VXHConfig.Colors.Text
            DropdownLabel.TextScaled = true
            DropdownLabel.Font = VXHConfig.DefaultFont
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = Dropdown

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Size = UDim2.new(1, -20, 0, 20)
            DropdownButton.Position = UDim2.new(0, 10, 0, 25)
            DropdownButton.BackgroundColor3 = VXHConfig.Colors.Background
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Text = DropdownConfig.CurrentOption .. " ▼"
            DropdownButton.TextColor3 = VXHConfig.Colors.Text
            DropdownButton.TextScaled = true
            DropdownButton.Font = VXHConfig.DefaultFont
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            DropdownButton.Parent = Dropdown

            CreateCorner(DropdownButton, 4)

            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(1, -20, 0, #DropdownConfig.Options * 25)
            DropdownList.Position = UDim2.new(0, 10, 1, 5)
            DropdownList.BackgroundColor3 = VXHConfig.Colors.Background
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.Parent = Dropdown
            DropdownList.ZIndex = 10

            CreateCorner(DropdownList, 4)
            CreateStroke(DropdownList, 1, VXHConfig.Colors.Border, 0.7)

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownListLayout.Parent = DropdownList

            for i, option in ipairs(DropdownConfig.Options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option_" .. option
                OptionButton.Size = UDim2.new(1, 0, 0, 25)
                OptionButton.BackgroundColor3 = VXHConfig.Colors.Background
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.TextColor3 = VXHConfig.Colors.Text
                OptionButton.TextScaled = true
                OptionButton.Font = VXHConfig.DefaultFont
                OptionButton.LayoutOrder = i
                OptionButton.Parent = DropdownList

                OptionButton.MouseButton1Click:Connect(function()
                    DropdownConfig.CurrentOption = option
                    DropdownButton.Text = option .. " ▼"
                    DropdownList.Visible = false
                    VXH.Flags[DropdownConfig.Flag] = option
                    DropdownConfig.Callback(option)
                end)

                OptionButton.MouseEnter:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = VXHConfig.Colors.Card}):Play()
                end)

                OptionButton.MouseLeave:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = VXHConfig.Colors.Background}):Play()
                end)
            end

            DropdownButton.MouseButton1Click:Connect(function()
                DropdownList.Visible = not DropdownList.Visible
                DropdownButton.Text = DropdownConfig.CurrentOption .. (DropdownList.Visible and " ▲" or " ▼")
            end)

            -- Add to flags system
            VXH.Flags[DropdownConfig.Flag] = DropdownConfig.CurrentOption
            Dropdown.CurrentOption = DropdownConfig.CurrentOption

            table.insert(Tab.Elements, Dropdown)
            return Dropdown
        end

        function Tab:CreateColorPicker(config)
            local ColorPickerConfig = {
                Name = config.Name or "Color Picker",
                Color = config.Color or Color3.fromRGB(255, 255, 255),
                Flag = config.Flag or ("ColorPicker" .. tostring(#Tab.Elements + 1)),
                Callback = config.Callback or function() end
            }

            local ColorPicker = Instance.new("Frame")
            ColorPicker.Name = "ColorPicker_" .. ColorPickerConfig.Name
            ColorPicker.Size = UDim2.new(1, 0, 0, 50)
            ColorPicker.BackgroundColor3 = VXHConfig.Colors.Card
            ColorPicker.BorderSizePixel = 0
            ColorPicker.LayoutOrder = #Tab.Elements + 1
            ColorPicker.Parent = TabContent

            CreateCorner(ColorPicker, 8)
            CreateStroke(ColorPicker, 1, VXHConfig.Colors.Border, 0.7)

            local ColorPickerLabel = Instance.new("TextLabel")
            ColorPickerLabel.Name = "ColorPickerLabel"
            ColorPickerLabel.Size = UDim2.new(1, -60, 0, 20)
            ColorPickerLabel.Position = UDim2.new(0, 10, 0, 5)
            ColorPickerLabel.BackgroundTransparency = 1
            ColorPickerLabel.Text = ColorPickerConfig.Name
            ColorPickerLabel.TextColor3 = VXHConfig.Colors.Text
            ColorPickerLabel.TextScaled = true
            ColorPickerLabel.Font = VXHConfig.DefaultFont
            ColorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left
            ColorPickerLabel.Parent = ColorPicker

            local ColorPreview = Instance.new("Frame")
            ColorPreview.Name = "ColorPreview"
            ColorPreview.Size = UDim2.new(0, 40, 0, 40)
            ColorPreview.Position = UDim2.new(1, -50, 0, 5)
            ColorPreview.BackgroundColor3 = ColorPickerConfig.Color
            ColorPreview.BorderSizePixel = 0
            ColorPreview.Parent = ColorPicker

            CreateCorner(ColorPreview, 6)
            CreateStroke(ColorPreview, 1, VXHConfig.Colors.Border, 0.7)

            local ColorButton = Instance.new("TextButton")
            ColorButton.Name = "ColorButton"
            ColorButton.Size = UDim2.new(1, 0, 1, 0)
            ColorButton.BackgroundTransparency = 1
            ColorButton.Text = ""
            ColorButton.Parent = ColorPreview

            -- Simple color picker (you can enhance this with a full color wheel)
            local colors = {
                Color3.fromRGB(255, 0, 0),    -- Red
                Color3.fromRGB(0, 255, 0),    -- Green
                Color3.fromRGB(0, 0, 255),    -- Blue
                Color3.fromRGB(255, 255, 0),  -- Yellow
                Color3.fromRGB(255, 0, 255),  -- Magenta
                Color3.fromRGB(0, 255, 255),  -- Cyan
                Color3.fromRGB(255, 255, 255), -- White
                Color3.fromRGB(0, 0, 0)       -- Black
            }

            local currentColorIndex = 1
            ColorButton.MouseButton1Click:Connect(function()
                currentColorIndex = currentColorIndex % #colors + 1
                ColorPickerConfig.Color = colors[currentColorIndex]
                ColorPreview.BackgroundColor3 = ColorPickerConfig.Color
                VXH.Flags[ColorPickerConfig.Flag] = ColorPickerConfig.Color
                ColorPickerConfig.Callback(ColorPickerConfig.Color)
            end)

            -- Add to flags system
            VXH.Flags[ColorPickerConfig.Flag] = ColorPickerConfig.Color
            ColorPicker.CurrentColor = ColorPickerConfig.Color

            table.insert(Tab.Elements, ColorPicker)
            return ColorPicker
        end

        function Tab:CreateKeybind(config)
            local KeybindConfig = {
                Name = config.Name or "Keybind",
                CurrentKeybind = config.CurrentKeybind or "None",
                HoldToInteract = config.HoldToInteract or false,
                Flag = config.Flag or ("Keybind" .. tostring(#Tab.Elements + 1)),
                Callback = config.Callback or function() end
            }

            local Keybind = Instance.new("Frame")
            Keybind.Name = "Keybind_" .. KeybindConfig.Name
            Keybind.Size = UDim2.new(1, 0, 0, 50)
            Keybind.BackgroundColor3 = VXHConfig.Colors.Card
            Keybind.BorderSizePixel = 0
            Keybind.LayoutOrder = #Tab.Elements + 1
            Keybind.Parent = TabContent

            CreateCorner(Keybind, 8)
            CreateStroke(Keybind, 1, VXHConfig.Colors.Border, 0.7)

            local KeybindLabel = Instance.new("TextLabel")
            KeybindLabel.Name = "KeybindLabel"
            KeybindLabel.Size = UDim2.new(1, -80, 0, 20)
            KeybindLabel.Position = UDim2.new(0, 10, 0, 5)
            KeybindLabel.BackgroundTransparency = 1
            KeybindLabel.Text = KeybindConfig.Name
            KeybindLabel.TextColor3 = VXHConfig.Colors.Text
            KeybindLabel.TextScaled = true
            KeybindLabel.Font = VXHConfig.DefaultFont
            KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            KeybindLabel.Parent = Keybind

            local KeybindButton = Instance.new("TextButton")
            KeybindButton.Name = "KeybindButton"
            KeybindButton.Size = UDim2.new(0, 60, 0, 20)
            KeybindButton.Position = UDim2.new(1, -70, 0, 15)
            KeybindButton.BackgroundColor3 = VXHConfig.Colors.Background
            KeybindButton.BorderSizePixel = 0
            KeybindButton.Text = KeybindConfig.CurrentKeybind
            KeybindButton.TextColor3 = VXHConfig.Colors.Text
            KeybindButton.TextScaled = true
            KeybindButton.Font = VXHConfig.DefaultFont
            KeybindButton.Parent = Keybind

            CreateCorner(KeybindButton, 4)

            local listening = false
            KeybindButton.MouseButton1Click:Connect(function()
                if listening then return end
                listening = true
                KeybindButton.Text = "..."
                
                local connection
                connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    local keyName = input.KeyCode.Name
                    if keyName ~= "Unknown" then
                        KeybindConfig.CurrentKeybind = keyName
                        KeybindButton.Text = keyName
                        VXH.Flags[KeybindConfig.Flag] = keyName
                        listening = false
                        connection:Disconnect()
                    end
                end)
            end)

            -- Handle keybind activation
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode.Name == KeybindConfig.CurrentKeybind then
                    if not KeybindConfig.HoldToInteract then
                        KeybindConfig.Callback()
                    end
                end
            end)

            if KeybindConfig.HoldToInteract then
                UserInputService.InputEnded:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    if input.KeyCode.Name == KeybindConfig.CurrentKeybind then
                        KeybindConfig.Callback()
                    end
                end)
            end

            -- Add to flags system
            VXH.Flags[KeybindConfig.Flag] = KeybindConfig.CurrentKeybind
            Keybind.CurrentKeybind = KeybindConfig.CurrentKeybind

            table.insert(Tab.Elements, Keybind)
            return Keybind
        end

        function Tab:CreateLabel(config)
            local LabelConfig = {
                Name = config.Name or "Label",
                Text = config.Text or config.Name or "Label Text"
            }

            local Label = Instance.new("Frame")
            Label.Name = "Label_" .. LabelConfig.Name
            Label.Size = UDim2.new(1, 0, 0, 30)
            Label.BackgroundTransparency = 1
            Label.LayoutOrder = #Tab.Elements + 1
            Label.Parent = TabContent

            local LabelText = Instance.new("TextLabel")
            LabelText.Name = "LabelText"
            LabelText.Size = UDim2.new(1, -10, 1, 0)
            LabelText.Position = UDim2.new(0, 10, 0, 0)
            LabelText.BackgroundTransparency = 1
            LabelText.Text = LabelConfig.Text
            LabelText.TextColor3 = VXHConfig.Colors.SubText
            LabelText.TextScaled = true
            LabelText.Font = VXHConfig.DefaultFont
            LabelText.TextXAlignment = Enum.TextXAlignment.Left
            LabelText.Parent = Label

            table.insert(Tab.Elements, Label)
            return Label
        end

        Tabs[name] = Tab
        return Tab
    end

    function Window:Notify(config)
        local NotificationConfig = {
            Title = config.Title or "Notification",
            Content = config.Content or "This is a notification",
            Duration = config.Duration or 5,
            Image = config.Image or "rbxassetid://4483345998",
            Actions = config.Actions or {}
        }

        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Size = UDim2.new(0, 300, 0, 80)
        Notification.Position = UDim2.new(1, -310, 0, 10)
        Notification.BackgroundColor3 = VXHConfig.Colors.Card
        Notification.BorderSizePixel = 0
        Notification.Parent = ScreenGui

        CreateCorner(Notification, 8)
        CreateStroke(Notification, 1, VXHConfig.Colors.Border, 0.7)

        local NotificationIcon = Instance.new("ImageLabel")
        NotificationIcon.Name = "NotificationIcon"
        NotificationIcon.Size = UDim2.new(0, 20, 0, 20)
        NotificationIcon.Position = UDim2.new(0, 10, 0, 10)
        NotificationIcon.BackgroundTransparency = 1
        NotificationIcon.Image = NotificationConfig.Image
        NotificationIcon.ImageColor3 = VXHConfig.Colors.Primary
        NotificationIcon.Parent = Notification

        local NotificationTitle = Instance.new("TextLabel")
        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Size = UDim2.new(1, -40, 0, 20)
        NotificationTitle.Position = UDim2.new(0, 35, 0, 10)
        NotificationTitle.BackgroundTransparency = 1
        NotificationTitle.Text = NotificationConfig.Title
        NotificationTitle.TextColor3 = VXHConfig.Colors.Text
        NotificationTitle.TextScaled = true
        NotificationTitle.Font = VXHConfig.DefaultFont
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotificationTitle.Parent = Notification

        local NotificationContent = Instance.new("TextLabel")
        NotificationContent.Name = "NotificationContent"
        NotificationContent.Size = UDim2.new(1, -40, 0, 15)
        NotificationContent.Position = UDim2.new(0, 35, 0, 30)
        NotificationContent.BackgroundTransparency = 1
        NotificationContent.Text = NotificationConfig.Content
        NotificationContent.TextColor3 = VXHConfig.Colors.SubText
        NotificationContent.TextScaled = true
        NotificationContent.Font = VXHConfig.DefaultFont
        NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
        NotificationContent.Parent = Notification

        -- Slide in animation
        CreateTween(Notification, {Position = UDim2.new(1, -310, 0, 10)}):Play()

        -- Auto dismiss
        game:GetService("Debris"):AddItem(Notification, NotificationConfig.Duration)
    end

    WindowFrame = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Tabs = Tabs
    }

    return Window
end

-- VXH Advanced Features

-- Theme System
VXH.Themes = {
    Default = {
        Primary = Color3.fromRGB(59, 130, 246),
        Secondary = Color3.fromRGB(99, 102, 241),
        Background = Color3.fromRGB(30, 30, 30),
        Card = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(156, 163, 175),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Border = Color3.fromRGB(75, 85, 99)
    },
    Dark = {
        Primary = Color3.fromRGB(37, 99, 235),
        Secondary = Color3.fromRGB(67, 56, 202),
        Background = Color3.fromRGB(17, 24, 39),
        Card = Color3.fromRGB(31, 41, 55),
        Text = Color3.fromRGB(243, 244, 246),
        SubText = Color3.fromRGB(156, 163, 175),
        Success = Color3.fromRGB(5, 150, 105),
        Warning = Color3.fromRGB(217, 119, 6),
        Error = Color3.fromRGB(220, 38, 38),
        Border = Color3.fromRGB(55, 65, 81)
    },
    Light = {
        Primary = Color3.fromRGB(59, 130, 246),
        Secondary = Color3.fromRGB(99, 102, 241),
        Background = Color3.fromRGB(255, 255, 255),
        Card = Color3.fromRGB(249, 250, 251),
        Text = Color3.fromRGB(17, 24, 39),
        SubText = Color3.fromRGB(107, 114, 128),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Border = Color3.fromRGB(209, 213, 219)
    }
}

-- Configuration Management
function VXH:SaveConfiguration(folderName, fileName)
    if not folderName or not fileName then
        return false
    end
    
    local config = {
        Flags = self.Flags,
        Version = self.Version,
        SavedAt = os.time()
    }
    
    -- In a real implementation, you would save to a file
    -- For now, we'll use a simple table storage
    if not game:GetService("ReplicatedStorage"):FindFirstChild("VXH_Configs") then
        local configFolder = Instance.new("Folder")
        configFolder.Name = "VXH_Configs"
        configFolder.Parent = game:GetService("ReplicatedStorage")
    end
    
    local configValue = Instance.new("StringValue")
    configValue.Name = fileName
    configValue.Value = game:GetService("HttpService"):JSONEncode(config)
    configValue.Parent = game:GetService("ReplicatedStorage").VXH_Configs
    
    return true
end

function VXH:LoadConfiguration(folderName, fileName)
    if not folderName or not fileName then
        return false
    end
    
    local configFolder = game:GetService("ReplicatedStorage"):FindFirstChild("VXH_Configs")
    if not configFolder then
        return false
    end
    
    local configValue = configFolder:FindFirstChild(fileName)
    if not configValue then
        return false
    end
    
    local success, config = pcall(function()
        return game:GetService("HttpService"):JSONDecode(configValue.Value)
    end)
    
    if success and config then
        self.Flags = config.Flags or {}
        return true
    end
    
    return false
end

-- Key System Implementation
function VXH:CreateKeySystem(config)
    local KeySystemConfig = {
        Title = config.Title or "VXH Key System",
        Subtitle = config.Subtitle or "Enter your key to continue",
        Note = config.Note or "Get your key from our Discord server",
        FileName = config.FileName or "VXH_Key",
        SaveKey = config.SaveKey or true,
        GrabKeyFromSite = config.GrabKeyFromSite or false,
        Key = config.Key or {"VXH2024"},
        KeyLink = config.KeyLink or "https://discord.gg/vxh"
    }
    
    -- Create Key System GUI
    local KeySystemGui = Instance.new("ScreenGui")
    KeySystemGui.Name = "VXH_KeySystem"
    KeySystemGui.Parent = CoreGui
    KeySystemGui.ResetOnSpawn = false
    
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 400, 0, 300)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    KeyFrame.BackgroundColor3 = VXHConfig.Colors.Background
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = KeySystemGui
    
    CreateCorner(KeyFrame, 12)
    CreateStroke(KeyFrame, 1, VXHConfig.Colors.Border, 0.7)
    
    -- Key System Title
    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Name = "KeyTitle"
    KeyTitle.Size = UDim2.new(1, -20, 0, 40)
    KeyTitle.Position = UDim2.new(0, 10, 0, 10)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Text = KeySystemConfig.Title
    KeyTitle.TextColor3 = VXHConfig.Colors.Text
    KeyTitle.TextScaled = true
    KeyTitle.Font = VXHConfig.DefaultFont
    KeyTitle.TextXAlignment = Enum.TextXAlignment.Center
    KeyTitle.Parent = KeyFrame
    
    -- Key System Subtitle
    local KeySubtitle = Instance.new("TextLabel")
    KeySubtitle.Name = "KeySubtitle"
    KeySubtitle.Size = UDim2.new(1, -20, 0, 30)
    KeySubtitle.Position = UDim2.new(0, 10, 0, 50)
    KeySubtitle.BackgroundTransparency = 1
    KeySubtitle.Text = KeySystemConfig.Subtitle
    KeySubtitle.TextColor3 = VXHConfig.Colors.SubText
    KeySubtitle.TextScaled = true
    KeySubtitle.Font = VXHConfig.DefaultFont
    KeySubtitle.TextXAlignment = Enum.TextXAlignment.Center
    KeySubtitle.Parent = KeyFrame
    
    -- Key Input
    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Size = UDim2.new(1, -40, 0, 40)
    KeyInput.Position = UDim2.new(0, 20, 0, 100)
    KeyInput.BackgroundColor3 = VXHConfig.Colors.Card
    KeyInput.BorderSizePixel = 0
    KeyInput.PlaceholderText = "Enter your key here..."
    KeyInput.PlaceholderColor3 = VXHConfig.Colors.SubText
    KeyInput.Text = ""
    KeyInput.TextColor3 = VXHConfig.Colors.Text
    KeyInput.TextScaled = true
    KeyInput.Font = VXHConfig.DefaultFont
    KeyInput.Parent = KeyFrame
    
    CreateCorner(KeyInput, 8)
    
    -- Submit Button
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Size = UDim2.new(1, -40, 0, 40)
    SubmitButton.Position = UDim2.new(0, 20, 0, 160)
    SubmitButton.BackgroundColor3 = VXHConfig.Colors.Primary
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Text = "Submit Key"
    SubmitButton.TextColor3 = VXHConfig.Colors.Text
    SubmitButton.TextScaled = true
    SubmitButton.Font = VXHConfig.DefaultFont
    SubmitButton.Parent = KeyFrame
    
    CreateCorner(SubmitButton, 8)
    
    -- Get Key Button
    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Name = "GetKeyButton"
    GetKeyButton.Size = UDim2.new(1, -40, 0, 40)
    GetKeyButton.Position = UDim2.new(0, 20, 0, 210)
    GetKeyButton.BackgroundColor3 = VXHConfig.Colors.Secondary
    GetKeyButton.BorderSizePixel = 0
    GetKeyButton.Text = "Get Key"
    GetKeyButton.TextColor3 = VXHConfig.Colors.Text
    GetKeyButton.TextScaled = true
    GetKeyButton.Font = VXHConfig.DefaultFont
    GetKeyButton.Parent = KeyFrame
    
    CreateCorner(GetKeyButton, 8)
    
    -- Key System Logic
    local function ValidateKey(key)
        for _, validKey in ipairs(KeySystemConfig.Key) do
            if key == validKey then
                return true
            end
        end
        return false
    end
    
    SubmitButton.MouseButton1Click:Connect(function()
        local enteredKey = KeyInput.Text
        if ValidateKey(enteredKey) then
            if KeySystemConfig.SaveKey then
                -- Save key locally (simplified)
                game:GetService("Players").LocalPlayer:SetAttribute("VXH_Key", enteredKey)
            end
            KeySystemGui:Destroy()
        else
            -- Show error
            CreateTween(KeyFrame, {BackgroundColor3 = VXHConfig.Colors.Error}):Play()
            wait(0.5)
            CreateTween(KeyFrame, {BackgroundColor3 = VXHConfig.Colors.Background}):Play()
        end
    end)
    
    GetKeyButton.MouseButton1Click:Connect(function()
        -- Open key link (in real implementation)
        print("Get your key from: " .. KeySystemConfig.KeyLink)
    end)
    
    -- Check if key is already saved
    if KeySystemConfig.SaveKey then
        local savedKey = game:GetService("Players").LocalPlayer:GetAttribute("VXH_Key")
        if savedKey and ValidateKey(savedKey) then
            KeySystemGui:Destroy()
            return true
        end
    end
    
    return false
end

-- Utility Functions for Script Hub Developers
function VXH:GetFlag(flagName)
    return self.Flags[flagName]
end

function VXH:SetFlag(flagName, value)
    self.Flags[flagName] = value
end

function VXH:DestroyWindow(windowName)
    if self.Windows[windowName] then
        self.Windows[windowName].ScreenGui:Destroy()
        self.Windows[windowName] = nil
    end
end

function VXH:ToggleWindow(windowName)
    if self.Windows[windowName] then
        local mainFrame = self.Windows[windowName].MainFrame
        mainFrame.Visible = not mainFrame.Visible
    end
end

function VXH:SetTheme(themeName)
    if self.Themes[themeName] then
        for colorKey, colorValue in pairs(self.Themes[themeName]) do
            VXHConfig.Colors[colorKey] = colorValue
        end
    end
end

-- Developer Helper Functions
function VXH:CreateQuickToggle(name, callback)
    -- Quick way to create a toggle without full window setup
    local quickToggle = {
        Name = name,
        Value = false,
        Callback = callback or function() end
    }
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Insert then -- Default toggle key
            quickToggle.Value = not quickToggle.Value
            quickToggle.Callback(quickToggle.Value)
            print("VXH: " .. name .. " = " .. tostring(quickToggle.Value))
        end
    end)
    
    return quickToggle
end

function VXH:CreateCommand(commandName, callback)
    -- Simple command system for developers
    game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
        if message:lower():sub(1, #commandName + 1) == "/" .. commandName:lower() then
            local args = message:sub(#commandName + 3):split(" ")
            callback(args)
        end
    end)
end

-- Export VXH Library
return VXH
