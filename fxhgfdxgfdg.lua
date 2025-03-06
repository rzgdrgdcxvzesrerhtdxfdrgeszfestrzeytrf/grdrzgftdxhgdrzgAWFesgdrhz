local plrs = game:GetService("Players")
local me = plrs.LocalPlayer
local mouse = me:GetMouse()
local tween = game:GetService("TweenService")
local light = game:GetService("Lighting")
local input = game:GetService("UserInputService")
local content = game:GetService("ContentProvider")
local run = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera

local RandSound = {2084290015, 5853668794, 18331725459, 18331725459, 18331725459, 7056720271, 6651571134, 4910368846, 4910368846, 102630287147529, 102630287147529, 15798534597, 6435412998}
local rand = math.random(1, #RandSound)

local PlayersList = {}
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

local cmds = {"clear", "close", "cmds"}

local functions = {
      FullbrightF = false,
      AutoOpenDoorsF = false,
      nobarriersF = false,
      fastpickupF = false,
      FlyF = nil,
      infstaminaF = false,
      nofalldamageF = false,
      silentaimF = false,
      aimbotF = false,
      rocket_controlF = nil,
      meleeauraF = false,
      rage_botF = nil,
      EspF = false,
      instant_reloadF = false,
      infpepperF = false,
      norecoilF = nil,
      glassarmsF = false,
      lockpickF = false,
      atmF = false,
      RagebotF = false,
      WallbangF = false,
      AltsFarmF = false
}

local SectionSettings = {
      SilentAim = {
            Draw = nil,
            DrawSize = 50,
            DrawColor = nil,
            TargetPart = {"Head"},
            CheckWall = nil,
            CheckTeam = false,
            CheckList = false,
            CheckDist = nil
      },
      AimBot = {
            Draw = nil,
            DrawSize = 50,
            DrawColor = Color3.new(1, 0, 0),
            TargetPart = {"Head"},
            CheckWall = nil,
            CheckTeam = false,
            CheckWhiteList = false,
            CheckDistance = nil,
            Velocity = false
      },
      MeleeAura = {
            ShowAnim = nil,
            TargetPart = {"Head"},
            AutoAttack = nil,
            CheckTeam = false,
            CheckWhiteList = false,
            Distance = 20
      },
      RageBot = {
            CheckWhiteList = false
      },
      RocketControl = {
            Speed = 200
      },
      ESP = {
            Name = false,
            Box = nil,
            Weapon = nil,
            Chams = false,
            CheckTeam = false,
            Tools = nil,
            Scraps = nil,
            Crates = nil,
            Safes = nil
      }
}

local remotes = {
      fov_connection = nil;
      infstamina = nil;
      silentaim_circle = nil,
      silentaim_circlepos = nil,
      aimbot_circle = nil,
      aimbot_circlepos = nil,
      Speed_RUN = nil,
      aimbot_button = nil,
      meleeaura_body = nil,
      Aimbot_body = nil,
      Silentaim_body = nil,
      Altsfarm_respawnRUN = nil,
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
content:PreloadAsync({"rbxassetid://2084290015"})

game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Wecome to Ghost",
      Icon = "rbxassetid://83501732181441",
      Text = "Join to discord \n https://discord.gg/5XAn83XFJP",
      Duration = 10
})

local sound = Instance.new("Sound")
sound.Parent = game:GetService("SoundService")
sound.SoundId = "rbxassetid://"..RandSound[rand]
sound:Play()
sound.Ended:Connect(function()
      sound:Destroy()
end)

local Gui = Instance.new("ScreenGui")
local s, e = pcall(function() Gui.Parent = game.CoreGui end) if not s then Gui.Parent = me.PlayerGui end
Gui.Name = Decrypt(10)
Gui.Enabled = true
Gui.ResetOnSpawn = false

local OCmenubutton = Instance.new("ImageButton")
OCmenubutton.Parent = Gui
OCmenubutton.Name = "Open/Close"
OCmenubutton.BackgroundColor3 = Color3.new(0, 0, 0)
OCmenubutton.Position = UDim2.new(0.368, 0, -0.07, 0)
OCmenubutton.Size = UDim2.new(0.025, 0, 0.048, 0)
OCmenubutton.Image = "rbxassetid://83501732181441"
OCmenubutton.Visible = true

local uicocmenubutton = Instance.new("UICorner")
uicocmenubutton.Parent = OCmenubutton
uicocmenubutton.CornerRadius = UDim.new(8, 8)

local uisocmenubutton = Instance.new("UIStroke")
uisocmenubutton.Parent = OCmenubutton
uisocmenubutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisocmenubutton.Color = Color3.new(1, 1, 1)
uisocmenubutton.LineJoinMode = Enum.LineJoinMode.Round
uisocmenubutton.Thickness = 1

