local Game = {}
Game.__index = Game

function Game.new(group)
	local self = setmetatable({}, Game)
	self.group = group

	return self
end

function Game:update(delta, time)
end

return Game
