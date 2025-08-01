local actor, super = Class(Actor, "evan")

function actor:init()
    super.init(self)
        -- Display name (optional)
    self.name = "Evan"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 38

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = {10, 24}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {2/255, 1, 2/255}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/evan/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    self.animations = {
                -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 0.2, true},

        ["battle/transition"]   = {"battle/battle_transition", 0.2, true},
        ["battle/intro"]        = {"battle/attack", 1/15, true},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
    }

    self.offsets = {
                -- Battle offsets
        ["battle/idle"] = {-3, -1},

        ["battle/attack"] = {-10, -6},
        ["battle/attackready"] = {-10, -6},
        ["battle/act"] = {-10, -6},
        ["battle/actend"] = {-10, -6},
        ["battle/actready"] = {-10, -6},
        ["battle/item"] = {-10, -6},
        ["battle/itemend"] = {-10, -6},
        ["battle/itemready"] = {-10, -6},
        ["battle/spell"] = {-10, -6},
        ["battle/spellready"] = {-10, -6},
        ["battle/defend"] = {0, -3},

        ["battle/defeat"] = {-3, -5},
        ["battle/hurt"] = {-10, -6},

        ["battle/intro"] = {-10, -9},
        ["battle/victory"] = {-3, 0},
    }

    -- Sound to play when this actor speaks (optional)
    self.voice = "assets/sounds/voice/party/evan"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/evan"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-2, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = true
end

return actor