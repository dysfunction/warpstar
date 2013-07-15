local Kirby = require 'kirby'
local Game = {}
Game.__index = Game

Game.WIDTH = 480
Game.HEIGHT = 320
Game.CENTERX = math.floor(Game.WIDTH / 2)

function Game.new(group)
	local self = setmetatable({}, Game)
	display.setDefault('magTextureFilter', 'nearest')
	self.group = group
	self:initBackground()
	self.speed = 2
	self.input = {
		touches = {},
		left = false,
		right = false
	}

	self:initGround()
	self.kirby = Kirby.new(self)

	return self
end

function Game:initBackground()
	self.background = {
		x = 0,
		y = 125,
		offsetX = 0,
		scale = 2.2,
		imageLeft = display.newImage(self.group, 'background.png'),
		imageRight = display.newImage(self.group, 'background.png')
	}

	self.background.width = self.background.imageLeft.width
	self.background.imageLeft.xScale = self.background.scale
	self.background.imageLeft.yScale = self.background.scale
	self.background.imageRight.xScale = self.background.scale
	self.background.imageRight.yScale = self.background.scale

end

function Game:updateBackground(delta)
	self.background.offsetX = self.background.offsetX + delta * -0.02 * self.speed

	while (self.background.offsetX <= -self.background.width) do
		self.background.offsetX = self.background.offsetX + self.background.width
	end

	self.background.imageLeft.x = (self.background.x + self.background.offsetX) * self.background.scale
	self.background.imageLeft.y = self.background.y
	self.background.imageRight.x = self.background.imageLeft.x + self.background.imageLeft.width * self.background.scale
	self.background.imageRight.y = self.background.y
end

function Game:touchStart(x, y, evt)
	self.input.touches[evt.id] = { x = x, y = y }

	if (x < Game.CENTERX) then
		self.input.left = true
		self.kirby:duck()
	else
		self.input.right = true
		self.kirby:jump()
	end
end

function Game:touchEnd(x, y, evt)
	self.input.touches[evt.id] = nil
	self.input.left = false
	self.input.right = false

	for k, touch in pairs(self.input.touches) do
		if (touch.x < Game.CENTERX) then
			self.input.left = true
		else
			self.input.right = true
		end
	end
end

function Game:initGround()
	self.ground = {}
	self.ground.group = display.newGroup()
	self.ground.x = 0
	local width = 0
	local j = 0
	while (j * width < Game.WIDTH + width * 2) do
		self.ground[j + 1] = display.newImage(self.ground.group, 'ground.png')
		width = self.ground[j + 1].width
		self.ground[j + 1]:translate(j * width, Game.HEIGHT - self.ground[j + 1].height)
		j = j + 1
	end
	self.ground.tileWidth = width
end

function Game:updateGround(delta)
	self.ground.x = self.ground.x + delta * 0.1 * self.speed
	self.ground.group.x = -(self.ground.x % self.ground.tileWidth) - 90
end

function Game:update(delta, time)
	self:updateBackground(delta)
	self:updateGround(delta)
	self.kirby:update(delta)
end

return Game
