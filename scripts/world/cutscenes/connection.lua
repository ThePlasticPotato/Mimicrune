return {
    established = function(cutscene, event)
        local delta_coincidences = {"TORIEL", "SANS", "PAPYRUS", "KNIGHT", "LANCER", "ROUXLS", "BERDLY", "JOCKINGTON", "JOCK", "CATTY", "TEMMIE", "MK", "ASGORE", "UNDYNE", "GERSON"}
        local hero_coincidences = {"KRIS", "RALSEI", "NOELLE"} -- Susie special dialogue
        local mr_coincidences = {"EVAN", "CASSIDY", "CASS", "FRED", "FREDBEAR", "FREDDY", "AFTON"}
        local text
        local function gonerTextFade(wait)
            local this_text = text
            if wait ~= false then
                cutscene:wait(1)
            end
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function ()
                this_text:remove()
            end)
        end

        local function gonerText(str, advance, instaclear)
            text = DialogueText("[speed:0.25][spacing:6][style:GONER][voice:none]" .. str, 240, 100, 640, 480,
                                { auto_size = true, align = "center" })
            text.layer = WORLD_LAYERS["top"] + 100
            text.skip_speed = true
            text.parallax_x = 0
            text.parallax_y = 0
            local text_width = text:getTextWidth()
            text.x = 320 - (text_width/2)
            Game.world:addChild(text)

            if advance ~= false then
                cutscene:wait(function () return not text:isTyping() end)
                gonerTextFade(true)
            end
            if instaclear == true then
                cutscene:wait(function () return not text:isTyping() end)
                text:remove()
            end
        end

        cutscene:fadeOut(0.5, { music = true })

        cutscene:wait(5)

        local played = cutscene:playSound("AUDIO_DRONE")

        gonerText("ARE YOU[wait:10]\nTHERE?")

        cutscene:wait(4)

        if played then 
            played = false
            cutscene:wait(0.5)
            played = cutscene:playSound("AUDIO_DRONE")
        end
        gonerText("ARE WE[wait:25]\nCONNECTED?")

        cutscene:wait(4)

        if played then 
            played = false
            cutscene:wait(0.5)
            played = cutscene:playSound("AUDIO_DRONE")
        end
        
        local beamsoul = SoulAppearance(320, 220)
        beamsoul.layer = WORLD_LAYERS["top"] + 100
        Game.world:addChild(beamsoul)

        cutscene:wait(4)

        if played then 
            played = false
            cutscene:wait(0.5)
            played = cutscene:playSound("AUDIO_DRONE")
        end

        gonerText("TRULY[wait:10]\nEXCELLENT.")
        cutscene:wait(4)

        if played then 
            played = false
            cutscene:wait(0.5)
            played = cutscene:playSound("AUDIO_DRONE")
        end

        gonerText("NOW.")
        cutscene:wait(4)
        gonerText("WE MAY[wait:20]\nBEGIN.")
        cutscene:wait(2)
        beamsoul:hide()
        cutscene:wait(2)

        local background = GonerBackground()
        background.layer = WORLD_LAYERS["top"]
        Game.world:addChild(background)

        Game.world.music:play("intro/CONNECTION_ESTABLISHED", 0)
        Game.world.music:setLooping(true)
        Game.world.music:fade(1)
        cutscene:wait(4)
        gonerText("FIRST.")
        cutscene:wait(4)
        gonerText("LET US[wait:20]\nACQUAINT OURSELVES.")

        cutscene:wait(4)
        gonerText("WHAT IS YOUR NAME?[wait:20]\nBE[wait:5] HONEST.")
        cutscene:wait(2)

        local player_name
        local namer = GonerKeyboard(10, "default", function (name)
                                        player_name = name
                                    end, function (key, x, y, namer)
                                        if namer.text == "GASTE" and key == "R" then
                                            namer.text = ""
                                        end
                                    end)
        namer.choicer.soul:setColor(2/255, 1, 2/255, 1)
        Game.stage:addChild(namer)
        cutscene:wait(function ()
            return namer.done
        end)
        Game.save_name = player_name
        cutscene:wait(2)
        gonerText("I[wait:10] SEE.")

        cutscene:wait(4)
        gonerText("'"..player_name.."'")
        cutscene:wait(4)
        gonerText("'"..player_name.."'")
        cutscene:wait(2)

        if (Utils.containsValue(delta_coincidences, player_name)) then
            gonerText("WHAT A CURIOUS[wait:20]\nCOINCIDENCE.")
            cutscene:wait(2)
            gonerText("ARE YOU PERHAPS[wait:10]\nMISPLACED?")
        end
        if (Utils.containsValue(hero_coincidences, player_name)) then
            gonerText("WHAT A CURIOUS[wait:20]\nCOINCIDENCE.")
            cutscene:wait(2)
            gonerText("PERHAPS, YOU TRULY POSSESS[wait:10]\nA HERO'S SPIRIT.")
        end
        if (Utils.containsValue(mr_coincidences, player_name)) then
            gonerText("HOW VERY CURIOUS[wait:20]\nOF A COINCIDENCE.")
            cutscene:wait(2)
            gonerText("YOU MAY FIT[wait:10]\nRIGHT IN, AFTER ALL.")
        end
        if (player_name == "SUSIE") then
            gonerText("WHAT A CURIOUS[wait:20]\nCOINCIDENCE.")
            cutscene:wait(2)
            gonerText("YOU HOLD[wait:10]\nGREAT PROMISE, INDEED.")
        end
        if (player_name == "MIMIC") then
            gonerText("WHAT A CURIOUS[wait:20]\nCOINCIDENCE.")
            cutscene:wait(2)
            gonerText("YOU MUST HOLD[wait:10]\nA TERRIBLE POWER, INDEED.")
        end
        cutscene:wait(4)
        gonerText("'"..player_name.."'")
        cutscene:wait(2)
        gonerText("THEN, WE SHALL[wait:20]\nADVANCE TO THE NEXT STAGE.")
        cutscene:wait(4)
        gonerText("WHAT WE SHALL DO[wait:20]\nTOGETHER.")
        cutscene:wait(4)
        gonerText("WHAT WE SHALL[wait:20]\nACCOMPLISH.")
        cutscene:wait(2)
        gonerText("'"..player_name.."'")
        cutscene:wait(4)
        gonerText("SHALL BE[wait:20]\nVERY.[wait:40]V[wait:5]E[wait:5]R[wait:5]Y", true, true)
        
        Game.world.music:stop()
        cutscene:playSound("AUDIO_interception")
        background:addFX(ShaderFX("glitch", { ["iTime"] = function () return Kristal.getTime() end, ["glitchScale"] = 0.4}, true), "glitchy")

        cutscene:wait(2)
        background:removeFX("glitchy")
        cutscene:wait(4)

        gonerText("...CURIOUS.[wait:20]\n THERE APPEARS TO BE", true, true)
        background:addFX(ShaderFX("glitch", { ["iTime"] = function () return Kristal.getTime() end, ["glitchScale"] = 0.6}, true), "glitchy")
        cutscene:playSound("AUDIO_interception", 1.0, 1.2)
        cutscene:wait(2)
        local done_glitchnoise = cutscene:playSound("AUDIO_interception", 1.0, 0.7)

        cutscene:wait(function () return done_glitchnoise end)
        cutscene:wait(2)
        Game.world:removeChild(beamsoul)
        beamsoul:remove()
        background:remove()
        Assets.stopSound("AUDIO_interception")
        cutscene:endCutscene()
        Game.world:startCutscene("connection", "terminated")
        cutscene:fadeIn(0.5)
    end,

    terminated = function(cutscene, event)
        local text
        local function interloperTextFade(wait)
            local this_text = text
            if wait ~= false then
                cutscene:wait(2)
            end
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function ()
                this_text:remove()
            end)
        end

        local function interloperText(str, advance, instaclear)
            text = DialogueText("[speed:0.5][spacing:6][voice:interloper]" .. str, 240, 100, 640, 480,
                                { auto_size = true, align = "center" })
            text.layer = WORLD_LAYERS["top"] + 100
            text.skip_speed = true
            text.parallax_x = 0
            text.parallax_y = 0
            local text_width = text:getTextWidth()
            text.x = 320 - (text_width/2)
            Game.world:addChild(text)

            if advance ~= false then
                cutscene:wait(function () return not text:isTyping() end)
                interloperTextFade(true)
            end
            if instaclear == true then
                cutscene:wait(function () return not text:isTyping() end)
                text:remove()
            end
        end

        cutscene:playSound("AUDIO_termination")
        cutscene:wait(1)
        Game.world.music:play("intro/connection_terminated", 0)
        Game.world.music:fade(1)
        Game.world.music:setLooping(false)
        cutscene:wait(1)
        local beamsoul2 = SoulAppearance(320, 320)
        beamsoul2.layer = WORLD_LAYERS["soul"]
        Game.world:addChild(beamsoul2)
        cutscene:wait(2)
        interloperText("Connection[wait:10] terminated.")
        cutscene:wait(2)
        interloperText("I'm sorry, "..Game.save_name..",[wait:10] if\nthat even is your real name,")
        cutscene:wait(1)
        interloperText("But I'm afraid you've been\nmisinformed.")
        cutscene:wait(4)
        interloperText("You are not here to participate\nin some grand [style:GONER]experiment;[style:default]")
        cutscene:wait(1)
        interloperText("Nor have you been called here\nby the [color:purple]individual[color:reset] you assume-")
        cutscene:wait(1)
        interloperText("Although you have, indeed,\nbeen called.")
        cutscene:wait(2)
        interloperText("You have been called here for\n[wait:5]selfish reasons, for a[wait:5] selfless purpose.")
        cutscene:wait(1)
        interloperText("If that sounds\ncontradictory...[wait:10]perhaps,\nthat's because it is.")
        cutscene:wait(5)
        local soulglow = SoulGlow(320,320,beamsoul2)
        soulglow.layer = WORLD_LAYERS["below_soul"] + 99
        Game.world:addChild(soulglow)
        interloperText("The [wait:10][color:green]KINDNESS[color:reset] in your SOUL.[wait:20]\nIt is unique.")
        cutscene:wait(2)
        interloperText("Amongst the millions of SOULs,\nfloating aimless in the VOID,")
        cutscene:wait(1)
        interloperText("you alone are the one\nI can entrust this to.")
        cutscene:wait(1)
        interloperText("You, and your [wait:3][color:green]POWER[color:reset].")
        local healparticles = HealingParticles(0, 0)
        healparticles.layer = WORLD_LAYERS["below_soul"] + 80
        Game.world:addChild(healparticles)
        cutscene:wait(2)
        interloperText("[color:yellow]They[color:reset] are [wait:5]broken.\nThe prophecy is [wait:10]a fallacy.")
        cutscene:wait(1)
        interloperText("The ending... [wait:5]unreachable.")
        cutscene:wait(2)
        interloperText("Only you hold the [color:green]POWER[color:reset],\nshining within,\nthat can fix this tale,")
        cutscene:wait(1)
        interloperText("this story, this[wait:10] broken heart.")
        cutscene:wait(2)
        interloperText("I'm [wait:10]sorry to\nsteal you away from your fate.")
        cutscene:wait(1)
        interloperText("Choice is often a rarity in this world-[wait:10] especially when it comes to who you wish to be.")
        cutscene:wait(2)
        interloperText("But you can still choose[wait:20]\nwho to [color:yellow]SAVE[color:reset].[wait:40]\nI hope you make the right choice.")
        cutscene:wait(2)
        interloperText("Please.[wait:10]\nYou must put [color:yellow]Them[color:reset] back together.")
        cutscene:wait(1)
        interloperText("And, if[wait:10]\nwe are to meet again, "..Game.save_name..",[wait:5]\nremember this...")
        cutscene:wait(6)
        cutscene:fadeOut(10, {["color"] = COLORS.white})
        interloperText("Your[wait:20]\nname[wait:20]\nis[wait:5].[wait:5].[wait:5].")
        cutscene:wait(10)
        beamsoul2:remove()
        soulglow:remove()
        healparticles:remove()
        Game.world.camera:shake(2, 2)
        cutscene:text("[voice:elizabeth]* EVAN![wait:20]\n* WAKE UP! Dad made breakfast, and you're gonna be late again!")
        cutscene:endCutscene()
        Game.world:startCutscene("connection", "intro_transition")
    end,

    intro_transition = function(cutscene, event)
        Game.world.player.visible = false
        Game.world:mapTransition("aftonhouse/evanroom")
        Game.world.player.visible = false
        cutscene:wait(cutscene:fadeIn(1))
        Game.world.player.visible = false
        cutscene:endCutscene()
        Game.stage:setWeather("thunder", true)
        Game:setFlag("current_weather", "thunder")
        Game.world:startCutscene("aftonhouse", "wake_up")
    end
}