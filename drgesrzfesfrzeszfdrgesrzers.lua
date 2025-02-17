local plrs = game:GetService("Players")
local me = plrs.LocalPlayer
local mouse = me:GetMouse()
local tween = game:GetService("TweenService")
local light = game:GetService("Lighting")
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera

_G.Keybind = Enum.KeyCode.Insert
local ignore_binds = {Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.D, Enum.KeyCode.S, Enum.KeyCode.F9, Enum.KeyCode.F12, Enum.KeyCode.Tab, Enum.KeyCode.Space, Enum.KeyCode.Backspace, Enum.KeyCode.LeftControl, Enum.KeyCode.LeftShift, Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}

local status = ""

local WhiteList = {}

local FOLDER = {
      Function_Guns = false,
      Function_Melees = false,
      Guns = {"G-17"},
      Melees = {},
      Skins = {
            GUNS = {
                  {id = "rbxassetid://15707661222", gun = "G-17"},
            },
            MELEES = {
                  {id = "rbxassetid://14983772470", melee = "Katana"},
            },
      },
      Selection = {
            GUNS = {
                  ["G-17"] = false,   
            },
            MELEES = {
                  ["Katana"] = false,
            }
      }
}

local cmds = {"leave", "reset", "clear", "close", "cmds"}

local functions = {
      FullbrightF = false,
      AutoOpenDoorsF = false,
      nobarriersF = false,
      fastpickupF = false,
      FlyF = nil,
      infstaminaF = false,
      nofalldamageF = false,
      silentaimF = nil,
      aimbotF = false,
      rocket_controlF = nil,
      meleeauraF = false,
      rage_botF = nil,
      EspF = nil,
      instant_reloadF = false,
      infpepperF = false,
      norecoilF = nil,
      glassarmsF = false,
      lockpickF = false,
      atmF = false,
      RagebotF = false,
}

local SectionSettings = {
      SilentAim = {
            Draw = nil,
            DrawSize = 50,
            DrawColor = nil,
            TargetPart = nil,
            CheckWall = nil,
            CheckTeam = nil,
            CheckList = nil,
            CheckDist = nil
      },
      AimBot = {
            Draw = nil,
            DrawSize = 50,
            DrawColor = Color3.new(1, 0, 0),
            TargetPart = "Head",
            CheckWall = nil,
            CheckTeam = nil,
            CheckWhiteList = nil,
            CheckDistance = nil,
            Velocity = nil
      },
      MeleeAura = {
            ShowAnim = nil,
            TargetPart = "Head",
            CheckWall = nil,
            CheckTeam = nil,
            CheckWhiteList = nil,
            Distance = 20
      },
      RageBot = {
            CheckTeam = nil,
            CheckWhiteList = nil
      },
      RocketControl = {
            Speed = 200
      },
      ESP = {
            Chams = nil,
            Tools = nil,
            Scraps = nil,
            Crates = nil,
            Safes = nil
      }
}

local remotes = {
      OCmenukeybind = nil;
      fov_connection = nil;
      infstamina = nil;
      aimbot_circle = nil,
      aimbot_circlepos = nil,
      Speed_RUN = nil,
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

wait(1)
local MouseCheck = input.MouseEnabled
if MouseCheck then status = "PC" else status = "mobile" end

local Gui = Instance.new("ScreenGui")
local s, e = pcall(function() Gui.Parent = game.CoreGui end) if not s then Gui.Parent = me.PlayerGui end
Gui.Name = Decrypt(10)
Gui.Enabled = true
Gui.ResetOnSpawn = false

local dragg = Instance.new("Frame")
dragg.Parent = Gui
dragg.Name = "dragg"
dragg.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
dragg.Position = UDim2.new(0.24, 0, 0.132, 0)
dragg.Size = UDim2.new(0, 405, 0, 19)
dragg.Visible = true

local OCmenubutton = nil

if status == "mobile" then
      OCmenubutton = Instance.new("ImageButton")
      OCmenubutton.Parent = Gui
      OCmenubutton.BackgroundColor3 = Color3.new(0, 0, 0)
      OCmenubutton.Position = UDim2.new(0, 306, 0, 21)
      OCmenubutton.Size = UDim2.new(0, 25, 0, 25)
      OCmenubutton.Image = "rbxassetid://83501732181441"
      OCmenubutton.ImageColor3 = Color3.new(1, 1, 1)
      OCmenubutton.Visible = true

      local uicocmenubutton = Instance.new("UICorner")
      uicocmenubutton.Parent = OCmenubutton
      uicocmenubutton.CornerRadius = UDim.new(8, 8)

      local uisocmenubutton = Instance.new("UIStroke")
      uisocmenubutton.Parent = OCmenubutton
      uisocmenubutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
      uisocmenubutton.Color = Color3.new(1, 1, 1)
      uisocmenubutton.LineJoinMode = Enum.LineJoinMode.Round
      uisocmenubutton.Thickness = 1.5
end

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
if status == "PC" then uiscdragg.Scale = 1 else uiscdragg.Scale = 0.5 end

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
if status == "PC" then uiscmf.Scale = 0.8 else uiscmf.Scale = 0.7 end

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

local console = Instance.new("Frame")
console.Parent = mainframe
console.Name = "Console"
console.BackgroundColor3 = Color3.new(0.152941, 0.152941, 0.152941)
console.Position = UDim2.new(1.009, 0, 0.031, 0)
console.Size = UDim2.new(0, 550, 0, 580)
console.Visible = true

local uigconsole = Instance.new("UIGradient")
uigconsole.Parent = console
uigconsole.Rotation = 50
uigconsole.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.new(0.117647, 0.117647, 0.117647)),
      ColorSequenceKeypoint.new(0.5, Color3.new(0.27451, 0.27451, 0.27451)),
      ColorSequenceKeypoint.new(1, Color3.new(0.117647, 0.117647, 0.117647))
})

local consoletext = Instance.new("TextLabel")
consoletext.Parent = console
consoletext.Name = "ConsoleText"
consoletext.BackgroundTransparency = 1
consoletext.Position = UDim2.new(0, 0, 0, 0)
consoletext.Size = UDim2.new(0, 550, 0, 580)
consoletext.TextColor3 = Color3.new(1, 0, 0)
consoletext.TextSize = 18
consoletext.Text = ""
consoletext.TextWrapped = true
consoletext.ClipsDescendants = true
consoletext.RichText = true
consoletext.TextXAlignment = Enum.TextXAlignment.Left
consoletext.TextYAlignment = Enum.TextYAlignment.Top
consoletext.Visible = true

