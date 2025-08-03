local Arch, super = Class(Event)

function Arch:init(data)
    super.init(self, data)
    self:setSprite("props/aftonhouse/aftonhouse_downstairs_arch")
    self.width = self.sprite:getScaledWidth()
    self.height = self.sprite:getScaledHeight()
    self.faded = false
end

function Arch:onEnter(chara)
    if (chara.is_player and not self.faded) then
        self:fadeTo(0.5, 0.5)
        self.faded = true
    end
end

function Arch:onExit(chara)
    if (chara.is_player and self.faded) then
        self:fadeTo(1.0, 0.5)
        self.faded = false
    end
end

return Arch
