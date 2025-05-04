local ErrorHandler = require(script.Parent.ErrorHandler)

local FrameworkLoader = {}

function FrameworkLoader:Load(
	module_container: Instance, 
	blacklist: { string }?
): { any } -- Returns an array of any-type module tables

	local loaded_modules = {} :: { any }

	local function isBlacklisted(name: string, blacklist: { string }?): boolean
		if not blacklist then return false end
		for _, blacklistedName in ipairs(blacklist) do
			if blacklistedName == name then
				return true
			end
		end
		return false
	end
	
	
	coroutine.wrap(function()
		for _, module : ModuleScript? in module_container:GetChildren() do
			if module:IsA("ModuleScript") and not isBlacklisted(module.Name, blacklist) then
				local module_index = require(module) :: any
				table.insert(loaded_modules, module_index)
				if typeof(module_index) == "table" and module_index.Init then
					module_index.Init()
				end
				ErrorHandler.ConditionalPrint("FrameworkLoader:Load", "Successfully loaded "..module.Name)
			end
		end
	end)()

	return loaded_modules
end

return table.freeze(FrameworkLoader)
