getgenv().SecureMode = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "The Grand Fucking | Профессиональный Хаб",
    LoadingTitle = "The Grand Fucking",
    LoadingSubtitle = "v5.0 • Стабильная версия",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local VFXTab = Window:CreateTab("ВХ", 4384396147)
local AimTab = Window:CreateTab("Аим", 6961018899)
local OtherTab = Window:CreateTab("Прочее", 4503342962)

-- ==================== ГЛОБАЛЬНЫЕ ====================
local ESPEnabled = false
local ESPMode = "All"
local TeamColor = BrickColor.new("Bright blue")
local EnemyColor = BrickColor.new("Really red")

local AimAssistEnabled = false
local AimbotEnabled = false
local SilentAimEnabled = false
local AimMode = "People"
local TargetPart = "Head"
local FOV = 100
local MaxDistance = 200
local Smoothing = 0.3

local FlyEnabled = false
local FlySpeed = 50
local FlyCarEnabled = false
local FlyCarSpeed = 100

local FlyConnection = nil
local FlyCarConnection = nil
local CurrentFlySpeed = 50
local FlyingPart = nil

local ESPObjects = {}

-- ==================== ВХ ====================
VFXTab:CreateToggle({Name = "Включить ESP", CurrentValue = false, Flag = "ESP", Callback = function(v) ESPEnabled = v end})
VFXTab:CreateDropdown({Name = "ESP Режим", Options = {"Показать всех", "Показать только союзников", "Показать только противников"}, CurrentOption = {"Показать всех"}, Flag = "ESPMode", Callback = function(v) ESPMode = v[1] end})

-- ==================== АИМ ====================
AimTab:CreateToggle({Name = "Aim Assist", CurrentValue = false, Flag = "AimAssist", Callback = function(v) AimAssistEnabled = v end})
AimTab:CreateToggle({Name = "Aimbot", CurrentValue = false, Flag = "Aimbot", Callback = function(v) AimbotEnabled = v end})
AimTab:CreateToggle({Name = "Silent Aim", CurrentValue = false, Flag = "SilentAim", Callback = function(v) SilentAimEnabled = v end})

AimTab:CreateDropdown({Name = "Цель", Options = {"People", "NPC", "All"}, CurrentOption = {"People"}, Flag = "AimMode", Callback = function(v) AimMode = v[1] end})
AimTab:CreateDropdown({Name = "Куда целиться", Options = {"Голова", "Тело"}, CurrentOption = {"Голова"}, Flag = "TargetPart", Callback = function(v) TargetPart = v[1] end})

AimTab:CreateSlider({Name = "FOV", Range = {30, 300}, Increment = 1, CurrentValue = 100, Flag = "FOV", Callback = function(v) FOV = v end})
AimTab:CreateSlider({Name = "Макс. Дистанция", Range = {50, 500}, Increment = 1, CurrentValue = 200, Flag = "MaxDist", Callback = function(v) MaxDistance = v end})
AimTab:CreateSlider({Name = "Сглаживание (Smoothing)", Range = {0.05, 1}, Increment = 0.05, CurrentValue = 0.3, Flag = "Smoothing", Callback = function(v) Smoothing = v end})

-- ==================== ПРОЧЕЕ ====================
OtherTab:CreateToggle({Name = "Fly", CurrentValue = false, Flag = "Fly", Callback = function(v) FlyEnabled = v end})
OtherTab:CreateSlider({Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Flag = "FlySpeed", Callback = function(v) FlySpeed = v end})

OtherTab:CreateToggle({Name = "Fly Car", CurrentValue = false, Flag = "FlyCar", Callback = function(v) FlyCarEnabled = v end})
OtherTab:CreateSlider({Name = "Fly Car Speed", Range = {20, 300}, Increment = 5, CurrentValue = 100, Flag = "FlyCarSpeed", Callback = function(v) FlyCarSpeed = v end})

-- ==================== ВСПОМОГАТЕЛЬНЫЕ ====================
local function GetClosestPlayer(mode)
    local target, best = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (Vector2.new(Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position).X, Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position).Y) - Camera.ViewportSize/2).Magnitude
            if dist < FOV and dist < best then
                if mode == "People" and plr.Character:FindFirstChild("Humanoid") then target, best = plr.Character, dist
                elseif mode == "NPC" and not plr.Character:FindFirstChild("Humanoid") then target, best = plr.Character, dist
                elseif mode == "All" then target, best = plr.Character, dist end
            end
        end
    end
    return target
end

-- ==================== ДВИЖЕНИЕ ====================
RunService.Heartbeat:Connect(function()
    if FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local cam = Camera.CFrame
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        root.Velocity = move.Unit * FlySpeed
    end

    if FlyCarEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        if root:FindFirstChild("Car") then
            local car = root:FindFirstChild("Car")
            local cam = Camera.CFrame
            local move = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
            car.AssemblyLinearVelocity = move.Unit * FlyCarSpeed
        end
    end
end)

