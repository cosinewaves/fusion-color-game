local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Interface.Fusion)

return function (scope, gameColor: Fusion.Value<Color3>, clickCallback: () -> (), isHovering: Fusion.Value): TextButton
	
	return scope:New "TextButton" {
		Name = "HintButton",
		FontFace = Font.fromEnum(Enum.Font.GothamMedium),
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 63,
		TextWrapped = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(42, 46, 74),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.175, 0.186),
		Selectable = false,
		Size = UDim2.fromScale(0.0301, 0.0499),
		
		[Fusion.OnEvent("MouseButton1Click")] = clickCallback,
		[Fusion.OnEvent("MouseEnter")] = function()
			isHovering:set(true)
			game:GetService("ReplicatedStorage").Assets.Sounds.Click:Play()
		end,
		[Fusion.OnEvent("MouseLeave")] = function()
			isHovering:set(false)
		end,

		[Fusion.Children] = {
			scope:New "UICorner" {
				Name = "UICorner",
			},

			scope:New "UIStroke" {
				Name = "UIStroke",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(255, 255, 255),
				Transparency = Fusion.Spring(scope, 
					Fusion.Computed(scope, function(use, scope)
						return use(isHovering) and 0.42 or 0.87
					end),
					15,
					0.8
				)	
				
			},

			scope:New "ImageLabel" {
				Name = "Icon",
				Image = "http://www.roblox.com/asset/?id=6026568247",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.489, 0.489),
				Size = UDim2.fromScale(0.489, 0.489),
				ImageColor3 = scope:Computed(function(use, scope)
					return use(isHovering) and Fusion.peek(gameColor) or Color3.fromRGB(255,255,255)
				end)
				,

				[Fusion.Children] = {
					scope:New "UIAspectRatioConstraint" {
						Name = "UIAspectRatioConstraint",
					},
				}
			},

			scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
			},
		}
	}
end