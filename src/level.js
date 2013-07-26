define(['assets', 'util'], function (Assets, Util) {
	var BLOCK_SIZE = 32;

	var obstacleTypes = [
		// Ground-level 2x2
		{ x: 0, y: 0, width: 2, height: 2 },

		// Jumpable 2x4
		{ x: 0, y: 0, width: 2, height: 4 },

		// Duckable 2x4
		{ x: 0, y: -BLOCK_SIZE * 2, width: 2, height: 4 },

		// Duckable 12x8
		{ x: 0, y: -BLOCK_SIZE * 2, width: 12, height: 8 }
	];

	function Level(game, startX, startY, obstacleCount, obstacleLevel) {
		PIXI.DisplayObjectContainer.call(this);

		this.game = game;
		this.obstacles = [];
		this.x = 0;
		var x = startX;
		var y = startY;
		var max = Math.min(Math.max(1, obstacleLevel || 1), obstacleTypes.length);
		var j, ob, sprite;

		for (j = 0; j < obstacleCount; j += 1) {
			ob = obstacleTypes[Util.randFloor(0, max)];
			sprite = new PIXI.TilingSprite(
				Assets.block,
				ob.width * BLOCK_SIZE,
				ob.height * BLOCK_SIZE 
			);

			sprite.position.x = x + ob.x;
			sprite.position.y = ob.y + game.HEIGHT - ob.height * BLOCK_SIZE - game.ground.height;
			x += ob.width * BLOCK_SIZE + 250 + game.speed * 10;

			this.addChild(sprite);
		}
	}

	Level.prototype = new PIXI.DisplayObjectContainer();

	Level.prototype.update = function (delta) {
		this.x += delta * -0.1 * this.game.speed;
		this.position.x = Math.floor(this.x);
	};

	return Level;
});
