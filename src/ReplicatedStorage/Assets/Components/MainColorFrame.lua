local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope, color: Fusion.Value<Color3>): Frame
	return scope:New "Frame" {
		Name = "MainColorFrame",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Fusion.Spring(scope, color, 20, 0.8),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.399),
		Size = UDim2.fromScale(0.599, 0.6),

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
				AspectRatio = 1.65,
			},
		}
	}
end