local HitCircle, super = Class(Object)

function HitCircle:init(x, y, speed, radius)
    self.speed = speed
    super:init(self, x, y)
    --self.rotation = angle
    self:setOrigin(0.5, 0.5)
    self.radius = radius or 30
    self.layer = WORLD_LAYERS["ui"] + 100



    self:setScale(4, 4)

    self.pressed = false



    self.collider = CircleCollider(self, 0, 0 + self.radius, 8)
end

function HitCircle:update()
    if self.scale_x > 0.31 then
        self.scale_x = Utils.approach(self.scale_x, 0.3, self.speed * DTMULT)
        self.scale_y = Utils.approach(self.scale_y, 0.3, self.speed * DTMULT)
    else
        self:remove()
    end


    super:update(self)
end

function HitCircle:draw()
    love.graphics.setLineWidth(2)
    love.graphics.setColor(1, 0, 0, self.alpha)
    love.graphics.circle("line", 0, 0, self.radius)


    super:draw(self)
    if DEBUG_RENDER then
        self.collider:draw(1, 0, 0)
    end
end

function HitCircle:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

return HitCircle
