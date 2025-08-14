local FrontDoor, super = Class(Door)

function FrontDoor:onInteract(player, dir)
    local storyFlag = Game:getFlag("frontdoor_unlocked", false)
    local storyReason = Game:getFlag("frontdoor_message", "* It's locked.")
    local storyExpression = Game:getFlag("frontdoor_expression", "neutral")
    if (Game:getFlag("plot", 0) == 4) then
        -- cassidy entrance cutscene
        return true
    end
    if (storyFlag) then
        -- todo: also play deeper sound
        return super.onInteract(self, player, dir)
    else
        Game.world:startCutscene(function(cutscene)
        cutscene:setSpeaker("evan")
        cutscene:text(storyReason, storyExpression)
        end)
    end
    return true
end

return FrontDoor