---@class Text
local Text, super = Utils.hookScript(Text)

function Text:init(text, x, y, w, h, options)
    self.COLORS["time"] = { 184 / 255, 241 / 255, 238 / 255 }
    self.COLORS["sanctuary"] = { 57 / 255, 185 / 255, 185 / 255 }
    super.init(self, text, x, y, w, h, options)
end

return Text