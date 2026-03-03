local FallingMic, super = Class(Bullet)

function FallingMic:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, (Game.battle.tense) and ("bullets/mictoss_twisted") or "bullets/mictoss")

    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.gravity = 0.75
    self.destroy_on_hit = false
    self.physics.match_rotation = true
    self.physics.spin = 0.25 * math.pi
    
    self.afterimg_timer = 0
    self.exploded = false
    self.remove_offscreen = false
end

function FallingMic:update()
    if (self.exploded) then
        super.update(self)
        return
    end
    -- For more complicated bullet behaviours, code here gets called every update
    if (Game.battle.tense) then
        self.afterimg_timer = self.afterimg_timer - DT
        if (self.afterimg_timer <= 0) then
            local afterimage = AfterImage(self, 0.5)
            --afterimage:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))
            self:addChild(afterimage)
            self.afterimg_timer = 0.15
        end
    end

    if (self.y >= Game.battle.arena:getBottom()) then
        self.wave:explodeMic(self)
    end
    super.update(self)
end

return FallingMic