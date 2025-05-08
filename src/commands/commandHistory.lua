local CommandHistory = {}

function CommandHistory:new()
	local newInstance = {}
	newInstance.history = {}
	newInstance.pointer = 0
	newInstance.addPointer = 0
	setmetatable(newInstance, {
		__index = function(table, key)
			return CommandHistory[key]
		end
	})
	return newInstance
end

function CommandHistory:reset()
	for i = #self.history, 1, -1 do
		table.remove(self.history, i)
	end
end

function CommandHistory:cleanup()
	for i = #self.history, self.addPointer, -1 do
		table.remove(self.history, i)
	end
end

function CommandHistory:push(command)
	if (self.history[self.addPointer + 1] ~= nil) then
		for i = #self.history, self.addPointer + 1, -1 do
			table.remove(self.history, i)
		end
	end
	table.insert(self.history, command)
	self.addPointer = self.addPointer + 1
end

function CommandHistory:pop()
	local command = nil
	if (self.addPointer > self.pointer) then
		command = self.history[self.addPointer]
		self.addPointer = self.addPointer - 1
	end
	return command
end

function CommandHistory:undoPop()
	if (self.addPointer + 1 ~= nil) then
		self.addPointer = self.addPointer + 1
	end
end

function CommandHistory:forward()
	if (self.pointer + 1 > 0 and self.pointer + 1 <= self.addPointer) then
		self.pointer = self.pointer + 1
		return self.history[self.pointer]
	else
		return nil
	end
end

function CommandHistory:backward()
	if (self.pointer - 1 > 0 and self.pointer <= self.addPointer) then
		self.pointer = self.pointer - 1
		return self.history[self.pointer + 1]
	else
		return nil
	end
end

function CommandHistory:toString()
	local label = ""
	for i = 1, #self.history do
		label = label .. self.history[i].label
		if (i == self.pointer) then
			label = label .. "\t"
		end
		if (i == self.addPointer) then
			label = label .. "\t"
		end
	end
	return label
end

return CommandHistory
