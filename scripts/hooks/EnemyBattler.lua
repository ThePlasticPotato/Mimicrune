---@class EnemyBattler
local EnemyBattler, super = Utils.hookScript(EnemyBattler)

--- *(Override)* Gets the attack damage dealt to this enemy \
--- *By default, returns `damage` if it is a number greater than 0, otherwise using the attacking `battler` and `points` against this enemy's `defense` to calculate damage*
---@param damage    number
---@param battler   PartyBattler
---@param points    number          The points of the hit, based on closeness to the target box when attacking, maximum value is `150`
---@return number
function EnemyBattler:getAttackDamage(damage, battler, points)
    local bonus = battler.next_attack_bonus
    battler.next_attack_bonus = 0
    if damage > 0 then
        return damage + bonus
    end
    return ((battler.chara:getStat("attack") * points) / 20) + bonus - (self.defense * 3)
end

return EnemyBattler