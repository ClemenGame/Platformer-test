local Test = {}
local State = require("state")
local Player = require("player")

function Test:draw()
    i = 1
	love.graphics.draw("assets/state/"..i..".png")
end

function Test:keypressed(key, scancode, isrepeat)
	if scancode == "return" then
		State:setState("map")
        i = i + 1
	end
end