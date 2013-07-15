local Game = {}
Game.__index = Game

Game.WIDTH = 480
Game.HEIGHT = 320
Game.CENTERX = math.floor(Game.WIDTH / 2)

function Game.new(group)
	local self = setmetatable({}, Game)
	display.setDefault('background', 83, 135, 162)
	self.group = group
	self.speed = 2
	self.input = {
		touches = {},
		left = false,
		right = false
	}

	self:initGround()

	return self
end

function Game:updateTouch(id, x, y, active)
	if (self.input.touches[id] == nil) then
		self.input.touches[id] = {}
	end

	self.input.touches[id].x = x
	self.input.touches[id].y = y
	self.input.touches[id].active = active or false and active
end

function Game:touchStart(x, y, evt)
	self:updateTouch(evt.id, x, y, true)

	if (x < Game.CENTERX) then
		self.input.left = true
	else
		self.input.right = true
	end
end

function Game:touchEnd(x, y, evt)
	self:updateTouch(evt.id, x, y, false)
	self.input.left = false
	self.input.right = false

	for k, touch in pairs(self.input.touches) do
		if (touch.active) then
			if (touch.x < Game.CENTERX) then
				self.input.left = true
			else
				self.input.right = true
			end
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
	self:updateGround(delta)
end

return Game
