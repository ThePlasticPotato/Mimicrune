local Soul, super = Utils.hookScript(Soul)

function Soul:init(x, y, color)
    super.init(self, x, y, color)
    self.parry_timer = 0
    self.parry_cd = 0
    self.parry_draw_timer = 0

    self.parry_sprite = Sprite("player/parry")
    self.parry_sprite:setOrigin(0.5, 0.5)
    self.parry_sprite.inherit_color = false
    self:addChild(self.parry_sprite)
    
    self.parry_glow = Sprite("player/heart_outline_outer")
    self.parry_glow:setOrigin(0.5, 0.5)
    self.parry_sprite.inherit_color = false
    self:addChild(self.parry_glow)
end

function Soul:doMovement()
    super.doMovement(self)
    if Input.down("parry") and self.parry_cd == 0 and self.inv_timer == 0 then
        self.parry_timer = 0.1
        self.parry_cd = 2
    end
end

function Soul:update()
    if self.parry_cd > 0 then
        self.parry_cd = Utils.approach(self.parry_cd, 0, DT)
    end
    if self.parry_timer > 0 then
        self.parry_timer = Utils.approach(self.parry_timer, 0, DT)
    end
    if self.parry_draw_timer > 0 then
        self.parry_draw_timer = Utils.approach(self.parry_draw_timer, 0, DT)
    end

    super.update(self)
end

function Soul:draw()
    self.parry_glow.visible = self.parry_timer > 0
    super.draw(self)
    self.parry_sprite.visible = self.parry_draw_timer > 0
    self.parry_sprite:setColor(1.0, 1.0, 1.0, self.parry_draw_timer/1.0)
end

return Soul