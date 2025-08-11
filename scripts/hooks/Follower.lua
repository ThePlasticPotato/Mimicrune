---@class Follower
---@field was_running boolean
---@field pathing boolean
local Follower, super = Utils.hookScript(Follower)

function Follower:init(chara, x, y, target)
    super.init(self, chara, x, y, target)
    self.was_running = false
    self.pathing = false
    self.should_sit = false
end

function Follower:update()
    super.update(self)
    if (self.target and self.target.was_running and not self.was_running) then
        self.was_running = true
        self:resetSprite()
    elseif (self.target and self.target.was_running == false and self.was_running) then
        self.was_running = false
        self:resetSprite()
    end
    if (self.target and self.target.was_running == false and self.sitting and self.sprite.current_default == "run") then
        self.was_running = false
        self:resetSprite()
    end
    self.should_sit = Game.world.player.sitting
end

function Follower:pathfindTo(x, y, options)
    self.following = false
    self.returning = false
    self.pathing = true
    local current_node = Game.world:getNearestNode(self.x, self.y)
    local target_node = Game.world:getNearestValidNode(x, y)
    local path = Game.world:findPathTo(current_node[1], current_node[2], target_node[1], target_node[2], self.collider)
    if (#path == 0) then
        self.following = true
        return false
    end
    self:walkPath(path, { speed = options and options.speed or 6, loop = false, relative = false, after = function () 
        if (options and options.refollow) then self:returnToFollowing(options.speed) end
        self.pathing = false
        if (options and options.after) then options.after() end
        end }
    )
    return true
end

return Follower