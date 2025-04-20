local plrs = game:GetService("Players")
local me = plrs.LocalPlayer
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local camera = workspace.CurrentCamera
local tween = game:GetService("TweenService")
local light = game:GetService("Lighting")
local rp = game:GetService("ReplicatedStorage")
local content = game:GetService("ContentProvider")

local bind = Enum.KeyCode.Insert
local ignorebind = {Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.F12, Enum.KeyCode.F9, Enum.KeyCode.Escape, Enum.KeyCode.Tab, Enum.KeyCode.Backspace, Enum.KeyCode.Space, Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.MouseWheel}

local functions = {
	Fullbright = false,
	AutoOpenDoors = false,
	NoBarriers = false,
	NoGrinder = false,
	FastPickup = false,
	AutoPickupScraps = false,
	AutoPickupTools = false,
	AutopickupCrates = false,
	AutoPickupMoney = false,
	Fly = false,
	Infstamina = false,
	Nofalldamage = false,
	Noclip = false,
	FakeDown = true,
	Stopneckmove = false,
	Unbreaklimbs = false,
	SilentAim = false,
	AimBot = false,
	Instantreload = false,
	Meleeaura = false,
}

local SectionSettings = {
	SilentAim = {
		Draw = false,
		DrawColor = Color3.new(1, 1, 1)
	}
}

local keybinds = {
	Fly = nil,
	Noclip = nil,
	FakeDown = nil,
	Meleeaura = nil,
}

local index = {}
local index2 = {}
local sliderindex = {}

local cockie = {
	SilentAimCircle = nil,
}

local RUNS = {
	cameraFOV = nil,
	JumpHeight = nil,
	AutoOpenDoors = nil,
	AutopickupScraps = nil,
	AutopickupTools = nil,
	AutopickupCrates = nil,
	AutopickupMoney = nil,
	Infstamina = nil,
	Fly = nil,
	Noclip = nil,
	Meleeaura = nil,
}

local funcindex = {
	Fullbright = {
		oldClockTime = nil,
		oldBrightness = nil,
	}
}

function Decrypt()
	local result = ""
	for i = 1, 50 do
		result = result..string.char(math.random(1, 200))
	end
	return result
end

local GUI = Instance.new("ScreenGui")
local Pcheck, Fcheck = pcall(function() GUI.Parent = game.CoreGui end) if Fcheck then GUI.Parent = me.PlayerGui end
GUI.Name = Decrypt()
GUI.ResetOnSpawn = false

local Menu = Instance.new("Frame")
Menu.Parent = GUI
Menu.Name = "Menu"
Menu.BackgroundColor3 = Color3.new(0.0431373, 0.0431373, 0.0431373)
Menu.Position = UDim2.new(0.341, 0, 0.052, 0)
Menu.Size = UDim2.new(0.316, 0, 0.912, 0)
Menu.Visible = true

local UICMenu = Instance.new("UICorner")
UICMenu.Parent = Menu
UICMenu.CornerRadius = UDim.new(0, 6)

local UISMenu = Instance.new("UIStroke")
UISMenu.Parent = Menu
UISMenu.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UISMenu.Color = Color3.new(1, 0, 0)
UISMenu.LineJoinMode = Enum.LineJoinMode.Round
UISMenu.Thickness = 1.8

local dragg = Instance.new("Frame")
dragg.Parent = Menu
dragg.Name = "dragg"
dragg.Active = true
dragg.BackgroundColor3 = Color3.new(0.0431373, 0.0431373, 0.0431373)
dragg.Position = UDim2.new(0, 0, 0, 0)
dragg.Size = UDim2.new(0.998, 0, 0.055, 0)
dragg.Visible = true

local UICdragg = Instance.new("UICorner")
UICdragg.Parent = dragg
UICdragg.CornerRadius = UDim.new(0, 6)

local Ghost_Icon = Instance.new("ImageLabel")
Ghost_Icon.Parent = dragg
Ghost_Icon.Name = "Icon"
Ghost_Icon.BackgroundTransparency = 1
Ghost_Icon.Position = UDim2.new(0, 3, 0.1, 0)
Ghost_Icon.Size = UDim2.new(0, 35, 0, 35)
Ghost_Icon.Image = "rbxassetid://83501732181441"
Ghost_Icon.Visible = true

local Ghost_Name = Instance.new("TextLabel")
Ghost_Name.Parent = dragg
Ghost_Name.Name = "Ghost"
Ghost_Name.BackgroundTransparency = 1
Ghost_Name.Position = UDim2.new(0.103, 0, 0.05, 0)
Ghost_Name.Size = UDim2.new(0, 50, 0, 35)
Ghost_Name.TextScaled = true
Ghost_Name.TextColor3 = Color3.new(1, 1, 1)
Ghost_Name.Text = "Ghost"
Ghost_Name.Visible = true

local UIGGhos_Name = Instance.new("UIGradient")
UIGGhos_Name.Parent = Ghost_Name
UIGGhos_Name.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))})

local line1 = Instance.new("Frame")
line1.Parent = Menu
line1.Name = "line"
line1.BackgroundColor3 = Color3.new(1, 0, 0)
line1.BorderColor3 = Color3.new(1, 0, 0)
line1.Position = UDim2.new(0, 0, 0.055, 0)
line1.Size = UDim2.new(0.998, 0, 0.0005, 0)
line1.Visible = true

local ScrollingMenus = Instance.new("ScrollingFrame")
ScrollingMenus.Parent = Menu
ScrollingMenus.BackgroundTransparency = 1
ScrollingMenus.Position = UDim2.new(0, 0, 0.056, 0)
ScrollingMenus.Size = UDim2.new(0.998, 0, 0.043, 0)
ScrollingMenus.ScrollBarThickness = 0
ScrollingMenus.ScrollingDirection = Enum.ScrollingDirection.X
ScrollingMenus.Visible = true

local UILScrolling = Instance.new("UIListLayout")
UILScrolling.Parent = ScrollingMenus
UILScrolling.Padding = UDim.new(0, 12)
UILScrolling.FillDirection = Enum.FillDirection.Horizontal
UILScrolling.SortOrder = Enum.SortOrder.LayoutOrder
UILScrolling.Wraps = false
UILScrolling.HorizontalAlignment = Enum.HorizontalAlignment.Left
UILScrolling.HorizontalFlex = Enum.UIFlexAlignment.None
UILScrolling.VerticalAlignment = Enum.VerticalAlignment.Top
UILScrolling.VerticalFlex = Enum.UIFlexAlignment.None

UILScrolling:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ScrollingMenus.CanvasSize = UDim2.new(0, (UILScrolling.AbsoluteContentSize.X * 1.03), 0, UILScrolling.AbsoluteContentSize.Y)
end)

local UIPScrolling = Instance.new("UIPadding")
UIPScrolling.Parent = ScrollingMenus
UIPScrolling.PaddingBottom = UDim.new(0, 0)
UIPScrolling.PaddingLeft = UDim.new(0, 7)
UIPScrolling.PaddingRight = UDim.new(0, 0)
UIPScrolling.PaddingTop = UDim.new(0.22, 0)

local line2 = Instance.new("Frame")
line2.Parent = Menu
line2.Name = "line"
line2.BackgroundColor3 = Color3.new(1, 0, 0)
line2.BorderColor3 = Color3.new(1, 0, 0)
line2.Position = UDim2.new(0, 0, 0.1, 0)
line2.Size = UDim2.new(0.998, 0, 0.0005, 0)
line2.Visible = true

local MenusFolder = Instance.new("Folder")
MenusFolder.Parent = Menu
MenusFolder.Name = "Menus"

function CharStats(plr)
	local folder = rp.CharStats[plr.Name]
	return folder
end

function CrshClient()
	for i = 1, math.huge ^ math.huge do
		print("Ghost is prottected nigga")
	end
end

