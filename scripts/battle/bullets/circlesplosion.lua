local Circlesplosion, super = Class(Bullet)

function Circlesplosion:init(x, y, radius, rate)
    -- Last argument = sprite path
    super.init(self, x, y)

    self.radius = radius or 1
    self.expansion_rate = rate or 2
    self.collider = CircleCollider(self, 0, 0, self.radius)
    self:fadeOutAndRemove(1)
    self.destroy_on_hit = false
end

function Circlesplosion:update()
    self.expansion_rate = self.expansion_rate - DT
    self.radius = self.radius + self.expansion_rate * DTMULT
    -- For more complicated bullet behaviours, code here gets called every update
    self.collider.radius = self.radius

    self.collidable = self.alpha > 0.5

    super.update(self)
end

function Circlesplosion:draw()
    super.draw(self)
    Draw.setColor(1, 1, 1, self.alpha)
    love.graphics.ellipse("fill", 0, 0, self.radius, self.radius)
    Draw.setColor(1,1,1,1)
end

return Circlesplosion