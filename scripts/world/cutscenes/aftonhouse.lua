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
        local elizabeth = cutscene:getCharacter("elizabeth_lw")
        local ep_x, ep_y = cutscene:getMarker("elizabeth_pancake_spot")
        local elizabeth_pancakes = Sprite("props/aftonhouse/pangcaek", ep_x, ep_y)
        elizabeth_pancakes:setLayer(WORLD_LAYERS["above_events"])
        elizabeth_pancakes:setScale(2, 2)
        elizabeth_pancakes:setOrigin(0.5, 0.5)
        Game.world:addChild(elizabeth_pancakes)
        afton:setFacing("up")
        local elizachair = cutscene:getEvent(25)
        elizabeth.should_sit = true
        elizabeth:setFacing("down")
        elizachair:trySitting(elizabeth, "down", false)
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
        local should_retrigger_music = true
        Game.world.timer:afterCond(function () return (not Game.world.music:isPlaying()) end, function ()
            if (should_retrigger_music) then
                Game.world.music:play("themes/william/mbtl_loopable", 1.0)
                Game.world.music:setLooping(true)
            end
        end)

        cutscene:setSpeaker(afton)
        cutscene:text("* Whoops! Power cut... that storm really is something, huh?", "smug")
        cutscene:text("* [speed:0.1]. . .[wait:4][react:1]", "awkward_left_sweat", "evan_lw", { reactions = { {"(...I see that one didn't really land...)", 200, 58, "nervous", "william"}, }})
        cutscene:text("* 'Morning, son!", "grin")
        cutscene:text("* You're just in time [wait:2][react:1][wait:4][react:2][wait:20]", "smile", "william", { reactions = { {"For once.", "rightmid", "middle", "grin", "elizabeth"}, {"Elizabeth, don't antagonize your brother.", 200, "bottom", "annoyed_down", "william" } }, auto = true })
        cutscene:text("* For breakfast! Your old pop's famous flapjacks.[wait:3][react:1]", "smug", "william",  { reactions = { {"(yeah, THAT's what you're famous for-)", 200, 58, "smile_side", "elizabeth"}, }})

        local choice = cutscene:choicer({"Where's Mike?", "PURPLE GUY!?", "Ooh, pancakes!"}, {highlight = {COLORS.green, COLORS.purple, COLORS.yellow}})

        if (choice == 1) then
            cutscene:panTo(elizabeth, 1, "in-out-cubic", function () 
                elizabeth:setAnimation("sit_turn_left")
                cutscene:text("* Probably sleeping like a [wave:1]rock[wave:0].[wait:4][face:smug] You two are alike in that.", "unamused", "elizabeth") 
                end)
            cutscene:wait(2)
            elizabeth:setAnimation("sit_turn_left_end", function () elizabeth:setAnimation("sit") end)
            afton:setSprite("pancakes_down_squint")
            cutscene:wait(1)
            cutscene:panTo(afton, 1, "in-out-cubic")
            cutscene:wait(2)
            cutscene:text("* Anyways...[wait:4][func:1][face:grin] pancakes!", "squint_left", afton, { functions = {function() 
                afton:setWalkSprite("walk_pancakes")
            end}})
        elseif(choice == 2) then
            afton:setSprite("pancakes_down_squint")
            cutscene:text("* [speed:0.1]. . .[wait:4]", "confused", "william", { auto = true })
            cutscene:text("* Oh-! You're referring to-", "neutral_side", "william", { auto = true })
            cutscene:text("* -the winner of the [color:purple]Friend Inside Weekly[color:reset] cover contest!", "smile")
            cutscene:panTo("purpleguy_pan", 1, "in-out-cubic", function () cutscene:text("* I was surprised too. Not exactly 'cover material', that one...", "neutral_side") end)
            cutscene:wait(1)
            cutscene:panTo(afton, 1, "in-out-cubic")
            cutscene:wait(2)
            cutscene:text("* Anyways...[wait:4][face:smug][func:1] pancakes!", "annoyed_down", afton, { functions = {function() 
                afton:setWalkSprite("walk_pancakes")
            end}})
        else
            cutscene:text("* [wave:1]Pancakes![wave:0]", "happy", "evan_lw")
            cutscene:text("* Nothing better on a dark morning.", "grin")
        end
        cutscene:text("* Have a seat with your sister-[wait:2] I'll bring them to the table.", "smile")
        cutscene:panTo(Game.world.player, 1, "in-out-cubic", function ()
            cutscene:enableMovement()
            Game.world:setCameraAttached(true)
            cutscene:allowLimitedInteraction()
        end)
        cutscene:wait(function () return Game:getFlag("aftonhouse_sat_down", false) end)
        cutscene:disableMovement()
        cutscene:disableLimitedInteraction()
        local should_face = "down"
        if (Game.world.player.seat) then
            should_face = Game.world.player.seat.facing
        end
        Game.world.player:setFacing(should_face)
        cutscene:wait(2)
        cutscene:text("* Coming right up!", "smug")
        local reached = false
        afton:pathfindChase(Game.world.player, {once = true, after = function () reached = true end, speed = 8, chase_distance = 32})
        cutscene:wait(function () return reached end)
        local _, plate_dir = Utils.getFacingVector(should_face)
        plate_dir = plate_dir * 96
        local plate_pos = {Game.world.player.x, Game.world.player.y + plate_dir}
        local pancakes = Sprite("props/aftonhouse/pangcaek", plate_pos[1], plate_pos[2])
        pancakes:setScale(2, 2)
        pancakes:setOrigin(0.5, 0.5)
        pancakes:setLayer(WORLD_LAYERS["above_events"])
        Game.world:addChild(pancakes)
        cutscene:playSound("plate_place")
        afton:setWalkSprite("walk_apron")
        cutscene:wait(2)
        local to_x_1, to_y_1 = cutscene:getMarker("walk_target_1")
        reached = false
        afton:pathfindTo(to_x_1, to_y_1, { speed = 8, after = function () 
            afton:setFacing("right")
            reached = true
        end })
        cutscene:wait(function () return reached end)
        cutscene:text("* Now, you enjoy that.", "smug")
        cutscene:text("* I've got some work to attend to. Need me, I'll be in my office.", "grin")
        --insert cheeky wave here but im lazy rn
        cutscene:setSpeaker(elizabeth)
        local to_x_2, to_y_2 = cutscene:getMarker("walk_target_2")
        reached = false
        afton:pathfindTo(to_x_2, to_y_2, { speed = 8, after = function () 
            afton:remove()
            reached = true
        end })
        cutscene:wait(function () return reached end)
        cutscene:wait(2)
        cutscene:text("* [speed:0.1]. . [face:neutral_side].[wait:4]", "neutral")
        cutscene:text("* ...Aren't you going to say anything?", "awkward_right", "evan_lw")
        cutscene:text("* And what exactly would I say?[wait:8]", "unamused", elizabeth, {auto = true})
        cutscene:text("* It's not like you'd understand half the things I think about.", "smug", elizabeth)
        cutscene:text("* [speed:0.1]. . .[wait:8]", "disapproval", "evan_lw", {auto = true})
        cutscene:text("* [wave:1]Fine,[wait:2] fine.[wave:0][wait:4]", "neutral_side", elizabeth, { auto = true })
        cutscene:text("* Oh, actually, I heard something pretty interesting...[wait:2][react:1]", "grin", elizabeth, {reactions = {{"???", "right", 58, "eyebrow_raise", "evan_lw"}}})
        cutscene:text("* [wave:1][color:yellow]That [wait:1]girl[color:reset][wave:0] that tolerates you-[wait:2]", "smug", elizabeth)
        cutscene:text("* I think she might've been discharged...[wait:2][react:1]", "smug", elizabeth, {reactions = {{"!!!", "right", 58, "mild_shock", "evan_lw"}}})
        cutscene:text("* "..Mod:shakifyText("[font:main_mono, 64]REALLY").."?![wait:2][react:1][wait:2][react:2][wait:4]", "happy_wide", "evan_lw", { reactions = { {"Don't shout.", "leftmid", "bottom", "unamused", "elizabeth"}, {"Sorry...", "right", "bottom", "sad", "evan_lw" } } })
        cutscene:text("* Yes, 'really'.[wait:3]\n* [face:neutral_side]Now if you'll excuse me...", "unamused")
        cutscene:wait(1)
        elizabeth_pancakes:remove()
        cutscene:playSound("plate_place", 0.8, 1.2)
        cutscene:wait(1)
        elizabeth:attemptSit(nil, nil)
        cutscene:wait(1)
        cutscene:text("* Now that dad's gone, [wait:1][wave:1]I'm[wave:0][wait:2] gonna go eat in my room.[wait:2][face:smug] See you later, dork.", "grin")
        reached = false
        elizabeth:pathfindTo(to_x_2, to_y_2, { speed = 8, after = function () 
            elizabeth:remove()
            reached = true
        end })
        cutscene:wait(function () return reached end)
        cutscene:wait(1)
        cutscene:setSpeaker("evan_lw")
        cutscene:text("* [speed:0.1]. .[face:squint_right] .[wait:4]", "squint")
        local done_sighing = cutscene:playSound("evansigh", 1.25)
        cutscene:wait(done_sighing)
        cutscene:wait(1)
        cutscene:playSound("fork_on_plate")
        cutscene:text("* ...Guess I'm eating alone again.", "sad")
        local reveal_self = cutscene:choicer({"You are\nnot alone.", ". . ."})
        local fake_choice = nil
        should_retrigger_music = false
        Game.world.music:setLooping(false)
        if (reveal_self == 1) then
            if (Game.world.music:isPlaying()) then
                local pitch = 1.0
                Game.world.timer:doWhile(function () return pitch > 0 end, function ()
                    pitch = pitch - (DT / 2)
                    Game.world.music:setPitch(math.max(pitch, 0.01))
                 end, function ()
                    Game.world.music:stop()
                    Game.world.music:setPitch(1.0)
                end)
            end
            cutscene:shakeCharacter("evan_lw", 2, 0, 0.5)
            cutscene:wait(2)
            cutscene:text("*[speed:0.25] . . . [shake:1]who said that...?[shake:0]", "fear")
            _, fake_choice = cutscene:choicer({"Me.", ". . ."}, { wait = false })
        end
        cutscene:wait(1)
        if (fake_choice) then fake_choice:remove() end
        cutscene:playSound("doorbell")
        cutscene:wait(1)
        local _, done_alert = cutscene:alert("evan_lw")
        cutscene:wait(done_alert)
        local evan_face = "neutral_side"
        local additional = ""
        if (reveal_self == 1) then
            evan_face = "worry_side"
            additional = "T-"
        end
        cutscene:text("* "..additional.."The doorbell...[wait:4][face:"..evan_face.."]\n* I should probably go check who that is.", "mild_shock")
        cutscene:wait(1)
        Game.stage:pushObjective("Answer the door.", 4, true, nil, nil)
        if (Game:getFlag("plot", 0) ~= 3) then
            Game:setFlag("plot", 3)
            -- probably unnecessary but just to be certain in case of cutscene skipping/repeating or weird bugs
        end
        Game:setFlag("afton_intro_done", true)
        cutscene:endCutscene()
    end
}