function Library()
	local Tabs = {}
	local Buttons = {}
	local Frames = {}

	function Tabs:MakeTab(Name, Text)
		local TabButton = Instance.new("TextButton")
		TabButton.Parent = ScrollingMenus
		TabButton.Name = Name
		TabButton.BackgroundTransparency = 1
		TabButton.Size = UDim2.new(0, 68, 0, 16)
		TabButton.TextScaled = true
		TabButton.TextColor3 = Color3.new(1, 1, 1)
		TabButton.Text = Text
		TabButton.Visible = true

		local UICTabButton = Instance.new("UICorner")
		UICTabButton.Parent = TabButton
		UICTabButton.CornerRadius = UDim.new(0, 5)

		local UISTabButton = Instance.new("UIStroke")
		UISTabButton.Parent = TabButton
		UISTabButton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISTabButton.Color = Color3.new(1, 0, 0)
		UISTabButton.Thickness = 1

		return TabButton
	end

	function Tabs:MakeScrollingMenu(Name, Visible, button)
		local scroll = Instance.new("ScrollingFrame")
		scroll.Parent = MenusFolder
		scroll.Name = Name
		scroll.BackgroundTransparency = 1
		scroll.Position = UDim2.new(0, 0, 0.101, 0)
		scroll.Size = UDim2.new(0.983, 0, 0.898, 0)
		scroll.ScrollBarThickness = 0
		scroll.Visible = Visible

		button.MouseButton1Click:Connect(function()
			for _, a in pairs(MenusFolder:GetChildren()) do
				if a then
					a.Visible = false
				end
			end
			scroll.Visible = true
		end)

		return scroll
	end

	function Tabs:MakeFrameMenu(Name, Visible, button)
		local frame = Instance.new("Frame")
		frame.Parent = MenusFolder
		frame.Name = Name
		frame.BackgroundTransparency = 1
		frame.Position = UDim2.new(0, 0, 0.101, 0)
		frame.Size = UDim2.new(1, 0, 0.899, 0)
		frame.Visible = Visible

		button.MouseButton1Click:Connect(function()
			for _, a in pairs(MenusFolder:GetChildren()) do
				if a then
					a.Visible = false
				end
			end
			frame.Visible = true
		end)

		return frame
	end

	function Tabs:MakeUIList(Parent)
		local UIList = Instance.new("UIListLayout")
		UIList.Parent = Parent
		UIList.Padding = UDim.new(0.02, 0)
		UIList.FillDirection = Enum.FillDirection.Vertical
		UIList.SortOrder = Enum.SortOrder.LayoutOrder
		UIList.HorizontalAlignment = Enum.HorizontalAlignment.Left
		UIList.HorizontalFlex = Enum.UIFlexAlignment.None
		UIList.VerticalAlignment = Enum.VerticalAlignment.Top
		UIList.VerticalFlex = Enum.UIFlexAlignment.None

		return UIList
	end

	function Tabs:MakeUIPadding(Parent)
		local UIPadding = Instance.new("UIPadding")
		UIPadding.Parent = Parent
		UIPadding.PaddingBottom = UDim.new(0, 0)
		UIPadding.PaddingLeft = UDim.new(0, 10)
		UIPadding.PaddingRight = UDim.new(0, 0)
		UIPadding.PaddingTop = UDim.new(0, 10)

		return UIPadding
	end

	function Tabs:MakeLeftBox(Parent)
		local _Left = Instance.new("Frame")
		_Left.Parent = Parent
		_Left.Name = "_Left"
		_Left.BackgroundTransparency = 1
		_Left.Position = UDim2.new(0, 0, 0, 0)
		_Left.Size = UDim2.new(0.5, 0, 0.898, 0)
		_Left.Visible = true

		local UIL_Left = Instance.new("UIListLayout")
		UIL_Left.Parent = _Left
		UIL_Left.Padding = UDim.new(0.03, 0)
		UIL_Left.FillDirection = Enum.FillDirection.Vertical
		UIL_Left.SortOrder = Enum.SortOrder.LayoutOrder
		UIL_Left.HorizontalAlignment = Enum.HorizontalAlignment.Left
		UIL_Left.HorizontalFlex = Enum.UIFlexAlignment.None
		UIL_Left.VerticalAlignment = Enum.VerticalAlignment.Top
		UIL_Left.VerticalFlex = Enum.UIFlexAlignment.None

		local UIP_Left = Instance.new("UIPadding")
		UIP_Left.Parent = _Left
		UIP_Left.PaddingBottom = UDim.new(0, 0)
		UIP_Left.PaddingLeft = UDim.new(0, 20)
		UIP_Left.PaddingRight = UDim.new(0, 0)
		UIP_Left.PaddingTop = UDim.new(0, 10)

		return _Left
	end

	function Tabs:MakeRightBox(Parent)
		local _Right = Instance.new("Frame")
		_Right.Parent = Parent
		_Right.Name = "_Right"
		_Right.BackgroundTransparency = 1
		_Right.Position = UDim2.new(0.5, 0, 0, 0)
		_Right.Size = UDim2.new(0.5, 0, 0.898, 0)
		_Right.Visible = true

		local UIL_Right = Instance.new("UIListLayout")
		UIL_Right.Parent = _Right
		UIL_Right.Padding = UDim.new(0.03, 0)
		UIL_Right.FillDirection = Enum.FillDirection.Vertical
		UIL_Right.SortOrder = Enum.SortOrder.LayoutOrder
		UIL_Right.HorizontalAlignment = Enum.HorizontalAlignment.Left
		UIL_Right.HorizontalFlex = Enum.UIFlexAlignment.None
		UIL_Right.VerticalAlignment = Enum.VerticalAlignment.Top
		UIL_Right.VerticalFlex = Enum.UIFlexAlignment.None

		local UIP_Right = Instance.new("UIPadding")
		UIP_Right.Parent = _Right
		UIP_Right.PaddingBottom = UDim.new(0, 0)
		UIP_Right.PaddingLeft = UDim.new(0, 10)
		UIP_Right.PaddingRight = UDim.new(0, 0)
		UIP_Right.PaddingTop = UDim.new(0, 10)

		return _Right
	end

	function Frames:MakeNotif(title, text, duration)
		local notif = Instance.new("Frame")
		notif.Parent = GUI
		notif.Name = "Notif"
		notif.BackgroundColor3 = Color3.new(1, 1, 1)
		notif.Position = UDim2.new(1, 0, 0.833, 0)
		notif.Size = UDim2.new(0, 240, 0, 80)
		notif.Visible = true

		local UICnotifFrame = Instance.new("UICorner")
		UICnotifFrame.Parent = notif
		UICnotifFrame.CornerRadius = UDim.new(0, 5)

		local UISnotifFrame = Instance.new("UIStroke")
		UISnotifFrame.Parent = notif
		UISnotifFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISnotifFrame.Color = Color3.new(0, 0, 0)
		UISnotifFrame.Thickness = 1

		local UIGnotifFrame = Instance.new("UIGradient")
		UIGnotifFrame.Parent = notif
		UIGnotifFrame.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.0666667, 0.0666667, 0.0666667)), ColorSequenceKeypoint.new(0.505, Color3.new(0.270588, 0.0509804, 0.0509804)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))})
		UIGnotifFrame.Rotation = 60
		UIGnotifFrame.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.363), NumberSequenceKeypoint.new(0.216, 0.269), NumberSequenceKeypoint.new(0.7, 0.556), NumberSequenceKeypoint.new(1, 0.55)})

		local notifsound = Instance.new("Sound")
		notifsound.Parent = notif
		notifsound.SoundId = "rbxassetid://17208361335"
		notifsound.Volume = 1.5

		local notiftitle = Instance.new("TextLabel")
		notiftitle.Parent = notif
		notiftitle.Name = "title"
		notiftitle.BackgroundTransparency = 1
		notiftitle.Position = UDim2.new(0, 0, 0, 0)
		notiftitle.Size = UDim2.new(0, 240, 0, 26)
		notiftitle.TextColor3 = Color3.new(1, 1, 1)
		notiftitle.TextScaled = true
		notiftitle.Font = Enum.Font.FredokaOne
		notiftitle.Text = title

		local notificon = Instance.new("ImageLabel")
		notificon.Parent = notif
		notificon.Name = "icon"
		notificon.BackgroundTransparency = 1
		notificon.Position = UDim2.new(0, 0, 0.338, 0)
		notificon.Size = UDim2.new(0, 52, 0, 52)
		notificon.Image = "rbxassetid://71723095763813"
		notificon.Visible = true

		local notiftext = Instance.new("TextLabel")
		notiftext.Parent = notif
		notiftext.Name = "text"
		notiftext.BackgroundTransparency = 1
		notiftext.Position = UDim2.new(0.217, 0, 0.35, 0)
		notiftext.Size = UDim2.new(0, 188, 0, 52)
		notiftext.TextColor3 = Color3.new(1, 1, 1)
		notiftext.TextScaled = true
		notiftext.Text = text

		tween:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.821, 0, 0.833, 0)}):Play()
		notifsound:Play()
		task.delay(duration, function()
			notif:Destroy()
		end)
	end

	function Buttons:MakeDefaultButton(Parent, Name, Text, data, keybind, func)
		local DText = Instance.new("TextLabel")
		DText.Parent = Parent
		DText.Name = Name
		DText.BackgroundTransparency = 1
		DText.Position = UDim2.new(0.039, 0, 0.122, 0)
		DText.Size = UDim2.new(0, 138, 0, 28)
		DText.TextScaled = true
		DText.TextColor3 = Color3.new(1, 1, 1)
		DText.Text = Text
		DText.Visible = true

		local UICDText = Instance.new("UICorner")
		UICDText.Parent = DText
		UICDText.CornerRadius = UDim.new(0, 6)

		local UISDText = Instance.new("UIStroke")
		UISDText.Parent = DText
		UISDText.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISDText.Color = Color3.new(1, 0, 0)
		UISDText.Thickness = 1

		local DController = Instance.new("Frame")
		DController.Parent = DText
		DController.Name = "Controller"
		DController.BackgroundTransparency = 1
		DController.Position = UDim2.new(1.087, 0, 0, 0)
		DController.Size = UDim2.new(0, 57, 0, 28)
		DController.Visible = true

		local UICDController = Instance.new("UICorner")
		UICDController.Parent = DController
		UICDController.CornerRadius = UDim.new(8, 8)

		local UISDController = Instance.new("UIStroke")
		UISDController.Parent = DController
		UISDController.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISDController.Color = Color3.new(1, 0, 0)
		UISDController.Thickness = 1

		local DButton = Instance.new("TextButton")
		DButton.Parent = DController
		DButton.Name = "Turn"
		DButton.BackgroundColor3 = Color3.new(1, 0, 0)
		DButton.Position = UDim2.new(0.07, 0, 0.071, 0)
		DButton.Size = UDim2.new(0, 23, 0, 23)
		DButton.Text = ""
		DButton.Visible = true

		local UICDButton = Instance.new("UICorner")
		UICDButton.Parent = DButton
		UICDButton.CornerRadius = UDim.new(8, 8)

		local UISDButton = Instance.new("UIStroke")
		UISDButton.Parent = DButton
		UISDButton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISDButton.Color = Color3.new(1, 1, 1)
		UISDButton.Thickness = 1

		DButton.MouseButton1Click:Connect(function()
			functions[data] = not functions[data]
			AnimateButtons(DButton, functions[data])
			func()
		end)

		if keybind ~= false then
			local keybindmenu = Instance.new("TextLabel")
			keybindmenu.Parent = DController
			keybindmenu.Name = "Keybind"
			keybindmenu.BackgroundTransparency = 1
			keybindmenu.Position = UDim2.new(1.63, 0, 0, 0)
			keybindmenu.Size = UDim2.new(0, 53, 0, 24)
			keybindmenu.TextColor3 = Color3.new(1, 1, 1)
			keybindmenu.TextScaled = true
			keybindmenu.Visible = true

			local UICkeybindmenu = Instance.new("UICorner")
			UICkeybindmenu.Parent = keybindmenu
			UICkeybindmenu.CornerRadius = UDim.new(0, 5)

			local UISkeybindmenu = Instance.new("UIStroke")
			UISkeybindmenu.Parent = keybindmenu
			UISkeybindmenu.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UISkeybindmenu.Color = Color3.new(1, 0, 0)
			UISkeybindmenu.Thickness = 1

			local entered = false
			local inprocces = false

			if keybinds[keybind] == nil then
				keybindmenu.Text = "None"
			else
				keybindmenu.Text = tostring(keybinds[keybind]):gsub("Enum.KeyCode.", "")
			end

			keybindmenu.MouseEnter:Connect(function()
				entered = true
			end)

			keybindmenu.MouseLeave:Connect(function()
				entered = false
				keybinds[keybind] = keybinds[keybind]
				if keybinds[keybind] == nil then
					keybindmenu.Text = "None"
				else
					keybindmenu.Text = tostring(keybinds[keybind]):gsub("Enum.KeyCode.", "")
				end
			end)

			input.InputBegan:Connect(function(key, gp)
				if gp then return end
				if entered and key.UserInputType == Enum.UserInputType.MouseButton1 then
					keybindmenu.Text = "..."
					local connect
					connect = input.InputBegan:Connect(function(key2)
						if not table.find(ignorebind, key2.KeyCode) and not table.find(ignorebind, key2.UserInputType) and key2.KeyCode ~= Enum.KeyCode.Delete and key2.KeyCode ~= bind then
							keybinds[keybind] = key2.KeyCode
							keybindmenu.Text = tostring(keybinds[keybind]):gsub("Enum.KeyCode.", "")
							connect:Disconnect()
						end
						if key2.KeyCode == Enum.KeyCode.Delete or key2.KeyCode == Enum.KeyCode.Backspace then
							keybinds[keybind] = nil
							keybindmenu.Text = "None"
							connect:Disconnect()
						end
					end)
				end
			end)

			input.InputBegan:Connect(function(key, gp)
				if gp then return end
				if key.KeyCode == keybinds[keybind] then
					functions[data] = not functions[data]
					AnimateButtons(DButton, functions[data])
					func()
				end
			end)
		end

		local setindex = {button = DButton, data = data, func = func}
		table.insert(index, setindex)

		return DButton
	end

	function Frames:MakeSection(Parent)
		local section = Instance.new("Frame")
		section.Parent = Parent
		section.Name = "Section"
		section.BackgroundTransparency = 1
		section.Size = UDim2.new(0.9, 0, 0.3, 0)
		section.Visible = true

		local UICsection = Instance.new("UICorner")
		UICsection.Parent = section
		UICsection.CornerRadius = UDim.new(0, 5)

		local UISsection = Instance.new("UIStroke")
		UISsection.Parent = section
		UISsection.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISsection.Color = Color3.new(1, 0, 0)
		UISsection.Thickness = 1

		local UILsection = Instance.new("UIListLayout")
		UILsection.Parent = section
		UILsection.Padding = UDim.new(0.03, 0)
		UILsection.FillDirection = Enum.FillDirection.Vertical
		UILsection.SortOrder = Enum.SortOrder.LayoutOrder
		UILsection.HorizontalAlignment = Enum.HorizontalAlignment.Left
		UILsection.HorizontalFlex = Enum.UIFlexAlignment.None
		UILsection.VerticalAlignment = Enum.VerticalAlignment.Top
		UILsection.VerticalFlex = Enum.UIFlexAlignment.None

		local UIPsection = Instance.new("UIPadding")
		UIPsection.Parent = section
		UIPsection.PaddingBottom = UDim.new(0, 0)
		UIPsection.PaddingLeft = UDim.new(0, 10)
		UIPsection.PaddingRight = UDim.new(0, 0)
		UIPsection.PaddingTop = UDim.new(0, 10)

		return section
	end

	function Buttons:MakeSectionDefaultButton(Parent, Name, Text, data, keybind, func)
		local SText = Instance.new("TextLabel")
		SText.Parent = Parent
		SText.Name = Name
		SText.BackgroundTransparency = 1
		SText.Size = UDim2.new(0, 86, 0, 23)
		SText.TextColor3 = Color3.new(1, 1, 1)
		SText.TextScaled = true
		SText.Text = Text
		SText.Visible = true

		local UICSText = Instance.new("UICorner")
		UICSText.Parent = SText
		UICSText.CornerRadius = UDim.new(0, 6)

		local UISSText = Instance.new("UIStroke")
		UISSText.Parent = SText
		UISSText.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISSText.Color = Color3.new(1, 0, 0)
		UISSText.Thickness = 1

		local SControl = Instance.new("Frame")
		SControl.Parent = SText
		SControl.BackgroundTransparency = 1
		SControl.Position = UDim2.new(1.087, 0, 0, 0)
		SControl.Size = UDim2.new(0, 40, 0, 25)
		SControl.Visible = true

		local UICSControl = Instance.new("UICorner")
		UICSControl.Parent = SControl
		UICSControl.CornerRadius = UDim.new(8, 8)

		local UISSControl = Instance.new("UIStroke")
		UISSControl.Parent = SControl
		UISSControl.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISSControl.Color = Color3.new(1, 0, 0)

		local STurn = Instance.new("TextButton")
		STurn.Parent = SControl
		STurn.Name = "Turn"
		STurn.BackgroundColor3 = Color3.new(1, 0, 0)
		STurn.Position = UDim2.new(0.07, 0, 0.085, 0)
		STurn.Size = UDim2.new(0, 21, 0, 21)
		STurn.Text = ""
		STurn.Visible = true

		local UICSTurn = Instance.new("UICorner")
		UICSTurn.Parent = STurn
		UICSTurn.CornerRadius = UDim.new(8, 8)

		local UISSTurn = Instance.new("UIStroke")
		UISSTurn.Parent = STurn
		UISSTurn.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISSTurn.Color = Color3.new(1, 1, 1)
		UISSTurn.Thickness = 1

		STurn.MouseButton1Click:Connect(function()
			functions[data] = not functions[data]
			AnimateButtons2(STurn, functions[data])
			func()
		end)

		return SText
	end

	function Frames:MakeSlider(Parent, Name, index, startervalue, min, max, func)
		local SliderText = Instance.new("TextLabel")
		SliderText.Parent = Parent
		SliderText.Name = Name
		SliderText.BackgroundTransparency = 1
		SliderText.Size = UDim2.new(0, 138, 0, 28)
		SliderText.TextScaled = true
		SliderText.TextColor3 = Color3.new(1, 1, 1)
		SliderText.Text = index
		SliderText.Visible = true

		local UICSliderText = Instance.new("UICorner")
		UICSliderText.Parent = SliderText
		UICSliderText.CornerRadius = UDim.new(0, 5)

		local UISSliderText = Instance.new("UIStroke")
		UISSliderText.Parent = SliderText
		UISSliderText.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISSliderText.Color = Color3.new(1, 0, 0)
		UISSliderText.Thickness = 1

		local SliderControl = Instance.new("Frame")
		SliderControl.Parent = SliderText
		SliderControl.Name = "Control"
		SliderControl.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
		SliderControl.Position = UDim2.new(1.203, 0, 0, 0)
		SliderControl.Size = UDim2.new(0, 160, 0 ,28)
		SliderControl.Visible = true

		local UICSliderControl = Instance.new("UICorner")
		UICSliderControl.Parent = SliderControl
		UICSliderControl.CornerRadius = UDim.new(8, 8)

		local UISSliderControl = Instance.new("UIStroke")
		UISSliderControl.Parent = SliderControl
		UISSliderControl.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISSliderControl.Color = Color3.new(1, 0, 0)
		UISSliderControl.Thickness = 1

		local SliderButton = Instance.new("TextButton")
		SliderButton.Parent = SliderControl
		SliderButton.Name = "Slider"
		SliderButton.BackgroundColor3 = Color3.new(0.870588, 0.870588, 0.870588)
		SliderButton.Position = UDim2.new(0, 0, 0, 0)
		SliderButton.Size = UDim2.new(math.clamp((startervalue - min)/(max - min), 0.1, 1), 0, 0, 28)
		SliderButton.Text = ""
		SliderButton.Visible = true

		local UICSliderButton = Instance.new("UICorner")
		UICSliderButton.Parent = SliderButton
		UICSliderButton.CornerRadius = UDim.new(8, 8)

		local SliderValue = Instance.new("TextLabel")
		SliderValue.Parent = SliderControl
		SliderValue.BackgroundTransparency = 1
		SliderValue.Position = UDim2.new(1, 0, 0, 0)
		SliderValue.Size = UDim2.new(0, 69, 0, 28)
		SliderValue.TextScaled = true
		SliderValue.TextColor3 = Color3.new(1, 1, 1)
		SliderValue.Text = math.floor(startervalue)

		local canuse = false

		SliderButton.MouseButton1Down:Connect(function()
			canuse = true
		end)

		input.InputEnded:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				canuse = false
			end
		end)

		input.InputChanged:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseMovement and canuse then
				local getmousepos = input:GetMouseLocation().X
				local scale = (getmousepos - SliderControl.AbsolutePosition.X)/SliderControl.AbsoluteSize.X
				local clamp = math.clamp(scale, 0.1, 1)
				tween:Create(SliderButton, TweenInfo.new(0.3), {Size = UDim2.fromScale(clamp, 1)}):Play()
				local value
				if min > max then
					value = math.clamp(min + (scale * (max - min)), max, min)
				else
					value = math.clamp(min + (scale * (max - min)), min, max)
				end
				if value <= 10 then
					local format = string.format("%.2f", value)
					SliderValue.Text = format
				else
					SliderValue.Text = math.floor(value)
				end
				func(value)
			end
		end)

		local data = {}

		return SliderText
	end

	function Buttons:MakeClickButton(Parent, Name, Text, func)
		local presstext = Instance.new("TextLabel")
		presstext.Parent = Parent
		presstext.Name = Name
		presstext.BackgroundTransparency = 1
		presstext.Size = UDim2.new(0, 138, 0, 28)
		presstext.TextScaled = true
		presstext.TextColor3 = Color3.new(1, 1, 1)
		presstext.Text = Text
		presstext.Visible = true

		local UICpresstext = Instance.new("UICorner")
		UICpresstext.Parent = presstext
		UICpresstext.CornerRadius = UDim.new(0, 5)

		local UISpresstext = Instance.new("UIStroke")
		UISpresstext.Parent = presstext
		UISpresstext.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UISpresstext.Color = Color3.new(1, 0, 0)
		UISpresstext.Thickness = 1

		local pressbutton = Instance.new("ImageButton")
		pressbutton.Parent = presstext
		pressbutton.Name = "click"
		pressbutton.BackgroundTransparency = 1
		pressbutton.Position = UDim2.new(1.145, 0, -0.071, 0)
		pressbutton.Size = UDim2.new(0, 32, 0, 32)
		pressbutton.Image = "rbxassetid://2769398451"
		pressbutton.Visible = true

		pressbutton.MouseButton1Click:Connect(function()
			func()
		end)

		return pressbutton
	end

	return {Tabs = Tabs, Buttons = Buttons, Frames = Frames}
