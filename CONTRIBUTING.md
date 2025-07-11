# Contributing to VXH UI Library

Thank you for your interest in contributing to VXH UI Library! This document provides guidelines and instructions for contributors.

## 🤝 How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use the issue templates** when available
3. **Provide detailed information** including:
   - Steps to reproduce the issue
   - Expected vs actual behavior
   - Screenshots/videos if applicable
   - Your environment (executor, game, etc.)

### Suggesting Features

1. **Check if the feature already exists** or is planned
2. **Open a feature request** with:
   - Clear description of the feature
   - Use cases and benefits
   - Possible implementation approach
   - Examples from other UI libraries (if applicable)

### Code Contributions

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes** following our coding standards
4. **Test your changes** thoroughly
5. **Commit your changes** with descriptive messages
6. **Push to your fork** (`git push origin feature/amazing-feature`)
7. **Open a Pull Request**

## 📋 Development Guidelines

### Code Style

#### Lua Code Style

```lua
-- Use descriptive variable names
local playerCharacter = game.Players.LocalPlayer.Character
local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")

-- Use proper indentation (4 spaces)
function VXH:CreateWindow(config)
    local WindowConfig = {
        Name = config.Name or "VXH Script Hub",
        LoadingTitle = config.LoadingTitle or "VXH Interface Suite"
    }
    
    -- Function body
end

-- Add comments for complex logic
-- This function creates a tween animation for smooth UI transitions
local function CreateTween(object, properties, duration)
    return TweenService:Create(object, TweenInfo.new(duration or 0.3), properties)
end

-- Use error handling where appropriate
local success, result = pcall(function()
    -- Potentially risky code
end)

if not success then
    warn("VXH Error: " .. tostring(result))
end
```

#### Documentation Standards

```lua
--[[
    Function: CreateButton
    
    Description: Creates a clickable button element in the specified tab
    
    Parameters:
    - config (table): Configuration table containing:
        - Name (string): Button display text
        - Callback (function): Function to call when clicked
    
    Returns:
    - Button element (Instance): The created button element
    
    Example:
    Tab:CreateButton({
        Name = "Test Button",
        Callback = function()
            print("Button clicked!")
        end
    })
]]
function Tab:CreateButton(config)
    -- Implementation
end
```

### Testing

Before submitting code:

1. **Test in multiple executors** (Synapse X, KRNL, etc.)
2. **Test in different games** to ensure compatibility
3. **Test edge cases** and error conditions
4. **Verify no memory leaks** or performance issues

### Commit Message Format

Use clear, descriptive commit messages:

```
feat: add color picker element to UI library
fix: resolve window positioning bug on mobile
docs: update API documentation for new features
refactor: optimize element creation performance
test: add unit tests for configuration system
```

### Branch Naming

Use descriptive branch names:

- `feature/color-picker` - New features
- `fix/window-positioning` - Bug fixes
- `docs/api-reference` - Documentation updates
- `refactor/element-creation` - Code refactoring

## 🧪 Testing Guidelines

### Manual Testing Checklist

- [ ] UI elements render correctly
- [ ] All callbacks function properly
- [ ] Configuration saving/loading works
- [ ] No console errors
- [ ] Performance is acceptable
- [ ] Works across different games
- [ ] Mobile compatibility (if applicable)

### Automated Testing

When adding new features, consider adding tests:

```lua
-- Example test structure
local function testButtonCreation()
    local button = Tab:CreateButton({
        Name = "Test Button",
        Callback = function() end
    })
    
    assert(button ~= nil, "Button should be created")
    assert(button.Name == "Button_Test Button", "Button should have correct name")
end
```

## 📁 Project Structure

```
VXH-UI/
├── src/
│   └── vxh-ui.lua          # Main library file
├── docs/
│   ├── TUTORIAL.md         # Complete tutorial
│   ├── API.md             # API reference
│   └── QUICKSTART.md      # Quick start guide
├── examples/
│   ├── universal-hub.lua   # Universal script hub
│   ├── fps-hub.lua        # FPS game hub
│   └── ...                # Other examples
├── tests/
│   └── ...                # Test files
├── assets/
│   └── ...                # Images, icons, etc.
├── CONTRIBUTING.md         # This file
├── LICENSE                # License file
└── README.md              # Main README
```

