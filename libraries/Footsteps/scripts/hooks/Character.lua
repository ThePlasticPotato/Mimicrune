---@class Character : Object
local Character, super = HookSystem.hookScript(Character)

function Character:getStepVolume()
    return math.min(Footsteps:getConfig("step_volume") * (1), Footsteps:getConfig("step_volume_max"))
end

function Character:onFootstep(num)
    super.onFootstep(self, num)
    if (Game:getFlag("audible_footsteps", false) and Game.world and Game.world.map) then
        local randpitch = MathUtils.random(-0.15, 0.15)
        num = MathUtils.wrap(num, 1, 3)
        local sound, pitch = Game.world:getStepSound(self.x, self.y, num, self.actor)
        Assets.stopAndPlaySound(sound, self:getStepVolume(), pitch or (1 + randpitch))
    end
end

return Character