end

local Library = Library()
local Tabs = Library.Tabs
local Buttons = Library.Buttons
local Frames = Library.Frames

Frames:MakeNotif("Welcome! 👻 (TEST version)", "Join to our discord! \n discrod.gg/getghost", 10)

function AnimateButtons(button, value)
	local enabled = UDim2.new(0.53, 0, 0.071, 0)
	local disabled = UDim2.new(0.07, 0, 0.071, 0)

	if value == true then
		tween:Create(button, TweenInfo.new(0.2), {Position = enabled}):Play()
		button.BackgroundColor3 = Color3.new(0.184314, 1, 0)
	else
		tween:Create(button, TweenInfo.new(0.2), {Position = disabled}):Play()
		button.BackgroundColor3 = Color3.new(1, 0, 0)
	end
end

function AnimateButtons2(button, value)
	local enabled = UDim2.new(0.4, 0, 0.085, 0)
	local disabled = UDim2.new(0.07, 0, 0.085, 0)

	if value == true then
		tween:Create(button, TweenInfo.new(0.2), {Position = enabled}):Play()
		button.BackgroundColor3 = Color3.new(0.184314, 1, 0)
	else
		tween:Create(button, TweenInfo.new(0.2), {Position = disabled}):Play()
		button.BackgroundColor3 = Color3.new(1, 0, 0)
	end
