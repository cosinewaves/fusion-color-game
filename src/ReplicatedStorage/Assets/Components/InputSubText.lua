local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope: Fusion.Scope, text: string, position: UDim2): TextButton
	
	return scope:New "TextLabel" {
		Name = "InputSubTexts",
		FontFace = Font.new(
			"rbxasset://fonts/families/RobotoMono.json",
			Enum.FontWeight.Light,
			Enum.FontStyle.Normal
		),
		Text = text,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		TextTransparency = 0.6,
		TextWrapped = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = position,
		Size = UDim2.fromScale(0.0958, 0.0333),

		[Fusion.Children] = {
			scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
				AspectRatio = 4.77,
			},
		}
	}
end