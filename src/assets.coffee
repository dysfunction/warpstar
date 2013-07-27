result = {}
assets =
	background: 'images/background.png'
	ground: 'images/ground.png'
	kirby: 'images/kirby.png'
	block: 'images/block.png'

load = (callback) ->
	urls = Object.keys(assets).map (key) -> assets[key]

	loader = new PIXI.AssetLoader(urls)
	loader.on 'onComplete', ->
		Object.keys(assets).forEach (key) ->
			result[key] = PIXI.Texture.fromImage(assets[key])

		callback()

	loader.load()

result.load = load
module.exports = result
