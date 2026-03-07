local SafeNoteBullet, super = Class(Bullet)

function SafeNoteBullet:init(x, y, dir, speed, twisted)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/notebullet_safe")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.parry = false
    self.visual_siner = 0
    self.afterimg_timer = 0
    self.damage = 0
    self.can_graze = false

    self:setColor(1,1,1,0.75)
    self:glitch()
end

function SafeNoteBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.visual_siner = self.visual_siner + (DTMULT / 4)
    self.y = self.y + (math.sin(self.visual_siner) * 1)
    self.afterimg_timer = self.afterimg_timer - DT
    -- if (self.afterimg_timer <= 0) then
    --     local afterimage = AfterImage(self, 0.5)
    --     --afterimage:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))
    --     self:addChild(afterimage)
    --     self.afterimg_timer = 0.30
    -- end
    super.update(self)
end

function SafeNoteBullet:onCollide(soul)
    for _, party in ipairs(Game.battle.party) do
        --party:heal(5)
    end
    for i, wave in ipairs(Game.battle.waves) do
        if (wave.perfect_notes) then wave.perfect_notes = wave.perfect_notes + 1 end
    end
    self:remove()
end

return SafeNoteBullet