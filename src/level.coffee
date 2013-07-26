define ['assets', 'util'], (Assets, Util) ->
	BLOCK_SIZE = 32

	obstacleTypes = [
		# Ground-level 2x2
		{ x: 0, y: 0, width: 2, height: 2 }

		# Jumpable 2x4
		{ x: 0, y: 0, width: 2, height: 4 }

		# Duckable 2x4
		{ x: 0, y: -BLOCK_SIZE * 2, width: 2, height: 4 }

		# Duckable 12x8
		{ x: 0, y: -BLOCK_SIZE * 2, width: 12, height: 8 }
	]

	Level = (game, startX, startY, obstacleCount, obstacleLevel) ->
		PIXI.DisplayObjectContainer.call(this)

		@game = game
		@obstacles = []
		@x = 0
		x = startX
		y = startY
		max = Math.min(Math.max(1, obstacleLevel || 1), obstacleTypes.length)

		for j in [0..obstacleCount - 1] by 1
			ob = obstacleTypes[Util.randFloor(0, max)]
			sprite = new PIXI.TilingSprite(
				Assets.block,
				ob.width * BLOCK_SIZE,
				ob.height * BLOCK_SIZE 
			)

			sprite.position.x = x + ob.x
			sprite.position.y = ob.y + game.HEIGHT - ob.height * BLOCK_SIZE - game.ground.height
			x += ob.width * BLOCK_SIZE + 250 + game.speed * 10

			@addChild(sprite)

		return this

	Level.prototype = new PIXI.DisplayObjectContainer()

	Level.prototype.update = (delta) ->
		@x += delta * -0.1 * @game.speed
		@position.x = Math.floor(@x)

	return Level
