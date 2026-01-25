---@class TaintedFountain : TaintedFountainBase
local TaintedFountain, super = Class(TaintedFountainBase)

function TaintedFountain:init(data)
    super.init(self, data)
end

return TaintedFountain