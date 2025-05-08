local Concrete = require("data.commands.concrete")
local Command = require("src.commands.command")
local Invoker = require("src.commands.invoker")
local KeyEvent = require("src.wrappers.keyEvent")

local Keyboard = {}

function Keyboard:new(controlled)
	local newInstance = {}
	newInstance.controlled = controlled
	newInstance.controller = Invoker:new()
	setmetatable(newInstance, {
		__index = function(table, key)
			return Keyboard[key]
		end
	})
	return newInstance
end

function Keyboard:directionPlan(key, scanCode, isRepeat)
	local commandKey, direction = KeyEvent.directionKey(key, scanCode, isRepeat)
	if (direction.x ~= 0 or direction.y ~= 0) then
		local concrete = Concrete[commandKey]
		local directionCommand = Command:new(self.controlled, concrete.execute, concrete.undo, concrete.label)
		self.controller:plan(directionCommand)
	end
end

function Keyboard:undoPlan(key, scanCode, isRepeat)
	local undoKey = KeyEvent.undoPlanKey(key, scanCode, isRepeat)
	if (undoKey) then
		self.controller:undoPlan()
	end
end

function Keyboard:redoPlan(key, scanCode, isRepeat)
	local redoKey = KeyEvent.redoPlanKey(key, scanCode, isRepeat)
	if (redoKey) then
		self.controller:redoPlan()
	end
end

function Keyboard:executePlan(key, scanCode, isRepeat)
	local executeKey = KeyEvent.executePlanKey(key, scanCode, isRepeat)
	if (executeKey) then
		self.controller:execute()
	end
end

function Keyboard:undoExecute(key, scanCode, isRepeat)
	local undoExecuteKey = KeyEvent.undoExecuteKey(key, scanCode, isRepeat)
	if (undoExecuteKey) then
		self.controller:undoExecute()
	end
end

function Keyboard:planToString()
	return self.controller:planToString()
end

return Keyboard
