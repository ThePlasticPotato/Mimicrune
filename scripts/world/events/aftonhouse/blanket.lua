local Blanket, super = Class(Event)

function Blanket:init(data)
    super.init(self, data.x, data.y, 46, 52, data)
    self.layer = WORLD_LAYERS["above_soul"]
    self.interact_text = data.properties["text"]
    self.sprite_location = "props/aftonhouse/evanroom_blanket_"

    self.state = Game:getFlag("bed_made", "full") or data.properties["state"]
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
        Game.world:showText(self.interact_text)
        return true
    end
    return false
end

function Blanket:onSoulInteract(soul)
    if (not Game:getFlag("intro_evan_interacted", false)) then
        Game:setFlag("intro_evan_interacted", true)
        soul.is_active = false
        soul:slideTo(self.x + 46, self.y + (52/2), 0.6, "in-out-cubic")
    end
end

return Blanket