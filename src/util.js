define(function () {
	var imageCache = {}, requestAnimationFrame;

	requestAnimationFrame = window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	function (callback) {
		window.setTimeout(function () {
			callback(Date.now());
		}, 20);
	};

	function loadImages(sources, callback) {
		var result = {}, count = 0, num = Object.keys(sources).length;

		function loaded() {
			count += 1;
			if (count >= num) {
				callback(result);
			}
		}

		Object.keys(sources).forEach(function (name) {
			var source = sources[name];
			result[name] = document.createElement('img');

			if (typeof imageCache[source] !== 'undefined') {
				result[name] = imageCache[source];
				loaded();
			} else {
				result[name].onload = loaded;
				result[name].src = source;
				imageCache[source] = result[name];
			}
		});
	}

	function createCanvas(width, height, node) {
		var canvas = document.createElement('canvas');
		canvas.width = width;
		canvas.height = height;

		if (node && node.appendChild) {
			node.appendChild(canvas);
		}

		return canvas.getContext('2d');
	}

	function loadScript(src, callback) {
		var script = document.createElement('script');
		script.async = true;
		script.onload = callback;
		script.src = src;
		document.body.appendChild(script);
		return script;
	}

	function rand(min, max) {
		return min + Math.random() * (max - min);
	}

	function randFloor(min, max) {
		return Math.floor(rand(min, max));
	}

	/* Modulo operation that supports negatives */
	function mod(left, right) {
		return ((left % right) + right) % right;
	}

	/* Translate event x,y coordinate relative to element */
	function translateEventPoint(element, evt) {
		var x, y, bounds;
		evt = evt || window.event;

		if (typeof evt.pageX !== 'undefined') {
			x = evt.pageX - document.body.scrollLeft - document.documentElement.scrollLeft;
			y = evt.pageY - document.body.scrollTop - document.documentElement.scrollTop;
		} else {
			x = evt.clientX;
			y = evt.clientY;
		}

		bounds = element.getBoundingClientRect();

		return ({
			x: x - bounds.left,
			y: y - bounds.top
		});
	}

	function toRadians(degrees) {
		return degrees * (Math.PI / 180);
	}

	/* Determine angle between two points */
	function calcAngle(p1, p2) {
		var degree = Math.atan2(p2.x - p1.x, p2.y - p1.y) * (180 / Math.PI) + 180;
		return 360 - (degree % 360);
	}

	return {
		loadImages: loadImages,
		createCanvas: createCanvas,
		requestAnimationFrame: requestAnimationFrame,
		loadScript: loadScript,
		rand: rand,
		randFloor: randFloor,
		mod: mod,
		translateEventPoint: translateEventPoint,
		toRadians: toRadians,
		calcAngle: calcAngle
	};
});
