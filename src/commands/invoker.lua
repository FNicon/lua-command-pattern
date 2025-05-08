local Command = require("src.commands.command")
local CommandHistory = require("src.commands.commandHistory")

local Invoker = {}

function Invoker:new()
	local newInstance = {}
	newInstance.history = CommandHistory:new()
	setmetatable(newInstance, {
		__index = function(table, key)
			return Invoker[key]
		end
	})
	return newInstance
end

function Invoker:plan(command)
	if (command ~= nil) and (type(command) == type(Command)) then
		self.history:push(command)
	end
end

function Invoker:undoPlan()
	self.history:pop()
end

function Invoker:redoPlan()
	self.history:undoPop()
end

function Invoker:execute()
	local command = self.history:forward()
	if (command) then
		command:execute()
	end
end

function Invoker:undoExecute()
	local command  = self.history:backward()
	if (command) then
		command:undo()
	end
end

function Invoker:planToString()
	return self.history:toString()
end

function Invoker:reset()
	self.history:reset()
end

return Invoker
