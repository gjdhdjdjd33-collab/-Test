-- by ItzKonst (Mobile Optimized) - v6 PRO EDITION (исправлено под Roblox Studio)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera
local uis = game:GetService("UserInputService")

-- Создание GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MegaAimbot"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- ОСНОВНОЕ ОКНО (БОЛЬШОЕ ДЛЯ ПАЛЬЦЕЙ) - ПРО СТИЛЬ
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 50, 50)
mainStroke.Thickness = 3
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

-- ЗАГОЛОВОК с подсветкой (больше)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ MEGA AIMBOT v6 PRO ⚡"
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local titleGlow = Instance.new("UIStroke")
titleGlow.Color = Color3.fromRGB(255, 50, 50)
titleGlow.Thickness = 2
titleGlow.Transparency = 0.4
titleGlow.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 50, 0, 50)
closeBtn.Position = UDim2.new(1, -55, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- КОНТЕЙНЕР ДЛЯ СКРОЛЛА (ВАЖНО ДЛЯ МОБИЛЫ!)
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 1, -55)
scrollingFrame.Position = UDim2.new(0, 0, 0, 55)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 15)
scrollCorner.Parent = scrollingFrame

-- ========== ВСЕ НАСТРОЙКИ ==========
local settings = {
    -- Основное
    Enabled = true,
    AimKey = "MouseButton2",
    AimKeyMobile = true,
    
    -- Цели
    TeamCheck = false,
    WallCheck = false,
    VisibleCheck = false,
    IgnoreFriends = false,
    
    -- Прицеливание
    TargetPart = "Head",
    Smoothness = 5,
    Prediction = 0.165,
    FOV = 180,
    HitChance = 100,
    
    -- Визуал
    ShowFOV = true,
    ShowTargetLine = true,
    ShowTargetInfo = true,
    FOVColor = Color3.fromRGB(255, 50, 50),
    
    -- Дополнительно
    AutoShoot = false,
    TriggerBot = false,
    Airshot = false,
    Knockback = false
}

-- ========== ФУНКЦИИ СОЗДАНИЯ ЭЛЕМЕНТОВ (ВСЕ БОЛЬШИЕ ДЛЯ МОБИЛЫ И ПРО СТИЛЬ) ==========
function createSection(parent, title, yPos)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -20, 0, 40)
    section.Position = UDim2.new(0, 10, 0, yPos)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 3)
    line.Position = UDim2.new(0, 0, 1, -8)
    line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    line.BorderSizePixel = 0
    line.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBlack
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    return 50
end

function createBigToggle(parent, name, yPos, setting, defaultColor)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 65)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 90, 0, 45)
    toggleBtn.Position = UDim2.new(1, -100, 0.5, -22.5)
    toggleBtn.BackgroundColor3 = defaultColor or Color3.fromRGB(0, 255, 0)
    toggleBtn.Text = "ON"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = toggleBtn
    
    toggleBtn.MouseButton1Click:Connect(function()
        settings[setting] = not settings[setting]
        if settings[setting] then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            toggleBtn.Text = "ON"
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            toggleBtn.Text = "OFF"
        end
    end)
    
    return 80
end

function createSlider(parent, name, yPos, setting, min, max, suffix)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 85)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 25)
    label.Position = UDim2.new(0, 15, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, 0, 0, 25)
    valueLabel.Position = UDim2.new(0.7, 0, 0, 8)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = settings[setting] .. (suffix or "")
    valueLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -30, 0, 35)
    inputBox.Position = UDim2.new(0, 15, 0, 45)
    inputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    inputBox.Text = tostring(settings[setting])
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextScaled = true
    inputBox.Font = Enum.Font.SourceSansBold
    inputBox.PlaceholderText = "Введи значение..."
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = frame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 10)
    inputCorner.Parent = inputBox
    
    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val then
            settings[setting] = math.clamp(val, min, max)
            inputBox.Text = tostring(settings[setting])
            valueLabel.Text = settings[setting] .. (suffix or "")
        else
            inputBox.Text = tostring(settings[setting])
        end
    end)
    
    return 100
end

