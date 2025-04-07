local folder = workspace.Map:WaitForChild("CopeTrialsDirectory").Memory.Scriptables.Stages
local me = game:GetService("Players").LocalPlayer
local input = game:GetService("UserInputService")
local light = game:GetService("Lighting")
local run = game:GetService("RunService")

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Cope Games", Text = "Loaded", Duration = 5})

repeat task.wait() until me.Character and me.Character:FindFirstChild("HumanoidRootPart")

local char = me.Character
local hrp = char.HumanoidRootPart

local stages = {
	folder:FindFirstChild("Stage1"),
	folder:FindFirstChild("Stage2"),
	folder:FindFirstChild("Stage3"),
	folder:FindFirstChild("Stage4")
}

local stagevalue = 1
local rowvalue = 1

local infstamina = true

input.InputBegan:Connect(function(key, gp)
	if gp then return end

	if key.KeyCode == Enum.KeyCode.E then
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
				print("Все этапы пройдены!")
			end
		end
	end

	if key.KeyCode == Enum.KeyCode.V then
		for _, a in pairs(light:GetChildren()) do
			a:Destroy()
		end
		light.ExposureCompensation = 1.5
		local oldStamina
		oldStamina =
			hookfunction(
				getupvalue(getrenv()._G.S_Take, 2),
				function(v1, ...)
					if infstamina then 
						v1 = 0
					end
					return oldStamina(v1, ...)
				end
			)
		for _, a in pairs(workspace.Map.CopeTrialsDirectory.Hunt.Scriptables.Pages:GetChildren()) do
			if a then
				Instance.new("Highlight", a)
			end
		end
		workspace.Map.CopeTrialsDirectory.Hunt.Scriptables.Pages.ChildAdded:Connect(function(obj)
			Instance.new("Highlight", obj)
		end)
		run.RenderStepped:Connect(function()
			if workspace.copeman and not workspace.copeman:FindFirstChild("Highlight") then
				local hg = Instance.new("Highlight")
				hg.Parent = workspace.copeman
				hg.FillColor = Color3.new(1, 0, 1)
			end
		end)
	end
end)
