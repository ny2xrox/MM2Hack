local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Hacker_Rox_MM2_PREMIUM"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Gradient ve köşe fonksiyonları
local function addGradient(object, colors, transparency)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    if transparency then
        gradient.Transparency = NumberSequence.new(transparency)
    end
    gradient.Parent = object
    return gradient
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = object
    return corner
end

local function addStroke(object, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 2
    stroke.Color = color or Color3.fromRGB(100, 200, 255)
    stroke.Transparency = 0.3
    stroke.Parent = object
    return stroke
end

local function makeButton(text, sizeX, sizeY)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(0, sizeX, 0, sizeY)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Active = true
    btn.Selectable = false
    btn.BackgroundTransparency = 0
    btn.TextTransparency = 0
    
    addCorner(btn, 8)
    addStroke(btn, 1, Color3.fromRGB(70, 130, 200))
    
    -- Hover efekti
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
    end)
    
    return btn
end

local function makeLabel(text, sizeX, sizeY)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0, sizeX, 0, sizeY)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(150, 200, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Selectable = false
    label.TextTransparency = 0
    return label
end

-- Ana frame - geliştirilmiş tasarım
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 340, 0, 720)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.BackgroundTransparency = 0
frame.Parent = ScreenGui

addCorner(frame, 15)
addStroke(frame, 2, Color3.fromRGB(100, 150, 255))

-- Başlık çubuğu
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
titleBar.BorderSizePixel = 0
titleBar.BackgroundTransparency = 0
titleBar.Parent = frame
addCorner(titleBar, 15)

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "🎯 Hacker_Rox MM2 Premium 🎯"
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.TextTransparency = 0
titleLabel.Parent = titleBar

local toggleButton = Instance.new("TextButton")
toggleButton.Text = "➖"
toggleButton.Size = UDim2.new(0, 35, 0, 35)
toggleButton.Position = UDim2.new(0.82, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.BackgroundTransparency = 0
toggleButton.TextTransparency = 0
toggleButton.Parent = titleBar
addCorner(toggleButton, 8)

-- İçerik frame'i
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.Visible = true
contentFrame.Parent = frame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -15, 1, 0)
ScrollingFrame.Position = UDim2.new(0, 7, 0, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1400)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Parent = contentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollingFrame

-- Değişkenler
local espEnabled = false
local espBoxes = {}
local espConnection
local nameESPEnabled = false
local nameESPLabels = {}
local weaponESPEnabled = false
local weaponESPBoxes = {}
local coinESPEnabled = false
local coinESPBoxes = {}
local playerDistanceEnabled = false
local distanceLabels = {}
local aimbotEnabled = false
local aimbotConnection

-- Temizlik fonksiyonları
local function clearESP()
    for _, box in pairs(espBoxes) do
        if box and box.Parent then box:Destroy() end
    end
    espBoxes = {}
end

local function clearNameESP()
    for _, label in pairs(nameESPLabels) do
        if label and label.Parent then label:Destroy() end
    end
    nameESPLabels = {}
end

local function clearWeaponESP()
    for _, box in pairs(weaponESPBoxes) do
        if box and box.Parent then box:Destroy() end
    end
    weaponESPBoxes = {}
end

local function clearCoinESP()
    for _, box in pairs(coinESPBoxes) do
        if box and box.Parent then box:Destroy() end
    end
    coinESPBoxes = {}
end

local function clearDistanceLabels()
    for _, label in pairs(distanceLabels) do
        if label and label.Parent then label:Destroy() end
    end
    distanceLabels = {}
end

-- ESP fonksiyonları
local function createESPBox(part, color)
    local ador = Instance.new("BoxHandleAdornment")
    ador.Name = "ESPBox"
    ador.Adornee = part
    ador.AlwaysOnTop = true
    ador.ZIndex = 10
    ador.Size = part.Size
    ador.Transparency = 0.3
    ador.Color3 = color
    ador.Parent = part
    return ador
end

local function createNameESP(part, text, color)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = billboard
    
    return billboard
end

local function getPlayerRole(player)
    if not player or not player.Character then return "Innocent" end
    
    if player.Team then
        local teamName = player.Team.Name
        if teamName == "Murderer" then
            return "Killer"
        elseif teamName == "Sheriff" then
            return "Sheriff"
        end
    end
    
    for _, tool in pairs(player.Character:GetChildren()) do
        if tool:IsA("Tool") then
            if tool.Name == "Revolver" or tool.Name == "Gun" then
                return "Sheriff"
            elseif tool.Name == "Knife" then
                return "Killer"
            end
        end
    end
    
    if player:FindFirstChild("Backpack") then
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                if tool.Name == "Revolver" or tool.Name == "Gun" then
                    return "Sheriff"
                elseif tool.Name == "Knife" then
                    return "Killer"
                end
            end
        end
    end
    
    return "Innocent"
