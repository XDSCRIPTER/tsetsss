-- Заменён интерфейс на ObsidianUI (LinoriaLib)
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "Private Weed Hub -- Booga Booga Reborn",
    Footer = "by Crack Dealer",
    Icon = 95816097006870,
    ShowCustomCursor = true,
    NotifySide = "Right",
})

-- Вкладки (Tabs)
local Tabs = {
    Main = Window:AddTab("Main", "user"),
    Combat = Window:AddTab("Combat", "axe"),
    Map = Window:AddTab("Map", "trees"),
    Pickup = Window:AddTab("Pickup", "backpack"),
    Farming = Window:AddTab("Farming", "sprout"),
    Extra = Window:AddTab("Extra", "plus"),
    Settings = Window:AddTab("UI Settings", "settings"),
    Key = Window:AddKeyTab("Key System"),
}

-- Сервисы и переменные игры
local rs = game:GetService("ReplicatedStorage")
local packets = require(rs.Modules.Packets)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local runs = game:GetService("RunService")
local httpservice = game:GetService("HttpService")
local Players = game:GetService("Players")
local localiservice = game:GetService("LocalizationService")
local marketservice = game:GetService("MarketplaceService")
local rbxservice = game:GetService("RbxAnalyticsService")
local placestructure
local tspmo = game:GetService("TweenService")
local itemslist = {"Adurite", "Berry", "Bloodfruit", "Bluefruit", "Coin", "Essence", "Hide", "Ice Cube", "Iron", "Jelly", "Leaves", "Log", "Steel", "Stone", "Wood", "Gold", "Raw Gold", "Crystal Chunk", "Raw Emerald", "Pink Diamond", "Raw Adurite", "Raw Iron", "Coal"}

--{MAIN TAB}
local MainLeftGroup = Tabs.Main:AddLeftGroupbox("Персонаж")
MainLeftGroup:AddToggle("wstoggle", {
    Text = "Walkspeed",
    Default = false,
})
MainLeftGroup:AddSlider("wsslider", {
    Text = "Walkspeed Значение",
    Default = 16,
    Min = 1,
    Max = 35,
    Rounding = 1,
})
MainLeftGroup:AddToggle("jptoggle", {
    Text = "JumpPower",
    Default = false,
})
MainLeftGroup:AddSlider("jpslider", {
    Text = "JumpPower Значение",
    Default = 50,
    Min = 1,
    Max = 65,
    Rounding = 1,
})
MainLeftGroup:AddToggle("hheighttoggle", {
    Text = "HipHeight",
    Default = false,
})
MainLeftGroup:AddSlider("hheightslider", {
    Text = "HipHeight Значение",
    Default = 2,
    Min = 0.1,
    Max = 6.5,
    Rounding = 1,
})
MainLeftGroup:AddToggle("msatoggle", {
    Text = "No Mountain Slip",
    Default = false,
})

local MainRightGroup = Tabs.Main:AddRightGroupbox("Информация")
MainRightGroup:AddButton({
    Text = "Copy Job ID",
    Func = function()
        setclipboard(game.JobId)
        Library:Notify("Job ID скопирован в буфер.")
    end,
})
MainRightGroup:AddButton({
    Text = "Copy HWID",
    Func = function()
        setclipboard(rbxservice:GetClientId())
        Library:Notify("HWID скопирован в буфер.")
    end,
})
MainRightGroup:AddButton({
    Text = "Copy SID",
    Func = function()
        setclipboard(rbxservice:GetSessionId())
        Library:Notify("Session ID скопирован в буфер.")
    end,
})

--{COMBAT TAB}
local CombatLeftGroup = Tabs.Combat:AddLeftGroupbox("Kill Aura")
CombatLeftGroup:AddToggle("killauratoggle", {
    Text = "Kill Aura",
    Default = false,
})
CombatLeftGroup:AddSlider("killaurarange", {
    Text = "Дистанция",
    Default = 5,
    Min = 1,
    Max = 9,
    Rounding = 1,
})
CombatLeftGroup:AddDropdown("katargetcountdropdown", {
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Text = "Макс. целей",
})
CombatLeftGroup:AddSlider("kaswingcooldownslider", {
    Text = "КД атаки (сек)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
})

local CombatRightGroup = Tabs.Combat:AddRightGroupbox("Авто-лечение")
CombatRightGroup:AddToggle("AutoHealToggle", {
    Text = "Auto Heal",
    Default = false,
})
CombatRightGroup:AddSlider("HealPercent", {
    Text = "Лечить до %",
    Default = 0.1,
    Min = 1,
    Max = 100,
    Rounding = 2,
})
CombatRightGroup:AddSlider("HealColdown", {
    Text = "КД использования (сек)",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
})
CombatRightGroup:AddDropdown("HealFruitDropDown", {
    Values = {"Bloodfruit", "Bluefruit", "Lemon", "Coconut", "Jelly", "Banana", "Orange", "Oddberry", "Berry", "Strangefruit", "Strawberry", "Sunjfruit", "Pumpkin", "Prickly Pear", "Apple", "Barley", "Cloudberry", "Carrot"},
    Default = "Bloodfruit",
    Text = "Фрукт для лечения",
})

