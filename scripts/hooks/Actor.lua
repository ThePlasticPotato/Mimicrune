---@class Actor
---@field default_run string The actor's run animation. Falls back to walk by default.
local Actor, super = Utils.hookScript(Actor)

function Actor:init()
    super.init(self)
    self.default_run = self.default
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
        ["run/down"] = "run/up",
        ["run/up"] = "run/down",
        ["run/left"] = "run/left",
        ["run/right"] = "run/right"
    }

end

function Actor:getDefault()
    if (Game.world and Game.world.player and Game.world.player.run_timer > 60) then return self.default_run else return super.getDefault(self) end
end

function Actor:getStepSoundOverride()
    return nil
end

return Actor
