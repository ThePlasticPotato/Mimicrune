---@class PartyBattler
---@field next_attack_bonus number
---@field overheat boolean
local PartyBattler, super = Utils.hookScript(PartyBattler)

function PartyBattler:init(chara, x, y)
    super.init(self, chara, x, y)
    self.next_attack_bonus = 0
    self.overheat = false
    self.was_hit_last = true
    self.sing_level = 0
    self.singing = false

    if (self.chara.is_musical) then
        self.note_sprites = {
            NoteSprite("effects/note", 8, 16, nil, nil, nil, 1, self),
            NoteSprite("effects/note", 8, 16, nil, nil, nil, 2, self),
            NoteSprite("effects/note", 8, 16, nil, nil, nil, 3, self)
        }

        --self.note_sprites[1].visible = false
        --self.note_sprites[2].visible = false
        --self.note_sprites[3].visible = false

        self.note_sprites[1]:setLayer(self.sprite:getLayer())
        self.note_sprites[2]:setLayer(self.sprite:getLayer())
        self.note_sprites[3]:setLayer(self.sprite:getLayer())
        self:addChild(self.note_sprites[1])
        self:addChild(self.note_sprites[2])
        self:addChild(self.note_sprites[3])
    end
end

function PartyBattler:update()
    super.update(self)
    if (self.sing_level > 0 and not self.singing) then
        self:setAnimation("battle/sing_power_"..tostring(self.sing_level))
        self.singing = true
    end
    if (self.sing_level == 0 and self.singing) then
        self:setAnimation("battle/idle")
        Game.battle.music_additional:fade(0.0, nil, function () Game.battle.music_additional:stop() end)
        self.singing = false
    end
end

--- Whether the party member is in a state where they can take their turn (not sleeping or downed)
---@return boolean
function PartyBattler:isActive()
    return super.isActive(self) and not self.overheat
end

function PartyBattler:hurt(amount, exact, color, options)
    super.hurt(self, amount, exact, color, options)
    if (amount > 0) then
        self.was_hit_last = true
    end
end

function PartyBattler:setOverheat(overheat)
    self.overheat = overheat
end

function PartyBattler:buffNextAttack(amount, mult)
    if (mult) then
        self.next_attack_bonus = math.max(self.next_attack_bonus, 1) * amount
    else
        self.next_attack_bonus = self.next_attack_bonus + amount
    end
end

return PartyBattler