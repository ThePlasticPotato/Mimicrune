local ClawDebris, super = Class(Bullet)

function ClawDebris:init(x, y, dir, speed, width, height, target, safe)
    -- Last argument = sprite path
    super.init(self, x, y)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.rot = 0
    self.width = width or 4
    self.height = height or 4
    self.collider = Hitbox(self, -self.width/4, -self.height/4, self.width/2, self.height/2)
    self.safe = safe
    self.target = target
    self.remove_offscreen = false

    self:addFX(ShaderFX('pixelize', {
        size = {SCREEN_WIDTH, SCREEN_HEIGHT},
        factor = 2
    }))

    if (self.safe) then
        self.damage = 0
        self.can_graze = false
        self:glitch()
    end

    --self.damage = self.damage * 2
end

function ClawDebris:drawRotatedRectangle(mode, x, y, width, height, angle)
	-- We cannot rotate the rectangle directly, but we
	-- can move and rotate the coordinate system.
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
    love.graphics.setLineWidth(2)
	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end

function ClawDebris:onCollide(soul)
    self.wave.finished_bullets = self.wave.finished_bullets + 1
    if (not self.safe) then
        super.onCollide(self, soul)
        return
    end
    for _, party in ipairs(Game.battle.party) do
        --party:heal(5)
    end
    for i, wave in ipairs(Game.battle.waves) do
        if (wave.perfect_bullets) then wave.perfect_bullets = wave.perfect_bullets + 1 end
    end
    self:remove()
end

function ClawDebris:update()
    super.update(self)
    self.rot = self.rot + DTMULT
    local passed = ((self.wave.claw_side < 1) and (self.x <= self.target.x)) or ((self.wave.claw_side >= 1) and (self.x >= self.target.x))
    if (self.x < 0) or (self.x > SCREEN_WIDTH) then passed = false end
    if passed then
        self.wave.finished_bullets = self.wave.finished_bullets + 1
        local current_claw = (self.wave.claw_side < 1) and self.wave.left_claw or self.wave.right_claw
        current_claw:shake(0, 2)
        self:remove()
    end
end

function ClawDebris:draw()
    super.draw(self)
    if self.safe then Draw.setColor(0,1,1,1) else Draw.setColor(1, 0, 0, 1) end
    self:drawRotatedRectangle("line", 0, 0, self.width, self.height, self.rot)
    if self.safe then Draw.setColor(1,1,1,1) else Draw.setColor(0, 0, 0, 1) end
    self:drawRotatedRectangle("fill", 0, 0, self.width/2, self.height/2, self.rot)
    Draw.setColor(1,1,1,1)
end

return ClawDebris