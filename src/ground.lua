local Ground = {}
Ground.__index = Ground

function Ground.new(game)
	local self = setmetatable({}, Ground)
	self.game = game
	self.images = {}
	self.group = display.newGroup()
	self.x = 0
	self.tileWidth = 0

	local j = 0
	while (j * self.tileWidth < game.WIDTH + self.tileWidth * 2) do
		local image = display.newImage(self.group, 'images/ground.png')
		self.tileWidth = image.width
		image.x = math.floor(j * image.width)
		image.y = math.floor(game.HEIGHT - image.height * 0.5)
		j = j + 1
		self.images[j] = image
	end

	return self
end

function Ground:update(delta)
	self.x = self.x + delta * 0.1 * self.game.speed
	self.group.x = -(math.floor(self.x) % self.tileWidth) - self.tileWidth
end

return Ground
