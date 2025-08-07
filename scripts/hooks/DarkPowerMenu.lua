---@class DarkPowerMenu
local DarkPowerMenu, super = Utils.hookScript(DarkPowerMenu)

function DarkPowerMenu:init()
    super.init(self)
    self.small_font = Assets.getFont("smallnumbers")
end

function DarkPowerMenu:canCast(spell)
    if not Game:getConfig("overworldSpells") then return false end
    if Game:getTension() < spell:getTPCost(self.party:getSelected()) then return false end
    if (spell.psychic) then
        local canCast = self.party:getSelected().is_psychic and (spell:getNPCost(self.party:getSelected()) <= self.party:getSelected().neural_power) and ((spell:getNHeat(self.party:getSelected()) + self.party:getSelected().heat) <= 100)
        if (not canCast) then return false end
    end
    return (spell:hasWorldUsage(self.party:getSelected()))
end

function DarkPowerMenu:drawSpells()
    local spells = self:getSpells()

    local tp_x, tp_y
    local name_x, name_y

    if #spells <= 6 then
        tp_x, tp_y = 258, 118
        name_x, name_y = 328, 118
    else
        tp_x, tp_y = 242, 118
        name_x, name_y = 302, 118
    end

    Draw.setColor(1, 1, 1)
    Draw.draw(self.tp_sprite, tp_x, tp_y - 5)

    local spell_limit = self:getSpellLimit()

    for i = self.scroll_y, math.min(#spells, self.scroll_y + (spell_limit - 1)) do
        local spell = spells[i]
        local offset = i - self.scroll_y

        local canCast = self:canCast(spell)

        if not canCast then
            Draw.setColor(0.5, 0.5, 0.5)
        else
            Draw.setColor(1, 1, 1)
        end
        if (spell.psychic) then
            local npCost = tostring(spell:getNPCost(self.party:getSelected()))
            local heat = tostring(spell:getNHeat(self.party:getSelected()))

            local pColor = COLORS.aqua
            local hColor = COLORS.red
            if (not canCast) then
                pColor = {0, 0.5, 0.5, 1}
                hColor = {0.5, 0, 0, 1}
            end

            love.graphics.setFont(self.small_font)
            Draw.setColor(0.5, 0.5, 0.5)
            love.graphics.print("-", tp_x+ (12 * npCost:len()), tp_y+12 + (offset * 25))
            Draw.setColor(pColor)
            love.graphics.print(npCost.."%P", tp_x, tp_y+12 + (offset * 25))
            Draw.setColor(hColor)
            love.graphics.print(heat.."H", tp_x+(12 * (npCost:len())+8), tp_y+12 + (offset * 25))
            if (canCast) then Draw.setColor(1, 1, 1) else Draw.setColor(0.5, 0.5, 0.5) end
            love.graphics.setFont(self.font)
        else
            love.graphics.print(tostring(spell:getTPCost(self.party:getSelected())).."%", tp_x, tp_y + (offset * 25))
        end
        love.graphics.print(spell:getName(), name_x, name_y + (offset * 25))
    end

    -- Draw scroll arrows if needed
    if #spells > spell_limit then
        Draw.setColor(1, 1, 1)

        -- Move the arrows up and down only if we're in the spell selection state
        local sine_off = 0
        if self.state == "SPELLS" then
            sine_off = math.sin((Kristal.getTime()*30)/12) * 3
        end

        if self.scroll_y > 1 then
            -- up arrow
            Draw.draw(self.arrow_sprite, 469, (name_y + 25 - 3) - sine_off, 0, 1, -1)
        end
        if self.scroll_y + spell_limit <= #spells then
            -- down arrow
            Draw.draw(self.arrow_sprite, 469, (name_y + (25 * spell_limit) - 12) + sine_off)
        end
    end

    if self.state == "SPELLS" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, tp_x - 20, tp_y + 10 + ((self.selected_spell - self.scroll_y) * 25))

        -- Draw scrollbar if needed (unless the spell limit is 2, in which case the scrollbar is too small)
        if spell_limit > 2 and #spells > spell_limit then
            local scrollbar_height = (spell_limit - 2) * 25
            Draw.setColor(0.25, 0.25, 0.25)
            love.graphics.rectangle("fill", 473, name_y + 30, 6, scrollbar_height)
            local percent = (self.scroll_y - 1) / (#spells - spell_limit)
            Draw.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 473, name_y + 30 + math.floor(percent * (scrollbar_height-6)), 6, 6)
        end
    end
end

return DarkPowerMenu