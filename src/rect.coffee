Rect = (x, y, width,height) ->
	@x = +x || 0
	@y = +y || 0
	@width = +width || 1
	@height = +height || 1

Rect.prototype.contains = (x, y) ->
	return (
		(x >= @x && x <= @x + @width) &&
		(y >= @y && y <= @y + @height)
	)

# modified from the java.awt.Rect source code
Rect.prototype.intersects = (rect) ->
	tw = @width
	th = @height
	rw = rect.width
	rh = rect.height
	if (rw <= 0 || rh <= 0 || tw <= 0 || th <= 0)
		return false

	tx = @x
	ty = @y
	rx = rect.x
	ry = rect.y
	rw += rx
	rh += ry
	tw += tx
	th += ty
	#      overflow || intersect
	return ((rw < rx || rw > tx) &&
		(rh < ry || rh > ty) &&
		(tw < tx || tw > rx) &&
		(th < ty || th > ry))

module.exports = Rect
