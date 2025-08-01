local SoulPulse, super = Class(Object)

function SoulPulse:init(x, y)
    super.init(self, x, y)

    self:setScale(1)
    self:setOrigin(0.5, 0.5)
    

    self.sprite = Assets.getTexture("player/heart_hidden")
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self:setColor(2/255, 1, 2/255, 0)
    self:fadeTo(1.0, 0.4)
end

function SoulPulse:draw()
    super.draw(self)
    Draw.draw(self.sprite, 0, 0)
end

return SoulPulse