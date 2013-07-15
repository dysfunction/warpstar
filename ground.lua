local Ground = {}
Ground.__index = Ground

function Ground.new(game)
	local self = setmetatable({}, Ground)
	self.game = game
	self.images = {}
	self.group = display.newGroup()
	self.x = 0

	local width = 0
	local j = 0
	while (j * width < game.WIDTH + width * 2) do
		self.images[j + 1] = display.newImage(self.group, 'ground.png')
		width = self.images[j + 1].width
		self.images[j + 1]:translate(j * width, game.HEIGHT - self.images[j + 1].height)
		j = j + 1
	end
	self.tileWidth = width

	return self
end

function Ground:update(delta)
	self.x = self.x + delta * 0.1 * self.game.speed
	self.group.x = -(self.x % self.tileWidth) - 90
end

return Ground
