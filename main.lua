local Game = require 'game'
local fps = display.newText('FPS: 00', 10, 10, native.systemFont, 20)
local game = nil

local timer = {
	lastUpdate = -1,
	delta = 0,
	frames = 0,
	frameTicks = 0
}

function update(evt)
	if (timer.lastUpdate < 0) then
		timer.lastUpdate = evt.time
		return
	end

	timer.delta = evt.time - timer.lastUpdate
	timer.lastUpdate = evt.time

	timer.frames = timer.frames + 1
	timer.frameTicks = timer.frameTicks + timer.delta
	while (timer.frameTicks >= 1000) do
		timer.frameTicks = timer.frameTicks - 1000
		fps.text = 'FPS: ' .. timer.frames
		timer.frames = 0
	end

	game:update(timer.delta, evt.time)
end

display.setStatusBar(display.HiddenStatusBar)

game = Game.new(display.newGroup())

display.currentStage:addEventListener('touch', function (evt)
	print(evt.name, evt.phase, evt.x, evt.y)
end)

Runtime:addEventListener('enterFrame', update)
