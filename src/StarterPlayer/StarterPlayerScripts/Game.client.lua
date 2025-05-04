local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ErrorHandler = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Utility"):WaitForChild("ErrorHandler"))
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

-- Types
type GameState = { R: boolean, G: boolean, B: boolean }
type Answer = boolean

-- Constants
local COMPONENTS_FOLDER = ReplicatedStorage.Assets.Components
local SOUNDS_FOLDER = ReplicatedStorage.Assets.Sounds
local GUESS_LEEWAY = 5

-- Game Variables
local colorCompleted: boolean = false
local autoNextColor: boolean = true
local gameState: GameState = { R = false, G = false, B = false }

-- Interface Variables
local container: Frame
local mainColorFrame: Frame
local inputContainerRed: TextBox
local inputContainerGreen: TextBox
local inputContainerBlue: TextBox
local skipButton: TextButton
local hintButton: TextButton
local skipToolTip: TextLabel
local hintTooltip: TextLabel

-- Fusion state variables
local scope = Fusion:scoped()
local gameColor = scope:Value(Color3.fromRGB(255, 255, 255))
local skipHover = scope:Value(false)
local hintHover = scope:Value(false)
local redAnswer: Answer = scope:Value(false)
local blueAnswer: Answer = scope:Value(false)
local greenAnswer: Answer = scope:Value(false)

-- Utility Functions
local function HexToRGB(hex: string): (number, number, number)
	hex = string.sub(hex, 2)
	local red = tonumber(string.sub(hex, 1, 2), 16)
	local green = tonumber(string.sub(hex, 3, 4), 16)
	local blue = tonumber(string.sub(hex, 5, 6), 16)
	return red, green, blue
end

local function ResetInputs(): nil
	scope:Hydrate(inputContainerGreen)({ TextEditable = true, Text = "" })
	scope:Hydrate(inputContainerBlue)({ TextEditable = true, Text = "" })
	scope:Hydrate(inputContainerRed)({ TextEditable = true, Text = "" })
	gameState.R, gameState.G, gameState.B = false, false, false
	redAnswer:set(false)
	greenAnswer:set(false)
	blueAnswer:set(false)
end

local function isColorGuessed(): boolean
	return gameState.R and gameState.G and gameState.B
end

local function setGuessed(inputBox: TextBox, channel: string): nil
	ErrorHandler.ConditionalPrint("Game.setGuessed", "setGuessed called for channel: " .. channel)
	scope:Hydrate(inputBox)({ TextEditable = false })
	if channel == "R" then
		redAnswer:set(true)
	elseif channel == "G" then
		greenAnswer:set(true)
	else
		blueAnswer:set(true)
	end
	gameState[channel] = true
	SOUNDS_FOLDER.Correct:Play()

	if isColorGuessed() and not colorCompleted then
		colorCompleted = true
		ErrorHandler.ConditionalPrint("Game.setGuessed", "Color guessed correctly. Proceeding to next color")

		if autoNextColor then
			task.delay(2, function()
				if colorCompleted then
					NewColor()
				end
			end)
		end
	end
end

local function CheckInput(inputField: TextBox, targetValue: number, channel: string): nil
	ErrorHandler.ConditionalPrint("Game.CheckInput", "Checking input for channel: " .. channel)
	local guess = tonumber(inputField.Text)
	if not guess then 
		ErrorHandler.ConditionalPrint("Game.CheckInput", "Invalid input: " .. inputField.Text)
		return 
	end

	ErrorHandler.ConditionalPrint("Game.CheckInput", "Guess: " .. guess .. ", Target: " .. targetValue)
	if math.abs(guess - targetValue) <= GUESS_LEEWAY then
		scope:Hydrate(inputField)({ Text = tostring(targetValue) })
		setGuessed(inputField, channel)
	else
		ErrorHandler.ConditionalPrint("Game.CheckInput", "Incorrect guess")
		SOUNDS_FOLDER.Incorrect:Play()
	end
end

