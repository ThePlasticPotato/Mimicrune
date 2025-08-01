local Door, super = Class(Event)

function Door:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    self.lock = data.lock or false
    self.lock_text = data.lock_text
    self.target_map = data.target_map
    self.target_marker = data.target_marker or "entry"
    self.target_dir = data.target_dir or "down"
end

function Door:onInteract(player, dir)
    super.onInteract(self, player, dir)
    if (self.lock) then
        Assets.playSound("noise")
        Game.world:showText(self.lock_text or "* It's locked.")
        return true
    else
        Assets.playSound("dooropen")
        Game.world:mapTransition(self.target_map, self.target_marker, self.target_dir, function () Assets.playSound("doorclose") end)
    end
    return true
end
return Door