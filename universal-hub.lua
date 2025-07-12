--[[
    VXH Universal Script Hub
    
    A comprehensive script hub that works across all Roblox games.
    Features player modifications, visual enhancements, teleportation,
    and utility functions.
    
    Author: VXH Team
    Version: 2.0.0
]]

-- Load VXH Library
local VXH = loadstring(game:HttpGet("https://raw.githubusercontent.com/vxhteam/VXH-UI/refs/heads/main/vxh.lua"))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- Create Window
local Window = VXH:CreateWindow({
    Name = "VXH Universal Hub",
    LoadingTitle = "VXH Interface Suite",
    LoadingSubtitle = "Universal Script Hub v2.0",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VXH_Universal",
        FileName = "Config"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/vxh",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "VXH Universal Hub",
        Subtitle = "Enter your key to access features",
        Note = "Join our Discord server to get your key: discord.gg/vxh",
        FileName = "VXH_Universal_Key",
        SaveKey = true,
        Key = {"VXH_Universal_2024", "VXH_Free_Access", "Demo_Key_123"}
    }
})

-- ====================
-- PLAYER TAB
-- ====================

local PlayerTab = Window:CreateTab("Player", "User")

PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = value
        end
    end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(value)
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = value
        end
    end
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(value)
        getgenv().InfiniteJump = value
        if value then
            getgenv().InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
                if getgenv().InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        else
            if getgenv().InfiniteJumpConnection then
                getgenv().InfiniteJumpConnection:Disconnect()
                getgenv().InfiniteJumpConnection = nil
            end
        end
    end
})

PlayerTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Flag = "SpeedBoost",
    Callback = function(value)
        local multiplier = value and 2 or 1
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = VXH:GetFlag("WalkSpeed") * multiplier
        end
    end
})

PlayerTab:CreateSection("Character")

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(value)
        getgenv().Noclip = value
        if value then
            getgenv().NoclipConnection = RunService.Stepped:Connect(function()
                if getgenv().Noclip and LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if getgenv().NoclipConnection then
                getgenv().NoclipConnection:Disconnect()
                getgenv().NoclipConnection = nil
            end
            -- Re-enable collision
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(value)
        getgenv().Flying = value
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        if value then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = character.HumanoidRootPart
            
            getgenv().FlyConnection = RunService.Heartbeat:Connect(function()
                if getgenv().Flying and bodyVelocity and bodyVelocity.Parent then
                    local moveVector = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveVector = moveVector + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveVector = moveVector - Vector3.new(0, 1, 0)
                    end
                    
                    bodyVelocity.Velocity = moveVector * 50
                end
            end)
        else
            if getgenv().FlyConnection then
                getgenv().FlyConnection:Disconnect()
                getgenv().FlyConnection = nil
            end
            if character and character:FindFirstChild("HumanoidRootPart") then
                local bodyVelocity = character.HumanoidRootPart:FindFirstChild("BodyVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
    end
})

PlayerTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.Health = 0
            VXH:Notify({
                Title = "Character Reset",
                Content = "Your character has been reset",
                Duration = 2
            })
        end
    end
})

PlayerTab:CreateButton({
    Name = "Respawn",
    Callback = function()
        LocalPlayer:LoadCharacter()
        VXH:Notify({
            Title = "Respawned",
            Content = "Character respawned successfully",
            Duration = 2
        })
    end
})

-- ====================
-- VISUAL TAB
-- ====================

local VisualTab = Window:CreateTab("Visuals", "Eye")

VisualTab:CreateSection("ESP")

VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(value)
        if value then
            -- Enable ESP for existing players
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "VXH_ESP"
                    highlight.FillColor = VXH:GetFlag("ESPColor") or Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                end
            end
            
            -- ESP for new players
            getgenv().ESPPlayerAddedConnection = Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    if VXH:GetFlag("PlayerESP") then
                        wait(1)
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "VXH_ESP"
                        highlight.FillColor = VXH:GetFlag("ESPColor") or Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = character
                    end
                end)
            end)
        else
            -- Disable ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("VXH_ESP")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
            
            if getgenv().ESPPlayerAddedConnection then
                getgenv().ESPPlayerAddedConnection:Disconnect()
                getgenv().ESPPlayerAddedConnection = nil
            end
        end
    end
})

VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor",
    Callback = function(color)
        -- Update existing ESP colors
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("VXH_ESP")
                if highlight then
                    highlight.FillColor = color
                end
            end
        end
    end
})

VisualTab:CreateToggle({
    Name = "Name ESP",
    CurrentValue = false,
    Flag = "NameESP",
    Callback = function(value)
        if value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Name = "VXH_NameESP"
                    billboardGui.Adornee = player.Character.Head
                    billboardGui.Size = UDim2.new(0, 200, 0, 50)
                    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                    billboardGui.Parent = player.Character.Head
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Name = "NameLabel"
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Text = player.Name
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.Parent = billboardGui
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    local nameESP = player.Character.Head:FindFirstChild("VXH_NameESP")
                    if nameESP then
                        nameESP:Destroy()
                    end
                end
            end
        end
    end
})

VisualTab:CreateSection("Camera")

VisualTab:CreateSlider({
    Name = "FOV",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 70,
    Flag = "FOV",
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end
})

VisualTab:CreateToggle({
    Name = "No Fog",
    CurrentValue = false,
    Flag = "NoFog",
    Callback = function(value)
        if value then
            workspace.FogEnd = 9e9
            workspace.FogStart = 9e9
        else
            workspace.FogEnd = 100000
            workspace.FogStart = 0
        end
    end
})

-- ====================
-- TELEPORT TAB
-- ====================

local TeleportTab = Window:CreateTab("Teleport", "MapPin")

TeleportTab:CreateSection("Quick Teleports")

local teleportLocations = {
    ["Spawn"] = Vector3.new(0, 5, 0),
    ["Sky"] = Vector3.new(0, 1000, 0),
    ["Underground"] = Vector3.new(0, -100, 0),
    ["Far Away"] = Vector3.new(10000, 1000, 10000)
}

for locationName, position in pairs(teleportLocations) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. locationName,
        Callback = function()
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(position)
                VXH:Notify({
                    Title = "Teleported",
                    Content = "Teleported to " .. locationName,
                    Duration = 2
                })
            end
        end
    })
end

TeleportTab:CreateSection("Player Teleport")

TeleportTab:CreateDropdown({
    Name = "Teleport to Player",
    Options = {"Select Player"},
    CurrentOption = "Select Player",
    Flag = "TeleportPlayer",
    Callback = function(option)
        if option ~= "Select Player" then
            local targetPlayer = Players:FindFirstChild(option)
            if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = 
                    targetPlayer.Character.HumanoidRootPart.CFrame
                VXH:Notify({
                    Title = "Teleported",
                    Content = "Teleported to " .. option,
                    Duration = 2
                })
            end
        end
    end
})

-- Update player list periodically
spawn(function()
    while true do
        if VXH:GetFlag("TeleportPlayer") then
            local playerOptions = {"Select Player"}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    table.insert(playerOptions, player.Name)
                end
            end
            -- Note: In a real implementation, you'd update the dropdown options here
        end
        wait(5)
    end
end)

TeleportTab:CreateSection("Custom Teleport")

TeleportTab:CreateInput({
    Name = "X Coordinate",
    PlaceholderText = "Enter X position",
    NumbersOnly = true,
    Flag = "TeleportX",
    Callback = function(text)
        -- Store X coordinate
    end
})

TeleportTab:CreateInput({
    Name = "Y Coordinate",
    PlaceholderText = "Enter Y position",
    NumbersOnly = true,
    Flag = "TeleportY",
    Callback = function(text)
        -- Store Y coordinate
    end
})

