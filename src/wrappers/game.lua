local Spawner = require("src.wrappers.spawner")

local Game = {}

local agents = {}
local objects = {}

function Game.load()
	agents, objects = Spawner.Spawn()
end

function Game.update(dt)
	for i = 1, #objects do
		if (agents[i] ~= nil) then
			objects[i].text = agents[i].agent:planToString()
		end
	end
end

function Game.keypressed(key, scancode, isrepeat)
	for i = 1, #agents do
		if (agents[i].type == "keyboard") then
			agents[i].agent:directionPlan(key, scancode, isrepeat)
			agents[i].agent:undoPlan(key, scancode, isrepeat)
			agents[i].agent:redoPlan(key, scancode, isrepeat)
			agents[i].agent:executePlan(key, scancode, isrepeat)
			agents[i].agent:undoExecute(key, scancode, isrepeat)
		end
	end
end

function Game.draw()
	for i = 1, #objects do
		objects[i]:render()
	end
end

return Game
