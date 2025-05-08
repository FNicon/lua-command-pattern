local Objects = require("data.controllable.objects")
local Loader = require("src.wrappers.loader")
local ControllableObject = require("src.controllable.controllableObject")
local AgentKeyboard = require("src.controllerAgents.agentKeyboard")
local AgentLoop = require("src.controllerAgents.agentLoop")

local Spawner = {}

function Spawner.Spawn()
	local objects = {}
	local agents = {}
	for i=1, #Objects do
		local font = Loader.loadFont(Objects[i].font.path, Objects[i].font.size)
		local object = ControllableObject:new(Objects[i].x, Objects[i].y, Objects[i].size, font)
		local agent = Spawner.SpawnAgent(Objects[i].agent, object.moveableReceiver, Objects[i].agent.plan)
		table.insert(objects, object)
		table.insert(agents, agent)
	end
	return agents, objects
end

function Spawner.SpawnAgent(agentData, receiver, plan)
	if (agentData.type == "keyboard") then
		local agent = AgentKeyboard:new(receiver)
		return { type = agentData.type, agent = agent }
	elseif (agentData.type == "loop") then
		local agent = AgentLoop:new(receiver, plan)
		return { type = agentData.type, agent = agent}
	else
		return nil
	end
end

return Spawner
