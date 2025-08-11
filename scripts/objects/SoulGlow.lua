local SoulGlow, super = Class(Object)

function SoulGlow:init(x, y, soul)
    super.init(self, x, y)

    self:setScale(2)
    self:setOrigin(0.5, 0.5)

    self.soul = soul
    self.width = 64
    self.height = 64
    self.runtime = 0.0
    self.t = -10
    self.m = 64
    self.momentum = 2.0
    self.scale_offset = 0.0
    self.radius = self.t

    Assets.playSound("snd_greatshine", 1.0, 0.75)
    self:setColor(250/255, 1, 250/255, 1)
end

function SoulGlow:hide()
    self.momentum = -0.5
    if self.radius <= -9 then
        self:remove()
    end
end

function SoulGlow:draw()
    self.runtime = self.runtime + (DT/1.5)

    if (self.radius >= self.m) then
        self.scale_offset = self.scale_offset + (math.sin(self.runtime)/10)
    end
    if (self.radius >= 0) then
        love.graphics.setLineWidth(math.max(2, 4 + self.scale_offset))
        love.graphics.setColor(100/255, 1, 100/255, 0.05)
        love.graphics.circle("line", 32, 32 + self.soul.pos_offset, (self.radius + self.scale_offset)*1.25)
        love.graphics.setColor(220/255, 1, 220/255, 0.25)
        love.graphics.circle("fill", 32, 32 + self.soul.pos_offset, (self.radius + self.scale_offset))
        love.graphics.setColor(250/255, 1, 250/255, 0.5)
        love.graphics.circle("fill", 32, 32 + self.soul.pos_offset, (self.radius + self.scale_offset)*0.75)
    end
    
    if (self.momentum > 0) then
        if (self.radius < (self.m + 2)) then
            self.radius = Utils.lerp(self.radius, self.m, self.momentum * DT)
        end
        if (self.m - self.radius > 0 and self.m - self.radius < 0.001) then
            self.radius = self.m
        end
    end
    if (self.momentum < 0) then
        self.radius = Utils.lerp(self.radius, self.t, self.momentum * DT)
    end
    super.draw(self)
end

return SoulGlow