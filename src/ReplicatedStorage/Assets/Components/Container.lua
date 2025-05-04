local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope): Frame
	return scope:New "Frame" {
		Name = "Container",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(27, 29, 47),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),

		[Fusion.Children] = {
			scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
				AspectRatio = 1.66,
			},
		}
	}
end