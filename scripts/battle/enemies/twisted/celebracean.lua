local Celebracean, super = Class(EnemyBattler)

function Celebracean:init()
    super.init(self)

    -- Enemy name
    self.name = "Celebracean"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("celebracean_twisted")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 2
    -- Enemy defense (usually 0)
    self.defense = 6
    -- Enemy reward
    self.money = 100

    self.exit_on_defeat = false

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    self.dialogue_bubble = "agony"
    self.disable_mercy = true
    self.tired_percentage = 0
    --self.comment = "TWISTED"

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
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
    self.check = "AT 2 DF 6\n* A celebratory crustacean\n* Seems the party is over..."

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
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerActFor("evan", "Tell Story", "", {"fredbear"})
    self:registerActFor("cassidy", "Play Prank", "", {"evan"})
end

function Celebracean:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You smile.[wait:5]\n* The dummy smiles back.",
            "* It seems the dummy just wanted\nto see you happy."
        }

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told the dummy a bedtime story.\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Celebracean