TeleportTab:CreateInput({
    Name = "Z Coordinate",
    PlaceholderText = "Enter Z position",
    NumbersOnly = true,
    Flag = "TeleportZ",
    Callback = function(text)
        -- Store Z coordinate
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Coordinates",
    Callback = function()
        local x = tonumber(VXH:GetFlag("TeleportX")) or 0
        local y = tonumber(VXH:GetFlag("TeleportY")) or 5
        local z = tonumber(VXH:GetFlag("TeleportZ")) or 0
        
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
            VXH:Notify({
                Title = "Teleported",
                Content = string.format("Teleported to (%d, %d, %d)", x, y, z),
                Duration = 3
            })
        end
    end
})

-- ====================
-- MISC TAB
-- ====================

local MiscTab = Window:CreateTab("Misc", "Settings")

MiscTab:CreateSection("Game Utilities")

MiscTab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

MiscTab:CreateButton({
    Name = "Copy Game ID",
    Callback = function()
        local gameId = tostring(game.PlaceId)
        setclipboard(gameId)
        VXH:Notify({
            Title = "Copied",
            Content = "Game ID copied to clipboard: " .. gameId,
            Duration = 3
        })
    end
})

MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = game:GetService("HttpService"):JSONDecode(req)
        
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and v.maxPlayers and v.playing and v.maxPlayers > v.playing and v.id ~= game.JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        else
            VXH:Notify({
                Title = "Server Hop Failed",
                Content = "No available servers found",
                Duration = 3
            })
        end
    end
})

MiscTab:CreateSection("Chat Utilities")

MiscTab:CreateInput({
    Name = "Chat Message",
    PlaceholderText = "Enter message to spam",
    Flag = "ChatMessage",
    Callback = function(text)
        -- Store chat message
    end
})

MiscTab:CreateToggle({
    Name = "Chat Spam",
    CurrentValue = false,
    Flag = "ChatSpam",
    Callback = function(value)
        getgenv().ChatSpam = value
        if value then
            spawn(function()
                while getgenv().ChatSpam do
                    local message = VXH:GetFlag("ChatMessage") or "VXH Universal Hub"
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
                    wait(1)
                end
            end)
        end
    end
})

-- ====================
-- SETTINGS TAB
-- ====================

local SettingsTab = Window:CreateTab("Settings", "Settings")

SettingsTab:CreateSection("Configuration")

SettingsTab:CreateButton({
    Name = "Save Configuration",
    Callback = function()
        VXH:SaveConfiguration("VXH_Universal", "Config")
        VXH:Notify({
            Title = "Configuration Saved",
            Content = "Your settings have been saved successfully",
            Duration = 3
        })
    end
})

SettingsTab:CreateButton({
    Name = "Load Configuration",
    Callback = function()
        if VXH:LoadConfiguration("VXH_Universal", "Config") then
            VXH:Notify({
                Title = "Configuration Loaded",
                Content = "Settings loaded successfully",
                Duration = 3
            })
        else
            VXH:Notify({
                Title = "Load Failed",
                Content = "No saved configuration found",
                Duration = 3
            })
        end
    end
})

SettingsTab:CreateSection("Appearance")

SettingsTab:CreateDropdown({
    Name = "UI Theme",
    Options = {"Default", "Dark", "Light"},
    CurrentOption = "Default",
    Flag = "UITheme",
    Callback = function(option)
        VXH:SetTheme(option)
        VXH:Notify({
            Title = "Theme Changed",
            Content = "UI theme set to " .. option,
            Duration = 2
        })
    end
})

SettingsTab:CreateSection("Keybinds")

SettingsTab:CreateKeybind({
    Name = "Toggle GUI",
    CurrentKeybind = "Insert",
    HoldToInteract = false,
    Flag = "ToggleGUI",
    Callback = function()
        VXH:ToggleWindow("VXH Universal Hub")
    end
})