local function ValidateInput(textBox: TextBox, channel: string): nil
	textBox.FocusLost:Connect(function(enterPressed: boolean)
		if enterPressed then
			local text = textBox.Text
			local num = tonumber(text)
			if num then
				num = math.clamp(num, 0, 255)
				scope:Hydrate(textBox)({ Text = tostring(num) })
			else
				scope:Hydrate(textBox)({ Text = "" })
			end

			if channel == "R" then
				CheckInput(textBox, math.round(Fusion.peek(gameColor).R * 255), "R")
			elseif channel == "G" then
				CheckInput(textBox, math.round(Fusion.peek(gameColor).G * 255), "G")
			elseif channel == "B" then
				CheckInput(textBox, math.round(Fusion.peek(gameColor).B * 255), "B")
			end
		end
	end)
end

function GiveHint(): nil
	ErrorHandler.ConditionalPrint("Game.GiveHint", "GiveHint called")
	local options = {}

	if not gameState.R then table.insert(options, "R") end
	if not gameState.G then table.insert(options, "G") end
	if not gameState.B then table.insert(options, "B") end
	if #options == 0 then return end

	local selected = options[math.random(1, #options)]
	ErrorHandler.ConditionalPrint("Game.GiveHint", "Hint for: " .. selected)

	if selected == "R" then
		scope:Hydrate(inputContainerRed)({ Text = tostring(math.round(Fusion.peek(gameColor).R * 255)) })
		setGuessed(inputContainerRed, "R")
	elseif selected == "G" then
		scope:Hydrate(inputContainerGreen)({ Text = tostring(math.round(Fusion.peek(gameColor).G * 255)) })
		setGuessed(inputContainerGreen, "G")
	elseif selected == "B" then
		scope:Hydrate(inputContainerBlue)({ Text = tostring(math.round(Fusion.peek(gameColor).B * 255)) })
		setGuessed(inputContainerBlue, "B")
	end
end

function NewColor(): nil
	colorCompleted = false
	gameColor:set(Color3.fromRGB(
		math.random(1, 255),
		math.random(1, 255),
		math.random(1, 255)
		))
	ErrorHandler.ConditionalPrint("Game.NewColor", "New color generated: " .. Fusion.peek(gameColor):ToHex())
	ResetInputs()
end

-- Initialization
local mount = require(COMPONENTS_FOLDER.ScreenGui)(scope)
mount.Parent = Players.LocalPlayer.PlayerGui

container = require(COMPONENTS_FOLDER.Container)(scope)
container.Parent = mount

mainColorFrame = require(COMPONENTS_FOLDER.MainColorFrame)(scope, gameColor)
mainColorFrame.Parent = container

skipButton = require(COMPONENTS_FOLDER.SkipButton)(scope, gameColor, NewColor, skipHover)
hintButton = require(COMPONENTS_FOLDER.HintButton)(scope, gameColor, GiveHint, hintHover)
skipButton.Parent, hintButton.Parent = container, container

inputContainerRed = require(COMPONENTS_FOLDER.InputContainerRed)(scope, redAnswer)
inputContainerGreen = require(COMPONENTS_FOLDER.InputContainerGreen)(scope, greenAnswer)
inputContainerBlue = require(COMPONENTS_FOLDER.InputContainerBlue)(scope, blueAnswer)
inputContainerRed.Parent, inputContainerGreen.Parent, inputContainerBlue.Parent = container, container, container

skipToolTip = require(COMPONENTS_FOLDER.SkipTooltip)(scope, skipHover)
hintTooltip = require(COMPONENTS_FOLDER.HintTooltip)(scope, hintHover)
skipToolTip.Parent, hintTooltip.Parent = container, container

require(COMPONENTS_FOLDER.InputSubText)(scope, "Red", UDim2.fromScale(0.295, 0.869)).Parent = container
require(COMPONENTS_FOLDER.InputSubText)(scope, "Green", UDim2.fromScale(0.5, 0.869)).Parent = container
require(COMPONENTS_FOLDER.InputSubText)(scope, "Blue", UDim2.fromScale(0.704, 0.869)).Parent = container

NewColor()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

skipButton.MouseButton1Click:Connect(function()
	SOUNDS_FOLDER.Click:Play()
end)

hintButton.MouseButton1Click:Connect(function()
	SOUNDS_FOLDER.Click:Play()
end)

ValidateInput(inputContainerRed, "R")
ValidateInput(inputContainerGreen, "G")
ValidateInput(inputContainerBlue, "B")
