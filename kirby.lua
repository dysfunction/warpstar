local Kirby = {}
Kirby.__index = Kirby

function Kirby.new(game)
	local self = setmetatable({}, Kirby)

	self.game = game
	self.x = 100
	self.y = 180
	self.gravity = 0.8
	self.velocityY = 0
	self.ducking = false
	self.jumping = false
	self.offsetY = 0
	self.image = display.newImage(self.game.group, 'kirby.png')
	self.image.x = self.x
	self.image.y = self.y

	return self
end

function Kirby:duck()
	if (self.jumping == false) then
		self.ducking = true
	end
end

function Kirby:jump()
	if (self.ducking == false and self.jumping == false) then
		self.jumping = true
		self.velocityY = -1.15
	end
end

function Kirby:update(delta)
	if (self.ducking) then
		local offset = delta * 0.2

		if (self.game.input.left) then
			self.offsetY = math.min(64, self.offsetY + offset)
		else
			self.offsetY = math.max(0, self.offsetY - offset)
		end

		if (self.offsetY == 0) then
			self.ducking = false
			if (self.game.input.right) then
				self:jump()
			end
		end

	elseif (self.jumping) then
		self.offsetY = math.min(0, self.offsetY + self.velocityY * delta)
		self.velocityY = self.velocityY + self.gravity * delta * 0.005

		if (self.offsetY == 0) then
			self.jumping = false
			self.ducking = self.game.input.left
		end
	end

	self.image.y = self.y + self.offsetY
end

return Kirby