SettingsTab:CreateKeybind({
    Name = "Toggle Noclip",
    CurrentKeybind = "N",
    HoldToInteract = false,
    Flag = "ToggleNoclip",
    Callback = function()
        local currentValue = VXH:GetFlag("Noclip")
        VXH:SetFlag("Noclip", not currentValue)
    end
})

SettingsTab:CreateSection("Information")

SettingsTab:CreateLabel({
    Name = "Version Info",
    Text = "VXH Universal Hub v2.0.0"
})

SettingsTab:CreateLabel({
    Name = "Player Info",
    Text = "Player: " .. LocalPlayer.Name
})

SettingsTab:CreateLabel({
    Name = "Game Info",
    Text = "Game ID: " .. game.PlaceId
})

-- ====================
-- FINAL SETUP
-- ====================

-- Welcome notification
VXH:Notify({
    Title = "VXH Universal Hub Loaded!",
    Content = "Welcome " .. LocalPlayer.Name .. "! Press Insert to toggle the GUI.",
    Duration = 5,
    Image = "rbxassetid://4483345998"
})

-- Quick GUI toggle
VXH:CreateQuickToggle("GUI Toggle", function()
    VXH:ToggleWindow("VXH Universal Hub")
end)

-- Chat commands
VXH:CreateCommand("help", function()
    print("VXH Universal Hub Commands:")
    print("/speed [number] - Set walk speed")
    print("/jump [number] - Set jump power")
    print("/tp [player] - Teleport to player")
    print("/fly - Toggle fly mode")
    print("/noclip - Toggle noclip")
    print("/esp - Toggle player ESP")
    print("/reset - Reset character")
end)

VXH:CreateCommand("speed", function(args)
    local speed = tonumber(args[1])
    if speed and speed >= 16 and speed <= 500 then
        VXH:SetFlag("WalkSpeed", speed)
        VXH:Notify({
            Title = "Speed Set",
            Content = "Walk speed set to " .. speed,
            Duration = 2
        })
    else
        print("Usage: /speed [16-500]")
    end
end)

VXH:CreateCommand("jump", function(args)
    local power = tonumber(args[1])
    if power and power >= 50 and power <= 500 then
        VXH:SetFlag("JumpPower", power)
        VXH:Notify({
            Title = "Jump Power Set",
            Content = "Jump power set to " .. power,
            Duration = 2
        })
    else
        print("Usage: /jump [50-500]")
    end
end)

VXH:CreateCommand("tp", function(args)
    local playerName = args[1]
    if playerName then
        local targetPlayer = Players:FindFirstChild(playerName)
        if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            print("Teleported to " .. playerName)
        else
            print("Player not found: " .. playerName)
        end
    else
        print("Usage: /tp [player_name]")
    end
end)

VXH:CreateCommand("fly", function()
    local currentValue = VXH:GetFlag("Fly")
    VXH:SetFlag("Fly", not currentValue)
    print("Fly mode: " .. tostring(not currentValue))
end)

VXH:CreateCommand("noclip", function()
    local currentValue = VXH:GetFlag("Noclip")
    VXH:SetFlag("Noclip", not currentValue)
    print("Noclip: " .. tostring(not currentValue))
end)

VXH:CreateCommand("esp", function()
    local currentValue = VXH:GetFlag("PlayerESP")
    VXH:SetFlag("PlayerESP", not currentValue)
    print("Player ESP: " .. tostring(not currentValue))
end)

VXH:CreateCommand("reset", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
        print("Character reset")
    end
end)

-- Auto-save configuration on exit
game:BindToClose(function()
    VXH:SaveConfiguration("VXH_Universal", "Config")
end)

-- Cleanup on character respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Reset certain flags on respawn
    VXH:SetFlag("WalkSpeed", 16)
    VXH:SetFlag("JumpPower", 50)
    VXH:SetFlag("Noclip", false)
    VXH:SetFlag("Fly", false)
end)

print("VXH Universal Hub loaded successfully!")
print("Press Insert to toggle the GUI")
print("Type /help for available commands")
