return {
	{
		x = 100,
		y = 100,
		size = 40,
		font = { path = "assets/EastSeaDokdo-Regular.ttf", size = 20 },
		agent = { type = "keyboard" }
	},
	{
		x = 200,
		y = 200,
		size = 20,
		font = { path = "assets/EastSeaDokdo-Regular.ttf", size = 20 },
		agent = {
			type = "loop",
			plan = { "up", "right", "left", "down" }
		}
	}
}