end

-- Aimbot fonksiyonu
local function aimAtTarget()
    if not aimbotEnabled then return end
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local nearestKiller = nil
    local nearestDistance = math.huge
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = getPlayerRole(plr)
            if role == "Killer" then
                local distance = (plr.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < nearestDistance and distance < 100 then
                    nearestDistance = distance
                    nearestKiller = plr
                end
            end
        end
    end
    
    if nearestKiller and nearestKiller.Character and nearestKiller.Character:FindFirstChild("Head") then
        local targetPosition = nearestKiller.Character.Head.Position
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
        
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name == "Revolver" or tool.Name == "Gun") then
            tool:Activate()
        end
    end
end

local function updateESP()
    clearESP()
    clearNameESP()
    clearWeaponESP()
    clearCoinESP()
    clearDistanceLabels()
    
    if not (espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled) then return end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = getPlayerRole(plr)
            local color = Color3.fromRGB(255, 255, 255)
            
            if role == "Killer" then 
                color = Color3.fromRGB(255, 50, 50)
            elseif role == "Sheriff" then 
                color = Color3.fromRGB(50, 150, 255)
            end
            
            if espEnabled then
                for _, part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        local box = createESPBox(part, color)
                        table.insert(espBoxes, box)
                    end
                end
            end
            
            if nameESPEnabled and plr.Character:FindFirstChild("Head") then
                local nameLabel = createNameESP(plr.Character.Head, plr.Name .. " [" .. role .. "]", color)
                table.insert(nameESPLabels, nameLabel)
            end
            
            if playerDistanceEnabled and plr.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor((plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                local distanceLabel = createNameESP(plr.Character.Head, distance .. "m", Color3.fromRGB(255, 255, 100))
                distanceLabel.StudsOffset = Vector3.new(0, -1, 0)
                table.insert(distanceLabels, distanceLabel)
            end
        end
    end
    
    if weaponESPEnabled then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Tool") and (obj.Name == "Revolver" or obj.Name == "Gun" or obj.Name == "Knife") then
                if obj:FindFirstChild("Handle") then
                    local box = createESPBox(obj.Handle, Color3.fromRGB(255, 255, 100))
                    table.insert(weaponESPBoxes, box)
                end
            end
        end
    end
    
    if coinESPEnabled then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin" or obj.Name == "CoinContainer" or (obj:IsA("Part") and obj.BrickColor == BrickColor.new("Bright yellow")) then
                local box = createESPBox(obj, Color3.fromRGB(255, 215, 0))
                table.insert(coinESPBoxes, box)
            end
        end
    end
end

-- UI elemanları
local imageLabel = makeLabel("🎨 Görsel Özellikler", 320, 24)
imageLabel.Parent = ScrollingFrame

local imageButton = makeButton("🔍 ESP Aç/Kapa", 320, 40)
imageButton.Parent = ScrollingFrame
imageButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        imageButton.Text = "🔍 ESP Açık ✅"
        imageButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled then
                updateESP()
            end
        end)
    else
        imageButton.Text = "🔍 ESP Kapalı ❌"
        imageButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        
        if not (nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled) then
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
        end
        clearESP()
    end
end)

local nameESPButton = makeButton("📝 Name ESP Aç/Kapa", 320, 40)
nameESPButton.Parent = ScrollingFrame
nameESPButton.MouseButton1Click:Connect(function()
    nameESPEnabled = not nameESPEnabled
    nameESPButton.Text = nameESPEnabled and "📝 Name ESP Açık ✅" or "📝 Name ESP Kapalı ❌"
    nameESPButton.BackgroundColor3 = nameESPEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if nameESPEnabled and not espConnection then
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled then
                updateESP()
            end
        end)
    elseif not nameESPEnabled then
        clearNameESP()
        if not (espEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled) then
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
        end
    end
end)

