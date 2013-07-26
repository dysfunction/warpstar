define(function () {
	var module = {};
	var assets = {
		background: 'images/background.png',
		ground: 'images/ground.png',
		kirby: 'images/kirby.png',
		block: 'images/block.png'
	};

	function load(callback) {
		var urls = Object.keys(assets).map(function(key) {
			return assets[key];
		});

		var loader = new PIXI.AssetLoader(urls);
		loader.on('onComplete', function () {
			Object.keys(assets).forEach(function (key) {
				module[key] = PIXI.Texture.fromImage(assets[key]);
			});

			callback();
		});

		loader.load();
	}

	module.load = load;
	return module;
});
