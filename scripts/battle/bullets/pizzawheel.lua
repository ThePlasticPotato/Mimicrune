local PizzaWheel, super = Class(Bullet)

function PizzaWheel:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, (Game.battle.tense) and ("bullets/pizzawheel_twisted") or "bullets/pizzawheel")

    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = Game.battle.tense and 24 or 12
    self.physics.direction = math.pi
    --self.physics.match_rotation = false
    self.destroy_on_hit = false
    
    --self.physics.spin = 0.25 * math.pi
    
    self.afterimg_timer = 0
    self.reversed = false
    self.remove_offscreen = false
    self.parry = not Game.battle.tense
    self.rotation_speed = 0.25 * math.pi
    self.propogated = false
end

function PizzaWheel:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (Game.battle.tense) then
        self.afterimg_timer = self.afterimg_timer - DT
        if (self.afterimg_timer <= 0) then
            local afterimage = AfterImage(self, 0.5)
            --afterimage:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))
            self:addChild(afterimage)
            self.afterimg_timer = 0.15
        end

        if (self.x < Game.battle.arena:getLeft() - (self.width * 2)) then
            if not (self.reversed) then
                Assets.playSound("icky")
            end
            self.reversed = true

        end

        if (self.reversed) then
            self.physics.speed = MathUtils.approach(self.physics.speed, -30, DTMULT)
            self.sprite.flip_x = self.physics.speed < 0
            self.rotation_speed = MathUtils.approach(self.rotation_speed, -0.25 * math.pi, DTMULT / 2)
        end
    end

    if (self.reversed or (self.x <= 0 - self.width)) and not self.propogated then
        self.wave:pizzaTime()
        self.propogated = true
        if not (self.reversed) then self:remove() end
    end

    if (self.reversed and self.x >= SCREEN_WIDTH + self.width) then
        self:remove()
    end

    self.rotation = MathUtils.wrap(self.rotation - self.rotation_speed, 0, 2 * math.pi)
    super.update(self)
end

return PizzaWheel