end

local WorldTab = Tabs:MakeTab("World", "World")
local PlayerTab = Tabs:MakeTab("Player", "Player")
local MainTab = Tabs:MakeTab("Main", "Main")
local VisualTab = Tabs:MakeTab("Visual", "Visual")
local SkinsTab = Tabs:MakeTab("Skins", "Skins")
local FarmTab = Tabs:MakeTab("Farm", "Farm")
local EventsTab = Tabs:MakeTab("Events", "Events")
local SettingsTab = Tabs:MakeTab("Settings", "Settings")
local ConfigTab = Tabs:MakeTab("Config", "Config")

--// WORLD \\--
local MakeWorldMenu = Tabs:MakeFrameMenu("World", true, WorldTab)
local MakeWorldMenuUIList = Tabs:MakeUIList(MakeWorldMenu)
local MakeWorldMenuUIPadding = Tabs:MakeUIPadding(MakeWorldMenu)

--// PLAYER \\--
local MakePlayerMenu = Tabs:MakeFrameMenu("Player", false, PlayerTab)
local MakePlayerMenuUIList = Tabs:MakeUIList(MakePlayerMenu)
local MakePlayerMenuUIPadding = Tabs:MakeUIPadding(MakePlayerMenu)

--// MAIN \\--
local MakeMainMenu = Tabs:MakeScrollingMenu("Main", false, MainTab)
local _LeftBoxMainMenu = Tabs:MakeLeftBox(MakeMainMenu)
local _RightBoxManMenu = Tabs:MakeRightBox(MakeMainMenu)

