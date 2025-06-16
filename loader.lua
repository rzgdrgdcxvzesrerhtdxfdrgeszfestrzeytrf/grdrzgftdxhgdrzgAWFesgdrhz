local https = game:GetService("HttpService")
local link = "https://weareghost.glitch.me"
local script_name = "loader"

local pw = {"httpspy", "spy", "requests"}

_G.SN = "aks-keysystem"

local checked = false

local function SendNotif(title, text)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = 5
	})
end

local result1 = game:HttpGetAsync(link.."/load/".."guard")
local body1 = https:JSONDecode(result1)
if body1 then
	if shared.canload then
		shared.canload = true
		repeat wait() until shared.canload == true
	end
	if _G.LS then
		_G.LS(game:HttpGet(body1.url))()
		_G.AW("loaded")
	else
		loadstring(game:HttpGet(body1.url))()
		_G.AW("loaded")
	end
end

pcall(function()
	for _, a in pairs(game:GetService("CoreGui"):GetDescendants()) do
		if a:IsA("TextLabel") then
			for ____, i  in pairs(pw) do
				if string.find(string.lower(a.Text), i) then
					game:Shutdown()
				end
			end
		end
	end
end)

local function CheckConnection()
	if checked == false then
		checked = true
		local body = game:HttpGetAsync(link.."/check-server-connection")
		if body then
			local result = https:JSONDecode(body)
			if result and result.status == "ok" then
				SendNotif("Server connection", "🟢 server connected")
			else
				SendNotif("Server connection", "🔴 connection failed")
			end
		end
	end
end

CheckConnection()

local result2 = game:HttpGetAsync(link.."/load/"..script_name)
local body2 = https:JSONDecode(result2)

if body2 then
	shared.canload = true
	repeat wait() until shared.canload == true
	_G.LS(game:HttpGet(body2.url))()
end
