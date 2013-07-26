define([
	'background',
	'ground',
	'kirby',
	'level',
	'util'
], function(Background, Ground, Kirby, Level, Util) {

	function Game(container) {
		this.WIDTH = Game.WIDTH;
		this.HEIGHT = Game.HEIGHT;
		this.CENTERX = Game.CENTERX;

		this.speed = 3;
		this.input = {
			touches: {},
			left: false,
			right: false
		};

		this.background = new Background(this);
		this.ground = new Ground(this);
		this.level = new Level(this, this.WIDTH, 0, 20, 4); 
		this.kirby = new Kirby(this);

		container.addChild(this.background);
		container.addChild(this.ground);
		container.addChild(this.level);
		container.addChild(this.kirby);
	}

	Game.WIDTH = 480;
	Game.HEIGHT = 320;
	Game.CENTERX = Math.floor(Game.WIDTH / 2);

	Game.prototype.touchStart = function (x, y) {
		if (x < Game.CENTERX) {
			this.input.left = true;
			this.kirby.duck();
		} else {
			this.input.right = true;
			this.kirby.jump();
		}
	};

	Game.prototype.touchEnd = function (x, y) {
		this.input.left = false;
		this.input.right = false;
	};

	Game.prototype.update = function (delta) {
		this.background.update(delta);
		this.ground.update(delta);
		this.kirby.update(delta);
		this.level.update(delta);
	};

	return Game;
});