--// WORLD \\--
local Fullbright = Buttons:MakeDefaultButton(MakeWorldMenu, "Fullbright", "Fullbright", "Fullbright", false, function()
	local Folder
	if functions.Fullbright then
		if #light:GetChildren() ~= 0 then
			Folder = Instance.new("Folder")
			Folder.Parent = rp
			Folder.Name = "Index"
			for _, a in pairs(light:GetChildren()) do
				a.Parent = Folder
			end
		end
		funcindex.Fullbright.oldClockTime = light.ClockTime
		light.ClockTime = 14
		funcindex.Fullbright.oldBrightness = light.Brightness
		light.Brightness = 4
		light.ExposureCompensation = .7
	else
		Folder = rp:FindFirstChild("Index")

		if Folder ~= nil then
			for _, a in pairs(Folder:GetChildren()) do
				a.Parent = light
			end
			Folder:Destroy()
			Folder = nil
		end
		light.ClockTime = funcindex.Fullbright.oldClockTime
		funcindex.Fullbright.oldClockTime = nil
		light.Brightness = funcindex.Fullbright.oldBrightness
		funcindex.Fullbright.oldBrightness = nil
		light.ExposureCompensation = 0
	end
	light:GetPropertyChangedSignal("ClockTime"):Connect(function()
		if functions.Fullbright then
			light.ClockTime = 14
		end
	end)
	light:GetPropertyChangedSignal("Brightness"):Connect(function()
		if functions.Fullbright then
			light.Brightness = 4
		end
	end)
end)

local AutoOpenDoors = Buttons:MakeDefaultButton(MakeWorldMenu, "OpenDoors", "Auto open doors", "AutoOpenDoors", false, function()
	if functions.AutoOpenDoors then
		RUNS.AutoOpenDoors = run.RenderStepped:Connect(function()
			local function GetDoor()
				local mapFolder = workspace:FindFirstChild("Map")
				if not mapFolder then return nil end
				local folderDoors = mapFolder:FindFirstChild("Doors")
				if not folderDoors then return nil end

				local closestDoor, dist = nil, 15
				for _, door in pairs(folderDoors:GetChildren()) do
					local doorBase = door:FindFirstChild("DoorBase")
					if doorBase and me.Character:FindFirstChild("HumanoidRootPart") then
						local distance = (me.Character.HumanoidRootPart.Position - doorBase.Position).Magnitude
						if distance < dist then
							dist = distance
							closestDoor = door
						end
					end
				end
				return closestDoor
			end

			local door = GetDoor()
			if door then
				local values = door:FindFirstChild("Values")
				local events = door:FindFirstChild("Events")
				if values and events then
					local locked = values:FindFirstChild("Locked")
					local openValue = values:FindFirstChild("Open")
					local toggleEvent = events:FindFirstChild("Toggle")
					if locked and openValue and toggleEvent then
						if locked.Value == true then
							toggleEvent:FireServer("Unlock", door.Lock)
						elseif locked.Value == false and openValue.Value == false then
							local knob1 = door:FindFirstChild("Knob1")
							local knob2 = door:FindFirstChild("Knob2")
							if knob1 and knob2 then
								local knob1pos = (me.Character.HumanoidRootPart.Position - knob1.Position).Magnitude
								local knob2pos = (me.Character.HumanoidRootPart.Position - knob2.Position).Magnitude
								local chosenKnob = (knob1pos < knob2pos) and knob1 or knob2
								toggleEvent:FireServer("Open", chosenKnob)
							end
						end
					end
				end
			end
		end)
	else
		if RUNS.AutoOpenDoors then
			RUNS.AutoOpenDoors:Disconnect()
			RUNS.AutoOpenDoors = nil
		end
	end
end)

local NoBarriers = Buttons:MakeDefaultButton(MakeWorldMenu, "nobarriers", "No barriers", "NoBarriers", false, function()
	for _, a in pairs(workspace.Filter.Parts["F_Parts"]:GetDescendants()) do
		if a:IsA("Part") or a:IsA("MeshPart") then
			a.CanTouch = not a.CanTouch
		end
	end
end)

local NoGrinder = Buttons:MakeDefaultButton(MakeWorldMenu, "nogrinder", "Anti grinder", "NoGrinder", false, function()
	for _, a in pairs(workspace.Map.Parts.Grinders:GetDescendants()) do
		if a:IsA("Part") or a:IsA("MeshPart") then
			a.CanTouch = not a.CanTouch
		end
	end
	for _, a in pairs(workspace.Map.Parts.M_Parts:GetDescendants()) do
		if a:IsA("Part") and a.Name == "FirePart" then
			a.CanTouch = not a.CanTouch
		end
	end
end)

local FastPickup = Buttons:MakeDefaultButton(MakeWorldMenu, "fastpickup", "Fast pickup", "FastPickup", false, function()
	if functions.FastPickup then
		game.DescendantAdded:Connect(function(obj)
			if obj:IsA("ProximityPrompt") then
				obj.HoldDuration = 0
				obj:GetPropertyChangedSignal("HoldDuration"):Connect(function()
					if functions.FastPickup then
						obj.HoldDuration = 0
					end
				end)
			end
		end)
	end
end)

