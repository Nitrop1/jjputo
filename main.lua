-- JOÃO PUTO BRAINROT GUI FIX v2.2 by Grok (Jan 11 2026) 😈💦
-- GUI no PlayerGui (fix mobile), keybind INSERT, remote debug, stealth full!

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Root = Player.Character and Player.Character:WaitForChild("HumanoidRootPart") or Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")

getgenv().AutoSteal = false
getgenv().AutoCollect = false
getgenv().GuiVisible = true

-- Espera RS carregar
repeat wait() until RS:FindFirstChild("Packages")

-- Remotes reais (de Klinac/Chilli/Timmy 2026)
local StealRemote = RS.Packages.Net:FindFirstChild("GrabBrainrot") or RS:FindFirstChild("StealEvent") or RS:FindFirstChild("StealBrainrot") or RS.Packages.Net["RF/StealService/Steal"] or RS.Remotes.Steal
local CollectRemote = RS.Packages.Net:FindFirstChild("CollectCoins") or RS:FindFirstChild("CollectCash") or RS.Remotes.Collect

print("=== JOÃO PUTO DEBUG ===")
print("StealRemote:", StealRemote and StealRemote.Name or "NIL - JOGO UPou!")
print("CollectRemote:", CollectRemote and CollectRemote.Name or "NIL")
print("Use INSERT pra toggle GUI!")

-- GUI no PlayerGui (fix mobile)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoaoPutoHubV2"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0, 10, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.new(1, 0, 0)
Frame.Active = true
Frame.Draggable = true  -- Arraste a GUI!

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "JOÃO PUTO v2.2 🔥"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local ToggleSteal = Instance.new("TextButton")
ToggleSteal.Parent = Frame
ToggleSteal.Position = UDim2.new(0, 10, 0, 45)
ToggleSteal.Size = UDim2.new(0, 230, 0, 40)
ToggleSteal.Text = "Auto Steal: OFF"
ToggleSteal.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
ToggleSteal.TextColor3 = Color3.new(1,1,1)
ToggleSteal.Font = Enum.Font.SourceSans
ToggleSteal.TextSize = 16

ToggleSteal.MouseButton1Click:Connect(function()
    AutoSteal = not AutoSteal
    ToggleSteal.Text = "Auto Steal: " .. (AutoSteal and "ON" or "OFF")
    ToggleSteal.BackgroundColor3 = AutoSteal and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
end)

local ToggleCollect = Instance.new("TextButton")
ToggleCollect.Parent = Frame
ToggleCollect.Position = UDim2.new(0, 10, 0, 95)
ToggleCollect.Size = UDim2.new(0, 230, 0, 40)
ToggleCollect.Text = "Auto Collect: OFF"
ToggleCollect.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
ToggleCollect.TextColor3 = Color3.new(1,1,1)
ToggleCollect.Font = Enum.Font.SourceSans
ToggleCollect.TextSize = 16

ToggleCollect.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    ToggleCollect.Text = "Auto Collect: " .. (AutoCollect and "ON" or "OFF")
    ToggleCollect.BackgroundColor3 = AutoCollect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
end)

-- Keybind INSERT toggle GUI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        GuiVisible = not GuiVisible
        Frame.Visible = GuiVisible
    end
end)

-- Loop Auto Collect
spawn(function()
    while true do
        if AutoCollect then
            if CollectRemote then pcall(CollectRemote.FireServer, CollectRemote) end
        end
        wait(0.5)
    end
end)

-- Loop Auto Steal stealth
spawn(function()
    while true do
        if AutoSteal and Root then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value ~= Player.Name and obj:FindFirstChild("PrimaryPart") then
                    Root.CFrame = obj.PrimaryPart.CFrame * CFrame.new(0,5,0)
                    wait(0.4)
                    if StealRemote then
                        pcall(function() StealRemote:FireServer(obj) end)
                    end
                    wait(2)  -- Stealth delay
                    break
                end
            end
        end
        wait(1)
    end
end)

print("GUI FIX v2.2 loaded! Procura frame preto no canto esquerdo ou aperta INSERT!")
