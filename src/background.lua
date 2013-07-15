local Background = {}
Background.__index = Background

function Background.new(game)
	local self = setmetatable({}, Background)

	self.game = game
	self.x = 0
	self.offsetX = 0
	self.group = display.newGroup()
	self.group.y = -65
	self.scale = 2.2
	self.group.xScale = self.scale
	self.group.yScale = self.scale

	for j = 1, 2, 1 do
		local image = display.newImage(self.group, 'images/background.png')
		image.x = (j - 1) * image.width
		self.width = image.width
	end

	return self
end

function Background:update(delta)
	self.offsetX = self.offsetX + delta * -0.02 * self.game.speed

	while (self.offsetX <= -self.width) do
		self.offsetX = self.offsetX + self.width
	end

	self.group.x = self.offsetX * self.scale

end

return Background