local weaponESPButton = makeButton("⚔️ Weapon ESP Aç/Kapa", 320, 40)
weaponESPButton.Parent = ScrollingFrame
weaponESPButton.MouseButton1Click:Connect(function()
    weaponESPEnabled = not weaponESPEnabled
    weaponESPButton.Text = weaponESPEnabled and "⚔️ Weapon ESP Açık ✅" or "⚔️ Weapon ESP Kapalı ❌"
    weaponESPButton.BackgroundColor3 = weaponESPEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if weaponESPEnabled and not espConnection then
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled then
                updateESP()
            end
        end)
    elseif not weaponESPEnabled then
        clearWeaponESP()
        if not (espEnabled or nameESPEnabled or coinESPEnabled or playerDistanceEnabled) then
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
        end
    end
end)

local coinESPButton = makeButton("🪙 Coin ESP Aç/Kapa", 320, 40)
coinESPButton.Parent = ScrollingFrame
coinESPButton.MouseButton1Click:Connect(function()
    coinESPEnabled = not coinESPEnabled
    coinESPButton.Text = coinESPEnabled and "🪙 Coin ESP Açık ✅" or "🪙 Coin ESP Kapalı ❌"
    coinESPButton.BackgroundColor3 = coinESPEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if coinESPEnabled and not espConnection then
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled then
                updateESP()
            end
        end)
    elseif not coinESPEnabled then
        clearCoinESP()
        if not (espEnabled or nameESPEnabled or weaponESPEnabled or playerDistanceEnabled) then
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
        end
    end
end)

local distanceButton = makeButton("📏 Player Distance Aç/Kapa", 320, 40)
distanceButton.Parent = ScrollingFrame
distanceButton.MouseButton1Click:Connect(function()
    playerDistanceEnabled = not playerDistanceEnabled
    distanceButton.Text = playerDistanceEnabled and "📏 Distance Açık ✅" or "📏 Distance Kapalı ❌"
    distanceButton.BackgroundColor3 = playerDistanceEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if playerDistanceEnabled and not espConnection then
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled or playerDistanceEnabled then
                updateESP()
            end
        end)
    elseif not playerDistanceEnabled then
        clearDistanceLabels()
        if not (espEnabled or nameESPEnabled or weaponESPEnabled or coinESPEnabled) then
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
        end
    end
end)

-- Aimbot
local aimbotLabel = makeLabel("🎯 Otomatik Nişan", 320, 24)
aimbotLabel.Parent = ScrollingFrame

local aimbotButton = makeButton("🎯 Aimbot Aç/Kapa", 320, 40)
aimbotButton.Parent = ScrollingFrame
aimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotButton.Text = aimbotEnabled and "🎯 Aimbot Açık ✅" or "🎯 Aimbot Kapalı ❌"
    aimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if aimbotEnabled then
        aimbotConnection = RunService.Heartbeat:Connect(aimAtTarget)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    end
end)

-- Teleport bölümü
local teleportLabel = makeLabel("🚀 Işınlanma", 320, 24)
teleportLabel.Parent = ScrollingFrame

local tpNearbyButton = makeButton("🚀 Teleport (Yakına)", 320, 40)
tpNearbyButton.Parent = ScrollingFrame
tpNearbyButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    local nearestPlayer = nil
    local nearestDistance = math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < nearestDistance then
                nearestDistance = dist
                nearestPlayer = plr
            end
        end
    end
    if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
        hrp.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    end
end)

local teleportMurderButton = makeButton("🔪 Teleport Murder", 320, 40)
teleportMurderButton.Parent = ScrollingFrame
teleportMurderButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local role = getPlayerRole(plr)
            if role == "Killer" and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

local teleportSheriffButton = makeButton("🔫 Teleport Sheriff", 320, 40)
teleportSheriffButton.Parent = ScrollingFrame
teleportSheriffButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local role = getPlayerRole(plr)
            if role == "Sheriff" and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

-- Otomatik özellikler
local autoLabel = makeLabel("🤖 Otomatik Özellikler", 320, 24)
autoLabel.Parent = ScrollingFrame

local autoCollectEnabled = false
local autoCollectConn

local autoCollectButton = makeButton("🪙 Auto Collect Coins", 320, 40)
autoCollectButton.Parent = ScrollingFrame
autoCollectButton.MouseButton1Click:Connect(function()
    autoCollectEnabled = not autoCollectEnabled
    autoCollectButton.Text = autoCollectEnabled and "🪙 Auto Collect Açık ✅" or "🪙 Auto Collect Kapalı ❌"
    autoCollectButton.BackgroundColor3 = autoCollectEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if autoCollectEnabled then
        autoCollectConn = RunService.Heartbeat:Connect(function()
            if not autoCollectEnabled then return end
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name == "Coin" or obj.Name == "CoinContainer" or (obj:IsA("Part") and obj.BrickColor == BrickColor.new("Bright yellow")) then
                    local distance = (obj.Position - character.HumanoidRootPart.Position).Magnitude
                    if distance < 50 then
                        obj.CFrame = character.HumanoidRootPart.CFrame
                    end
                end
            end
        end)
    else
        if autoCollectConn then
            autoCollectConn:Disconnect()
            autoCollectConn = nil
        end
    end
end)

