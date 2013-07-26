define(['assets'], function (Assets) {
	function Ground(game) {
		PIXI.DisplayObjectContainer.call(this);

		var ground = Assets.ground, sprite, j;

		this.game = game;
		this.x = 0;
		this.tileWidth = ground.width;
		this.height = Assets.ground.height;

		for (j = -1; j * ground.width < game.WIDTH + ground.width * 2; j += 1) {
			sprite = new PIXI.Sprite(ground);
			sprite.position.x = Math.floor(j * ground.width);
			sprite.position.y = Math.floor(game.HEIGHT - ground.height);
			this.addChild(sprite);
		}

		return this;
	}

	Ground.prototype = new PIXI.DisplayObjectContainer();

	Ground.prototype.update = function (delta) {
		this.x += delta * 0.1 * this.game.speed;
		this.position.x = -(Math.floor(this.x) % this.tileWidth) - this.tileWidth;
	};

	return Ground;
});
