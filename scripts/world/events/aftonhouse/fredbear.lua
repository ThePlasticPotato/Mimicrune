local FredbearPlushie, super = Class(Event)

function FredbearPlushie:init(data)
    super.init(self, data.x, data.y - 30, 16, 21, data)
    self:setSprite("party/fredbear/light")
    if (Game:getFlag("fredbear_get", false)) then
        self.visible = false
    end
end

function FredbearPlushie:onInteract(player, dir)
    super.onInteract(self, player, dir)
    if (Game:getFlag("fredbear_get", false)) then
        self:remove()
        return true
    end
    Game:setFlag("fredbear_get", true)
    Assets.playSound("noise")
    self.visible = false
    Game.world:startCutscene(function(cutscene)
        cutscene:setSpeaker("evan")
        cutscene:text("* Fredbear![wait:10][react:1]", "laugh", {reactions = { {"(How did you get over here???)", 200, 58, "awkward_left_sweat", "evan"}, }})
    end)
    Game.inventory:tryGiveItem("fredbear_plush")
    self:remove()
end


return FredbearPlushie