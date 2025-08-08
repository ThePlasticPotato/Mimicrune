---@class Player
local Player, super = Utils.hookScript(Player)

function Player:getStepVolume()
    return math.min(Footsteps:getConfig("step_volume") * (self.walk_speed / 4), Footsteps:getConfig("step_volume_max"))
end

function Player:onFootstep(num)
    super.onFootstep(self, num)
    if (Game:getFlag("audible_footsteps", false) and Game.world and Game.world.map) then
        local randpitch = Utils.random(-0.15, 0.15)
        Assets.playSound(Game.world:getStepSound(self.x, self.y, num, self.actor), self:getStepVolume(), 1 + randpitch)
    end
end

return Player