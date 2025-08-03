local EvanDoor, super = Class(Door)

function EvanDoor:onInteract(player, dir)
    local fredbearGotten = Game:getFlag("fredbear_get", false)
    if (fredbearGotten) then
        return super.onInteract(self, player, dir)
    else
        Game.world:startCutscene(function(cutscene)
        cutscene:setSpeaker("evan")
        cutscene:text("* ...I can't leave without\nFredbear...", "neutral_side")
        end)
    end
    return true
end

return EvanDoor