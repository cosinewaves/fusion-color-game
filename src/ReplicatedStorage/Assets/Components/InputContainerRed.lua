local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope: Fusion.Scope, isCorrect: Fusion.Value): TextBox
	
	local isFocused = Fusion.Value(scope, false)
	
	return scope:New "TextBox" {
		Name = "InputContainerRed",
		FontFace = Font.fromEnum(Enum.Font.GothamMedium),
		PlaceholderColor3 = Color3.fromRGB(255, 85, 127),
		PlaceholderText = "0",
		Text = "",
		TextColor3 = scope:Spring(scope:Computed(function(use, scope)
			if use(isCorrect) then
				return Color3.fromRGB(0, 255, 127)
			else
				return Color3.fromRGB(255, 85, 127)
			end
		end), 15, 0.8),
		TextSize = 63,
		TextWrapped = true,
		Active = false,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(42, 46, 74),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = scope:Spring(scope:Computed(function(use, scope)
			if use(isFocused) then
				return UDim2.fromScale(0.295, 0.78)
			else
				return UDim2.fromScale(0.295, 0.799)
			end
		end), 15, 0.8),
		Selectable = false,
		Size = UDim2.fromScale(0.191, 0.0998),
		ClearTextOnFocus = true,
		
		[Fusion.OnEvent("Focused")] = function()
			isFocused:set(true)
			game:GetService("ReplicatedStorage").Assets.Sounds.Select:Play()
		end,
		
		[Fusion.OnEvent("FocusLost")] = function()
			isFocused:set(false)
		end,
		
		[Fusion.Children] = {
			scope:New "UICorner" {
				Name = "UICorner",
			},

			scope:New "UIStroke" {
				Name = "UIStroke",
				Color = Color3.fromRGB(255, 255, 255),
				Transparency = 0.87,
			},

			scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
				AspectRatio = 3.17,
			},
		}
	}
end