local dragg = Instance.new("Frame")
dragg.Parent = Gui
dragg.Name = "dragg"
dragg.BackgroundColor3 = Color3.new(0.0862745, 0.0862745, 0.0862745)
dragg.Position = UDim2.new(0.24, 0, 0.132, 0)
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
uiscdragg.Scale = 0.5

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
uiscmf.Scale = 0.75

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
HideButton.Size = UDim2.new(0.066, 0, 0.112, 0)
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
                        if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.Touch then
                              canuse = false
                        end
                  end)

                  input.InputChanged:Connect(function(key)
                        if canuse and (key.UserInputType == Enum.UserInputType.MouseMovement or key.UserInputType == Enum.UserInputType.Touch) then
                              local mpos = input:GetMouseLocation().X
                              local SCALE = (mpos - SectionSliderControl.AbsolutePosition.X)/SectionSliderControl.AbsoluteSize.X
                              local setscale = math.clamp(SCALE, 0.08, 1)
                              SectionSliderButton.Size = UDim2.fromScale(setscale, 1)
                              local value
                              value = math.clamp(minim + (SCALE * (maxim - minim)), minim, maximal)
                              VALUE.Text = math.floor(value)
                              FUNC(math.floor(value))
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

      function Functions:MakeSectionSlider(Parent, Text, Position, startertext, min, max, func)
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
            
            local canuse = false
            
            SliderButton.MouseButton1Down:Connect(function()
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
                        local SCALE = (mpos - SliderControl.AbsolutePosition.X)/SliderControl.AbsoluteSize.X
                        local setscale = math.clamp(SCALE, 0.08, 1)
                        SliderButton.Size = UDim2.fromScale(setscale, 1)
                        local value
                        value = math.clamp(min + (SCALE * (max - min)), min, max)
                        VALUE.Text = math.floor(value)
                        func(math.floor(value))
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
local SECTION3 = Functions:MakeSection(MainScroll, UDim2.new(0.529, 0, 0.473, 0), UDim2.new(0, 300, 0, 110))
local SECTION4 = Functions:MakeSection(MainScroll, UDim2.new(0.015, 0, 0.347, 0), UDim2.new(0, 300, 0, 350))
local SECTION5 = Functions:MakeSection(MainScroll, UDim2.new(0.531, 0, 0.371, 0), UDim2.new(0, 300, 0, 100))
local SECTION6 = Functions:MakeSection(VisualMenu, UDim2.new(0.018, 0, 0.02, 0), UDim2.new(0, 300, 0, 500))

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
local norecoilTurn = Functions:MakeTextButton(MainScroll, "norecoil", "No recoil", UDim2.new(0.521, 0, 0.582, 0), functions, "norecoilF")
local WallbangTurn = Functions:MakeTextButton(MainScroll, "Wallbang", "Wallbang", UDim2.new(0.016, 0, 0.746, 0), functions, "WallbangF", function()
      WallbangL()
end)
local glassarmsTurn = Functions:MakeTextButton(VisualMenu, "glassarms", "Glass arms", UDim2.new(0.53, 0, 0.019, 0), functions, "glassarmsF", function()
      glassarmsL()
end)
local glassarmscolor = Functions:MakeColorWheelButton(VisualMenu, UDim2.new(0.937, 0, 0.025, 0))

--// silent aim in section \\--
local silentaimTurn = Functions:MakeSectionButton(SECTION1, "silentaim", "Silent aim", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "silentaimF", function()
      SilentaimL()
end)
local silentaimdraw = Functions:MakeSectionCheckButton(SECTION1, "Draw", "Draw circle", UDim2.new(0.029, 0, 0.145, 0), SectionSettings.SilentAim, "Draw", true, "Size", UDim2.new(0, 0, 1.367, 0), tonumber(SectionSettings.SilentAim.DrawSize), 20, 300, function(val)
      SectionSettings.SilentAim.DrawSize = math.floor(val)
      if remotes.silentaim_circle then
            remotes.silentaim_circle.Radius = math.floor(val)
      end
end)
local silentaimdrawcolor = Functions:MakeColorWheelButton(SECTION1, UDim2.new(0.783, 0, 0.145, 0))
local silentaimpart = Functions:MakeSectionClickButton(SECTION1, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.398, 0), UDim2.new(0, 160, 0, 32), function()
      if remotes.Silentaim_body then
            remotes.Silentaim_body:Destroy()
            remotes.Silentaim_body = false
      else
            remotes.Silentaim_body = Functions:MakeBodySelector(SectionSettings.SilentAim.TargetPart)
      end
end)
local silentaimwallcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckWall", "Check wall", UDim2.new(0.029, 0, 0.523, 0), SectionSettings.SilentAim, "CheckWall", false, "", nil, nil, nil)
local silentaimteamcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckTeam", "Check team", UDim2.new(0.029, 0, 0.645, 0), SectionSettings.SilentAim, "CheckTeam", false, "", nil, nil, nil)
local silentaimwhitelistcheck = Functions:MakeSectionCheckButton(SECTION1, "CheckList", "Check white list", UDim2.new(0.029, 0, 0.766, 0), SectionSettings.SilentAim, "CheckList", false, "", nil, nil, nil)
local silentaimcheckdistance = Functions:MakeSectionCheckButton(SECTION1, "CheckDist", "Check distance", UDim2.new(0.029, 0, 0.882, 0), SectionSettings.SilentAim, "CheckDist", false, "", nil, nil, nil)

--// aimbot in section \\--
local aimbotTurn = Functions:MakeSectionButton(SECTION2, "aimbot", "Aim bot", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "aimbotF", function()
      aimbotL()
end)
local aimbotdraw = Functions:MakeSectionCheckButton(SECTION2, "Draw", "Draw circle", UDim2.new(0.029, 0, 0.158, 0), SectionSettings.AimBot, "Draw", true, "Size", UDim2.new(0, 0, 1.367, 0), tonumber(SectionSettings.AimBot.DrawSize), 20, 300, function(val)
      SectionSettings.AimBot.DrawSize = math.floor(val)
      if remotes.aimbot_circle then
            remotes.aimbot_circle.Radius = math.floor(val)
      end
end)
local aimbotdrawcolor = Functions:MakeColorWheelButton(SECTION2, UDim2.new(0.783, 0, 0.152, 0))
local aimbottargetpart = Functions:MakeSectionClickButton(SECTION2, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.369, 0), UDim2.new(0, 160, 0, 32), function()
      if remotes.Aimbot_body then
            remotes.Aimbot_body:Destroy()
            remotes.Aimbot_body = false
      else
            remotes.Aimbot_body = Functions:MakeBodySelector(SectionSettings.AimBot.TargetPart)
      end
end)
local aimbotcheckwall = Functions:MakeSectionCheckButton(SECTION2, "CheckWall", "Check wall", UDim2.new(0.025, 0, 0.473, 0), SectionSettings.AimBot, "CheckWall")
local aimbotcheckteam = Functions:MakeSectionCheckButton(SECTION2, "CheckTeam", "Check team", UDim2.new(0.025, 0, 0.586, 0), SectionSettings.AimBot, "CheckTeam")
local aimbotwhitelistcheck = Functions:MakeSectionCheckButton(SECTION2, "CheckList", "Check white list", UDim2.new(0.025, 0, 0.693, 0), SectionSettings.AimBot, "CheckWhiteList")
local aimbotcheckdist = Functions:MakeSectionCheckButton(SECTION2, "CheckDist", "Check distance", UDim2.new(0.025, 0, 0.798, 0), SectionSettings.AimBot, "CheckDistance")
local aimbotvelocity = Functions:MakeSectionCheckButton(SECTION2, "Velocity", "Velocity", UDim2.new(0.025, 0, 0.905, 0), SectionSettings.AimBot, "Velocity")

