local Renderable = {}

function Renderable:new(renderFunction)
	local newInstance = {}
	newInstance.renderFunction = renderFunction
	setmetatable(newInstance, {
		__index = function(table, key)
			return Renderable[key]
		end
	})
	return newInstance
end

function Renderable:draw()
	self.renderFunction()
end

return Renderable
