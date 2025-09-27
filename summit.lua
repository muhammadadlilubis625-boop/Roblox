--[[ 
    ================================================
    MOUNT TARANJANG AUTO SUMMIT - STELLAR SINGLE TAB
    Fix: Logika teleportasi diperkuat agar Auto Loop
    berjalan stabil setelah respawn (di Delta).
    ================================================
]]

-- UBAH INI SESUAI KEINGINANMU
local Author = "Rafaczx"
local SUMMIT_CFRAME = CFrame.new(8711.95215, 1637.02124, 1343.46667, 0.375418901, -4.74302198e-09, 0.926855266, 1.80503723e-10, 1, 5.04421527e-09, -0.926855266, -1.72639292e-09, 0.375418901)
-- ================================================

-- 1. MEMUAT LIBRARY STELLAR
local StellarLibrary = (loadstring(Game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/NewUiStellar.lua")))();

if StellarLibrary:LoadAnimation() then
	StellarLibrary:StartLoad();
end;
if StellarLibrary:LoadAnimation() then
	StellarLibrary:Loaded();
end;

-- 2. LOGIKA TELEPORTASI (Diperkuat)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local running = false
local teleportsLeft = 0
local delayTime = 2

local function teleportToSummit()
    local char = player.Character
    if not char then 
        player.CharacterAdded:Wait()
        char = player.Character
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- 1. Kill the character
    humanoid.Health = 0
    
    -- 2. Wajib: Tunggu sampai karakter lama hilang (karakter = nil)
    while player.Character ~= nil do
        task.wait()
    end
    
    -- 3. Wajib: Tunggu sampai karakter baru muncul (menggunakan CharacterAdded)
    local newChar = player.Character
    while newChar == nil do
        -- Gunakan CharacterAdded:Wait untuk menunggu event, lalu cek lagi
        player.CharacterAdded:Wait()
        newChar = player.Character
    end
    
    -- 4. Teleport karakter baru
    local humanoidRootPart = newChar:WaitForChild("HumanoidRootPart", 10) -- Tambah timeout
    if humanoidRootPart then
        humanoidRootPart.CFrame = SUMMIT_CFRAME
    end
end

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

local function stopTeleportLoop()
    running = false
end


-- 3. PEMBUATAN WINDOW DAN TAB TUNGGAL
local UserInputService = game:GetService("UserInputService")
local Window = StellarLibrary:Window({
	SubTitle = "Rafaczx HUB - " .. Author,
	Size = game:GetService("UserInputService").TouchEnabled and UDim2.new(0, 380, 0, 260) or UDim2.new(0, 500, 0, 320),
	TabWidth = 140
})

local SummitTab = Window:Tab("Mount Taranjang", "rbxassetid://10723407389")


-- 4. MENAMBAHKAN KONTROL AUTO SUMMIT KE TAB
SummitTab:Seperator("Teleport & Loop Settings by " .. Author);

local TeleportCountSlider = SummitTab:Slider("Loop Count (0 = Infinite)", 0, 100, 10, function(value)
    teleportsLeft = math.floor(value)
    if value == 0 then teleportsLeft = -1 end
end)

local DelaySlider = SummitTab:Slider("Delay (seconds)", 0.5, 10, 2, function(value)
    delayTime = value
end)

SummitTab:Line();

SummitTab:Button("Teleport Sekarang (Sekali)", function()
    teleportToSummit();
    StellarLibrary:Notify("Teleport berhasil ke Summit!", 2);
end);

SummitTab:Toggle("Auto Summit (Start/Stop)", nil, function(state)
    if state then
        -- Ambil nilai terakhir dari slider sebelum memulai
        teleportsLeft = math.floor(TeleportCountSlider:GetValue())
        if teleportsLeft == 0 then teleportsLeft = -1 end
        delayTime = DelaySlider:GetValue()

        startTeleportLoop();
        StellarLibrary:Notify("Auto Summit dimulai! Count: " .. (teleportsLeft == -1 and "Infinite" or teleportsLeft), 3);
    else
        stopTeleportLoop();
        StellarLibrary:Notify("Auto Summit dihentikan.", 2);
    end
end);
