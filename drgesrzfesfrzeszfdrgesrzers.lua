local plrs = game:GetService("Players")
local me = plrs.LocalPlayer
local mouse = me:GetMouse()
local tween = game:GetService("TweenService")
local light = game:GetService("Lighting")
local input = game:GetService("UserInputService")
local content = game:GetService("ContentProvider")
local run = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera

_G.Keybind = Enum.KeyCode.Insert
local ignore_binds = {Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.D, Enum.KeyCode.S, Enum.KeyCode.F9, Enum.KeyCode.F12, Enum.KeyCode.Tab, Enum.KeyCode.Space, Enum.KeyCode.Backspace, Enum.KeyCode.LeftControl, Enum.KeyCode.LeftShift, Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}

local PlayersList = {}
local WhiteList = {}

local functions = {
	FullbrightF = false,
	nobarriersF = false,
	infstaminaF = false,
	nofalldamageF = false,
	aimbotF = false,
	rocket_controlF = false,
	rage_botF = nil,
	EspF = false,
	infpepperF = false,
	glassarmsF = false,
	lockpickF = false,
}

local SectionSettings = {
	AimBot = {
		Draw = false,
		DrawSize = 50,
		DrawColor = Color3.new(1, 0, 0),
		TargetPart = {"Head"},
		CheckWall = false,
		CheckTeam = false,
		CheckWhiteList = false,
		Smooth = false,
		SmoothSize = 0.5,
		Velocity = false
	},
	RocketControl = {
		Speed = 200
	},
	ESP = {
		Name = false,
		Box = false,
		Weapon = false,
		Chams = false,
		CheckTeam = false,
		Scraps = false,
		Crates = false,
		Safes = false
	}
}

local remotes = {
	OCmenukeybind = nil;
	fov_connection = nil;
	infstamina = nil;
	aimbot_circle = nil,
	aimbot_circlepos = nil,
	Speed_RUN = nil,
	Aimbot_body = nil,
	ChangeBind = nil,
}

function Decrypt(value)
	local result = ""
	for i = 1, value do
		result = result..string.char(math.random(120, 250))
	end
	return result
end

function Animate(Button, val, section)
	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local anim1 = tween:Create(Button, info, {Position = UDim2.new(0.6, 0, 0.071, 0)})
	local anim2 = tween:Create(Button, info, {Position = UDim2.new(0.53, 0, 0.071, 0)})
	local anim3 = tween:Create(Button, info, {Position = UDim2.new(0.046, 0, 0.071, 0)})
	if val == true then
		if section == true then
			anim2:Play()
			anim2.Completed:Wait()
			Button.BackgroundColor3 = Color3.new(0, 1, 0)
		else
			anim1:Play()
			anim1.Completed:Wait()
			Button.BackgroundColor3 = Color3.new(0, 1, 0)
		end
	else
		anim3:Play()
		anim3.Completed:Wait()
		Button.BackgroundColor3 = Color3.new(1, 0, 0)
	end
end

content:PreloadAsync({"rbxassetid://83501732181441"})

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Wecome to Ghost",
	Icon = "rbxassetid://83501732181441",
	Text = "Join to discord \n https://discord.gg/5XAn83XFJP",
	Duration = 10
})

local Gui = Instance.new("ScreenGui")
local s, e = pcall(function() Gui.Parent = game.CoreGui end) if not s then Gui.Parent = me.PlayerGui end
Gui.Name = Decrypt(10)
Gui.Enabled = true
Gui.ResetOnSpawn = false

local dragg = Instance.new("Frame")
dragg.Parent = Gui
dragg.Name = "dragg"
dragg.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
dragg.Position = UDim2.new(0.372, 0, 0.15, 0)
dragg.Size = UDim2.new(0, 405, 0, 19)
dragg.Visible = true

uicdragg = Instance.new("UICorner")
uicdragg.Parent = dragg
uicdragg.CornerRadius = UDim.new(0, 8)

uisdragg = Instance.new("UIStroke")
uisdragg.Parent = dragg
uisdragg.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisdragg.Color = Color3.new(1, 1, 1)
uisdragg.LineJoinMode = Enum.LineJoinMode.Round
uisdragg.Thickness = 1

uiscdragg = Instance.new("UIScale")
uiscdragg.Parent = dragg
uiscdragg.Scale = 1

local mainframe = Instance.new("Frame")
mainframe.Parent = dragg
mainframe.Name = "Main"
mainframe.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
mainframe.Position = UDim2.new(-0.602, 0, 1.055, 0)
mainframe.Size = UDim2.new(0, 986, 0, 610)
mainframe.Visible = true

uicmf = Instance.new("UICorner")
uicmf.Parent = mainframe
uicmf.CornerRadius = UDim.new(0, 8)

uiscmf = Instance.new("UIScale")
uiscmf.Parent = mainframe
uiscmf.Scale = 0.8

uistmf = Instance.new("UIStroke")
uistmf.Parent = mainframe
uistmf.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
uistmf.Color = Color3.new(1, 1, 1)
uistmf.LineJoinMode = Enum.LineJoinMode.Round
uistmf.Thickness = 2
uistmf.Transparency = 0
uistmf.Enabled = true

uigmf = Instance.new("UIGradient")
uigmf.Parent = mainframe
uigmf.Rotation = 40
uigmf.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0.117647, 0.117647, 0.117647)),
	ColorSequenceKeypoint.new(0.824, Color3.new(0.886275, 0.886275, 0.886275)),
	ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
})

local list = Instance.new("Frame")
list.Parent = mainframe
list.Name = "List"
list.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
list.Position = UDim2.new(0, 0, 0, 0)
list.Size = UDim2.new(0, 197, 0, 609)
list.Visible = true

uiclist = Instance.new("UICorner")
uiclist.Parent = list
uiclist.CornerRadius = UDim.new(0, 8)

uistlist = Instance.new("UIStroke")
uistlist.Parent = list
uistlist.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
uistlist.Color = Color3.new(1, 1, 1)
uistlist.LineJoinMode = Enum.LineJoinMode.Round
uistlist.Thickness = 2
uistlist.Transparency = 0
uistlist.Enabled = true

uiglist = Instance.new("UIGradient")
uiglist.Parent = list
uiglist.Rotation = 0
uiglist.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
	ColorSequenceKeypoint.new(0.6, Color3.new(0.207843, 0.207843, 0.207843)),
	ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
})

uillist = Instance.new("UIListLayout")
uillist.Parent = list
uillist.Padding = UDim.new(0, 15)
uillist.FillDirection = Enum.FillDirection.Vertical
uillist.SortOrder = Enum.SortOrder.LayoutOrder
uillist.HorizontalAlignment = Enum.HorizontalAlignment.Left
uillist.HorizontalFlex = Enum.UIFlexAlignment.None
uillist.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
uillist.VerticalAlignment = Enum.VerticalAlignment.Top
uillist.VerticalFlex = Enum.UIFlexAlignment.None

uiplist = Instance.new("UIPadding")
uiplist.Parent = list
uiplist.PaddingBottom = UDim.new(0, 0)
uiplist.PaddingLeft = UDim.new(0, 10)
uiplist.PaddingRight = UDim.new(0, 0)
uiplist.PaddingTop = UDim.new(0, 10)

local Menus = Instance.new("Folder")
Menus.Parent = mainframe
Menus.Name = "Menus"

local MenuWhite = Instance.new("Frame")
MenuWhite.Parent = Gui
MenuWhite.Name = "Menu"
MenuWhite.BackgroundTransparency = 1
MenuWhite.Position = UDim2.new(0.338, 0, 0.316, 0)
MenuWhite.Size = UDim2.new(0.324, 0, 0.367, 0)
MenuWhite.Visible = false

local HideButton = Instance.new("TextButton")
HideButton.Parent = MenuWhite
HideButton.Name = "Hide"
HideButton.BackgroundColor3 = Color3.new(0.0705882, 0.0705882, 0.0705882)
HideButton.Position = UDim2.new(0.902, 0, -0.334, 0)
HideButton.Size = UDim2.new(0, 30, 0, 30)
HideButton.TextScaled = true
HideButton.TextColor3 = Color3.new(1, 1, 1)
HideButton.Text = "X"
HideButton.Visible = true

local uichidebutton = Instance.new("UICorner")
uichidebutton.Parent = HideButton
uichidebutton.CornerRadius = UDim.new(0, 4)

local uishidebutton = Instance.new("UIStroke")
uishidebutton.Parent = HideButton
uishidebutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uishidebutton.Color = Color3.new(1, 0, 0)
uishidebutton.LineJoinMode = Enum.LineJoinMode.Round
uishidebutton.Thickness = 1

local Ghosts = Instance.new("ImageLabel")
Ghosts.Parent = MenuWhite
Ghosts.BackgroundColor3 = Color3.new(0, 0, 0)
Ghosts.Position = UDim2.new(0.029, 0, -0.184, 0)
Ghosts.Size = UDim2.new(0.94, 0, 1.633, 0)
Ghosts.Image = "rbxassetid://121742762213177"
Ghosts.ImageColor3 = Color3.new(0.478, 0.478, 0.478)
Ghosts.ImageTransparency = 0.9

local uicghosts = Instance.new("UICorner")
uicghosts.CornerRadius = UDim.new(0, 4)
uicghosts.Parent = Ghosts

local uisghosts = Instance.new("UIStroke")
uisghosts.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisghosts.Color = Color3.new(0, 0, 0)
uisghosts.Thickness = 6
uisghosts.Transparency = 0.4
uisghosts.Parent = Ghosts

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = Ghosts
scroll.BackgroundTransparency = 1
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 10, 0)

local uilscroll = Instance.new("UIListLayout")
uilscroll.Parent = scroll
uilscroll.Padding = UDim.new(0, 30)
uilscroll.HorizontalAlignment = Enum.HorizontalAlignment.Center

local uipscroll = Instance.new("UIPadding")
uipscroll.PaddingTop = UDim.new(0, 15)
uipscroll.Parent = scroll

