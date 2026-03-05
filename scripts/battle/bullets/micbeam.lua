local MicBeam, super = Class(Bullet)

function MicBeam:init(x, y, radius, rate)
    -- Last argument = sprite path
    super.init(self, x, y)

    self.radius = radius or 1
    self.expansion_rate = rate or 1
    self.height = 142
    self.collider = Hitbox(self, -self.radius/4, 0, self.radius/2, self.height)
    self:fadeOutAndRemove(1)
    self.destroy_on_hit = false
end

function MicBeam:update()
    self.expansion_rate = self.expansion_rate - DT
    self.radius = self.radius + self.expansion_rate * DTMULT
    -- For more complicated bullet behaviours, code here gets called every update
    self.collider.x = -self.radius/4
    self.collider.width = self.radius/2

    self.collidable = self.alpha > 0.5

    super.update(self)
end

function MicBeam:draw()
    super.draw(self)
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.rectangle("fill", -self.radius, 0, self.radius * 2, self.height/2)
    Draw.setColor(1,1,1,1)
end

return MicBeam