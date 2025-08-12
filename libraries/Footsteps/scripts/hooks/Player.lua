---@class Player
local Player, super = Utils.hookScript(Player)

function Player:getStepVolume()
    return math.min(Footsteps:getConfig("step_volume") * (self.walk_speed / 4), Footsteps:getConfig("step_volume_max"))
end

return Player