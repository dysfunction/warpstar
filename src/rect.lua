local Rect = {}
Rect.__index = Rect

function Rect.new(x, y, width, height)
	local self = setmetatable({}, Rect)

	self.x = x
	self.y = y
	self.width = width
	self.height = height

	return self
end

function Rect:intersects(rect)

	local tw = this.width
	local th = this.height
	local rw = rect.width
	local rh = rect.height
	if (rw <= 0 or rh <= 0 or tw <= 0 or th <= 0) then
		return false
	end

	local tx = this.x
	local ty = this.y
	local rx = rect.x
	local ry = rect.y
	rw = rw + rx
	rh = rh + ry
	tw = tw + tx
	th = th + ty

	return ((rw < rx or rw > tx) and
		(rh < ry or rh > ty) and
		(tw < tx or tw > rx) and
		(th < ty or th > ry))
end

return Rect