local commands = Instance.new("TextBox")
commands.Parent = console
commands.Name = "command"
commands.BackgroundColor3 = Color3.new(0.168627, 0.168627, 0.168627)
commands.Position = UDim2.new(-0, 0, 1, 0)
commands.Size = UDim2.new(0, 550, 0, 34)
commands.ClearTextOnFocus = false
commands.ClipsDescendants = true
commands.PlaceholderText = "Console Bar"
commands.PlaceholderColor3 = Color3.new(0.709804, 0.709804, 0.709804)
commands.TextSize = 17
commands.TextColor3 = Color3.new(1, 1, 1)
commands.Text = ""
commands.TextXAlignment = Enum.TextXAlignment.Left
commands.Visible = true

local uiscommands = Instance.new("UIStroke")
uiscommands.Parent = commands
uiscommands.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiscommands.Color = Color3.new(0.101961, 0.101961, 0.101961)
uiscommands.LineJoinMode = Enum.LineJoinMode.Round
uiscommands.Thickness = 2

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

function Library()
      local Tabs = {}
      local Functions = {}

      function Tabs:MakeTab(Name)
            local TabButton = Instance.new("TextButton")
            TabButton.Parent = list
            TabButton.Name = Name
            TabButton.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
            TabButton.Size = UDim2.new(0, 176, 0, 38)
            TabButton.TextColor3 = Color3.new(1, 1, 1)
            TabButton.TextScaled = true
            TabButton.Text = Name
            TabButton.Visible = true

            local uictabbutton = Instance.new("UICorner")
            uictabbutton.Parent = TabButton
            uictabbutton.CornerRadius = UDim.new(0, 25)

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
                        ConsoleText("This function is disabled.", "text")
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
                  if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.Touch then
                        activated = false
                  end
            end)

            input.InputChanged:Connect(function(key)
                  if activated and (key.UserInputType == Enum.UserInputType.MouseMovement or key.UserInputType == Enum.UserInputType.Touch) then  
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
                        ConsoleText("This function is disabled.", "text")
                  end
                  if FUnc then
                        FUnc()
                  end
            end)

            return SectionButtonTurn
      end

      function Functions:MakeSectionCheckButton(Parent, Name, Text, Position, TYPE, TYPENAME, slider, SliderText, SliderPosition, minimal, maximal, FUNC)
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
                  else
                        ConsoleText("Configuration is disabled or in dev", "text")
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

                  local MINN = 0.0001 * SectionSliderButton.AbsoluteSize.X
                  local MAXX = SectionSliderButton.AbsoluteSize.X

                  local minim = minimal
                  local maxim = maximal

                  local canuse = false

                  SectionSliderButton.MouseButton1Down:Connect(function()
                        canuse = true
                  end)

                  input.InputEnded:Connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.Touch then
                              canuse = false
                        end
                  end)

                  input.InputChanged:Connect(function(key)
                        if canuse and (key.UserInputType == Enum.UserInputType.MouseMovement or key.UserInputType == Enum.UserInputType.Touch) then
                              local mpos = input:GetMouseLocation().X
                              local SCALE = math.clamp((mpos - SectionSliderControl.AbsolutePosition.X)/SectionSliderControl.AbsoluteSize.X,0.08,1)
                              SectionSliderButton.Size = UDim2.fromScale(SCALE, 1)
                              local value
                              value = math.clamp(minim + (SCALE * (maxim - minim)), minim, maximal)
                              FUNC(value)
                        end
                  end)
            end
            return SectionCheckImage
      end

      function Functions:MakeSectionClickButton(Parent, Name, Text, Position, Size)
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
            return SectionClickButton
      end

      function Functions:MakeColorWheelButton(Parent, Position)
            local ColorWheelButton = Instance.new("ImageButton")
            ColorWheelButton.Parent = Parent
            ColorWheelButton.Name = "Color"
            ColorWheelButton.BackgroundTransparency = 1
            ColorWheelButton.Position = Position
            ColorWheelButton.Size = UDim2.new(0, 35, 0, 35)
            ColorWheelButton.Image = "rbxassetid://1003599877"
            ColorWheelButton.Visible = true
            return ColorWheelButton
      end

      function Functions:MakeSectionSlider(Parent, Text, Position)
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
            return SliderButton
      end

      function Functions:AddSkin(Parent, Name, Text)
            local SkinText = Instance.new("TextLabel")
            SkinText.Parent = Parent
            SkinText.Name = Name
            SkinText.BackgroundColor3 = Color3.new(0.121569, 0.121569, 0.121569)
            SkinText.Size = UDim2.new(0, 250, 0, 40)
            SkinText.TextColor3 = Color3.new(1, 1, 1)
            SkinText.TextScaled = true
            SkinText.Text = Text
            SkinText.Visible = true

            local uicskinstext = Instance.new("UICorner")
            uicskinstext.Parent = SkinText
            uicskinstext.CornerRadius = UDim.new(0, 8)

            local SkinsButton = Instance.new("TextButton")
            SkinsButton.Parent = SkinText
            SkinsButton.Name = "Check"
            SkinsButton.BackgroundColor3 = Color3.new(0, 0, 0)
            SkinsButton.Position = UDim2.new(1.052, 0, 0, 0)
            SkinsButton.Size = UDim2.new(0, 40, 0, 40)
            SkinsButton.Text = ""
            SkinsButton.Visible = true

            local uicskinsbutton = Instance.new("UICorner")
            uicskinsbutton.Parent = SkinsButton
            uicskinsbutton.CornerRadius = UDim.new(0, 5)

            local uisskinsbutton = Instance.new("UIStroke")
            uisskinsbutton.Parent = SkinsButton
            uisskinsbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uisskinsbutton.Color = Color3.new(1, 1, 1)
            uisskinsbutton.LineJoinMode = Enum.LineJoinMode.Round
            uisskinsbutton.Thickness = 1

            local SkinsCheckImage = Instance.new("ImageLabel")
            SkinsCheckImage.Parent = SkinsButton
            SkinsCheckImage.Name = "check"
            SkinsCheckImage.BackgroundTransparency = 1
            SkinsCheckImage.Position = UDim2.new(0, 0, 0, 0)
            SkinsCheckImage.Size = UDim2.new(0, 40, 0, 40)
            SkinsCheckImage.Image = "rbxassetid://6218581738"
            SkinsCheckImage.Visible = false
            return SkinsCheckImage
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
local SkinsMenu = Tab:MakeTab("Skins")
local FarmMenu = Tab:MakeTab("Farm")
local SettingsMenu = Tab:MakeTab("Settings")
local ConfigMenu = Tab:MakeTab("Config")
local SECTION1 = Functions:MakeSection(MainScroll, UDim2.new(0.016, 0, 0.001, 0), UDim2.new(0, 300, 0, 380))
local SECTION2 = Functions:MakeSection(MainScroll, UDim2.new(0.532, 0, 0.001, 0), UDim2.new(0, 300, 0, 420))
local SECTION3 = Functions:MakeSection(MainScroll, UDim2.new(0.531, 0, 0.513, 0), UDim2.new(0, 300, 0, 110))
local SECTION4 = Functions:MakeSection(MainScroll, UDim2.new(0.015, 0, 0.347, 0), UDim2.new(0, 300, 0, 350))
local SECTION5 = Functions:MakeSection(MainScroll, UDim2.new(0.531, 0, 0.371, 0), UDim2.new(0, 300, 0, 150))
local SECTION6 = Functions:MakeSection(VisualMenu, UDim2.new(0.018, 0, 0.02, 0), UDim2.new(0, 300, 0, 300))