local autoPickupEnabled = false
local autoPickupConn

local autoPickupButton = makeButton("🔫 Auto Pickup Guns", 320, 40)
autoPickupButton.Parent = ScrollingFrame
autoPickupButton.MouseButton1Click:Connect(function()
    autoPickupEnabled = not autoPickupEnabled
    autoPickupButton.Text = autoPickupEnabled and "🔫 Auto Pickup Açık ✅" or "🔫 Auto Pickup Kapalı ❌"
    autoPickupButton.BackgroundColor3 = autoPickupEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if autoPickupEnabled then
        autoPickupConn = RunService.Heartbeat:Connect(function()
            if not autoPickupEnabled then return end
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Tool") and (obj.Name == "Revolver" or obj.Name == "Gun") then
                    if obj:FindFirstChild("Handle") then
                        local distance = (obj.Handle.Position - character.HumanoidRootPart.Position).Magnitude
                        if distance < 30 then
                            obj.Handle.CFrame = character.HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end)
    else
        if autoPickupConn then
            autoPickupConn:Disconnect()
            autoPickupConn = nil
        end
    end
end)

-- Savaş özellikleri
local combatLabel = makeLabel("⚔️ Savaş Özellikleri", 320, 24)
combatLabel.Parent = ScrollingFrame

local killAuraEnabled = false
local killAuraTeleportEnabled = false
local killAuraConn

local function getNearestKillTarget(range)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = character.HumanoidRootPart
    local nearestPlayer = nil
    local nearestDistance = range
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < nearestDistance then
                nearestDistance = dist
                nearestPlayer = plr
            end
        end
    end
    return nearestPlayer
end

local function attackPlayer(plr)
    local character = LocalPlayer.Character
    if not character then return end
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    if killAuraTeleportEnabled then
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
    
    pcall(function()
        tool:Activate()
        if tool:FindFirstChild("Handle") then
            local args = {
                [1] = "Slash"
            }
            if tool:FindFirstChild("RemoteEvent") then
                tool.RemoteEvent:FireServer(unpack(args))
            end
        end
    end)
end

local killAuraButton = makeButton("⚔️ Kill Aura", 320, 40)
killAuraButton.Parent = ScrollingFrame
killAuraButton.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    if killAuraEnabled then
        killAuraTeleportEnabled = false
        local killAuraTPButton = ScrollingFrame:FindFirstChild("🗡️ Kill Aura + Teleport")
        if killAuraTPButton then
            killAuraTPButton.Text = "🗡️ Kill Aura + TP Kapalı ❌"
            killAuraTPButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        end
        killAuraButton.Text = "⚔️ Kill Aura Açık ✅"
        killAuraButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        killAuraConn = RunService.Heartbeat:Connect(function()
            if not killAuraEnabled then return end
            local target = getNearestKillTarget(20)
            if target then
                wait(0.1)
                attackPlayer(target)
            end
        end)
    else
        killAuraButton.Text = "⚔️ Kill Aura Kapalı ❌"
        killAuraButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        if killAuraConn then 
            killAuraConn:Disconnect() 
            killAuraConn = nil 
        end
    end
end)

local killAuraTPButton = makeButton("🗡️ Kill Aura + Teleport", 320, 40)
killAuraTPButton.Parent = ScrollingFrame
killAuraTPButton.MouseButton1Click:Connect(function()
    killAuraTeleportEnabled = not killAuraTeleportEnabled
    if killAuraTeleportEnabled then
        killAuraEnabled = false
        killAuraButton.Text = "⚔️ Kill Aura Kapalı ❌"
        killAuraButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        killAuraTPButton.Text = "🗡️ Kill Aura+TP Açık ✅"
        killAuraTPButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        
        killAuraConn = RunService.Heartbeat:Connect(function()
            if not killAuraTeleportEnabled then return end
            local target = getNearestKillTarget(50)
            if target then
                wait(0.1)
                attackPlayer(target)
            end
        end)
    else
        killAuraTPButton.Text = "🗡️ Kill Aura + TP Kapalı ❌"
        killAuraTPButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        if killAuraConn then 
            killAuraConn:Disconnect() 
            killAuraConn = nil 
        end
    end
end)

