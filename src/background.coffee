Assets = require('./assets.coffee')
Background = (game) ->
	PIXI.DisplayObjectContainer.call(this)

	sprites = []
	@game = game
	@x = 0
	@offsetX = 0
	@position.y = -40
	@scale.x = 2.2
	@scale.y = 2.2

	for j in [0..1] by 1
		sprite = new PIXI.Sprite(Assets.background)
		sprite.position.x = Math.floor(j * sprite.width)
		sprite.position.y = 0
		sprites.push(sprite)
		@width = sprite.width
		@addChild(sprite)

	return this

Background.prototype = new PIXI.DisplayObjectContainer()

Background.prototype.update = (delta) ->
	@offsetX += delta * -0.02 * @game.speed

	while (@offsetX <= -@width)
		@offsetX = @offsetX + @width

	@position.x = Math.floor(-90 + @offsetX * @scale.x)


module.exports = Background