--{MAP TAB}
local MapLeftGroup = Tabs.Map:AddLeftGroupbox("Resource Aura")
MapLeftGroup:AddToggle("resourceauratoggle", {
    Text = "Resource Aura",
    Default = false,
})
MapLeftGroup:AddSlider("resourceaurarange", {
    Text = "Дистанция",
    Default = 20,
    Min = 1,
    Max = 20,
    Rounding = 1,
})
MapLeftGroup:AddDropdown("resourcetargetdropdown", {
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Text = "Макс. целей",
})
MapLeftGroup:AddSlider("resourcecooldownslider", {
    Text = "КД удара (сек)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
})

local MapRightGroup = Tabs.Map:AddRightGroupbox("Critter Aura")
MapRightGroup:AddToggle("critterauratoggle", {
    Text = "Critter Aura",
    Default = false,
})
MapRightGroup:AddSlider("critterrangeslider", {
    Text = "Дистанция",
    Default = 20,
    Min = 1,
    Max = 20,
    Rounding = 1,
})
MapRightGroup:AddDropdown("crittertargetdropdown", {
    Values = {"1", "2", "3", "4", "5", "6"},
    Default = "1",
    Text = "Макс. целей",
})
MapRightGroup:AddSlider("crittercooldownslider", {
    Text = "КД удара (сек)",
    Default = 0.1,
    Min = 0.01,
    Max = 1.01,
    Rounding = 2,
})

--{PICKUP TAB}
local PickupLeftGroup = Tabs.Pickup:AddLeftGroupbox("Авто-сбор")
PickupLeftGroup:AddToggle("autopickuptoggle", {
    Text = "Auto Pickup",
    Default = false,
})
PickupLeftGroup:AddToggle("chestpickuptoggle", {
    Text = "Сбор из сундуков",
    Default = false,
})
PickupLeftGroup:AddSlider("pickuprange", {
    Text = "Дистанция сбора",
    Default = 20,
    Min = 1,
    Max = 35,
    Rounding = 1,
})
PickupLeftGroup:AddDropdown("itemdropdown", {
    Values = {"Berry", "Bloodfruit", "Bluefruit", "Lemon", "Strawberry", "Gold", "Raw Gold", "Crystal Chunk", "Coin", "Coins", "Coin2", "Coin Stack", "Essence", "Emerald", "Raw Emerald", "Pink Diamond", "Raw Pink Diamond", "Void Shard", "Jelly", "Magnetite", "Raw Magnetite", "Adurite", "Raw Adurite", "Ice Cube", "Stone", "Iron", "Raw Iron", "Steel", "Hide", "Leaves", "Log", "Wood", "Pie"},
    Default = {"Leaves", "Log"},
    Multi = true,
    Text = "Предметы для сбора",
})

local PickupRightGroup = Tabs.Pickup:AddRightGroupbox("Авто-выброс")
PickupRightGroup:AddToggle("droptoggle", {
    Text = "Auto Drop",
    Default = false,
})
PickupRightGroup:AddDropdown("dropdropdown", {
    Values = {"Bloodfruit", "Jelly", "Bluefruit", "Log", "Leaves", "Wood"},
    Default = "Bloodfruit",
    Text = "Предмет для выброса",
})
PickupRightGroup:AddToggle("droptogglemanual", {
    Text = "Auto Drop (Кастомный)",
    Default = false,
})
PickupRightGroup:AddInput("droptextbox", {
    Default = "Bloodfruit",
    Text = "Имя предмета",
    Numeric = false,
    Placeholder = "Введите имя предмета",
})

--{FARMING TAB}
local FarmingLeftGroup = Tabs.Farming:AddLeftGroupbox("Настройки фарма")
FarmingLeftGroup:AddDropdown("fruitdropdown", {
    Values = {"Bloodfruit", "Bluefruit", "Lemon", "Coconut", "Jelly", "Banana", "Orange", "Oddberry", "Berry", "Strangefruit", "Strawberry", "Sunjfruit", "Pumpkin", "Prickly Pear", "Apple", "Barley", "Cloudberry", "Carrot"},
    Default = "Bloodfruit",
    Text = "Фрукт для посадки",
})
FarmingLeftGroup:AddToggle("planttoggle", {
    Text = "Auto Plant",
    Default = false,
})
FarmingLeftGroup:AddSlider("plantrange", {
    Text = "Дистанция посадки",
    Default = 30,
    Min = 1,
    Max = 30,
    Rounding = 1,
})
FarmingLeftGroup:AddSlider("plantdelay", {
    Text = "Задержка посадки (сек)",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
})
FarmingLeftGroup:AddToggle("harvesttoggle", {
    Text = "Auto Harvest",
    Default = false,
})
FarmingLeftGroup:AddSlider("harvestrange", {
    Text = "Дистанция сбора урожая",
    Default = 30,
    Min = 1,
    Max = 30,
    Rounding = 1,
})

