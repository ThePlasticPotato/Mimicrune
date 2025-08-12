---@class Chair : Sittable
---@field facing string
---@field occupied boolean
---@field occupying_chara Character
local Chair, super = Class(Sittable)

function Chair:init(data)
    super.init(self, data)
    self.solid = true
    self:setSprite("props/aftonhouse/dining_chair_"..self.facing)
    self.interact_buffer = 2
end

---@param chara Character
function Chair:sit(chara)
    self.occupied = true
    self.occupying_chara = chara
    self.dismount_pos = {chara.x - self.x, chara.y - self.y}
    self.original_layer = chara.layer
    self.currently_targeted = false
end

---@param chara Character
function Chair:unsit(chara)
    if (self.occupying_chara == chara) then
        self.occupied = false
        self.occupying_chara = nil
        self.original_layer = 0
    end
end

---@param player Player
---@param dir string
function Chair:onInteract(player, dir)
    super.onInteract(self, player ,dir)
    local sat = self:trySitting(player, dir, true)

    if (sat and Game.world.followers) then
        for index, value in ipairs(Game.world.followers) do
            if (player.sitting ~= value.sitting) then value:attemptSit(self, dir) end
        end
    end

    if (sat and Game:getFlag("intro:aftonhouse_sat_down", false)) then
        Game:setFlag("intro:aftonhouse_sat_down", true)
        --todo: start cutscene here once I make it
    end
end

---@param chara Character
---@param dir string
---@param play_sound boolean
function Chair:trySitting(chara, dir, play_sound)
    if (not self.occupied) then
        self:sit(chara)
        local offset = self.facing == "up" and -0.1 or 0.1
        chara:setFacing(self.facing)
        if (self.should_set_layer) then chara:setLayer(self.layer + offset) end
        chara:jumpTo(self.x + self.sit_offset[1], self.y + self.sit_offset[2], 2, 0.15, nil, "sit")
        Game.world.timer:after(0.35, function () chara:setAnimation("sit") end)
        if play_sound then Assets.playSound("jump", 0.5) end
        chara.sitting = true
        chara.seat = self
    elseif (self.occupied and self.occupying_chara == chara) then
        local original = self.original_layer
        local new_direction_angle = Utils.angle(self.x, self.y, self.x + self.dismount_pos[1], self.y + self.dismount_pos[2])
        local new_direction = Utils.facingFromAngle(new_direction_angle)
        self:unsit(chara)
        if play_sound then Assets.playSound("jump", 0.5, 0.75) end
        chara:setFacing(new_direction)
        chara:resetSprite()
        chara:jumpTo(self.x + self.dismount_pos[1], self.y + self.dismount_pos[2], 2, 0.25)
        chara:setLayer(original)
        chara.sitting = false
        chara.seat = nil
    else 
        return false
    end
    return true
end

return Chair