--// rocket control in section \\--
local rocketcontrolTurn = Functions:MakeSectionButton(SECTION3, "RocketControl", "Rocket control", UDim2.new(0.03, 0, 0.136, 0), UDim2.new(0, 160, 0, 32), functions, "rocket_controlF")
local rocketcontrolspeed = Functions:MakeSectionSlider(SECTION3, "Speed", UDim2.new(0.029, 0, 0.53, 0), tonumber(SectionSettings.RocketControl.Speed), 10, 200, function(val)
      SectionSettings.RocketControl.Speed = val
end)

--// melee aura in section \\--
local meleeauraTurn = Functions:MakeSectionButton(SECTION4, "meleeaura", "Melee aura", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "meleeauraF", function()
      meleeauraL()
end)
local meleeaurashomanim = Functions:MakeSectionCheckButton(SECTION4, "ShowAnim", "Show anim", UDim2.new(0.029, 0, 0.182, 0), SectionSettings.MeleeAura, "ShowAnim", false, "", nil, nil, nil)
local meleeauratargetpart = Functions:MakeSectionClickButton(SECTION4, "TargetPart", "Target part", UDim2.new(0.029, 0, 0.329, 0), UDim2.new(0, 160, 0, 32), function()
      if remotes.meleeaura_body then
            remotes.meleeaura_body:Destroy()
            remotes.meleeaura_body = false
      else
            remotes.meleeaura_body = Functions:MakeBodySelector(SectionSettings.AimBot.TargetPart)
      end
end)
local meleeauraautoattack = Functions:MakeSectionCheckButton(SECTION4, "AutoAttack", "Auto attack", UDim2.new(0.029, 0, 0.468, 0))
local meleeaurateamcheck = Functions:MakeSectionCheckButton(SECTION4, "CheckTeam", "Check team", UDim2.new(0.029, 0, 0.6, 0), SectionSettings.MeleeAura, "CheckTeam", false, "", nil, nil, nil)
local meleeaurawhitelistcheck = Functions:MakeSectionCheckButton(SECTION4, "CheckList", "Check white list", UDim2.new(0.029, 0, 0.739, 0), SectionSettings.MeleeAura, "CheckWhiteList", false, "", nil, nil, nil)
local meleeauradist = Functions:MakeSectionSlider(SECTION4, "Distance", UDim2.new(0.029, 0, 0.875, 0), tonumber(SectionSettings.MeleeAura.Distance), 5, 20, function(val)
      SectionSettings.MeleeAura.Distance = val
end)

--// rage-bot in section \\--
local ragebotTurn = Functions:MakeSectionButton(SECTION5, "RageBot", "Rage bot", UDim2.new(0.034, 0, 0.102, 0), UDim2.new(0, 160, 0, 32), functions, "RagebotF", function()
      RagebotL()
end)
local ragebotwhitelistcheck = Functions:MakeSectionCheckButton(SECTION5, "CheckList", "Check white list", UDim2.new(0.033, 0, 0.57, 0), SectionSettings.RageBot, "CheckWhiteList", false, "", nil, nil, nil)

--// esp in section \\--
local espTurn = Functions:MakeSectionButton(SECTION6, "ESP", "ESP", UDim2.new(0.03, 0, 0.022, 0), UDim2.new(0, 160, 0, 32), functions, "EspF", function()
      EspL()
end)
local espName = Functions:MakeSectionCheckButton(SECTION6, "Name", "Name", UDim2.new(0.029, 0, 0.149, 0), SectionSettings.ESP, "Name", false, "", nil, nil, nil)
local espBox = Functions:MakeSectionCheckButton(SECTION6, "Box", "Box", UDim2.new(0.029, 0, 0.236, 0), SectionSettings.ESP, "Box", false, "", nil, nil, nil)
local espWeapon = Functions:MakeSectionCheckButton(SECTION6, "Weapon", "Weapon", UDim2.new(0.029, 0, 0.344, 0), SectionSettings.ESP, "Weapon", false, "", nil, nil, nil)
local espChams = Functions:MakeSectionCheckButton(SECTION6, "Chams", "Chams", UDim2.new(0.029, 0, 0.449, 0), SectionSettings.ESP, "Chams", false, "", nil, nil, nil)
local espTeamCheck = Functions:MakeSectionCheckButton(SECTION6, "CheckTeam", "Team check", UDim2.new(0.029, 0, 0.541, 0), SectionSettings.ESP, "CheckTeam", false, "", nil, nil, nil)
local espTools = Functions:MakeSectionCheckButton(SECTION6, "Tools", "Tools", UDim2.new(0.029, 0, 0.63, 0), SectionSettings.ESP, "Tools", false, "", nil, nil, nil)
local espScraps = Functions:MakeSectionCheckButton(SECTION6, "Scraps", "Scraps", UDim2.new(0.029, 0, 0.732, 0), SectionSettings.ESP, "Scraps", false, "", nil, nil, nil)
local espCrates = Functions:MakeSectionCheckButton(SECTION6, "Crates", "Crates", UDim2.new(0.029, 0, 0.826, 0), SectionSettings.ESP, "Crates", false, "", nil, nil, nil)
local espSafes = Functions:MakeSectionCheckButton(SECTION6, "Safes", "Safes", UDim2.new(0.029, 0, 0.916, 0), SectionSettings.ESP, "Safes", false, "", nil, nil, nil)

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
      {button = ragebotTurn, func = functions, name = "RagebotF", section = true},
      {button = WallbangTurn, func = functions, name = "WallbangF", section = false}
}