local FullbrightTurn = Functions:MakeTextButton(WorldMenu, "Fullbright", "Fullbright", UDim2.new(0.016, 0, 0.022, 0), functions, "FullbrightF", function()
      FullbrightL()
end)
local TurnOpen_doors = Functions:MakeTextButton(WorldMenu, "OpenDoors", "Auto open doors", UDim2.new(0.016, 0, 0.109, 0), functions, "AutoOpenDoorsF", function()
      Open_doorsL()
end)
local nobarriersTurn = Functions:MakeTextButton(WorldMenu, "nobarriers", "No barriers", UDim2.new(0.016, 0, 0.192, 0), functions, "nobarriersF", function()
      nobarriersL()
end)
local fastpickupTurn = Functions:MakeTextButton(WorldMenu, "fastpickup", "Fast pick up", UDim2.new(0.016, 0, 0.275, 0), functions, "fastpickupF", function()
      fastpickupL()
end)
local flyTurn = Functions:MakeTextButton(PlayerMenu, "Fly", "Fly", UDim2.new(0.016, 0, 0.352, 0), functions, "FlyF")
local infstaminaTurn = Functions:MakeTextButton(PlayerMenu, "infstamina", "Inf stamina", UDim2.new(0.016, 0, 0.439, 0), functions, "infstaminaF", function()
      infstaminaL()
end)
local nofalldamageTurn = Functions:MakeTextButton(PlayerMenu, "nofalldamage", "No fall damage", UDim2.new(0.016, 0, 0.525, 0), functions, "nofalldamageF", function()
      nofalldamageL()
end)
local lockpickTurn = Functions:MakeTextButton(FarmMenu, "lockpick", "Lockpick", UDim2.new(0.016, 0, 0.022, 0), functions, "lockpickF", function()
      lockpickL()
end)
local atmTurn = Functions:MakeTextButton(FarmMenu, "ATM", "ATM", UDim2.new(0.016, 0, 0.099, 0), functions, "atmF", function()
      atmL()
end)
local instantreloadTurn = Functions:MakeTextButton(MainScroll, "reload", "Instant reload", UDim2.new(0.016, 0, 0.662, 0), functions, "instant_reloadF", function()
      instantreloadL()
end)
local infpepperTurn = Functions:MakeTextButton(MainScroll, "infpepper", "Inf pepper spray", UDim2.new(0.016, 0, 0.704, 0), functions, "infpepperF", function()
      infpepperL()
end)
local norecoilTurn = Functions:MakeTextButton(MainScroll, "norecoil", "No recoil", UDim2.new(0.014, 0, 0.749, 0), functions, "norecoilF")
local glassarmsTurn = Functions:MakeTextButton(VisualMenu, "glassarms", "Glass arms", UDim2.new(0.53, 0, 0.019, 0), functions, "glassarmsF", function()
      glassarmsL()
end)
local glassarmscolor = Functions:MakeColorWheelButton(VisualMenu, UDim2.new(0.937, 0, 0.025, 0))

--// silent aim in section \\--
local silentaimTurn = Functions:MakeSectionButton(SECTION1, "silentaim", "Silent aim", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "silentaimF")
local silentaimdraw = Functions:MakeSectionCheckButton(SECTION1, "Draw", "Draw circle", UDim2.new(0.029, 0, 0.145, 0), SectionSettings.SilentAim, "Draw", true, "Size", UDim2.new(0, 0, 1.367, 0), 50, 300, function(val)
      SectionSettings.SilentAim.DrawSize = math.floor(val)
end)

local silentaimdrawcolor = Functions:MakeColorWheelButton(SECTION1, UDim2.new(0.783, 0, 0.145, 0))
local silentaimpart = Functions:MakeSectionClickButton(SECTION1, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.398, 0), UDim2.new(0, 160, 0, 32))
local silentaimwallcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckWall", "Check wall", UDim2.new(0.029, 0, 0.523, 0), SectionSettings.SilentAim, "CheckWall", false, "", nil, nil, nil)
local silentaimteamcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckTeam", "Check team", UDim2.new(0.029, 0, 0.645, 0), SectionSettings.SilentAim, "CheckTeam", false, "", nil, nil, nil)
local silentaimwhitelistcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckList", "Check white list", UDim2.new(0.029, 0, 0.766, 0), SectionSettings.SilentAim, "CheckList", false, "", nil, nil, nil)
local silentaimcheckdistance = Functions:MakeSectionCheckButton(SECTION1, "CheckDist", "Check distance", UDim2.new(0.029, 0, 0.882, 0), SectionSettings.SilentAim, "CheckDist", false, "", nil, nil, nil)

--// aimbot in section \\--
local aimbotTurn = Functions:MakeSectionButton(SECTION2, "aimbot", "Aim bot", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "aimbotF", function()
      aimbotL()
end)
local aimbotdraw = Functions:MakeSectionCheckButton(SECTION2, "Draw", "Draw circle", UDim2.new(0.029, 0, 0.158, 0), SectionSettings.AimBot, "Draw", true, "Size", UDim2.new(0, 0, 1.367, 0), 50, 300, function(val)
      SectionSettings.AimBot.DrawSize = math.floor(val)
end)
local aimbotdrawcolor = Functions:MakeColorWheelButton(SECTION2, UDim2.new(0.783, 0, 0.152, 0))
local aimbottargetpart = Functions:MakeSectionClickButton(SECTION2, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.369, 0), UDim2.new(0, 160, 0, 32))
local aimbotcheckwall = Functions:MakeSectionCheckButton(SECTION2, "CheckWall", "Check wall", UDim2.new(0.025, 0, 0.473, 0), SectionSettings.AimBot, "CheckWall")
local aimbotcheckteam = Functions:MakeSectionCheckButton(SECTION2, "CheckTeam", "Check team", UDim2.new(0.025, 0, 0.586, 0), SectionSettings.AimBot, "CheckTeam")
local aimbotwhitelistcheck = Functions:MakeSectionCheckButton(SECTION2, "CheckList", "Check white list", UDim2.new(0.025, 0, 0.693, 0), SectionSettings.AimBot, "CheckWhiteList")
local aimbotcheckdist = Functions:MakeSectionCheckButton(SECTION2, "CheckDist", "Check distance", UDim2.new(0.025, 0, 0.798, 0), SectionSettings.AimBot, "CheckDistance")
local aimbotvelocity = Functions:MakeSectionCheckButton(SECTION2, "Velocity", "Velocity", UDim2.new(0.025, 0, 0.905, 0), SectionSettings.AimBot, "Velocity")

