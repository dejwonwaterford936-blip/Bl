-- leaked @x_vvw

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LogService = game:GetService("LogService")

local SECRET_KEY = "traced"
local DISCORD_INVITE = "https://discord.gg/traced"

pcall(function()
	setclipboard(DISCORD_INVITE)
end)

pcall(function()
	local rpcPayload = {
		cmd = "SET_ACTIVITY",
		nonce = HttpService:GenerateGUID(false),
		args = {
			code = SECRET_KEY
		}
	}
	local rpcBody = HttpService:JSONEncode(rpcPayload)
	request({
		Method = "POST",
		Timeout = 2,
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Body = rpcBody,
		Headers = {
			Origin = "https://discord.com",
			["Content-Type"] = "application/json"
		}
	})
end)

pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "Mooze | TRACED",
		Text = "Thank you for using Mooze! / discord.gg/traced",
		Duration = 6
	})
end)

local ExecutorCapabilities = {
	HasHookfunction = pcall(function() return hookfunction ~= nil end),
	HasGetConnections = pcall(function() return getconnections ~= nil end),
	HasGetUpvalues = pcall(function() return getupvalues ~= nil end),
	HasIdentifyExecutor = pcall(function() return identifyexecutor ~= nil end),
	HasGetRawMetatable = pcall(function() return getrawmetatable ~= nil end)
}

local ExecutorName, ExecutorVersion = "Unknown", "?.?"
if ExecutorCapabilities.HasIdentifyExecutor then
	ExecutorName, ExecutorVersion = identifyexecutor()
end

local function showNotification(title, message, duration)
	local notificationScreenGui = Instance.new("ScreenGui")
	notificationScreenGui.Name = "MoozeNotifier"
	notificationScreenGui.Parent = CoreGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 260, 0, 55)
	mainFrame.Position = UDim2.new(0.5, -130, 0, -70)
	mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	mainFrame.BackgroundTransparency = 0.1
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Parent = notificationScreenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = mainFrame

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0, 3, 1, 0)
	accent.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	accent.BorderSizePixel = 0
	accent.Parent = mainFrame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 20)
	titleLabel.Position = UDim2.new(0, 15, 0, 8)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 13
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = mainFrame

	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, -20, 0, 20)
	messageLabel.Position = UDim2.new(0, 15, 0, 28)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	messageLabel.TextSize = 12
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.Parent = mainFrame

	TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -130, 0, 30) }):Play()

	task.delay(duration or 3, function()
		TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { Position = UDim2.new(0.5, -130, 0, -70) }):Play()
		task.wait(0.4)
		notificationScreenGui:Destroy()
	end)
end

print("[Mooze] Executor:", ExecutorName)
print("[Mooze] hookfunction:", ExecutorCapabilities.HasHookfunction and "✓" or "✗")
print("[Mooze] getrawmetatable:", ExecutorCapabilities.HasGetRawMetatable and "✓" or "✗")

task.delay(1, function()
	showNotification("Mooze| Welcome!", "Detected " .. ExecutorName, 4)
end)

local GamePresets = {
	["Da Hood - AIMING"] = {
		["Da Hood Aim"] = {
			FOV = {
				Enabled = true,
				Size = { X = 40 }
			},
			["Anti-Aim Exploit"] = {
				["Anti-Aim Exploit"] = { Enabled = false, Normal = { Multiplier = 30 } }
			}
		}
	},
	["Blade Ball - AIMING"] = {
		["Blade Ball Aim"] = {
			FOV = {
				Enabled = false,
				Size = { X = 40 }
			},
			["Anti-Aim Exploit"] = {
				["Anti-Aim Exploit"] = { Enabled = false, Normal = { Multiplier = 30 } }
			}
		}
	},
	["Arsenal - Legit"] = {
		["Arsenal Aim"] = {
			FOV = {
				Enabled = true,
				Size = { X = 100 }
			},
			["Anti-Aim Exploit"] = {
				["Anti-Aim Exploit"] = { Enabled = false, Normal = { Multiplier = 150 } }
			}
		}
	},
	["Phantom Forces - Legit"] = {
		["Phantom Aim"] = {
			FOV = {
				Enabled = false,
				Size = { X = 100 }
			},
			["Anti-Aim Exploit"] = {
				["Anti-Aim Exploit"] = { Enabled = false, Normal = { Multiplier = 150 } }
			}
		}
	}
}

getgenv().Mooze = {
	Global = {
		Enabled = true,
		Keybind = "C"
	},
	Triggerbot = {
		Enabled = false,
		Activation = {
			["Activation-Key"] = "V"
		},
		FOV = { X = 5 },
		Prediction = { X = 0.131, Y = 0.131, Z = 0.131 },
		["Fire-Rate"] = 0.1,
		Weapons = { "Shotgun", "Deagle", "New Revolver", "Glock" }
	},
	VelocityExploit = {
		Enabled = true,
		Magnitude = 10
	},
	SilentAim = {
		Enabled = false,
		Keybind = "C",
		Part = "HumanoidRootPart",
		Prediction = { X = 0, Y = 0, Z = 0 },
		Snappiness = 1
	},
	Walkspeed = {
		Enabled = true,
		Weapon = "Default",
		FOV = {
			Enabled = true,
			Size = { X = 40 },
			["Dynamic-Rate-Control"] = {
				Enabled = false,
				Shotguns = { X = 15 },
				Pistols = { X = 8 }
			}
		},
		Prediction = { X = 0, Y = 0, Z = 0 },
		["Weapon-Rates"] = {
			Default = 1.0
		},
		["SilentAim-Prediction"] = {
			Enabled = false,
			Prediction = { X = 0.131, Y = 0.131, Z = 0.131 },
			Weapons = { "M4A1", "AK47" }
		}
	},
	ESP = {
		["Silent-Aim-Target"] = {
			Enabled = false,
			Weapons = {
				M4A1 = { Multiplier = 0.1 },
				AK47 = { Multiplier = 0.12 },
				Pistol = { Multiplier = 0.08 },
				Shotgun = { Multiplier = 0.15 }
			}
		},
		["Speed-Controller"] = {
			Enabled = false,
			Normal = { Multiplier = 30 },
			["On-Hit"] = { Multiplier = 35 },
			Reloading = { Multiplier = 35 },
			Shooting = { Multiplier = 35 }
		}
	},
	["Spread-Controller"] = {
		["Spread-Controller"] = {
			Enabled = true,
			M4A1 = { Multiplier = 0.5 },
			AK47 = { Multiplier = 0.7 },
			Pistol = { Multiplier = 0.4 },
			Shotgun = { Multiplier = 1.9 }
		}
	}
}

if ExecutorCapabilities.HasHookfunction and ExecutorCapabilities.HasGetConnections and ExecutorCapabilities.HasGetUpvalues then
	print("[Mooze] AC-Bypass initializing...")

	local messageOutSignal = LogService.MessageOut
	local processedConnections = {}

	local function neutralizeACConnection(connection)
		local success, err = pcall(function()
			local upvalues = getupvalues(connection.Function)
			local acTable = upvalues[9]
			if acTable then
				local acFunction = acTable[1]
				setupvalue(acFunction, 14, function(...)
					return function(...)
						local args = { ... }
						if type(args[1]) == "table" and args[1][1] then
							pcall(function()
								if type(args[1][1]) == "RBXScriptConnection" then
									args[1][1]:Disconnect()
									args[1][2]:Disconnect()
									args[1][3]:Disconnect()
									args[1][4]:Disconnect()
								end
							end)
						end
					end
				end)
				setupvalue(acFunction, 1, function(...) task.wait(200) end)
				hookfunction(acFunction, function(...) return {} end)
			end
		end)
		if not success then
			warn("[Mooze] AC-Bypass> Failed to neutralize connection: ", err)
		end
	end

	local lastCheckTime = 0
	local checkInterval = 10
	RunService.Heartbeat:Connect(function()
		if tick() - lastCheckTime >= checkInterval then
			lastCheckTime = tick()
			local success, connections = pcall(getconnections, messageOutSignal)
			if success and connections then
				for _, connection in ipairs(connections) do
					if not table.find(processedConnections, connection) then
						table.insert(processedConnections, connection)
						task.spawn(neutralizeACConnection, connection)
					end
				end
			end
		end
	end)
else
	warn("[Mooze] AC bypass disabled - executor doesn't support required functions")
end

local authenticationCompleted = false
local configurationApplied = false
local selectedGamePreset = nil
local bypassedAuth = false
local guiLoaded = false

task.spawn(function()
	wait(1)
	guiLoaded = true
end)

local AuthGui = Instance.new("ScreenGui")
local AuthFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Icon = Instance.new("ImageLabel")
local TitleText = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local MaximizeButton = Instance.new("TextButton")
local AsciiArtLabel = Instance.new("TextLabel")
local KeyInputLabel = Instance.new("TextLabel")
local BypassButton = Instance.new("TextButton")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpPower = humanoid.JumpPower

