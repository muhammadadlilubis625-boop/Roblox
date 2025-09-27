-- Modern Auto Summit Panel
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

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoSummitGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Tombol awal (Launch)
local launchBtn = Instance.new("TextButton")
launchBtn.Size = UDim2.new(0,150,0,50)
launchBtn.Position = UDim2.new(0.5,-75,0.5,-25) -- tengah
launchBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
launchBtn.TextColor3 = Color3.fromRGB(30,30,30)
launchBtn.Font = Enum.Font.GothamBold
launchBtn.TextSize = 18
launchBtn.Text = "Open Panel"
launchBtn.AutoButtonColor = true
launchBtn.Parent = ScreenGui

-- Panel utama
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,200)
frame.Position = UDim2.new(0.5,-150,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(240,240,240)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.05
frame.Parent = ScreenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Mount Taranjang Auto Summit"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(50,50,50)
title.Parent = frame

-- Input jumlah
local repsBox = Instance.new("TextBox")
repsBox.PlaceholderText = "Jumlah (0 = Infinite)"
repsBox.Size = UDim2.new(0.9,0,0,30)
repsBox.Position = UDim2.new(0.05,0,0.25,0)
repsBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
repsBox.TextColor3 = Color3.fromRGB(30,30,30)
repsBox.Text = ""
repsBox.Font = Enum.Font.Gotham
repsBox.TextSize = 14
repsBox.Parent = frame

-- Input delay
local delayBox = repsBox:Clone()
delayBox.Parent = frame
delayBox.PlaceholderText = "Delay antar teleport (detik)"
delayBox.Position = UDim2.new(0.05,0,0.45,0)

-- Tombol teleport
local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0.9,0,0,30)
teleportBtn.Position = UDim2.new(0.05,0,0.65,0)
teleportBtn.Text = "Teleport Sekarang"
teleportBtn.BackgroundColor3 = Color3.fromRGB(100,100,200)
teleportBtn.TextColor3 = Color3.fromRGB(255,255,255)
teleportBtn.Font = Enum.Font.GothamBold
teleportBtn.TextSize = 14
teleportBtn.Parent = frame

-- Tombol start
local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0.4,0,0,30)
startBtn.Position = UDim2.new(0.05,0,0.85,0)
startBtn.Text = "Start Auto"
startBtn.BackgroundColor3 = Color3.fromRGB(100,200,100)
startBtn.TextColor3 = Color3.fromRGB(255,255,255)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
startBtn.Parent = frame

-- Tombol stop
local stopBtn = startBtn:Clone()
stopBtn.Parent = frame
stopBtn.Position = UDim2.new(0.55,0,0.85,0)
stopBtn.Text = "Stop Auto"
stopBtn.BackgroundColor3 = Color3.fromRGB(200,100,100)

-- Events
launchBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    launchBtn.Visible = false
end)

teleportBtn.MouseButton1Click:Connect(function()
    teleportToSummit()
end)

startBtn.MouseButton1Click:Connect(function()
    local n = tonumber(repsBox.Text)
    local d = tonumber(delayBox.Text)
    teleportsLeft = (n and n > 0) and n or -1
    delayTime = (d and d >= 0) and d or 2
    if not running then
        startTeleportLoop()
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)
