local Command = {}

function Command:new(receiver, executeInput, undoInput, label)
	local newInstance = {}
	newInstance.receiver = receiver
	newInstance.executeInput = executeInput
	newInstance.undoInput = undoInput
	newInstance.label = label
	setmetatable(newInstance, {
		__index = function(table, key)
			return Command[key]
		end
	})
	return newInstance
end

function Command:execute()
	self.receiver:execute(self.executeInput)
end

function Command:undo()
	self.receiver:undo(self.undoInput)
end

return Command
