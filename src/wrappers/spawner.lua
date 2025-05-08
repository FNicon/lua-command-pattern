local Objects = require("data.controllable.objects")
local Loader = require("src.wrappers.loader")
local ControllableObject = require("src.controllable.controllableObject")
local AgentKeyboard = require("src.controllerAgents.agentKeyboard")

local Spawner = {}

function Spawner.Spawn()
	local objects = {}
	local agents = {}
	for i=1, #Objects do
		local font = Loader.loadFont(Objects[i].font.path, Objects[i].font.size)
		local object = ControllableObject:new(Objects[i].x, Objects[i].y, Objects[i].size, font)
		table.insert(objects, object)
		table.insert(agents, Spawner.SpawnAgent(Objects[i].agent, object.moveableReceiver))
	end
	return agents, objects
end

function Spawner.SpawnAgent(agentData, receiver)
	if (agentData.type == "keyboard") then
		local agent = AgentKeyboard:new(receiver)
		return { type = "keyboard", agent = agent }
	else
		return nil
	end
end

return Spawner
