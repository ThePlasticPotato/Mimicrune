---@class Spell
---@field pcost number|nil
---@field pheat number|nil
---@field required boolean
local Spell, super = Utils.hookScript(Spell)

function Spell:init()
    super.init(self)
    self.psychic = false
    self.pcost = nil
    self.pheat = nil
    self.required = false
end

function Spell:getNPCost(chara)
    return self.pcost
end

function Spell:getNHeat(chara)
    return self.pheat
end

return Spell