--// rocket control in section \\--
local rocketcontrolTurn = Functions:MakeSectionButton(SECTION3, "RocketControl", "Rocket control", UDim2.new(0.03, 0, 0.136, 0), UDim2.new(0, 160, 0, 32), functions, "rocket_controlF")
local rocketcontrolspeed = Functions:MakeSectionSlider(SECTION3, "Speed", UDim2.new(0.029, 0, 0.53, 0))

--// melee aura in section \\--
local meleeauraTurn = Functions:MakeSectionButton(SECTION4, "meleeaura", "Melee aura", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "meleeauraF", function()
      meleeauraL()
end)
local meleeaurashomanim = Functions:MakeSectionCheckButton(SECTION4, "ShowAnim", "Show anim", UDim2.new(0.029, 0, 0.182, 0))
local meleeauratargetpart = Functions:MakeSectionClickButton(SECTION4, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.329, 0), UDim2.new(0, 160, 0, 32))
local meleeauracheckwall = Functions:MakeSectionCheckButton(SECTION4, "AutoAttack", "Auto attack", UDim2.new(0.029, 0, 0.468, 0))
local meleeaurateamcheck = Functions:MakeSectionCheckButton(SECTION4, "CheckTeam", "Check team", UDim2.new(0.029, 0, 0.6, 0))
local meleeaurawhitelistcheck = Functions:MakeSectionCheckButton(SECTION4, "CheckList", "Check white list", UDim2.new(0.029, 0, 0.739, 0))
local neleeaurapos = Functions:MakeSectionSlider(SECTION4, "Distance", UDim2.new(0.029, 0, 0.875, 0))

--// rage-bot in section \\--
local ragebotTurn = Functions:MakeSectionButton(SECTION5, "RageBot", "Rage bot", UDim2.new(0.03, 0, 0.04, 0), UDim2.new(0, 160, 0, 32), functions, "RagebotF", function()
      RagebotL()
end)
local ragebotteamcheck = Functions:MakeSectionCheckButton(SECTION5, "CheckTeam", "Check team", UDim2.new(0.029, 0, 0.365, 0))
local ragebotwhitelistcheck = Functions:MakeSectionCheckButton(SECTION5, "CheckList", "Check white list", UDim2.new(0.029, 0, 0.677, 0))

--// esp in section \\--
local espTurn = Functions:MakeSectionButton(SECTION6, "ESP", "ESP", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "EspF")
local espChams = Functions:MakeSectionCheckButton(SECTION6, "Chams", "Chams", UDim2.new(0.029, 0, 0.186, 0), SectionSettings.ESP, "Chams", false, "", nil, nil, nil)
local espTool = Functions:MakeSectionCheckButton(SECTION6, "Tools", "Tools", UDim2.new(0.029, 0, 0.343, 0), SectionSettings.ESP, "Tools", false, "", nil, nil, nil)
local espScraps = Functions:MakeSectionCheckButton(SECTION6, "Scraps", "Scraps", UDim2.new(0.029, 0, 0.509, 0), SectionSettings.ESP, "Scraps", false, "", nil, nil , nil)
local espCrates = Functions:MakeSectionCheckButton(SECTION6, "Crates", "Crates", UDim2.new(0.029, 0, 0.679, 0), SectionSettings.ESP, "Crates", false, "", nil, nil, nil)
local espSafes = Functions:MakeSectionCheckButton(SECTION6, "Safes", "Safes", UDim2.new(0.029, 0, 0.856, 0), SectionSettings.ESP, "Safes", false, "", nil, nil, nil)

local INDEX = {
      {button = FullbrightTurn, func = functions, name = "FullbrightF", section = false},
      {button = TurnOpen_doors, func = functions, name = "AutoOpenDoorsF", section = false},
      {button = nobarriersTurn, func = functions, name = "nobarriersF", section = false},
      {button = fastpickupTurn, func = functions, name = "fastpickupF", section = false},
      {button = flyTurn, func = functions, name = "FlyF", section = false},
      {button = infstaminaTurn, func = functions, name = "infstaminaF", section = false},
      {button = nofalldamageTurn, func = functions, name = "nofalldamageF", section = false},
      {button = aimbotTurn, func = functions, name = "aimbotF", section = true},
      {button = silentaimTurn, func = functions, name = "silentaimF", section = true},
      {button = instantreloadTurn, func = functions, name = "instant_reloadF", section = false},
      {button = infpepperTurn, func = functions, name = "infpepperF", section = false},
      {button = norecoilTurn, func = functions, name = "norecoilF", section = false},
      {button = glassarmsTurn, func = functions, name = "glassarmsF", section = false},
      {button = lockpickTurn, func = functions, name = "lockpickF", section = false},
      {button = atmTurn, func = functions, name = "atmF", section = false},
      {button = espTurn, func = functions, name = "EspF", section = true},
      {button = meleeauraTurn, func = functions, name = "meleeauraF", section = true},
      {button = ragebotTurn, func = functions, name = "RagebotF", section = true}
}

local INDEX2 = {
      {button = aimbotdraw, func = SectionSettings.AimBot, name = "Draw"},
      {button = aimbotcheckwall, func = SectionSettings.AimBot, name = "CheckWall"},
      {button = aimbotcheckteam, func = SectionSettings.AimBot, name = "CheckTeam"},
      {button = aimbotwhitelistcheck, func = SectionSettings.AimBot, name = "CheckWhiteList"},
      {button = aimbotcheckdist, func = SectionSettings.AimBot, name = "CheckDistance"},
      {button = aimbotvelocity, func = SectionSettings.AimBot, name = "Velocity"},
      {button = espChams, func = SectionSettings.ESP, name = "Chams"},
      {button = espTool, func = SectionSettings.ESP, name = "Tools"},
      {button = espScraps, func = SectionSettings.ESP, name = "Scraps"},
      {button = espCrates, func = SectionSettings.ESP, name = "Crates"},
      {button = espSafes, func = SectionSettings.ESP, name = "Safes"},
}

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

local skinslistText = Instance.new("TextLabel")
skinslistText.Parent = SkinsMenu
skinslistText.Name = "text"
skinslistText.BackgroundTransparency = 1
skinslistText.Position = UDim2.new(0.37, 0, -0.01, 0)
skinslistText.Size = UDim2.new(0, 200, 0, 50)
skinslistText.TextColor3 = Color3.new(0.945098, 0.945098, 0.945098)
skinslistText.TextScaled = true
skinslistText.Text = "SKINS LIST"
skinslistText.Visible = true