local instantKillEnabled = false
local instantKillConn

local instantKillButton = makeButton("💀 Instant Kill", 320, 40)
instantKillButton.Parent = ScrollingFrame
instantKillButton.MouseButton1Click:Connect(function()
    instantKillEnabled = not instantKillEnabled
    instantKillButton.Text = instantKillEnabled and "💀 Instant Kill Açık ✅" or "💀 Instant Kill Kapalı ❌"
    instantKillButton.BackgroundColor3 = instantKillEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    if instantKillEnabled then
        instantKillConn = RunService.Heartbeat:Connect(function()
            if not instantKillEnabled then return end
            local character = LocalPlayer.Character
            if not character then return end
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and tool.Name == "Knife" then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (plr.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                        if distance < 25 then
                            pcall(function()
                                plr.Character.Humanoid.Health = 0
                                plr.Character.Humanoid:TakeDamage(math.huge)
                                if plr.Character:FindFirstChild("Head") then
                                    plr.Character.Head:Destroy()
                                end
                            end)
                        end
                    end
                end
            end
        end)
    else
        if instantKillConn then
            instantKillConn:Disconnect()
            instantKillConn = nil
        end
    end
end)

-- Oyuncu özellikleri
local playerLabel = makeLabel("👤 Oyuncu Özellikleri", 320, 24)
playerLabel.Parent = ScrollingFrame

local speedEnabled = false
local normalWalkSpeed = 16
local speedValue = 80

local speedButton = makeButton("💨 Hız Aç/Kapa", 320, 40)
speedButton.Parent = ScrollingFrame
speedButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    local humanoid = character.Humanoid
    speedEnabled = not speedEnabled
    if speedEnabled then
        humanoid.WalkSpeed = speedValue
        speedButton.Text = "💨 Hız Açık ✅"
        speedButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        humanoid.WalkSpeed = normalWalkSpeed
        speedButton.Text = "💨 Hız Kapalı ❌"
        speedButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

local jumpEnabled = false
local normalJumpPower = 50
local jumpValue = 120

local jumpButton = makeButton("🦘 Zıplama Aç/Kapa", 320, 40)
jumpButton.Parent = ScrollingFrame
jumpButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    local humanoid = character.Humanoid
    jumpEnabled = not jumpEnabled
    if jumpEnabled then
        humanoid.JumpPower = jumpValue
        jumpButton.Text = "🦘 Zıplama Açık ✅"
        jumpButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        humanoid.JumpPower = normalJumpPower
        jumpButton.Text = "🦘 Zıplama Kapalı ❌"
        jumpButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

local noclipEnabled = false
local noclipConn

local function noclipLoop()
    local character = LocalPlayer.Character
    if not character then return end
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipEnabled
        end
    end
end

local noclipButton = makeButton("👻 Noclip Aç/Kapa", 320, 40)
noclipButton.Parent = ScrollingFrame
noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    noclipButton.Text = noclipEnabled and "👻 Noclip Açık ✅" or "👻 Noclip Kapalı ❌"
    if noclipEnabled then 
        noclipConn = RunService.Heartbeat:Connect(noclipLoop)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        noclipLoop()
    end
end)

local godModeEnabled = false

local godModeButton = makeButton("🛡️ God Mode Aç/Kapa", 320, 40)
godModeButton.Parent = ScrollingFrame
godModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    godModeButton.Text = godModeEnabled and "🛡️ God Mode Açık ✅" or "🛡️ God Mode Kapalı ❌"
    godModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if godModeEnabled then
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        else
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
    end
end)

-- Sürükleme fonksiyonalitesi
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
    TweenService:Create(frame, TweenInfo.new(0.1), {Position = newPosition}):Play()
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Gizle/göster fonksiyonalitesi
toggleButton.MouseButton1Click:Connect(function()
    local isVisible = contentFrame.Visible
    contentFrame.Visible = not isVisible
    toggleButton.Text = isVisible and "➕" or "➖"
    
    local targetSize = isVisible and UDim2.new(0, 340, 0, 40) or UDim2.new(0, 340, 0, 720)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
end)

wait(1)
print("🎯 Hacker_Rox MM2 Premium Menu Loaded Successfully! 🎯")
