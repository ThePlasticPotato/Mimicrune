local Spell, super = Utils.hookScript(Spell)

function Spell:init()
    super.init(self)
    self.pcost = -1
    self.pheat = -1
end

function Spell:getNPCost()
    return self.pcost
end

function Spell:getNHeat()
    return self.pheat
end

return Spell