define ->
	module = {}
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
				module[key] = PIXI.Texture.fromImage(assets[key])

			callback()

		loader.load()

	module.load = load;
	return module