local gunsSkins = Instance.new("TextLabel")
gunsSkins.Parent = SkinsMenu
gunsSkins.Name = "guns"
gunsSkins.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
gunsSkins.Position = UDim2.new(0.015, 0, 0.094, 0)
gunsSkins.Size = UDim2.new(0, 194, 0, 32)
gunsSkins.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
gunsSkins.TextScaled = true
gunsSkins.Text = "GUNS"
gunsSkins.Visible = true

local uicgunsskins = Instance.new("UICorner")
uicgunsskins.Parent = gunsSkins
uicgunsskins.CornerRadius = UDim.new(0, 8)

local gunsskinscontrol = Instance.new("Frame")
gunsskinscontrol.Parent = gunsSkins
gunsskinscontrol.Name = "Control"
gunsskinscontrol.BackgroundColor3 = Color3.new(0, 0, 0)
gunsskinscontrol.Position = UDim2.new(1.064, 0, -0.078, 0)
gunsskinscontrol.Size = UDim2.new(0, 81, 0, 35)
gunsskinscontrol.Visible = true

local uicgunsskinscontrol = Instance.new("UICorner")
uicgunsskinscontrol.Parent = gunsskinscontrol
uicgunsskinscontrol.CornerRadius = UDim.new(8, 8)

local uisgunsskinscontrol = Instance.new("UIStroke")
uisgunsskinscontrol.Parent = gunsskinscontrol
uisgunsskinscontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisgunsskinscontrol.Color = Color3.new(1, 1, 1)
uisgunsskinscontrol.LineJoinMode = Enum.LineJoinMode.Round
uisgunsskinscontrol.Thickness = 1

local gunsskinsTurn = Instance.new("TextButton")
gunsskinsTurn.Parent = gunsskinscontrol
gunsskinsTurn.Name = "turn"
gunsskinsTurn.BackgroundColor3 = Color3.new(1, 0, 0)
gunsskinsTurn.Position = UDim2.new(0.046, 0, 0.071, 0)
gunsskinsTurn.Size = UDim2.new(0, 30, 0, 30)
gunsskinsTurn.Text = ""
gunsskinsTurn.Visible = true

local uicgunsskinsturn = Instance.new("UICorner")
uicgunsskinsturn.Parent = gunsskinsTurn
uicgunsskinsturn.CornerRadius = UDim.new(8, 8)

local uisgunsskinsturn = Instance.new("UIStroke")
uisgunsskinsturn.Parent = gunsskinsTurn
uisgunsskinsturn.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisgunsskinsturn.Color = Color3.new(1, 1, 1)
uisgunsskinsturn.LineJoinMode = Enum.LineJoinMode.Round
uisgunsskinsturn.Thickness = 1

local meleeSkins = Instance.new("TextLabel")
meleeSkins.Parent = SkinsMenu
meleeSkins.Name = "melees"
meleeSkins.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
meleeSkins.Position = UDim2.new(0.619, 0, 0.094, 0)
meleeSkins.Size = UDim2.new(0, 194, 0, 32)
meleeSkins.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
meleeSkins.TextScaled = true
meleeSkins.Text = "MELEES"
meleeSkins.Visible = true

local uicmeleeskins = Instance.new("UICorner")
uicmeleeskins.Parent = meleeSkins
uicmeleeskins.CornerRadius = UDim.new(0, 8)

local meleeskinsControl = Instance.new("Frame")
meleeskinsControl.Parent = meleeSkins
meleeskinsControl.Name = "Control"
meleeskinsControl.BackgroundColor3 = Color3.new(0, 0, 0)
meleeskinsControl.Position = UDim2.new(1.064, 0,-0.078, 0)
meleeskinsControl.Size = UDim2.new(0, 81, 0, 35)
meleeskinsControl.Visible = true

local uicmeleeskinscontrol = Instance.new("UICorner")
uicmeleeskinscontrol.Parent = meleeskinsControl
uicmeleeskinscontrol.CornerRadius = UDim.new(8, 8)

local uismeleeskinscontrol = Instance.new("UIStroke")
uismeleeskinscontrol.Parent = meleeskinsControl
uismeleeskinscontrol.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uismeleeskinscontrol.Color = Color3.new(1, 1, 1)
uismeleeskinscontrol.LineJoinMode = Enum.LineJoinMode.Round
uismeleeskinscontrol.Thickness = 1

local meleeskinsTurn = Instance.new("TextButton")
meleeskinsTurn.Parent = meleeskinsControl
meleeskinsTurn.Name = "turn"
meleeskinsTurn.BackgroundColor3 = Color3.new(1, 0, 0)
meleeskinsTurn.Position = UDim2.new(0.046, 0, 0.071, 0)
meleeskinsTurn.Size = UDim2.new(0, 30, 0, 30)
meleeskinsTurn.Text = ""
meleeskinsTurn.Visible = true

local uicmeleeskinsturn = Instance.new("UICorner")
uicmeleeskinsturn.Parent = meleeskinsTurn
uicmeleeskinsturn.CornerRadius = UDim.new(8, 8)

local uismeleeskinsturn = Instance.new("UIStroke")
uismeleeskinsturn.Parent = meleeskinsTurn
uismeleeskinsturn.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uismeleeskinsturn.Color = Color3.new(1, 1, 1)
uismeleeskinsturn.LineJoinMode = Enum.LineJoinMode.Round
uismeleeskinsturn.Thickness = 1

local gunsList = Instance.new("ScrollingFrame")
gunsList.Parent = SkinsMenu
gunsList.Name = "ginslist"
gunsList.BackgroundColor3 = Color3.new(0.333333, 0.333333, 0.333333)
gunsList.Position = UDim2.new(0.015, 0, 0.182, 0)
gunsList.Size = UDim2.new(0, 360, 0, 481)
gunsList.CanvasSize = UDim2.new(0, 0, 10, 0)
gunsList.ScrollBarImageColor3 = Color3.new(0, 0, 0)
gunsList.ScrollBarThickness = 5

local uilgunlist = Instance.new("UIListLayout")
uilgunlist.Parent = gunsList
uilgunlist.Padding = UDim.new(0, 15)
uilgunlist.FillDirection = Enum.FillDirection.Vertical
uilgunlist.SortOrder = Enum.SortOrder.LayoutOrder
uilgunlist.HorizontalAlignment = Enum.HorizontalAlignment.Left
uilgunlist.HorizontalFlex = Enum.UIFlexAlignment.None
uilgunlist.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
uilgunlist.VerticalAlignment = Enum.VerticalAlignment.Top
uilgunlist.VerticalFlex = Enum.UIFlexAlignment.None

