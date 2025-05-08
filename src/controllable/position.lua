local Position = {}

function Position:new(x, y)
	local newInstance = {}
	newInstance.x = x
	newInstance.y = y
	setmetatable(newInstance, {
		__index = function(table, key)
			return Position[key]
		end
	})
	return newInstance
end

function Position:move(delta)
	self.x = self.x + delta.x;
	self.y = self.y + delta.y;
end

return Position