local CURSOR_CHAR = "▄"
local CURSOR_BLINK_RATE = 0.5
local AUTH_DELAY = 5
local HIDE_DELAY = 5

local cursorColor = Color3.fromRGB(255, 255, 255)
local typedTextColor = Color3.fromRGB(128, 128, 128)
local typedText = ""
local isCursorVisible = true
local isKeyInputActive = false
local isAuthenticating = false

AuthGui.Name = "GUI"
AuthGui.Parent = CoreGui

AuthFrame.Name = "MoozeFrame"
AuthFrame.Parent = AuthGui
AuthFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AuthFrame.Size = UDim2.new(0, 600, 0, 300)
AuthFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
AuthFrame.ClipsDescendants = true

TopBar.Name = "TitleBar"
TopBar.Parent = AuthFrame
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 28)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.Active = true

Icon.Name = "IconImage"
Icon.Parent = TopBar
Icon.BackgroundTransparency = 1
Icon.Size = UDim2.new(0, 16, 0, 16)
Icon.Position = UDim2.new(0, 6, 0, 6)
Icon.Image = "rbxassetid://128024012812354"

TitleText.Name = "TitleLabel"
TitleText.Parent = TopBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(0, 100, 1, 0)
TitleText.Position = UDim2.new(0, 28, 0, 0)
TitleText.Text = "Mooze"
TitleText.Font = Enum.Font.SourceSans
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local watermark = Instance.new("TextLabel")
watermark.Name = "Watermark"
watermark.Parent = TopBar
watermark.BackgroundTransparency = 1
watermark.Size = UDim2.new(0, 300, 1, 0)
watermark.Position = UDim2.new(0.5, -150, 0, 0)
watermark.Text = "discord.gg/traced | v?? | " .. ExecutorName
watermark.Font = Enum.Font.SourceSansBold
watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
watermark.TextSize = 14
watermark.TextXAlignment = Enum.TextXAlignment.Center

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.Size = UDim2.new(0, 40, 0, 28)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.Size = UDim2.new(0, 40, 0, 28)
MinimizeButton.Position = UDim2.new(1, -120, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 24

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TopBar
MaximizeButton.Size = UDim2.new(0, 40, 0, 28)
MaximizeButton.Position = UDim2.new(1, -80, 0, 0)
MaximizeButton.BackgroundTransparency = 1
MaximizeButton.Text = "▢"
MaximizeButton.Font = Enum.Font.SourceSansBold
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.TextSize = 18
MaximizeButton.Visible = false

BypassButton.Name = "BypassButton"
BypassButton.Parent = AuthGui
BypassButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BypassButton.BorderSizePixel = 0
BypassButton.Size = UDim2.new(0, 140, 0, 50)
BypassButton.Font = Enum.Font.SourceSansBold
BypassButton.Text = "Maybe Later?"
BypassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BypassButton.TextSize = 14
BypassButton.AutoButtonColor = false

local function updateBypassButtonPosition()
	local framePos = AuthFrame.AbsolutePosition
	local frameSize = AuthFrame.AbsoluteSize
	BypassButton.Position = UDim2.new(0, framePos.X + frameSize.X + 10, 0, framePos.Y)
end

updateBypassButtonPosition()
AuthFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateBypassButtonPosition)

local isDragging = false
local dragStart, frameStart

local function dragFrame(input)
	local delta = input.Position - dragStart
	AuthFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		dragStart = input.Position
		frameStart = AuthFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				isDragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		dragFrame(input)
	end
end)

local defaultSize = AuthFrame.Size
local isMaximized = true

MinimizeButton.MouseButton1Click:Connect(function()
	if isMaximized then
		TweenService:Create(AuthFrame, TweenInfo.new(0.2), { Size = UDim2.new(defaultSize.X.Scale, defaultSize.X.Offset, 0, TopBar.Size.Y.Offset) }):Play()
		AsciiArtLabel.Visible = false
		KeyInputLabel.Visible = false
		MaximizeButton.Visible = true
		isMaximized = false
	end
end)

MaximizeButton.MouseButton1Click:Connect(function()
	if not isMaximized then
		TweenService:Create(AuthFrame, TweenInfo.new(0.2), { Size = defaultSize }):Play()
		AsciiArtLabel.Visible = true
		KeyInputLabel.Visible = true
		MaximizeButton.Visible = false
		isMaximized = true
	end
end)

CloseButton.MouseButton1Click:Connect(function()
	AuthGui:Destroy()
end)