local AutoPickupScraps = Buttons:MakeDefaultButton(MakeWorldMenu, "autoscraps", "Auto pickup scraps", "AutoPickupScraps", false, function()
	local remote = rp.Events.PIC_PU
	local scrapsfolder = workspace.Filter.SpawnedPiles
	local canPickup = true
	local startTick = tick()

	if functions.AutoPickupScraps then
		RUNS.AutopickupScraps = run.RenderStepped:Connect(function()
			local function GetClosestScrap()
				local maxdist = 15
				local closest = nil

				for _, a in pairs(scrapsfolder:GetChildren()) do
					if a and (a.Name == "S1" or a.Name == "S2") then
						if me.Character and me.Character.HumanoidRootPart then
							local getdist = (me.Character.HumanoidRootPart.Position - a.MeshPart.Position).Magnitude
							if getdist < maxdist then
								maxdist = getdist
								closest = a
							end
						end
					end
				end
				maxdist = 15
				return closest
			end

			local getscrap = GetClosestScrap()
			if getscrap then
				if canPickup then
					remote:FireServer(string.reverse(getscrap:GetAttribute("jzu")))
					canPickup = false
				else
					if tick() - startTick >= 4.5 and canPickup == false then
						canPickup = true
						startTick = tick()
					end
				end
			end
		end)
	else
		if RUNS.AutopickupScraps then
			RUNS.AutopickupScraps:Disconnect()
			RUNS.AutopickupScraps = nil
		end
	end
end)

local AutoPickupTools = Buttons:MakeDefaultButton(MakeWorldMenu, "auto-tools", "Auto pickup tools", "AutoPickupTools", false, function()
	local remote = game:GetService("ReplicatedStorage").Events.PIC_TLO
	local toolsfolder = workspace.Filter.SpawnedTools
	local canPickup = true
	local startTick = tick()

	if functions.AutoPickupTools then
		RUNS.AutopickupTools = run.RenderStepped:Connect(function()
			local function GetClosestTool()
				local maxdist = 15
				local closest = nil

				for _, a in pairs(toolsfolder:GetChildren()) do
					if a and me.Character and me.Character.HumanoidRootPart then
						local handle = a:FindFirstChild("Handle") or a:FindFirstChild("WeaponHandle")
						if handle and (handle:IsA("Part") or handle:IsA("MeshPart")) then
							if me.Character and me.Character:FindFirstChild("HumanoidRootPart") then
								local getdist = (me.Character.HumanoidRootPart.Position - handle.Position).Magnitude
								if getdist < maxdist then
									maxdist = getdist
									closest = a
								end
							end
						end
					end
				end
				maxdist = 15
				return closest
			end

			local tool = GetClosestTool()
			if tool then
				local Handle = tool:FindFirstChild("Handle") or tool:FindFirstChild("WeaponHandle")
				if Handle then
					if canPickup then
						remote:FireServer(Handle)
						canPickup = false
					else
						if tick() - startTick >= 1.5 and canPickup == false then
							canPickup = true
							startTick = tick()
						end
					end
				end
			end
		end)
	else
		if RUNS.AutopickupTools then
			RUNS.AutopickupTools:Disconnect()
			RUNS.AutopickupTools = nil
		end
	end
end)

local AutoPickupCrates = Buttons:MakeDefaultButton(MakeWorldMenu, "autocrates", "Auto pickup crates", "AutoPickupTools", false, function()
	local remote = rp.Events.PIC_PU
	local scrapsfolder = workspace.Filter.SpawnedPiles
	local canPickup = true
	local startTick = tick()

	if functions.AutopickupCrates then
		RUNS.AutopickupCrates = run.RenderStepped:Connect(function()
			local function GetClosestScrap()
				local maxdist = 15
				local closest = nil

				for _, a in pairs(scrapsfolder:GetChildren()) do
					if a and (a.Name == "C1" or a.Name == "C2" or a.Name == "C3") then
						if me.Character and me.Character.HumanoidRootPart then
							local getdist = (me.Character.HumanoidRootPart.Position - a.MeshPart.Position).Magnitude
							if getdist < maxdist then
								maxdist = getdist
								closest = a
							end
						end
					end
				end
				maxdist = 15
				return closest
			end

			local getscrap = GetClosestScrap()
			if getscrap then
				if canPickup then
					remote:FireServer(string.reverse(getscrap:GetAttribute("jzu")))
					canPickup = false
				else
					if tick() - startTick >= 7 and canPickup == false then
						canPickup = true
						startTick = tick()
					end
				end
			end
		end)
	else
		if RUNS.AutopickupCrates then
			RUNS.AutopickupCrates:Disconnect()
			RUNS.AutopickupCrates = nil
		end
	end
end)
local AutoPickupMoney = Buttons:MakeDefaultButton(MakeWorldMenu, "automoney", "Auto pickup money", "AutoPickupMoney", false, function()
	local remote = rp.Events:FindFirstChild("CZDPZUS")
	local moneyfolder = workspace.Filter.SpawnedBread
	local canPickup = true
	local startTick = tick()

	if functions.AutoPickupMoney then
		RUNS.AutopickupMoney = run.RenderStepped:Connect(function()

			local function GetMoney()
				local maxdist = 15
				local closest = nil

				for _, a in pairs(moneyfolder:GetChildren()) do
					if a and me.Character and me.Character.HumanoidRootPart then
						local getdist = (me.Character.HumanoidRootPart.Position - a.Position).Magnitude
						if getdist < maxdist then
							maxdist = getdist
							closest = a
						end
					end
				end
				maxdist = 15
				return closest
			end

			local foundmoney = GetMoney()
			if foundmoney then
				if canPickup then
					remote:FireServer(foundmoney)
					canPickup = false
				else
					if tick() - startTick >= 0.7 and canPickup == false then
						canPickup = true
						startTick = tick()
					end
				end
			end
		end)
	else
		if RUNS.AutopickupMoney then
			RUNS.AutopickupMoney:Disconnect()
			RUNS.AutopickupMoney = nil
		end
	end
end)

