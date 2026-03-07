local Celebracean, super = Class(EnemyBattler)

function Celebracean:init()
    super.init(self)

    -- Enemy name
    self.name = "Celebracean"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("celebracean_twisted")

    -- Enemy health
    self.max_health = 920
    self.health = 920
    -- Enemy attack (determines bullet damage)
    self.attack = 6
    -- Enemy defense (usually 0)
    self.defense = 6
    -- Enemy reward
    self.money = 100

    self.exit_on_defeat = false

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    self.scrambled = false

    self.dialogue_bubble = "agony"
    self.disable_mercy = true
    self.tired_percentage = 0
    --self.comment = "TWISTED"

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "twisted/twistedmissiles",
        "twisted/twistedpopper",
        "twisted/twistedpizzawheel",
        "twisted/twistedclawgnet"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "[shake:1][color:maroon]theendisnevertheendisnever[color:reset]",
        "[shake:1][color:gray]what is your\nearliest memory?",
        "[shake:1][color:gray]is it my fault?\nis it your fault?",
        "[shake:1][color:gray]why persist?\nwhy proceed?",
        "[shake:1][color:gray]do you know who\nyour friends are?",
        "[shake:1][color:gray]have you walked\nthe right path?",
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 6 DF 6\n* A celebratory crustacean\n* Seems the party is over..."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* When did you start being yourself?",
        "* [color:gray]The confetti is rotten.",
        "* Smells like [color:yellow]forgotten birthdays[color:reset].",
        "* [color:gray]Is your head okay? It's [color:maroon]bleeding[color:gray]...[color:reset]",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* [color:lime]Nearly there."

    self.twisted = true
    -- Register act called "Smile"
    self:registerActFor("evan", "Reason", "Try to Reason")
    self:registerActFor("cassidy", "Threaten", "Scare off?")
end

