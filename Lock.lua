Lock = Class{DMG_VALUE = 1}

ActiveLocks = {}

function Lock:init(x, y)

  self.sound = love.audio.newSource('assets/sounds/Lock.wav', 'static')

  self.x = x
  self.y = y

  self.image = love.graphics.newImage("assets/images/lock.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.toBeRemoved = false

  self.scale = 1

  self.physics = {}
  self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
  self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
  self.physics.body:setFixedRotation(true)
  self.physics.fixture:setUserData('Lock')
  --self.physics.fixture:setSensor(true)
  self.physics.body:setMass(0.5)
  --self.physics.body:setGravityScale(0)

  table.insert(ActiveLocks, self)
end

function Lock:update(dt)
  self.checkRemove()
end


function Lock:updateAll(dt)
  for i, v in ipairs(ActiveLocks) do
    v:update(dt)
  end
end

function Lock:render()
  love.graphics.draw(self.image, self.x - self.width/2, self.y - self.height/2, 0, self.scale, self.scale)
end

function Lock:renderAll()
  for i, v in ipairs(ActiveLocks) do
    v:render()
  end
end

function Lock:remove()
    for _, lock in pairs(ActiveLocks) do
        if self.toBeRemoved then
            table.remove(ActiveLocks, lock)
        end
    end
end

function Lock:removeAll()
  for i,v in ipairs(ActiveLocks) do
    v.physics.body:destroy()
  end

  ActiveLocks = {}
end

function Lock:checkRemove()

  if self.toBeRemoved then
    self:remove()
  end
end

function Lock:checkCoins(dt)
  if hero.coins == 1 then
    self.toBeRemoved
  end
end

function Lock:beginContact(a, b, collision)
  for i, instance in ipairs(ActiveLocks) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == hero.physics.fixture or b == hero.physics.fixture then
        print("colliding with Lock")
        hero:takeDamage(Lock.DMG_VALUE)

        return true
      end
    end
  end
end
