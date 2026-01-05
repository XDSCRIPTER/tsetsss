local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "Private Weed Hub -- Booga Booga Reborn",
    Footer = "by Crack Dealer",
    Icon = 95816097006870,
    ShowCustomCursor = true,
    NotifySide = "Right",
})

local Tabs = {
    Main = Window:AddTab("Main", "user"),
    Combat = Window:AddTab("Combat", "axe"),
    Map = Window:AddTab("Map", "map"),
    Pickup = Window:AddTab("Pickup", "package"),
    Farming = Window:AddTab("Farming", "sprout"),
    Extra = Window:AddTab("Extra", "plus"),
    Settings = Window:AddTab("UI Settings", "settings"),
}

local rs = game:GetService("ReplicatedStorage")
local packets = require(rs.Modules.Packets)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local runs = game:GetService("RunService")
local Players = game:GetService("Players")
local rbxservice = game:GetService("RbxAnalyticsService")
local tspmo = game:GetService("TweenService")

-- Main Tab
local MainLeftGroup = Tabs.Main:AddLeftGroupbox("Movement")

MainLeftGroup:AddToggle("wstoggle", {
    Text = "Walkspeed",
    Default = false,
    Callback = function(Value) end
})

MainLeftGroup:AddSlider("wsslider", {
    Text = "Walkspeed Value",
    Default = 16,
    Min = 1,
    Max = 35,
    Rounding = 1,
    Callback = function(Value) end
})

MainLeftGroup:AddToggle("jptoggle", {
    Text = "JumpPower",
    Default = false,
    Callback = function(Value) end
})

MainLeftGroup:AddSlider("jpslider", {
    Text = "JumpPower Value",
    Default = 50,
    Min = 1,
    Max = 65,
    Rounding = 1,
    Callback = function(Value) end
})

MainLeftGroup:AddToggle("hheighttoggle", {
    Text = "HipHeight",
    Default = false,
    Callback = function(Value) end
})

MainLeftGroup:AddSlider("hheightslider", {
    Text = "HipHeight Value",
    Default = 2,
    Min = 0.1,
    Max = 6.5,
    Rounding = 1,
    Callback = function(Value) end
})

MainLeftGroup:AddToggle("msatoggle", {
    Text = "No Mountain Slip",
    Default = false,
    Callback = function(Value) end
})

local MainRightGroup = Tabs.Main:AddRightGroupbox("Utilities")

MainRightGroup:AddButton({
    Text = "Copy Job ID",
    Func = function() 
        setclipboard(game.JobId)
        Library:Notify("Job ID copied!")
    end,
    DoubleClick = false
})

MainRightGroup:AddButton({
    Text = "Copy HWID",
    Func = function() 
        setclipboard(rbxservice:GetClientId())
        Library:Notify("HWID copied!")
    end,
    DoubleClick = false
})

MainRightGroup:AddButton({
    Text = "Copy SID",
    Func = function() 
        setclipboard(rbxservice:GetSessionId())
        Library:Notify("Session ID copied!")
    end,
    DoubleClick = false
})

-- Combat Tab
local CombatLeftGroup = Tabs.Combat:AddLeftGroupbox("Kill Aura")

CombatLeftGroup:AddToggle("killauratoggle", {
    Text = "Kill Aura",
    Default = false,
    Callback = function(Value) end
})

CombatLeftGroup:AddSlider("killaurarange", {
    Text = "Kill Aura Range",
    Default = 5,
    Min = 1,
    Max = 9,
    Rounding = 1,
    Callback = function(Value) end
})

CombatLeftGroup:AddDropdown("katargetcountdropdown", {
    Text = "Max Targets",
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Callback = function(Value) end
})

CombatLeftGroup:AddSlider("kaswingcooldownslider", {
    Text = "Attack Cooldown (s)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
    Callback = function(Value) end
})

local CombatRightGroup = Tabs.Combat:AddRightGroupbox("Auto Heal")