local uipgunslist = Instance.new("UIPadding")
uipgunslist.Parent = gunsList
uipgunslist.PaddingBottom = UDim.new(0, 0)
uipgunslist.PaddingLeft = UDim.new(0, 10)
uipgunslist.PaddingRight = UDim.new(0, 0)
uipgunslist.PaddingTop = UDim.new(0, 10)

local meleesList = Instance.new("ScrollingFrame")
meleesList.Parent = SkinsMenu
meleesList.Name = "meleeslist"
meleesList.BackgroundColor3 = Color3.new(0.333333, 0.333333, 0.333333)
meleesList.Position = UDim2.new(0.525, 0, 0.186, 0)
meleesList.Size = UDim2.new(0, 360, 0, 481)
meleesList.CanvasSize = UDim2.new(0, 0, 10, 0)
meleesList.ScrollBarImageColor3 = Color3.new(0, 0, 0)
meleesList.ScrollBarThickness = 5

local uilmelelist = Instance.new("UIListLayout")
uilmelelist.Parent = meleesList
uilmelelist.Padding = UDim.new(0, 15)
uilmelelist.FillDirection = Enum.FillDirection.Vertical
uilmelelist.SortOrder = Enum.SortOrder.LayoutOrder
uilmelelist.HorizontalAlignment = Enum.HorizontalAlignment.Left
uilmelelist.HorizontalFlex = Enum.UIFlexAlignment.None
uilmelelist.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
uilmelelist.VerticalAlignment = Enum.VerticalAlignment.Top
uilmelelist.VerticalFlex = Enum.UIFlexAlignment.None

local uipmelelist = Instance.new("UIPadding")
uipmelelist.Parent = meleesList
uipmelelist.PaddingBottom = UDim.new(0, 0)
uipmelelist.PaddingLeft = UDim.new(0, 10)
uipmelelist.PaddingRight = UDim.new(0, 0)
uipmelelist.PaddingTop = UDim.new(0, 10)

local GlockSkin = Functions:AddSkin(gunsList, "Glock", "Glock - Anime girl")
local KatanaSkin = Functions:AddSkin(meleesList, "Katana", "Katana - hz")

local Commands = {
      leave = function()
            game:Shutdown()
      end,
      reset = function()
            me.Character.Humanoid.Health = 0
      end,
      cmds = function()
            ConsoleText(table.concat(cmds, ", "), "succes")
      end,
      clear = function()
            ConsoleText("")
      end,
      close = function()
            Gui:Destroy()
      end,
}

function FullbrightL()
      if functions.FullbrightF == true then
            light.ExposureCompensation = 1
      elseif functions.FullbrightF == false then
            light.ExposureCompensation = 0
      end
end

function Open_doorsL()
      if functions.AutoOpenDoorsF then
            while functions.AutoOpenDoorsF do
                  local Folder_Map = workspace:FindFirstChild("Map")
                  if not Folder_Map then return end
                  for _, a in pairs(Folder_Map.Doors:GetChildren()) do
                        if me.Character and me.Character:FindFirstChild("HumanoidRootPart") and (me.Character:FindFirstChild("HumanoidRootPart").Position - a:FindFirstChild("DoorBase").Position).Magnitude <= 30 then
                              if a:FindFirstChild("Values"):FindFirstChild("Locked").Value == true then
                                    a:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer("Unlock", a.Lock)
                                    local b1 = "Open"
                                    local b2
                                    local KNOB1 = a:FindFirstChild("Knob1")
                                    local KNOB2 = a:FindFirstChild("Knob2")
                                    local KNOB1pos = (me.Character:FindFirstChild("HumanoidRootPart").Position - KNOB1.Position).Magnitude
                                    local KNOB2pos = (me.Character:FindFirstChild("HumanoidRootPart").Position - KNOB2.Position).Magnitude
                                    b2 = (KNOB1pos < KNOB2pos) and KNOB1 or KNOB2
                                    a:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer(b1, b2)
                              else
                                    for _, i in pairs(Folder_Map.Doors:GetChildren()) do
                                          if me.Character and me.Character:FindFirstChild("HumanoidRootPart") and (me.Character:FindFirstChild("HumanoidRootPart").Position - i:FindFirstChild("DoorBase").Position).Magnitude <= 20 then
                                                local opened = i:FindFirstChild("Values"):FindFirstChild("Open")
                                                if opened and opened.Value == false then
                                                      local a1 = "Open"
                                                      local a2
                                                      local knob1 = i:FindFirstChild("Knob1")
                                                      local knob2 = i:FindFirstChild("Knob2")
                                                      local knob1pos = (me.Character:FindFirstChild("HumanoidRootPart").Position - knob1.Position).Magnitude
                                                      local knob2pos = (me.Character:FindFirstChild("HumanoidRootPart").Position - knob2.Position).Magnitude
                                                      a2 = (knob1pos < knob2pos) and knob1 or knob2
                                                      i:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer(a1, a2)
                                                end
                                          end
                                    end
                              end 
                        end
                  end
                  run.RenderStepped:Wait()
            end
      end
end

function fastpickupL()
      local proximityPrompts = {}

      workspace.DescendantAdded:Connect(function(item)
            if item:IsA("ProximityPrompt") then
                  proximityPrompts[item] = {
                        originalDuration = item.HoldDuration
                  }
            end
      end)

      if functions.fastpickupF == true then
            while functions.fastpickupF do
                  for prompt, info in pairs(proximityPrompts) do
                        prompt.HoldDuration = 0
                  end
                  run.RenderStepped:Wait()
            end
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
                        remotes.infstamina = game:GetService("RunService").RenderStepped:Connect(function()
                              get()
                              if functions.infstaminaF then
                                    for _, a in pairs(stamina) do
                                          a.S = 100
                                    end
                              end
                        end)
                  else
                        ConsoleText("Patched or your exploit not support.", "error"); functions.infstaminaF = false
                        Animate(infstaminaTurn, false, false)
                  end
            end
      else
            if remotes.infstamina then remotes.infstamina:Disconnect() end; remotes.infstamina = nil
      end
end

function nofalldamageL()
      local folder = workspace:FindFirstChild("Characters")
      local mychar = me.Character
      if mychar then
            if functions.nofalldamageF then
                  local ff = Instance.new("ForceField")
                  ff.Parent = mychar
                  ff.Visible = false
            end
      end
      me.CharacterAdded:Connect(function(char)
            repeat wait() until char and char.Parent
            if functions.nofalldamageF then
                  local ff = Instance.new("ForceField")
                  ff.Parent = char
                  ff.Visible = false
            end
      end)
      if functions.nofalldamageF == false then
            local mychar = me.Character
            if mychar then
                  for _, a in pairs(mychar:GetChildren()) do
                        if a:IsA("ForceField") and a.Visible == false then
                              a:Destroy()
                        end
                  end
            end
      end
end

