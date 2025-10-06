---@class NoteSprite : Sprite
local NoteSprite, super = Class(Sprite)

function NoteSprite:init(texture, x, y, width, height, path, index, battler)
    local real_texture = texture.."_"..tostring(index)
    super.init(self, real_texture, x, y, width, height, path)
    self.index = index
    self.battler = battler
    self.progress = { 0, 0 }
    self.offset_x = -15
    self.offset_y = 0
    if (index == 2) then
        self.progress = { 2/3 * math.pi, 2/3 * math.pi }
        self.offset_x = (2/3 * 30) - 15
    elseif (index == 3) then
        self.progress = { 4/3 * math.pi, 4/3 * math.pi }
        self.offset_x = (4/3 * 30) - 15
    end
    
    self:setOrigin(0.5, 0.5)

    self.afterimg_timer = 0
end

function NoteSprite:update()
    super.update(self)
    self.progress[1] = self.progress[1] + (DT * 2)
    self.progress[2] = self.progress[2] + DT
    self.afterimg_timer = self.afterimg_timer - DT
    
    --self:move(self.battler.x, self.battler.y, DT * 2)

    self.visible = self.battler.chara.notes >= self.index
    local progress = self.progress[1]
    local y_progress = self.progress[2]
    local position_offset = math.sin(progress)
    local y_offset = math.cos(y_progress) / 4
    local layer = self.battler.sprite.layer
    if (position_offset > 0) then layer = layer + 10 else layer = layer -10 end
    self:setLayer(layer)
    self.offset_x = self.offset_x + (position_offset * 2)
    self.offset_y = self.offset_y + y_offset
    self:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))

    if (self.afterimg_timer <= 0) then
        local afterimage = AfterImage(self, 0.5)
        --afterimage:setScale(MathUtils.clamp(1 + (position_offset / 4), 0.5, 1.5))
        self:addChild(afterimage)
        self.afterimg_timer = 0.15
    end
end

function NoteSprite:draw()
    super.super.draw(self)
    local r,g,b,a = self:getDrawColor()
    if self.crossfade_alpha > 0 and self.crossfade_texture ~= nil then
        Draw.setColor(r, g, b, self.crossfade_out and MathUtils.lerp(a, 0, self.crossfade_alpha) or a)
        Draw.draw(self.texture, self.x + self.offset_x, self.y + self.offset_y)

        Draw.setColor(r, g, b, MathUtils.lerp(0, a, self.crossfade_alpha))
        Draw.draw(self.crossfade_texture, self.x + self.offset_x, self.y + self.offset_y)
    else
        Draw.setColor(r, g, b, a)
        Draw.draw(self.texture, self.offset_x, self.offset_y + 8)
    end
end

return NoteSprite