--[[

	Universal Aimbot Module
	Original by Exunys © CC0
	Optimized rewrite (2026) @olmac16

]]

--// Cache & Locals

local game = game
local workspace = workspace
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Vector2new = Vector2.new
local Vector3zero = Vector3.zero
local CFramenew = CFrame.new
local Color3fromRGB = Color3.fromRGB
local Color3fromHSV = Color3.fromHSV
local Drawingnew = Drawing.new
local TweenInfonew = TweenInfo.new

local math_clamp = math.clamp
local string_lower = string.lower
local string_sub = string.sub
local table_find = table.find
local table_remove = table.remove

local mousemoverel = mousemoverel or (Input and Input.MouseMove)
local getgenv = getgenv
local tick = tick

--// Prevent multiple instances

if getgenv().ExunysDeveloperAimbot and getgenv().ExunysDeveloperAimbot.Exit then
	getgenv().ExunysDeveloperAimbot:Exit()
end

--// Environment

local Aimbot = {
	DeveloperSettings = {
		UpdateMode = "RenderStepped",
		TeamCheckOption = "TeamColor",
		RainbowSpeed = 1
	},

	Settings = {
		Enabled = true,
		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,

		OffsetToMoveDirection = false,
		OffsetIncrement = 15,

		Sensitivity = 0,
		Sensitivity2 = 3.5,

		LockMode = 1,
		LockPart = "Head",

		TriggerKey = Enum.UserInputType.MouseButton2,
		Toggle = false
	},

	FOVSettings = {
		Enabled = true,
		Visible = true,

		Radius = 90,
		NumSides = 60,

		Thickness = 1,
		Transparency = 1,
		Filled = false,

		RainbowColor = false,
		RainbowOutlineColor = false,

		Color = Color3fromRGB(255, 255, 255),
		OutlineColor = Color3fromRGB(0, 0, 0),
		LockedColor = Color3fromRGB(255, 150, 150)
	},

	Blacklisted = {},
	FOVCircle = Drawingnew("Circle"),
	FOVCircleOutline = Drawingnew("Circle")
}

getgenv().ExunysDeveloperAimbot = Aimbot

--// Internal State

local Running = false
local Typing = false
local LockedPlayer = nil
local RequiredDistance = 2000
local OriginalSensitivity = UserInputService.MouseDeltaSensitivity
local ActiveTween = nil

local Connections = {}

--// Utility

local function GetRainbowColor()
	local speed = Aimbot.DeveloperSettings.RainbowSpeed
	return Color3fromHSV((tick() % speed) / speed, 1, 1)
end

local function CancelLock()
	LockedPlayer = nil

	if ActiveTween then
		ActiveTween:Cancel()
		ActiveTween = nil
	end

	UserInputService.MouseDeltaSensitivity = OriginalSensitivity
	Aimbot.FOVCircle.Color = Aimbot.FOVSettings.Color
end

--// Target Acquisition