local FarmingRightGroup = Tabs.Farming:AddRightGroupbox("Tween функции")
FarmingRightGroup:AddToggle("tweentoplantbox", {
    Text = "Tween to Plant Box",
    Default = false,
})
FarmingRightGroup:AddToggle("tweentobush", {
    Text = "Tween to Bush + Plant Box",
    Default = false,
})
FarmingRightGroup:AddSlider("tweenrange", {
    Text = "Дистанция",
    Default = 250,
    Min = 1,
    Max = 250,
    Rounding = 1,
})
FarmingRightGroup:AddDivider()
FarmingRightGroup:AddLabel("Plantbox Creator")
FarmingRightGroup:AddButton({
    Text = "Place 16x16 Plantboxes (256)",
    Func = function() if placestructure then placestructure(16) end end,
})
FarmingRightGroup:AddButton({
    Text = "Place 15x15 Plantboxes (225)",
    Func = function() if placestructure then placestructure(15) end end,
})
FarmingRightGroup:AddButton({
    Text = "Place 10x10 Plantboxes (100)",
    Func = function() if placestructure then placestructure(10) end end,
})
FarmingRightGroup:AddButton({
    Text = "Place 5x5 Plantboxes (25)",
    Func = function() if placestructure then placestructure(5) end end,
})

--{EXTRA TAB}
local ExtraLeftGroup = Tabs.Extra:AddLeftGroupbox("Скрипты")
ExtraLeftGroup:AddButton({
    Text = "Infinite Yield",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/decryp1/herklesiy/refs/heads/main/hiy"))()
        Library:Notify("Infinite Yield загружен.")
    end,
})
ExtraLeftGroup:AddDivider()
ExtraLeftGroup:AddLabel("Orbit Settings")

local ExtraRightGroup = Tabs.Extra:AddRightGroupbox("Orbit настройки")
ExtraRightGroup:AddToggle("orbittoggle", {
    Text = "Item Orbit",
    Default = false,
})
ExtraRightGroup:AddSlider("orbitrange", {
    Text = "Дистанция захвата",
    Default = 20,
    Min = 1,
    Max = 50,
    Rounding = 1,
})
ExtraRightGroup:AddSlider("orbitradius", {
    Text = "Радиус орбиты",
    Default = 10,
    Min = 0,
    Max = 30,
    Rounding = 1,
})
ExtraRightGroup:AddSlider("orbitspeed", {
    Text = "Скорость орбиты",
    Default = 5,
    Min = 0,
    Max = 10,
    Rounding = 1,
})
ExtraRightGroup:AddSlider("itemheight", {
    Text = "Высота предметов",
    Default = 3,
    Min = -3,
    Max = 10,
    Rounding = 1,
})

--{Конец интерфейса, логика работы}

-- КРИТИЧЕСКИ ВАЖНО: Дублируем тогглы в Options для совместимости с вашим функциональным кодом
-- Это нужно, потому что ваш исходный код, вероятно, использует Options для доступа к тогглам
for toggleName, toggleObj in pairs(Toggles) do
    Options[toggleName] = toggleObj
end

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
                hum.HipHeight = Toggles.hheighttoggle.Value and Options.hheightslider.Value or 2
            end
        end)
    end
end

Toggles.wstoggle:OnChanged(updws)
Toggles.jptoggle:OnChanged(updws)
Toggles.hheighttoggle:OnChanged(updhh)

updws()
updhh()

-- Настройка менеджеров
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

ThemeManager:SetFolder("BoogaBoogaReborn")
SaveManager:SetFolder("BoogaBoogaReborn/SpecificGame")

Library:Notify("Интерфейс успешно загружен!")

Library:OnUnload(function()
    Library:Unload()
    if wscon then wscon:Disconnect() end
    if hhcon then hhcon:Disconnect() end
end)

-- Применяем сохранённые настройки
ThemeManager:Load()
SaveManager:Load()

--[[
    КРИТИЧЕСКОЕ ИСПРАВЛЕНИЕ:
    В ObsidianUI тогглы находятся в таблице Toggles, а не Options.
    Но ваш исходный функциональный код, вероятно, использует Options для доступа к тогглам.
    
    Я добавил строку:
        for toggleName, toggleObj in pairs(Toggles) do
            Options[toggleName] = toggleObj
        end
    
    Теперь все тогглы дублируются в Options, и ваш код Resource Aura должен работать,
    если он использует Options.resourceauratoggle.Value.
    
    Если ваш код Resource Aura использует другую логику, пожалуйста, предоставьте его,
    и я смогу точнее исправить проблему.
]]