function RagebotL()
      local function RandomString(length)
            local res = ""
            for i = 1, length do
                  res = res .. string.char(math.random(97, 122))
            end
            return res
      end

      local function GetClosestEnemy()
            local closestEnemy = nil
            local shortestDistance = 100

            for _, player in pairs(plrs:GetPlayers()) do
                  if player ~= me and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid").Health > 15 and not player.Character:FindFirstChildOfClass("ForceField") then
                        local enemyPos = player.Character.HumanoidRootPart.Position
                        local distance = (enemyPos - me.Character.HumanoidRootPart.Position).Magnitude

                        if distance < shortestDistance then
                              closestEnemy = player
                        end
                  end
            end

            return closestEnemy
      end

      local function Shoot(target)
            if not target or not target.Character then return end
            local humanoidRootPart = target.Character:FindFirstChild("Head")
            if not humanoidRootPart then return end

            local hitPosition = humanoidRootPart.Position
            local hitDirection = (hitPosition - camera.CFrame.Position).unit
            local randomKey = RandomString(30)..0
            local tool = me.Character:FindFirstChildOfClass("Tool")

            game:GetService("ReplicatedStorage").Events.GNX_S:FireServer(
                  tick(), 
                  randomKey, 
                  tool, 
                  "FDS9I83", 
                  camera.CFrame.Position, 
                  {hitDirection}, 
                  false
            )

            task.delay(0.00001, function()
                  game:GetService("ReplicatedStorage").Events.ZFKLF_H:FireServer(
                        "🍯", 
                        tool, 
                        randomKey, 
                        1, 
                        humanoidRootPart, 
                        hitPosition, 
                        hitDirection, 
                        nil, 
                        nil
                  )
            end)
      end

      local function RageBotLoop()
            while functions.RagebotF do
                  local target = GetClosestEnemy()
                  if target then
                        Shoot(target)
                  end
                  run.RenderStepped:Wait()
            end
      end
      RageBotLoop()
end

--[[function EspL()
      local ToolsFolder = workspace:FindFirstChild("Filter").ToolSpawns
      local SafeFolder = workspace:FindFirstChild("Map").BredMakurz
      local ScapFolder = workspace:FindFirstChild("Filter").SpawnedPiles
end]]

function UpdateButtons()
      for i, a in pairs(INDEX) do
            if a.func[a.name] == false then
                  Animate(a.button, false, a.section)
            elseif a.func[a.name] == true then
                  Animate(a.button, true, a.section)
            end
      end
      for i, a in pairs(INDEX2) do
            if a.func[a.name] == false then
                  a.button.Visible = false
            elseif a.func[a.name] == true then
                  a.button.Visible = true
            end
      end
end

--[[function SkinsL()
      run.RenderStepped:Connect(function()
            local char = me.Character or me.CharacterAdded:Wait()
            if not char then return end
            local tool = char:FindFirstChildOfClass("Tool")
            if not tool then return end
            
            if FOLDER.Function_Guns then
                  for _, a in ipairs(FOLDER.Skins.GUNS) do
                        if tool.Name  == a.gun then
                              for _, obj in ipairs(tool:GetDescendants()) do
                                    if obj:IsA("MeshPart") then
                                          if FOLDER.Selection.GUNS[a.gun] then
                                                obj.TextureID = a.id
                                          end
                                    end
                              end
                        end
                  end
            end
            if FOLDER.Function_Melees then
                  for _, a in pairs(FOLDER.Skins.MELEES) do
                        if tool.Name == a.melee then
                              for _, obj in pairs(tool:GetDescendants()) do
                                    if obj:IsA("MeshPart") then
                                          if FOLDER.Selection.MELEES[a.melee] then
                                                obj.TextureID = a.id
                                          end
                                    end
                              end
                        end
                  end
            end
      end)
end]]

function meleeauraL()
      local plrs = game:GetService("Players")
      local me = plrs.LocalPlayer
      local run = game:GetService("RunService")

      local remote1 = game:GetService("ReplicatedStorage").Events["XMHH.2"]
      local remote2 = game:GetService("ReplicatedStorage").Events["XMHH2.2"]

      local maxdist = 20

      function Attack(target)
            if not (target and target:FindFirstChild("Head")) then return end

            local arg1 = {
                  [1] = "🍞",
                  [2] = tick(),
                  [3] = me.Character:FindFirstChildOfClass("Tool"),
                  [4] = "43TRFWX",
                  [5] = "Normal",
                  [6] = tick(),
                  [7] = true
            }

            local result = remote1:InvokeServer(unpack(arg1))

            task.wait(0.5)

            local tool = me.Character:FindFirstChildOfClass("Tool")
            if tool then
                  local Handle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle") or me.Character:FindFirstChild("Right Arm")
                  local arg2 = {
                        [1] = "🍞",
                        [2] = tick(),
                        [3] = tool,
                        [4] = "2389ZFX34",
                        [5] = result,
                        [6] = false,
                        [7] = Handle,
                        [8] = target:FindFirstChild("Head"),
                        [9] = target,
                        [10] = me.Character:FindFirstChild("HumanoidRootPart").Position,
                        [11] = target:FindFirstChild("Head").Position
                  }
                  remote2:FireServer(unpack(arg2))
            else
                  return
            end
      end

      while functions.meleeauraF do
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
                                                if distance < maxdist and a.Character:FindFirstChildOfClass("Humanoid").Health > 15 and not char:FindFirstChildOfClass("ForceField") then -- искать близжайшего игрока
                                                      Attack(char)
                                                end
                                          end
                                    end
                              end
                        end
                  end
            end
            run.RenderStepped:Wait()
      end
end

