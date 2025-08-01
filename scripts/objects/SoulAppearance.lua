---@class SoulAppearance : Object
---@overload fun(...) : SoulAppearance
local SoulAppearance, super = Class(Object)

function SoulAppearance:init(x, y, tiny, shouldbob)
    super.init(self, x, y)

    if (tiny ~= true) then
        self:setScale(2)
        self:setOrigin(0, 0)
    else
        self:setScale(1)
        self:setOrigin(0.5, 0.5)
    end
    self.should_bob = shouldbob or true

    self.sprite = Assets.getTexture("player/heart")
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.t = -10
    self.m = (self.height / 2)
    self.momentum = 0.5
    self.pos_offset = 0.0
    self.runtime = 0.0

    local pitch = 1.0
    if (tiny) then
        pitch = 1.5
    end
    Assets.playSound("AUDIO_APPEARANCE", 1.0, pitch)
    self:setColor(2/255, 1, 2/255, 1)
end

function SoulAppearance:hide()
    Assets.playSound("AUDIO_APPEARANCE")
    self.t = self.t - 2
    self.momentum = -0.5
    if self.t <= -10 then
        self:remove()
    end
end

function SoulAppearance:draw()
    super.draw(self)
    self.runtime = self.runtime + DT

    if (self.t <= 0) then
        self.xs = (1 + (self.t / 10))
        if (self.xs < 0) then
            self.xs = 0
        end

        Draw.drawPart(self.sprite, ((0 - ((self.width / 2) * self.xs)) + (self.width / 2)), self.m - 400, 0, self.m, self.width, 1, 0, self.xs, 800)
    end

    if ((self.t > 0) and (self.t < self.m)) then
        Draw.drawPart(self.sprite, 0, ((0 - self.t) + self.m), 0, (self.m - self.t), self.width, (1 + (self.t * 2)))
        Draw.drawPart(self.sprite, 0, (((0 - 400) - self.t) + self.m), 0, ((self.m - self.t) - 1), self.width, 1, 0, 1, 400)
        Draw.drawPart(self.sprite, 0, ((0 + self.t) + self.m), 0, (self.m + self.t), self.width, 1, 0, 1, 400)
    end

    if (self.t >= self.m) then
        if (self.should_bob) then
            self.pos_offset = self.pos_offset + (math.sin(self.runtime)/10)
        else
            self.pos_offset = Utils.approach(self.pos_offset, 0, DT)
        end
        
        Draw.draw(self.sprite, 0, self.pos_offset)
    end

    if (self.momentum > 0) then
        if (self.t < (self.m + 2)) then
            self.t = self.t + self.momentum * DTMULT
        end
    end
    if (self.momentum < 0) then
        self.t = self.t + self.momentum * DTMULT
    end
end

return SoulAppearance