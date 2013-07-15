local Game = {}
Game.__index = Game

Game.WIDTH = 480
Game.HEIGHT = 320

function Game.new(group)
	local self = setmetatable({}, Game)
	display.setDefault('background', 83, 135, 162)
	self.group = group
	self.speed = 2

	self:initGround()

	return self
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
	self:updateGround(delta)
end

return Game
