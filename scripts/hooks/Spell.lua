---@class Spell
---@field pcost number|nil
---@field pheat number|nil
---@field required boolean
---@field slot_weight number
local Spell, super = Utils.hookScript(Spell)

function Spell:init()
    super.init(self)
    self.psychic = false
    self.pcost = nil
    self.pheat = nil
    self.required = false
    self.slot_weight = 1
end

function Spell:getWeight(chara)
    return self.slot_weight
end

function Spell:getNPCost(chara)
    return self.pcost
end

function Spell:getNHeat(chara)
    return self.pheat
end

return Spell