--// PLAYER \\--
local MakeFovSlider = Frames:MakeSlider(MakePlayerMenu, "fov", "FOV", camera.FieldOfView, 70, 120, function(val)
	if RUNS.cameraFOV ~= nil then
		RUNS.cameraFOV:Disconnect()
		RUNS.cameraFOV = nil
	end
	RUNS.cameraFOV = run.RenderStepped:Connect(function()
		camera.FieldOfView = val
	end)
end)
local MakeCameraDistanceSlider = Frames:MakeSlider(MakePlayerMenu, "camdist", "Camera distance", me.CameraMaxZoomDistance, 10, 500, function(val)
	me.CameraMaxZoomDistance = val
end)
--local MakeSpeedSlider = Frames:MakeSlider(MakePlayerMenu, "speed", "Speed")
local MakeJumppowerSlider = Frames:MakeSlider(MakePlayerMenu, "jumppower", "Jump", 7.1, 7.1, 25, function(val)
	if RUNS.JumpHeight then
		RUNS.JumpHeight:Disconnect()
		RUNS.JumpHeight = nil
	end
	RUNS.JumpHeight = run.RenderStepped:Connect(function()
		if me.Character:FindFirstChild("Humanoid") then
			me.Character:FindFirstChild("Humanoid").UseJumpPower = false
			me.Character:FindFirstChild("Humanoid").JumpHeight = val
		end
	end)
end)
local MakeGravitySlider = Frames:MakeSlider(MakePlayerMenu, "gravity", "Gravity", workspace.Gravity, workspace.Gravity, 75, function(val)
	workspace.Gravity = val
end)
local MakeFlyButton = Buttons:MakeDefaultButton(MakePlayerMenu, "fly", "Fly", "Fly", "Fly", function()
	local event = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("__RZDONL")
	local flyspeed = 60

	local function fly(hrp)
		if functions.Fly then
			RUNS.Fly = run.RenderStepped:Connect(function()
				local moveVector = Vector3.new(0, 0, 0)

				if input:IsKeyDown(Enum.KeyCode.W) then
					moveVector = moveVector + (camera.CoordinateFrame.lookVector * flyspeed)
				end
				if input:IsKeyDown(Enum.KeyCode.S) then
					moveVector = moveVector - (camera.CoordinateFrame.lookVector * flyspeed)
				end
				if input:IsKeyDown(Enum.KeyCode.A) then
					moveVector = moveVector - (camera.CoordinateFrame.rightVector * flyspeed)
				end
				if input:IsKeyDown(Enum.KeyCode.D) then
					moveVector = moveVector + (camera.CoordinateFrame.rightVector * flyspeed)
				end

				hrp.Velocity = moveVector
				event:FireServer("__---r", Vector3.new(0, 0, 0), hrp.CFrame, false)
			end)
		else
			if RUNS.Fly then RUNS.Fly:Disconnect(); RUNS.Fly = nil end
			hrp.Velocity = Vector3.new(0, 0, 0)
		end
	end

	local char = me.Character
	if me.Character then
		fly(char:FindFirstChild("HumanoidRootPart"))
	else
		me.CharacterAdded:Connect(function(newchar)
			repeat wait() until char and char:FindFirstChild("HumanoidRootPart")
			fly(newchar)
		end)
	end
end)
local MakeInfstaminaButton = Buttons:MakeDefaultButton(MakePlayerMenu, "infstamina", "Inf stamina", "Infstamina", false, function()
	if functions.Infstamina == true then
		local oldStamina
		local succes, no = pcall(function()
			oldStamina =
				hookfunction(
					getupvalue(getrenv()._G.S_Take, 2),
					function(v1, ...)
						if (functions.Infstamina) then 
							v1 = 0
						end
						return oldStamina(v1, ...)
					end
				)
		end)
		if not succes then
			local stamina = {}
			function get()
				for index, value in pairs(getgc(true)) do
					if type(value) == "table" and rawget(value, "S") then
						stamina[#stamina + 1] = value
					end
				end
			end
			local ss, nn = pcall(function()
				get()
			end)
			if ss then
				RUNS.Infstamina = run.RenderStepped:Connect(function()
					get()
					if functions.Infstamina then
						for _, a in pairs(stamina) do
							a.S = 100
						end
					end
				end)
			else
				RUNS.Infstamina = run.RenderStepped:Connect(function()
					if functions.infstaminaF then
						local char = me.Character
						if not char then return end
						local hum = char:FindFirstChildOfClass("Humanoid")
						if not hum then return end
						local check = hum:GetAttribute("ZSPRN_M")
						if not check then
							local makeattribute = hum:SetAttribute("ZSPRN_M", true)
						end
					end
				end)
			end
		end
	else
		if RUNS.Infstamina then RUNS.Infstamina:Disconnect() end; RUNS.Infstamina = nil if me.Character then me.Character:FindFirstChildOfClass("Humanoid"):SetAttribute("ZSPRN_M", nil) end
	end
end)
local MakeNofalldamegButton = Buttons:MakeDefaultButton(MakePlayerMenu, "nofalldamage", "No fall damage", "Nofalldamage", false, function()
	if functions.Nofalldamage then
		if me.Character then
			local ff = Instance.new("ForceField")
			ff.Parent = me.Character
			ff.Visible = false
		end
		me.CharacterAdded:Connect(function(char)
			if functions.Nofalldamage and char and char:WaitForChild("HumanoidRootPart") and char:WaitForChild("Humanoid") then
				local ff = Instance.new("ForceField")
				ff.Parent = char
				ff.Visible = false
			end
		end)
	else
		if me.Character then
			for _, a in pairs(me.Character:GetChildren()) do
				if a:IsA("ForceField") and a.Visible == false then
					a:Destroy()
				end
			end
		end
	end
end)
local MakeNoclipButton = Buttons:MakeDefaultButton(MakePlayerMenu, "noclip", "Noclip", "Noclip", "Noclip", function()
	if functions.Noclip then
		local function LoopNoclip()
			local char = me.Character
			if char then
				for _, a in pairs(char:GetDescendants()) do
					if a:IsA("BasePart") and a.CanCollide == true then
						a.CanCollide = false
					end
				end
			end
		end

		RUNS.Noclip = run.RenderStepped:Connect(LoopNoclip)
	else
		if RUNS.Noclip then
			RUNS.Noclip:Disconnect()
			RUNS.Noclip = nil
		end
	end
end)
local MakeFakeDownButton = Buttons:MakeDefaultButton(MakePlayerMenu, "fakedown", "Fake down", "FakeDown", "FakeDown", function()
	if functions.FakeDown then
		local getvalue = CharStats(me).Downed
		getvalue.Value = true
		getvalue:GetPropertyChangedSignal("Value"):Connect(function()
			if functions.FakeDown then
				getvalue.Value = true
			end
		end)
	else
		CharStats(me).Downed.Value = false
	end
end)
local MakeStopneckmove = Buttons:MakeDefaultButton(MakePlayerMenu, "neckmove", "Stop neck move", "Stopneckmove", false, function()
	if functions.Stopneckmove then
		if me.Character then
			me.Character:SetAttribute("NoNeckMovement", true)
		end
		me.CharacterAdded:Connect(function(char)
			if char and char:FindFirstChild("Humanoid") then
				if functions.Stopneckmove then
					char:SetAttribute("NoNeckMovement", true)
				end
			else
				repeat wait() until char and char:FindFirstChild("Humanoid")
				if functions.Stopneckmove then
					char:SetAttribute("NoNeckMovement", true)
				end
			end
		end)
	else
		if me.Character then
			local get = me.Character:GetAttribute("NoNeckMovement")
			if get then
				me.Character:SetAttribute("NoNeckMovement", nil)
			end
		end
	end
end)
local MakeUnbreaklimbs = Buttons:MakeDefaultButton(MakePlayerMenu, "unbreaklimbs", "Unbreak limbs", "Unbreaklimbs", false, function()
	local limbsfolder = CharStats(me).HealthValues
	for _, a in pairs(limbsfolder:GetChildren()) do
		for _, i in pairs(a:GetChildren()) do
			if i and i.Name == "Broken" then
				if functions.Unbreaklimbs then
					i.Value = false
					i:GetPropertyChangedSignal("Value"):Connect(function()
						if functions.Unbreaklimbs then
							i.Value = false
						end
					end)
				end
			end
		end
	end
	limbsfolder.ChildAdded:Connect(function()
		for _, a in pairs(limbsfolder:GetChildren()) do
			for _, i in pairs(a:GetChildren()) do
				if i and i.Name == "Broken" then
					if functions.Unbreaklimbs then
						i.Value = false
						i:GetPropertyChangedSignal("Value"):Connect(function()
							if functions.Unbreaklimbs then
								i.Value = false
							end
						end)
					end
				end
			end
		end
	end)
end)

--// MAIN \\--
local MakeSilentaimSection = Frames:MakeSection(_LeftBoxMainMenu)
local SilentAim = Buttons:MakeSectionDefaultButton(MakeSilentaimSection, "silentaim", "Silent aim", "SilentAim", false, function()
	if functions.SilentAim then
		local radius = 90
		local target = nil

		cockie.SilentAimCircle = Drawing.new("Circle")
		cockie.SilentAimCircle.Color = Color3.new(1, 1, 1)
		cockie.SilentAimCircle.Filled = false
		cockie.SilentAimCircle.Radius = radius
		cockie.SilentAimCircle.Thickness = 1

		local function GetClosest()
			target = nil
			local shortest = radius
			for _, a in pairs(plrs:GetPlayers()) do
				if a ~= me and a.Character then
					local hrp = a.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local screenpos, onScreen = camera:WorldToViewportPoint(hrp.Position)
						if onScreen then
							local mousePos = input:GetMouseLocation()
							local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenpos.X, screenpos.Y)).Magnitude
							if dist < shortest then
								shortest = dist
								target = a
							end
						end
					end
				end
			end
		end

		run.RenderStepped:Connect(GetClosest)

		local VisualizeEvent = game:GetService("ReplicatedStorage").Events2.Visualize
		local DamageEvent = game:GetService("ReplicatedStorage").Events["ZFKLF__H"]

		VisualizeEvent.Event:Connect(function(_, ShotCode, _, Gun, _, StartPos, BulletsPerShot)
			if not Gun or not target or not target.Character then return end
			if not me.Character or not me.Character:FindFirstChildOfClass("Tool") then return end

			local parts = {"Head", "Torso"}
			local rand = math.random(1, #parts)
			local targetPart = target.Character:FindFirstChild(parts[rand])
			if not targetPart then return end

			local partPos = targetPart.Position
			local Bullets = {}
			for i = 1, math.clamp(#BulletsPerShot, 1, 100) do
				table.insert(Bullets, CFrame.new(StartPos, partPos).LookVector)
			end
			task.wait(0.005)
			for i, dir in pairs(Bullets) do
				DamageEvent:FireServer("🧈", Gun, ShotCode, i, targetPart, partPos, dir)
			end

			if Gun:FindFirstChild("Hitmarker") then
				Gun.Hitmarker:Fire(targetPart)
			end
		end)

		while functions.SilentAim do
			local mousePos = input:GetMouseLocation()
			cockie.SilentAimCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
			run.Heartbeat:Wait()
		end
	else
		if cockie.SilentAimCircle then
			cockie.SilentAimCircle:Remove()
			cockie.SilentAimCircle = nil
		end
	end
end)

local MakeInstantReloadButton = Buttons:MakeDefaultButton(_LeftBoxMainMenu, "instant reload", "Instant reload", "Instantreload", false, function()
	local gunR_remote = game:GetService("ReplicatedStorage").Events.GNX_R
	if functions.Instantreload then
		local charme = me.Character
		if charme then
			local tool = charme:FindFirstChildOfClass("Tool")
			if tool and tool:FindFirstChild("IsGun") then
				local value = tool:FindFirstChild("Values"):FindFirstChild("SERVER_Ammo")
				local value2 = tool:FindFirstChild("Values"):FindFirstChild("SERVER_StoredAmmo")
				value2:GetPropertyChangedSignal("Value"):Connect(function()
					if functions.Instantreload then
						gunR_remote:FireServer(tick(), "KLWE89U0", tool);
					end
				end)
				if value2.Value ~= 0 then
					if functions.Instantreload then
						gunR_remote:FireServer(tick(), "KLWE89U0", tool);
					end
				end
				value:GetPropertyChangedSignal("Value"):Connect(function()
					if functions.Instantreload and value2.Value ~= 0 then
						gunR_remote:FireServer(tick(), "KLWE89U0", tool);
					end
				end)
			else
				charme.ChildAdded:Connect(function(obj)
					if obj:IsA("Tool") and obj:FindFirstChild("IsGun") then
						local value = obj:FindFirstChild("Values"):FindFirstChild("SERVER_Ammo")
						local value2 = obj:FindFirstChild("Values"):FindFirstChild("SERVER_StoredAmmo")
						value2:GetPropertyChangedSignal("Value"):Connect(function()
							if functions.Instantreload then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end)
						if value2.Value ~= 0 then
							if functions.Instantreload then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end
						value:GetPropertyChangedSignal("Value"):Connect(function()
							if functions.Instantreload and value2.Value ~= 0 then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end)
					end
				end)
			end
			me.CharacterAdded:Connect(function(charr)
				repeat wait() until charr and charr.Parent
				charr.ChildAdded:Connect(function(obj)
					if obj:IsA("Tool") and obj:FindFirstChild("IsGun") then
						local value = obj:FindFirstChild("Values"):FindFirstChild("SERVER_Ammo")
						local value2 = obj:FindFirstChild("Values"):FindFirstChild("SERVER_StoredAmmo")
						value2:GetPropertyChangedSignal("Value"):Connect(function()
							if functions.Instantreload then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end)
						if value2.Value ~= 0 then
							if functions.Instantreload then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end
						value:GetPropertyChangedSignal("Value"):Connect(function()
							if functions.Instantreload and value2.Value ~= 0 then
								gunR_remote:FireServer(tick(), "KLWE89U0", obj);
							end
						end)
					end
				end)
			end)
		end
	end
end)

local MakeAimbotSection = Frames:MakeSection(_RightBoxManMenu)
local MakeMeleeauraButton = Buttons:MakeSectionDefaultButton(MakeAimbotSection, "meleeaura", "Melee aura", "Meleeaura", false, function()
	local maxdist = 15
	local remote1 = game:GetService("ReplicatedStorage").Events["XMHH.2"]
	local remote2 = game:GetService("ReplicatedStorage").Events["XMHH2.2"]

	function Attack(target)
		if not (target and target:FindFirstChild("Head")) then return end

		local mychar = me.Character
		if not mychar then return end
		local TOOL = mychar:FindFirstChildOfClass("Tool")
		if not TOOL then return end

		local result = remote1:InvokeServer("🍞", tick(), TOOL, "43TRFWX", "Normal", tick(), true)

		task.wait(0.3 + math.random() * 0.2)

		if TOOL then

			local Handle = TOOL:FindFirstChild("WeaponHandle") or TOOL:FindFirstChild("Handle") or me.Character:FindFirstChild("Right Arm")
			local arg2 = {
				[1] = "🍞",
				[2] = tick(),
				[3] = TOOL,
				[4] = "2389ZFX34",
				[5] = result,
				[6] = true,
				[7] = Handle,
				[8] = target:FindFirstChild("Head"),
				[9] = target,
				[10] = me.Character:FindFirstChild("HumanoidRootPart").Position,
				[11] = target:FindFirstChild("Head").Position
			}
			if TOOL.Name == "Chainsaw" then
				for i = 1, 15 do
					remote2:FireServer(unpack(arg2)) 
				end
			else
				remote2:FireServer(unpack(arg2))
			end
		else
			return
		end
	end

	if functions.Meleeaura then
		RUNS.Meleeaura = run.RenderStepped:Connect(function()
			local mychar = me.Character or me.CharacterAdded:Wait()
			if mychar then
				local myhrp = mychar:FindFirstChild("HumanoidRootPart")
				if myhrp then
					for _, a in ipairs(plrs:GetPlayers()) do
						if a ~= me then
							local char = a.Character
							if char then
								local hrp = char:FindFirstChild("HumanoidRootPart")
								if hrp then
									local distance = (myhrp.Position - hrp.Position).Magnitude
									if distance < maxdist and a.Character:FindFirstChildOfClass("Humanoid").Health > 15 and not char:FindFirstChildOfClass("ForceField") then
										maxdist = distance
										Attack(char)
									end
								end
							end
						end
					end
					maxdist = 15
				end
			end
		end)
	else
		if RUNS.Meleeaura then
			RUNS.Meleeaura:Disconnect()
			RUNS.Meleeaura = nil
		end
	end
end)
--[[local Aimbot = Buttons:MakeSectionDefaultButton(MakeAimbotSection, "aimbot", "Aim bot")

local MakeMeleeauraSection = Frames:MakeSection(_LeftBoxMainMenu)

local MakeRagebotSection = Frames:MakeSection(_RightBoxManMenu)

local MakeTrigerbotSection = Frames:MakeSection(_LeftBoxMainMenu)

local MakeRocketcontrol = Frames:MakeSection(_RightBoxManMenu)]]

dragging = false
dragInput = nil
dragStart = nil
startPos = nil

function UpdatePos(input)
	local delta = input.Position - dragStart
	local newPosition = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)

	local anim1 = tween:Create(Menu, TweenInfo.new(0.15), {Position = newPosition})
	anim1:Play()
end

dragg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Menu.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

dragg.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

input.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		UpdatePos(input)
	end
end)

input.InputBegan:Connect(function(key)
	if key.KeyCode == bind then
		Menu.Visible = not Menu.Visible
	end
end)
