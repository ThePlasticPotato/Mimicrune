---@class Sittable : Event
---@field occupied boolean
---@field occupying_chara Character
---@field facing string
---@field sit_offset table<number>
---@field original_layer number
---@field dismount_pos table<number>
local Sittable, super = Class(Event)

function Sittable:init(data)
    local properties = data.properties or {}
    self.facing = properties["facing"] or "down"
    super.init(self, data)
    self:setOrigin(0.5, 0.5)
    local default_y_offset = (self.facing == "down") and -32 or -16
    self.sit_offset = { properties["sit_x"] or (self.width / 2), properties["sit_y"] or ((self.height / 2) - default_y_offset)}
    self.occupied = false
    self.occupying_chara = nil
    self.original_layer = 0
    self.should_set_layer = properties["update_layer"] or false
    
    self.dismount_pos = { 0, 0 }

    self.solid = true
    self.interact_buffer = 2
end

function Sittable:trySitting(chara, dir, play_sound)
end

return Sittable