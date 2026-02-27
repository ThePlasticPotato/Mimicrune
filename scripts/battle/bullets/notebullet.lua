local NoteBullet, super = Class(Bullet)

function NoteBullet:init(x, y, dir, speed, twisted)
    -- Last argument = sprite path
    super.init(self, x, y, (not twisted) and ("bullets/notebullet_twisted") or "bullets/notebullet")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.parry = true
    self.visual_siner = 0
    self.afterimg_timer = 0
end

function NoteBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.visual_siner = self.visual_siner + (DTMULT / 4)
    self.y = self.y + (math.sin(self.visual_siner) * 1)
    self.afterimg_timer = self.afterimg_timer - DT
    if (self.afterimg_timer <= 0) then
        local afterimage = AfterImage(self, 0.5)
        --afterimage:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))
        self:addChild(afterimage)
        self.afterimg_timer = 0.15
    end
    super.update(self)
end

return NoteBullet