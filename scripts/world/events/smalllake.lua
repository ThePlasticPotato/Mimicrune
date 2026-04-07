--- @class SmallLake : Event
local SmallLake, super = Class(Event)

function SmallLake:init(data)
    super.init(self, data)
    self:setSprite("props/lake")
    self:setOrigin(0.5, 0.5)

    -- self:addFX(ShaderFX('water', {
    --     size = {SCREEN_WIDTH, SCREEN_HEIGHT},
    --     factor = 2
    -- }))
end

return SmallLake