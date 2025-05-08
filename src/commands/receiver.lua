local Receiver = {}

function Receiver:new(executeFunction, undoFunction)
	local newInstance = {}
	newInstance.executeFunction = executeFunction
	newInstance.undoFunction = undoFunction
	setmetatable(newInstance, {
		__index = function(table, key)
			return Receiver[key]
		end
	})
	return newInstance
end

function Receiver:execute(input)
	self.executeFunction(input)
end

function Receiver:undo(input)
	self.undoFunction(input)
end

return Receiver
