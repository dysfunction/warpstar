Assets = require('./assets.coffee')

Ground = (game) ->
	PIXI.DisplayObjectContainer.call(this)

	@game = game
	@x = 0
	@tileWidth = Assets.ground.width
	@height = Assets.ground.height

	j = -1
	while (j * @tileWidth < game.WIDTH + @tileWidth * 2)
		sprite = new PIXI.Sprite(Assets.ground)
		sprite.position.x = Math.floor(j * @tileWidth)
		sprite.position.y = Math.floor(game.HEIGHT - @height)
		@addChild(sprite)
		j += 1

	return this

Ground.prototype = new PIXI.DisplayObjectContainer()

Ground.prototype.update = (delta) ->
	@x += delta * 0.1 * @game.speed
	@position.x = -(Math.floor(@x) % @tileWidth) - @tileWidth

module.exports = Ground