-- ==================== AIMBOT + SILENT AIM ====================
RunService.RenderStepped:Connect(function()
    if not (AimAssistEnabled or AimbotEnabled or SilentAimEnabled) then return end

    local targetChar = GetClosestPlayer(AimMode)
    if not targetChar then return end

    local part = TargetPart == "Тело" and targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("Head")
    if not part then return end

    if AimAssistEnabled then
        local targetPos = part.Position
        local screenPos = Camera:WorldToViewportPoint(targetPos)
        if screenPos.Z > 0 then
            local center = Camera.ViewportSize / 2
            local aimDir = (Vector2.new(screenPos.X, screenPos.Y) - center).Unit * (FOV / 100)
            local newCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Vector3.new(aimDir.X, aimDir.Y, 0))
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, Smoothing)
        end
    end

    if AimbotEnabled then
        local headPos = part.Position
        local screenPos = Camera:WorldToViewportPoint(headPos)
        if screenPos.Z > 0 then
            local center = Camera.ViewportSize / 2
            local aimDir = (Vector2.new(screenPos.X, screenPos.Y) - center).Unit * (FOV / 100)
            local newCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Vector3.new(aimDir.X, aimDir.Y, 0))
            Camera.CFrame = Camera.CFrame:Lerp(newCframe, 0.3)
        end
    end

    if SilentAimEnabled then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
    end
end)

-- ==================== ESP ====================
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then
        for _, obj in pairs(ESPObjects) do if obj then obj:Destroy() end end
        ESPObjects = {}
        return
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr \~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local root = char.HumanoidRootPart
            if not ESPObjects[plr] then ESPObjects[plr] = {} end

            local color = TeamColor
            if ESPMode == "Показать только союзников" and plr.Team == LocalPlayer.Team then color = TeamColor
            elseif ESPMode == "Показать только противников" and plr.Team \~= LocalPlayer.Team then color = EnemyColor
            else color = (plr.Team == LocalPlayer.Team) and TeamColor or EnemyColor end

            for _, box in pairs({"Head", "Body"}) do
                if not ESPObjects[plr][box] then
                    ESPObjects[plr][box] = Drawing.new("Box")
                    ESPObjects[plr][box].Thickness = 2
                    ESPObjects[plr][box].Filled = false
                    ESPObjects[plr][box].Transparency = 0.8
                    ESPObjects[plr][box].Color = color
                end
                local size = box == "Head" and Vector2.new(180, 180) or Vector2.new(140, 420)
                local pos = box == "Head" and root.Position + Vector3.new(0,3,0) or root.Position + Vector3.new(0,-1.5,0)
                ESPObjects[plr][box].Size = size
                ESPObjects[plr][box].Position = Camera:WorldToViewportPoint(pos)
                ESPObjects[plr][box].Visible = true
            end
        end
    end

    for plr, objs in pairs(ESPObjects) do
        if not (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
            for _, obj in pairs(objs) do if obj then obj.Visible = false end end
        end
    end
end)

-- ==================== КРАБ + КНОПКА F ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrabMenu"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KrabFrame = Instance.new("Frame")
KrabFrame.Size = UDim2.new(0, 50, 0, 50)
KrabFrame.Position = UDim2.new(0.05, 0, 0.85, 0)
KrabFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
KrabFrame.Parent = ScreenGui

local KrabCorner = Instance.new("UICorner")
KrabCorner.CornerRadius = UDim.new(0, 12)
KrabCorner.Parent = KrabFrame

local KrabText = Instance.new("TextLabel")
KrabText.Size = UDim2.new(1,0,1,0)
KrabText.BackgroundTransparency = 1
KrabText.Text = "D"
KrabText.TextColor3 = Color3.new(0,0,0)
KrabText.TextScaled = true
KrabText.Font = Enum.Font.GothamBold
KrabText.Parent = KrabFrame

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrabMenu"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KrabFrame = Instance.new("Frame")
KrabFrame.Size = UDim2.new(0, 50, 0, 50)
KrabFrame.Position = UDim2.new(0.05, 0, 0.85, 0)
KrabFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
KrabFrame.Parent = ScreenGui

local KrabCorner = Instance.new("UICorner")
KrabCorner.CornerRadius = UDim.new(0, 12)
KrabCorner.Parent = KrabFrame

local KrabText = Instance.new("TextLabel")
KrabText.Size = UDim2.new(1,0,1,0)
KrabText.BackgroundTransparency = 1
KrabText.Text = "D"
KrabText.TextColor3 = Color3.new(0,0,0)
KrabText.TextScaled = true
KrabText.Font = Enum.Font.GothamBold
KrabText.Parent = KrabFrame

-- Перетаскивание (точно как раньше)
local dragging, dragInput, dragStart, startPos
KrabFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = KrabFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        KrabFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

OtherTab:CreateButton({Name = "Скрыть меню (F)", Callback = function()
    Rayfield.MainFrame.Visible = not Rayfield.MainFrame.Visible
end})

Rayfield:Notify("The Grand Fucking v5.0 загружен!", "Теперь должно работать нормально 🔥", 5)
