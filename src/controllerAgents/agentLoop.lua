local Concrete = require("data.commands.concrete")
local Command = require("src.commands.command")
local Invoker = require("src.commands.invoker")

local Loop = {}

function Loop:new(controlled, loopPlan)
	local newInstance = {}
	newInstance.controlled = controlled
	newInstance.loopPlan = loopPlan
	newInstance.loopPointer = 1
	newInstance.controller = Invoker:new()
	setmetatable(newInstance, {
		__index = function(table, key)
			return Loop[key]
		end
	})
	return newInstance
end

function Loop:plan(commandKey)
	if (commandKey) then
		local concrete = Concrete[commandKey]
		local command = Command:new(self.controlled, concrete.execute, concrete.undo, concrete.label)
		self.controller:plan(command)
	end
end

function Loop:execute()
	self.controller:execute()
end

function Loop:executeLoop()
	if (self.loopPointer <= #self.loopPlan) then
		self:plan(self.loopPlan[self.loopPointer])
		self.loopPointer = self.loopPointer + 1
		self:execute()
	else
		self.controller:reset()
		self.loopPointer = 1
	end
end

function Loop:planToString()
	return self.controller:planToString()
end

return Loop
