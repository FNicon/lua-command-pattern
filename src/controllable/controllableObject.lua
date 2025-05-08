local Position = require("src.controllable.position")
local Renderable = require("src.controllable.renderable")
local Receiver = require("src.commands.receiver")

local ControllableObject = {}

function ControllableObject:new(x, y, size, font)
	local newInstance = {}
	setmetatable(newInstance, {
		__index = function(table, key)
			return ControllableObject[key]
		end
	})
	newInstance.size = size
	newInstance.moveable = Position:new(x, y)
	newInstance.renderable = Renderable:new(
		function()
			newInstance:render()
		end)
	newInstance.moveableReceiver = Receiver:new(
		function(input)
			newInstance:move(input)
		end,
		function(input)
			newInstance:move(input)
		end)
	newInstance.font = font
	newInstance.text = ""
	return newInstance
end

function ControllableObject:render()
	love.graphics.circle("fill", self.moveable.x, self.moveable.y, self.size)
	love.graphics.print(self.text, self.font, self.moveable.x - 75, self.moveable.y - 75)
end

function ControllableObject:move(delta)
	self.moveable:move(delta)
end

return ControllableObject
