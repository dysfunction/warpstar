local Background = require 'src.background'
local Ground = require 'src.ground'
local Kirby = require 'src.kirby'
local Game = {}
Game.__index = Game

Game.WIDTH = 480
Game.HEIGHT = 320
Game.CENTERX = math.floor(Game.WIDTH / 2)

function Game.new(group)
	local self = setmetatable({}, Game)
	display.setDefault('magTextureFilter', 'nearest')
	self.group = group
	self.speed = 2
	self.input = {
		touches = {},
		left = false,
		right = false
	}

	self.background = Background.new(self)
	self.ground = Ground.new(self)
	self.kirby = Kirby.new(self)

	return self
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

function Game:update(delta, time)
	self.background:update(delta)
	self.ground:update(delta)
	self.kirby:update(delta)
end

return Game
