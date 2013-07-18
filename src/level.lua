local Obstacle = require 'src.obstacle'
local Level = {}
Level.__index = Level

local obstacleTypes = {
	-- Ground-level 2x2
	{ x = 0, y = 0, width = 2, height = 2 },

	-- Jumpable 2x4
	{ x = 0, y = 0, width = 2, height = 4 },

	-- Duckable 2x4
	{ x = 0, y = -Obstacle.BLOCK_SIZE * 2, width = 2, height = 4 },

	-- Duckable 12x8
	{ x = 0, y = -Obstacle.BLOCK_SIZE * 2, width = 12, height = 8 }
}

function Level.new(game, startX, startY, obstacleCount, obstacleLevel)
	local self = setmetatable({}, Level)

	self.game = game
	self.obstacles = {}
	local x = startX
	local y = startY
	local max = obstacleLevel and obstacleLevel or 1
	max = math.min(math.max(1, max), #obstacleTypes)

	for j = 1, obstacleCount, 1 do
		local o = obstacleTypes[math.random(1, max)]
		local ob = Obstacle.new(game.group, x + o.x, y + o.y, o.width, o.height)
		ob:translate(0, game.HEIGHT - ob.height - game.ground.height)
		x = x + ob.width + 250 + game.speed * 10
		self.obstacles[j] = ob
	end

	return self;
end

function Level:update(delta)
	for j = 1, #self.obstacles, 1 do
		self.obstacles[j]:translate(delta * -0.1 * self.game.speed, 0)
	end
end

return Level
