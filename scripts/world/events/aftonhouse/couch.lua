local Couch, super = Class(Event)

function Couch:init(data)
    super.init(self, data)
    self:setSprite("props/aftonhouse/aftonhouse_upstairs_couch")
end

return Couch