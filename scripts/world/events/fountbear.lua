--- @class Fountbear : Event
local Fountbear, super = Class(Event)

function Fountbear:init(data)
    super.init(self, data)
    self:setSprite("props/fountbear")
    self:setOrigin(0.5, 0.5)
end

function Fountbear:onInteract(player, dir)
    
    Game.world:showText("* It's a fountain with a statue in the shape of Fredbear.\n* A Fountbear, if you will.")
    return super.onInteract(self, player, dir)
end

return Fountbear