--[[ 
    ================================================
    MOUNT TARANJANG AUTO SUMMIT - STELLAR SINGLE TAB
    Hanya menggunakan satu tombol untuk langsung memulai Auto Loop.
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
    
    -- 2. Tunggu sampai karakter lama hilang
    while player.Character ~= nil do
        task.wait()
    end
    
    -- 3. Tunggu sampai karakter baru muncul
    local newChar = player.Character
    while newChar == nil do
        player.CharacterAdded:Wait()
        newChar = player.Character
    end
    
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

    -- Update variabel kontrol
    teleportsLeft = count
    delayTime = delay
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
        StellarLibrary:Notify("Auto Summit Selesai.", 2);
    end)
end

-- Fungsi untuk menghentikan loop (opsional, tapi bagus untuk kontrol)
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

-- HANYA MEMBUAT TAB MOUNT TARANJANG
local SummitTab = Window:Tab("Mount Taranjang", "rbxassetid://10723407389")


-- 4. MENAMBAHKAN KONTROL AUTO SUMMIT KE TAB
SummitTab:Seperator("Auto Summit Settings by " .. Author);

-- Inisialisasi Slider (diperlukan untuk mendapatkan nilai saat tombol ditekan)
local TeleportCountSlider = SummitTab:Slider("Loop Count (0 = Infinite)", 0, 100, 10, function(value)
    -- Tidak perlu update teleportsLeft di sini, nanti diupdate saat tombol ditekan
end)

local DelaySlider = SummitTab:Slider("Delay (seconds)", 0.5, 10, 2, function(value)
    -- Tidak perlu update delayTime di sini
end)

SummitTab:Line();

-- TOMBOL RUN UTAMA (Menggantikan Teleport Sekali dan Toggle)
SummitTab:Button("START AUTO SUMMIT", function()
    -- Ambil nilai langsung dari slider saat tombol ditekan
    local count = math.floor(TeleportCountSlider:GetValue())
    local delay = DelaySlider:GetValue()
    
    -- Atur infinite loop jika count = 0
    local finalCount = (count == 0) and -1 or count
    
    startTeleportLoop(finalCount, delay);
end);

-- TOMBOL STOP (Opsional, tapi penting)
SummitTab:Button("STOP AUTO LOOP", function()
    stopTeleportLoop();
end);
