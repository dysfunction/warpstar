require ['game', 'assets', 'util'], (Game, Assets, Util) ->
	renderer = null
	container = null
	stage = null
	game = null
	repaint = Util.requestAnimationFrame
	timer =
		ticks: 0
		startTime: -1
		lastUpdate: 0

	resize = (width, height) ->
		renderer.resize(width, height)
		scale = width / Game.WIDTH
		scale = Math.min(scale, height / Game.HEIGHT)
		container.scale.x = scale
		container.scale.y = scale
		container.position.x = Math.floor(width - Game.WIDTH * scale)
		container.position.y = Math.floor(height - Game.HEIGHT * scale)

	init = -> 
		stage = new PIXI.Stage(0x000000, true)
		renderer = new PIXI.autoDetectRenderer(Game.WIDTH, Game.HEIGHT)
		console.log(renderer);

		container = new PIXI.DisplayObjectContainer()
		container.setInteractive(true)
		container.touchstart = (event) ->
			pos = event.getLocalPosition(container)
			game.touchStart(Math.floor(pos.x), Math.floor(pos.y))

		container.touchend = (event) ->
			pos = event.getLocalPosition(container)
			game.touchEnd(Math.floor(pos.x), Math.floor(pos.y))

		resize(window.innerWidth, window.innerHeight)

		game = new Game(container)

		stage.addChild(container)
		document.body.appendChild(renderer.view)
		repaint(gameLoop)

	update = (delta, ticks) ->
		game.update(delta)

	gameLoop = (time) ->
		if (timer.startTime < 0)
			timer.startTime = time
			timer.lastUpdate = time
			return repaint(gameLoop)

		timer.delta = time - timer.lastUpdate
		timer.ticks = time - timer.startTime
		timer.lastUpdate = time
		update(timer.delta, timer.ticks)

		renderer.render(stage)
		repaint(gameLoop)

	window.onresize = -> resize(window.innerWidth, window.innerHeight)

	Assets.load(init)
