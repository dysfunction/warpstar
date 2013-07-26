define ->
	requestAnimationFrame = window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	(callback) -> window.setTimeout (-> callback Date.now()), 20

	createCanvas = (width, height, node) ->
		canvas = document.createElement('canvas')
		canvas.width = width
		canvas.height = height

		if (node && node.appendChild)
			node.appendChild(canvas)

		return canvas.getContext('2d')

	loadScript = (src, callback) ->
		script = document.createElement('script')
		script.async = true
		script.onload = callback
		script.src = src
		document.body.appendChild(script)
		return script

	rand = (min, max) -> min + Math.random() * (max - min)

	randFloor = (min, max) -> Math.floor(rand(min, max))

	# Modulo operation that supports negatives
	mod = (left, right) -> ((left % right) + right) % right

	toRadians = (degrees) -> degrees * (Math.PI / 180)

	# Determine angle between two points
	calcAngle = (p1, p2) ->
		degree = Math.atan2(p2.x - p1.x, p2.y - p1.y) * (180 / Math.PI) + 180
		return 360 - (degree % 360)

	return {
		createCanvas: createCanvas
		requestAnimationFrame: requestAnimationFrame
		loadScript: loadScript
		rand: rand
		randFloor: randFloor
		mod: mod
		toRadians: toRadians
		calcAngle: calcAngle
	}
