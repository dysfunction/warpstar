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
	self:initKirby()

	return self
end

function Game:touchStart(x, y, evt)
	self.input.touches[evt.id] = { x = x, y = y }

	if (self.kirby.jumping == false and x < Game.CENTERX) then
		self.kirby.ducking = true
		self.input.left = true
	elseif (self.kirby.ducking == false and x >= Game.CENTERX) then
		self.kirby.jumping = true
		self.kirby.velocityY = -1.15
		self.input.right = true
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

function Game:initKirby()
	self.kirby = {
		x = 100,
		y = 180,
		gravity = 0.8,
		velocityY = 0,
		ducking = false,
		jumping = false,
		offsetY = 0,
		image = display.newImage(self.group, 'kirby.png')
	}
	self.kirby.image.x = self.kirby.x
	self.kirby.image.y = self.kirby.y
end

function Game:updateKirby(delta)
	if (self.kirby.ducking) then
		local offset = delta * 0.2;

		if (self.input.left) then
			self.kirby.offsetY = math.min(64, self.kirby.offsetY + offset)
		else
			self.kirby.offsetY = math.max(0, self.kirby.offsetY - offset)
		end

		self.kirby.ducking = self.kirby.offsetY ~= 0

	elseif (self.kirby.jumping) then
		self.kirby.offsetY = math.min(0, self.kirby.offsetY + self.kirby.velocityY * delta)
		self.kirby.velocityY = self.kirby.velocityY + self.kirby.gravity * delta * 0.005

		self.kirby.jumping = self.kirby.offsetY ~= 0
	end

	self.kirby.image.y = self.kirby.y + self.kirby.offsetY
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
	self:updateKirby(delta)
end

return Game
