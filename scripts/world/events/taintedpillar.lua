---@class TaintedPillar : Event
local TaintedPillar, super = Class(Event)

function TaintedPillar:init(data)
    super.init(self, data)
    self.pillar_sprite = Assets.getTexture("world/nowhere/twistedpillar")
    self.width = self.pillar_sprite:getWidth()
    self.height = self.pillar_sprite:getHeight()
    self:setOrigin(0.5, 1)
    self.vein_sprite = Assets.getTexture("world/nowhere/twistedpillar_veins")
    self.fumes = {}
    self.streaks = {}
    self.vein_alpha = 1
    self.vein_siner = 0

    self.spawn_timer = 0
    self.streak_timer = 0
    self.shrink = true
    self.timer = 0
end

function TaintedPillar:update()
    super.update(self)
    self.timer = self.timer + DTMULT
    self.spawn_timer = self.spawn_timer - DTMULT
    self.streak_timer = self.streak_timer - DTMULT
    self.vein_siner = self.vein_siner + DTMULT / 8
    self.vein_alpha = math.sin(self.vein_siner) + 1.25

    if self.spawn_timer < 0 then
        self.spawn_timer = self.spawn_timer + MathUtils.random(5, 30)
        local pos = MathUtils.random(32, self.width-32)
        table.insert(self.fumes, {pos, MathUtils.random(40, 50), MathUtils.random(20, 40), self.timer, MathUtils.random(-1, 1), MathUtils.randomInt(-1, 1), 0, true, true})
    end
    if (self.streak_timer < 0) then
        self.streak_timer = self.streak_timer + MathUtils.random(1, (30 / 4))
        local pos = MathUtils.random(4, self.width-4)
        table.insert(self.streaks, {pos, MathUtils.random(30, 40), MathUtils.random(20, 40), 0, self.timer})
    end

    local to_remove = {}
    local to_remove_streaks = {}
    for index, fume in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        if x < -(radius + 30) or radius < 0 then table.insert(to_remove, fume) end
    end

    for index,streak in ipairs(self.streaks) do
        local x, y, width = self:getStreakInformation(index)
        if x < -(width + 30) then table.insert(to_remove_streaks, streak) end
    end

    for _, fume in ipairs(to_remove) do
        TableUtils.removeValue(self.fumes, fume)
    end
    for _, streak in ipairs(to_remove_streaks) do
        TableUtils.removeValue(self.streaks, streak)
    end
end

function TaintedPillar:getFumeInformation(index)
    local x, y, radius, time, rotation, rotdir, acceleration, shrink, tail = TableUtils.unpack(self.fumes[index])
    time = self.timer - time
    if (rotdir == 0) then rotdir = 1 end
    if (shrink) then 
        acceleration = acceleration + (time / 8)
        y = y - time * (4.9 + acceleration)
        x = x + math.sin(time / 4) * 8
    else
        x = x + math.sin(time/4) * 8
    end
    rotation = rotation + ((time / 4) * rotdir)
    if (self.shrink and shrink) then radius = radius - time * 0.25 end
    return x, y, radius, time, rotation, tail
end

function TaintedPillar:getStreakInformation(index)
    local x, y, width, speed, time = TableUtils.unpack(self.streaks[index])

    time = self.timer - time
    speed = speed + (time / 4)
    y = y - time * (12 + speed)
    width = width + (time)
    return x, y, width, speed, time
end

function TaintedPillar:drawRotatedRectangle(mode, x, y, width, height, angle)
	-- We cannot rotate the rectangle directly, but we
	-- can move and rotate the coordinate system.
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
    love.graphics.setLineWidth(2)
	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end

function TaintedPillar:draw()
    local iterated = {}
    
    Draw.setColor(0.2, 0, 0, 1)
    love.graphics.setLineWidth(2)

    for index, _ in ipairs(self.streaks) do
        local x, y, width = self:getStreakInformation(index)
        love.graphics.line(x, y-width*2, x, y)
    end

    Draw.setColor(1,0,0,1)
    for index, _ in ipairs(self.fumes) do
        local x, y, radius, time, rotation, tail = self:getFumeInformation(index)
        --tails
        table.insert(iterated, {x, y, radius, time, rotation})
        if (tail) then
            self:drawRotatedRectangle("line", x-(math.sin(time / 4) * 8), y+(1.5 * radius), radius/4, radius/4, rotation)
            self:drawRotatedRectangle("line", x-(math.sin(time / 4) * 2), y+(1 * radius), radius/2, radius/2, rotation)
        end
        self:drawRotatedRectangle("line", x, y, radius, radius, rotation)
    end
    Draw.setColor(0,0,0,1)
    for index, value in ipairs(iterated) do
        local x, y, radius, time, rotation, tail = TableUtils.unpack(value)
        if (tail) then
            self:drawRotatedRectangle("fill", x+(1.5 * radius), y-(math.sin(time / 4) * 8), (radius/4)-2, (radius/4)-2, rotation)
            self:drawRotatedRectangle("fill", x+(1 * radius), y-(math.sin(time / 4) * 2), (radius/2)-2, (radius/2)-2, rotation)
        end
        self:drawRotatedRectangle("fill", x, y, radius-2, radius-2, rotation)
    end
    Draw.setColor(1,1,1,1)
    super.draw(self)
    Draw.draw(self.pillar_sprite, 0, 0, 0, 1, 1)
    Draw.setColor(1, 1, 1, self.vein_alpha)
    Draw.draw(self.vein_sprite, 0, 0, 0, 1, 1)
    Draw.setColor(1,1,1,1)
end

return TaintedPillar