function Library()
	local Tabs = {}
	local Functions = {}

	function Tabs:MakeTab(Name)
		local TabButton = Instance.new("TextButton")
		TabButton.Parent = list
		TabButton.Name = Name
		TabButton.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
		TabButton.Size = UDim2.new(0, 176, 0, 38)
		TabButton.TextColor3 = Color3.new(1, 1, 1)
		TabButton.TextScaled = true
		TabButton.Text = Name
		TabButton.Visible = true

		local uictabbutton = Instance.new("UICorner")
		uictabbutton.Parent = TabButton
		uictabbutton.CornerRadius = UDim.new(0, 25)

		local uistabbutton = Instance.new("UIStroke")
		uistabbutton.Parent = TabButton
		uistabbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uistabbutton.Color = Color3.new(1, 1, 1)
		uistabbutton.LineJoinMode = Enum.LineJoinMode.Round
		uistabbutton.Thickness = 1

		local TabFrame = Instance.new("Frame")
		TabFrame.Parent = Menus
		TabFrame.Name = Name
		TabFrame.BackgroundTransparency = 1
		TabFrame.Position = UDim2.new(0.209, 0, 0.01, 0)
		TabFrame.Size = UDim2.new(0, 774, 0, 598)
		TabFrame.Visible = false

		TabButton.MouseButton1Click:Connect(function()
			for _, a in pairs(Menus:GetChildren()) do
				a.Visible = false
			end
			TabFrame.Visible = true
		end)
		return TabFrame
	end

	function Tabs:MakeScrollFrame(Parent)
		local ScrollFrame = Instance.new("ScrollingFrame")
		ScrollFrame.Parent = Parent
		ScrollFrame.BackgroundTransparency = 1
		ScrollFrame.Position = UDim2.new(0.008, 0, 0.01, 0)
		ScrollFrame.Size = UDim2.new(0, 761, 0, 590)
		ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
		ScrollFrame.ScrollBarImageColor3 = Color3.new(1, 1, 1)
		ScrollFrame.ScrollBarThickness = 7
		ScrollFrame.Visible = true
		return ScrollFrame
	end

	function Functions:MakeTextButton(Parent, Name, Text, Position, TYPE, TYPENAME, func)
		local ButtonText = Instance.new("TextLabel")
		ButtonText.Parent = Parent
		ButtonText.Name = Name
		ButtonText.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
		if Position then ButtonText.Position = Position end
		ButtonText.Size = UDim2.new(0, 194, 0, 32)
		ButtonText.TextColor3 = Color3.new(1, 1, 1)
		ButtonText.TextScaled = true
		ButtonText.Text = Text
		ButtonText.Visible = true

		local uicbuttontext = Instance.new("UICorner")
		uicbuttontext.Parent = ButtonText
		uicbuttontext.CornerRadius = UDim.new(0, 8)

		local ButtonTextControl = Instance.new("Frame")
		ButtonTextControl.Parent = ButtonText
		ButtonTextControl.Name = "Control"
		ButtonTextControl.BackgroundColor3 = Color3.new(0, 0, 0)
		ButtonTextControl.Position = UDim2.new(1.129, 0, 0, 0)
		ButtonTextControl.Size = UDim2.new(0, 81, 0, 35)
		ButtonTextControl.Visible = true

		local uicbuttontextcontrol = Instance.new("UICorner")
		uicbuttontextcontrol.Parent = ButtonTextControl
		uicbuttontextcontrol.CornerRadius = UDim.new(8, 8)

		local uisbuttontextcontrol = Instance.new("UIStroke")
		uisbuttontextcontrol.Parent = ButtonTextControl
		uisbuttontextcontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uisbuttontextcontrol.Color = Color3.new(1, 1, 1)
		uisbuttontextcontrol.LineJoinMode = Enum.LineJoinMode.Round
		uisbuttontextcontrol.Thickness = 1

		local TextButton = Instance.new("TextButton")
		TextButton.Parent = ButtonTextControl
		TextButton.Name = "turn"
		TextButton.BackgroundColor3 = Color3.new(1, 0, 0)
		TextButton.Position = UDim2.new(0.046, 0, 0.071, 0)
		TextButton.Size = UDim2.new(0, 30, 0, 30)
		TextButton.Text = ""
		TextButton.Visible = true

		local uictextbutton = Instance.new("UICorner")
		uictextbutton.Parent = TextButton
		uictextbutton.CornerRadius = UDim.new(8, 8)

		local uistextbutton = Instance.new("UIStroke")
		uistextbutton.Parent = TextButton
		uistextbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uistextbutton.Color = Color3.new(1, 1, 1)
		uistextbutton.LineJoinMode = Enum.LineJoinMode.Round
		uistextbutton.Thickness = 1

		TextButton.MouseButton1Click:Connect(function()
			if TYPE[TYPENAME] == true then
				TYPE[TYPENAME] = false
				Animate(TextButton, TYPE[TYPENAME], false)
			elseif TYPE[TYPENAME] == false then
				TYPE[TYPENAME] = true
				Animate(TextButton, TYPE[TYPENAME], false)
			elseif TYPE[TYPENAME] == nil then
			end
			if func then
				func()
			end
		end)

		return TextButton
	end

	function Functions:MakeSlider(Parent, Name, Text, Position, minimal, maximal, func)
		local SliderText = Instance.new("TextLabel")
		SliderText.Parent= Parent
		SliderText.Name = Name
		SliderText.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
		if Position then SliderText.Position = Position end
		SliderText.Size = UDim2.new(0, 194, 0, 32)
		SliderText.TextColor3 = Color3.new(1, 1, 1)
		SliderText.TextScaled = true
		SliderText.Text = Text
		SliderText.Visible = true

		local uicslidertext = Instance.new("UICorner")
		uicslidertext.Parent = SliderText
		uicslidertext.CornerRadius = UDim.new(0, 8)

		local SliderControl = Instance.new("Frame")
		SliderControl.Parent = SliderText
		SliderControl.Name = "control"
		SliderControl.BackgroundColor3 = Color3.new(1, 1, 1)
		SliderControl.Position = UDim2.new(1.151, 0, 0.099, 0)
		SliderControl.Size = UDim2.new(0, 272, 0, 25)
		SliderControl.Visible = true

		local uicslidercontrol = Instance.new("UICorner")
		uicslidercontrol.Parent = SliderControl
		uicslidercontrol.CornerRadius = UDim.new(8, 8)

		local uisslidercontrol = Instance.new("UIStroke")
		uisslidercontrol.Parent = SliderControl
		uisslidercontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uisslidercontrol.Color = Color3.new(0, 0, 0)
		uisslidercontrol.LineJoinMode = Enum.LineJoinMode.Round
		uisslidercontrol.Thickness = 2.4

		local SlideButton = Instance.new("TextButton")
		SlideButton.Parent = SliderControl
		SlideButton.Name = "slide"
		SlideButton.BackgroundColor3 = Color3.new(0.235294, 0.235294, 0.235294)
		SlideButton.Position = UDim2.new(-0, 0, 0, 0)
		SlideButton.Size = UDim2.new(0, 199, 0, 25)
		SlideButton.Text = ""
		SlideButton.Visible = true

		local uicslidebutton = Instance.new("UICorner")
		uicslidebutton.Parent = SlideButton
		uicslidebutton.CornerRadius = UDim.new(8, 8)

		local mine = 0.08 * SliderControl.AbsoluteSize.X
		local maxe = SliderControl.AbsoluteSize.X

		local MIN = minimal
		local MAX = maximal

		local activated = false

		SlideButton.MouseButton1Down:Connect(function()
			activated = true
		end)

		input.InputEnded:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				activated = false
			end
		end)

		input.InputChanged:Connect(function(key)
			if activated and key.UserInputType == Enum.UserInputType.MouseMovement then  
				local mousepos = input:GetMouseLocation().X
				local resize = math.clamp(mousepos - SliderControl.AbsolutePosition.X, mine, maxe)
				local scale = resize / SliderControl.AbsoluteSize.X
				SlideButton.Size = UDim2.new(scale, 0, SliderControl.Size.Y.Scale, SliderControl.Size.Y.Offset)
				local progress = (resize - mine) / (maxe - mine)
				local funct
				if minimal > maximal then
					funct = math.clamp(MIN + (progress * (MAX - MIN)), MAX, MIN)
				else
					funct = math.clamp(MIN + (progress * (MAX - MIN)), MIN, MAX)
				end
				func(funct)
			end
		end)

		return SlideButton
	end

	function Functions:MakeSection(Parent, Position, Size)
		local Section = Instance.new("Frame")
		Section.Parent = Parent
		Section.Name = "Section"
		Section.BackgroundColor3 = Color3.new(0.0823529, 0.0823529, 0.0823529)
		Section.Position = Position
		Section.Size = Size
		Section.Visible = true

		local uicsection = Instance.new("UICorner")
		uicsection.Parent = Section
		uicsection.CornerRadius = UDim.new(0, 5)

		local uissection = Instance.new("UIStroke")
		uissection.Parent = Section
		uissection.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uissection.Color = Color3.new(1, 1, 1)
		uissection.LineJoinMode = Enum.LineJoinMode.Round
		uissection.Thickness = 1
		return Section
	end

	function Functions:MakeSectionButton(Parent, Name, Text, Position, Size, TYPE, TYPENAME, FUnc)
		local SectionButton = Instance.new("TextLabel")
		SectionButton.Parent = Parent
		SectionButton.Name = Name
		SectionButton.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
		SectionButton.Position = Position
		SectionButton.Size = Size
		SectionButton.TextColor3 = Color3.new(1, 1, 1)
		SectionButton.TextScaled = true
		SectionButton.Text = Text
		SectionButton.Visible = true

		local uicsectionbutton = Instance.new("UICorner")
		uicsectionbutton.Parent = SectionButton
		uicsectionbutton.CornerRadius = UDim.new(0, 8)

		local SectionButtonControl = Instance.new("Frame")
		SectionButtonControl.Parent = SectionButton
		SectionButtonControl.Name = "Control"
		SectionButtonControl.BackgroundColor3 = Color3.new(0, 0, 0)
		SectionButtonControl.Position = UDim2.new(1.1, 0, 0, 0)
		SectionButtonControl.Size = UDim2.new(0, 70, 0, 35)
		SectionButtonControl.Visible = true

		local uicsectionbuttoncontrol = Instance.new("UICorner")
		uicsectionbuttoncontrol.Parent = SectionButtonControl
		uicsectionbuttoncontrol.CornerRadius = UDim.new(8, 8)

		local uissectionbuttoncontrol = Instance.new("UIStroke")
		uissectionbuttoncontrol.Parent = SectionButtonControl
		uissectionbuttoncontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uissectionbuttoncontrol.Color = Color3.new(1, 1, 1)
		uissectionbuttoncontrol.LineJoinMode = Enum.LineJoinMode.Round
		uissectionbuttoncontrol.Thickness = 1

		local SectionButtonTurn = Instance.new("TextButton")
		SectionButtonTurn.Parent = SectionButtonControl
		SectionButtonTurn.Name = "turn"
		SectionButtonTurn.BackgroundColor3 = Color3.new(1, 0, 0)
		SectionButtonTurn.Position = UDim2.new(0.046, 0, 0.071, 0)
		SectionButtonTurn.Size = UDim2.new(0, 30, 0, 30)
		SectionButtonTurn.Text = ""
		SectionButtonTurn.Visible = true

		local uicsectionbuttonturn = Instance.new("UICorner")
		uicsectionbuttonturn.Parent = SectionButtonTurn
		uicsectionbuttonturn.CornerRadius = UDim.new(8, 8)

		local uissectionbuttonturn = Instance.new("UIStroke")
		uissectionbuttonturn.Parent= SectionButtonTurn
		uissectionbuttonturn.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uissectionbuttonturn.Color = Color3.new(1, 1, 1)
		uissectionbuttonturn.LineJoinMode = Enum.LineJoinMode.Round
		uissectionbuttonturn.Thickness = 1

		SectionButtonTurn.MouseButton1Click:Connect(function()
			if TYPE[TYPENAME] == true then
				TYPE[TYPENAME] = false
				Animate(SectionButtonTurn, TYPE[TYPENAME], true)
			elseif TYPE[TYPENAME] == false then
				TYPE[TYPENAME] = true
				Animate(SectionButtonTurn, TYPE[TYPENAME], true)
			elseif TYPE[TYPENAME] == nil then
			end
			if FUnc then
				FUnc()
			end
		end)

		return SectionButtonTurn
	end

	function Functions:MakeSectionCheckButton(Parent, Name, Text, Position, TYPE, TYPENAME, slider, SliderText, SliderPosition, startertext, minimal, maximal, FUNC)
		local SectionCheckText = Instance.new("TextLabel")
		SectionCheckText.Parent = Parent
		SectionCheckText.Name = Name
		SectionCheckText.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
		SectionCheckText.Position = Position
		SectionCheckText.Size = UDim2.new(0, 160, 0, 32)
		SectionCheckText.TextColor3 = Color3.new(1, 1, 1)
		SectionCheckText.TextScaled = true
		SectionCheckText.Text = Text
		SectionCheckText.Visible = true

		local uicsectionchecktext = Instance.new("UICorner")
		uicsectionchecktext.Parent = SectionCheckText
		uicsectionchecktext.CornerRadius = UDim.new(0, 8)

		local SectionCheckButton = Instance.new("TextButton")
		SectionCheckButton.Parent = SectionCheckText
		SectionCheckButton.Name = "Check"
		SectionCheckButton.BackgroundColor3 = Color3.new(0, 0, 0)
		SectionCheckButton.Position = UDim2.new(1.117, 0, 0, 0)
		SectionCheckButton.Size = UDim2.new(0, 32, 0, 32)
		SectionCheckButton.Text = ""
		SectionCheckButton.Visible = true

		local uicsectioncheckbutton = Instance.new("UICorner")
		uicsectioncheckbutton.Parent = SectionCheckButton
		uicsectioncheckbutton.CornerRadius = UDim.new(0, 5)

		local uissectioncheckbutton = Instance.new("UIStroke")
		uissectioncheckbutton.Parent = SectionCheckButton
		uissectioncheckbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uissectioncheckbutton.Color = Color3.new(1, 1, 1)
		uissectioncheckbutton.LineJoinMode = Enum.LineJoinMode.Round
		uissectioncheckbutton.Thickness = 1

		local SectionCheckImage = Instance.new("ImageLabel")
		SectionCheckImage.Parent = SectionCheckButton
		SectionCheckImage.Name = "Check"
		SectionCheckImage.BackgroundTransparency = 1
		SectionCheckImage.Position = UDim2.new(0, 0, 0, 0)
		SectionCheckImage.Size = UDim2.new(0, 32, 0, 32)
		SectionCheckImage.Image = "rbxassetid://6218581738"
		SectionCheckImage.Visible = false

		SectionCheckButton.MouseButton1Click:Connect(function()
			if TYPE[TYPENAME] == true then
				TYPE[TYPENAME] = false
				SectionCheckImage.Visible = TYPE[TYPENAME]
			elseif TYPE[TYPENAME] == false then
				TYPE[TYPENAME] = true
				SectionCheckImage.Visible = TYPE[TYPENAME]
			end
		end)

		if slider  and SliderText ~= "" and SliderPosition ~= nil and minimal ~= nil and maximal ~= nil then
			local SectionSlider = Instance.new("TextLabel")
			SectionSlider.Parent = SectionCheckText
			SectionSlider.Name = "slide"
			SectionSlider.BackgroundTransparency = 1
			SectionSlider.Position = SliderPosition
			SectionSlider.Size = UDim2.new(0, 100, 0, 32)
			SectionSlider.TextColor3 = Color3.new(1, 1, 1)
			SectionSlider.TextScaled = true
			SectionSlider.Text = SliderText
			SectionSlider.Visible = true

			local SectionSliderControl = Instance.new("Frame")
			SectionSliderControl.Parent = SectionSlider
			SectionSliderControl.BackgroundColor3 = Color3.new(1, 1, 1)
			SectionSliderControl.Position = UDim2.new(1, 0, 0.194, 0)
			SectionSliderControl.Size = UDim2.new(0, 141, 0, 25)
			SectionSliderControl.Visible = true

			local uicsectionslidercontrol = Instance.new("UICorner")
			uicsectionslidercontrol.Parent = SectionSliderControl
			uicsectionslidercontrol.CornerRadius = UDim.new(8, 8)

			local uissectionslidercontrol = Instance.new("UIStroke")
			uissectionslidercontrol.Parent = SectionSliderControl
			uissectionslidercontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uissectionslidercontrol.Color = Color3.new(0, 0, 0)
			uissectionslidercontrol.LineJoinMode = Enum.LineJoinMode.Round
			uissectionslidercontrol.Thickness = 1

			local SectionSliderButton = Instance.new("TextButton")
			SectionSliderButton.Parent = SectionSliderControl
			SectionSliderButton.Name = "slider"
			SectionSliderButton.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
			SectionSliderButton.Position = UDim2.new(0, 0, 0, 0)
			SectionSliderButton.Size = UDim2.new(0, 50, 0, 25)
			SectionSliderButton.Text = ""
			SectionSliderButton.Visible = true

			local uicsectionsliderbutton = Instance.new("UICorner")
			uicsectionsliderbutton.Parent = SectionSliderButton
			uicsectionsliderbutton.CornerRadius = UDim.new(8, 8)

			local VALUE = Instance.new("TextLabel")
			VALUE.Parent = SectionSlider
			VALUE.Name = SliderText
			VALUE.BackgroundTransparency = 1
			VALUE.Position = UDim2.new(2.475, 0, 0.156, 0)
			VALUE.Size = UDim2.new(0, 35, 0, 29)
			VALUE.TextScaled = true
			VALUE.TextColor3 = Color3.new(1, 1, 1)
			VALUE.Text = startertext

			local minim = minimal
			local maxim = maximal

			local canuse = false

			SectionSliderButton.MouseButton1Down:Connect(function()
				canuse = true
			end)

			input.InputEnded:Connect(function(key)
				if key.UserInputType == Enum.UserInputType.MouseButton1 then
					canuse = false
				end
			end)

			input.InputChanged:Connect(function(key)
				if canuse and key.UserInputType == Enum.UserInputType.MouseMovement then
					local mpos = input:GetMouseLocation().X
					local scale = (mpos - SectionSliderControl.AbsolutePosition.X)/SectionSliderControl.AbsoluteSize.X
					local clamp = math.clamp(scale, 0.08, 1)
					local value
					SectionSliderButton.Size = UDim2.fromScale(clamp, 1)
					value = math.clamp(minimal + (scale * (maximal - minimal)), minimal, maximal)
					FUNC(value)
					if value < 10 then
						VALUE.Text = string.format("%.2f", value)
					else
						VALUE.Text = math.floor(value)
					end
				end
			end)
		end
		return SectionCheckImage
	end

	function Functions:MakeSectionClickButton(Parent, Name, Text, Position, Size, func)
		local SectionClickText = Instance.new("TextLabel")
		SectionClickText.Parent = Parent
		SectionClickText.Name = Name
		SectionClickText.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
		SectionClickText.Position = Position
		SectionClickText.Size = Size
		SectionClickText.TextColor3 = Color3.new(1, 1, 1)
		SectionClickText.TextScaled = true
		SectionClickText.Text = Text
		SectionClickText.Visible = true

		local uicsectionclicktext = Instance.new("UICorner")
		uicsectionclicktext.Parent = SectionClickText
		uicsectionclicktext.CornerRadius = UDim.new(0, 8)

		local SectionClickButton = Instance.new("ImageButton")
		SectionClickButton.Parent = SectionClickText
		SectionClickButton.BackgroundTransparency = 1
		SectionClickButton.Position = UDim2.new(1.117, 0, 0.039, 0)
		SectionClickButton.Size = UDim2.new(0, 30, 0, 30)
		SectionClickButton.Image = "rbxassetid://2769398451"
		SectionClickButton.Visible = true

		SectionClickButton.MouseButton1Click:Connect(function()
			if func then
				func()
			end
		end)

		return SectionClickButton
	end

	function Functions:MakeSectionSlider(Parent, Text, Position, min, max, startertext, Func)
		local SliderText = Instance.new("TextLabel")
		SliderText.Parent = Parent
		SliderText.Name = "Slider"
		SliderText.BackgroundTransparency = 1
		SliderText.Position = Position
		SliderText.Size = UDim2.new(0, 100, 0, 32)
		SliderText.TextColor3 = Color3.new(1, 1, 1)
		SliderText.TextScaled = true
		SliderText.Text = Text
		SliderText.Visible = true

		local SliderControl = Instance.new("Frame")
		SliderControl.Parent = SliderText
		SliderControl.Name = "Control"
		SliderControl.BackgroundColor3 = Color3.new(1, 1, 1)
		SliderControl.Position = UDim2.new(1.075, 0, 0.155, 0)
		SliderControl.Size = UDim2.new(0, 141, 0, 25)
		SliderControl.Visible = true

		local uicslidercontrol = Instance.new("UICorner")
		uicslidercontrol.Parent = SliderControl
		uicslidercontrol.CornerRadius = UDim.new(8, 8)

		local uisslidercontrol = Instance.new("UIStroke")
		uisslidercontrol.Parent = SliderControl
		uisslidercontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uisslidercontrol.Color = Color3.new(0, 0, 0)
		uisslidercontrol.LineJoinMode = Enum.LineJoinMode.Round
		uisslidercontrol.Thickness = 1

		local SliderButton = Instance.new("TextButton")
		SliderButton.Parent = SliderControl
		SliderButton.Name = "slide"
		SliderButton.BackgroundColor3 = Color3.new(0.380392, 0.380392, 0.380392)
		SliderButton.Position = UDim2.new(0, 0, 0, 0)
		SliderButton.Size = UDim2.new(0, 50, 0, 25)
		SliderButton.Text = ""
		SliderButton.Visible = true

		local uicsliderbutton = Instance.new("UICorner")
		uicsliderbutton.Parent = SliderButton
		uicsliderbutton.CornerRadius = UDim.new(8, 8)

		local VALUE = Instance.new("TextLabel")
		VALUE.Parent = SliderText
		VALUE.Name = Text
		VALUE.BackgroundTransparency = 1
		VALUE.Position = UDim2.new(2.488, 0, 0.078, 0)
		VALUE.Size = UDim2.new(0, 35, 0, 29)
		VALUE.TextScaled = true
		VALUE.TextColor3 = Color3.new(1, 1, 1)
		VALUE.Text = startertext

		local slide = false

		SliderButton.MouseButton1Down:Connect(function()
			slide = true
		end)

		input.InputEnded:Connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 then
				slide = false
			end
		end)

		input.InputChanged:Connect(function(key)
			if slide and key.UserInputType == Enum.UserInputType.MouseMovement then
				local mpos = input:GetMouseLocation().X
				local fullProgress = (mpos - SliderControl.AbsolutePosition.X) / SliderControl.AbsoluteSize.X
				local resize = math.clamp(fullProgress, 0.08, 1)

				local progress = math.clamp(fullProgress, 0, 1)
				SliderButton.Size = UDim2.fromScale(resize, 1)

				local value = math.clamp(min + (progress * (max - min)), min, max)
				VALUE.Text = math.floor(value)
				Func(math.floor(value))
			end
		end)

		return SliderButton
	end

	function Functions:MakeBodySelector(func)
		local Body = Instance.new("Frame")
		Body.Parent = Gui
		Body.Name = "Body"
		Body.BackgroundColor3 = Color3.new(0, 0, 0)
		Body.Position = UDim2.new(0.715, 0, 0.131, 0)
		Body.Size = UDim2.new(0.3, 0, 0.3, 0)
		Body.Visible = true

		local uiabody = Instance.new("UIAspectRatioConstraint")
		uiabody.Parent = Body
		uiabody.AspectRatio = 1
		uiabody.AspectType = Enum.AspectType.FitWithinMaxSize
		uiabody.DominantAxis = Enum.DominantAxis.Width

		local Head = Instance.new("TextButton")
		Head.Parent = Body
		Head.Name = "Head"
		Head.BackgroundColor3 = Color3.new(1,1 , 1)
		Head.BorderColor3 = Color3.new(0, 0, 0)
		Head.BorderSizePixel = 2
		Head.Position = UDim2.new(0.394, 0, 0.055, 0)
		Head.Size = UDim2.new(0.203, 0, 0.203, 0)
		Head.Text = ""
		Head.Visible = true

		local Torso = Instance.new("TextButton")
		Torso.Parent = Body
		Torso.Name = "Torso"
		Torso.Position = UDim2.new(0.321, 0, 0.261, 0)
		Torso.Size = UDim2.new(0.344, 0, 0.344, 0)
		Torso.BackgroundColor3 = Color3.new(1, 1, 1)
		Torso.BorderColor3 = Color3.new(0, 0, 0)
		Torso.BorderSizePixel = 1
		Torso.Text = ""
		Torso.Visible = true

		local LeftArm = Instance.new("TextButton")
		LeftArm.Parent = Body
		LeftArm.Name = "LeftArm"
		LeftArm.BackgroundColor3 = Color3.new(1,1 , 1)
		LeftArm.Position = UDim2.new(0.665, 0, 0.261, 0)
		LeftArm.Size = UDim2.new(0.172, 0, 0.344, 0)
		LeftArm.Text = ""
		LeftArm.Visible = true

		local RightArm = Instance.new("TextButton")
		RightArm.Parent = Body
		RightArm.Name = "RightArm"
		RightArm.BackgroundColor3 = Color3.new(1, 1, 1)
		RightArm.Position = UDim2.new(0.147, 0, 0.261, 0)
		RightArm.Size = UDim2.new(0.172, 0, 0.344, 0)
		RightArm.Text = ""
		RightArm.Visible = true

		local LeftLeg = Instance.new("TextButton")
		LeftLeg.Parent = Body
		LeftLeg.Name = "LeftLeg"
		LeftLeg.BackgroundColor3 = Color3.new(1, 1, 1)
		LeftLeg.Position = UDim2.new(0.5, 0, 0.605, 0)
		LeftLeg.Size = UDim2.new(0.172, 0, 0.344, 0)
		LeftLeg.Text = ""
		LeftLeg.Visible = true

		local RightLeg = Instance.new("TextButton")
		RightLeg.Parent = Body
		RightLeg.Name = "RightLeg"
		RightLeg.BackgroundColor3 = Color3.new(1, 1, 1)
		RightLeg.Position = UDim2.new(0.321, 0, 0.605, 0)
		RightLeg.Size = UDim2.new(0.163, 0, 0.344, 0)
		RightLeg.Text = ""
		RightLeg.Visible = true

		local check1 = table.find(func, "Head")
		local check2 = table.find(func, "Torso")
		local check3 = table.find(func, "Left Arm")
		local check4 = table.find(func, "Right Arm")
		local check5 = table.find(func, "Left Leg")
		local check6 = table.find(func, "Right Leg")

		if check1 then
			Head.BackgroundColor3 = Color3.new(0.0666667, 1, 0)
		end

		if check2 then
			Torso.BackgroundColor3 = Color3.new(0, 1, 0.0313725)
		end

		if check3 then
			LeftArm.BackgroundColor3 = Color3.new(0.0666667, 1, 0)
		end

		if check4 then
			RightArm.BackgroundColor3 = Color3.new(0.133333, 1, 0)
		end

		if check5 then
			LeftLeg.BackgroundColor3 = Color3.new(0.101961, 1, 0)
		end

		if check6 then
			RightLeg.BackgroundColor3 = Color3.new(0.0156863, 1, 0)
		end

		Head.MouseButton1Click:Connect(function()
			local check = table.find(func, "Head")
			if not check then
				table.insert(func, "Head")
				Head.BackgroundColor3 = Color3.new(0.0509804, 1, 0)
			else
				table.remove(func, check)
				Head.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		Torso.MouseButton1Click:Connect(function()
			local check = table.find(func, "Torso")
			if not check then
				table.insert(func, "Torso")
				Torso.BackgroundColor3 = Color3.new(0.0666667, 1, 0)
			else
				table.remove(func, check)
				Torso.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		LeftArm.MouseButton1Click:Connect(function()
			local check = table.find(func, "Left Arm")
			if not check then
				table.insert(func, "Left Arm")
				LeftArm.BackgroundColor3 = Color3.new(0, 1, 0.0666667)
			else
				table.remove(func, check)
				LeftArm.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		RightArm.MouseButton1Click:Connect(function()
			local check = table.find(func, "Right Arm")
			if not check then
				table.insert(func, "Right Arm")
				RightArm.BackgroundColor3 = Color3.new(0, 1, 0.0823529)
			else
				table.remove(func, check)
				RightArm.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		LeftLeg.MouseButton1Click:Connect(function()
			local check = table.find(func, "Left Leg")
			if not check then
				table.insert(func, "Left Leg")
				LeftLeg.BackgroundColor3 = Color3.new(0, 1, 0.0666667)
			else
				table.remove(func, check)
				LeftLeg.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		RightLeg.MouseButton1Click:Connect(function()
			local check = table.find(func, "Right Leg")
			if not check then
				table.insert(func, "Right Leg")
				RightLeg.BackgroundColor3 = Color3.new(0.0156863, 1, 0)
			else
				table.remove(func, check)
				RightLeg.BackgroundColor3 = Color3.new(1, 1, 1)
			end
		end)

		return Body
	end

	function Functions:AddBind(Parent, pos, change, name)
		local bindframe = Instance.new("TextLabel")
		bindframe.Parent = Parent
		bindframe.Name = "Key"
		bindframe.BackgroundColor3 = Color3.new(0.105882, 0.105882, 0.105882)
		bindframe.Position = pos
		bindframe.Size = UDim2.new(0, 50, 0, 30)
		bindframe.TextScaled = true
		bindframe.TextColor3 = Color3.new(1, 1, 1)
		bindframe.Text = "None"

		local uicbinds = Instance.new("UICorner")
		uicbinds.Parent = bindframe
		uicbinds.CornerRadius = UDim.new(0, 8)

		local uisbinds = Instance.new("UIStroke")
		uisbinds.Parent = bindframe
		uisbinds.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uisbinds.Color = Color3.new(1, 1, 1)
		uisbinds.LineJoinMode = Enum.LineJoinMode.Round
		uisbinds.Thickness = 1

		bindframe.MouseEnter:Connect(function()
			remotes.ChangeBind = true
			input.InputBegan:Connect(function(key, procces)
				if not procces and remotes.ChangeBind and key.UserInputType == Enum.UserInputType.MouseButton1 then
					bindframe.Text = "..."
					local conncet
					conncet = input.InputBegan:Connect(function(key2)
						if not table.find(ignore_binds, key2.KeyCode) and not table.find(ignore_binds, key2.UserInputType) then
							change[name] = key2.KeyCode
							local setname = tostring(change[name]):gsub("Enum.KeyCode.", "")
							bindframe.Text = setname
							conncet:Disconnect()
						end
					end)
				end
			end)
		end)

		bindframe.MouseLeave:Connect(function()
			remotes.ChangeBind = false
			local setname = tostring(change[name]):gsub("Enum.KeyCode.", "")
			bindframe.Text = setname
		end)

		return bindframe
	end

	return {Tabs = Tabs, Functions = Functions}
end

local library = Library()
local Tab = library.Tabs
local Functions = library.Functions

local WorldMenu = Tab:MakeTab("World")
WorldMenu.Visible = true
local PlayerMenu = Tab:MakeTab("Player")
local MainMenu = Tab:MakeTab("Main")
local MainScroll = Tab:MakeScrollFrame(MainMenu)
local VisualMenu = Tab:MakeTab("Visual")
local FarmMenu = Tab:MakeTab("Farm")
local SettingsMenu = Tab:MakeTab("Settings")

local SECTION1 = Functions:MakeSection(MainScroll, UDim2.new(0.016, 0, 0.001, 0), UDim2.new(0, 300, 0, 350))
local SECTION2 = Functions:MakeSection(MainScroll, UDim2.new(0.532, 0, 0.001, 0), UDim2.new(0, 300, 0, 470))
local SECTION3 = Functions:MakeSection(MainScroll, UDim2.new(0.531, 0, 0.52, 0), UDim2.new(0, 300, 0, 110))
local SECTION4 = Functions:MakeSection(MainScroll, UDim2.new(0.015, 0, 0.317, 0), UDim2.new(0, 300, 0, 300))
local SECTION5 = Functions:MakeSection(MainScroll, UDim2.new(0.531, 0, 0.42, 0), UDim2.new(0, 300, 0, 100))
local SECTION6 = Functions:MakeSection(VisualMenu, UDim2.new(0.018, 0, 0.02, 0), UDim2.new(0, 300, 0, 455))

local FullbrightTurn = Functions:MakeTextButton(WorldMenu, "Fullbright", "Fullbright", UDim2.new(0.016, 0, 0.022, 0), functions, "FullbrightF", function()
	FullbrightL()
end)
local nobarriersTurn = Functions:MakeTextButton(WorldMenu, "nobarriers", "No barriers", UDim2.new(0.016, 0, 0.192, 0), functions, "nobarriersF", function()
	nobarriersL()
end)
local infstaminaTurn = Functions:MakeTextButton(PlayerMenu, "infstamina", "Inf stamina", UDim2.new(0.016, 0, 0.439, 0), functions, "infstaminaF", function()
	infstaminaL()
end)
local nofalldamageTurn = Functions:MakeTextButton(PlayerMenu, "nofalldamage", "No fall damage", UDim2.new(0.016, 0, 0.525, 0), functions, "nofalldamageF", function()
	nofalldamageL()
end)
local lockpickTurn = Functions:MakeTextButton(FarmMenu, "lockpick", "Lockpick", UDim2.new(0.016, 0, 0.022, 0), functions, "lockpickF", function()
	lockpickL()
end)
local infpepperTurn = Functions:MakeTextButton(MainScroll, "infpepper", "Inf pepper spray", UDim2.new(0.013, 0, 0.635, 0), functions, "infpepperF", function()
	infpepperL()
end)
local glassarmsTurn = Functions:MakeTextButton(VisualMenu, "glassarms", "Glass arms", UDim2.new(0.53, 0, 0.019, 0), functions, "glassarmsF", function()
	glassarmsL()
end)

--// aimbot in section \\--
local aimbotTurn = Functions:MakeSectionButton(SECTION2, "aimbot", "Aim bot", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "aimbotF", function()
	aimbotL()
end)
local aimbotdraw = Functions:MakeSectionCheckButton(SECTION2, "Draw", "Draw circle", UDim2.new(0.029, 0, 0.128, 0), SectionSettings.AimBot, "Draw", true, "Size", UDim2.new(0, 0, 1.367, 0), tonumber(SectionSettings.AimBot.DrawSize), 10, 300, function(val)
	SectionSettings.AimBot.DrawSize = val
	if remotes.aimbot_circle then
		remotes.aimbot_circle.Radius = val
	end
end)
local aimbottargetpart = Functions:MakeSectionClickButton(SECTION2, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.326, 0), UDim2.new(0, 160, 0, 32), function()
	if remotes.Aimbot_body then
		remotes.Aimbot_body:Destroy()
		remotes.Aimbot_body = nil
	else
		remotes.Aimbot_body = Functions:MakeBodySelector(SectionSettings.AimBot.TargetPart)
	end
end)
local aimbotcheckwall = Functions:MakeSectionCheckButton(SECTION2, "CheckWall", "Check wall", UDim2.new(0.025, 0, 0.43, 0), SectionSettings.AimBot, "CheckWall")
local aimbotcheckteam = Functions:MakeSectionCheckButton(SECTION2, "CheckTeam", "Check team", UDim2.new(0.025, 0, 0.525, 0), SectionSettings.AimBot, "CheckTeam")
local aimbotwhitelistcheck = Functions:MakeSectionCheckButton(SECTION2, "CheckList", "Check white list", UDim2.new(0.025, 0, 0.629, 0), SectionSettings.AimBot, "CheckWhiteList")
local aimbotsmooth = Functions:MakeSectionCheckButton(SECTION2, "Smooth", "Smooth", UDim2.new(0.025, 0, 0.735, 0), SectionSettings.AimBot, "Smooth", true, "Size", UDim2.new(0, 0, 1.367, 0), tonumber(SectionSettings.AimBot.SmoothSize), 0.1, 1, function(val)
	SectionSettings.AimBot.SmoothSize = val
end)
local aimbotvelocity = Functions:MakeSectionCheckButton(SECTION2, "Velocity", "Velocity", UDim2.new(0.029, 0, 0.915, 0), SectionSettings.AimBot, "Velocity")

--// rocket control in section \\--
local rocketcontrolTurn = Functions:MakeSectionButton(SECTION3, "RocketControl", "Rocket control", UDim2.new(0.03, 0, 0.136, 0), UDim2.new(0, 160, 0, 32), functions, "rocket_controlF", function()
	RocketControlL()
end)
local rocketcontrolspeed = Functions:MakeSectionSlider(SECTION3, "Speed", UDim2.new(0.029, 0, 0.53, 0), 10, 500, tonumber(SectionSettings.RocketControl.Speed), function(val)
	SectionSettings.RocketControl.Speed = val
end)

--// esp in section \\--
local espTurn = Functions:MakeSectionButton(SECTION6, "ESP", "ESP", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "EspF", function()
	EspL()
end)
local espName = Functions:MakeSectionCheckButton(SECTION6, "Name", "Name", UDim2.new(0.029, 0, 0.131, 0), SectionSettings.ESP, "Name", false, "", nil, nil, nil)
local espBox = Functions:MakeSectionCheckButton(SECTION6, "Box", "Box", UDim2.new(0.029, 0, 0.236, 0), SectionSettings.ESP, "Box", false, "", nil, nil, nil)
local espWeapon = Functions:MakeSectionCheckButton(SECTION6, "Weapon", "Weapon", UDim2.new(0.029, 0, 0.344, 0), SectionSettings.ESP, "Weapon", false, "", nil, nil, nil)
local espChams = Functions:MakeSectionCheckButton(SECTION6, "Chams", "Chams", UDim2.new(0.029, 0, 0.449, 0), SectionSettings.ESP, "Chams", false, "", nil, nil, nil)
local espTeamCheck = Functions:MakeSectionCheckButton(SECTION6, "CheckTeam", "Team check", UDim2.new(0.029, 0, 0.569, 0), SectionSettings.ESP, "CheckTeam", false, "", nil, nil, nil)
local espScraps = Functions:MakeSectionCheckButton(SECTION6, "Scraps", "Scraps", UDim2.new(0.029, 0, 0.685, 0), SectionSettings.ESP, "Scraps", false, "", nil, nil, nil)
local espCrates = Functions:MakeSectionCheckButton(SECTION6, "Crates", "Crates", UDim2.new(0.029, 0, 0.798, 0), SectionSettings.ESP, "Crates", false, "", nil, nil, nil)
local espSafes = Functions:MakeSectionCheckButton(SECTION6, "Safes", "Safes", UDim2.new(0.029, 0, 0.916, 0), SectionSettings.ESP, "Safes", false, "", nil, nil, nil)

local FOV = Functions:MakeSlider(PlayerMenu, "fov", "FOV", UDim2.new(0.016, 0, 0.022, 0), 70, 120, function(value)
	if remotes.fov_connection then
		remotes.fov_connection:Disconnect()
	end
	remotes.fov_connection = run.RenderStepped:Connect(function()
		camera.FieldOfView = value
	end)
end)

local CameraDist = Functions:MakeSlider(PlayerMenu, "CameraDist", "Camera distance", UDim2.new(0.016, 0, 0.105, 0), 10, 50, function(value)
	me.CameraMaxZoomDistance = value
end)

local speed = Functions:MakeSlider(PlayerMenu, "Speed", "Speed", UDim2.new(0.016, 0, 0.184, 0), 0, 0.7, function(value)
	if remotes.Speed_RUN then
		remotes.Speed_RUN:Disconnect()
		remotes.Speed_RUN = nil
	end
	remotes.Speed_RUN = run.RenderStepped:Connect(function(delta)
		local char = me.Character
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not char or not hum or not hrp then return end
		if hum.MoveDirection.Magnitude > 0 then
			local offset = hum.MoveDirection * (hum.WalkSpeed * value) * delta
			hrp.CFrame += offset
		end
	end)
end)

local Gravity = Functions:MakeSlider(PlayerMenu, "gravity", "Gravity", UDim2.new(0.016, 0, 0.265, 0), 195, 75, function(value)
	game.Workspace.Gravity = value
end)

local OCmenuKeybind = Instance.new("TextLabel")
OCmenuKeybind.Parent = SettingsMenu
OCmenuKeybind.Name = "keybind"
OCmenuKeybind.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
OCmenuKeybind.Position = UDim2.new(0.016, 0, 0.022, 0)
OCmenuKeybind.Size = UDim2.new(0, 194, 0, 32)
OCmenuKeybind.TextScaled = true
OCmenuKeybind.Text = "Menu Keybind"
OCmenuKeybind.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
OCmenuKeybind.Visible = true

local uisocmenukeybind = Instance.new("UICorner")
uisocmenukeybind.Parent = OCmenuKeybind
uisocmenukeybind.CornerRadius = UDim.new(0, 8)

local ocmenukeybindLoad = Instance.new("TextLabel")
ocmenukeybindLoad.Parent = OCmenuKeybind
ocmenukeybindLoad.Name = "load"
ocmenukeybindLoad.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
ocmenukeybindLoad.Position = UDim2.new(1.147, 0, 0, 0)
ocmenukeybindLoad.Size = UDim2.new(0, 104, 0, 32)
ocmenukeybindLoad.TextScaled = true
ocmenukeybindLoad.Text = "Insert"
ocmenukeybindLoad.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
ocmenukeybindLoad.Visible = true

local uicocmenukeybindload = Instance.new("UICorner")
uicocmenukeybindload.Parent = ocmenukeybindLoad
uicocmenukeybindload.CornerRadius = UDim.new(0, 8)

local uisocmenukeybindload = Instance.new("UIStroke")
uisocmenukeybindload.Parent = ocmenukeybindLoad
uisocmenukeybindload.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisocmenukeybindload.Color = Color3.new(1, 1, 1)
uisocmenukeybindload.LineJoinMode = Enum.LineJoinMode.Round
uisocmenukeybindload.Thickness = 1

local WhiteAdd = Instance.new("TextLabel")
WhiteAdd.Parent = SettingsMenu
WhiteAdd.Name = "WhiteList"
WhiteAdd.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
WhiteAdd.Position = UDim2.new(0.016, 0, 0.104, 0)
WhiteAdd.Size = UDim2.new(0, 194, 0, 32)
WhiteAdd.TextScaled = true
WhiteAdd.TextColor3 = Color3.new(1, 1, 1)
WhiteAdd.Text = "White list"
WhiteAdd.Visible = true

local uicwhiteadd = Instance.new("UICorner")
uicwhiteadd.Parent = WhiteAdd
uicwhiteadd.CornerRadius = UDim.new(0, 8)

local WhitePress = Instance.new("ImageButton")
WhitePress.Parent = WhiteAdd
WhitePress.Name = "press"
WhitePress.BackgroundTransparency = 1
WhitePress.Position = UDim2.new(1.192, 0, 0, 0)
WhitePress.Size = UDim2.new(0, 32, 0, 32)
WhitePress.Image = "rbxassetid://2769398451"
WhitePress.Visible = true

function RocketControlL()
	local Debris = workspace.Debris
	local VParts = Debris.VParts

	local Forward = 0
	local Sideways = 0
	local Break = false

	VParts.ChildAdded:Connect(function(Projectile)
		task.wait()

		if (Projectile.Name == "RPG_Rocket" or Projectile.Name == "GrenadeLauncherGrenade") and functions.rocket_controlF and isnetworkowner(Projectile) then
			if Projectile.Name == "RPG_Rocket" then 
				if not me.Character:FindFirstChild("RPG-7") then 
					return 
				end
			end

			if Projectile.Name == "GrenadeLauncherGrenade" then 
				if not isnetworkowner(Projectile) then
					return 
				end
			end

			camera.CameraSubject = Projectile
			me.Character.HumanoidRootPart.Anchored = true

			pcall(function()
				if Projectile.Name == "RPG_Rocket" then 
					Projectile.BodyForce:Destroy()
					Projectile.RotPart.BodyAngularVelocity:Destroy()
					Projectile.Sound:Destroy()
				elseif Projectile.Name == "GrenadeLauncherGrenade" then
					Projectile.BodyForce:Destroy()
					Projectile.BodyAngularVelocity:Destroy()
					Projectile.Sound:Destroy()
				end
			end)

			local BV = Instance.new("BodyVelocity", Projectile)
			BV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
			BV.Velocity = Vector3.new()

			local BG = Instance.new("BodyGyro", Projectile)
			BG.P = 9e4
			BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

			task.spawn(function()
				while true do
					run.RenderStepped:Wait()

					tween:Create(BV, TweenInfo.new(0), {Velocity = ((camera.CFrame.LookVector * Forward) + (camera.CFrame.RightVector * Sideways)) * SectionSettings.RocketControl.Speed}):Play()
					BG.CFrame = camera.CoordinateFrame

					local targetCFrame = Projectile.CFrame * CFrame.new(Vector3.new(0, 1, 1))
					camera.CFrame = camera.CFrame:Lerp(targetCFrame + Vector3.new(0, 5, 0), 0.1)

					if Break then
						Break = false
						break
					end
				end

				camera.CameraSubject = me.Character.Humanoid
				me.Character.HumanoidRootPart.Anchored = false
			end)
		end
	end)

	input.InputBegan:Connect(function(Key)
		if Key.KeyCode == Enum.KeyCode.W then
			Forward = 1
		elseif Key.KeyCode == Enum.KeyCode.S then
			Forward = -1
		elseif Key.KeyCode == Enum.KeyCode.D then
			Sideways = 1
		elseif Key.KeyCode == Enum.KeyCode.A then
			Sideways = -1
		end
	end)

	input.InputEnded:Connect(function(Key)
		if Key.KeyCode == Enum.KeyCode.W or Key.KeyCode == Enum.KeyCode.S then
			Forward = 0
		elseif Key.KeyCode == Enum.KeyCode.D or Key.KeyCode == Enum.KeyCode.A then
			Sideways = 0
		end
	end)

	Debris.ChildAdded:Connect(function(Result)
		task.wait()
		pcall(function()
			if me.Character:FindFirstChild("RPG-7") and (Result.Name == "RPG_Explosion_Long" or Result.Name == "RPG_Explosion_Short") then
				Break = true
				task.wait(1)
				Break = false
			end

			if (me.Character:FindFirstChild("M320-1") or me.Character:FindFirstChild("SCAR-H-X")) and (Result.Name == "GL_Explosion_Long" or Result.Name == "GL_Explosion_Short") then
				Break = true
				task.wait(1)
				Break = false
			end
		end)
	end)
end

function FullbrightL()
	if functions.FullbrightF == true then
		light.ExposureCompensation = 1
	elseif functions.FullbrightF == false then
		light.ExposureCompensation = 0
	end
end

function infstaminaL()
	if functions.infstaminaF == true then
		local oldStamina
		local succes, no = pcall(function()
			oldStamina =
				hookfunction(
					getupvalue(getrenv()._G.S_Take, 2),
					function(v1, ...)
						if (functions.infstaminaF) then 
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
				remotes.infstamina = run.RenderStepped:Connect(function()
					get()
					if functions.infstaminaF then
						for _, a in pairs(stamina) do
							a.S = 100
						end
					end
				end)
			else
				remotes.infstamina = run.RenderStepped:Connect(function()
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
		if remotes.infstamina then remotes.infstamina:Disconnect() end; remotes.infstamina = nil if me.Character then me.Character:FindFirstChildOfClass("Humanoid"):SetAttribute("ZSPRN_M", nil) end
	end
end

function nofalldamageL()
	if functions.nofalldamageF == true then
		if me.Character then
			local ff = Instance.new("ForceField")
			ff.Parent = me.Character
			ff.Visible = false
		end
		me.CharacterAdded:Connect(function(char)
			if functions.nofalldamageF and char and char:WaitForChild("HumanoidRootPart") and char:WaitForChild("Humanoid") then
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
end

function EspL()
	local TextService = game:GetService("TextService")
	local trackedPlayers = {}
	local trackedScraps = {}
	local trackedCrates = {}
	local trackedSafes = {}
	local TEXT_OFFSET = Vector2.new(0, -30)
	local BOX_OFFSET = Vector2.new(0, 0)

	local function updatePlayerEsp(player, data)
		local character = player.Character
		if not character then
			if data.chams then data.chams:Destroy() data.chams = nil end
			if data.text then data.text:Destroy() data.text = nil end
			if data.box then data.box:Destroy() data.box = nil end
			if data.weapon then data.weapon:Destroy() data.weapon = nil end
			return
		end

		if SectionSettings.ESP.CheckTeam and player.Team == me.Team then
			if data.chams then data.chams:Destroy() data.chams = nil end
			if data.text then data.text:Destroy() data.text = nil end
			if data.box then data.box:Destroy() data.box = nil end
			if data.weapon then data.weapon:Destroy() data.weapon = nil end
			return
		end

		if SectionSettings.ESP.Chams then
			if not data.chams or data.chams.Parent ~= character then
				if data.chams then data.chams:Destroy() end
				local highlight = Instance.new("Highlight")
				highlight.FillTransparency = 1
				highlight.Parent = character
				data.chams = highlight
			end
		else
			if data.chams then data.chams:Destroy() data.chams = nil end
		end

		if SectionSettings.ESP.Name then
			if not data.text then
				data.text = Drawing.new("Text")
				data.text.Visible = false
				data.text.Size = 12
				data.text.Color = Color3.new(1, 1, 1)
				data.text.Outline = true
				data.text.Center = true
			end
			local head = character:FindFirstChild("Head")
			if head then
				local headPosition = head.Position + Vector3.new(0, 0.5, 0)
				local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(headPosition)
				if onScreen then
					data.text.Visible = true
					data.text.Position = Vector2.new(pos.X + TEXT_OFFSET.X, pos.Y + TEXT_OFFSET.Y)
					data.text.Text = player.Name
				else
					data.text.Visible = false
				end
			else
				data.text.Visible = false
			end
		else
			if data.text then data.text:Destroy() data.text = nil end
		end

		if SectionSettings.ESP.Box then
			if not data.box then
				data.box = Drawing.new("Square")
				data.box.Visible = false
				data.box.Color = Color3.new(1, 0, 0)
				data.box.Thickness = 2
			end
			local modelCFrame, modelSize = character:GetBoundingBox()
			local corners = {}
			local halfSize = modelSize / 2
			local offsets = {
				Vector3.new(-halfSize.X, -halfSize.Y, -halfSize.Z),
				Vector3.new(-halfSize.X, -halfSize.Y, halfSize.Z),
				Vector3.new(-halfSize.X, halfSize.Y, -halfSize.Z),
				Vector3.new(-halfSize.X, halfSize.Y, halfSize.Z),
				Vector3.new(halfSize.X, -halfSize.Y, -halfSize.Z),
				Vector3.new(halfSize.X, -halfSize.Y, halfSize.Z),
				Vector3.new(halfSize.X, halfSize.Y, -halfSize.Z),
				Vector3.new(halfSize.X, halfSize.Y, halfSize.Z),
			}
			for _, offset in ipairs(offsets) do
				local worldPoint = modelCFrame * offset
				local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(worldPoint)
				table.insert(corners, {point = Vector2.new(screenPoint.X, screenPoint.Y), onScreen = onScreen})
			end

			local minX, minY = math.huge, math.huge
			local maxX, maxY = -math.huge, -math.huge
			local anyOnScreen = false
			for _, corner in ipairs(corners) do
				if corner.onScreen then
					anyOnScreen = true
					minX = math.min(minX, corner.point.X)
					minY = math.min(minY, corner.point.Y)
					maxX = math.max(maxX, corner.point.X)
					maxY = math.max(maxY, corner.point.Y)
				end
			end

			if anyOnScreen and minX ~= math.huge and minY ~= math.huge and maxX ~= -math.huge and maxY ~= -math.huge then
				local viewportSize = workspace.CurrentCamera.ViewportSize
				minX = math.clamp(minX, 0, viewportSize.X)
				minY = math.clamp(minY, 0, viewportSize.Y)
				maxX = math.clamp(maxX, 0, viewportSize.X)
				maxY = math.clamp(maxY, 0, viewportSize.Y)

				local boxWidth = maxX - minX
				local boxHeight = maxY - minY
				data.box.Size = Vector2.new(boxWidth, boxHeight)
				data.box.Position = Vector2.new(minX, minY)
				data.box.Visible = true
			else
				data.box.Visible = false
			end
		else
			if data.box then data.box:Destroy() data.box = nil end
		end

		if SectionSettings.ESP.Weapon then
			if not data.weapon then
				data.weapon = Drawing.new("Text")
				data.weapon.Visible = false
				data.weapon.Size = 12
				data.weapon.Color = Color3.new(1, 1, 1)
				data.weapon.Outline = true
				data.weapon.Center = true
			end
			local tool = nil
			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") then
					tool = child
					break
				end
			end
			if tool then
				local foot = character:FindFirstChild("LeftFoot") or character:FindFirstChild("RightFoot") or character:FindFirstChild("HumanoidRootPart")
				if foot then
					local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(foot.Position)
					if onScreen then
						data.weapon.Visible = true
						data.weapon.Position = Vector2.new(pos.X, pos.Y + 10)
						data.weapon.Text = tool.Name
					else
						data.weapon.Visible = false
					end
				end
			else
				data.weapon.Visible = false
			end
		else
			if data.weapon then data.weapon:Destroy() data.weapon = nil end
		end
	end

	local function createEsp(player)
		if trackedPlayers[player] then return end
		trackedPlayers[player] = { chams = nil, text = nil, box = nil, weapon = nil }
		player.CharacterAdded:Connect(function(character)
			task.wait(0.1)
			if trackedPlayers[player] then updatePlayerEsp(player, trackedPlayers[player]) end
		end)
	end

	local function removeEsp(player)
		if trackedPlayers[player] then
			if trackedPlayers[player].chams then trackedPlayers[player].chams:Destroy() end
			if trackedPlayers[player].text then trackedPlayers[player].text:Destroy() end
			if trackedPlayers[player].box then trackedPlayers[player].box:Destroy() end
			if trackedPlayers[player].weapon then trackedPlayers[player].weapon:Destroy() end
			trackedPlayers[player] = nil
		end
	end

	for _, player in ipairs(plrs:GetPlayers()) do
		if player ~= me then createEsp(player) end
	end

	plrs.PlayerAdded:Connect(function(player)
		if player ~= me then createEsp(player) end
	end)

	plrs.PlayerRemoving:Connect(removeEsp)

	local heartbeatConnection
	heartbeatConnection = run.Heartbeat:Connect(function()
		if not functions.EspF then
			for player, data in pairs(trackedPlayers) do
				if data.chams then data.chams:Destroy() end
				if data.text then data.text:Destroy() end
				if data.box then data.box:Destroy() end
				if data.weapon then data.weapon:Destroy() end
			end
			trackedPlayers = {}
			for obj, hl in pairs(trackedScraps) do
				if hl then hl:Destroy() end
			end
			trackedScraps = {}
			for obj, hl in pairs(trackedCrates) do
				if hl then hl:Destroy() end
			end
			trackedCrates = {}
			for obj, hl in pairs(trackedSafes) do
				if hl then hl:Destroy() end
			end
			trackedSafes = {}
			heartbeatConnection:Disconnect()
			return
		end

		for player, data in pairs(trackedPlayers) do
			updatePlayerEsp(player, data)
		end

		if SectionSettings.ESP.Scraps then
			for _, pile in ipairs(workspace.Filter.SpawnedPiles:GetChildren()) do
				if pile.Name == "S1" or pile.Name == "S2" then
					if not trackedScraps[pile] then
						local highlight = Instance.new("Highlight")
						highlight.FillColor = Color3.new(0.796078, 0.266667, 0)
						highlight.Parent = pile
						trackedScraps[pile] = highlight
					end
				end
			end
		else
			for pile, hl in pairs(trackedScraps) do
				if hl then hl:Destroy() end
				trackedScraps[pile] = nil
			end
		end

		if SectionSettings.ESP.Crates then
			for _, pile in ipairs(workspace.Filter.SpawnedPiles:GetChildren()) do
				if pile.Name == "C1" or pile.Name == "C2" or pile.Name == "C3" then
					if not trackedCrates[pile] then
						local highlight = Instance.new("Highlight")
						highlight.Parent = pile
						if pile.Name == "C1" then
							highlight.FillColor = Color3.new(0, 1, 0)
						elseif pile.Name == "C2" then
							highlight.FillColor = Color3.new(1, 0, 0)
						elseif pile.Name == "C3" then
							highlight.FillColor = Color3.new(1, 1, 0)
						end
						trackedCrates[pile] = highlight
					end
				end
			end
		else
			for pile, hl in pairs(trackedCrates) do
				if hl then hl:Destroy() end
				trackedCrates[pile] = nil
			end
		end

		if SectionSettings.ESP.Safes then
			for _, safe in ipairs(workspace.Map.BredMakurz:GetChildren()) do
				if string.find(safe.Name, "Safe") then
					local values = safe:FindFirstChild("Values")
					if values then
						local broken = values:FindFirstChild("Broken")
						if broken and broken.Value == false then
							if not trackedSafes[safe] then
								local highlight = Instance.new("Highlight")
								highlight.FillColor = Color3.new(0.101961, 1, 0.92549)
								highlight.Parent = safe
								trackedSafes[safe] = highlight
							end
						else
							if trackedSafes[safe] then
								trackedSafes[safe]:Destroy()
								trackedSafes[safe] = nil
							end
						end
					end
				end
			end
		else
			for safe, hl in pairs(trackedSafes) do
				if hl then hl:Destroy() end
				trackedSafes[safe] = nil
			end
		end
	end)
end

function infpepperL()
	function pepper(obj)
		if functions.infpepperF == true then
			obj:FindFirstChild("Ammo").MinValue = 100
			obj:FindFirstChild("Ammo").Value = 100
		else
			obj:FindFirstChild("Ammo").MinValue = 0
		end
	end

	local char = me.Character
	if char then
		local tool = char:FindFirstChildOfClass("Tool")
		if tool and tool.Name == "Pepper-spray" then
			pepper(tool)
		else
			char.ChildAdded:Connect(function(obj)
				if obj:IsA("Tool") and obj.Name == "Pepper-spray" then
					pepper(obj)
				end
			end)
		end
	else
		me.CharacterAdded:Connect(function(character)
			if character then
				local tool = character:FindFirstChildOfClass("Tool")
				if tool and tool.Name == "Pepper-spray" then
					pepper(tool)
				else
					character.ChildAdded:Connect(function(obj)
						if obj:IsA("Tool") and obj.Name == "Pepper-spray" then
							pepper(obj)
						end
					end)
				end
			end
		end)
	end
end

function glassarmsL()
	local viewfolder = camera:WaitForChild("ViewModel")
	if functions.glassarmsF == true then
		viewfolder["Left Arm"].Material = Enum.Material.ForceField
		viewfolder["Right Arm"].Material = Enum.Material.ForceField
	else
		viewfolder["Left Arm"].Material = Enum.Material.Plastic
		viewfolder["Right Arm"].Material = Enum.Material.Plastic
	end
	me.CharacterAdded:Connect(function(char)
		repeat wait() until char and char.Parent
		local viewfolder = camera:WaitForChild("ViewModel")
		if functions.glassarmsF == true then
			viewfolder["Left Arm"].Material = Enum.Material.ForceField
			viewfolder["Right Arm"].Material = Enum.Material.ForceField
		else
			viewfolder["Left Arm"].Material = Enum.Material.Plastic
			viewfolder["Right Arm"].Material = Enum.Material.Plastic
		end
	end)
end

function lockpickL()
	function lockpick(gui)
		for _, a in pairs(gui:GetDescendants()) do
			if a:IsA("ImageLabel") and a.Name == "Bar" then
				if a.Parent.Name ~= "Attempts" then
					local oldsize = a.Size
					run.RenderStepped:Connect(function()
						if functions.lockpickF then
							task.wait()
							a.Size = UDim2.new(0, 280, 0, 280)
						else
							task.wait()
							a.Size = oldsize
						end
					end)
				end
			end
		end
	end

	me.PlayerGui.ChildAdded:Connect(function(gui)
		if gui:IsA("ScreenGui") and gui.Name == "LockpickGUI" then
			lockpick(gui)
		end
	end)
end

function aimbotL()
	if functions.aimbotF == true then
		local target = nil
		local pressed = false
		local aimtarget
		local canusing = false
		local FirstPerson = true
		local predict = 15

		local part
		local randpart = nil

		local lastRandomTick = tick()

		local function getClosestTarget()
			local closest, closestDist = nil, SectionSettings.AimBot.DrawSize
			for _, player in pairs(plrs:GetPlayers()) do
				if player ~= me and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local pos, onScreen = camera:WorldToViewportPoint(player.Character:FindFirstChild("HumanoidRootPart").Position)
					if onScreen then
						if SectionSettings.AimBot.CheckTeam and player.Team == me.Team then
							continue
						end
						if SectionSettings.AimBot.CheckWhiteList and table.find(WhiteList, player) then
							continue
						end

						if SectionSettings.AimBot.CheckWall then
							local function Check()
								local ignore = {camera, me.Character, player.Character}
								if player.Parent ~= workspace then
									table.insert(ignore, player.Parent)
								end

								local checkpart = player.Character:FindFirstChild("HumanoidRootPart")
								if not checkpart then return math.huge end
								return #camera:GetPartsObscuringTarget({checkpart.Position}, ignore)
							end
							local value = Check()
							if value > 0 then
								continue
							end
						end

						local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(input:GetMouseLocation().X, input:GetMouseLocation().Y)).Magnitude
						if distance < closestDist then
							closestDist = distance
							closest = player
						end
					end
				end
			end
			return closest
		end

		remotes.aimbot_circlepos = run.RenderStepped:Connect(function()
			remotes.aimbot_circle.Position = Vector2.new(input:GetMouseLocation().X, input:GetMouseLocation().Y)
		end)

		input.InputBegan:Connect(function(key)
			if not input:GetFocusedTextBox() then
				if key.UserInputType == Enum.UserInputType.MouseButton2 then
					pressed = true
					aimtarget = getClosestTarget()
				end
			end
		end)

		input.InputEnded:Connect(function(key)
			if not input:GetFocusedTextBox() then
				if key.UserInputType == Enum.UserInputType.MouseButton2 then
					pressed = false
					aimtarget = nil
				end
			end
		end)

		run.RenderStepped:Connect(function()
			if FirstPerson then
				local magnitude = (camera.Focus.p - camera.CFrame.p).Magnitude
				canusing = magnitude <= 1.5
			end

			if functions.aimbotF and pressed and aimtarget and aimtarget.Character then
				local humanoid = aimtarget.Character:FindFirstChild("Humanoid")
				local targetPartCount = #SectionSettings.AimBot.TargetPart

				if targetPartCount == 0 then
					part = "Head"
				elseif targetPartCount == 1 then
					part = SectionSettings.AimBot.TargetPart[1]
				elseif targetPartCount > 1 then
					if tick() - lastRandomTick >= .5 then
						local rand = math.random(1, targetPartCount)
						randpart = SectionSettings.AimBot.TargetPart[rand]
						lastRandomTick = tick()
					end
					part = randpart or SectionSettings.AimBot.TargetPart[1]
				end

				if part and humanoid and humanoid.Health > 0 and canusing then
					local targetPosition = aimtarget.Character[part].Position
					if SectionSettings.AimBot.Velocity then
						targetPosition = targetPosition + aimtarget.Character[part].Velocity / predict
					end
					if SectionSettings.AimBot.Smooth then
						camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.p, targetPosition), SectionSettings.AimBot.SmoothSize)
					else
						camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
					end
				end
			end
		end)

		while functions.aimbotF do
			if SectionSettings.AimBot.Draw then
				if not remotes.aimbot_circle then
					remotes.aimbot_circle = Drawing.new("Circle")
					remotes.aimbot_circle.Color = Color3.new(1, 0, 0)
					remotes.aimbot_circle.Thickness = 2
					remotes.aimbot_circle.Radius = SectionSettings.AimBot.DrawSize
					remotes.aimbot_circle.Filled = false
					remotes.aimbot_circle.Visible = true

					if not remotes.aimbot_circlepos then
						remotes.aimbot_circlepos = run.Heartbeat:Connect(function()
							remotes.aimbot_circle.Position = Vector2.new(input:GetMouseLocation().X, input:GetMouseLocation().Y)
						end)
					end

				end
			else
				if remotes.aimbot_circle then remotes.aimbot_circle:Remove(); remotes.aimbot_circle = nil end if remotes.aimbot_circlepos then remotes.aimbot_circlepos:Disconnect(); remotes.aimbot_circlepos = nil end
			end
			run.RenderStepped:Wait()
		end

	else
		if remotes.aimbot_circle then remotes.aimbot_circle:Remove(); remotes.aimbot_circle = nil end if remotes.aimbot_circlepos then remotes.aimbot_circlepos:Disconnect(); remotes.aimbot_circlepos = nil end
	end
end

function nobarriersL()
	for _, a in pairs(workspace.Filter.Parts["F_Parts"]:GetDescendants()) do
		if a:IsA("Part") or a:IsA("MeshPart") then
			a.CanTouch = not a.CanTouch
		end
	end
end

ocmenukeybindLoad.MouseEnter:Connect(function()
	remotes.OCmenukeybind = true
	input.InputBegan:Connect(function(key, procces)
		if not procces and remotes.OCmenukeybind and key.UserInputType == Enum.UserInputType.MouseButton1 then
			ocmenukeybindLoad.Text = "..."
			local connect
			connect = input.InputBegan:Connect(function(key2)
				if not table.find(ignore_binds, key2.KeyCode) and not table.find(ignore_binds, key2.UserInputType) then
					_G.Keybind = key2.KeyCode
					local keyname = tostring(_G.Keybind):gsub("Enum.KeyCode.", "")
					ocmenukeybindLoad.Text = keyname
					connect:Disconnect()
				else
					return
				end
			end)
		end
	end)
end)

ocmenukeybindLoad.MouseLeave:Connect(function()
	remotes.OCmenukeybind = false
	local keyname = tostring(_G.Keybind):gsub("Enum.KeyCode.", "")
	ocmenukeybindLoad.Text = keyname
end)

dragging = false
dragInput = nil
dragStart = nil
startPos = nil

function update(input)
	delta = input.Position - dragStart
	newPosition = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)

	local anim1 = tween:Create(dragg, TweenInfo.new(0.3), {Position = newPosition})
	anim1:Play()
end

dragg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = dragg.Position

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
		update(input)
	end
end)

input.InputBegan:Connect(function(key)
	if key.KeyCode == _G.Keybind then
		if dragg.Visible == true then
			dragg.Visible = false
		else
			dragg.Visible = true
		end
	end
end)

function UpdateWhite()
	function Update(player)
		if player == me then return end

		local MakeFrame

		if table.find(PlayersList, player) then
			MakeFrame = Instance.new("Frame")
			MakeFrame.Parent = scroll
			MakeFrame.Name = player.Name
			MakeFrame.BackgroundColor3 = Color3.new(0.07, 0.07, 0.07)
			MakeFrame.Size = UDim2.new(0, 236, 0, 27)

			local uisframe = Instance.new("UIStroke")
			uisframe.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uisframe.Color = Color3.new(0.14, 0.14, 0.14)
			uisframe.Thickness = 3
			uisframe.Transparency = 0.4
			uisframe.Parent = MakeFrame

			local Name = Instance.new("TextLabel")
			Name.Parent = MakeFrame
			Name.Name = "Name"
			Name.BackgroundTransparency = 1
			Name.Position = UDim2.new(0.1, 0, 0, 0)
			Name.Size = UDim2.new(0, 200, 0, 27)
			Name.Font = Enum.Font.Roboto
			Name.TextColor3 = Color3.new(1, 1, 1)
			Name.TextScaled = true
			Name.Text = player.Name

			local CheckButton = Instance.new("TextButton")
			CheckButton.Parent = MakeFrame
			CheckButton.BackgroundColor3 = Color3.new(0.14, 0.14, 0.14)
			CheckButton.Position = UDim2.new(1.119, 0, 0, 0)
			CheckButton.Size = UDim2.new(0, 26, 0, 26)
			CheckButton.Text = ""

			local uischeckbutton = Instance.new("UIStroke")
			uischeckbutton.Parent = CheckButton
			uischeckbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uischeckbutton.Color = Color3.new(0.14, 0.14, 0.14)
			uischeckbutton.Thickness = 3
			uischeckbutton.Transparency = 0.4

			local CheckImage = Instance.new("ImageLabel")
			CheckImage.Parent = CheckButton
			CheckImage.BackgroundTransparency = 1
			CheckImage.Size = UDim2.new(1, 0, 1, 0)
			CheckImage.Image = "rbxassetid://6218581738"
			CheckImage.Visible = false

			if table.find(WhiteList, player) then
				CheckImage.Visible = true
			else
				CheckImage.Visible = false
			end

			CheckButton.MouseButton1Click:Connect(function()
				if not table.find(WhiteList, player) then
					table.insert(WhiteList, player)
					CheckImage.Visible = true
				else
					local check = table.find(WhiteList, player)
					table.remove(WhiteList, check)
					CheckImage.Visible = false
				end
			end)
		else
			if scroll:FindFirstChild(player.Name) then scroll:FindFirstChild(player.Name):Destroy() end
		end

		return MakeFrame
	end

	for _, a in pairs(plrs:GetPlayers()) do
		table.insert(PlayersList, a)
		Update(a)
	end

	plrs.PlayerAdded:Connect(function(plr)
		table.insert(PlayersList, plr)
		Update(plr)
	end)

	plrs.PlayerRemoving:Connect(function(index)
		local find = table.find(PlayersList, index)
		local find2 = table.find(WhiteList, index)

		if find then
			table.remove(PlayersList, find)
		end
		if find2 then
			table.remove(WhiteList, find2)
		end
		Update(index)
	end)
end

UpdateWhite()

WhitePress.MouseButton1Click:Connect(function()
	MenuWhite.Visible = true
end)

HideButton.MouseButton1Click:Connect(function()
	MenuWhite.Visible = false
end)
