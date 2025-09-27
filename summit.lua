-- Modern Auto Summit Panel (Desain Baru)
-- by Gemini & rispha

-- Variabel untuk CFrame summit
local SUMMIT_CFRAME = CFrame.new(8711.95215, 1637.02124, 1343.46667, 0.375418901, -4.74302198e-09, 0.926855266, 1.80503723e-10, 1, 5.04421527e-09, -0.926855266, -1.72639292e-09, 0.375418901)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Vars
local running = false
local teleportsLeft = 0
local delayTime = 2

-- Fungsi teleportasi
local function teleportToSummit()
    local char = player.Character
    if not char then 
        player.CharacterAdded:Wait()
        char = player.Character
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0 -- Reset karakter
    end
    
    player.CharacterAdded:Wait()
    char = player.Character
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    
    humanoidRootPart.CFrame = SUMMIT_CFRAME
end

-- Loop function
local function startTeleportLoop()
    running = true
    task.spawn(function()
        while running and (teleportsLeft > 0 or teleportsLeft == -1) do
            teleportToSummit()
            if delayTime > 0 then task.wait(delayTime) end
            if teleportsLeft > 0 then
                teleportsLeft -= 1
            end
        end
        running = false
    end)
end

-- GUI (Desain Baru)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoSummitGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 220)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

-- UI Corner untuk sudut yang melengkung
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Mount Taranjang Auto Summit"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = mainFrame

-- Tombol Minimize
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 20, 0, 20)
minimizeBtn.Position = UDim2.new(1, -25, 0, 5)
minimizeBtn.Text = "_"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.TextSize = 18
minimizeBtn.Parent = mainFrame

-- Konten utama
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0.9, 0, 0, 40)
teleportBtn.Position = UDim2.new(0.05, 0, 0, 10)
teleportBtn.Text = "Teleport Sekarang"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
teleportBtn.Font = Enum.Font.GothamBold
teleportBtn.TextSize = 16
teleportBtn.Parent = contentFrame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.9, 0, 0, 20)
label.Position = UDim2.new(0.05, 0, 0, 60)
label.Text = "Jumlah teleport (0 = tak terbatas):"
label.TextColor3 = Color3.fromRGB(240, 240, 240)
label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.Parent = contentFrame

local countInput = Instance.new("TextBox")
countInput.Size = UDim2.new(0.9, 0, 0, 30)
countInput.Position = UDim2.new(0.05, 0, 0, 85)
countInput.PlaceholderText = "Masukkan jumlah"
countInput.Text = "10"
countInput.TextColor3 = Color3.fromRGB(240, 240, 240)
countInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
countInput.Font = Enum.Font.Gotham
countInput.TextSize = 14
countInput.Parent = contentFrame

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0.4, 0, 0, 40)
startBtn.Position = UDim2.new(0.05, 0, 0, 130)
startBtn.Text = "Mulai Auto"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 16
startBtn.Parent = contentFrame

local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0.4, 0, 0, 40)
stopBtn.Position = UDim2.new(0.55, 0, 0, 130)
stopBtn.Text = "Hentikan"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 16
stopBtn.Parent = contentFrame

-- Events
minimizeBtn.MouseButton1Click:Connect(function()
    contentFrame.Visible = not contentFrame.Visible
    mainFrame.Size = contentFrame.Visible and UDim2.new(0, 280, 0, 220) or UDim2.new(0, 280, 0, 30)
end)

teleportBtn.MouseButton1Click:Connect(function()
    teleportToSummit()
end)

startBtn.MouseButton1Click:Connect(function()
    local n = tonumber(countInput.Text)
    teleportsLeft = (n and n >= 0) and n or 10
    if not running then
        startTeleportLoop()
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)

-- Hover effect
local function applyHover(button)
    local originalColor = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = originalColor:Lerp(Color3.new(1, 1, 1), 0.2)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
end

applyHover(teleportBtn)
applyHover(startBtn)
applyHover(stopBtn)
applyHover(minimizeBtn)
