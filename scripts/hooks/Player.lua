---@class Player
---@field was_running boolean
local Player, super = Utils.hookScript(Player)

function Player:init(chara, x, y)
    super.init(self, chara, x, y)
    self.was_running = false
end

function Player:handleMovement()
    super.handleMovement(self)
    if (not self.was_running and self.run_timer > 60) then
        self.was_running = true
        self:resetSprite()
    elseif ((self.was_running) and self.run_timer <= 60) then
        self.was_running = false
        self:resetSprite()
    end
    if (self.moving_x == 0 and self.moving_y == 0 and not self.force_run and self.sprite.current_default == "run") then
        self.was_running = false
        self:resetSprite()
    end
end

return Player