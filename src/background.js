define(['assets'], function (Assets) {
	function Background(game) {
		PIXI.DisplayObjectContainer.call(this);

		var j, sprites = [], sprite;
		this.game = game;
		this.x = 0;
		this.offsetX = 0;
		this.position.y = -40;
		this.scale.x = 2.2;
		this.scale.y = 2.2;

		for (j = 0; j < 2; j += 1) {
			sprite = new PIXI.Sprite(Assets.background);
			sprite.position.x = Math.floor(j * sprite.width);
			sprite.position.y = 0;
			sprites.push(sprite);
			this.width = sprite.width;
			this.addChild(sprite);
		}
	}

	Background.prototype = new PIXI.DisplayObjectContainer();

	Background.prototype.update = function (delta) {
		this.offsetX = this.offsetX + delta * -0.02 * this.game.speed;

		while (this.offsetX <= -this.width) {
			this.offsetX = this.offsetX + this.width;
		}

		this.position.x = Math.floor(-90 + this.offsetX * this.scale.x);
	};

	return Background;
});
