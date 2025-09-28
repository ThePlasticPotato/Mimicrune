return {
    ---@param cutscene WorldCutscene
    ---@param event Event
    streamer_mode = function (cutscene, event)
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
            text = DialogueText("[speed:2][spacing:6][voice:interloper]" .. str, 240, 50, 640, 480,
                                { auto_size = true, align = "center", font_size = 16 })
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

        interloperText("This game contains meta elements, which may be unsuitable for a streaming environment.\nWould you like to enable STREAMER MODE?\n(In streamer mode, all sensitive content is censored or removed and certain effects are disabled.)", false)

        cutscene:wait(4)
        local choice = ""
        local choicer = GonerChoice(SCREEN_WIDTH / 2, (SCREEN_HEIGHT * 3) / 4, nil, function (choiced, x, y) choice = choiced end, function() end)
        choicer.x = choicer.x - (choicer.width / 2)
        Game.world:addChild(choicer)
        cutscene:wait(function () return choice ~= "" end)

        Game:setFlag("streamer_mode", choice == "YES")

        if (choice == "YES") then
            Assets.playSound("egg")
        end
        interloperTextFade()
        cutscene:wait(2)

        interloperText("This game contains flashing lights,\nand content some may find disturbing.\nDo you still wish to PROCEED?", false)
        cutscene:wait(4)
        local choice2 = ""
        local choicer2 = GonerChoice(SCREEN_WIDTH / 2, (SCREEN_HEIGHT * 3) / 4, nil, function (choiced, x, y) choice2 = choiced end, function() end)
        choicer2.x = choicer2.x - (choicer.width / 2)
        Game.world:addChild(choicer2)
        cutscene:wait(function () return choice2 ~= "" end)

        cutscene:wait(1)

        if (choice2 == "NO") then
            love.event.quit()
        else
            interloperTextFade()
            cutscene:wait(2)
            cutscene:endCutscene()
            Game.world:startCutscene("connection", "startup")
        end
    end,

    ---startup
    ---@param cutscene WorldCutscene
    ---@param event Event
    startup = function (cutscene, event)
        Game.world.player.visible = false
        local texts = {}
        local wdtexts = {}
        local function shortGlitch()
            Game.world:addFX(ShaderFX("glitch", { ["iTime"] = function () return Kristal.getTime() end, ["glitchScale"] = 0.6}, false), "glitchy")
            cutscene:wait(0.25)
            Game.world:removeFX("glitchy")
        end
        local function wipeText() 
            for index, value in ipairs(texts) do
                value:remove()
            end
            for index, value in ipairs(wdtexts) do
                value:remove()
            end
            texts = {}
            wdtexts = {}
        end
        local function terminalText(str, advance, instaclear, offset, red, x_offset)
            offset = offset or 0
            x_offset = x_offset or 0
            local additional = red and "[color:red]" or ""
            local additionalwd = red and "[color:maroon]" or ""
            local wdtext = DialogueText("[color:#222222][font:wingdings][speed:1][spacing:6][style:GONER][voice:none][shake:1]" .. additionalwd .. str, 38 + x_offset, 100 + offset, 640*2, 480 * 2,
                                { auto_size = true, align = "left"})
            local text = DialogueText("[speed:1][spacing:6][style:GONER][voice:none]" .. additional .. str, 40 + x_offset, 90 + offset, 640, 480,
                                { auto_size = true, align = "left", wrap = false})
            
            wdtext:setScale(0.5, 0.5)
            text:setScale(0.5, 0.5)
            text.layer = WORLD_LAYERS["top"] + 100
            text.skip_speed = true
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)
            Game.world:addChild(wdtext)
            wdtext.layer = 100
            text.layer = 110
            
            table.insert(wdtexts, wdtext)
            table.insert(texts, text)
            if advance ~= false then
                cutscene:wait(function () return not text:isTyping() end)
                Utils.removeFromTable(texts, text)
                Utils.removeFromTable(wdtexts, wdtext)
                text:remove()
                wdtext:remove()
            end
            if instaclear == true then
                cutscene:wait(function () return not text:isTyping() end)
                text:remove()
                wdtext:remove()
            end
        end

        
        Game.world.music:play("AUDIO_DEVICE_BOOT")
        Game.world.music:setLooping(false)

        cutscene:musicWait(0.109) -- Start Button Start
        
        cutscene:musicWait(0.365) -- Start Button End
        local flash_sprite = Sprite("misc/DEVICE_bootup", 0, 0)
        flash_sprite:setScale(2,2)
        flash_sprite:play(1/10, false, function()
            Game.world:addFX(ShaderFX("crt_convert", { ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT} }, false), "ceeartee")
            flash_sprite:setSprite("misc/DEVICE_bootup_end")
            flash_sprite:play(1/10, false, function ()
                
            end)
        end)
        Game.stage:addChild(flash_sprite)
        local bios_sprite
        
        cutscene:musicWait(1.051) -- Startup Phase 1
        bios_sprite = Sprite("misc/garamond_bios", 0, 0)
        bios_sprite:setScale(2,2)
        bios_sprite.layer = 90
        bios_sprite.alpha = 0
        Game.world:addChild(bios_sprite)
        
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]")
        bios_sprite.alpha = 0.25
        cutscene:wait(0.15)
        terminalText("[speed:0.5]. . .[wait:1]")
        bios_sprite.alpha = 0.5
        cutscene:wait(0.15)
        terminalText("[speed:0.5]. . .[wait:1]")
        bios_sprite.alpha = 0.75
        cutscene:wait(0.15)
        terminalText("[speed:0.5]. . .[wait:1]")
        bios_sprite.alpha = 1
        cutscene:wait(0.25)
        --cutscene:musicWait(4.773) -- Startup Phase 2
        terminalText("[speed:2]WD-OS_V1.2.1a", false, false)
        cutscene:wait(0.4)
        terminalText("[speed:2]Copyright (C) 19XX-20XX,\nASTER SCIENCES LLC.", false, false, 28)
        cutscene:wait(0.8)
        terminalText("[speed:2]CORE g10 CPU @ 8200 MHz\n8 Processor(s)", false, false, 80)
        cutscene:wait(0.6)
        terminalText("[speed:2]Memory Test : [wait:1]63518192K [wait:2.5]OK", false, false, 80 + 56)
        cutscene:wait(0.7)
        --cutscene:musicWait(8.958) -- Startup Phase 3
        terminalText("[speed:2]Detecting Flash ROM : [wait:3]\n...AMALGAE 15 [wait:2.5]OK", false, false, 80 + 28 + 56)
        cutscene:wait(0.75)
        terminalText("[speed:2]Detecting Flash Extension : [wait:3]\n...Generic m.2 [wait:2.5]OK", false, false, 80 + 28 + 56 + 56)
        cutscene:wait(0.75)
        terminalText("[speed:2]Detecting SOUL Presence : [wait:3]\n...NARRA.kd.13018 [wait:2.5]OK", false, false, 80 + 28 + 56 + 56 + 56)
        cutscene:wait(0.75)
        wipeText()
        terminalText("[speed:2]!!!WARNING!!! Debug Mode is\nENABLED.\nSystem instability \nmay be present.", false, false, 0, true)
        cutscene:wait(1)
        terminalText("[speed:2]PROCEEDing is inadvisable.\nStrike any key to \nPROCEED regardless.", false, false, 56 + 56 + 28, false)
        cutscene:wait(2)
        Assets.playSound("voice/interloper")
        wipeText()
        cutscene:wait(0.1)
        terminalText("[speed:2]Please hold...\n[speed:1]Do not turn off the DEVICE.", false, false, 0)
        cutscene:musicWait(13.182) -- Hard Drive Click
        wipeText()
        terminalText("[speed:2]Initialized VOID_RELAY module.", false, false)
        cutscene:musicWait(14) -- Connection Start
        local connection_target = love.system:getOS() --os.getenv("USERNAME") or os.getenv("USER") or "TARGET_ID"
        -- if (connection_target == "temerity" or Game:getFlag("streamer_mode", false)) then
        --     connection_target = "sys_admin"
        -- end
        terminalText("[speed:2][vdrl] : CONNECTING TO EXTERNAL\nDEVICE RUNNING : ' " .. connection_target .. " '", false, false, 28)
        cutscene:musicWait(15.229) -- Beep end
        cutscene:musicWait(16.105) -- Static
        Game:setBorder("DEVICE", 18)
        shortGlitch()
        terminalText("[speed:2][vdrl] : ESTABLISHING \n CONNECTION", false, false, 56 + 28)
        terminalText("[speed:2][vdrl] :", true, false, 56 + 56 + 28)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:musicWait(17.484) -- Connection Phase 1
        shortGlitch()
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:2][vdrl] : TARGETLOCK", false, false, 56 + 56 + 28, true)
        cutscene:wait(0.1)
        terminalText("[speed:2][vdrl] :", true, false, 56 + 56 + 56 + 28)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 28, false, 40)
        cutscene:musicWait(19.346) -- Connection Phase 2
        shortGlitch()
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:2][vdrl] : PING SUCCESS, TOOK 1899ms", false, false, 56 + 56 + 56 + 28, true)
        cutscene:wait(0.1)
        terminalText("[speed:2][vdrl] :", true, false, 56 + 56 + 56 + 56 + 28)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:musicWait(22.86) -- Connection Phase 3
        shortGlitch()
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:2][vdrl] : BEGIN LINK PHASE", false, false, 56 + 56 + 56 + 56 + 28, true)
        cutscene:wait(0.1)
        terminalText("[speed:2][vdrl] :", true, false, 56 + 56 + 56 + 56 + 56 +  28)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:musicWait(27.535) -- Connection Phase 4
        shortGlitch()
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:0.5]. . .[wait:1]", true, false, 56 + 56 + 56 + 56 + 56 + 28, false, 40)
        cutscene:wait(0.25)
        terminalText("[speed:2][vdrl] : LINK SUCCESS", false, false, 56 + 56 + 56 + 56 + 56 + 28, true)
        
        cutscene:musicWait(34.356) -- Connection Finale Start
        shortGlitch()
        wipeText()
        terminalText("[speed:2][vdrl] : RELAY CONNECTED.", false, false, 0, true)
        cutscene:musicWait(36) -- Connection Finale Riser
        terminalText("[speed:0.5][vdrl] : SOUL UPLOAD IN PROGRESS...", false, false, 28, true)
        shortGlitch()
        cutscene:musicWait(36.731) -- Connection Finale End
        shortGlitch()
        wipeText()
        terminalText("[speed:2]Please hold...\n[speed:1]Do not turn off the DEVICE.", false, false, 0)
        cutscene:musicWait(37.331) -- Gaster Shuts Up
        shortGlitch()
        wipeText()
        bios_sprite:remove()
        Game.world:removeFX("ceeartee")
        shortGlitch()
        cutscene:musicWait(38.287) -- snd_greatshine
        cutscene:musicWait(39.666) -- CONNECTION ESTABLISHED

        cutscene:wait(function () return not Game.world.music:isPlaying() end)
        cutscene:wait(2)
        
        Game.world.music:stop()
        Game.world.music:setLooping(true)
        
        cutscene:endCutscene()
        Game.world:startCutscene("connection", "established")
    end,

    ---established
    ---@param cutscene WorldCutscene
    ---@param event Event
    established = function(cutscene, event)
        Game.world.player.visible = false
        Game.world.player.y = 1000
        local delta_coincidences = {"TORIEL", "SANS", "PAPYRUS", "KNIGHT", "LANCER", "ROUXLS", "BERDLY", "JOCKINGTON", "JOCK", "CATTY", "TEMMIE", "MK", "ASGORE", "UNDYNE", "GERSON"}
        local hero_coincidences = {"KRIS", "RALSEI", "NOELLE"} -- Susie special dialogue
        local mr_coincidences = {"EVAN", "CASSIDY", "CASS", "FRED", "FREDBEAR", "FREDDY", "AFTON", "BONNIE", "CHICA", "FOXY", "SPRING"}
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

        if (player_name == "MIMIC") then
            Game.world.music:stop()
            background:remove()
            cutscene:wait(2)

            local jumpscare = Jumpscare("mimic", function()
                error({msg = [[
                Error: src/engine/tunnel/voidrelay.lua:1987: Connection failure.

                stack traceback:

                voidrelay.lua:1225: in function 'authenticate'
                voidrelay.lua:413: in function 'connect'
                wdserver.lua:666: in function 'locate'
                wdserver.lua:23: in function 'init'
                ]]})
            end)
            Game.world:addChild(jumpscare)
            return
            -- gonerText("WHAT A CURIOUS[wait:20]\nCOINCIDENCE.")
            -- cutscene:wait(2)
            -- gonerText("YOU MUST HOLD[wait:10]\nA TERRIBLE POWER, INDEED.")
        end

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
        if (player_name == "NARRA") then
            gonerText("THANK YOU FOR YOUR[wait:20]\nHONESTY.")
            cutscene:wait(2)
            gonerText("THIS BODES WELL FOR[wait:20]\nWHAT COMES NEXT.")
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
        Game.world:addFX(ShaderFX("glitch", { ["iTime"] = function () return Kristal.getTime() end, ["glitchScale"] = 0.4}, false), "glitchy")
        Game:setBorder("DEVICE_ERROR", 0)

        cutscene:wait(2)
        Game.world:removeFX("glitchy")
        cutscene:wait(4)

        gonerText("...CURIOUS.[wait:20]\n THERE APPEARS TO BE AN", true, true)
        Game.world:addFX(ShaderFX("glitch", { ["iTime"] = function () return Kristal.getTime() end, ["glitchScale"] = 0.6}, false), "glitchy")
        cutscene:playSound("AUDIO_interception", 1.0, 1.2)
        Game:setBorder("DEVICE_BROKEN", 0)
        cutscene:wait(2)
        local done_glitchnoise = cutscene:playSound("AUDIO_interception", 1.0, 0.7)
        cutscene:wait(function () return done_glitchnoise end)
        cutscene:wait(2)
        Game.world:removeChild(beamsoul)
        beamsoul:remove()
        background:remove()
        Assets.stopSound("AUDIO_interception")
        cutscene:endCutscene()
        Game.world:removeFX("glitchy")
        Game.world:startCutscene("connection", "terminated")
        cutscene:fadeIn(0.5)
    end,

    ---@param cutscene WorldCutscene
    ---@param event any
    terminated = function(cutscene, event)
        Game.world:addFX(ShaderFX("vhs", {["iTime"] = function () return Kristal.getTime() end, ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}, ["noiseTex"] = Assets.getTexture("static_gray")}), "veehaitchess")
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
        local addition = "[wait:10] if\nthat even is your real name,"
        if (Game.save_name == "NARRA") then
            addition = "[wait:10] if\nthat truly is your real name,"
        end
        interloperText("I'm sorry, "..Game.save_name..","..addition)
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
        local fade = cutscene:fadeOut(10, {["color"] = COLORS.white})
        interloperText("Your[wait:20]\nname[wait:20]\nis\n[wait:10].[wait:10].[wait:10].")
        cutscene:wait(fade)
        Game.world:removeFX("veehaitchess")
        if (text and not text.isRemoved) then
            text:remove()
        end
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
        Game.world:removeFX("veehaitchess")
        Game.world:mapTransition("aftonhouse/evanroom")
        Game.world.player.visible = false
        cutscene:wait(cutscene:fadeIn(1))
        cutscene:endCutscene()
        Game.world.player.visible = true
        Game.stage:setWeather("thunder", true)
        Game:setFlag("current_weather", "thunder")
        Game.world:startCutscene("aftonhouse", "wake_up")
    end
}