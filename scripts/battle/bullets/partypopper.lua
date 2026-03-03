local PartyPopper, super = Class(Bullet)

function PartyPopper:init(x, y)
    -- Last argument = sprite path
    local suffix = (Game.battle.tense) and "_twisted" or ""
    super.init(self, x, y, "bullets/partypopper" .. suffix .. "_capless")
    self.top_sprite = Sprite("bullets/partypopper" .. suffix .. "_cap")
    self:addChild(self.top_sprite)
    self.radius = 0
    self.expansion_rate = 1.1
    Assets.playSound("drumrollin")
end

function PartyPopper:popper()
    self:setLayer(BATTLE_LAYERS["top"])
    Assets.playSound("confetticannon")
    self.sprite:flash(nil, nil, BATTLE_LAYERS["top"] + 1)
    self.top_sprite.physics.gravity = 1
    --self.top_sprite.physics.direction = 1.25 * math.pi
    self.top_sprite.physics.speed_x = -8
    self.top_sprite.physics.speed_y = -8
    self.popped = true
    if (Game.battle.tense) then
        self.wave.timer:after(3, function()
            Assets.playSound("icky")
            for i = 0, MathUtils.randomInt(1, 4) do
                local segments = MathUtils.randomInt(2, 5)
                local dir_offset = MathUtils.random(-0.12 * math.pi, 0.12 * math.pi)
                self.wave:spawnWorm(self.x + self.width / 2, self.y + self.height / 2, (1.5 * math.pi) + dir_offset, segments, Game.battle.soul)
            end
        end)
        return
    end
end

function PartyPopper:update()
    if (self.popped) then
        self.expansion_rate = self.expansion_rate - DT
        self.radius = self.radius + self.expansion_rate * DTMULT
    end

    super.update(self)
end

function PartyPopper:draw()
    
    Draw.setColor(1, 1, 1, math.min(self.expansion_rate, 1))
    love.graphics.ellipse("fill", 0, 0, self.radius, self.radius)
    Draw.setColor(1,1,1,1)
    super.draw(self)
end

return PartyPopper