CombatRightGroup:AddToggle("AutoHealToggle", {
    Text = "Auto Heal",
    Default = false,
    Callback = function(Value) end
})

CombatRightGroup:AddSlider("HealPercent", {
    Text = "Heal to %",
    Default = 50,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value) end
})

CombatRightGroup:AddSlider("HealColdown", {
    Text = "Use Cooldown",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Callback = function(Value) end
})

CombatRightGroup:AddDropdown("HealFruitDropDown", {
    Text = "Fruit to eat",
    Values = {"Bloodfruit", "Bluefruit", "Lemon", "Coconut", "Jelly", "Banana", "Orange", "Oddberry", "Berry", "Strangefruit", "Strawberry", "Sunjfruit", "Pumpkin", "Prickly Pear", "Apple", "Barley", "Cloudberry", "Carrot"},
    Default = "Bloodfruit",
    Callback = function(Value) end
})

-- Map Tab
local MapLeftGroup = Tabs.Map:AddLeftGroupbox("Resource Aura")

MapLeftGroup:AddToggle("resourceauratoggle", {
    Text = "Resource Aura",
    Default = false,
    Callback = function(Value) end
})

MapLeftGroup:AddSlider("resourceaurarange", {
    Text = "Resource Range",
    Default = 20,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Callback = function(Value) end
})

MapLeftGroup:AddDropdown("resourcetargetdropdown", {
    Text = "Max Targets",
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Callback = function(Value) end
})

MapLeftGroup:AddSlider("resourcecooldownslider", {
    Text = "Swing Cooldown (s)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
    Callback = function(Value) end
})

local MapRightGroup = Tabs.Map:AddRightGroupbox("Critter Aura")

MapRightGroup:AddToggle("critterauratoggle", {
    Text = "Critter Aura",
    Default = false,
    Callback = function(Value) end
})

MapRightGroup:AddSlider("critterrangeslider", {
    Text = "Critter Range",
    Default = 20,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Callback = function(Value) end
})

MapRightGroup:AddDropdown("crittertargetdropdown", {
    Text = "Max Targets",
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Callback = function(Value) end
})

MapRightGroup:AddSlider("crittercooldownslider", {
    Text = "Swing Cooldown (s)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
    Callback = function(Value) end
})

-- Pickup Tab
local PickupLeftGroup = Tabs.Pickup:AddLeftGroupbox("Auto Pickup")

PickupLeftGroup:AddToggle("autopickuptoggle", {
    Text = "Auto Pickup",
    Default = false,
    Callback = function(Value) end
})

PickupLeftGroup:AddToggle("chestpickuptoggle", {
    Text = "Auto Pickup From Chests",
    Default = false,
    Callback = function(Value) end
})

PickupLeftGroup:AddSlider("pickuprange", {
    Text = "Pickup Range",
    Default = 20,
    Min = 1,
    Max = 35,
    Rounding = 1,
    Callback = function(Value) end
})

PickupLeftGroup:AddDropdown("itemdropdown", {
    Text = "Items to Pickup",
    Values = {"Berry", "Bloodfruit", "Bluefruit", "Lemon", "Strawberry", "Gold", "Raw Gold", "Crystal Chunk", "Coin", "Coins", "Coin2", "Coin Stack", "Essence", "Emerald", "Raw Emerald", "Pink Diamond", "Raw Pink Diamond", "Void Shard","Jelly", "Magnetite", "Raw Magnetite", "Adurite", "Raw Adurite", "Ice Cube", "Stone", "Iron", "Raw Iron", "Steel", "Hide", "Leaves", "Log", "Wood", "Pie"},
    Default = {"Leaves", "Log"},
    Multi = true,
    Callback = function(Value) end
})

local PickupRightGroup = Tabs.Pickup:AddRightGroupbox("Auto Drop")

PickupRightGroup:AddToggle("droptoggle", {
    Text = "Auto Drop",
    Default = false,
    Callback = function(Value) end
})

