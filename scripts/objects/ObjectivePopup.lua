---@class ObjectivePopup : Object
local ObjectivePopup, super = Class(Object)

function ObjectivePopup:init(x, y, width, height, text, display_time, sound)
    super.init(self, x, y, width, height)

    self.target_x = x + 60
    self.x = -550
    
    self.text = Text(text, 20, 0, nil, nil, {auto_size = true})
    self.bg = UIBox(0, 0, self.text.text_width + 20, self.text.text_height + 10)
    self.bg.layer = self.layer -1
    self:addChild(self.bg)
    self:addChild(self.text)
    
    self:slideTo(0, y, 1, "in-out-cubic", function () Game.stage.timer:after(display_time or 8, function () self:slideTo(-550, y, 1, "in-out-cubic", function () self:remove() end) end) end)
    Assets.playSound(sound or "cd_bagel/noelle", 0.9)
end

return ObjectivePopup