---@class HealthBar
local HealthBar, super = Utils.hookScript(HealthBar)

function HealthBar:init()
    super.init(self)
    self.sprite = Assets.getTexture("ui/menu/panels/dark/main/bottom")
end

function HealthBar:draw()
    -- Draw the black background
    Draw.draw(self.sprite, 0, -16)

    super.super.draw(self)
end

return HealthBar