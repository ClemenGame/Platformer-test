WalkState = Class{__includes = BaseState}

function WalkState:init()
  self.NAME = 'walk'
  self.animation = newAnimation(love.graphics.newImage("assets/images/finn_sprites/finn_walk.png"), 32, 32, 1)
end

function WalkState:enter(params)

end

function WalkState:exit()

end

function WalkState:update(dt)
  heroPhysics:walk()
  heroController:walk()
end

function WalkState:render()

end
