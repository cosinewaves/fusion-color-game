local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope: Fusion.Scope, visible: Fusion.Value<boolean>): TextButton
	
	return scope:New "TextLabel" {
		Name = "HintTooltip",
		FontFace = Font.new(
			"rbxasset://fonts/families/RobotoMono.json",
			Enum.FontWeight.Light,
			Enum.FontStyle.Normal
		),
		Text = "Hint ",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		TextTransparency = scope:Spring(scope:Computed(function(use)
			return use(visible) and 0.6 or 1
		end)),
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Right,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.112, 0.185),
		Size = UDim2.fromScale(0.0958, 0.0333),

		[Fusion.Children] = {
			scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
				AspectRatio = 4.77,
			},
		}
	}
end