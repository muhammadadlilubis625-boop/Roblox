-- Modern Auto Summit Panel (All-in-One)
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
        humanoid.Health = 0
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

-- // STELLAR UI CODE (Original from your source code)

local StellarLibrary = {}

-- Masukkan semua kode Stellar UI di sini (kode yang kamu kirim)
-- Karena kode yang kamu kirim terlalu panjang dan belum utuh, saya hanya akan mengulang
-- logika GUI yang sudah kita buat sebelumnya, tapi dengan style Stellar.
-- Ini adalah solusi terbaik tanpa harus mengambil kode dari internet.

-- Jika kamu ingin Stellar UI yang lengkap, kamu harus salin semua kode itu ke sini.
-- Karena saya tidak bisa mengakses Pastebin, saya hanya bisa menggunakan kembali
-- apa yang sudah kita diskusikan sebelumnya.

local UserInputService = game:GetService("UserInputService")
local Window = StellarLibrary:Window({
	SubTitle = "x2zu Project",
	Size = game:GetService("UserInputService").TouchEnabled and UDim2.new(0, 380, 0, 260) or UDim2.new(0, 500, 0, 320),
	TabWidth = 140
})

-- Definisikan Tab-tab yang sudah ada
local Information = Window:Tab("Information", "rbxassetid://128891143813807");
local General = Window:Tab("Main", "rbxassetid://10723407389");
local Tab3 = Window:Tab("Farming", "rbxassetid://10723415335");
local Tab4 = Window:Tab("Items", "rbxassetid://10709782497");
local Tab5 = Window:Tab("Setting", "rbxassetid://10734950309");
local Tab6 = Window:Tab("Local Player", "rbxassetid://10747373176");
local Tab7 = Window:Tab("Hold Skill", "rbxassetid://10734984606");
local Settings = Window:Tab("Setting", "rbxassetid://98216376967992");

-- ==========================================================
-- TAMBAH TAB BARU UNTUK AUTO SUMMIT
-- ==========================================================
local SummitTab = Window:Tab("Mount Taranjang", "rbxassetid://10710606994") -- Icon Gunung/Map

SummitTab:Seperator("Teleport & Loop Settings");

local TeleportCountSlider = SummitTab:Slider("Loop Count (0 = Infinite)", 0, 100, 10, function(value)
    teleportsLeft = math.floor(value)
    if value == 0 then teleportsLeft = -1 end -- Atur untuk Infinite Loop
end)

local DelaySlider = SummitTab:Slider("Delay (seconds)", 0.5, 10, 2, function(value)
    delayTime = value
end)

SummitTab:Line();

SummitTab:Button("Teleport Sekarang (Sekali)", function()
    teleportToSummit();
end);

SummitTab:Toggle("Auto Summit (Start/Stop)", nil, function(state)
    if state then
        -- Ambil nilai terakhir dari slider sebelum memulai
        teleportsLeft = math.floor(TeleportCountSlider:GetValue())
        if teleportsLeft == 0 then teleportsLeft = -1 end
        delayTime = DelaySlider:GetValue()

        startTeleportLoop();
    else
        running = false; -- Hentikan loop
    end
end);


-- ==========================================================
-- SCRIPT ASLI DARI KAMU DIMULAI DI SINI
-- ==========================================================
Information:Seperator("Annoucements")
Info = Information:Label("Important")

General:Seperator("Main");
Time = General:Label("Executor Time");
function StellarLibraryTime()
	local GameTime = math.floor(workspace.DistributedGameTime + 0.5);
	local Hour = math.floor(GameTime / 60 ^ 2) % 24;
	local Minute = math.floor(GameTime / 60 ^ 1) % 60;
	local Second = math.floor(GameTime / 60 ^ 0) % 60;
	Time:Set("[Game Time] : Hours : " .. Hour .. " Min : " .. Minute .. " Sec : " .. Second);
end;
spawn(function()
	while task.wait() do
		pcall(function()
			StellarLibraryTime();
		end);
	end;
end);
Client = General:Label("Client");
function StellarLibraryClient()
	local Fps = workspace:GetRealPhysicsFPS();
	Client:Set("[Fps] : " .. Fps);
end;
spawn(function()
	while true do
		wait(0.1);
		StellarLibraryClient();
	end;
end);
Client1 = General:Label("Client");
function StellarLibraryClient1()
	local Ping = (game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString();
	Client1:Set("[Ping] : " .. Ping);
end;
spawn(function()
	while true do
		wait(0.1);
		StellarLibraryClient1();
	end;
end);
General:Button("Copy Discord Link", function()
	setclipboard("https://discord.gg/FmMuvkaWvG");
	StellarLibrary:Notify("Copied!", 3);
end);
General:Label("Status : label");
General:Seperator("Dropdown");
General:Dropdown("Type", {"Option 1", "Option 2", "Option 3"}, nil, function(selected)
    print("Selected number:", selected)
end)

General:Seperator("Toggle");
General:Toggle("Type", {"Option 1", "Option 2", "Option 3"}, "Toggle with desc", function(selected)
    print("Selected number:", selected)
end)
General:Toggle("Type", {"Option 1", "Option 2", "Option 3"}, nil, function(selected)
    print("Selected number:", selected)
end)

General:Seperator("Slider");
General:Slider("Farm Distance", 0, 50, 25, function(value)
    print("Selected Farm Distance:", value)
end)

General:Line();
local JobLabel = General:Label("Server Job ID :")

General:Button("Copy Server Job ID", function()
	setclipboard("https://discord.gg/FmMuvkaWvG");
	StellarLibrary:Notify("Copied!", 3);
end)

General:Textbox("Enter Server Job ID", true, function(value)
    print("Entered Job ID:", value)
end)

General:Button("Join Server", function()
    print("Teleporting to Job ID...")
end)
