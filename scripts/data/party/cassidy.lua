local character, super = Class(PartyMember, "cassidy")

function character:init()
    super.init(self)
        -- Display name
    self.name = "Cassidy"

    -- Actor (handles overworld/battle sprites)
    self:setActor("cassidy")
    self:setLightActor("cassidy_lw")

    -- Display level (saved to the save file)
    self.level = 1 -- todo: make this based on mimicrune chapters
    -- Default title / class (saved to the save file)
    self.title = "Psychic\nA passionate flame.\nFrail."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1.0, 210/255, 53/255}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = false
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "C-Action"

    self.neural_power = 0
    self.heat = 0
    self.is_psychic = true

    -- Spells
    self:addSpell("meditate")
    self:addSpell("psybeam")
    self:addSpell("psywave")

    -- Current health (saved to the save file)
    self.health = 40

    -- Base stats (saved to the save file)
    self.stats = {
        health = 40,
        attack = 8,
        defense = 1,
        magic = 12,
        heat = 50
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 100,
        heat = 200
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/ring"

    -- Equipment (saved to the save file)
    self:setWeapon("popring")
    self:setArmor(1, "overmosts")
    --self:setArmor(2, "amber_card")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "popring_lw"
    self.lw_armor_default = "overalls"

    -- Character color (for action box outline and hp bar)
    self.color = {1.0, 210/255, 53/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1.0, 210/255, 53/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1.0, 210/255, 53/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {211/255, 130/255, 75/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1.0, 210/255, 53/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/cassidy/head"
    -- Path to head icons used in battle
    self.head_icons = "party/cassidy/icon"
    -- Name sprite
    self.name_sprite = "party/cassidy/name"
    
    -- Pitch of the attack sound
    self.attack_sprite = "effects/attack/wave"
    self.attack_sound = "psywave"
    self.attack_pitch = 1.0

    -- Battle position offset (optional)
    self.battle_offset = nil
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:getGameOverMessage(main)
    return {
        "Evan-[wait:5] EVAN!\nCmon' we can't die here...[wait:5]\nGet up...! Please..."
    }
end

function character:onAttackHit(enemy, damage)
    if damage > 0 then
        Assets.playSound("impact", 0.8)
        Game.battle:shakeCamera(4)
    end
end

function character:onTurnStart(battler)
    if self:getFlag("neural_overheat", false) then
        Game.battle:pushForcedAction(battler, "DEFEND", nil, nil, nil)
    end
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 2 == 0 then
        self:increaseStat("health", 1)
    end
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

return character