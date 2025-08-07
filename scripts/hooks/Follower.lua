---@class Follower
---@field was_running boolean
local Follower, super = Utils.hookScript(Follower)

function Follower:init(chara, x, y, target)
    super.init(self, chara, x, y, target)
    self.was_running = false
end

function Follower:update()
    super.update(self)
    if (self.target.was_running and not self.was_running) then
        self.was_running = true
        self:resetSprite()
    elseif (self.target.was_running == false and self.was_running) then
        self.was_running = false
        self:resetSprite()
    end
end

function Follower:onFootstep(num)
    super.onFootstep(self, num)
    if (Game:getFlag("audible_footsteps", false) and Game.world and Game.world.map) then
        local randpitch = Utils.random(-0.15, 0.15)
        Assets.playSound(Game.world:getStepSound(self.x, self.y, num, self.actor), 0.85, 1 + randpitch)
    end
end

return Follower