function createDropdown(parent, name, yPos, setting, options)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 85)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 0, 25)
    label.Position = UDim2.new(0, 15, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(1, -30, 0, 35)
    dropdownBtn.Position = UDim2.new(0, 15, 0, 45)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    dropdownBtn.Text = settings[setting]
    dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownBtn.TextScaled = true
    dropdownBtn.Font = Enum.Font.SourceSansBold
    dropdownBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = dropdownBtn
    
    local expanded = false
    local dropdownItems = {}
    
    dropdownBtn.MouseButton1Click:Connect(function()
        expanded = not expanded
        
        if expanded then
            frame.Size = UDim2.new(1, -20, 0, 85 + (#options * 50))
            
            for i, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, -30, 0, 45)
                optBtn.Position = UDim2.new(0, 15, 0, 95 + ((i-1) * 50))
                optBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                optBtn.Text = opt
                optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                optBtn.TextScaled = true
                optBtn.Font = Enum.Font.SourceSans
                optBtn.Parent = frame
                
                local optCorner = Instance.new("UICorner")
                optCorner.CornerRadius = UDim.new(0, 10)
                optCorner.Parent = optBtn
                
                optBtn.MouseButton1Click:Connect(function()
                    settings[setting] = opt
                    dropdownBtn.Text = opt
                    expanded = false
                    frame.Size = UDim2.new(1, -20, 0, 85)
                    for _, btn in pairs(frame:GetChildren()) do
                        if btn:IsA("TextButton") and btn \~= dropdownBtn then
                            btn:Destroy()
                        end
                    end
                end)
                
                table.insert(dropdownItems, optBtn)
            end
        else
            frame.Size = UDim2.new(1, -20, 0, 85)
            for _, btn in pairs(dropdownItems) do
                btn:Destroy()
            end
            dropdownItems = {}
        end
    end)
    
    return 100
end

function createTabButton(parent, text, yPos, tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, -15, 0, 45)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255, 50, 50)
    btnStroke.Thickness = 1.5
    btnStroke.Transparency = 0.5
    btnStroke.Parent = btn
    
    return btn
end

-- ========== СБОРКА ИНТЕРФЕЙСА (ТАБЫ) ==========
local yPos = 10

-- Кнопки табов
local tabs = {}
local currentTab = "aim"

local aimBtn = createTabButton(scrollingFrame, "⚡ AIMBOT", yPos, "aim")
aimBtn.Position = UDim2.new(0, 10, 0, yPos)
tabs.aim = aimBtn
yPos = yPos + 55

local checksBtn = createTabButton(scrollingFrame, "🛡️ CHECKS", yPos, "checks")
checksBtn.Position = UDim2.new(0.5, -5, 0, yPos)
tabs.checks = checksBtn
yPos = yPos + 55

local aimSettingsBtn = createTabButton(scrollingFrame, "⚙️ AIM", yPos, "aimsettings")
aimSettingsBtn.Position = UDim2.new(0, 10, 0, yPos)
tabs.aimsettings = aimSettingsBtn
yPos = yPos + 55

local visualBtn = createTabButton(scrollingFrame, "👁️ VISUAL", yPos, "visual")
visualBtn.Position = UDim2.new(0.5, -5, 0, yPos)
tabs.visual = visualBtn
yPos = yPos + 55

local extraBtn = createTabButton(scrollingFrame, "💥 EXTRA", yPos, "extra")
extraBtn.Position = UDim2.new(0, 10, 0, yPos)
tabs.extra = extraBtn
yPos = yPos + 55

-- Контейнеры табов
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 1, -yPos - 80)
tabContainer.Position = UDim2.new(0, 0, 0, yPos)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = scrollingFrame

local aimContainer = Instance.new("Frame")
aimContainer.Size = UDim2.new(1, 0, 1, 0)
aimContainer.BackgroundTransparency = 1
aimContainer.Visible = true
aimContainer.Parent = tabContainer

local checksContainer = Instance.new("Frame")
checksContainer.Size = UDim2.new(1, 0, 1, 0)
checksContainer.BackgroundTransparency = 1
checksContainer.Visible = false
checksContainer.Parent = tabContainer

local aimSettingsContainer = Instance.new("Frame")
aimSettingsContainer.Size = UDim2.new(1, 0, 1, 0)
aimSettingsContainer.BackgroundTransparency = 1
aimSettingsContainer.Visible = false
aimSettingsContainer.Parent = tabContainer

local visualContainer = Instance.new("Frame")
visualContainer.Size = UDim2.new(1, 0, 1, 0)
visualContainer.BackgroundTransparency = 1
visualContainer.Visible = false
visualContainer.Parent = tabContainer

local extraContainer = Instance.new("Frame")
extraContainer.Size = UDim2.new(1, 0, 1, 0)
extraContainer.BackgroundTransparency = 1
extraContainer.Visible = false
extraContainer.Parent = tabContainer

-- Заполнение табов (каждый в свою вкладку)

-- AIMBOT ТАБ
yPos = 10
yPos = yPos + createSection(aimContainer, "🎯 ОСНОВНЫЕ НАСТРОЙКИ", yPos)
yPos = yPos + createBigToggle(aimContainer, "Включить аимбот", yPos, "Enabled")
yPos = yPos + createBigToggle(aimContainer, "Мобильный режим (авто-цель)", yPos, "AimKeyMobile")

yPos = yPos + createSection(aimContainer, "⚙️ НАСТРОЙКИ ПРИЦЕЛА", yPos)
yPos = yPos + createSlider(aimContainer, "Плавность", yPos, "Smoothness", 1, 20)
yPos = yPos + createSlider(aimContainer, "Предсказание", yPos, "Prediction", 0, 1, "с")
yPos = yPos + createSlider(aimContainer, "Радиус FOV", yPos, "FOV", 30, 360, "°")
yPos = yPos + createDropdown(aimContainer, "Часть тела", yPos, "TargetPart", {"Head", "Torso", "HumanoidRootPart", "Random"})

