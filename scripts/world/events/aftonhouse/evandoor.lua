local EvanDoor, super = Class(Event)

function EvanDoor:init(data)
    super.init(self, data)
    self.lock = data.properties["lock"] or false
    self.lock_text = data.properties["lock_text"]
    self.target_map = data.properties["target_map"]
    self.target_marker = data.properties["target_marker"] or "entry"
    self.target_dir = data.properties["target_dir"] or "down"
end

function EvanDoor:onInteract(player, dir)
    local fredbearGotten = Game:getFlag("fredbear_get", false)
    if (fredbearGotten) then
        if (self.lock) then
            Assets.playSound("noise")
            Game.world:showText(self.lock_text or "* It's locked.")
            return true
        else
            Assets.playSound("dooropen")
            Game.world:mapTransition(self.target_map, self.target_marker, self.target_dir, function () Assets.playSound("doorclose") end)
        end
    else
        Game.world:startCutscene(function(cutscene)
        cutscene:setSpeaker("evan")
        cutscene:text("* ...I can't leave without\nFredbear...", "neutral_side")
        end)
    end
    return true
end

return EvanDoor