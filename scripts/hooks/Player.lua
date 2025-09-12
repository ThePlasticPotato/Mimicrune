---@class Player
---@field was_running boolean
local Player, super = Utils.hookScript(Player)

function Player:init(chara, x, y)
    super.init(self, chara, x, y)
    self.was_running = false
    self.should_sit = true
end

function Player:handleMovement()
    super.handleMovement(self)
end

return Player