local Circlesplosion, super = Class(Bullet)

function Circlesplosion:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y)

    self.radius = 1
    self.expansion_rate = 2
    self.collider = CircleCollider(self, self.x, self.y, self.radius)
    self:fadeOutAndRemove(1)
end

function Circlesplosion:update()
    self.expansion_rate = self.expansion_rate - DT
    self.radius = self.radius + self.expansion_rate * DTMULT
    -- For more complicated bullet behaviours, code here gets called every update
    self.collider.radius = self.radius

    super.update(self)
end

function Circlesplosion:draw()
    super.draw(self)
    Draw.setColor(1, 1, 1, self.alpha)
    love.graphics.ellipse("fill", 0, 0, self.radius, self.radius)
    Draw.setColor(1,1,1,1)
end

return Circlesplosion