local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ErrorHandler = {} :: {
	warn: (sender: string, msg: string) -> (),
	print: (sender: string, msg: string) -> (),
	kick: (target: Player, sender: string, msg: string) -> (),
	ConditionalPrint: (sender: string, msg: string) -> (),
	ConditionalWarn: (sender: string, msg: string) -> ()
}

function ErrorHandler.kick(target: Player, sender: string, msg: string): ()
	target:Kick(`[{sender}]: {msg}.`)
end

function ErrorHandler.warn(sender: string, msg: string): ()
	warn(`[{sender}]: {msg}.`)
end

function ErrorHandler.print(sender: string, msg: string): ()
	print(`[{sender}]: {msg}.`)
end

function ErrorHandler.ConditionalPrint(sender: string, msg: string): ()
	if ReplicatedStorage:GetAttribute("OutputDeveloperInfo") then
		print(`[DEV] [{sender}]: {msg}.`)
	end
end

function ErrorHandler.ConditionalWarn(sender: string, msg: string): ()
	if ReplicatedStorage:GetAttribute("OutputDeveloperInfo") then
		warn(`[DEV] [{sender}]: {msg}.`)
	end
end

return table.freeze(ErrorHandler)
