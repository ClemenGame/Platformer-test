ID = Class{DMG_VALUE = 10}

ActiveIDs = {}

function ID:init(x, y)

  -- self.animation = newAnimation(love.graphics.newImage("assets/images/jakoin_spin.png"), 16, 16, 2)

  self.x = x
  self.y = y

  self.image = love.graphics.newImage("assets/images/instantdeath.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.scaleX = 1

  self.physics = {}
  self.physics.body = love.physics.newBody(World, self.x + self.width/2, self.y + self.height/2, "static")
  self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.fixture:setSensor(true)

  -- self.DMG_VALUE = 1

  table.insert(ActiveIDs, self)
end

function ID:update(dt)

  -- updateAnimation(self.animation, dt)
end

function ID:updateAll(dt)
  for i, v in ipairs(ActiveIDs) do
    v:update(dt)
  end
end

function ID:render()
  love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
  --renderAnimation(self.animation, self.x, self.y, 1)
end

function ID:renderAll()
  for i, v in ipairs(ActiveIDs) do
    v:render()
  end
end

function ID:removeAll()
  for i,v in ipairs(ActiveIDs) do
    v.physics.body:destroy()
  end

  ActiveIDs = {}
end

function ID:beginContact(a, b, collision)
  for i, instance in ipairs(ActiveIDs) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == hero.physics.fixture or b == hero.physics.fixture then
        print("colliding with ID")
        hero:takeDamage(ID.DMG_VALUE)

        return true
      end
    end
  end
end