AsciiArtLabel.Name = "AsciiArt"
AsciiArtLabel.Parent = AuthFrame
AsciiArtLabel.BackgroundTransparency = 1
AsciiArtLabel.Size = UDim2.new(1, 0, 0.6, 0)
AsciiArtLabel.Position = UDim2.new(0, 0, 0.12, 0)
AsciiArtLabel.Font = Enum.Font.Code
AsciiArtLabel.Text = [[
ooo        ooooo     .oooooo.      .oooooo.      oooooooooooo   oooooooooooo
`88.       .888'    d8P'  `Y8b    d8P'  `Y8b    d'''""""'888'        `888'     
 888b     d'888    888      888  888      888         .888P         888       
 8 Y88. .P  888    888      888  888      888        d888'          888oooo8  
 8  `888'   888    888      888  888      888      .888P            888    "  
 8    Y     888    `88b    d88'  `88b    d88'     d888'    .P       888       
o8o        o888o    `Y8bood8P'    `Y8bood8P'    .888888888P      o888ooooood8
]]
AsciiArtLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
AsciiArtLabel.TextSize = 12
AsciiArtLabel.TextWrapped = true
AsciiArtLabel.TextXAlignment = Enum.TextXAlignment.Center
AsciiArtLabel.TextYAlignment = Enum.TextYAlignment.Center

KeyInputLabel.Name = "KeyLabel"
KeyInputLabel.Parent = AuthFrame
KeyInputLabel.BackgroundTransparency = 1
KeyInputLabel.Position = UDim2.new(0, 29, 0, 200)
KeyInputLabel.Size = UDim2.new(0.7, 0, 0.1, 0)
KeyInputLabel.Font = Enum.Font.Code
KeyInputLabel.RichText = true
KeyInputLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
KeyInputLabel.TextSize = 12
KeyInputLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyInputLabel.TextYAlignment = Enum.TextYAlignment.Center
KeyInputLabel.Active = true

local function updateKeyLabel()
	if isAuthenticating then return end
	local cursor = isCursorVisible and CURSOR_CHAR or ""
	KeyInputLabel.Text = string.format('[<font color="rgb(255,0,0)">-</font>] Key: <font color="rgb(%d,%d,%d)">%s</font><font color="rgb(%d,%d,%d)">%s</font>', typedTextColor.R * 255, typedTextColor.G * 255, typedTextColor.B * 255, typedText, cursorColor.R * 255, cursorColor.G * 255, cursorColor.B * 255, cursor)
end

task.spawn(function()
	while true do
		if not isAuthenticating then
			isCursorVisible = not isCursorVisible
			updateKeyLabel()
		end
		wait(CURSOR_BLINK_RATE)
	end
end)

local function startAuthentication()
	isAuthenticating = true
	KeyInputLabel.Text = '[<font color="rgb(255,0,0)">-</font>] Authenticating...'
	wait(AUTH_DELAY)
	repeat task.wait() until guiLoaded
	AsciiArtLabel.Visible = false
	KeyInputLabel.Visible = false
	BypassButton.Visible = false
	showExecutorInfo()
end

BypassButton.MouseButton1Click:Connect(function()
	bypassedAuth = true
	print("[Mooze] Authentication bypassed... Have fun trying to use features that will automatically close your game...")
	startAuthentication()
end)

local keyNameMap = {
	Zero="0", One="1", Two="2", Three="3", Four="4", Five="5", Six="6", Seven="7", Eight="8", Nine="9",
	Comma=",", Period=".", Slash="/", BackSlash="\\", Semicolon=";", Quote="'", Minus="-", Equal="=", Grave="`",
	LeftBracket="[", RightBracket="]",
	F1="F1", F2="F2", F3="F3", F4="F4", F5="F5", F6="F6", F7="F7", F8="F8", F9="F9", F10="F10", F11="F11", F12="F12",
	Space=" ", Tab="\t", CapsLock="<CapsLock>", Insert="<Insert>", Delete="<Delete>", Home="<Home>", End="<End>",
	PageUp="<PageUp>", PageDown="<PageDown>", Up="↑", Down="↓", Left="←", Right="→"
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if isKeyInputActive and input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.Return then
			isKeyInputActive = false
			humanoid.WalkSpeed = originalWalkSpeed
			humanoid.JumpPower = originalJumpPower
			if typedText == SECRET_KEY then
				bypassedAuth = false
				print("[Mooze] Key correct! Authenticating you... please give us ~5 seconds.")
				startAuthentication()
			else
				localPlayer:Kick("Incorrect key: TRACED")
			end
			updateKeyLabel()
		elseif input.KeyCode == Enum.KeyCode.Backspace then
			typedText = typedText:sub(1, -2)
			updateKeyLabel()
		else
			local key = input.KeyCode.Name
			if #key == 1 then
				typedText = typedText .. key:lower()
			elseif keyNameMap[key] then
				typedText = typedText .. keyNameMap[key]
			end
			updateKeyLabel()
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local mousePos = input.Position
		local framePos = AuthFrame.AbsolutePosition
		local frameSize = AuthFrame.AbsoluteSize

		if mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y then
			isKeyInputActive = true
			typedText = ""
			updateKeyLabel()
			originalWalkSpeed = humanoid.WalkSpeed
			originalJumpPower = humanoid.JumpPower
			humanoid.WalkSpeed = 0
			humanoid.JumpPower = 0
		else
			if isKeyInputActive then
				humanoid.WalkSpeed = originalWalkSpeed
				humanoid.JumpPower = originalJumpPower
			end
			isKeyInputActive = false
			updateKeyLabel()
		end
	end
end)

updateKeyLabel()

function showExecutorInfo()
	for _, child in pairs(AuthFrame:GetChildren()) do
		if child ~= TopBar then
			child:Destroy()
		end
	end

	local executorTitle = Instance.new("TextLabel")
	executorTitle.Name = "ExecutorTitle"
	executorTitle.Parent = AuthFrame
	executorTitle.BackgroundTransparency = 1
	executorTitle.Position = UDim2.new(0, 0, 0, 40)
	executorTitle.Size = UDim2.new(1, 0, 0, 30)
	executorTitle.Font = Enum.Font.SourceSansBold
	executorTitle.Text = "Executor: " .. ExecutorName
	executorTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
	executorTitle.TextSize = 20
	executorTitle.TextXAlignment = Enum.TextXAlignment.Center

	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "FeaturesScroll"
	scrollFrame.Parent = AuthFrame
	scrollFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.Position = UDim2.new(0.5, -260, 0, 80)
	scrollFrame.Size = UDim2.new(0, 520, 0, 150)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollFrame.ScrollBarThickness = 6
	scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)

	local scrollCorner = Instance.new("UICorner")
	scrollCorner.CornerRadius = UDim.new(0, 8)
	scrollCorner.Parent = scrollFrame

	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = scrollFrame
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 5)

	local features = {
		{ name = "Silent Aim", status = ExecutorCapabilities.HasGetRawMetatable, detail = ExecutorCapabilities.HasGetRawMetatable and "Perfect silent aim" or "Not supported (disabled)" },
		{ name = "Triggerbot", status = true, detail = "Flawless and optimized" },
		{ name = "Aimbot", status = true, detail = "Perfected and optimized" },
		{ name = "ESP", status = true, detail = "Highlights locked targets" },
		{ name = "Anti Aim-Down-Sights", status = true, detail = "Hides when your target is aiming" },
		{ name = "Anti-Aim Exploit", status = true, detail = "Makes you faster while aiming" },
		{ name = "FOV Circle", status = true, detail = "Visualizes your aim-lock radius" },
		{ name = "AC-Bypass", status = ExecutorCapabilities.HasHookfunction and ExecutorCapabilities.HasGetConnections and ExecutorCapabilities.HasGetUpvalues, detail = ExecutorCapabilities.HasHookfunction and "Bypasses are enabled" or "Executor not supported" }
	}

	local totalHeight = 5
	for i, feature in ipairs(features) do
		local featureFrame = Instance.new("Frame")
		featureFrame.Name = "Feature" .. i
		featureFrame.Parent = scrollFrame
		featureFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		featureFrame.BorderSizePixel = 0
		featureFrame.Size = UDim2.new(1, -10, 0, 45)
		featureFrame.LayoutOrder = i

		local ffCorner = Instance.new("UICorner")
		ffCorner.CornerRadius = UDim.new(0, 6)
		ffCorner.Parent = featureFrame

		local statusIndicator = Instance.new("Frame")
		statusIndicator.Name = "StatusIndicator"
		statusIndicator.Parent = featureFrame
		statusIndicator.BackgroundColor3 = feature.status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
		statusIndicator.BorderSizePixel = 0
		statusIndicator.Position = UDim2.new(0, 10, 0.5, -8)
		statusIndicator.Size = UDim2.new(0, 16, 0, 16)

		local siCorner = Instance.new("UICorner")
		siCorner.CornerRadius = UDim.new(1, 0)
		siCorner.Parent = statusIndicator

		local featureName = Instance.new("TextLabel")
		featureName.Name = "FeatureName"
		featureName.Parent = featureFrame
		featureName.BackgroundTransparency = 1
		featureName.Position = UDim2.new(0, 35, 0, 5)
		featureName.Size = UDim2.new(1, -40, 0, 18)
		featureName.Font = Enum.Font.SourceSansBold
		featureName.Text = feature.name
		featureName.TextColor3 = Color3.fromRGB(255, 255, 255)
		featureName.TextSize = 14
		featureName.TextXAlignment = Enum.TextXAlignment.Left

		local featureDetail = Instance.new("TextLabel")
		featureDetail.Name = "FeatureDetail"
		featureDetail.Parent = featureFrame
		featureDetail.BackgroundTransparency = 1
		featureDetail.Position = UDim2.new(0, 35, 0, 23)
		featureDetail.Size = UDim2.new(1, -40, 0, 16)
		featureDetail.Font = Enum.Font.SourceSans
		featureDetail.Text = feature.detail
		featureDetail.TextColor3 = Color3.fromRGB(150, 150, 150)
		featureDetail.TextSize = 12
		featureDetail.TextXAlignment = Enum.TextXAlignment.Left

		totalHeight = totalHeight + 50
	end
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

	local continueButton = Instance.new("TextButton")
	continueButton.Name = "ContinueButton"
	continueButton.Parent = AuthFrame
	continueButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	continueButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
	continueButton.BorderSizePixel = 2
	continueButton.Position = UDim2.new(0.5, -100, 0, 240)
	continueButton.Size = UDim2.new(0, 200, 0, 40)
	continueButton.Font = Enum.Font.SourceSansBold
	continueButton.Text = "Continue"
	continueButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	continueButton.TextSize = 16
	continueButton.AutoButtonColor = false

	local cbCorner = Instance.new("UICorner")
	cbCorner.CornerRadius = UDim.new(0, 10)
	cbCorner.Parent = continueButton

	continueButton.MouseEnter:Connect(function()
		TweenService:Create(continueButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play()
	end)
	continueButton.MouseLeave:Connect(function()
		TweenService:Create(continueButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play()
	end)
	continueButton.MouseButton1Click:Connect(function()
		showConfigSelection()
	end)
end

function showConfigSelection()
	for _, child in pairs(AuthFrame:GetChildren()) do
		if child ~= TopBar then
			child:Destroy()
		end
	end

	local selectionTitle = Instance.new("TextLabel")
	selectionTitle.Name = "SelectionTitle"
	selectionTitle.Parent = AuthFrame
	selectionTitle.BackgroundTransparency = 1
	selectionTitle.Position = UDim2.new(0, 0, 0, 55)
	selectionTitle.Size = UDim2.new(1, 0, 0, 30)
	selectionTitle.Font = Enum.Font.SourceSansBold
	selectionTitle.Text = "Select your game/settings"
	selectionTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
	selectionTitle.TextSize = 20
	selectionTitle.TextXAlignment = Enum.TextXAlignment.Center

	local buttonContainer = Instance.new("Frame")
	buttonContainer.Name = "ButtonContainer"
	buttonContainer.Parent = AuthFrame
	buttonContainer.BackgroundTransparency = 1
	buttonContainer.Position = UDim2.new(0.5, -250, 0, 90)
	buttonContainer.Size = UDim2.new(0, 500, 0, 180)

	local configs = {
		{ name = "Da Hood - AIMING", preset = "Da Hood - AIMING" },
		{ name = "Blade Ball - AIMING", preset = "Blade Ball - AIMING" },
		{ name = "Arsenal - Legit", preset = "Arsenal - Legit" },
		{ name = "Phantom Forces - Legit", preset = "Phantom Forces - Legit" }
	}

	for i, config in ipairs(configs) do
		local row = math.floor((i - 1) / 2)
		local col = (i - 1) % 2

		local configButton = Instance.new("TextButton")
		configButton.Name = config.name
		configButton.Parent = buttonContainer
		configButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		configButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
		configButton.BorderSizePixel = 2
		configButton.Position = UDim2.new(col * 0.52, 0, row * 0.52, 0)
		configButton.Size = UDim2.new(0.46, 0, 0.46, 0)
		configButton.Font = Enum.Font.SourceSansBold
		configButton.Text = config.name
		configButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		configButton.TextSize = 14
		configButton.TextWrapped = true
		configButton.AutoButtonColor = false

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 10)
		corner.Parent = configButton

		configButton.MouseEnter:Connect(function()
			TweenService:Create(configButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play()
		end)
		configButton.MouseLeave:Connect(function()
			TweenService:Create(configButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play()
		end)
		configButton.MouseButton1Click:Connect(function()
			selectedGamePreset = config.preset
			showWalkspeedSelection(config.preset)
		end)
	end
end

function showWalkspeedSelection(preset)
	for _, child in pairs(AuthFrame:GetChildren()) do
		if child ~= TopBar then
			child:Destroy()
		end
	end

	local walkspeedTitle = Instance.new("TextLabel")
	walkspeedTitle.Name = "WalkspeedTitle"
	walkspeedTitle.Parent = AuthFrame
	walkspeedTitle.BackgroundTransparency = 1
	walkspeedTitle.Position = UDim2.new(0, 0, 0, 55)
	walkspeedTitle.Size = UDim2.new(1, 0, 0, 30)
	walkspeedTitle.Font = Enum.Font.SourceSansBold
	walkspeedTitle.Text = "Enable walkspeed?"
	walkspeedTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
	walkspeedTitle.TextSize = 20
	walkspeedTitle.TextXAlignment = Enum.TextXAlignment.Center

	local buttonContainer = Instance.new("Frame")
	buttonContainer.Name = "ButtonContainer"
	buttonContainer.Parent = AuthFrame
	buttonContainer.BackgroundTransparency = 1
	buttonContainer.Position = UDim2.new(0.5, -200, 0, 120)
	buttonContainer.Size = UDim2.new(0, 400, 0, 80)

	local yesButton = Instance.new("TextButton")
	yesButton.Name = "YesButton"
	yesButton.Parent = buttonContainer
	yesButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	yesButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
	yesButton.BorderSizePixel = 2
	yesButton.Position = UDim2.new(0, 0, 0, 0)
	yesButton.Size = UDim2.new(0.48, 0, 1, 0)
	yesButton.Font = Enum.Font.SourceSansBold
	yesButton.Text = "YES"
	yesButton.TextColor3 = Color3.fromRGB(0, 255, 0)
	yesButton.TextSize = 18
	yesButton.AutoButtonColor = false

	local yesCorner = Instance.new("UICorner")
	yesCorner.CornerRadius = UDim.new(0, 10)
	yesCorner.Parent = yesButton

	local noButton = Instance.new("TextButton")
	noButton.Name = "NoButton"
	noButton.Parent = buttonContainer
	noButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	noButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
	noButton.BorderSizePixel = 2
	noButton.Position = UDim2.new(0.52, 0, 0, 0)
	noButton.Size = UDim2.new(0.48, 0, 1, 0)
	noButton.Font = Enum.Font.SourceSansBold
	noButton.Text = "NO"
	noButton.TextColor3 = Color3.fromRGB(255, 0, 0)
	noButton.TextSize = 18
	noButton.AutoButtonColor = false

	local noCorner = Instance.new("UICorner")
	noCorner.CornerRadius = UDim.new(0, 10)
	noCorner.Parent = noButton

	yesButton.MouseEnter:Connect(function() TweenService:Create(yesButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play() end)
	yesButton.MouseLeave:Connect(function() TweenService:Create(yesButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play() end)
	noButton.MouseEnter:Connect(function() TweenService:Create(noButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play() end)
	noButton.MouseLeave:Connect(function() TweenService:Create(noButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play() end)

	local function fadeOutAndProceed(walkspeedEnabled)
		for _, child in pairs(AuthFrame:GetChildren()) do
			if child ~= TopBar then
				for _, obj in ipairs(child:GetDescendants()) do
					if obj:IsA("TextLabel") or obj:IsA("TextButton") then
						TweenService:Create(obj, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
					end
					if obj:IsA("Frame") or obj:IsA("ImageButton") then
						TweenService:Create(obj, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
					end
				end
				if child:IsA("TextLabel") or child:IsA("TextButton") then
					TweenService:Create(child, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
				end
				if child:IsA("Frame") or child:IsA("ImageButton") then
					TweenService:Create(child, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
				end
			end
		end
		task.wait(0.3)
		showESPSelection(preset, walkspeedEnabled)
	end
	yesButton.MouseButton1Click:Connect(function() fadeOutAndProceed(true) end)
	noButton.MouseButton1Click:Connect(function() fadeOutAndProceed(false) end)
end

function showESPSelection(preset, walkspeedEnabled)
	for _, child in pairs(AuthFrame:GetChildren()) do
		if child ~= TopBar then
			child:Destroy()
		end
	end

	local espTitle = Instance.new("TextLabel")
	espTitle.Name = "ESPTitle"
	espTitle.Parent = AuthFrame
	espTitle.BackgroundTransparency = 1
	espTitle.Position = UDim2.new(0, 0, 0, 55)
	espTitle.Size = UDim2.new(1, 0, 0, 30)
	espTitle.Font = Enum.Font.SourceSansBold
	espTitle.Text = "Enable target ESP?"
	espTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
	espTitle.TextSize = 20
	espTitle.TextXAlignment = Enum.TextXAlignment.Center

	local buttonContainer = Instance.new("Frame")
	buttonContainer.Name = "ButtonContainer"
	buttonContainer.Parent = AuthFrame
	buttonContainer.BackgroundTransparency = 1
	buttonContainer.Position = UDim2.new(0.5, -200, 0, 120)
	buttonContainer.Size = UDim2.new(0, 400, 0, 80)

	local yesButton = Instance.new("TextButton")
	yesButton.Name = "YesButton"
	yesButton.Parent = buttonContainer
	yesButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	yesButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
	yesButton.BorderSizePixel = 2
	yesButton.Position = UDim2.new(0, 0, 0, 0)
	yesButton.Size = UDim2.new(0.48, 0, 1, 0)
	yesButton.Font = Enum.Font.SourceSansBold
	yesButton.Text = "YES"
	yesButton.TextColor3 = Color3.fromRGB(0, 255, 0)
	yesButton.TextSize = 18
	yesButton.AutoButtonColor = false

	local yesCorner = Instance.new("UICorner")
	yesCorner.CornerRadius = UDim.new(0, 10)
	yesCorner.Parent = yesButton

	local noButton = Instance.new("TextButton")
	noButton.Name = "NoButton"
	noButton.Parent = buttonContainer
	noButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	noButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
	noButton.BorderSizePixel = 2
	noButton.Position = UDim2.new(0.52, 0, 0, 0)
	noButton.Size = UDim2.new(0.48, 0, 1, 0)
	noButton.Font = Enum.Font.SourceSansBold
	noButton.Text = "NO"
	noButton.TextColor3 = Color3.fromRGB(255, 0, 0)
	noButton.TextSize = 18
	noButton.AutoButtonColor = false

	local noCorner = Instance.new("UICorner")
	noCorner.CornerRadius = UDim.new(0, 10)
	noCorner.Parent = noButton

	yesButton.MouseEnter:Connect(function() TweenService:Create(yesButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play() end)
	yesButton.MouseLeave:Connect(function() TweenService:Create(yesButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play() end)
	noButton.MouseEnter:Connect(function() TweenService:Create(noButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play() end)
	noButton.MouseLeave:Connect(function() TweenService:Create(noButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(10, 10, 10) }):Play() end)
	
	local function fadeOutAndApply(espEnabled)
		for _, child in pairs(AuthFrame:GetChildren()) do
			if child ~= TopBar then
				for _, obj in ipairs(child:GetDescendants()) do
					if obj:IsA("TextLabel") or obj:IsA("TextButton") then
						TweenService:Create(obj, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
					end
					if obj:IsA("Frame") or obj:IsA("ImageButton") then
						TweenService:Create(obj, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
					end
				end
				if child:IsA("TextLabel") or child:IsA("TextButton") then
					TweenService:Create(c, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
				end
				if child:IsA("Frame") or child:IsA("ImageButton") then
					TweenService:Create(c, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
				end
			end
		end
		task.wait(0.3)
		applyConfig(preset, walkspeedEnabled, espEnabled)
		finishAuthentication()
	end

	yesButton.MouseButton1Click:Connect(function() fadeOutAndApply(true) end)
	noButton.MouseButton1Click:Connect(function() fadeOutAndApply(false) end)
end

function applyConfig(presetName, walkspeedEnabled, espEnabled)
	local preset = GamePresets[presetName]
	if preset then
		if preset["Walkspeed"] then
			getgenv().Mooze.Walkspeed.FOV.Enabled = preset.Walkspeed.FOV.Enabled
			getgenv().Mooze.Walkspeed.FOV.Size.X = preset.Walkspeed.FOV.Size.X
		end
		if preset.SilentAim and preset.SilentAim["Anti-Aim Exploit"] then
			local smooth = preset.SilentAim["Anti-Aim Exploit"]["Anti-Aim Exploit"]
			getgenv().Mooze.ESP["Silent-Aim-Target"].Enabled = walkspeedEnabled
			getgenv().Mooze.ESP["Silent-Aim-Target"]["Anti-Aim Exploit"].Normal.Multiplier = smooth.Normal.Multiplier
			getgenv().Mooze.ESP["Silent-Aim-Target"]["Anti-Aim Exploit"]["On-Hit"].Multiplier = smooth.Normal.Multiplier + 5
			getgenv().Mooze.ESP["Speed-Controller"]["Shooting"].Multiplier = smooth.Normal.Multiplier + 5
			getgenv().Mooze.ESP["Speed-Controller"]["Reloading"].Multiplier = smooth.Normal.Multiplier + 5
		end
	end
	getgenv().Mooze.ESP = { Enabled = espEnabled }
	print("[Mooze] Loaded preset:", presetName)
	print("[Mooze] Walkspeed enabled:", walkspeedEnabled)
	print("[Mooze] ESP enabled:", espEnabled)
end

function finishAuthentication()
	for _, child in pairs(AuthFrame:GetChildren()) do
		if child ~= TopBar then
			child:Destroy()
		end
	end

	local countdownLabel = Instance.new("TextLabel")
	countdownLabel.Name = "CountdownLabel"
	countdownLabel.Parent = AuthFrame
	countdownLabel.BackgroundTransparency = 1
	countdownLabel.Position = UDim2.new(0, 0, 0, 100)
	countdownLabel.Size = UDim2.new(1, 0, 0, 100)
	countdownLabel.Font = Enum.Font.Code
	countdownLabel.RichText = true
	countdownLabel.Text = string.format('[<font color="rgb(255,0,0)">-</font>] Hiding console in <font color="rgb(255,0,0)">%.2f</font> seconds!', HIDE_DELAY)
	countdownLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
	countdownLabel.TextSize = 14
	countdownLabel.TextXAlignment = Enum.TextXAlignment.Center

	wait(HIDE_DELAY)

	local function fadeOutGui(gui, duration)
		for _, obj in ipairs(gui:GetDescendants()) do
			if obj:IsA("TextLabel") then
				TweenService:Create(obj, TweenInfo.new(duration), { TextTransparency = 1 }):Play()
			elseif obj:IsA("TextButton") then
				TweenService:Create(obj, TweenInfo.new(duration), { TextTransparency = 1 }):Play()
			elseif obj:IsA("ImageLabel") then
				TweenService:Create(obj, TweenInfo.new(duration), { ImageTransparency = 1 }):Play()
			elseif obj:IsA("Frame") then
				TweenService:Create(obj, TweenInfo.new(duration), { BackgroundTransparency = 1 }):Play()
			end
		end
	end

	fadeOutGui(AuthGui, 2)
	wait(2)
	AuthGui:Destroy()
	authenticationCompleted = true
	configurationApplied = true
end

repeat task.wait() until authenticationCompleted and configurationApplied

if not getgenv().Mooze or not getgenv().Mooze.Global or not getgenv().Mooze.Global.Enabled then
	return
end

print("[Mooze] Bypassed authentication: ", bypassedAuth)

local isLocked = false
local lockedTarget = nil
local lockButton = nil
local fovCircleBypass = nil
local currentFovBypass = 40

if bypassedAuth then
	fovCircleBypass = Drawing.new("Circle")
	fovCircleBypass.Visible = true
	fovCircleBypass.Transparency = 1
	fovCircleBypass.Thickness = 2
	fovCircleBypass.Color = Color3.new(1, 1, 1)
	fovCircleBypass.NumSides = 100
	fovCircleBypass.Filled = false

	local bypassGui = Instance.new("ScreenGui")
	bypassGui.Name = "BypassHudGui"
	bypassGui.Parent = CoreGui
	bypassGui.ResetOnSpawn = false

	lockButton = Instance.new("TextButton")
	lockButton.Name = "LockTargetButton"
	lockButton.Parent = bypassGui
	lockButton.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	lockButton.BorderSizePixel = 0
	lockButton.Position = UDim2.new(0, 20, 0, 60)
	lockButton.Size = UDim2.new(0, 90, 0, 35)
	lockButton.Font = Enum.Font.GothamBold
	lockButton.Text = "LOCK"
	lockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	lockButton.TextSize = 13
	lockButton.AutoButtonColor = false
	lockButton.ZIndex = 10

	local lbCorner = Instance.new("UICorner")
	lbCorner.CornerRadius = UDim.new(0, 6)
	lbCorner.Parent = lockButton

	local btnAccent = Instance.new("Frame")
	btnAccent.Name = "Accent"
	btnAccent.Size = UDim2.new(0, 3, 1, 0)
	btnAccent.Position = UDim2.new(0, 0, 0, 0)
	btnAccent.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	btnAccent.BorderSizePixel = 0
	btnAccent.ZIndex = 11
	btnAccent.Parent = lockButton

	local btnAccentCorner = Instance.new("UICorner")
	btnAccentCorner.CornerRadius = UDim.new(0, 6)
	btnAccentCorner.Parent = btnAccent

	local sliderFrame = Instance.new("Frame")
	sliderFrame.Name = "SliderFrame"
	sliderFrame.Parent = bypassGui
	sliderFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	sliderFrame.BorderSizePixel = 0
	sliderFrame.Position = UDim2.new(0, 20, 0, 110)
	sliderFrame.Size = UDim2.new(0, 160, 0, 65)

	local sfc = Instance.new("UICorner")
	sfc.CornerRadius = UDim.new(0, 6)
	sfc.Parent = sliderFrame

	local sfAccent = Instance.new("Frame")
	sfAccent.Size = UDim2.new(0, 3, 1, 0)
	sfAccent.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	sfAccent.BorderSizePixel = 0
	sfAccent.Parent = sliderFrame

	local sfAccentCorner = Instance.new("UICorner")
	sfAccentCorner.CornerRadius = UDim.new(0, 6)
	sfAccentCorner.Parent = sfAccent

	local fovLabel = Instance.new("TextLabel")
	fovLabel.Name = "FovLabel"
	fovLabel.Parent = sliderFrame
	fovLabel.BackgroundTransparency = 1
	fovLabel.Position = UDim2.new(0, 15, 0, 10)
	fovLabel.Size = UDim2.new(1, -20, 0, 20)
	fovLabel.Font = Enum.Font.GothamBold
	fovLabel.Text = "FOV: " .. currentFovBypass
	fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	fovLabel.TextSize = 13
	fovLabel.TextXAlignment = Enum.TextXAlignment.Left

	local sliderBar = Instance.new("Frame")
	sliderBar.Name = "SliderBar"
	sliderBar.Parent = sliderFrame
	sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	sliderBar.BorderSizePixel = 0
	sliderBar.Position = UDim2.new(0.1, 0, 0, 35)
	sliderBar.Size = UDim2.new(0.8, 0, 0, 6)

	local sbc = Instance.new("UICorner")
	sbc.CornerRadius = UDim.new(1, 0)
	sbc.Parent = sliderBar

	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "SliderFill"
	sliderFill.Parent = sliderBar
	sliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	sliderFill.BorderSizePixel = 0
	sliderFill.Size = UDim2.new(0.2, 0, 1, 0)

	local sfc2 = Instance.new("UICorner")
	sfc2.CornerRadius = UDim.new(1, 0)
	sfc2.Parent = sliderFill

	local sliderButton = Instance.new("TextButton")
	sliderButton.Name = "SliderButton"
	sliderButton.Parent = sliderBar
	sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sliderButton.BorderSizePixel = 0
	sliderButton.Position = UDim2.new(0.2, -8, 0.5, -8)
	sliderButton.Size = UDim2.new(0, 16, 0, 16)
	sliderButton.Text = ""
	sliderButton.AutoButtonColor = false

	local sbc2 = Instance.new("UICorner")
	sbc2.CornerRadius = UDim.new(1, 0)
	sbc2.Parent = sliderButton

	local MIN_FOV = 10
	local MAX_FOV = 200
	local isSliding = false

	local function updateSlider(position)
		local ratio = math.clamp((position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
		currentFovBypass = math.floor(MIN_FOV + (MAX_FOV - MIN_FOV) * ratio)
		sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
		sliderButton.Position = UDim2.new(ratio, -8, 0.5, -8)
		fovLabel.Text = "FOV: " .. currentFovBypass
		getgenv().Mooze.SilentAim.FOV.Size.X = currentFovBypass
	end

	sliderButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isSliding = true
		end
	end)
	sliderButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isSliding = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateSlider(input.Position)
		end
	end)
	sliderBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			updateSlider(input.Position)
		end
	end)
	
	local tbFrame = Instance.new("Frame")
	tbFrame.Name = "TriggerBotFrame"
	tbFrame.Parent = bypassGui
	tbFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	tbFrame.BorderSizePixel = 0
	tbFrame.Position = UDim2.new(0, 20, 0, 185)
	tbFrame.Size = UDim2.new(0, 160, 0, 40)
	
	local tbFrameCorner = Instance.new("UICorner")
	tbFrameCorner.CornerRadius = UDim.new(0, 6)
	tbFrameCorner.Parent = tbFrame
	
	local tbAccent = Instance.new("Frame")
	tbAccent.Name = "Accent"
	tbAccent.Size = UDim2.new(0, 3, 1, 0)
	tbAccent.Position = UDim2.new(0, 0, 0, 0)
	tbAccent.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	tbAccent.BorderSizePixel = 0
	tbAccent.ZIndex = 11
	tbAccent.Parent = tbFrame
	
	local tbAccentCorner = Instance.new("UICorner")
	tbAccentCorner.CornerRadius = UDim.new(0, 6)
	tbAccentCorner.Parent = tbAccent
	
	local tbBtn = Instance.new("TextButton")
	tbBtn.Name = "TriggerbotToggleButton"
	tbBtn.Parent = tbFrame
	tbBtn.BackgroundTransparency = 1
	tbBtn.Position = UDim2.new(0, 10, 0, 0)
	tbBtn.Size = UDim2.new(1, -10, 1, 0)
	tbBtn.Font = Enum.Font.GothamBold
	tbBtn.Text = "TRIGGRBOT: OFF"
	tbBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
	tbBtn.TextSize = 12
	tbBtn.TextXAlignment = Enum.TextXAlignment.Left
	tbBtn.AutoButtonColor = false
	tbBtn.ZIndex = 10
	
	tbBtn.MouseButton1Click:Connect(function()
		local cfg = getgenv().Mooze.Triggerbot
		cfg.Enabled = not cfg.Enabled
		local accent = tbFrame:FindFirstChild("Accent")
		if cfg.Enabled then
			tbBtn.Text = "TRIGGERBOT: ON"
			tbBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
			TweenService:Create(tbFrame, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 40, 0) }):Play()
			if accent then
				TweenService:Create(accent, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 255, 100) }):Play()
			end
			showNotification("Triggerbot", "Triggerbot enabled", 2)
		else
			tbBtn.Text = "TRIGGRBOT: OFF"
			tbBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
			TweenService:Create(tbFrame, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(18, 18, 18) }):Play()
			if accent then
				TweenService:Create(accent, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(255, 60, 60) }):Play()
			end
			showNotification("Triggerbot", "Triggerbot disabled", 2)
		end
	end)
	
	lockButton.Position = UDim2.new(0, 20, 0, 60)
	lockButton.Size = UDim2.new(0, 160, 0, 40)
	sliderFrame.Position = UDim2.new(0, 20, 0, 110)
	sliderFrame.Size = UDim2.new(0, 160, 0, 65)
	tbFrame.Position = UDim2.new(0, 20, 0, 185)
	tbFrame.Size = UDim2.new(0, 160, 0, 40)
	
	print("[Mooze] Bypass-HUD loaded. Aimbot, SilentAim, FOV, Triggerbot, etc. functions are now available!")
end

local localPlayer = Players.LocalPlayer
local targetData = {
	target = nil,
	targetPart = nil,
	lastUpdate = 0,
	updateInterval = 0.033
}

local bodyParts = {
	"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso",
	"RightUpperArm", "LeftUpperArm", "RightLowerArm", "LeftLowerArm",
	"RightUpperLeg", "LeftUpperLeg", "RightLowerLeg", "LeftLowerLeg",
	"RightHand", "LeftHand", "RightFoot", "LeftFoot"
}
local bodyPartCache = {}
local CACHE_EXPIRY_TIME = 2

local function getCharacterParts(character)
	local now = tick()
	if not bodyPartCache[character] or (now - (bodyPartCache[character].time or 0)) > CACHE_EXPIRY_TIME then
		local parts = {}
		for _, partName in ipairs(bodyParts) do
			local part = character:FindFirstChild(partName)
			if part then table.insert(parts, part) end
		end
		bodyPartCache[character] = { parts = parts, time = now }
	end
	return bodyPartCache[character].parts
end

local MoozeConfig = getgenv().Mooze
local TriggerbotConfig = MoozeConfig.Triggerbot
local VelocityConfig = MoozeConfig.VelocityExploit

local fovTriggerCircle = Drawing.new("Circle")
fovTriggerCircle.Visible = false
fovTriggerCircle.Transparency = 1
fovTriggerCircle.Color = Color3.new(1, 1, 1)
fovTriggerCircle.Filled = true
fovTriggerCircle.Radius = TriggerbotConfig.FOV.X * 5
fovTriggerCircle.NumSides = math.clamp(math.floor(fovTriggerCircle.Radius * 2), 20, 100)
fovTriggerCircle.Position = Vector2.new(0, 0)

local triggerbotTargetBox = { Visible = false, Color = Color3.fromRGB(0, 150, 0), Position = Vector2.new(0, 0), Size = Vector2.new(0, 0) }
local targetLockedData = { Visible = false }
local activeTriggerbotTarget = nil
local lastFireTime = 0

local function isTargetVisibleAndValid(player, character)
	if not character then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 3 then return false end

	if character:FindFirstChildOfClass("ForceField") then return false end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local origin = workspace.CurrentCamera.CFrame.Position
		local direction = hrp.Position - origin
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { localPlayer.Character, workspace.CurrentCamera }
		local result = workspace:Raycast(origin, direction, params)
		if result and result.Instance ~= hrp and not result.Instance:IsDescendantOf(character) then
			return false
		end
	end
	return true
end

local function getClosestTarget()
	local bestTarget = nil
	local bestDist = math.huge
	local camera = workspace.CurrentCamera
	local mousePos = bypassedAuth and Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2) or UserInputService:GetMouseLocation()
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local velocity = hrp.AssemblyLinearVelocity
				local predictedPos = hrp.Position + Vector3.new(velocity.X * 0.08, velocity.Y * 0.04, velocity.Z * 0.08)
				local screenPos, onScreen = camera:WorldToViewportPoint(predictedPos)
				if onScreen and screenPos.Z > 0 then
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if dist < bestDist and isTargetVisibleAndValid(player, player.Character) then
						bestDist = dist
						bestTarget = player
					end
				end
			end
		end
	end
	return bestTarget
end

local function isMouseOverTarget()
	if bypassedAuth then return true end
	
	local mousePos = UserInputService:GetMouseLocation()
	local boxPos = triggerbotTargetBox.Position
	local boxSize = triggerbotTargetBox.Size
	
	return mousePos.X >= boxPos.X and mousePos.X <= (boxPos.X + boxSize.X) and mousePos.Y >= boxPos.Y and mousePos.Y <= (boxPos.Y + boxSize.Y)
end

local triggerbotKey = Enum.KeyCode[TriggerbotConfig.Activation["Activation-Key"]:upper()]
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == triggerbotKey then
		TriggerbotConfig.Enabled = not TriggerbotConfig.Enabled
		showNotification("Triggerbot", TriggerbotConfig.Enabled and "Enabled" or "Disabled", 3)
	end
end)

RunService.RenderStepped:Connect(function()
	if not TriggerbotConfig.Enabled then
		activeTriggerbotTarget = nil
		return
	end
	
	activeTriggerbotTarget = getClosestTarget()
	
	if activeTriggerbotTarget then
		triggerbotTargetBox.Color = Color3.fromRGB(0, 150, 0)
		if tick() - lastFireTime >= TriggerbotConfig["Fire-Rate"] then
			pcall(function()
				local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then
					local remote = tool:FindFirstChild("RemoteEvent")
					if remote then
						remote:FireServer()
					else
						tool:Activate()
					end
				end
			end)
			lastFireTime = tick()
		end
	else
		triggerbotTargetBox.Color = Color3.fromRGB(150, 0, 0)
	end
end)

do
	local AimbotConfig = getgenv().Mooze.Aimbot
	local globalKeybind = getgenv().Mooze.Global.Keybind or "E"
	AimbotConfig.Keybind = globalKeybind
	AimbotConfig.Snappiness = 1
	AimbotConfig.Prediction.X = 0
	AimbotConfig.Prediction.Y = 0
	AimbotConfig.Prediction.Z = 0
	
	local aimbotKey = Enum.KeyCode[AimbotConfig.Keybind:upper()]

	local function isTargetKnocked(character)
		if not character then return false end
		local be = character:FindFirstChild("Behavior")
		if be then
			local ko = be:FindFirstChild("KO")
			if ko and ko.Value == true then return true end
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local state = humanoid:GetState()
			if state == Enum.HumanoidStateType.Dead or state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll then
				return true
			end
		end
		local HRP = character:FindFirstChild("HumanoidRootPart")
		if HRP then
			local grab = HRP:FindFirstChild("GrabConstraint")
			if grab then return true end
		end
		return false
	end

	local function getLockedTarget()
		if isLocked and lockedTarget then
			if lockedTarget.Parent and lockedTarget.Parent:FindFirstChild("Humanoid") then
				local humanoid = lockedTarget.Parent:FindFirstChild("Humanoid")
				local character = lockedTarget.Parent
				if humanoid and humanoid.Health > 0 and not isTargetKnocked(character) then
					return lockedTarget
				end
			end

			-- Target is no longer valid
			isLocked = false
			lockedTarget = nil
			if lockButton then
				TweenService:Create(lockButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(18, 18, 18) }):Play()
				local accent = lockButton:FindFirstChild("Accent")
				if accent then
					TweenService:Create(accent, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(255, 60, 60) }):Play()
				end
			end
			showNotification("Mooze Aimbot", "Target lost or invalid. Aimbot disengaged.", 2)
			AimbotConfig.Enabled = false
			return nil
		end
		return nil
	end

	local function getTargetAtMouse()
		local camera = workspace.CurrentCamera
		local bestTarget = nil
		local shortestDist = math.huge
		local mousePos = UserInputService:GetMouseLocation()

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				if not isTargetKnocked(player.Character) then
					local hrp = player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
						if onScreen and screenPos.Z > 0 then
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
							if dist < shortestDist then
								shortestDist = dist
								bestTarget = hrp
							end
						end
					end
				end
			end
		end
		return bestTarget
	end

	local function getTargetAtCrosshair()
		local camera = workspace.CurrentCamera
		local bestTarget = nil
		local shortestDist = math.huge
		local crosshair = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
		
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				if not isTargetKnocked(player.Character) then
					local hrp = player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
						if onScreen and screenPos.Z > 0 then
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - crosshair).Magnitude
							if dist < shortestDist then
								shortestDist = dist
								bestTarget = hrp
							end
						end
					end
				end
			end
		end
		return bestTarget
	end

	if bypassedAuth and lockButton then
		print("[Mooze] Bypass Aimbot Lock, Silent Aim, FOV, Triggerbot, etc. functions are loaded.")
		lockButton.MouseButton1Click:Connect(function()
			local accent = lockButton:FindFirstChild("Accent")
			if not isLocked then
				local bestTarget = getTargetAtCrosshair()
				if bestTarget then
					isLocked = true
					lockedTarget = bestTarget
					TweenService:Create(lockButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 80, 0) }):Play()
					if accent then
						TweenService:Create(accent, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(0, 255, 100) }):Play()
					end
					local player = Players:GetPlayerFromCharacter(bestTarget.Parent)
					if player then
						showNotification("Aimbot Locked", player.Name .. " - Traced", 3)
					end
					AimbotConfig.Enabled = true
				else
					showNotification("Lock Failed", "No valid target found in crosshair.", 2)
				end
			else
				isLocked = false
				lockedTarget = nil
				AimbotConfig.Enabled = false
				TweenService:Create(lockButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(18, 18, 18) }):Play()
				if accent then
					TweenService:Create(accent, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(255, 60, 60) }):Play()
				end
				showNotification("Aimbot Status", "Aimbot disengaged.", 2)
			end
		end)
	end

	if not bypassedAuth then
		UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			if input.KeyCode == aimbotKey then
				if not isLocked then
					local bestTarget = getTargetAtMouse()
					if bestTarget then
						isLocked = true
						lockedTarget = bestTarget
						local player = Players:GetPlayerFromCharacter(bestTarget.Parent)
						if player then
							showNotification("Aimbot Locked", player.Name .. " - TRACED", 3)
						end
						AimbotConfig.Enabled = true
					else
						showNotification("Lock Failed", "No valid target found near mouse.", 2)
					end
				else
					isLocked = false
					lockedTarget = nil
					AimbotConfig.Enabled = false
					showNotification("Aimbot Status", "Aimbot disengaged.", 2)
				end
			end
		end)
	end

	RunService.RenderStepped:Connect(function()
		if AimbotConfig.Enabled then
			local targetPart = getLockedTarget()
			if targetPart then
				local camera = workspace.CurrentCamera
				if not camera then return end
				local targetPosition = targetPart.Position
				camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
			end
		end
	end)
end

do
	local SilentAimConfig = getgenv().Mooze.SilentAim
	local localPlayer = Players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	local lastMousePosition = Vector2.new(0, 0)
	local currentTarget = nil

	local function findBestPartForPriority(player)
		local bestPart, bestDist = nil, math.huge
		local priorityScale = SilentAimConfig["Weapon-Rates"] and SilentAimConfig["Weapon-Rates"].Default or 1.0
		local camera = workspace.CurrentCamera

		if player.Character then
			local parts = getCharacterParts(player.Character)
			for _, part in ipairs(parts) do
				local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
				if onScreen and screenPos.Z > 0 then
					local projectedPos = Vector2.new(screenPos.X, screenPos.Y)
					local dist = (lastMousePosition - projectedPos).Magnitude * priorityScale
					if dist < bestDist then
						bestPart, bestDist = part, dist
					end
				end
			end
		end
		return bestPart
	end

	local HAS_DRAWING_LIB = type(Drawing) == "table" or (type(getgenv) == "function" and getgenv().Drawing)
	local fovCircle = HAS_DRAWING_LIB and Drawing.new("Circle") or { Visible = false, Transparency = 1, Thickness = 2, Color = Color3.new(1, 1, 1), NumSides = 100, Filled = false, Radius = 0, Position = Vector2.new(0, 0) }

	if HAS_DRAWING_LIB then
		fovCircle.Visible = SilentAimConfig.FOV.Enabled and not bypassedAuth
		fovCircle.Transparency = 1
		fovCircle.Thickness = 2
		fovCircle.Color = Color3.new(1, 1, 1)
		fovCircle.NumSides = 100
		fovCircle.Filled = false
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "MoozeHL"
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	pcall(function() highlight.Parent = CoreGui end)

	local targetLine = HAS_DRAWING_LIB and Drawing.new("Line") or { Visible = false, Color = Color3.new(1, 0, 0), Thickness = 1.5, Transparency = 1, From = Vector2.new(0, 0), To = Vector2.new(0, 0) }
	
	if HAS_DRAWING_LIB then
		targetLine.Visible = false
		targetLine.Color = Color3.fromRGB(255, 0, 0)
		targetLine.Thickness = 1.5
		targetLine.Transparency = 1
	end

	local lastUpdateTime = 0
	local updateInterval = 0.033

	local function isAimingDownSights()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		if playerGui then
			local aimGui = playerGui:FindFirstChild("Aim")
			if aimGui and aimGui.Visible then return true end
		end
		
		local m = localPlayer:GetMouse()
		if m.Icon == "rbxasset://SystemCursors/Cross" then return true end

		local playerScripts = localPlayer.PlayerScripts:FindFirstChild("PlayerModule")
		if playerScripts then
			local cameraModule = playerScripts:FindFirstChild("CameraModule")
			if cameraModule then
				local mouseLockController = cameraModule:FindFirstChild("MouseLockController")
				if mouseLockController then
					local isMouseLocked = mouseLockController:FindFirstChild("isMouseLocked")
					if isMouseLocked and isMouseLocked.Value then return true end
				end
			end
		end
		
		return false
	end

	local function updateFovCircle()
		local camera = workspace.CurrentCamera
		if not camera then return end

		local fovConfig = SilentAimConfig.FOV
		local currentTool = nil
		if localPlayer.Character then
			currentTool = localPlayer.Character:FindFirstChildOfClass("Tool")
		end

		if bypassedAuth or (currentTool ~= nil and isAimingDownSights()) then
			local crosshair = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
			lastMousePosition = crosshair
		else
			lastMousePosition = UserInputService:GetMouseLocation()
		end

		local radius = fovConfig.Size.X * 5
		if fovConfig["Dynamic-Rate-Control"] and fovConfig["Dynamic-Rate-Control"].Enabled and currentTool then
			local toolName = string.lower(currentTool.Name or "")
			if string.find(toolName, "shotgun") then
				radius = fovConfig["Dynamic-Rate-Control"].Shotguns.X * 5
			elseif string.find(toolName, "pistol") then
				radius = fovConfig["Dynamic-Rate-Control"].Pistols.X * 5
			end
		end
		
		if bypassedAuth then
			radius = currentFovBypass * 5
		end
		
		fovCircle.Radius = radius
		fovCircle.NumSides = math.clamp(math.floor(radius * 2), 20, 100)
		fovCircle.Position = lastMousePosition
		fovCircle.Visible = SilentAimConfig.FOV.Enabled and not bypassedAuth
		
		if bypassedAuth and fovCircleBypass then
			local crosshair = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
			fovCircleBypass.Position = crosshair
			fovCircleBypass.Radius = currentFovBypass * 5
			fovCircleBypass.NumSides = math.clamp(math.floor(currentFovBypass * 2), 20, 100)
			fovCircleBypass.Visible = SilentAimConfig.FOV.Enabled
		end
		
		local espConf = getgenv().Mooze.ESP
		if espConf and espConf.Enabled and currentTarget and currentTarget.Parent then
			highlight.Adornee = currentTarget.Parent
			highlight.Enabled = true
			local screenPos, onScreen = camera:WorldToViewportPoint(currentTarget.Position)
			if onScreen and screenPos.Z > 0 then
				targetLine.From = lastMousePosition
				targetLine.To = Vector2.new(screenPos.X, screenPos.Y)
				targetLine.Visible = true
			else
				targetLine.Visible = false
			end
		else
			highlight.Adornee = nil
			highlight.Enabled = false
			targetLine.Visible = false
		end
	end

	local function updateClosestTargetInFov()
		local camera = workspace.CurrentCamera
		if not camera then return end

		local radius = fovCircle.Radius
		local bestPart, bestDist = nil, math.huge
		
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				local partToAimAt = nil
				if SilentAimConfig.Part == "Priority" then
					partToAimAt = findBestPartForPriority(player)
				else
					partToAimAt = player.Character:FindFirstChild("Head")
				end
				
				if partToAimAt then
					local screenPos, onScreen = camera:WorldToViewportPoint(partToAimAt.Position)
					if onScreen and screenPos.Z > 0 then
						local projectedPos = Vector2.new(screenPos.X, screenPos.Y)
						local dist = (lastMousePosition - projectedPos).Magnitude
						if dist < bestDist and dist <= radius then
							bestPart, bestDist = partToAimAt, dist
						end
					end
				end
			end
		end
		currentTarget = bestPart
	end

	RunService.RenderStepped:Connect(updateFovCircle)
	RunService.Heartbeat:Connect(function(dt)
		lastUpdateTime = lastUpdateTime + dt
		if lastUpdateTime >= updateInterval then
			lastUpdateTime = 0
			updateClosestTargetInFov()
		end
	end)

	local function getModifiedCFrame(originalCFrame, offset)
		return originalCFrame + Vector3.new(offset.X, offset.Y, offset.Z)
	end
	
	if ExecutorCapabilities.HasGetRawMetatable then
		local success = pcall(function()
			local mt = getrawmetatable(game)
			setreadonly(mt, false)
			local oldIndex = mt.__index
			mt.__index = newcclosure(function(object, property)
				if not checkcaller() and oldIndex(object, "IsA")(object, "BasePart") and (property == "CFrame" or property == "Position") then
					local targetPart = currentTarget
					if targetPart then
						local predictionConfig = SilentAimConfig.Prediction
						local reductionConfig = SilentAimConfig["SilentAim-Prediction"]
						
						local tool = localPlayer.Character and oldIndex(localPlayer.Character, "FindFirstChildOfClass")(localPlayer.Character, "Tool") or nil

						if reductionConfig.Enabled and tool then
							local toolName = tostring(tool.Name)
							for _, weaponName in ipairs(reductionConfig.Weapons) do
								if string.find(string.lower(toolName), string.lower(weaponName)) then
									predictionConfig = reductionConfig.Prediction
									break
								end
							end
						end
						
						local predictionMultiplier = Vector3.new(predictionConfig.X, predictionConfig.Y, predictionConfig.Z)
						local offset = targetPart.Velocity * predictionMultiplier
						
						if property == "CFrame" then
							return getModifiedCFrame(targetPart.CFrame, offset)
						else
							return targetPart
						end
					end
				end
				return oldIndex(object, property)
			end)
		end)
		
		if success then
			print("[Mooze] SilentAim: Hooked __index successfully. Silent aim is perfect.")
		else
			warn("[Mooze] SilentAim: Failed to hook __index. Silent aim may not be perfect, please reload.")
			showNotification("SilentAim", "Failed to init hooks. Reload your executor.", 5)
		end
	else
		warn("[Mooze] SilentAim: Silent aim disabled. Executor doesn't support getrawmetatable.")
		showNotification("SilentAim", "Disabled - executor not supported.", 5)
	end
end

local isRapidFiring = false
local RapidFire = {}

RapidFire.get_gun = function()
	for _, tool in next, Players.LocalPlayer.Character:GetChildren() do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
			return tool
		end
	end
end
RapidFire.rapid = function(tool)
	tool:Activate()
end

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local gun = RapidFire.get_gun()
		if gun and not isRapidFiring then
			isRapidFiring = true
			
			local gunName = gun.Name
			local multiplier = 1
			local spreadConfig = getgenv().Mooze.ESP["Silent-Aim-Target"]
			
			if spreadConfig and spreadConfig.Enabled then
				local weaponConfig = spreadConfig.Weapons[gunName]
				if weaponConfig then
					multiplier = weaponConfig.Multiplier or 1
				end
			end
			
			local fireDelay = multiplier
			while isRapidFiring do
				RapidFire.rapid(gun)
				task.wait(fireDelay)
			end
		end
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isRapidFiring = false
	end
end)

local SpreadConfig = getgenv().Mooze and getgenv().Mooze["Spread-Controller"] and getgenv().Mooze["Spread-Controller"]["Spread-Controller"]
local SPREAD_BASE = 0.1
local RECOIL_BASE = 0.1

local function cleanString(s)
	return tostring(s):lower():gsub("%W", "")
end

local function applyAntiSpread()
	if not SpreadConfig or not SpreadConfig.Enabled then return end
	
	task.spawn(function()
		for weaponKey, settings in pairs(SpreadConfig) do
			if weaponKey ~= "Enabled" and type(settings) == "table" then
				local multiplier = settings.Multiplier
				local newSpread = SPREAD_BASE * multiplier
				local newRecoil = RECOIL_BASE * multiplier
				local keyName = cleanString(weaponKey)
				
				local gcCount = 0
				for _, func in ipairs(getgc(true)) do
					gcCount = gcCount + 1
					if gcCount % 1000 == 0 then task.wait() end
					
					if type(func) == "function" and islclosure(func) and not isexecutorclosure(func) then
						local success, info = pcall(debug.getinfo, func)
						if success and info and info.short_src then
							local scriptName = cleanString(info.short_src)
							if scriptName:find(keyName, 1, true) then
								local constSuccess, constants = pcall(debug.getconstants, func)
								if constSuccess and constants then
									for idx, const in ipairs(constants) do
										if type(const) == "number" then
											if const > 0 and const < 0.1 then 
												pcall(debug.setconstant, func, idx, newSpread) 
											elseif const >= 0.1 and const < 0.3 then 
												pcall(debug.setconstant, func, idx, newRecoil)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

if localPlayer.Character then
	applyAntiSpread()
end
localPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	applyAntiSpread()
	bodyPartCache = {}
end)

local moozeEnv = getgenv().Mooze
local SpeedControllerConfig = moozeEnv.ESP["Speed-Controller"]

print("Speed Controller Enabled:", SpeedControllerConfig.Enabled)
if SpeedControllerConfig.Enabled then
	print("Speed Controller Normal Multiplier:", SpeedControllerConfig.Normal.Multiplier)
end

if SpeedControllerConfig.Enabled then
	local playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	local humanoid = playerCharacter:FindFirstChildOfClass("Humanoid") or playerCharacter:WaitForChild("Humanoid")

	local isShooting = false
	local isReloading = false
	local LOW_HEALTH_THRESHOLD = 50
	local mouse = localPlayer:GetMouse()

	mouse.Button1Down:Connect(function() isShooting = true end)
	mouse.Button1Up:Connect(function() isShooting = false end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.R and not isReloading then
			isReloading = true
			task.delay(1.5, function() isReloading = false end)
		end
	end)

	localPlayer.CharacterAdded:Connect(function(char)
		playerCharacter = char
		humanoid = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
		isShooting = false
		isReloading = false
	end)

	RunService.RenderStepped:Connect(function()
		if not SpeedControllerConfig.Enabled then return end
		if not humanoid or humanoid.Health <= 0 then return end
		
		local speed = SpeedControllerConfig.Normal and SpeedControllerConfig.Normal.Multiplier or humanoid.WalkSpeed

		if humanoid.Health < LOW_HEALTH_THRESHOLD and SpeedControllerConfig["On-Hit"] then
			speed = SpeedControllerConfig["On-Hit"].Multiplier
		elseif isReloading and SpeedControllerConfig.Reloading then
			speed = SpeedControllerConfig.Reloading.Multiplier
		elseif isShooting and SpeedControllerConfig.Shooting then
			speed = SpeedControllerConfig.Shooting.Multiplier
		end
		
		if humanoid.WalkSpeed ~= speed then
			humanoid.WalkSpeed = speed
		end
	end)
	print("Speed-Controller: Speed Controller is patched")
	print("Speed-Controller: Normal speed set to:", SpeedControllerConfig.Normal.Multiplier)
else
	print("Speed-Controller: Speed Controller is disabled by config.")
end

print("[Mooze] All features loaded successfully. nigger")
print("[Mooze] Executor:", ExecutorName)
print("[Mooze] Silent Aim Perfect:", ExecutorCapabilities.HasGetRawMetatable and "True" or "False")
print("[Mooze] Aimbot, Silent Aim, Triggerbot, ESP, and other features are now running.")

showNotification("Mooze Loaded", "All features are active. Enjoy!", 4)
showNotification("Important Notice", "Keybinds: Aimbot (hold " .. (MoozeConfig.Aimbot.Keybind or "E") .. "), Triggerbot (toggle V)", 4)
