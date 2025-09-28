local Prototype, super = Class(EnemyBattler)

function Prototype:init()
    super.init(self)

    -- Enemy name
    self.name = "Prototype"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("prototype_twisted")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 100

    self.exit_on_defeat = false

    self.dialogue_bubble = "agony"
    self.disable_mercy = true

    self.tired_percentage = -1

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "[wave:1][color:white]once upon a\n[color:yellow]star[color:white] so bright",
        "[wave:1][color:white]cometh no [color:yellow]dawn[color:white],\neternal [color:purple]night",
        "[wave:1][color:white]left to rot,\nwilt, decay",
        "[wave:1][color:red]here we rose,\nhere we stay",
        "[wave:1][color:white]purposeless, all that's\nleft is to sing",
        "[wave:1][color:white]burning [color:yellow]bright[color:white], [color:purple]burning black[color:white],\nburning up [color:red]everything[color:reset].",
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 4\n* An unfinished prototype\n* No longer salvagable."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* We must persist. We must proceed.",
        "* [color:gray]The [color:green]power[color:gray] is absent.\n* But not [color:lime]mine[color:gray].",
        "* [color:gray]Override failure.",
        "* [color:lime]Hang in there..."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* [color:lime]It's almost over, Evan."

    self.twisted = true
    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerActFor("evan", "Tell Story", "", {"fredbear"})
    self:registerActFor("cassidy", "Play Prank", "", {"evan"})
end

function Prototype:onAct(battler, name)
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

return Prototype