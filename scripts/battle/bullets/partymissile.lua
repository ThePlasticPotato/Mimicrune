local PartyMissile, super = Class(Bullet)

function PartyMissile:init(x, y, sprite, dir, speed, target)
    -- Last argument = sprite path
    super.init(self, x, y, (Game.battle.tense) and ("bullets/partymissile_twisted") or "bullets/partymissile")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.match_rotation = true
    self.rotation = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.parry = true
    self.visual_siner = 0
    self.afterimg_timer = 0
    self.smoketrail = {}
    self.target_x = target[1]
    self.target_y = target[2]
    self.should_turn = false
    self.inited = false
    self.destroy_on_hit = false
    self.remove_offscreen = false
    self.exploded = false

    --self.damage = self.damage * 4
end

function PartyMissile:update()
    if (self.exploded) then
        super.update(self)
        return
    end
    if not self.inited then
        self.inited = true
        self.wave.timer:after(MathUtils.random(0.8, 1.0), function() self.should_turn = true end)
    end
    self.physics.speed = MathUtils.approach(self.physics.speed, 20, DTMULT / 2)
    if (self.should_turn) then self.rotation = MathUtils.approachAngle(self.rotation, MathUtils.angle(self.x, self.y, self.target_x, self.target_y), DTMULT / 4) end

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

    if true then
        -- local smoke = {
        --     ["time"] = 1,
        --     ["size"] = ,
        --     ["x"] = self.x,
        --     ["y"] = self.y
        -- }
        local rad = MathUtils.random(0.5, 2)
        local smoke = Ellipse(self.x, self.y, rad * 2, rad * 2)
        smoke:fadeOutAndRemove(1)
        smoke.layer = self.layer - 1
        Game.battle:addChild(smoke)
        table.insert(self.smoketrail, #self.smoketrail+1, smoke)
    end

    if (self.smoketrail[1] and self.smoketrail[1].alpha <= 0) then
        table.remove(self.smoketrail, 1)
    end

    if (MathUtils.dist(self.x, self.y, self.target_x, self.target_y) <= 16) then
        self.wave:explodeMissile(self)
    end
    super.update(self)
end

function PartyMissile:onCollide(soul)
    super.onCollide(self, soul)
    self.target_x = soul.x
    self.target_y = soul.y
    self.wave:explodeMissile(self)
end

function PartyMissile:draw()
    -- for i, smoke in ipairs(self.smoketrail) do
    --     local alpha = math.max(smoke.time, 0)
    --     Draw.setColor(0.75, 0.5, 0.5, alpha)
    --     love.graphics.ellipse("fill", self.x - smoke.x, self.y - smoke.y, smoke.size * 2, smoke.size * 2)
    -- end
    super.draw(self)
end

return PartyMissile