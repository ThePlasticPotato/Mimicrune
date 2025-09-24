---@param cutscene WorldCutscene
return function(cutscene)
    if true then --(not Game.world:hasTalkCutscene()) then
        local randselect = Utils.random(0, 3, 1)
        
        if (randselect == 0) then
            cutscene:text("* But no one had anything to say.")
        elseif (randselect == 1) then
            local randparty = Utils.random(1, #Game.party, 1)
            if (Game.party[randparty]) then
                local character = Game.world:getPartyCharacterInParty(Game.party[randparty])
                if (character) then
                    cutscene:setSpeaker(character)
                    cutscene:text("* .[wait:5] .[wait:10] .[wait:15]", "neutral")
                    return
                end
            end
            cutscene:text("* Silence.")
        elseif (randselect == 2) then
            local randparty = Utils.random(1, #Game.party, 1)
            if (Game.party[randparty]) then
                local character = Game.world:getPartyCharacterInParty(Game.party[randparty])
                if (character) then
                    cutscene:setSpeaker(character)
                    cutscene:text("* .[wait:5] .[wait:10] .[wait:15]", "neutral_side")
                    return
                end
            end
            cutscene:text("* Crickets...")
        elseif (randselect == 3) then
            cutscene:text("* Your voice echoes out uselessly.")
        end
    end
end

