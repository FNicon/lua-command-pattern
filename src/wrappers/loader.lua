local loader = {}

function loader.loadFont(path, size)
	return love.graphics.newFont(path, size)
end

return loader
