---@class World : Object
---@field limited_interaction boolean
local World, super = Utils.hookScript(World)

function World:init(map)
    super.init(self, map)
    self.limited_interaction = false
end

---@param key string
function World:onKeyPressed(key)
    super.onKeyPressed(self, key)
    if self.state == "GAMEPLAY" then
        if Input.isConfirm(key) and self.player and (self:hasCutscene() and self.limited_interaction) then
            if self.player:interact() then
                Input.clear("confirm")
            end
        end
    end
end

return World