function instantreloadL()
      local gunR_remote = game:GetService("ReplicatedStorage").Events.GNX_R
      if functions.instant_reloadF then
            local charme = me.Character
            if charme then
                  local tool = charme:FindFirstChildOfClass("Tool")
                  if tool and tool:FindFirstChild("IsGun") then
                        local value = tool:FindFirstChild("Values"):FindFirstChild("SERVER_Ammo")
                        local value2 = tool:FindFirstChild("Values"):FindFirstChild("SERVER_StoredAmmo")
                        value2:GetPropertyChangedSignal("Value"):Connect(function()
                              if functions.instant_reloadF then
                                    gunR_remote:FireServer(tick(), "KLWE89U0", tool);
                              end
                        end)
                        if value2.Value ~= 0 then
                              if functions.instant_reloadF then
                                    gunR_remote:FireServer(tick(), "KLWE89U0", tool);
                              end
                        end
                        value:GetPropertyChangedSignal("Value"):Connect(function()
                              if functions.instant_reloadF and value2.Value ~= 0 then
                                    gunR_remote:FireServer(tick(), "KLWE89U0", tool);
                              end
                        end)
                  else
                        charme.ChildAdded:Connect(function(obj)
                              if obj:IsA("Tool") and obj:FindFirstChild("IsGun") then
                                    local value = obj:FindFirstChild("Values"):FindFirstChild("SERVER_Ammo")
                                    local value2 = obj:FindFirstChild("Values"):FindFirstChild("SERVER_StoredAmmo")
                                    value2:GetPropertyChangedSignal("Value"):Connect(function()
                                          if functions.instant_reloadF then
                                                gunR_remote:FireServer(tick(), "KLWE89U0", obj);
                                          end
                                    end)
                                    if value2.Value ~= 0 then
                                          if functions.instant_reloadF then
                                                gunR_remote:FireServer(tick(), "KLWE89U0", obj);
                                          end
                                    end
                                    value:GetPropertyChangedSignal("Value"):Connect(function()
                                          if functions.instant_reloadF and value2.Value ~= 0 then
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
                                          if functions.instant_reloadF then
                                                gunR_remote:FireServer(tick(), "KLWE89U0", obj);
                                          end
                                    end)
                                    if value2.Value ~= 0 then
                                          if functions.instant_reloadF then
                                                gunR_remote:FireServer(tick(), "KLWE89U0", obj);
                                          end
                                    end
                                    value:GetPropertyChangedSignal("Value"):Connect(function()
                                          if functions.instant_reloadF and value2.Value ~= 0 then
                                                gunR_remote:FireServer(tick(), "KLWE89U0", obj);
                                          end
                                    end)
                              end
                        end)
                  end)
            end
      end
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
            local aimpart = "Head"
            local target = nil
            local radius = 150
            local pressed = false
            local aimtarget
            local canusing = false
            local FirstPerson = true
            local velocity = true
            local predict = 15

            remotes.aimbot_circle = Drawing.new("Circle")
            remotes.aimbot_circle.Color = Color3.fromRGB(255, 0, 0)
            remotes.aimbot_circle.Thickness = 2
            remotes.aimbot_circle.NumSides = 50
            remotes.aimbot_circle.Radius = radius
            remotes.aimbot_circle.Filled = false
            remotes.aimbot_circle.Visible = true

            local function getClosestTarget()
                  local closest, closestDist = nil, radius
                  for _, player in pairs(plrs:GetPlayers()) do
                        if player ~= me and player.Character and player.Character:FindFirstChild(aimpart) then
                              local pos, onScreen = camera:WorldToViewportPoint(player.Character[aimpart].Position)
                              if onScreen then
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
                        local head = aimtarget.Character:FindFirstChild(aimpart)
                        local humanoid = aimtarget.Character:FindFirstChild("Humanoid")

                        if head and humanoid and humanoid.Health > 0 and canusing then
                              local targetPosition = head.Position
                              if velocity then
                                    targetPosition = targetPosition + head.Velocity / predict
                              end
                              camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.p, targetPosition), 0.9)
                        end
                  end
            end)
      else
            if remotes.aimbot_circle then remotes.aimbot_circle:Remove() end; remotes.aimbot_circle = nil; if remotes.aimbot_circlepos then remotes.aimbot_circlepos:Disconnect() end; remotes.aimbot_circlepos = nil
      end
end

function atmL()
      function GetATM(Studs)
            local Part;
            for _, v in ipairs(game:GetService("Workspace").Map.ATMz:GetChildren()) do
                  if v:FindFirstChild("MainPart") then
                        local Distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("MainPart").Position).Magnitude
                        if Distance < Studs then
                              Studs = Distance
                              Part = v:FindFirstChild("MainPart")
                        end
                  end
            end
            return Part
      end
      run.RenderStepped:Connect(function()
            if game:GetService("ReplicatedStorage").PlayerbaseData2[game:GetService("Players").LocalPlayer.Name].NextAllowance.Value == 0 then
                  local ATM = GetATM(math.huge)
                  if ATM then
                        if functions.atmF then
                              game:GetService("ReplicatedStorage").Events.CLMZALOW:InvokeServer(ATM)
                        end
                  end
            end
      end)
end

function nobarriersL()
      for _, a in pairs(workspace.Filter.Parts["F_Parts"]:GetDescendants()) do
            if a:IsA("Part") or a:IsA("MeshPart") then
                  a.CanTouch = not a.CanTouch
            end
      end
end

local stroke = 1
function ConsoleText(text, typeF)
      if stroke > 20 then
            consoletext.Text = ""
            stroke = 1
      end

      local strokeColor = '<font color="rgb(255, 255, 255)">'..stroke..".  "..'</font>'
      local errorColor = '<font color="rgb(255, 0, 0)">'..text..'</font>'
      local succesColor = '<font color="rgb(0, 255, 0)">'..text..'</font>'
      local textColor = '<font color="rgb(255, 255, 255)">'..text..'</font>'

      if consoletext.Text == "" and typeF == "error" then
            consoletext.Text = strokeColor..errorColor
            stroke += 1
      elseif consoletext.Text ~= "" and typeF == "error" then
            consoletext.Text = consoletext.Text.."\n"..strokeColor..errorColor
            stroke += 1
      end
      if consoletext.Text == "" and typeF == "succes" then
            consoletext.Text = strokeColor..succesColor
            stroke += 1
      elseif consoletext.Text ~= "" and typeF == "succes" then
            consoletext.Text = consoletext.Text.."\n"..strokeColor..succesColor
            stroke += 1
      end
      if consoletext.Text == "" and typeF == "text" then
            consoletext.Text = strokeColor..textColor
            stroke += 1
      elseif consoletext.Text ~= "" and typeF == "text" then
            consoletext.Text = consoletext.Text.."\n"..strokeColor..textColor
            stroke += 1
      end
      if text == "" then
            consoletext.Text = ""
            stroke = 1
      end
end

Commands.cmds()
ConsoleText("[Version 1.01]", "text")

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

commands.FocusLost:Connect(function()
      local succ, err = pcall(function()
            if commands.Text == "" then
                  return
            else
                  local commandFunc = Commands[commands.Text]
                  if commandFunc then
                        commandFunc()
                  else
                        ConsoleText("Command not found!", "error")
                  end
            end
            commands.Text = ""
      end)
      if not succ then
            ConsoleText("Error: function not support for your exploit", "error")
            commands.Text = ""
      end
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
      if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
      if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
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

if OCmenubutton ~= nil then
      OCmenubutton.MouseButton1Click:Connect(function()
            if dragg.Visible == true then
                  dragg.Visible = false
            else
                  dragg.Visible = true
            end
      end)
end

function UpdateFunctions()
      FullbrightL()
      Open_doorsL()
      nobarriersL()
      fastpickupL()
      infstaminaL()
      nofalldamageL()
      aimbotL()
      meleeauraL()
      RagebotL()
      instantreloadL()
      infpepperL()
      glassarmsL()
      lockpickL()
      atmL()
end
