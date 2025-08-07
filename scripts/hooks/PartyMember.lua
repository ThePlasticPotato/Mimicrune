---@class PartyMember
---@field known_spells Spell[]
---@field neural_power number
---@field heat number
---@field is_psychic boolean
---@field is_musical boolean
---@field notes number
local PartyMember, super = Utils.hookScript(PartyMember)

function PartyMember:init()
    super.init(self)
    self.known_spells = {}
    self.neural_power = 0
    self.heat = 0
    self.is_psychic = false
    self.is_musical = false
    self.notes = 0
    self.stats["heat"] = 0
    self.stats["max_spells"] = 6
    self.max_stats["heat"] = 0
    self.max_stats["max_spells"] = 6
end

--- Adds `spell` to this party member's list of known spells. \
--- If their list of active spells is not full, it also adds it to that.
--- @param spell string|Spell
--- @param activate boolean
function PartyMember:addKnownSpell(spell, activate)
    if type(spell) == "string" then
        spell = Registry.createSpell(spell)
    end
    table.insert(self.known_spells, spell)
    if (spell.required or activate == true) and Utils.tableLength(self.spells) < self:getStat("max_spells", 6) then
        table.insert(self.spells, spell)
    end
end

--- Returns a table of this party member's known spells.
--- @return table known
function PartyMember:getKnownSpells()
    return self.known_spells
end

--- Checks whether this party member knows the spell `spell`
---@param spell string|Spell
---@return boolean has_spell
function PartyMember:hasKnownSpell(spell)
    for i,v in ipairs(self.known_spells) do
        if v == spell or (type(spell) == "string" and v.id == spell) then
            return true
        end
    end
    return false
end

--- Replaces one of this party member's known spells with another \
--- If `spell` is not in this party member's known spell list, they will not learn `replacement`
---@param spell string|Spell
---@param replacement string
function PartyMember:replaceKnownSpell(spell, replacement)
    self:replaceSpell(spell, replacement)
    local tempspells = {}
    for _,v in ipairs(self.known_spells) do
        if v == spell or (type(spell) == "string" and v.id == spell) then
            table.insert(tempspells, Registry.createSpell(replacement))
        else
            table.insert(tempspells, v)
        end
    end
    self.known_spells = tempspells
end

--- Removes `spell` from this party member's list of known spells. \
--- Also removes it from their list of active spells.
--- @param spell string|Spell
function PartyMember:removeKnownSpell(spell)
    self:removeSpell(spell)
    for i,v in ipairs(self.known_spells) do
        if v == spell or (type(spell) == "string" and v.id == spell) then
            table.remove(self.spells, i)
            return
        end
    end
end

--- Retrieves the current weight of equipped spells. By default, this is just the number of spells equipped.
--- @return number weight
function PartyMember:getSpellWeight()
    local weight = 0
    for i,v in ipairs(self.spells) do
        weight = weight + v:getWeight(self)
    end
    return weight
end

function PartyMember:update()
    super.update(self)
    if (self:getFlag("max_spells_updated", false)) then
        local current_weight = self:getSpellWeight()
        local max_weight = self:getStat("max_weight", 6)
        if (current_weight > max_weight) then
            local i = 1
            local flipped = Utils.reverse(self:getSpells())
            while (self:getSpellWeight() > max_weight and i <= #flipped) do
                if (not flipped[i].required) then Utils.removeFromTable(self.spells, flipped[i]) end
                i = i+1
            end
        end
        self:setFlag("max_spells_updated", false)
    end
end

return PartyMember