return {
    ---@param cutscene WorldCutscene
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
        local tinysoul = SoulAppearance(330, 280, true, true)
        tinysoul.layer = WORLD_LAYERS["soul"]
        Game.world:addChild(tinysoul)
        local worldsoul = WorldSoul(330, 280, {2/255, 1, 2/255, 1})
        worldsoul.layer = WORLD_LAYERS["soul"]
        worldsoul.visible = false
        worldsoul.is_active = false
        Game.world:addChild(worldsoul)
        cutscene:wait(function () return tinysoul.t >= tinysoul.m end)
        worldsoul.visible = true
        worldsoul.is_active = true
        Game.stage:pushObjective("FIND A SUITABLE VESSEL.", 4, true, "AUDIO_HIM", true)
        tinysoul:remove()
        cutscene:wait(function () return Game:getFlag("intro_evan_interacted", false) end)
        local faded = false
        worldsoul:fadeTo(0.0, 0.8, function () faded = true end)
        cutscene:wait(function () return faded end)
        worldsoul:remove()
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

        Game.stage:pushObjective("Get breakfast.", 5, true)

        cutscene:endCutscene()
    end,

    ---@param cutscene WorldCutscene
    afton_intro = function (cutscene, event)
        local afton = cutscene:getCharacter("william")
        afton:setFacing("up")
        -- scuffed but oh well
        local afton_original_layer = afton.layer
        afton:setLayer(1001)
        afton:setSprite("dark_turn/turn_1")
        local thunder = ThunderFlash()
        thunder:setLayer(WORLD_LAYERS["top"] + 1)
        Game.world:addChild(thunder)
        cutscene:playSound("thunder", 0.6)
        local darkness = DarknessOverlay(0)
        darkness:setLayer(WORLD_LAYERS["below_ui"])
        local darkness_alpha = 0
        local darkness_cleared = false
        Game.world.timer:doWhile(function () return darkness_alpha < 1 end, function ()
            darkness_alpha = darkness_alpha + (DT)
            darkness.alpha = darkness_alpha
         end)
        Game.world:addChild(darkness)
        cutscene:wait(0.5)
        local wave_timer = 0
        local light_radius = 0
        Game.world.timer:doWhile(function () return light_radius < 20 end, function ()
            light_radius = light_radius + (DT * 10)
         end, function () 
            Game.world.timer:doWhile(function () return not darkness_cleared end, function () 
            wave_timer = wave_timer + (DT / 2)
            local offset = math.sin(wave_timer)
            light_radius = light_radius + (offset /8)
         end)
         end)
        
        local light_source = LightSource(19/2, 38/2, function () return light_radius end)
        Game.world.player:addChild(light_source)
        cutscene:playSound("power_outage")

        cutscene:wait(4)

        Game.world.music:play("themes/william/man_behind_the_laughter", 1.0)
        Game.world.music:setLooping(false)
        
        cutscene:panTo(afton, 5, "in-out-cubic", function () afton:setAnimation("turnaround") end)

        cutscene:musicWait(15.9)
        cutscene:playSound("noise")
        darkness_cleared = true
        afton:resetSprite()
        afton:setFacing("down")
        afton:setWalkSprite("walk_pancakes")
        light_source:remove()
        darkness:remove()
        afton:setLayer(afton_original_layer)

        cutscene:setSpeaker("william")
        cutscene:text("* Whoops! Power cut... that storm really is something, huh?", "smug")
        cutscene:text("* [speed:0.25]. . .[wait:4][react:1]", "awkward_left_sweat", "evan_lw", { reactions = { {"(...I see that one didn't really land...)", 200, 58, "nervous", "william"}, }})
        cutscene:text("* 'Morning, son!", "grin")
        cutscene:text("* You're just in time [wait:2][react:1][wait:4][react:2][wait:20]", "smile", "william", { reactions = { {"For once.", "rightmid", "middle", "smile_side", "elizabeth"}, {"Elizabeth, don't antagonize your brother.", 200, "bottom", "annoyed_down", "william" } }, auto = true })
        cutscene:text("* For breakfast! Your old pop's famous flapjacks.[wait:3][react:1]", "smug", "william",  { reactions = { {"(yeah, THAT's what you're famous for-)", 200, 58, "smile", "elizabeth"}, }})

        local choice = cutscene:choicer({"Where's Mike?", "PURPLE GUY!?", "Ooh, pancakes!"}, {highlight = {COLORS.green, COLORS.purple, COLORS.yellow}})

        if (choice == 1) then
            cutscene:text("* Probably sleeping like a [wave:1]rock[wave:0].[wait:4] You two are alike in that.", "unamused", "elizabeth")
            cutscene:wait(4)
            cutscene:text("* Anyways...[wait:4][face:grin] pancakes!", "squint_left")
        elseif(choice == 2) then
            cutscene:text("* [speed:0.1]. . .[wait:4]", "confused", "william", { auto = true })
            cutscene:text("* Oh-! You're referring to-", "neutral_side", "william", { auto = true })
            cutscene:text("* -the winner of the [color:purple]Friend Inside Weekly[color:reset] cover contest!", "smile")
            cutscene:panTo("purpleguy_pan", 1, "in-out-cubic", function () cutscene:text("* I was surprised too. Not exactly cover material, that one...", "neutral_side") end)
            cutscene:wait(1)
            cutscene:panTo(afton, 1, "in-out-cubic")
            cutscene:wait(4)
            cutscene:text("* Anyways... [face:smug]pancakes!", "smile")
        else
            cutscene:text("* [wave:1]Pancakes![wave:0]", "happy", "evan_lw")
            cutscene:text("* Nothing better on a dark morning.", "grin")
        end
        cutscene:text("* Have a seat with your sister-[wait:2] I'll bring them to the table.", "smile")
        cutscene:panTo(Game.world.player, 1, "in-out-cubic", function ()
            cutscene:enableMovement()
            Game.world:setCameraAttached(true)
        end)
        cutscene:wait(function () return Game:getFlag("aftonhouse_sat_down", false) end)
        cutscene:text("* Coming right up!", "smug")
        Game:setFlag("afton_intro_done", true)
    end
}