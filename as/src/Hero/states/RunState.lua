RunState = Class{__includes = BaseState}

function RunState:init()
  self.NAME = 'run'
  self.animation = newAnimation(love.graphics.newImage("assets/images/finn_sprites/finn_run.png"), 32, 32, .7)

end

function RunState:enter(params)

end

function RunState:exit()

end

function RunState:update(dt)
  heroPhysics:run()
  heroController:run()
end

function RunState:render()

end