PickupRightGroup:AddDropdown("dropdropdown", {
    Text = "Item to Drop",
    Values = {"Bloodfruit", "Jelly", "Bluefruit", "Log", "Leaves", "Wood"},
    Default = "Bloodfruit",
    Callback = function(Value) end
})

PickupRightGroup:AddToggle("droptogglemanual", {
    Text = "Auto Drop Custom",
    Default = false,
    Callback = function(Value) end
})

PickupRightGroup:AddInput("droptextbox", {
    Text = "Custom Item",
    Default = "Bloodfruit",
    Numeric = false,
    Finished = false,
    Callback = function(Value) end
})

-- Farming Tab
local FarmingLeftGroup = Tabs.Farming:AddLeftGroupbox("Auto Farming")

FarmingLeftGroup:AddDropdown("fruitdropdown", {
    Text = "Select Fruit",
    Values = {"Bloodfruit", "Bluefruit", "Lemon", "Coconut", "Jelly", "Banana", "Orange", "Oddberry", "Berry", "Strangefruit", "Strawberry", "Sunjfruit", "Pumpkin", "Prickly Pear", "Apple", "Barley", "Cloudberry", "Carrot"},
    Default = "Bloodfruit",
    Callback = function(Value) end
})

FarmingLeftGroup:AddToggle("planttoggle", {
    Text = "Auto Plant",
    Default = false,
    Callback = function(Value) end
})

FarmingLeftGroup:AddSlider("plantrange", {
    Text = "Plant Range",
    Default = 30,
    Min = 1,
    Max = 30,
    Rounding = 1,
    Callback = function(Value) end
})

FarmingLeftGroup:AddSlider("plantdelay", {
    Text = "Plant Delay (s)",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Callback = function(Value) end
})

FarmingLeftGroup:AddToggle("harvesttoggle", {
    Text = "Auto Harvest",
    Default = false,
    Callback = function(Value) end
})

FarmingLeftGroup:AddSlider("harvestrange", {
    Text = "Harvest Range",
    Default = 30,
    Min = 1,
    Max = 30,
    Rounding = 1,
    Callback = function(Value) end
})

local FarmingRightGroup = Tabs.Farming:AddRightGroupbox("Tween Features")

FarmingRightGroup:AddToggle("tweentoplantbox", {
    Text = "Tween to Plant Box",
    Default = false,
    Callback = function(Value) end
})

FarmingRightGroup:AddToggle("tweentobush", {
    Text = "Tween to Bush + Plant Box",
    Default = false,
    Callback = function(Value) end
})

FarmingRightGroup:AddSlider("tweenrange", {
    Text = "Tween Range",
    Default = 250,
    Min = 1,
    Max = 250,
    Rounding = 1,
    Callback = function(Value) end
})

local FarmingGroup2 = Tabs.Farming:AddLeftGroupbox("Plantbox Placement")

FarmingGroup2:AddButton({
    Text = "Place 16x16 Plantboxes (256)",
    Func = function()
        Library:Notify("Placement started...")
    end,
    DoubleClick = false
})

FarmingGroup2:AddButton({
    Text = "Place 15x15 Plantboxes (225)",
    Func = function()
        Library:Notify("Placement started...")
    end,
    DoubleClick = false
})

FarmingGroup2:AddButton({
    Text = "Place 10x10 Plantboxes (100)",
    Func = function()
        Library:Notify("Placement started...")
    end,
    DoubleClick = false
})

FarmingGroup2:AddButton({
    Text = "Place 5x5 Plantboxes (25)",
    Func = function()
        Library:Notify("Placement started...")
    end,
    DoubleClick = false
})

-- Extra Tab
local ExtraLeftGroup = Tabs.Extra:AddLeftGroupbox("Scripts")

