---@class Character : Object
local Character, super = Utils.hookScript(Character)

function Character:getStepVolume()
    return math.min(Footsteps:getConfig("step_volume") * (1), Footsteps:getConfig("step_volume_max"))
end

function Character:onFootstep(num)
    super.onFootstep(self, num)
    if (Game:getFlag("audible_footsteps", false) and Game.world and Game.world.map) then
        local randpitch = Utils.random(-0.15, 0.15)
        Assets.playSound(Game.world:getStepSound(self.x, self.y, num, self.actor), self:getStepVolume(), 1 + randpitch)
    end
end

return Character