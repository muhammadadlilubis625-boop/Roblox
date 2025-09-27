--[[ 
    ================================================
    MOUNT TARANJANG AUTO SUMMIT - STELLAR SINGLE TAB
    Fix: Input Slider diganti Textbox untuk kompatibilitas
    Executor yang lebih baik.
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

-- 2. LOGIKA TELEPORTASI
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Set nilai default dari Textbox saat inisialisasi
local running = false
local teleportsLeft = 10 -- Nilai default Textbox 10
local delayTime = 2     -- Nilai default Textbox 2

local function teleportToSummit()
    local char = player.Character
    
    -- 1. Siapkan sinyal untuk menunggu karakter BARU (lebih andal)
    local newCharSignal = player.CharacterAdded:Once()
    
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0 -- Kill
        end
    end

    -- 2. Tunggu sampai karakter lama hilang (agar event CharacterAdded yang selanjutnya dipastikan karakter baru)
    while player.Character ~= nil do
        task.wait()
    end
    
    -- 3. Tunggu sampai karakter baru muncul (menggunakan sinyal yang sudah disiapkan)
    local newChar = newCharSignal:Wait()
    
    -- 4. Teleport karakter baru
    local humanoidRootPart = newChar:WaitForChild("HumanoidRootPart", 10)
    if humanoidRootPart then
        humanoidRootPart.CFrame = SUMMIT_CFRAME
    end
end

-- Fungsi Utama: Memulai loop teleportasi
local function startTeleportLoop(count, delay)
    -- Jika sudah berjalan, hentikan dulu
    if running then
        running = false
        task.wait(delay * 0.5) -- Beri waktu sebentar untuk menghentikan thread lama
    end

    -- Update variabel kontrol (menggunakan nilai yang sudah di-set oleh textbox)
    teleportsLeft = count
    delayTime = delay
    running = true
    
    StellarLibrary:Notify("Auto Summit Dimulai! Count: " .. (count == -1 and "Infinite" or count), 3);

    task.spawn(function()
        while running and (teleportsLeft > 0 or teleportsLeft == -1) do
            teleportToSummit()
            if delayTime > 0 then task.wait(delayTime) end
            if teleportsLeft > 0 then
                teleportsLeft -= 1
            end
        end
        running = false
        StellarLibrary:Notify("Auto Summit Selesai.", 2);
    end)
end

local function stopTeleportLoop()
    running = false
    StellarLibrary:Notify("Auto Summit Dihentikan Manual.", 2);
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
SummitTab:Seperator("Auto Summit Settings by " .. Author);

-- Textbox Loop Count: Perbarui variabel global saat nilai berubah
local TeleportCountTextbox = SummitTab:Textbox("Loop Count (0 = Infinite)", "10", function(value)
    local count = tonumber(value)
    if count and count >= 0 then
        -- Update variabel global teleportsLeft secara instan
        teleportsLeft = (count == 0) and -1 or math.floor(count) 
    end
end)

-- Textbox Delay: Perbarui variabel global saat nilai berubah
local DelayTextbox = SummitTab:Textbox("Delay (seconds)", "2", function(value)
    local delay = tonumber(value)
    if delay and delay >= 0.1 then
        -- Update variabel global delayTime secara instan
        delayTime = delay
    end
end)

SummitTab:Line();

-- TOMBOL RUN UTAMA
SummitTab:Button("START AUTO SUMMIT", function()
    -- Tombol ini sekarang hanya perlu membaca variabel global yang sudah diupdate oleh Textbox
    local count = teleportsLeft 
    local delay = delayTime
    
    -- Cek jika loop sudah berjalan, hentikan dulu
    if running then
        stopTeleportLoop()
        task.wait(delay * 0.5)
    end
    
    startTeleportLoop(count, delay);
end);

-- TOMBOL STOP
SummitTab:Button("STOP AUTO LOOP", function()
    stopTeleportLoop();
end);