ExtraLeftGroup:AddButton({
    Text = "Load Infinite Yield",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/decryp1/herklesiy/refs/heads/main/hiy"))()
        Library:Notify("Infinite Yield loaded!")
    end,
    DoubleClick = false
})

local ExtraRightGroup = Tabs.Extra:AddRightGroupbox("Item Orbit")

ExtraRightGroup:AddToggle("orbittoggle", {
    Text = "Item Orbit",
    Default = false,
    Callback = function(Value) end
})

ExtraRightGroup:AddSlider("orbitrange", {
    Text = "Grab Range",
    Default = 20,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Callback = function(Value) end
})

ExtraRightGroup:AddSlider("orbitradius", {
    Text = "Orbit Radius",
    Default = 10,
    Min = 0,
    Max = 30,
    Rounding = 1,
    Callback = function(Value) end
})

ExtraRightGroup:AddSlider("orbitspeed", {
    Text = "Orbit Speed",
    Default = 5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value) end
})

ExtraRightGroup:AddSlider("itemheight", {
    Text = "Item Height",
    Default = 3,
    Min = -3,
    Max = 10,
    Rounding = 1,
    Callback = function(Value) end
})

-- ============================================
-- ОРИГИНАЛЬНАЯ ЛОГИКА СКРИПТА (без изменений)
-- ============================================

local itemslist = {"Adurite", "Berry", "Bloodfruit", "Bluefruit", "Coin", "Essence", "Hide", "Ice Cube", "Iron", "Jelly", "Leaves", "Log", "Steel", "Stone", "Wood", "Gold", "Raw Gold", "Crystal Chunk", "Raw Emerald", "Pink Diamond", "Raw Adurite", "Raw Iron", "Coal"}
local placestructure

local wscon, hhcon
local function updws()
    if wscon then wscon:Disconnect() end

    if Toggles.wstoggle.Value or Toggles.jptoggle.Value then
        wscon = runs.RenderStepped:Connect(function()
            if hum then
                hum.WalkSpeed = Toggles.wstoggle.Value and Options.wsslider.Value or 16
                hum.JumpPower = Toggles.jptoggle.Value and Options.jpslider.Value or 50
            end
        end)
    end
end

local function updhh()
    if hhcon then hhcon:Disconnect() end

    if Toggles.hheighttoggle.Value then
        hhcon = runs.RenderStepped:Connect(function()
            if hum then
                hum.HipHeight = Options.hheightslider.Value
            end
        end)
    end
end

local function onplradded(newChar)
    char = newChar
    root = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")

    updws()
    updhh()
end

plr.CharacterAdded:Connect(onplradded)
Toggles.wstoggle:OnChanged(updws)
Toggles.jptoggle:OnChanged(updws)
Toggles.hheighttoggle:OnChanged(updhh)

local slopecon
local function updmsa()
    if slopecon then slopecon:Disconnect() end

    if Toggles.msatoggle.Value then
        slopecon = game:GetService("RunService").RenderStepped:Connect(function()
            if hum then
                hum.MaxSlopeAngle = 90
            end
        end)
    else
        if hum then
            hum.MaxSlopeAngle = 46
        end
    end
end

Toggles.msatoggle:OnChanged(updmsa)

local function getlayout(itemname)
    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory:FindFirstChild("List")
    if not inventory then
        return nil
    end
    for _, child in ipairs(inventory:GetChildren()) do
        if child:IsA("ImageLabel") and child.Name == itemname then
            return child.LayoutOrder
        end
    end
    return nil
end

local function swingtool(tspmogngicl)
    if packets.SwingTool and packets.SwingTool.send then
        packets.SwingTool.send(tspmogngicl)
    end
end

local function Eating(itemname)
    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory:FindFirstChild("List")
    if not inventory then return end

    for _, child in ipairs(inventory:GetChildren()) do
        if child:IsA("ImageLabel") and child.Name == itemname then
           if packets.UseBagItem and packets.UseBagItem.send then
               print(itemname,  'Selected fruit')
               packets.UseBagItem.send(child.LayoutOrder)
               print(child.LayoutOrder)
           end
       end
    end
