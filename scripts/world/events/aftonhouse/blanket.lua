local Blanket, super = Class(Event)

function Blanket:init(data)
    super.init(self, data.x, data.y, 46, 52, data)
    self.layer = WORLD_LAYERS["above_soul"]
    self.interact_text = data.text
    self.sprite_location = "props/aftonhouse/evanroom_blanket_"

    self.state = Game:getFlag("bed_made", "full") or data.state
    self:setSprite(self.sprite_location..self.state)
end

function Blanket:setState(state)
    self.state = state or "empty"
    Game:setFlag("bed_made", self.state)
    self:setSprite(self.sprite_location..self.state)
end

function Blanket:onInteract(player, dir)
    super.onInteract(self, player, dir)
    if (self.state == "messy" and not Game.world:hasCutscene()) then
        self:setState("empty")
        Assets.playSound("noise")
        return true
    end
    if (self.state == "empty" and not Game.world:hasCutscene()) then
        Game.world:showText("* But it was already made.")
        return true
    end
    return false
end

return Blanket