local function GetClosestPlayer()
	local settings = Aimbot.Settings
	local fov = Aimbot.FOVSettings
	local mousePos = UserInputService:GetMouseLocation()

	RequiredDistance = fov.Enabled and fov.Radius or 2000
	LockedPlayer = nil

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer
			and not table_find(Aimbot.Blacklisted, player.Name) then

			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local part = character and character:FindFirstChild(settings.LockPart)

			if humanoid and part then
				if settings.TeamCheck
					and player[Aimbot.DeveloperSettings.TeamCheckOption]
					== LocalPlayer[Aimbot.DeveloperSettings.TeamCheckOption] then
					continue
				end

				if settings.AliveCheck and humanoid.Health <= 0 then
					continue
				end

				if settings.WallCheck then
					local blacklist = {}
					for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
						blacklist[#blacklist + 1] = v
					end
					for _, v in ipairs(character:GetDescendants()) do
						blacklist[#blacklist + 1] = v
					end

					if #Camera:GetPartsObscuringTarget({ part.Position }, blacklist) > 0 then
						continue
					end
				end

				local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
				if onScreen then
					local dist = (Vector2new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if dist < RequiredDistance then
						RequiredDistance = dist
						LockedPlayer = player
					end
				end
			end
		end
	end
end

--// Main Loop

local function Update()
	local settings = Aimbot.Settings
	local fov = Aimbot.FOVSettings

	-- FOV Rendering
	if fov.Enabled and settings.Enabled then
		local circle = Aimbot.FOVCircle
		local outline = Aimbot.FOVCircleOutline

		for k, v in pairs(fov) do
			if circle[k] ~= nil then
				circle[k] = v
				outline[k] = v
			end
		end

		circle.Color =
			(LockedPlayer and fov.LockedColor)
			or (fov.RainbowColor and GetRainbowColor())
			or fov.Color

		outline.Color =
			(fov.RainbowOutlineColor and GetRainbowColor())
			or fov.OutlineColor

		outline.Thickness = fov.Thickness + 1

		local pos = UserInputService:GetMouseLocation()
		circle.Position = pos
		outline.Position = pos
	else
		Aimbot.FOVCircle.Visible = false
		Aimbot.FOVCircleOutline.Visible = false
	end

	-- Aimbot Logic
	if Running and settings.Enabled then
		GetClosestPlayer()

		if LockedPlayer then
			local character = LockedPlayer.Character
			local part = character and character:FindFirstChild(settings.LockPart)
			if not part then
				CancelLock()
				return
			end

			local offset = Vector3zero
			if settings.OffsetToMoveDirection then
				local hum = character:FindFirstChildOfClass("Humanoid")
				if hum then
					offset = hum.MoveDirection * (math_clamp(settings.OffsetIncrement, 1, 30) / 10)
				end
			end

			local targetPos = part.Position + offset
			local screenPos = Camera:WorldToViewportPoint(targetPos)

			if settings.LockMode == 2 then
				mousemoverel(
					(screenPos.X - UserInputService:GetMouseLocation().X) / settings.Sensitivity2,
					(screenPos.Y - UserInputService:GetMouseLocation().Y) / settings.Sensitivity2
				)
			else
				if settings.Sensitivity > 0 then
					if ActiveTween then ActiveTween:Cancel() end
					ActiveTween = TweenService:Create(
						Camera,
						TweenInfonew(settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
						{ CFrame = CFramenew(Camera.CFrame.Position, targetPos) }
					)
					ActiveTween:Play()
				else
					Camera.CFrame = CFramenew(Camera.CFrame.Position, targetPos)
				end

				UserInputService.MouseDeltaSensitivity = 0
			end
		end
	end
end

--// Input Handling

Connections.InputBegan = UserInputService.InputBegan:Connect(function(input)
	if Typing then return end

	if input.UserInputType == Aimbot.Settings.TriggerKey
		or input.KeyCode == Aimbot.Settings.TriggerKey then

		if Aimbot.Settings.Toggle then
			Running = not Running
			if not Running then
				CancelLock()
			end
		else
			Running = true
		end
	end
end)

Connections.InputEnded = UserInputService.InputEnded:Connect(function(input)
	if Aimbot.Settings.Toggle or Typing then return end

	if input.UserInputType == Aimbot.Settings.TriggerKey
		or input.KeyCode == Aimbot.Settings.TriggerKey then
		Running = false
		CancelLock()
	end
end)

Connections.TypingStart = UserInputService.TextBoxFocused:Connect(function()
	Typing = true
end)

Connections.TypingEnd = UserInputService.TextBoxFocusReleased:Connect(function()
	Typing = false
end)

Connections.Update = RunService[Aimbot.DeveloperSettings.UpdateMode]:Connect(Update)

--// Public API

function Aimbot:Exit()
	for _, c in pairs(Connections) do
		c:Disconnect()
	end
	Aimbot.FOVCircle:Remove()
	Aimbot.FOVCircleOutline:Remove()
	getgenv().ExunysDeveloperAimbot = nil
end

function Aimbot:Restart()
	self:Exit()
	loadstring(game:HttpGet(""))()
end

function Aimbot:Blacklist(name)
	self.Blacklisted[#self.Blacklisted + 1] = name
end

function Aimbot:Whitelist(name)
	local i = table_find(self.Blacklisted, name)
	if i then
		table_remove(self.Blacklisted, i)
	end
end

return Aimbot
