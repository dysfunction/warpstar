local Background = {}
Background.__index = Background

function Background.new(game)
	local self = setmetatable({}, Background)

	self.game = game
	self.x = 0
	self.y = 125
	self.offsetX = 0
	self.scale = 2.2
	self.imageLeft = display.newImage(game.group, 'images/background.png')
	self.imageRight = display.newImage(game.group, 'images/background.png')
	self.width = self.imageLeft.width
	self.imageLeft.xScale = self.scale
	self.imageLeft.yScale = self.scale
	self.imageRight.xScale = self.scale
	self.imageRight.yScale = self.scale

	return self
end

function Background:update(delta)
	self.offsetX = self.offsetX + delta * -0.02 * self.game.speed

	while (self.offsetX <= -self.width) do
		self.offsetX = self.offsetX + self.width
	end

	self.imageLeft.x = (self.x + self.offsetX) * self.scale
	self.imageLeft.y = self.y
	self.imageRight.x = self.imageLeft.x + self.imageLeft.width * self.scale
	self.imageRight.y = self.y
end

return Background
