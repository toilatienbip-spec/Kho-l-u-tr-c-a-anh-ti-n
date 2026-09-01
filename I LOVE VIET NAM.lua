--[[
    COMBINED DUAL SCRIPT HUBS (ROBLOX) - HUB 1 (UPDATED: HEAD HITBOX, SIZE, & ESP CHAM) & HUB 2
]]

-- =========================================================================
-- HUB THỨ NHẤT: I LOVE VIET NAM HUB V13.5 (Đã thêm ESP Cham & Hitbox phần đầu siêu to)
-- =========================================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local CoreGui = game:GetService("CoreGui")
    local Lighting = game:GetService("Lighting")
    local Camera = workspace.CurrentCamera

    local Config1 = {
        Aimbot = false,
        AimVisual = false,
        WallCheck = false, 
        TeamCheck = false,
        ShowFOV = false, 
        FOVRadius = 250, 
        AimPart = "Head",
        SpeedBoost = false, 
        WalkSpeed = 50, 
        Noclip = false, 
        Fly = false,
        ESPBox = false, 
        ESPLine = false, 
        ESPHealth = false, 
        ESPName = false,
        ESPCount = true,
        ESPCham = false, -- Thêm tính năng ESP Cham
        HitboxEnabled = false,
        HitboxSize = 3,
        Fullbright = false,
        FixLag = false
    }

    local RED_COLOR = Color3.fromRGB(218, 37, 29)
    local YELLOW_COLOR = Color3.fromRGB(255, 204, 0)
    local WHITE_COLOR = Color3.fromRGB(255, 255, 255)
    local BRIGHT_GREEN = Color3.fromRGB(0, 255, 0)
    local DARK_BG = Color3.fromRGB(25, 12, 12)

    local function IsVisible1(targetPart)
        if not Config1.WallCheck then return true end
        local origin = Camera.CFrame.Position
        local targetPos = targetPart.Position
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        local ignoreList = {LocalPlayer.Character, Camera}
        if targetPart.Parent then table.insert(ignoreList, targetPart.Parent) end
        raycastParams.FilterDescendantsInstances = ignoreList
        local result = Workspace:Raycast(origin, targetPos - origin, raycastParams)
        return result == nil
    end

    local function GetClosestTarget1()
        local closestTarget = nil
        local shortestDistance = Config1.FOVRadius
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                if Config1.TeamCheck and plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team then continue end
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local targetPart = plr.Character:FindFirstChild(Config1.AimPart) 
                        or plr.Character:FindFirstChild("Head") 
                        or plr.Character:FindFirstChild("UpperTorso") 
                        or plr.Character:FindFirstChild("HumanoidRootPart")
                    
                    if targetPart then
                        local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen and pos.Z > 0 then
                            local distance = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                            if distance <= shortestDistance and IsVisible1(targetPart) then
                                shortestDistance = distance
                                closestTarget = targetPart
                            end
                        end
                    end
                end
            end
        end
        return closestTarget
    end

    local FOVCircle1 = Drawing.new("Circle")
    FOVCircle1.Color = BRIGHT_GREEN
    FOVCircle1.Thickness = 1.5
    FOVCircle1.NumSides = 60
    FOVCircle1.Filled = false
    FOVCircle1.Transparency = 1
    FOVCircle1.Visible = false

    local AimVisualLine1 = Drawing.new("Line")
    AimVisualLine1.Color = WHITE_COLOR
    AimVisualLine1.Thickness = 1
    AimVisualLine1.Transparency = 1
    AimVisualLine1.Visible = false

    local EspCache1 = {}
    local function CreateEsp1(plr)
        local drawings = {
            Box = Drawing.new("Square"),
            Line = Drawing.new("Line"),
            HealthBarBg = Drawing.new("Line"),
            HealthBar = Drawing.new("Line"),
            Name = Drawing.new("Text")
        }
        drawings.Box.Thickness = 1.5
        drawings.Box.Filled = false
        drawings.Box.Color = WHITE_COLOR

        drawings.Line.Thickness = 1
        drawings.Line.Color = WHITE_COLOR

        drawings.HealthBarBg.Thickness = 5
        drawings.HealthBarBg.Color = Color3.fromRGB(0, 0, 0)

        drawings.HealthBar.Thickness = 3
        drawings.HealthBar.Color = BRIGHT_GREEN

        drawings.Name.Size = 13
        drawings.Name.Center = true
        drawings.Name.Outline = true
        drawings.Name.Color = WHITE_COLOR

        EspCache1[plr] = drawings
    end

    local function RemoveEsp1(plr)
        if EspCache1[plr] then
            for _, obj in pairs(EspCache1[plr]) do pcall(function() obj:Remove() end) end
            EspCache1[plr] = nil
        end
        if plr.Character and plr.Character:FindFirstChild("Hub1_Highlight") then
            plr.Character.Hub1_Highlight:Destroy()
        end
    end

    Players.PlayerAdded:Connect(CreateEsp1)
    Players.PlayerRemoving:Connect(RemoveEsp1)
    for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreateEsp1(p) end end

    local screenGui1 = Instance.new("ScreenGui")
    screenGui1.Name = "ILoveVietnamHub"
    screenGui1.ResetOnSpawn = false
    pcall(function() screenGui1.Parent = CoreGui end)
    if not screenGui1.Parent then screenGui1.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local logoFrame1 = Instance.new("Frame")
    logoFrame1.Size = UDim2.new(0, 45, 0, 45)
    logoFrame1.Position = UDim2.new(1, -55, 0.25, -22)
    logoFrame1.BackgroundColor3 = RED_COLOR
    logoFrame1.BorderSizePixel = 0
    logoFrame1.Active = true
    logoFrame1.ZIndex = 999
    logoFrame1.Parent = screenGui1

    local logoCorner1 = Instance.new("UICorner")
    logoCorner1.CornerRadius = UDim.new(1, 0)
    logoCorner1.Parent = logoFrame1

    local logoBtn1 = Instance.new("TextButton")
    logoBtn1.Size = UDim2.new(1, 0, 1, 0)
    logoBtn1.BackgroundTransparency = 1
    logoBtn1.Text = "★"
    logoBtn1.TextColor3 = YELLOW_COLOR
    logoBtn1.TextSize = 24
    logoBtn1.Font = Enum.Font.GothamBold
    logoBtn1.Parent = logoFrame1

    local mainFrame1 = Instance.new("Frame")
    mainFrame1.Size = UDim2.new(0, 450, 0, 285)
    mainFrame1.Position = UDim2.new(0.2, -225, 0.4, -142)
    mainFrame1.BackgroundColor3 = DARK_BG
    mainFrame1.BackgroundTransparency = 0.05
    mainFrame1.BorderSizePixel = 0
    mainFrame1.ClipsDescendants = true
    mainFrame1.Parent = screenGui1

    local mainCorner1 = Instance.new("UICorner")
    mainCorner1.CornerRadius = UDim.new(0, 8)
    mainCorner1.Parent = mainFrame1

    local titleBar1 = Instance.new("Frame")
    titleBar1.Size = UDim2.new(1, 0, 0, 28)
    titleBar1.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    titleBar1.BorderSizePixel = 0
    titleBar1.Active = true
    titleBar1.Parent = mainFrame1

    local titleLabel1 = Instance.new("TextLabel")
    titleLabel1.Size = UDim2.new(1, -10, 1, 0)
    titleLabel1.Position = UDim2.new(0, 8, 0, 0)
    titleLabel1.BackgroundTransparency = 1
    titleLabel1.Text = "★ I LOVE VIET NAM - HUB 1"
    titleLabel1.TextColor3 = YELLOW_COLOR
    titleLabel1.TextSize = 11
    titleLabel1.Font = Enum.Font.GothamBold
    titleLabel1.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel1.Parent = titleBar1

    local function MakeDraggable1(frame, toggleFunc)
        local dragging, dragStart, startPos, hasMoved = false, nil, nil, false
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; hasMoved = false; dragStart = input.Position; startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                if delta.Magnitude > 5 then hasMoved = true end
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = false
                if not hasMoved and toggleFunc then toggleFunc() end
            end
        end)
    end

    MakeDraggable1(logoFrame1, function() mainFrame1.Visible = not mainFrame1.Visible end)

    local mainDragging1, mainDragStart1, mainStartPos1, mainHasMoved1 = false, nil, nil, false
    local containerVisible1 = true

    titleBar1.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            mainDragging1 = true; mainHasMoved1 = false; mainDragStart1 = input.Position; mainStartPos1 = mainFrame1.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if mainDragging1 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - mainDragStart1
            if delta.Magnitude > 5 then mainHasMoved1 = true end
            mainFrame1.Position = UDim2.new(mainStartPos1.X.Scale, mainStartPos1.X.Offset + delta.X, mainStartPos1.Y.Scale, mainStartPos1.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if mainDragging1 and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            mainDragging1 = false
            if not mainHasMoved1 then
                containerVisible1 = not containerVisible1
                for _, child in ipairs(mainFrame1:GetChildren()) do
                    if child ~= titleBar1 and child ~= mainCorner1 then
                        child.Visible = containerVisible1
                    end
                end
            end
        end
    end)

    local tabContainer1 = Instance.new("Frame")
    tabContainer1.Size = UDim2.new(0, 95, 1, -28)
    tabContainer1.Position = UDim2.new(0, 0, 0, 28)
    tabContainer1.BackgroundColor3 = Color3.fromRGB(35, 15, 15)
    tabContainer1.BorderSizePixel = 0
    tabContainer1.Parent = mainFrame1

    local contentArea1 = Instance.new("ScrollingFrame")
    contentArea1.Size = UDim2.new(1, -100, 1, -32)
    contentArea1.Position = UDim2.new(0, 98, 0, 30)
    contentArea1.BackgroundTransparency = 1
    contentArea1.BorderSizePixel = 0
    contentArea1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentArea1.ScrollBarThickness = 6
    contentArea1.Parent = mainFrame1

    local tabNames1 = {"AIM", "PLAYER", "ESP", "WORLD"}
    local tabIcons1 = {"🎯", "👤", "⭐", "🌍"}
    local tabFrames1 = {}
    local tabButtons1 = {}

    for i, name in ipairs(tabNames1) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -6, 0, 25)
        btn.Position = UDim2.new(0, 3, 0, (i - 1) * 28 + 4)
        btn.BackgroundColor3 = Color3.fromRGB(70, 25, 25)
        btn.BackgroundTransparency = 0.3
        btn.Text = tabIcons1[i] .. " " .. name
        btn.TextColor3 = Color3.fromRGB(255, 210, 210)
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.Parent = tabContainer1
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 4)
        corner.Parent = btn
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 0)
        frame.BackgroundTransparency = 1
        frame.Visible = (i == 1)
        frame.Parent = contentArea1
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 4)
        layout.Parent = frame
        
        tabFrames1[name] = frame
        tabButtons1[name] = btn
        
        btn.MouseButton1Click:Connect(function()
            for n, f in pairs(tabFrames1) do
                f.Visible = false
                tabButtons1[n].BackgroundColor3 = Color3.fromRGB(70, 25, 25)
            end
            frame.Visible = true
            btn.BackgroundColor3 = RED_COLOR
        end)
    end

    local function AddSection1(parent, name)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, 0, 0, 20)
        section.BackgroundTransparency = 1
        section.Parent = parent
        
        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 18)
        header.BackgroundColor3 = Color3.fromRGB(70, 25, 25)
        header.Parent = section
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -8, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = "★ " .. name
        label.TextColor3 = YELLOW_COLOR
        label.TextSize = 10
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = header
        
        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, 0, 0, 0)
        content.Position = UDim2.new(0, 0, 0, 20)
        content.BackgroundTransparency = 1
        content.Parent = section
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 2)
        contentLayout.Parent = content
        
        contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            section.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y + 22)
        end)
        return { Content = content }
    end

    local function AddToggle1(parent, label, configKey)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -4, 0, 22)
        btn.BackgroundColor3 = Color3.fromRGB(45, 18, 18)
        btn.Parent = parent.Content
        
        local labelText = Instance.new("TextLabel")
        labelText.Size = UDim2.new(0.65, 0, 1, 0)
        labelText.Position = UDim2.new(0, 6, 0, 0)
        labelText.BackgroundTransparency = 1
        labelText.Text = label
        labelText.TextColor3 = Color3.fromRGB(240, 220, 220)
        labelText.TextSize = 10
        labelText.Font = Enum.Font.Gotham
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.Parent = btn
        
        local stateBtn = Instance.new("TextButton")
        stateBtn.Size = UDim2.new(0, 36, 0, 15)
        stateBtn.Position = UDim2.new(1, -40, 0.5, -7.5)
        stateBtn.BackgroundColor3 = Config1[configKey] and RED_COLOR or Color3.fromRGB(90, 50, 50)
        stateBtn.Text = Config1[configKey] and "ON" or "OFF"
        stateBtn.TextColor3 = YELLOW_COLOR
        stateBtn.TextSize = 8
        stateBtn.Font = Enum.Font.GothamBold
        stateBtn.Parent = btn
        
        stateBtn.MouseButton1Click:Connect(function()
            Config1[configKey] = not Config1[configKey]
            stateBtn.BackgroundColor3 = Config1[configKey] and RED_COLOR or Color3.fromRGB(90, 50, 50)
            stateBtn.Text = Config1[configKey] and "ON" or "OFF"
        end)
    end

    local function AddSlider1(parent, labelText, min, max, configKey, unit)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -4, 0, 38)
        frame.BackgroundColor3 = Color3.fromRGB(45, 18, 18)
        frame.Parent = parent.Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -8, 0, 16)
        label.Position = UDim2.new(0, 6, 0, 2)
        label.BackgroundTransparency = 1
        label.Text = labelText .. ": " .. tostring(Config1[configKey]) .. (unit or "")
        label.TextColor3 = Color3.fromRGB(240, 220, 220)
        label.TextSize = 10
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -12, 0, 6)
        sliderBar.Position = UDim2.new(0, 6, 0, 24)
        sliderBar.BackgroundColor3 = Color3.fromRGB(90, 50, 50)
        sliderBar.BorderSizePixel = 0
        sliderBar.Parent = frame
        
        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(1, 0)
        barCorner.Parent = sliderBar
        
        local ball = Instance.new("Frame")
        ball.Size = UDim2.new(0, 12, 0, 12)
        ball.AnchorPoint = Vector2.new(0.5, 0.5)
        local initialScale = math.clamp((Config1[configKey] - min) / (max - min), 0, 1)
        ball.Position = UDim2.new(initialScale, 0, 0.5, 0)
        ball.BackgroundColor3 = YELLOW_COLOR
        ball.BorderSizePixel = 0
        ball.Parent = sliderBar
        
        local ballCorner = Instance.new("UICorner")
        ballCorner.CornerRadius = UDim.new(1, 0)
        ballCorner.Parent = ball
        
        local dragging = false
        local function update(inputPos)
            local pos = sliderBar.AbsolutePosition.X
            local size = sliderBar.AbsoluteSize.X
            local scale = math.clamp((inputPos.X - pos) / size, 0, 1)
            local val = math.floor(min + scale * (max - min))
            Config1[configKey] = val
            ball.Position = UDim2.new(scale, 0, 0.5, 0)
            label.Text = labelText .. ": " .. tostring(val) .. (unit or "")
        end
        
        sliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(input.Position)
            end
        end)
        ball.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input.Position)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    local secAim1 = AddSection1(tabFrames1["AIM"], "Cài đặt Aimbot & FOV")
    AddToggle1(secAim1, "Aimbot", "Aimbot")
    AddToggle1(secAim1, "Aim Visual", "AimVisual")
    AddToggle1(secAim1, "Wall Check", "WallCheck")
    AddToggle1(secAim1, "Team Check", "TeamCheck")
    AddToggle1(secAim1, "Hiển thị FOV", "ShowFOV")
    AddSlider1(secAim1, "Bán kính FOV", 50, 500, "FOVRadius", "")

    local secHitbox1 = AddSection1(tabFrames1["AIM"], "Cài đặt Hitbox (Phần Đầu)")
    AddToggle1(secHitbox1, "Mở rộng Hitbox Đầu", "HitboxEnabled")
    AddSlider1(secHitbox1, "Kích thước Hitbox", 2, 100, "HitboxSize", "")

    local secPlr1 = AddSection1(tabFrames1["PLAYER"], "Nhân vật & Tốc độ")
    AddToggle1(secPlr1, "Speed Boost", "SpeedBoost")
    AddSlider1(secPlr1, "Tốc độ chạy (Speed)", 16, 200, "WalkSpeed", "")
    AddToggle1(secPlr1, "Noclip", "Noclip")
    AddToggle1(secPlr1, "Bay (Fly)", "Fly")

    local secEsp1 = AddSection1(tabFrames1["ESP"], "Visuals ESP")
    AddToggle1(secEsp1, "ESP Box", "ESPBox")
    AddToggle1(secEsp1, "ESP Line", "ESPLine")
    AddToggle1(secEsp1, "ESP Health", "ESPHealth")
    AddToggle1(secEsp1, "ESP Name", "ESPName")
    AddToggle1(secEsp1, "ESP Cham", "ESPCham") -- Thêm mục ESP Cham vào Menu
    AddToggle1(secEsp1, "ESP Count", "ESPCount")

    local secWorld1 = AddSection1(tabFrames1["WORLD"], "Môi trường & Hiệu năng")
    AddToggle1(secWorld1, "Map Sáng (Fullbright)", "Fullbright")
    AddToggle1(secWorld1, "Fix Lag (FPS Boost)", "FixLag")

    RunService.Stepped:Connect(function()
        if Config1.Noclip and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        if Config1.SpeedBoost and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Config1.WalkSpeed
        end

        if Config1.ShowFOV then
            FOVCircle1.Visible = true
            FOVCircle1.Radius = Config1.FOVRadius
            FOVCircle1.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            FOVCircle1.Visible = false
        end

        local target1 = GetClosestTarget1()
        if Config1.Aimbot and target1 then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target1.Position)
        end

        if Config1.AimVisual and target1 then
            local pos, onScreen = Camera:WorldToViewportPoint(target1.Position)
            if onScreen then
                AimVisualLine1.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                AimVisualLine1.To = Vector2.new(pos.X, pos.Y)
                AimVisualLine1.Visible = true
            else
                AimVisualLine1.Visible = false
            end
        else
            AimVisualLine1.Visible = false
        end

        -- Hitbox phần đầu siêu to
        if Config1.HitboxEnabled then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        local head = plr.Character.Head
                        head.Size = Vector3.new(Config1.HitboxSize, Config1.HitboxSize, Config1.HitboxSize)
                        head.Transparency = 0.5
                        head.CanCollide = false
                        head.Massless = true
                    end
                end
            end
        end

        if Config1.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end

        if Config1.FixLag then
            Lighting.GlobalShadows = false
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
        end

        local activeEnemies = 0
        for plr, drawings in pairs(EspCache1) do
            local char = plr.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")

            -- Xử lý ESP Cham (Highlight)
            if char and humanoid and humanoid.Health > 0 then
                if Config1.ESPCham then
                    local highlight = char:FindFirstChild("Hub1_Highlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "Hub1_Highlight"
                        highlight.Adornee = char
                        highlight.FillColor = RED_COLOR
                        highlight.OutlineColor = WHITE_COLOR
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = char
                    end
                else
                    local highlight = char:FindFirstChild("Hub1_Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            else
                local highlight = char and char:FindFirstChild("Hub1_Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end

            if char and rootPart and head and humanoid and humanoid.Health > 0 then
                local rootPos, rootOnScreen = Camera:WorldToViewportPoint(rootPart.Position)
                local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos, legOnScreen = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

                if rootOnScreen then
                    activeEnemies = activeEnemies + 1
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 2

                    if Config1.ESPBox then
                        drawings.Box.Size = Vector2.new(width, height)
                        drawings.Box.Position = Vector2.new(headPos.X - width / 2, headPos.Y)
                        drawings.Box.Visible = true
                    else
                        drawings.Box.Visible = false
                    end

                    if Config1.ESPLine then
                        drawings.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        drawings.Line.To = Vector2.new(rootPos.X, rootPos.Y)
                        drawings.Line.Visible = true
                    else
                        drawings.Line.Visible = false
                    end

                    if Config1.ESPHealth then
                        local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                        local barHeight = height
                        local barX = headPos.X - width / 2 - 6
                        local barY = headPos.Y

                        drawings.HealthBarBg.From = Vector2.new(barX, barY)
                        drawings.HealthBarBg.To = Vector2.new(barX, barY + barHeight)
                        drawings.HealthBarBg.Visible = true

                        drawings.HealthBar.From = Vector2.new(barX, barY + barHeight * (1 - healthPercent))
                        drawings.HealthBar.To = Vector2.new(barX, barY + barHeight)
                        drawings.HealthBar.Visible = true
                    else
                        drawings.HealthBarBg.Visible = false
                        drawings.HealthBar.Visible = false
                    end

                    if Config1.ESPName then
                        drawings.Name.Text = plr.Name .. (Config1.ESPHealth and (" [" .. math.floor(humanoid.Health) .. "HP]") or "")
                        drawings.Name.Position = Vector2.new(headPos.X, headPos.Y - 18)
                        drawings.Name.Visible = true
                    else
                        drawings.Name.Visible = false
                    end
                else
                    for _, obj in pairs(drawings) do obj.Visible = false end
                end
            else
                for _, obj in pairs(drawings) do obj.Visible = false end
            end
        end
    end)
end)


-- =========================================================================
-- HUB THỨ HAI: FREE FIRE SCRIPT HUB (Giữ nguyên các chức năng)
-- =========================================================================
task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local Camera = workspace.CurrentCamera

    local Config = {
        Aimbot = false,
        AimPart = "Head",
        AimRadius = 150,
        ShowFOV = false,
        ESPLine = false,
        ESPBox = false,
        ESPHealth = false,
        ESPName = false
    }

    local RED_COLOR = Color3.fromRGB(218, 37, 29)
    local BLUE_ACTIVE = Color3.fromRGB(0, 102, 204)
    local GRAY_INACTIVE = Color3.fromRGB(60, 60, 60)
    local GREEN_COLOR = Color3.fromRGB(0, 255, 0)
    local WHITE_COLOR = Color3.fromRGB(255, 255, 255)

    local fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 1.5
    fovCircle.NumSides = 64
    fovCircle.Filled = false
    fovCircle.Transparency = 1
    fovCircle.Color = GREEN_COLOR
    fovCircle.Visible = false

    local ffEnemyCountText = Drawing.new("Text")
    ffEnemyCountText.Size = 28
    ffEnemyCountText.Center = true
    ffEnemyCountText.Outline = true
    ffEnemyCountText.Color = RED_COLOR
    ffEnemyCountText.Visible = false

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FreeFireModMenu"
    screenGui.ResetOnSpawn = false
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local logoFrame = Instance.new("Frame")
    logoFrame.Size = UDim2.new(0, 55, 0, 55)
    logoFrame.Position = UDim2.new(1, -85, 0.5, -27)
    logoFrame.BackgroundTransparency = 1
    logoFrame.Active = true
    logoFrame.Parent = screenGui

    local logoImage = Instance.new("ImageButton")
    logoImage.Size = UDim2.new(1, 0, 1, 0)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://6031097225"
    logoImage.ImageColor3 = Color3.fromRGB(200, 200, 200)
    logoImage.Parent = logoFrame

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 410)
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -205)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = true
    mainFrame.Parent = screenGui

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = RED_COLOR
    header.BorderSizePixel = 0
    header.Parent = mainFrame

    local headerText = Instance.new("TextLabel")
    headerText.Size = UDim2.new(1, 0, 1, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "FREE FIRE"
    headerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerText.TextSize = 16
    headerText.Font = Enum.Font.GothamBold
    headerText.Parent = header

    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, -35)
    container.Position = UDim2.new(0, 0, 0, 35)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.CanvasSize = UDim2.new(0, 0, 0, 360)
    container.ScrollBarThickness = 4
    container.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 2)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    local function CreateToggle(parent, text, configKey)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = Config[configKey] and BLUE_ACTIVE or GRAY_INACTIVE
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.Parent = parent
        
        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            btn.BackgroundColor3 = Config[configKey] and BLUE_ACTIVE or GRAY_INACTIVE
        end)
        return btn
    end

    CreateToggle(container, "AIMBOT", "Aimbot")

    local headBtn = Instance.new("TextButton")
    headBtn.Size = UDim2.new(1, 0, 0, 35)
    headBtn.BackgroundColor3 = Config.AimPart == "Head" and BLUE_ACTIVE or GRAY_INACTIVE
    headBtn.BorderSizePixel = 0
    headBtn.Text = "ĐẦU"
    headBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    headBtn.TextSize = 13
    headBtn.Font = Enum.Font.GothamBold
    headBtn.Parent = container

    local neckBtn = Instance.new("TextButton")
    neckBtn.Size = UDim2.new(1, 0, 0, 35)
    neckBtn.BackgroundColor3 = Config.AimPart == "Neck" and BLUE_ACTIVE or GRAY_INACTIVE
    neckBtn.BorderSizePixel = 0
    neckBtn.Text = "CỔ"
    neckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    neckBtn.TextSize = 13
    neckBtn.Font = Enum.Font.GothamBold
    neckBtn.Parent = container

    headBtn.MouseButton1Click:Connect(function()
        Config.AimPart = "Head"
        headBtn.BackgroundColor3 = BLUE_ACTIVE
        neckBtn.BackgroundColor3 = GRAY_INACTIVE
    end)

    neckBtn.MouseButton1Click:Connect(function()
        Config.AimPart = "Neck"
        neckBtn.BackgroundColor3 = BLUE_ACTIVE
        headBtn.BackgroundColor3 = GRAY_INACTIVE
    end)

    local function CreateSlider(parent, labelText, min, max, configKey)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 50)
        frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local label = Instance.new("TextButton")
        label.Size = UDim2.new(1, -10, 0, 20)
        label.Position = UDim2.new(0, 5, 0, 2)
        label.BackgroundColor3 = Config.ShowFOV and BLUE_ACTIVE or GRAY_INACTIVE
        label.BorderSizePixel = 0
        label.Text = labelText .. (Config.ShowFOV and " [ON]: " or " [OFF]: ") .. string.format("%.0f", Config[configKey])
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        label.Parent = frame
        
        label.MouseButton1Click:Connect(function()
            Config.ShowFOV = not Config.ShowFOV
            label.BackgroundColor3 = Config.ShowFOV and BLUE_ACTIVE or GRAY_INACTIVE
            label.Text = labelText .. (Config.ShowFOV and " [ON]: " or " [OFF]: ") .. string.format("%.0f", Config[configKey])
        end)
        
        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -20, 0, 8)
        sliderBar.Position = UDim2.new(0, 10, 0, 32)
        sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        sliderBar.BorderSizePixel = 0
        sliderBar.Parent = frame
        
        local sliderBarCorner = Instance.new("UICorner")
        sliderBarCorner.CornerRadius = UDim.new(1, 0)
        sliderBarCorner.Parent = sliderBar
        
        local ball = Instance.new("Frame")
        ball.Size = UDim2.new(0, 16, 0, 16)
        ball.AnchorPoint = Vector2.new(0.5, 0.5)
        local initialScale = math.clamp((Config[configKey] - min) / (max - min), 0, 1)
        ball.Position = UDim2.new(initialScale, 0, 0.5, 0)
        ball.BackgroundColor3 = GREEN_COLOR
        ball.BorderSizePixel = 0
        ball.Parent = sliderBar
        
        local ballCorner = Instance.new("UICorner")
        ballCorner.CornerRadius = UDim.new(1, 0)
        ballCorner.Parent = ball
        
        local draggingSlider = false
        
        local function updateSlider(inputPosition)
            local pos = sliderBar.AbsolutePosition.X
            local size = sliderBar.AbsoluteSize.X
            local mouseX = inputPosition.X
            local scale = math.clamp((mouseX - pos) / size, 0, 1)
            local val = math.floor(min + scale * (max - min))
            Config[configKey] = val
            ball.Position = UDim2.new(scale, 0, 0.5, 0)
            label.Text = labelText .. (Config.ShowFOV and " [ON]: " or " [OFF]: ") .. string.format("%.0f", val)
        end
        
        sliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = true
                updateSlider(input.Position)
            end
        end)
        
        ball.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = true
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input.Position)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = false
            end
        end)
    end

    CreateSlider(container, "AIM RADIUS", 0, 400, "AimRadius")

    CreateToggle(container, "ESP LINE", "ESPLine")
    CreateToggle(container, "ESP Box", "ESPBox")
    CreateToggle(container, "ESP HP", "ESPHealth")
    CreateToggle(container, "ESP TÊN", "ESPName")

    local espCache = {}

    local function removeEsp(player)
        if espCache[player] then
            for _, obj in pairs(espCache[player]) do
                pcall(function() obj:Remove() end)
            end
            espCache[player] = nil
        end
    end

    Players.PlayerRemoving:Connect(removeEsp)

    local function isVisible(targetPart)
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then return false end
        local origin = Camera.CFrame.Position
        local direction = (targetPart.Position - origin)
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
        raycastParams.IgnoreWater = true
        
        local result = workspace:Raycast(origin, direction, raycastParams)
        if result then
            local hitInstance = result.Instance
            if hitInstance:IsDescendantOf(targetPart.Parent) then
                return true
            end
            return false
        end
        return true
    end

    local function getClosestTarget()
        local closestTarget = nil
        local shortestDistance = Config.AimRadius
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local partName = (Config.AimPart == "Head") and "Head" or "UpperTorso"
                local targetPart = player.Character:FindFirstChild(partName) or player.Character:FindFirstChild("Head")
                
                if targetPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if magnitude < shortestDistance then
                            if isVisible(targetPart) then
                                shortestDistance = magnitude
                                closestTarget = targetPart
                            end
                        end
                    end
                end
            end
        end
        return closestTarget
    end

    RunService.RenderStepped:Connect(function()
        if Config.ShowFOV then
            fovCircle.Visible = true
            fovCircle.Radius = Config.AimRadius
            fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircle.Visible = false
        end
        
        if Config.Aimbot then
            local target = getClosestTarget()
            if target then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            end
        end
        
        local activeEnemiesCount = 0

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if not espCache[player] then
                    espCache[player] = {
                        Box = Drawing.new("Square"),
                        Line = Drawing.new("Line"),
                        HealthBarBg = Drawing.new("Line"),
                        HealthBar = Drawing.new("Line"),
                        Name = Drawing.new("Text")
                    }
                    espCache[player].Box.Filled = false
                    espCache[player].Box.Thickness = 1.5
                    espCache[player].Line.Thickness = 1.5
                    espCache[player].HealthBarBg.Thickness = 4
                    espCache[player].HealthBar.Thickness = 2
                    espCache[player].Name.Size = 13
                    espCache[player].Name.Center = true
                    espCache[player].Name.Outline = true
                    espCache[player].Name.Color = WHITE_COLOR
                end
                
                local cache = espCache[player]
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if character and humanoid and rootPart and humanoid.Health > 0 then
                    local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        activeEnemiesCount = activeEnemiesCount + 1

                        local headPart = character:FindFirstChild("Head")
                        local headVector = headPart and Camera:WorldToViewportPoint(headPart.Position + Vector3.new(0, 0.5, 0)) or vector
                        local legVector = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                        
                        local boxHeight = math.abs(headVector.Y - legVector.Y)
                        local boxWidth = boxHeight / 2
                        local boxPos = Vector2.new(vector.X - boxWidth / 2, headVector.Y)
                        
                        if Config.ESPBox then
                            cache.Box.Visible = true
                            cache.Box.Size = Vector2.new(boxWidth, boxHeight)
                            cache.Box.Position = boxPos
                            cache.Box.Color = WHITE_COLOR
                        else
                            cache.Box.Visible = false
                        end
                        
                        if Config.ESPLine then
                            cache.Line.Visible = true
                            cache.Line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                            cache.Line.To = Vector2.new(boxPos.X + boxWidth / 2, boxPos.Y)
                            cache.Line.Color = WHITE_COLOR
                        else
                            cache.Line.Visible = false
                        end
                        
                        if Config.ESPHealth then
                            local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                            local barHeight = boxHeight * healthPercent
                            
                            cache.HealthBarBg.Visible = true
                            cache.HealthBarBg.From = Vector2.new(boxPos.X - 6, boxPos.Y + boxHeight)
                            cache.HealthBarBg.To = Vector2.new(boxPos.X - 6, boxPos.Y)
                            cache.HealthBarBg.Color = Color3.fromRGB(0, 0, 0)
                            
                            cache.HealthBar.Visible = true
                            cache.HealthBar.From = Vector2.new(boxPos.X - 6, boxPos.Y + boxHeight)
                            cache.HealthBar.To = Vector2.new(boxPos.X - 6, boxPos.Y + (boxHeight - barHeight))
                            cache.HealthBar.Color = GREEN_COLOR
                        else
                            cache.HealthBar.Visible = false
                            cache.HealthBarBg.Visible = false
                        end
                        
                        if Config.ESPName then
                            cache.Name.Visible = true
                            cache.Name.Text = player.Name
                            cache.Name.Position = Vector2.new(boxPos.X + boxWidth / 2, boxPos.Y - 18)
                        else
                            cache.Name.Visible = false
                        end
                    else
                        cache.Box.Visible = false
                        cache.Line.Visible = false
                        cache.HealthBar.Visible = false
                        cache.HealthBarBg.Visible = false
                        cache.Name.Visible = false
                    end
                else
                    cache.Box.Visible = false
                    cache.Line.Visible = false
                    cache.HealthBar.Visible = false
                    cache.HealthBarBg.Visible = false
                    cache.Name.Visible = false
                end
            end
        end

        if Config.ESPLine then
            ffEnemyCountText.Text = tostring(activeEnemiesCount)
            ffEnemyCountText.Position = Vector2.new(Camera.ViewportSize.X / 2, 45)
            ffEnemyCountText.Visible = true
        else
            ffEnemyCountText.Visible = false
        end
    end)

    local logoDragging = false
    local logoDragStart = Vector2.new()
    local logoStartPos = UDim2.new()
    local logoHasMoved = false

    logoImage.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            logoDragging = true
            logoHasMoved = false
            logoDragStart = input.Position
            logoStartPos = logoFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if logoDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - logoDragStart
            if delta.Magnitude > 5 then logoHasMoved = true end
            logoFrame.Position = UDim2.new(logoStartPos.X.Scale, logoStartPos.X.Offset + delta.X, logoStartPos.Y.Scale, logoStartPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if logoDragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            logoDragging = false
            if not logoHasMoved then mainFrame.Visible = not mainFrame.Visible end
        end
    end)

    local headerDragging = false
    local headerDragStart = Vector2.new()
    local headerStartPos = UDim2.new()
    local headerHasMoved = false

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            headerDragging = true
            headerHasMoved = false
            headerDragStart = input.Position
            headerStartPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if headerDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - headerDragStart
            if delta.Magnitude > 6 then headerHasMoved = true end
            mainFrame.Position = UDim2.new(headerStartPos.X.Scale, headerStartPos.X.Offset + delta.X, headerStartPos.Y.Scale, headerStartPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if headerDragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            headerDragging = false
            if not headerHasMoved then mainFrame.Visible = false end
        end
    end)
end)