function Celebracean:onAct(battler, name)
    if name == "Reason" then
        -- Act text (since it's a list, multiple textboxes)

        local act = self:getAct("Reason")

        act.tp = 80
        act.name = "TRYCURE"
        act.description = "If they won't listen..."
        
        return {
            "* You try to reason with the Celebracean.[wait:5]\n* It doesn't respond..."
        }

    elseif name == "Threaten" then

        local act = self:getAct("Threaten")

        act.tp = 40
        act.name = "SCRAMBLE"
        act.description = "Hold them off"
        return {
            "* Cassidy tries to threaten the Celebracean.[wait:5]\n* It doesn't react...",
            "* Cassidy's will is changing- THREATEN became SCRAMBLE!"
        }
    elseif name == "TRYCURE" then
        Assets.playSound("boost")
        battler:setAnimation("act")

        Game.battle:startCutscene(function(cutscene)
            Game.battle.display_soul.sprite:flash()
            Game.battle.display_soul.soul_glow:hide(true)
            cutscene:wait(0.25)
            cutscene:text("* " .. battler.chara:getName() .. "'s SOUL emitted a searing light!")
            battler:flash()
            cutscene:playSound("revival")
            cutscene:playSound("snd_greatshine", 1, 0.8)

            local bx, by = Game.battle:getSoulLocation()

            local soul = Game.battle:addChild(purifyevent(bx, by))
            soul.color = Game:getPartyMember(Game.party[1].id).soul_color or { 1, 0, 0 }
            soul.layer = 501
            --  soul.graphics.fade = 0.20
            --soul.graphics.fade_to = 0

            local flash_parts = {}
            local flash_part_total = 20
            local flash_part_grow_factor = 0.5
            for i = 1, flash_part_total - 1 do
                -- width is 1px for better scaling
                local part = Ellipse(bx, by, 1, 1)
                part:setOrigin(0.5, 0.5)
                part.layer = soul.layer - i
                part:setColor(1, 1, 1, -(i / flash_part_total))
                part.graphics.fade = flash_part_grow_factor / 16
                part.graphics.fade_to = math.huge
                part.scale_x = i * i * 2
                part.scale_y = i * i * 2
                part.graphics.grow_x = flash_part_grow_factor * i * 2
                part.graphics.grow_y = flash_part_grow_factor * i * 2
                table.insert(flash_parts, part)
                Game.battle:addChild(part)
            end

            local rect = nil

            local function fade(step, color)
                rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                rect:setParallax(0, 0)
                rect:setColor(color)
                rect.layer = soul.layer + 1
                rect.alpha = 0
                rect.graphics.fade = step
                rect.graphics.fade_to = 1
                Game.battle:addChild(rect)
                cutscene:wait(1 / step / 45)
            end

            cutscene:wait(30 / 30)

            -- soul:remove()
            fade(0.06, { 1, 1, 1 })

            if (self.health < 50) and Game:getFlag("can_purify", true) then
                self.alpha = 0
                if (#Game.battle:getActiveEnemies() == 1) then
                    Game.battle.twisted_darkness:remove()
                    Game.battle.fountain:remove()
                else
                    Game.battle.fountain:glitch()--Game.battle.fountain:addFX(ShaderFX("kinoglitch", { ["iTime"] = function () return Kristal.getTime() end, ["scan_line_jitter"] = function () return 0.015 * (5 / 10) end, ["horizontal_shake"] = function () return 0.01 * (5 / 10) end }, false), "glitchy")
                end
            end

            cutscene:wait(20 / 30)
            for _, part in ipairs(flash_parts) do
                part:remove()
            end

            rect.graphics.fade = 0.02
            rect.graphics.fade_to = 0


            local wait = function() return soul.t > 540 end
            cutscene:wait(wait)

            if (self.health < 50) and Game:getFlag("can_purify", true) then
                Game:addFlag("PURIFIED", 1)
                cutscene:playSound("prognosticus_error", 1.5)
                self:recruitMessage("purified")
                self:defeat("PURIFIED", false)
                Game.battle.music:fade(0.05, nil, function () cutscene:playSound("prognosticus_error", 1.5); Game.battle.timer:after(2, function() Game.battle.music:fade(1) end) end)
            end

            Game.battle.purified = Game.battle.purified + 1
            if (self.health < 50) and Game:getFlag("can_purify", true) then
                cutscene:text("* ...The AGONY washes away!")
            else
                cutscene:text("* But nothing happened...")
            end
            battler:resetSprite()
            Game.battle.display_soul.soul_glow:show()
            
            Game.battle:finishAction(Game.battle:getCurrentAction())
        
            Game.battle:setState("ACTIONS", "CUTSCENE")
            return
        end)
        return
    elseif name == "SCRAMBLE" then
        self.scrambled = true
        Assets.playSound("psyburst")
        self:flash()
        battler:flash()
        self:glitch()--self:addFX(ShaderFX("kinoglitch", { ["iTime"] = function () return Kristal.getTime() end, ["scan_line_jitter"] = function () return 0.015 * (5 / 10) end, ["horizontal_shake"] = function () return 0.01 * (5 / 10) end }, false), "glitchy")

        return {
            "* Cassidy unleashes her power...",
            "* The enemy's processor locks up!"
        }
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Celebracean:getNextWaves()
    local any_enemy_notes = false
    local any_enemy_wheel = false
    for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
        if enemy ~= self then
            if not any_enemy_notes and enemy.selected_wave == "twisted/twistednotes" then any_enemy_notes = true; break end
            if not any_enemy_wheel and enemy.selected_wave == "twisted/twistedpizzawheel" then any_enemy_wheel = true; end
        end
    end

    if (self.scrambled) then
        self.scrambled = false
        self:stopGlitch()
        return {}
    end
    if any_enemy_notes then
        return {}
    elseif any_enemy_wheel then
        return TableUtils.filter(self.waves, function(wave) return wave ~= "twisted/twistedpizzawheel" end)
    else
        return self.waves
    end
end

return Celebracean