local INDEX2 = {
      {button = silentaimteamcheck, func = SectionSettings.SilentAim, "CheckTeam"},
      {button = silentaimwhitelistcheck, func = SectionSettings.SilentAim, "CheckList"},
      {button = aimbotdraw, func = SectionSettings.AimBot, name = "Draw"},
      {button = aimbotcheckwall, func = SectionSettings.AimBot, name = "CheckWall"},
      {button = aimbotcheckteam, func = SectionSettings.AimBot, name = "CheckTeam"},
      {button = aimbotwhitelistcheck, func = SectionSettings.AimBot, name = "CheckWhiteList"},
      {button = aimbotcheckdist, func = SectionSettings.AimBot, name = "CheckDistance"},
      {button = aimbotvelocity, func = SectionSettings.AimBot, name = "Velocity"},
      {button = ragebotwhitelistcheck, func = SectionSettings.RageBot, name = "CheckWhiteList"},
      {button = meleeaurashomanim, func = SectionSettings.MeleeAura, name = "ShowAnim"},
      {button = meleeaurateamcheck, func = SectionSettings.MeleeAura, name = "CheckTeam"},
      {button = meleeaurawhitelistcheck, func = SectionSettings.MeleeAura, name = "CheckWhiteList"},
      {button = espName, func = SectionSettings.ESP, name = "Name"},
      {button = espBox, func = SectionSettings.ESP, name = "Box"},
      {button = espWeapon, func = SectionSettings.ESP, name = "Weapon"},
      {button = espChams, func = SectionSettings.ESP, name = "Chams"},
      {button = espTeamCheck, func = SectionSettings.ESP, name = "CheckTeam"},
      {button = espTools, func = SectionSettings.ESP, name = "Tools"},
      {button = espScraps, func = SectionSettings.ESP, name = "Scraps"},
      {button = espCrates, func = SectionSettings.ESP, name = "Crates"},
      {button = espSafes, func = SectionSettings.ESP, name = "Safes"}
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

local WhiteAdd = Instance.new("TextLabel")
WhiteAdd.Parent = SettingsMenu
WhiteAdd.Name = "WhiteList"
WhiteAdd.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
WhiteAdd.Position = UDim2.new(0.016, 0, 0.022, 0)
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

local AltsFarm = Instance.new("TextLabel")
AltsFarm.Parent = FarmMenu
AltsFarm.Name = "AltsFarm"
AltsFarm.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
AltsFarm.Position = UDim2.new(0.016, 0, 0.193, 0)
AltsFarm.Size = UDim2.new(0, 270, 0, 32)
AltsFarm.TextScaled = true
AltsFarm.TextColor3 = Color3.new(1, 1, 1)
AltsFarm.Text = "Alt accounts farm"
AltsFarm.Visible = true

local uicaltsfarm = Instance.new("UICorner")
uicaltsfarm.Parent = AltsFarm
uicaltsfarm.CornerRadius = UDim.new(8, 8)

local NameAltsfarm = Instance.new("TextBox")
NameAltsfarm.Parent = AltsFarm
NameAltsfarm.Name = "Name"
NameAltsfarm.BackgroundColor3 = Color3.new(0, 0, 0)
NameAltsfarm.Position = UDim2.new(0, 0, 1.289, 0)
NameAltsfarm.Size = UDim2.new(0, 270, 0, 30)
NameAltsfarm.TextEditable = true
NameAltsfarm.ClearTextOnFocus = false
NameAltsfarm.TextScaled = true
NameAltsfarm.TextColor3 = Color3.new(1, 1, 1)
NameAltsfarm.Text = ""
NameAltsfarm.PlaceholderColor3 = Color3.new(0.533333, 0.533333, 0.533333)
NameAltsfarm.PlaceholderText = "Write name of main account"
NameAltsfarm.Visible = true

local uicnamealtsfarm = Instance.new("UICorner")
uicnamealtsfarm.Parent = NameAltsfarm
uicnamealtsfarm.CornerRadius = UDim.new(8, 8)

local uisnamealtsfarm = Instance.new("UIStroke")
uisnamealtsfarm.Parent = NameAltsfarm
uisnamealtsfarm.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisnamealtsfarm.Color = Color3.new(1, 1, 1)
uisnamealtsfarm.LineJoinMode = Enum.LineJoinMode.Round
uisnamealtsfarm.Thickness = 1

local StartAltsfarm = Instance.new("ImageButton")
StartAltsfarm.Parent = AltsFarm
StartAltsfarm.Name = "Start"
StartAltsfarm.BackgroundColor3 = Color3.new(0.0156863, 1, 0)
StartAltsfarm.Position = UDim2.new(1.065, 0, -0.039, 0)
StartAltsfarm.Size = UDim2.new(0, 38, 0, 38)
StartAltsfarm.Image = "http://www.roblox.com/asset/?id=90624860933410"
StartAltsfarm.ImageColor3 = Color3.new(0, 0, 0)

local uicstartaltsfarm = Instance.new("UICorner")
uicstartaltsfarm.Parent = StartAltsfarm
uicstartaltsfarm.CornerRadius = UDim.new(8, 8)

local uisstartaltsfarm = Instance.new("UIStroke")
uisstartaltsfarm.Parent = StartAltsfarm
uisstartaltsfarm.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisstartaltsfarm.Color = Color3.new(1, 1, 1)
uisstartaltsfarm.LineJoinMode = Enum.LineJoinMode.Round
uisstartaltsfarm.Thickness = 1

local StopAltsFarm = Instance.new("ImageButton")
StopAltsFarm.Parent = AltsFarm
StopAltsFarm.Name = "Stop"
StopAltsFarm.BackgroundColor3 = Color3.new(1, 1, 1)
StopAltsFarm.Position = UDim2.new(1.287, 0, -0.039, 0)
StopAltsFarm.Size = UDim2.new(0, 38, 0, 38)
StopAltsFarm.Image = "rbxassetid://101396568884110"
StopAltsFarm.ImageColor3 = Color3.new(1, 0, 0)
StopAltsFarm.Visible = true

local uicstopaltsfarm = Instance.new("UICorner")
uicstopaltsfarm.Parent = StopAltsFarm
uicstopaltsfarm.CornerRadius = UDim.new(8, 8)

local uisstopaltsfarm = Instance.new("UIStroke")
uisstopaltsfarm.Parent = StopAltsFarm
uisstopaltsfarm.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uisstopaltsfarm.Color = Color3.new(1, 1, 1)
uisstopaltsfarm.LineJoinMode = Enum.LineJoinMode.Round
uisstopaltsfarm.Thickness = 1

local GlockSkin = Functions:AddSkin(gunsList, "Glock", "Glock - Anime girl")
local KatanaSkin = Functions:AddSkin(meleesList, "Katana", "Katana - hz")

local Commands = {
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

function AltsFarmL()
      local respawn = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("DeathRespawn")
      local anim

      function Start(Name)
            local mainAcc = plrs:FindFirstChild(tostring(Name))

            local function onCharacterAdded(character)
                  local hum = character:FindFirstChildOfClass("Humanoid")
                  local hrp = character:FindFirstChild("HumanoidRootPart")
                  if not hum or not hrp then return end

                  if functions.AltsFarmF then
                        local mainCharacter = mainAcc.Character
                        if mainCharacter then
                              local mainHRP = mainCharacter:FindFirstChild("HumanoidRootPart")
                              if mainHRP then
                                    anim = tween:Create(hrp, TweenInfo.new(1.3), {CFrame = CFrame.new(mainHRP.Position + mainHRP.CFrame.LookVector * 3)})
                                    anim:Play()
                                    anim.Completed:Connect(function()
                                          if functions.AltsFarmF then
                                                anim:Play()
                                          end
                                    end)
                                    hum:GetPropertyChangedSignal("Health"):Connect(function()
                                          if functions.AltsFarmF then      
                                                hum.Health = 0
                                          end
                                    end)
                              end
                        end
                  end
            end

            if me.Character then
                  if functions.AltsFarmF then
                        onCharacterAdded(me.Character)
                  end
            end

            me.CharacterAdded:Connect(function()
                  if functions.AltsFarmF then
                        wait(.5)
                        onCharacterAdded(me.Character)
                        local tool = me.Backpack:FindFirstChildOfClass("Tool")
                        if tool then
                              tool.Parent = me.Character
                        end
                  end
            end)

            remotes.Altsfarm_respawnRUN = run.RenderStepped:Connect(function()
                  local char = me.Character
                  if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health  <= 0 then
                              respawn:InvokeServer("KMG4R904")
                        end
                  end
            end)
      end

      function Stop()
            if anim then
                  anim:Cancel()
                  anim = nil
            end

            if remotes.Altsfarm_respawnRUN then
                  remotes.Altsfarm_respawnRUN:Disconnect()
                  remotes.Altsfarm_respawnRUN = nil
            end
      end

      if functions.AltsFarmF == true then
            local getname = NameAltsfarm.Text
            local MainName = plrs:FindFirstChild(tostring(getname))
            if MainName then
                  Start(MainName)
            else
                  ConsoleText("Not found", "error")
            end
      else
            Stop()
            ConsoleText("Stop", "text")
      end
end

function SilentaimL()
      if functions.silentaimF then
            local part
            local randpart = nil
            local LastTick = tick()
            local camera = workspace.CurrentCamera

            local function UrTargetFunc()
                  if not functions.silentaimF then
                        return nil 
                  end

                  local closestPlayer = nil
                  local minDistance = math.huge

                  local centerPos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

                  for _, player in ipairs(plrs:GetPlayers()) do
                        if player == me or not player.Character then 
                              continue 
                        end

                        if SectionSettings.SilentAim.CheckTeam and player.Team == me.Team then
                              continue
                        end

                        if SectionSettings.SilentAim.CheckList and table.find(WhiteList, player) then
                              continue
                        end

                        local count = #SectionSettings.SilentAim.TargetPart

                        if count == 0 then
                              part = "Head"
                        elseif count == 1 then
                              part = SectionSettings.SilentAim.TargetPart[count]
                        elseif count > 1 then
                              if tick() - LastTick >= 0.5 then
                                    local rand = math.random(1, count)
                                    randpart = SectionSettings.SilentAim.TargetPart[rand]
                                    LastTick = tick()
                              end
                              part = randpart or SectionSettings.SilentAim.TargetPart[1]
                        end

                        local character = player.Character
                        local getpart = character:FindFirstChild(part)
                        if getpart then
                              local screenPos, onScreen = camera:WorldToViewportPoint(getpart.Position)
                              if onScreen then
                                    local distance = (centerPos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                                    if distance < minDistance then
                                          minDistance = distance
                                          closestPlayer = player
                                    end
                              end
                        end
                  end

                  return closestPlayer
            end

            local VisualizeEvent = game:GetService("ReplicatedStorage").Events2.Visualize
            local DamageEvent = game:GetService("ReplicatedStorage").Events.ZFKLF_H

            VisualizeEvent.Event:Connect(function(...)
                  local Args = { ... }
                  local ShotCode = Args[2] or ""
                  local Gun = Args[4] or nil
                  local BulletsPerShot = tonumber(Args[7]) or 1
                  local StartPos = Args[6] or Vector3.new()

                  if not Gun then 
                        return 
                  end

                  local Target = UrTargetFunc()
                  if not Target or not Target.Character then 
                        return 
                  end

                  if Target and Target.Character and not Target.Character:FindFirstChildOfClass("ForceField") then
                        local HitPart = Target.Character:FindFirstChild("Hitpart") or Target.Character:FindFirstChild(part)
                        if not HitPart then 
                              return 
                        end

                        local HitPos = HitPart.Position

                        local Bullets = {}
                        for _ = 1, math.clamp(BulletsPerShot, 1, 100) do
                              table.insert(Bullets, CFrame.new(StartPos, HitPos).LookVector)
                        end

                        task.wait(0.005)

                        if DamageEvent and typeof(DamageEvent.FireServer) == "function" then
                              for Index, LookVector in ipairs(Bullets) do
                                    DamageEvent:FireServer(
                                          "\240\159\141\175",
                                          Gun,
                                          ShotCode,
                                          Index,
                                          HitPart,
                                          HitPos,
                                          LookVector
                                    )
                              end
                        end

                        if Gun:FindFirstChild("Hitmarker") then
                              Gun.Hitmarker:Fire(HitPart)
                        end
                  end
            end)
      end
end

function FullbrightL()
      if functions.FullbrightF == true then
            light.ExposureCompensation = 1
      elseif functions.FullbrightF == false then
            light.ExposureCompensation = 0
      end
end

function WallbangL()
      if functions.WallbangF then
            game:service[[Workspace]]:FindFirstChild('Map'):FindFirstChild('Parts'):FindFirstChild('M_Parts').Parent = game:service[[Workspace]]:FindFirstChild('Characters')
      else
            game:service[[Workspace]]:FindFirstChild('Characters'):FindFirstChild("M_Parts").Parent = game:service[[Workspace]]:FindFirstChild("Map"):FindFirstChild("Parts")
      end
end

function Open_doorsL()
      if functions.AutoOpenDoorsF then
            while functions.AutoOpenDoorsF do
                  if not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
                        me.Character = me.Character or me.CharacterAdded:Wait()
                        me.Character:WaitForChild("HumanoidRootPart")
                  end
                  local hrp = me.Character:FindFirstChild("HumanoidRootPart")
                  if not hrp then
                        run.RenderStepped:Wait()
                        continue
                  end

                  local function GetDoor()
                        local mapFolder = workspace:FindFirstChild("Map")
                        if not mapFolder then return nil end
                        local folderDoors = mapFolder:FindFirstChild("Doors")
                        if not folderDoors then return nil end

                        local closestDoor, dist = nil, 15
                        for _, door in pairs(folderDoors:GetChildren()) do
                              local doorBase = door:FindFirstChild("DoorBase")
                              if doorBase then
                                    local distance = (hrp.Position - doorBase.Position).Magnitude
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
                                                local knob1pos = (hrp.Position - knob1.Position).Magnitude
                                                local knob2pos = (hrp.Position - knob2.Position).Magnitude
                                                local chosenKnob = (knob1pos < knob2pos) and knob1 or knob2
                                                toggleEvent:FireServer("Open", chosenKnob)
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
            if remotes.infstamina then remotes.infstamina:Disconnect() end; remotes.infstamina = nil
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

function RagebotL()
      local function RandomString(length)
            local res = ""
            for i = 1, length do
                  res = res .. string.char(math.random(97, 122))
            end
            return res
      end

      local function GetClosestEnemy()
            if not me.Character 
                  or not me.Character:FindFirstChild("HumanoidRootPart") 
            then return nil end

            local closestEnemy = nil
            local shortestDistance = 100

            for _, player in pairs(plrs:GetPlayers()) do
                  if player == me then continue end

                  local character = player.Character
                  local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                  local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                  if character 
                        and rootPart 
                        and humanoid 
                        and humanoid.Health > 15 
                        and not character:FindFirstChildOfClass("ForceField") 
                  then

                        if SectionSettings.RageBot.CheckWhiteList and table.find(WhiteList, player) then
                              continue
                        end

                        local distance = (rootPart.Position - me.Character.HumanoidRootPart.Position).Magnitude
                        if distance < shortestDistance then
                              shortestDistance = distance
                              closestEnemy = player
                        end
                  end
            end
            return closestEnemy
      end

      local function Shoot(target)
            if not target or not target.Character then return end

            local head = target.Character:FindFirstChild("Head")
            if not head then return end

            local tool = me.Character and me.Character:FindFirstChildOfClass("Tool")
            if not tool then return end

            local values = tool:FindFirstChild("Values")
            local hitMarker = tool:FindFirstChild("Hitmarker")
            if not values or not hitMarker then return end

            local ammo = values:FindFirstChild("SERVER_Ammo")
            local storedAmmo = values:FindFirstChild("SERVER_StoredAmmo")
            if not ammo or not storedAmmo then return end

            local hitPosition = head.Position
            local hitDirection = (hitPosition - camera.CFrame.Position).unit
            local randomKey = RandomString(30) ..0

            if ammo.Value > 0 then
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
                              head,
                              hitPosition,
                              hitDirection,
                              nil,
                              nil
                        )

                        ammo.Value = math.max(ammo.Value - 1, 0)
                        hitMarker:Fire(head)
                        storedAmmo.Value = values:FindFirstChild("SERVER_StoredAmmo").Value
                  end)
            end
      end

      local function RageBotLoop()
            while functions.RagebotF do
                  if me.Character and me.Character:FindFirstChildOfClass("Tool") then
                        local target = GetClosestEnemy()
                        if target then
                              Shoot(target)
                        end
                  end
                  run.RenderStepped:Wait()
            end
      end
      RageBotLoop()
end

function EspL()
      local TextService = game:GetService("TextService")

      local trackedPlayers = {}
      local TEXT_OFFSET = Vector2.new(0, -30)

      local function updatePlayerEsp(player, data)
            local character = player.Character
            if not character then
                  if data.chams then 
                        data.chams:Destroy() 
                        data.chams = nil 
                  end
                  return
            end

            if SectionSettings.ESP.CheckTeam and player.Team == me.Team then
                  if data.chams then 
                        data.chams:Destroy() 
                        data.chams = nil 
                  end
                  if data.text then 
                        data.text:Remove() 
                        data.text = nil 
                  end
                  return
            end

            if SectionSettings.ESP.Chams then
                  if not data.chams or data.chams.Parent ~= character then
                        if data.chams then 
                              data.chams:Destroy() 
                        end
                        local highlight = Instance.new("Highlight")
                        highlight.FillTransparency = 1
                        highlight.Parent = character
                        data.chams = highlight
                  end
            else
                  if data.chams then
                        data.chams:Destroy()
                        data.chams = nil
                  end
            end

            if SectionSettings.ESP.Name then
                  if not data.text then
                        local text = Drawing.new("Text")
                        text.Visible = false
                        text.Size = 12
                        text.Color = Color3.new(1, 1, 1)
                        text.Outline = true
                        text.Center = true
                        data.text = text
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
                  end
            else
                  if data.text then
                        data.text:Remove()
                        data.text = nil
                  end
            end
      end

      local function createEsp(player)
            if trackedPlayers[player] then return end
            trackedPlayers[player] = {
                  chams = nil,
                  text = nil,
            }
      end

      local function removeEsp(player)
            if trackedPlayers[player] then
                  if trackedPlayers[player].chams then
                        trackedPlayers[player].chams:Destroy()
                  end
                  if trackedPlayers[player].text then
                        trackedPlayers[player].text:Remove()
                  end
                  trackedPlayers[player] = nil
            end
      end

      for _, player in ipairs(plrs:GetPlayers()) do
            if player ~= me then
                  createEsp(player)
            end
      end

      plrs.PlayerAdded:Connect(function(player)
            if player ~= me then
                  createEsp(player)
            end
      end)

      plrs.PlayerRemoving:Connect(removeEsp)

      local heartbeatConnection
      heartbeatConnection = run.Heartbeat:Connect(function()
            if not functions.EspF then
                  for player, data in pairs(trackedPlayers) do
                        if data.chams then data.chams:Destroy() end
                        if data.text then data.text:Remove() end
                  end
                  trackedPlayers = {}
                  heartbeatConnection:Disconnect()
                  return
            end

            for player, data in pairs(trackedPlayers) do
                  updatePlayerEsp(player, data)
            end
      end)
end

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
      
      local part
      local randpart = nil
      local LastTick = tick()
      
      function Attack(target)
            if not (target and target:FindFirstChild("Head")) then return end

            local mychar = me.Character
            if not mychar then return end
            local TOOL = mychar:FindFirstChildOfClass("Tool")

            if not TOOL then return end

            local arg1 = {
                  [1] = "🍞",
                  [2] = tick(),
                  [3] = TOOL,
                  [4] = "43TRFWX",
                  [5] = "Normal",
                  [6] = tick(),
                  [7] = true
            }

            local result = remote1:InvokeServer(unpack(arg1))

            task.wait(0.35 + math.random() * 0.2)

            if TOOL then
                  local Handle = TOOL:FindFirstChild("WeaponHandle") or TOOL:FindFirstChild("Handle") or me.Character:FindFirstChild("Right Arm")
                  local arg2 = {
                        [1] = "🍞",
                        [2] = tick(),
                        [3] = TOOL,
                        [4] = "2389ZFX34",
                        [5] = result,
                        [6] = false,
                        [7] = Handle,
                        [8] = target[SectionSettings.MeleeAura.TargetPart],
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
                                                if distance < SectionSettings.MeleeAura.Distance and a.Character:FindFirstChildOfClass("Humanoid").Health > 15 and not char:FindFirstChildOfClass("ForceField") then

                                                      if SectionSettings.MeleeAura.CheckWhiteList and table.find(WhiteList, a) then
                                                            continue
                                                      end

                                                      if SectionSettings.MeleeAura.CheckTeam and a.Team == me.Team then
                                                            continue
                                                      end
                                                      
                                                      local count = #SectionSettings.MeleeAura.TargetPart
                                                      
                                                      if count == 0 then
                                                            part = "Head"
                                                      elseif count == 1 then
                                                            part = SectionSettings.MeleeAura.TargetPart[count]
                                                      elseif count > 1 then
                                                            if tick() - LastTick >= .5 then
                                                                  local rand = math.random(1, count)
                                                                  randpart = SectionSettings.MeleeAura.TargetPart[rand]
                                                                  LastTick = tick()
                                                            end
                                                            part = randpart or SectionSettings.MeleeAura.TargetPart[1]
                                                      end

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
            remotes.aimbot_button = Instance.new("TextButton")
            remotes.aimbot_button.Parent = Gui
            remotes.aimbot_button.Name = "Aim"
            remotes.aimbot_button.BackgroundColor3 = Color3.new(0, 0, 0)
            remotes.aimbot_button.Position = UDim2.new(0.689, 0, 0.521, 0)
            remotes.aimbot_button.Size = UDim2.new(0.025, 0, 0.048, 0)
            remotes.aimbot_button.TextSize = 10
            remotes.aimbot_button.TextColor3 = Color3.new(1, 1, 1)
            remotes.aimbot_button.Text = "Aim"
            remotes.aimbot_button.Visible = true

            local uicaimbotbutton = Instance.new("UICorner")
            uicaimbotbutton.Parent = remotes.aimbot_button
            uicaimbotbutton.CornerRadius = UDim.new(8, 8)

            local uisaimbotbutton = Instance.new("UIStroke")
            uisaimbotbutton.Parent = remotes.aimbot_button
            uisaimbotbutton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uisaimbotbutton.Color = Color3.new(1, 1, 1)
            uisaimbotbutton.LineJoinMode = Enum.LineJoinMode.Round
            uisaimbotbutton.Thickness = 1
            
            local target = nil
            local pressed = false
            local aimtarget
            local canusing = false
            local FirstPerson = true
            local predict = 15
            
            local part
            local randpart = nil
            local LastTick = tick()

            remotes.aimbot_circle = Drawing.new("Circle")
            remotes.aimbot_circle.Color = Color3.fromRGB(255, 0, 0)
            remotes.aimbot_circle.Thickness = 2
            remotes.aimbot_circle.NumSides = 50
            remotes.aimbot_circle.Radius = SectionSettings.AimBot.DrawSize
            remotes.aimbot_circle.Filled = false
            remotes.aimbot_circle.Visible = true

            local function getClosestTarget()
                  local closest, closestDist = nil, SectionSettings.AimBot.DrawSize
                  for _, player in pairs(plrs:GetPlayers()) do
                        if player ~= me and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                              
                              local count = #SectionSettings.AimBot.TargetPart
                              
                              if count == 0 then
                                    part = "Head"
                              elseif count == 1 then
                                    part = SectionSettings.AimBot.TargetPart[count]
                              elseif count > 1 then
                                    if tick() - LastTick >= .5 then
                                          local rand = math.random(1, count)
                                          randpart = SectionSettings.AimBot.TargetPart[rand]
                                          LastTick = tick()
                                    end
                                    part = randpart or SectionSettings.AimBot.TargetPart[1]
                              end
                              
                              local pos, onScreen = camera:WorldToViewportPoint(player.Character:FindFirstChild(part).Position)
                              if onScreen then
                                    if SectionSettings.AimBot.CheckTeam and player.Team == me.Team then
                                          continue
                                    end
                                    if SectionSettings.AimBot.CheckWhiteList and table.find(WhiteList, player) then
                                          continue
                                    end
                                    local centerScreen = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                                    local distance = (Vector2.new(pos.X, pos.Y) - centerScreen).Magnitude
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
                  local centerScreen = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                  remotes.aimbot_circle.Position = centerScreen
            end)

            remotes.aimbot_button.MouseButton1Click:Connect(function()
                  pressed = not pressed
                  aimtarget = getClosestTarget() or nil
            end)

            run.RenderStepped:Connect(function()
                  if FirstPerson then
                        local magnitude = (camera.Focus.p - camera.CFrame.p).Magnitude
                        canusing = magnitude <= 1.5
                  end
                  if functions.aimbotF and pressed and aimtarget and aimtarget.Character then
                        local head = aimtarget.Character:FindFirstChild(part)
                        local humanoid = aimtarget.Character:FindFirstChild("Humanoid")
                        if head and humanoid and humanoid.Health > 0 and canusing then
                              local targetPosition = head.Position
                              if SectionSettings.AimBot.Velocity then
                                    targetPosition = targetPosition + head.Velocity / predict
                              end
                              camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.p, targetPosition), 0.9)
                        end
                  end
            end)
      else
            if remotes.aimbot_circle then 
                  remotes.aimbot_circle:Remove() 
            end
            remotes.aimbot_circle = nil
            if remotes.aimbot_circlepos then 
                  remotes.aimbot_circlepos:Disconnect() 
            end
            remotes.aimbot_circlepos = nil
            if remotes.aimbot_button then 
                  remotes.aimbot_button:Destroy() 
            end
            remotes.aimbot_button = nil
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

StartAltsfarm.MouseButton1Click:Connect(function()
      functions.AltsFarmF = true
      AltsFarmL()
end)

StopAltsFarm.MouseButton1Click:Connect(function()
      functions.AltsFarmF = false
      AltsFarmL()
end)

function UpdateFunctions()
end

OCmenubutton.MouseButton1Click:Connect(function()
      dragg.Visible = not dragg.Visible
end)
