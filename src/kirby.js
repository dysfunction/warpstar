define(['assets', 'rect'], function (Assets, Rect) {
	function Kirby(game) {
		PIXI.Sprite.call(this, Assets.kirby);

		this.game = game;
		this.position.x = 100;
		this.startY = 148;
		this.position.y = this.startY;
		this.gravity = 0.8;
		this.velocityY = 0;
		this.ducking = false;
		this.jumping = false;
		this.offsetY = 0;
	}

	Kirby.prototype = Object.create(PIXI.Sprite.prototype);
	Kirby.prototype.constructor = Kirby;

	Kirby.prototype.duck = function () {
		if (!this.jumping) {
			this.ducking = true;
		};
	};

	Kirby.prototype.jump = function () {
		if (!this.ducking && !this.jumping) {
			this.jumping = true;
			this.velocityY = -1.15;
		};
	};

	Kirby.prototype.update = function (delta) {
		var offset = delta * 0.2;

		if (this.ducking) {
			if (this.game.input.left) {
				this.offsetY = Math.min(64, this.offsetY + offset);
			} else {
				this.offsetY = Math.max(0, this.offsetY - offset);
			}

			if (this.offsetY === 0) {
				this.ducking = false;
				if (this.game.input.right) {
					this.jump();
				}
			}

		} else if (this.jumping) {
			this.offsetY = Math.min(0, this.offsetY + this.velocityY * delta);
			this.velocityY = this.velocityY + this.gravity * delta * 0.005;

			if (this.offsetY === 0) {
				this.jumping = false;
				this.ducking = this.game.input.left;
			}
		}

		this.position.y = Math.floor(this.startY + this.offsetY);
	};

	return Kirby;
});
