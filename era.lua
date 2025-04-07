local me = game:GetService("Players").LocalPlayer
local input = game:GetService("UserInputService")
local light = game:GetService("Lighting")
local folder = workspace.Map:WaitForChild("CopeTrialsDirectory").Memory.Scriptables.Stages

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Cope games by Ghost",
	Icon = "rbxassetid://83501732181441",
	Text = "Join to discord \n https://discord.gg/getghost",
	Duration = 10
})

function Decrypt()
	local result = ""
	for i = 1, 20 do
		result = result..string.char(math.random(i))
	end
	return result
end

local stages = {
	folder:FindFirstChild("Stage1"),
	folder:FindFirstChild("Stage2"),
	folder:FindFirstChild("Stage3"),
	folder:FindFirstChild("Stage4")
}

local stagevalue = 1
local rowvalue = 1

local stamina = true

function TPplatform()
	local char = me.Character or me.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	
	local currentStage = stages[stagevalue]
	if not currentStage then return end

	local currentRow = currentStage.Rows:FindFirstChild("Row"..rowvalue)
	if not currentRow then return end

	for _, model in ipairs(currentRow:GetChildren()) do
		if model:IsA("Model") then
			local platform = model:FindFirstChild("PlatformMain")
			if platform and platform:IsA("Part") then
				if #platform:GetChildren() >= 2 then
					hrp.CFrame = platform.CFrame + Vector3.new(0, 3, 0)
					rowvalue += 1
					break
				end
			end
		end
	end

	local stageLimits = {3, 5, 7, 7}
	if rowvalue > stageLimits[stagevalue] then
		if stagevalue < 4 then
			stagevalue += 1
			rowvalue = 1
		else
			print("Done!")
		end
	end
end

function Fullbright()
	for _, a in pairs(light:GetChildren()) do
		if a then
			a:Destroy()
		end
	end
	light.ExposureCompensation = 1.5
end

function PagesEsp()
	for _, a in pairs(workspace.Map.CopeTrialsDirectory:WaitForChild("Hunt").Scriptables.Pages:GetChildren()) do
		if a then
			Instance.new("Highlight", a)
		end
	end
	workspace.Map.CopeTrialsDirectory:WaitForChild("Hunt").Scriptables.Pages.ChildAdded:Connect(function(obj)
		Instance.new("Highlight", obj)
	end)
end

function Infstamina()
	local oldStamina
	oldStamina =
		hookfunction(
			getupvalue(getrenv()._G.S_Take, 2),
			function(v1, ...)
				if stamina then 
					v1 = 0
				end
				return oldStamina(v1, ...)
			end
		)
end

function SlanderEsp()
	if workspace:FindFirstChildOfClass("Model") then
		for _, a in pairs(workspace:GetChildren()) do
			if a and a:IsA("Model") then
				local hl = Instance.new("Highlight")
				hl.Parent = a
				hl.FillTransparency = 1
			end
		end
	else
		repeat wait() until workspace:FindFirstChildOfClass("Model")
		for _, a in pairs(workspace:GetChildren()) do
			if a and a:IsA("Model") then
				local hl = Instance.new("Highlight")
				hl.Parent = a
				hl.FillTransparency = 1
			end
		end
	end
end

local GUI = Instance.new("ScreenGui")
local s, n = pcall(function() GUI.Parent = game.CoreGui end) if not s then GUI.Parent = me.PlayerGui end
GUI.Name = Decrypt()
GUI.ResetOnSpawn = false

local Menu = Instance.new("Frame")
Menu.Parent = GUI
Menu.Name = "Menu"
Menu.BackgroundTransparency = 1
Menu.Position = UDim2.new(0, 0, 0.313, 0)
Menu.Size = UDim2.new(0.1, 0, 0.192, 0)

local UILMenu = Instance.new("UIListLayout")
UILMenu.Parent = Menu
UILMenu.Padding = UDim.new(0, 8)
UILMenu.FillDirection = Enum.FillDirection.Vertical
UILMenu.SortOrder = Enum.SortOrder.LayoutOrder
UILMenu.HorizontalAlignment = Enum.HorizontalAlignment.Left
UILMenu.HorizontalFlex = Enum.UIFlexAlignment.None
UILMenu.VerticalAlignment = Enum.VerticalAlignment.Top
UILMenu.VerticalFlex = Enum.UIFlexAlignment.None

local UIPMenu = Instance.new("UIPadding")
UIPMenu.Parent = Menu
UIPMenu.PaddingBottom = UDim.new(0, 0)
UIPMenu.PaddingLeft = UDim.new(0, 5)
UIPMenu.PaddingRight = UDim.new(0, 0)
UIPMenu.PaddingTop = UDim.new(0, 7)

function MakeButton(Text, key)
	local button = Instance.new("TextLabel")
	button.Parent = Menu
	button.Name = "Button"
	button.BackgroundColor3 = Color3.new(1, 1, 1)
	button.Size = UDim2.new(0, 182, 0, 26)
	button.TextScaled = true
	button.TextColor3 = Color3.new(0, 0, 0)
	button.Text = Text
	
	local UICbutton = Instance.new("UICorner")
	UICbutton.Parent = button
	UICbutton.CornerRadius = UDim.new(0, 5)
	
	return button
end

local MakeTPplatformbutton = MakeButton("Platform teleport [E]")
local MakeFullbrightbutton = MakeButton("Fullbright [T]")
local MakePageEspbutton = MakeButton("Pages esp [V]")
local MakeSlanderEspbutton = MakeButton("Slander esp [Q]")
local MakeInfstaminabutton
if typeof(hookfunction) == "function" then
	MakeInfstaminabutton = MakeButton("Inf stamina [Z]")
else
	stamina = false
	return false
end

Menu.ChildRemoved:Connect(function()
	if #Menu:GetChildren() == 0 then
		GUI:Destroy()
	end
end)

input.InputBegan:Connect(function(key, pg)
	if pg then return end
	
	if key.KeyCode == Enum.KeyCode.E then
		TPplatform()
		if stagevalue == 4 and rowvalue == 7 then
			MakeTPplatformbutton:Destroy()
		end
	end
	if key.KeyCode == Enum.KeyCode.T then
		Fullbright()
		MakeFullbrightbutton:Destroy()
	end
	if key.KeyCode == Enum.KeyCode.V then
		PagesEsp()
		MakePageEspbutton:Destroy()
	end
	if key.KeyCode == Enum.KeyCode.Z and stamina == true then
		Infstamina()
		MakeInfstaminabutton:Destroy()
	end
	if key.KeyCode == Enum.KeyCode.Q then
		SlanderEsp()
		MakeSlanderEspbutton:Destroy()
	end
end)
