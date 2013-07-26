define ['assets', 'rect'], (Assets, Rect) ->
	Kirby = (game) ->
		PIXI.Sprite.call(this, Assets.kirby)

		@game = game
		@position.x = 100
		@startY = 148
		@position.y = @startY
		@gravity = 0.8
		@velocityY = 0
		@ducking = false
		@jumping = false
		@offsetY = 0

	Kirby.prototype = Object.create(PIXI.Sprite.prototype)
	Kirby.prototype.constructor = Kirby

	Kirby.prototype.duck = ->
		if (!@jumping)
			@ducking = true

	Kirby.prototype.jump = ->
		if (!@ducking && !@jumping)
			@jumping = true
			@velocityY = -1.15

	Kirby.prototype.update = (delta) ->
		offset = delta * 0.2

		if (@ducking)
			if (@game.input.left)
				@offsetY = Math.min(64, @offsetY + offset)
			else
				@offsetY = Math.max(0, @offsetY - offset)

			if (@offsetY == 0)
				@ducking = false
				if (@game.input.right)
					@jump()

		else if (@jumping)
			@offsetY = Math.min(0, @offsetY + @velocityY * delta)
			@velocityY = @velocityY + @gravity * delta * 0.005

			if (@offsetY == 0)
				@jumping = false
				@ducking = @game.input.left

		@position.y = Math.floor(@startY + @offsetY)

	return Kirby
