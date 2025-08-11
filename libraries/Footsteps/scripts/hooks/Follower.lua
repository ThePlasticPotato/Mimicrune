---@class Follower
local Follower, super = Utils.hookScript(Follower)

function Follower:getStepVolume()
    local walk_speed = self.target and self.target.walk_speed or 4
    if (Footsteps:getConfig("half_volume_followers")) then
        return math.min(Footsteps:getConfig("step_volume") * (walk_speed / 4), Footsteps:getConfig("step_volume_max")) / 2
    end
    return math.min(Footsteps:getConfig("step_volume") * (walk_speed / 4), Footsteps:getConfig("step_volume_max"))
end

function Follower:onFootstep(num)
    super.onFootstep(self, num)
    if (Game:getFlag("audible_footsteps", false) and Game.world and Game.world.map) then
        local randpitch = Utils.random(-0.15, 0.15)
        Assets.playSound(Game.world:getStepSound(self.x, self.y, num, self.actor), self:getStepVolume(), 1 + randpitch)
    end
end

return Follower