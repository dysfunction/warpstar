define [
	'background',
	'ground',
	'kirby',
	'level',
	'util'
], (Background, Ground, Kirby, Level, Util) ->

	Game = (container) ->
		@WIDTH = Game.WIDTH
		@HEIGHT = Game.HEIGHT
		@CENTERX = Game.CENTERX

		@speed = 3
		@input =
			touches: {}
			left: false
			right: false

		@background = new Background(this)
		@ground = new Ground(this)
		@level = new Level(this, @WIDTH, 0, 20, 4) 
		@kirby = new Kirby(this)

		console.log 'wat', @level
		container.addChild @background
		container.addChild @ground
		container.addChild @level
		container.addChild @kirby

	Game.WIDTH = 480
	Game.HEIGHT = 320
	Game.CENTERX = Math.floor(Game.WIDTH / 2)

	Game.prototype.touchStart = (x, y) ->
		if (x < Game.CENTERX)
			@input.left = true
			@kirby.duck()
		else
			@input.right = true
			@kirby.jump()

	Game.prototype.touchEnd = (x, y) ->
		@input.left = false
		@input.right = false

	Game.prototype.update = (delta) ->
		@background.update(delta)
		@ground.update(delta)
		@kirby.update(delta)
		@level.update(delta)

	return Game
