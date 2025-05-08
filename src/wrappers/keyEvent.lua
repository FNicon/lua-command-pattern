local Keybind = require("data.controllerAgents.keybind")

local KeyEvent = {}

function KeyEvent.directionKeyHold()
	local direction = {x = 0, y = 0}
	local commandKey = ""
	if love.keyboard.isDown(Keybind.upArrow) or love.keyboard.isDown(Keybind.upKey) then
		direction.y = -1
		commandKey = commandKey .. "up"
	elseif love.keyboard.isDown(Keybind.downArrow) or love.keyboard.isDown(Keybind.downKey) then
		direction.y = 1
		commandKey = commandKey .. "down"
	end
	if love.keyboard.isDown(Keybind.leftArow) or love.keyboard.isDown(Keybind.leftKey) then
		direction.x = -1
		commandKey = commandKey .. "left"
	elseif love.keyboard.isDown(Keybind.rightArrow) or love.keyboard.isDown(Keybind.rightKey) then
		direction.x = 1
		commandKey = commandKey .. "right"
	end
	return commandKey, direction
end

function KeyEvent.directionKey(key, scanCode, isRepeat)
	local direction = {x = 0, y = 0}
	local commandKey = ""
	if key == Keybind.upArrow or key == Keybind.upKey then
		direction.y = -1
		commandKey = commandKey .. "up"
	elseif key == Keybind.downArrow or key == Keybind.downKey then
		direction.y = 1
		commandKey = commandKey .. "down"
	end
	if key == Keybind.leftArow or key == Keybind.leftKey then
		direction.x = -1
		commandKey = commandKey .. "left"
	elseif key == Keybind.rightArrow or key == Keybind.rightKey then
		direction.x = 1
		commandKey = commandKey .. "right"
	end
	return commandKey, direction
end

function KeyEvent.undoPlanKey(key, scanCode, isRepeat)
	if key == Keybind.cancel then
		return Keybind.cancel
	else
		return nil
	end
end

function KeyEvent.redoPlanKey(key, scanCode, isRepeat)
	if key == Keybind.redo then
		return Keybind.redo
	else
		return nil
	end
end

function KeyEvent.executePlanKey(key, scanCode, isRepeat)
	if key == Keybind.execute then
		return Keybind.execute
	else
		return nil
	end
end

function KeyEvent.undoExecuteKey(key, scanCode, isRepeat)
	if key == Keybind.undo then
		return Keybind.undo
	else
		return nil
	end
end

return KeyEvent
