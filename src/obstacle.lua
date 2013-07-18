local Obstacle = {}
Obstacle.__index = Obstacle

Obstacle.BLOCK_SIZE = 32

function Obstacle.new(group, x, y, width, height)
	local self = setmetatable({}, Obstacle)
	self.group = group
	self.x = x
	self.y = y
	self.width = width * self.BLOCK_SIZE
	self.height = height * self.BLOCK_SIZE
	self.blocks = {}

	local count = 1

	for n = 1, height, 1 do
		for j = 1, width, 1 do
			self.blocks[count] = {
				x = j - 1,
				y = n - 1,
				image = display.newImage(group, 'images/block.png')
			}
			count = count + 1
		end
	end

	self:setPosition(x, y)

	return self
end

function Obstacle:setPosition(x, y)
	self.x = x
	self.y = y
	local o = nil

	for j = 1, #self.blocks, 1 do
		o = self.blocks[j]
		o.image.x = math.floor(x + o.x * self.BLOCK_SIZE + self.BLOCK_SIZE / 2)
		o.image.y = math.floor(y + o.y * self.BLOCK_SIZE + self.BLOCK_SIZE / 2)
	end
end

function Obstacle:translate(x, y)
	return self:setPosition(self.x + x, self.y + y)
end

return Obstacle