## 🎨 UI/UX Guidelines

### Design Principles

1. **Consistency** - Follow established patterns
2. **Clarity** - Make functionality obvious
3. **Performance** - Optimize for smooth experience
4. **Accessibility** - Consider all users

### Color Scheme

Maintain consistency with the VXH brand:

```lua
-- Primary colors
Primary = Color3.fromRGB(59, 130, 246)      -- Blue
Secondary = Color3.fromRGB(99, 102, 241)    -- Purple
Success = Color3.fromRGB(16, 185, 129)      -- Green
Warning = Color3.fromRGB(245, 158, 11)      -- Yellow
Error = Color3.fromRGB(239, 68, 68)         -- Red

-- Neutral colors
Background = Color3.fromRGB(30, 30, 30)     -- Dark gray
Card = Color3.fromRGB(40, 40, 40)           -- Lighter gray
Text = Color3.fromRGB(255, 255, 255)        -- White
SubText = Color3.fromRGB(156, 163, 175)     -- Gray
Border = Color3.fromRGB(75, 85, 99)         -- Border gray
```

### Animation Guidelines

```lua
-- Standard animation duration
local ANIMATION_DURATION = 0.3

-- Standard easing
local EASING_STYLE = Enum.EasingStyle.Quart
local EASING_DIRECTION = Enum.EasingDirection.Out

-- Example smooth animation
local tween = TweenService:Create(
    element,
    TweenInfo.new(ANIMATION_DURATION, EASING_STYLE, EASING_DIRECTION),
    {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
)
tween:Play()
```

## 🔧 Development Environment

### Prerequisites

- Roblox Studio (for testing)
- Text editor with Lua syntax highlighting
- Git for version control

### Recommended Tools

- **VS Code** with Lua extension
- **Roblox LSP** for autocomplete
- **Selene** for linting
- **StyLua** for code formatting

### Local Development

1. Clone the repository
2. Open in your preferred editor
3. Make changes to `src/vxh-ui.lua`
4. Test in Roblox Studio
5. Update documentation if needed

## 📚 Documentation

### When to Update Documentation

- Adding new features
- Changing existing functionality
- Fixing bugs that affect usage
- Adding examples or tutorials

### Documentation Locations

- **README.md** - Project overview and quick start
- **docs/TUTORIAL.md** - Complete tutorial
- **docs/API.md** - API reference
- **docs/QUICKSTART.md** - Quick start guide
- **Code comments** - Inline documentation

## 🏷️ Release Process

### Version Numbers

We follow [Semantic Versioning](https://semver.org/):

- **Major** (X.0.0) - Breaking changes
- **Minor** (0.X.0) - New features, backwards compatible
- **Patch** (0.0.X) - Bug fixes, backwards compatible

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Version number bumped
- [ ] Changelog updated
- [ ] Examples work with new version
- [ ] No breaking changes in minor/patch releases

## 🆘 Getting Help

If you need help contributing:

1. **Check the documentation** first
2. **Search existing issues** for similar questions
3. **Join our Discord** for real-time help
4. **Open a discussion** for general questions
5. **Create an issue** for specific problems

### Discord Server

Join our Discord for:
- Real-time help and support
- Feature discussions
- Community feedback
- Beta testing opportunities

[Join Discord](soon!!!)

## 📄 License

By contributing to VXH UI Library, you agree that your contributions will be licensed under the MIT License.

## 🎉 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Discord announcements
- Special contributor role (for significant contributions)

## ❓ Questions?

If you have any questions about contributing, feel free to:

- Open a discussion on GitHub
- Join our Discord server
- Contact the maintainers directly

Thank you for helping make VXH UI Library better for everyone! 🚀
