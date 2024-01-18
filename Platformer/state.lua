local State = {
	states = {},
	loaded = {},
	currentState = nil
}

function State:setState(scene)
	self.currentState = scene
end

function State:addState(state)
	table.insert(self.states, state)
end

function State:load()
	if self.currentState == nil then error("no State:currentState() not set") end
	for i, state in pairs(self.states) do
		self.loaded[state] = require(state)
	end
end

function State:keypressed(key, scancode, isrepeat)
	if self.loaded[self.currentState].keypressed then
		self.loaded[self.currentState]:keypressed(key, scancode, isrepeat)
	end
end

function State:draw()
	if self.loaded[self.currentState].draw then
		self.loaded[self.currentState]:draw()
	end
end

function State:update(dt)
	if self.loaded[self.currentState].update then
		self.loaded[self.currentState]:update(dt)
	end
end

return State