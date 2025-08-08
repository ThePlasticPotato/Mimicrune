return {
    wake_up = function (cutscene, event)
        local spawnWakeX, spawnWakeY = Game.world.map:getMarker("spawn")
        --story flags
        Game:setFlag("fredbear_get", false)
        Game:setFlag("frontdoor_unlocked", false)
        Game:setFlag("frontdoor_message", "* It's storming too hard to go outside right now...")
        Game:setFlag("frontdoor_expression", "neutral_side")
        Game:setFlag("afton_intro_done", false)

        Game.world.player.visible = true
        Game.world.player:setFacing("left")
        cutscene:wait(4)
        local tinysoul = SoulAppearance(480, 240, true, true)
        tinysoul.layer = WORLD_LAYERS["soul"]
        Game.world:addChild(tinysoul)
        cutscene:wait(10)
        tinysoul.should_bob = false
        local faded = false
        tinysoul:fadeTo(0.0, 0.8, function () faded = true end)
        cutscene:wait(function () return faded end)
        tinysoul:remove()
        cutscene:playSound("power")
        cutscene:wait(4)

        -- fling out section
        Game.world:getEvent("aftonhouse/blanket"):setState("messy")
        Game.world.player:setAnimation("splat")
        cutscene:playSound("awkward")
        cutscene:wait(cutscene:slideTo("evan", "floor_splat", 0.15, "linear"))
        Game.world.player:setAnimation("splat")
        cutscene:playSound("impact")
        cutscene:wait(cutscene:slideTo("evan", Game.world.player.x - 30, Game.world.player.y, 0.5, "out-cubic"))
        cutscene:wait(5)
        Game.world.player:shake()
        cutscene:playSound("bump")
        cutscene:wait(4)
        Game.world.player:shake(0.5, 0.5)
        Game.world.player:setAnimation("lift")
        cutscene:playSound("bump")
        cutscene:wait(2)
        Game.world.player:shake(0.5, 0.5)
        cutscene:playSound("bump")
        cutscene:wait(2)
        Game.world.player:shake(0.5, 0.5)
        cutscene:playSound("bump")
        Game.world.player:setAnimation("sat")
        cutscene:playSound("noise")
        cutscene:wait(2)
        cutscene:setSpeaker(Game.world.player.actor)
        cutscene:text("* Ow... my head...", "dazed", nil, { ["talk"] = false, ["wait"] = true})
        cutscene:wait(2)
        cutscene:playSound("bump")
        Game.world.player:setFacing("down")
        Game.world.player:resetSprite()
        cutscene:wait(1)
        cutscene:text("* (Something feels... different...)", "shadow_frown", nil, { ["talk"] = false, ["wait"] = true})
        cutscene:text("* [speed:0.25](...)", "shadow_blank", nil, { ["talk"] = false, ["wait"] = true, ["skip"] = false})
        local soulpulse = SoulPulse(Game.world.player.x + 1, Game.world.player.y - 35)
        soulpulse.layer = WORLD_LAYERS["top"]
        Game.world:addChild(soulpulse)
        cutscene:wait(2)
        soulpulse:fadeOutAndRemove(0.8)
        cutscene:wait(2)
        cutscene:text("* (...it's warm.)", "happy", nil, { ["talk"] = false, ["wait"] = true })

        Game.stage:pushObjective("Get breakfast.", 8, true)

        cutscene:endCutscene()
    end,

    afton_intro = function (cutscene, event)
        Game:setFlag("afton_intro_done", true)
    end
}