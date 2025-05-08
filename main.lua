local Game = require("src.wrappers.game")

function love.load()
	Game.load()
end

function love.update(dt)
	Game.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
	Game.keypressed(key, scancode, isrepeat)
end

function love.draw()
	Game.draw()
end

function love.quit()
end