end

local function pickup(entityid)
    if packets.Pickup and packets.Pickup.send then
        packets.Pickup.send(entityid)
    end
end

local function drop(itemname)
    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory:FindFirstChild("List")
    if not inventory then return end

    for _, child in ipairs(inventory:GetChildren()) do
        if child:IsA("ImageLabel") and child.Name == itemname then
            if packets and packets.DropBagItem and packets.DropBagItem.send then
                packets.DropBagItem.send(child.LayoutOrder)
                print(child.LayoutOrder)
            end
        end
    end
end

local selecteditems = {}
Toggles.itemdropdown:OnChanged(function(Value)
    selecteditems = {} 
    for item, State in pairs(Value) do
        if State then
            table.insert(selecteditems, item)
        end
    end
end)

task.spawn(function()
    while true do
        if not Toggles.killauratoggle.Value then
            task.wait(0.1)
            continue
        end

        local range = Options.killaurarange.Value or 20
        local targetCount = tonumber(Options.katargetcountdropdown.Value) or 1
        local cooldown = Options.kaswingcooldownslider.Value or 0.1
        local targets = {}

        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= plr then
                local playerfolder = workspace.Players:FindFirstChild(player.Name)
                if playerfolder then
                    local rootpart = playerfolder:FindFirstChild("HumanoidRootPart")
                    local entityid = playerfolder:GetAttribute("EntityID")

                    if rootpart and entityid then
                        local dist = (rootpart.Position - root.Position).Magnitude
                        if dist <= range then
                            table.insert(targets, { eid = entityid, dist = dist })
                        end
                    end
                end
            end
        end

        if #targets > 0 then
            table.sort(targets, function(a, b)
                return a.dist < b.dist
            end)

            local selectedTargets = {}
            for i = 1, math.min(targetCount, #targets) do
                table.insert(selectedTargets, targets[i].eid)
            end

            swingtool(selectedTargets)
        end

        task.wait(cooldown)
    end
end)

task.spawn(function()
    while true do
        if not Toggles.resourceauratoggle.Value then
            task.wait(0.1)
            continue
        end

        local range = Options.resourceaurarange.Value or 20
        local targetCount = tonumber(Options.resourcetargetdropdown.Value) or 1
        local cooldown = Options.resourcecooldownslider.Value or 0.1
        local targets = {}
        local allresources = {}

        for _, r in pairs(workspace.Resources:GetChildren()) do
            table.insert(allresources, r)
        end
        for _, r in pairs(workspace:GetChildren()) do
            if r:IsA("Model") and r.Name == "Gold Node" then
                table.insert(allresources, r)
            end
        end

        for _, res in pairs(allresources) do
            if res:IsA("Model") and res:GetAttribute("EntityID") then
                local eid = res:GetAttribute("EntityID")
                local ppart = res.PrimaryPart or res:FindFirstChildWhichIsA("BasePart")
                if ppart then
                    local dist = (ppart.Position - root.Position).Magnitude
                    if dist <= range then
                        table.insert(targets, { eid = eid, dist = dist })
                    end
                end
            end
        end

        if #targets > 0 then
            table.sort(targets, function(a, b)
                return a.dist < b.dist
            end)

            local selectedTargets = {}
            for i = 1, math.min(targetCount, #targets) do
                table.insert(selectedTargets, targets[i].eid)
            end

            swingtool(selectedTargets)
        end

        task.wait(cooldown)
    end
end)

task.spawn(function()
   while true do 
      if not Toggles.AutoHealToggle.Value then
          task.wait(0.1)
          continue
      end
    print(Options.HealPercent.Value)
    if plr.Character:FindFirstChild("Humanoid").Health > 0 and not plr.Character:FindFirstChild("Humanoid").Health >= Options.HealPercent.Value then
       Eating(Options.HealFruitDropDown.Value)
    end

    task.wait(Options.HealColdown.Value)

   end
end)

task.spawn(function()
    while true do
        if not Toggles.critterauratoggle.Value then
            task.wait(0.1)
            continue
        end

        local range = Options.critterrangeslider.Value or 20
        local targetCount = tonumber(Options.crittertargetdropdown.Value) or 1
        local cooldown = Options.crittercooldownslider.Value or 0.1
        local targets = {}

        for _, critter in pairs(workspace.Critters:GetChildren()) do
            if critter:IsA("Model") and critter:GetAttribute("EntityID") then
                local eid = critter:GetAttribute("EntityID")
                local ppart = critter.PrimaryPart or critter:FindFirstChildWhichIsA("BasePart")

                if ppart then
                    local dist = (ppart.Position - root.Position).Magnitude
                    if dist <= range then
                        table.insert(targets, { eid = eid, dist = dist })
                    end
                end
            end
        end

        if #targets > 0 then
            table.sort(targets, function(a, b)
                return a.dist < b.dist
            end)

            local selectedTargets = {}
            for i = 1, math.min(targetCount, #targets) do
                table.insert(selectedTargets, targets[i].eid)
            end

            swingtool(selectedTargets)
        end

        task.wait(cooldown)
    end
end)

task.spawn(function()
    while true do
        local range = Options.pickuprange.Value or 35

        if Toggles.autopickuptoggle.Value then
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if item:IsA("BasePart") or item:IsA("MeshPart") then
                    local selecteditem = item.Name
                    local entityid = item:GetAttribute("EntityID")

                    if entityid and table.find(selecteditems, selecteditem) then
                        local dist = (item.Position - root.Position).Magnitude
                        if dist <= range then
                            pickup(entityid)
                        end
                    end
                end
            end
        end

        if Toggles.chestpickuptoggle.Value then
            for _, chest in ipairs(workspace.Deployables:GetChildren()) do
                if chest:IsA("Model") and chest:FindFirstChild("Contents") then
                    for _, item in ipairs(chest.Contents:GetChildren()) do
                        if item:IsA("BasePart") or item:IsA("MeshPart") then
                            local selecteditem = item.Name
                            local entityid = item:GetAttribute("EntityID")

                            if entityid and table.find(selecteditems, selecteditem) then
                                local dist = (chest.PrimaryPart.Position - root.Position).Magnitude
                                if dist <= range then
                                    pickup(entityid)
                                end
                            end
                        end
                    end
                end
            end
        end

        task.wait(0.01)
    end
end)

local debounce = 0
local cd = 0.2
runs.Heartbeat:Connect(function()
    if Toggles.droptoggle.Value then
        if tick() - debounce >= cd then
            local selectedItem = Options.dropdropdown.Value
            drop(selectedItem)
            debounce = tick()
        end
    end
end)

runs.Heartbeat:Connect(function()
    if Toggles.droptogglemanual.Value then
        if tick() - debounce >= cd then
            local itemname = Options.droptextbox.Value
            drop(itemname)
            debounce = tick()
        end
    end
end)

local plantedboxes = {}
local fruittoitemid = {
    Bloodfruit = 94,
    Bluefruit = 377,
    Lemon = 99,
    Coconut = 1,
    Jelly = 604,
    Banana = 606,
    Orange = 602,
    Oddberry = 32,
    Berry = 35,
    Strangefruit = 302,
    Strawberry = 282,
    Sunfruit = 128,
    Pumpkin = 80,
    ["Prickly Pear"] = 378,
    Apple = 243,
    Barley = 247,
    Cloudberry = 101,
    Carrot = 147
}

local function plant(entityid, itemID)
    if packets.InteractStructure and packets.InteractStructure.send then
        packets.InteractStructure.send({ entityID = entityid, itemID = itemID })
        plantedboxes[entityid] = true
    end
end

local function getpbs(range)
    local plantboxes = {}
    for _, deployable in ipairs(workspace.Deployables:GetChildren()) do
        if deployable:IsA("Model") and deployable.Name == "Plant Box" then
            local entityid = deployable:GetAttribute("EntityID")
            local ppart = deployable.PrimaryPart or deployable:FindFirstChildWhichIsA("BasePart")
            if entityid and ppart then
                local dist = (ppart.Position - root.Position).Magnitude
                if dist <= range then
                    table.insert(plantboxes, { entityid = entityid, deployable = deployable, dist = dist })
                end
            end
        end
    end
    return plantboxes
end

local function getbushes(range, fruitname)
    local bushes = {}
    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model.Name:find(fruitname) then
            local ppart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
            if ppart then
                local dist = (ppart.Position - root.Position).Magnitude
                if dist <= range then
                    local entityid = model:GetAttribute("EntityID")
                    if entityid then
                        table.insert(bushes, { entityid = entityid, model = model, dist = dist })
                    end
                end
            end
        end
    end
    return bushes
end

local tweening = nil
local function tween(target)
    if tweening then tweening:Cancel() end
    local distance = (root.Position - target.Position).Magnitude
    local duration = distance / 21
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = tspmo:Create(root, tweenInfo, { CFrame = target })
    tween:Play()
    
    tweening = tween
end

local function tweenplantbox(range)
    while Toggles.tweentoplantbox.Value do
        local plantboxes = getpbs(range)
        table.sort(plantboxes, function(a, b) return a.dist < b.dist end)

        for _, box in ipairs(plantboxes) do
            if not box.deployable:FindFirstChild("Seed") then
                local target = box.deployable.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                tween(target)
                break
            end
        end

        task.wait(0.1)
    end
end

local function tweenpbs(range, fruitname)
    while Toggles.tweentobush.Value do
        local bushes = getbushes(range, fruitname)
        table.sort(bushes, function(a, b) return a.dist < b.dist end)

        if #bushes > 0 then
            for _, bush in ipairs(bushes) do
                local target = bush.model.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                tween(target)
                break
            end
        else
            local plantboxes = getpbs(range)
            table.sort(plantboxes, function(a, b) return a.dist < b.dist end)

            for _, box in ipairs(plantboxes) do
                if not box.deployable:FindFirstChild("Seed") then
                    local target = box.deployable.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                    tween(target)
                    break
                end
            end
        end

        task.wait(0.1)
    end
end

task.spawn(function()
    while true do
        if not Toggles.planttoggle.Value then
            task.wait(0.1)
            continue
        end

        local range = Options.plantrange.Value or 30
        local delay = Options.plantdelay.Value or 0.1
        local selectedfruit = Options.fruitdropdown.Value
        local itemID = fruittoitemid[selectedfruit] or 94
        local plantboxes = getpbs(range)
        table.sort(plantboxes, function(a, b) return a.dist < b.dist end)

        for _, box in ipairs(plantboxes) do
            if not box.deployable:FindFirstChild("Seed") then
                plant(box.entityid, itemID)
            else
                plantedboxes[box.entityid] = true
            end
        end
        task.wait(delay)
    end
end)

task.spawn(function()
    while true do
        if not Toggles.harvesttoggle.Value then
            task.wait(0.1)
            continue
        end
        local harvestrange = Options.harvestrange.Value or 30
        local selectedfruit = Options.fruitdropdown.Value
        local bushes = getbushes(harvestrange, selectedfruit)
        table.sort(bushes, function(a, b) return a.dist < b.dist end)
        for _, bush in ipairs(bushes) do
            pickup(bush.entityid)
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if not Toggles.tweentoplantbox.Value then
            task.wait(0.1)
            continue
        end
        local range = Options.tweenrange.Value or 250
        tweenplantbox(range)
    end
end)

task.spawn(function()
    while true do
        if not Toggles.tweentobush.Value then
            task.wait(0.1)
            continue
        end
        local range = Options.tweenrange.Value or 20
        local selectedfruit = Options.fruitdropdown.Value
        tweenpbs(range, selectedfruit)
    end
end)

placestructure = function(gridsize)
    if not plr or not plr.Character then return end

    local torso = plr.Character:FindFirstChild("HumanoidRootPart")
    if not torso then return end

    local startpos = torso.Position - Vector3.new(0, 3, 0)
    local spacing = 6.04

    for x = 0, gridsize - 1 do
        for z = 0, gridsize - 1 do
            task.wait(0.3)
            local position = startpos + Vector3.new(x * spacing, 0, z * spacing)

            if packets.PlaceStructure and packets.PlaceStructure.send then
                packets.PlaceStructure.send{
                    ["buildingName"] = "Plant Box",
                    ["yrot"] = 45,
                    ["vec"] = position,
                    ["isMobile"] = false
                }
            end
        end
    end
end

local orbiton, range, orbitradius, orbitspeed, itemheight = false, 20, 10, 5, 3
local attacheditems, itemangles, lastpositions = {}, {}, {}
local itemsfolder = workspace:WaitForChild("Items")

Toggles.orbittoggle:OnChanged(function(value)
    orbiton = value
    if not orbiton then
        for _, bp in pairs(attacheditems) do bp:Destroy() end
        table.clear(attacheditems)
        table.clear(itemangles)
        table.clear(lastpositions)
    else
        task.spawn(function()
            while orbiton do
                for item, bp in pairs(attacheditems) do
                    if item then
                        local currentpos = item.Position
                        local lastpos = lastpositions[item]
                        
                        if lastpos and (currentpos - lastpos).Magnitude < 0.1 then
                            if packets.ForceInteract and packets.ForceInteract.send then
                                packets.ForceInteract.send(item:GetAttribute("EntityID"))
                            end
                        end

                        lastpositions[item] = currentpos
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

Options.orbitrange:OnChanged(function(value) range = value end)
Options.orbitradius:OnChanged(function(value) orbitradius = value end)
Options.orbitspeed:OnChanged(function(value) orbitspeed = value end)
Options.itemheight:OnChanged(function(value) itemheight = value end)

runs.RenderStepped:Connect(function()
    if not orbiton then return end
    local time = tick() * orbitspeed
    for item, bp in pairs(attacheditems) do
        if item then
            local angle = itemangles[item] + time
            bp.Position = root.Position + Vector3.new(math.cos(angle) * orbitradius, itemheight, math.sin(angle) * orbitradius)
        end
    end
end)

task.spawn(function()
    while true do
        if orbiton then
            local children, index = itemsfolder:GetChildren(), 0
            local anglestep = (math.pi * 2) / math.max(#children, 1)

            for _, item in pairs(children) do
                local primary = item:IsA("BasePart") and item or item:IsA("Model") and item.PrimaryPart
                if primary and (primary.Position - root.Position).Magnitude <= range then
                    if not attacheditems[primary] then
                        local bp = Instance.new("BodyPosition")
                        bp.MaxForce, bp.D, bp.P, bp.Parent = Vector3.new(math.huge, math.huge, math.huge), 1500, 25000, primary
                        attacheditems[primary], itemangles[primary], lastpositions[primary] = bp, index * anglestep, primary.Position
                        index += 1
                    end
                end
            end
        end
        task.wait()
    end
end)

-- UI Settings
local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "Notification Side",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDivider()

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { 
    Default = "RightShift", 
    NoUI = true, 
    Text = "Menu keybind" 
})

MenuGroup:AddButton({
    Text = "Unload",
    Func = function()
        Library:Unload()
    end,
    DoubleClick = false
})

Library.ToggleKeybind = Options.MenuKeybind

-- Addons
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/BoogaBoogaReborn")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

Library:Notify({
    Title = "Private Weed Hub",
    Content = "Loaded, Enjoy!",
    Time = 8
})