-- CHECKS ТАБ
yPos = 10
yPos = yPos + createSection(checksContainer, "🛡️ ПРОВЕРКИ", yPos)
yPos = yPos + createBigToggle(checksContainer, "Не целиться в тиммейтов", yPos, "TeamCheck")
yPos = yPos + createBigToggle(checksContainer, "Проверка стен", yPos, "WallCheck")
yPos = yPos + createBigToggle(checksContainer, "Проверка видимости", yPos, "VisibleCheck")
yPos = yPos + createBigToggle(checksContainer, "Игнорировать друзей", yPos, "IgnoreFriends")

-- AIM SETTINGS ТАБ
yPos = 10
yPos = yPos + createSection(aimSettingsContainer, "⚙️ НАСТРОЙКИ ПРИЦЕЛА", yPos)
yPos = yPos + createSlider(aimSettingsContainer, "Плавность", yPos, "Smoothness", 1, 20)
yPos = yPos + createSlider(aimSettingsContainer, "Предсказание", yPos, "Prediction", 0, 1, "с")
yPos = yPos + createSlider(aimSettingsContainer, "Радиус FOV", yPos, "FOV", 30, 360, "°")
yPos = yPos + createDropdown(aimSettingsContainer, "Часть тела", yPos, "TargetPart", {"Head", "Torso", "HumanoidRootPart", "Random"})

-- VISUAL ТАБ
yPos = 10
yPos = yPos + createSection(visualContainer, "👁️ ВИЗУАЛ", yPos)
yPos = yPos + createBigToggle(visualContainer, "Показывать FOV", yPos, "ShowFOV")
yPos = yPos + createBigToggle(visualContainer, "Линия до цели", yPos, "ShowTargetLine")
yPos = yPos + createBigToggle(visualContainer, "Инфо о цели", yPos, "ShowTargetInfo")

-- EXTRA ТАБ
yPos = 10
yPos = yPos + createSection(extraContainer, "💥 ЭКСТРА ФИЧИ", yPos)
yPos = yPos + createBigToggle(extraContainer, "Авто-стрельба", yPos, "AutoShoot")
yPos = yPos + createBigToggle(extraContainer, "Триггер бот", yPos, "TriggerBot")
yPos = yPos + createBigToggle(extraContainer, "Эйршот (в воздухе)", yPos, "Airshot")
yPos = yPos + createBigToggle(extraContainer, "Нокбек (отдача)", yPos, "Knockback")

-- ========== МОБИЛЬНЫЕ СОВЕТЫ (в конце) ==========
local tipsFrame = Instance.new("Frame")
tipsFrame.Size = UDim2.new(1, -20, 0, 65)
tipsFrame.Position = UDim2.new(0, 10, 0, yPos)
tipsFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
tipsFrame.BackgroundTransparency = 0.2
tipsFrame.Parent = scrollingFrame

local tipsCorner = Instance.new("UICorner")
tipsCorner.CornerRadius = UDim.new(0, 12)
tipsCorner.Parent = tipsFrame

local tipsText = Instance.new("TextLabel")
tipsText.Size = UDim2.new(1, -20, 1, -10)
tipsText.Position = UDim2.new(0, 10, 0, 5)
tipsText.BackgroundTransparency = 1
tipsText.Text = "📱 МОБИЛЬНЫЕ СОВЕТЫ:\n• Тапай по переключателям пальцем\n• Листай список вверх/вниз\n• Держи окно чтобы перетащить\n• Вводи значения в поля"
tipsText.TextColor3 = Color3.fromRGB(255, 255, 255)
tipsText.TextScaled = true
tipsText.Font = Enum.Font.SourceSansBold
tipsText.TextXAlignment = Enum.TextXAlignment.Left
tipsText.Parent = tipsFrame

-- ========== ОСНОВНАЯ ЛОГИКА ==========

-- Создание FOV круга
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = settings.ShowFOV
fovCircle.Radius = settings.FOV
fovCircle.Thickness = 2
fovCircle.Color = settings.FOVColor
fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
fovCircle.NumSides = 64
fovCircle.Filled = false

-- Линия до цели
local targetLine = Drawing.new("Line")
targetLine.Visible = settings.ShowTargetLine
targetLine.Thickness = 2
targetLine.Color = Color3.fromRGB(255, 50, 50)

-- Инфо о цели
local targetInfo = Drawing.new("Text")
targetInfo.Visible = settings.ShowTargetInfo
targetInfo.Color = Color3.fromRGB(255, 255, 255)
targetInfo.Size = 18
targetInfo.Center = true
targetInfo.Outline = true

-- Функция получения ближайшей цели
function getClosestTarget()
    local closestTarget = nil
    local shortestDistance = settings.FOV
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    if settings.AimKeyMobile then
        mousePos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    end
    
    for _, target in pairs(game.Players:GetPlayers()) do
        if target \~= player and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
            if settings.IgnoreFriends and target:IsFriendsWith(player.UserId) then
                continu
