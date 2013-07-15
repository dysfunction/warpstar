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
	self:initKirby()

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

		if (self.kirby.jumping == false) then
			self.kirby.ducking = true
		end
	else
		self.input.right = true

		if (self.kirby.ducking == false and self.kirby.jumping == false) then
			self.kirby.jumping = true
			self.kirby.velocityY = -1.15
		end
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

		if (self.kirby.offsetY == 0) then
			self.kirby.ducking = false
			if (self.input.right) then
				self.kirby.jumping = true
				self.kirby.velocityY = -1.15
			end
		end

	elseif (self.kirby.jumping) then
		self.kirby.offsetY = math.min(0, self.kirby.offsetY + self.kirby.velocityY * delta)
		self.kirby.velocityY = self.kirby.velocityY + self.kirby.gravity * delta * 0.005

		if (self.kirby.offsetY == 0) then
			self.kirby.jumping = false
			self.kirby.ducking = self.input.left
		end
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
	self:updateBackground(delta)
	self:updateGround(delta)
	self:updateKirby(delta)
end

return Game
