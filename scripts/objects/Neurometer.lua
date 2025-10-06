local Neurometer, super = Class(Object)

---@param battler PartyBattler
function Neurometer:init(x, y, width, height, battler)
    super.init(self, x, y, width, height)
    self.base_y = y
    self.power_meter = Sprite("ui/battle/neural_power", -8)
    self.power_meter:setOrigin(0.5, 1)
    self.heat_meter = Sprite("ui/battle/neural_heat", 8)
    self.heat_meter:setOrigin(0.5, 1)
    self.steam_left = Sprite("ui/battle/steam/neural_steam_left", -12, -16)
    self.steam_right = Sprite("ui/battle/steam/neural_steam_right", 12, -32)

    self.steam_left.visible = false
    self.steam_right.visible = false
    self:addChild(self.power_meter)
    self:addChild(self.heat_meter)
    self:addChild(self.steam_left)
    self:addChild(self.steam_right)
    self.steam_left:play(nil, true, nil)
    self.steam_right:play(nil, true, nil)

    self.battler = battler

    self.display_heat = 0
    self.display_power = 0

    self.potential_heat = nil
    self.potential_power = nil

    self.target_y = 200 + self.base_y
    self.target_opacity = 0
    self.raising = false
    self.visible = true
    self.alpha = 0
    self.neurashine = 0
    self.shine_timer = 0

    self.shake_offset = 0
    self.shake_timer = 0
end

---@param chara PartyMember
function Neurometer:inDangerThreshold()
    return (self.display_heat * 100) > 75
end

function Neurometer:calcPercentileValues()
    local heat = self.battler.chara.heat
    local max_heat = self.battler.chara:getStat("heat", 50)

    local np = self.battler.chara.neural_power
    local max_np = 100

    return {np / max_np, heat / max_heat}
end

function Neurometer:update()
    super.update(self)
    self.shine_timer = self.shine_timer + (DT * 4)
    if (Game.battle and Game.battle.current_selecting == Game:getPartyIndex(self.battler.chara.id)) then
        self.target_y = -32 + self.base_y
        self.raising = true
        self.target_opacity = 1
    else
        self.target_y = 32 + self.base_y
        self.target_opacity = 0
        self.raising = false
    end
    local targets = self:calcPercentileValues()

    self.alpha = MathUtils.approach(self.alpha, self.target_opacity, DT * 4)
    self.steam_right.alpha = self.alpha
    self.steam_left.alpha = self.alpha
    self.heat_meter.alpha = self.alpha
    self.power_meter.alpha = self.alpha
    self.display_power = MathUtils.approach(self.display_power, targets[1], DT)
    self.display_heat = MathUtils.approach(self.display_heat, targets[2], DT)
    local speed = 10
    if (not self.raising) then
        speed = 20
    end
    self.y = MathUtils.approach(self.y, self.target_y, DTMULT * speed)

    local danger = self:inDangerThreshold()
    self.steam_left.visible = danger
    self.steam_right.visible = danger
    self.shake_timer = self.shake_timer + (DTMULT * (8 * (self.display_heat * 10)))
    if (danger) then
        self.shake_offset = math.sin(self.shake_timer)
    else
        self.shake_offset = MathUtils.approach(self.shake_offset, 0, DT)
    end
    self.steam_left.anim_speed = 0.7 * self.display_heat
    self.steam_right.anim_speed = 0.5 * self.display_heat
    self.heat_meter.x = 8 + (self.shake_offset / 2)
    self.neurashine = self.neurashine + (math.sin(self.shine_timer) / 30)
end

function Neurometer:draw()
    super.draw(self)
    Draw.setColor(self.neurashine, 1, 1, 0.8 * self.alpha)
    Draw.rectangle("fill", -12, -29 * self.display_power, 8, 29 * self.display_power)
    Draw.setColor(1, 0, 0, 0.8 * self.alpha)
    Draw.rectangle("fill", 5 + (self.shake_offset / 2), -21 * self.display_heat, 6, 21 * self.display_heat)
    if (self.potential_power) then
        Draw.setColor(0, 0, 1, 0.5 * self.alpha)
        Draw.rectangle("fill", -12, -29 * self.display_power, 8, ((29 * self.display_power) * (1 - self.potential_power)))
    end
    if (self.potential_heat) then
        Draw.setColor(0.5, 0, 0, 0.5 * self.alpha)
        Draw.rectangle("fill", 5 + (self.shake_offset / 2), -21 * self.potential_heat, 6, 21 * self.potential_heat)
    end
    Draw.setColor(1, 1, 1, 1)
end

return Neurometer