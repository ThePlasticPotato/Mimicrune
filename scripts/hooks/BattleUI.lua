---@class BattleUI
local BattleUI, super = Utils.hookScript(BattleUI)

function BattleUI:init()
    super.init(self)
    if (Game.battle:getPartyBattler("cassidy")) then
        local size_offset = 0
        local box_gap = 0
        
        if #Game.battle.party == 3 then
            size_offset = 0
            box_gap = 0
        elseif #Game.battle.party == 2 then
            size_offset = 108
            box_gap = 1
            if Game:getConfig("oldUIPositions") then
                size_offset = 106
                box_gap = 7
            end
        elseif #Game.battle.party == 1 then
            size_offset = 213
            box_gap = 0
        end

        self.neurometer = Neurometer(size_offset+ (2 - 1) * (213 + box_gap) + 80, 0, nil, nil, Game.battle:getPartyBattler("cassidy"))
        self.neurometer:setScale(2)
        self:addChild(self.neurometer)
        self.neurometer:setLayer(-20)
    end
end

function BattleUI:drawState()
    if Game.battle.state == "MENUSELECT" then
        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#Game.battle.menu_items / 6) - 1

        local last_selected_character_index = 1

        local x = 0
        local y = 0
        Draw.setColor(Game.battle.encounter:getSoulColor())
        Draw.draw(self.heart_sprite, 5 + ((Game.battle.current_menu_x - 1) * 230), 30 + ((Game.battle.current_menu_y - (page*3)) * 30))

        local font = Assets.getFont("main")
        local smallnumbers = Assets.getFont("smallnumbers")
        love.graphics.setFont(font)

        local page_offset = page * 6
        for i = page_offset+1, math.min(page_offset+6, #Game.battle.menu_items) do
            local item = Game.battle.menu_items[i]

            Draw.setColor(1, 1, 1, 1)
            local text_offset = 0
            -- Are we able to select this?
            local able = Game.battle:canSelectMenuItem(item)
            if item.party then
                if not able then
                    -- We're not able to select this, so make the heads gray.
                    Draw.setColor(COLORS.gray)
                end

                for index, party_id in ipairs(item.party) do
                    local chara = Game:getPartyMember(party_id)

                    -- Draw head only if it isn't the currently selected character
                    if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                        local ox, oy = chara:getHeadIconOffset()
                        Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 30 + (x * 230) + ox, 50 + (y * 30) + oy)
                        text_offset = text_offset + 30
                    else
                        last_selected_character_index = Game.battle.current_selecting
                    end
                end
            end

            if item.icons then
                if not able then
                    -- We're not able to select this, so make the heads gray.
                    Draw.setColor(COLORS.gray)
                end

                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = {icon, false, 0, 0, nil}
                    end
                    if not icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if able then
                -- Using color like a function feels wrong... should this be called getColor?
                Draw.setColor(item:color() or {1, 1, 1, 1})
            else
                Draw.setColor(COLORS.gray)
            end
            love.graphics.print(item.name, text_offset + 30 + (x * 230), 50 + (y * 30))
            text_offset = text_offset + font:getWidth(item.name)

            if item.icons then
                if able then
                    Draw.setColor(1, 1, 1)
                end

                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = {icon, false, 0, 0, nil}
                    end
                    if icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if x == 0 then
                x = 1
            else
                x = 0
                y = y + 1
            end
        end

        -- Print information about currently selected item
        local tp_offset, _ = 0, nil --initialize placeholdder variable so it doenst go in global scope
        local current_item = Game.battle.menu_items[Game.battle:getItemIndex()]
        if current_item.description then
            Draw.setColor(COLORS.gray)
            love.graphics.print(current_item.description, 260 + 240, 50)
            Draw.setColor(1, 1, 1, 1)
            _, tp_offset = current_item.description:gsub('\n', '\n')
            tp_offset = tp_offset + 1
        end

        if current_item.tp and current_item.tp ~= 0 then
            Draw.setColor(PALETTE["tension_desc"])
            love.graphics.print(math.floor((current_item.tp / Game:getMaxTension()) * 100) .. "% "..Game:getConfig("tpName"), 260 + 240, 50 + (tp_offset * 32))
            Game:setTensionPreview(current_item.tp)
        else
            Game:setTensionPreview(0)
        end

        if current_item.data.pcost and current_item.data:getNPCost() ~= 0 then
            Draw.setColor(PALETTE["tension_desc"])
            local npCost = current_item.data.pcost
            local max_heat = 50
            local neural_power = 0
            local heat = current_item.data.pheat
            local current_heat = 0
            if (Game.battle.current_selecting and Game.battle.party[Game.battle.current_selecting]) then
                local chara = Game.battle.party[Game.battle.current_selecting]
                max_heat = chara.chara:getStat("heat", 50)
                npCost = current_item.data:getNPCost(chara.chara)
                heat = current_item.data:getNHeat(chara.chara)
                neural_power = chara.chara.neural_power
                current_heat = chara.chara.heat
            end
            if (self.neurometer) then
                self.neurometer.potential_power = Utils.clamp(neural_power - npCost, 0, 100) / 100
                self.neurometer.potential_heat = Utils.clamp(current_heat + heat, 0, max_heat) / max_heat
            end
            local heatpercent = tostring((heat / max_heat) * 100)
            love.graphics.setFont(smallnumbers)
            local pColor = COLORS.aqua
            local hColor = COLORS.red

            local tp_y = 50
            local tp_x = 260 + 240
            local warning = ""
            if (Game.battle.current_selecting and Game.battle.party[Game.battle.current_selecting]) then
                local chara = Game.battle.party[Game.battle.current_selecting].chara
                
                if current_heat + heat >= max_heat then
                    warning = "///"
                end
            end

            npCost = tostring(npCost)
            Draw.setColor(0.5, 0.5, 0.5)
            love.graphics.print("-", tp_x+ (12 * npCost:len()), tp_y+12 + (tp_offset * 32))
            Draw.setColor(pColor)
            love.graphics.print(npCost.."%P", tp_x, tp_y+12 + (tp_offset * 32))
            Draw.setColor(hColor)
            love.graphics.print(heatpercent.."%H"..warning, tp_x+(12 * (npCost:len())+8), tp_y+12.25 + (tp_offset * 32))
            love.graphics.setFont(font)

            --love.graphics.print(math.floor((current_item.tp / Game:getMaxTension()) * 100) .. "% "..Game:getConfig("tpName"), 260 + 240, 50 + (tp_offset * 32))
        else
            if (self.neurometer) then
                self.neurometer.potential_heat = nil
                self.neurometer.potential_power = nil
            end
        end

        Draw.setColor(1, 1, 1, 1)
        if current_item.data.note_min and current_item.data.note_min ~= 0 then
            local has_notes = 3
            if (Game.battle.current_selecting and Game.battle.party[Game.battle.current_selecting]) then
                local chara = Game.battle.party[Game.battle.current_selecting].chara
                has_notes = chara.notes
            end
            if (has_notes == 0) then
                Draw.setColor(COLORS.maroon)
            else
                Draw.setColor(1, 1, 1, has_notes/3)
            end
            Draw.draw(Assets.getTexture("ui/menu/icon/note"), 260 + 240 + 90, 50 + (tp_offset * 32), nil, 3, 3)
        end

        Draw.setColor(1, 1, 1, 1)
        if page < max_page then
            Draw.draw(self.arrow_sprite, 470, 120 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if page > 0 then
            Draw.draw(self.arrow_sprite, 470, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end

    elseif Game.battle.state == "ENEMYSELECT" or Game.battle.state == "XACTENEMYSELECT" then
        if (self.neurometer) then
            self.neurometer.potential_heat = nil
            self.neurometer.potential_power = nil
        end
        local enemies = Game.battle.enemies_index

        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#enemies / 3) - 1
        local page_offset = page * 3

        Draw.setColor(Game.battle.encounter:getSoulColor())
        Draw.draw(self.heart_sprite, 55, 30 + ((Game.battle.current_menu_y - page_offset) * 30))

        local font = Assets.getFont("main")
        love.graphics.setFont(font)

        local draw_mercy = Game:getConfig("mercyBar")
        local draw_percents = Game:getConfig("enemyBarPercentages")

        Draw.setColor(1, 1, 1, 1)

        if draw_mercy then
            if Game.battle.state == "ENEMYSELECT" then
                love.graphics.print("HP", 424, 39, 0, 1, 0.5)
            end
            love.graphics.print("MERCY", 524, 39, 0, 1, 0.5)
        end
        
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            if self.xact_x_pos < font:getWidth(enemy.name) + 142 then
                self.xact_x_pos = font:getWidth(enemy.name) + 142
            end
        end

        for index = page_offset+1, math.min(page_offset+3, #enemies) do
            local enemy = enemies[index]
            local y_off = (index - page_offset - 1) * 30

            if enemy then
                local name_colors = enemy:getNameColors()
                if type(name_colors) ~= "table" then
                    name_colors = {name_colors}
                end

                if #name_colors <= 1 then
                    Draw.setColor(name_colors[1] or enemy.selectable and {1, 1, 1} or {0.5, 0.5, 0.5})
                    love.graphics.print(enemy.name, 80, 50 + y_off)
                else
                    -- Draw the enemy name to a canvas first
                    local canvas = Draw.pushCanvas(font:getWidth(enemy.name), font:getHeight())
                    Draw.setColor(1, 1, 1)
                    love.graphics.print(enemy.name)
                    Draw.popCanvas()

                    -- Define our gradient
                    local color_canvas = Draw.pushCanvas(#name_colors, 1)
                    for i = 1, #name_colors do
                        -- Draw a pixel for the color
                        Draw.setColor(name_colors[i])
                        love.graphics.rectangle("fill", i-1, 0, 1, 1)
                    end
                    Draw.popCanvas()

                    -- Reset the color
                    Draw.setColor(1, 1, 1)

                    -- Use the dynamic gradient shader for the spare/tired colors
                    local shader = Kristal.Shaders["DynGradient"]
                    love.graphics.setShader(shader)
                    -- Send the gradient colors
                    shader:send("colors", color_canvas)
                    shader:send("colorSize", {#name_colors, 1})
                    -- Draw the canvas from before to apply the gradient over it
                    Draw.draw(canvas, 80, 50 + y_off)
                    -- Disable the shader
                    love.graphics.setShader()
                end

                Draw.setColor(1, 1, 1)

                local spare_icon = false
                local tired_icon = false
                if enemy.tired and enemy:canSpare() then
                    Draw.draw(self.sparestar, 80 + font:getWidth(enemy.name) + 20, 60 + y_off)
                    Draw.draw(self.tiredmark, 80 + font:getWidth(enemy.name) + 40, 60 + y_off)
                    spare_icon = true
                    tired_icon = true
                elseif enemy.tired then
                    Draw.draw(self.tiredmark, 80 + font:getWidth(enemy.name) + 40, 60 + y_off)
                    tired_icon = true
                elseif enemy.mercy >= 100 then
                    Draw.draw(self.sparestar, 80 + font:getWidth(enemy.name) + 20, 60 + y_off)
                    spare_icon = true
                end

                for i = 1, #enemy.icons do
                    if enemy.icons[i] then
                        if (spare_icon and (i == 1)) or (tired_icon and (i == 2)) then
                            -- Skip the custom icons if we're already drawing spare/tired ones
                        else
                            Draw.setColor(1, 1, 1, 1)
                            Draw.draw(enemy.icons[i], 80 + font:getWidth(enemy.name) + (i * 20), 60 + y_off)
                        end
                    end
                end

                if Game.battle.state == "XACTENEMYSELECT" then
                    Draw.setColor(Game.battle.party[Game.battle.current_selecting].chara:getXActColor())
                    if Game.battle.selected_xaction.id == 0 then
                        love.graphics.print(enemy:getXAction(Game.battle.party[Game.battle.current_selecting]), self.xact_x_pos, 50 + y_off)
                    else
                        love.graphics.print(Game.battle.selected_xaction.name, self.xact_x_pos, 50 + y_off)
                    end
                end

                if Game.battle.state == "ENEMYSELECT" then
                    local namewidth = font:getWidth(enemy.name)

                    Draw.setColor(128/255, 128/255, 128/255, 1)

                    if ((80 + namewidth + 60 + (font:getWidth(enemy.comment) / 2)) < 415) then
                        love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off)
                    else
                        love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off, 0, 0.5, 1)
                    end


                    local hp_percent = enemy.health / enemy.max_health

                    local hp_x = draw_mercy and 420 or 510

                    if enemy.selectable then
                        -- Draw the enemy's HP
                        Draw.setColor(PALETTE["action_health_bg"])
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, 81, 16)

                        Draw.setColor(PALETTE["action_health"])
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, math.ceil(hp_percent * 81), 16)

                        if draw_percents then
                            Draw.setColor(PALETTE["action_health_text"])
                            love.graphics.print(math.ceil(hp_percent * 100) .. "%", hp_x + 4, 55 + y_off, 0, 1, 0.5)
                        end
                    end
                end

                if draw_mercy then
                    -- Draw the enemy's MERCY
                    if enemy.selectable then
                        Draw.setColor(PALETTE["battle_mercy_bg"])
                    else
                        Draw.setColor(127/255, 127/255, 127/255, 1)
                    end
                    love.graphics.rectangle("fill", 520, 55 + y_off, 81, 16)

                    if enemy.disable_mercy then
                        Draw.setColor(PALETTE["battle_mercy_text"])
                        love.graphics.setLineWidth(2)
                        love.graphics.line(520, 56 + y_off, 520 + 81, 56 + y_off + 16 - 1)
                        love.graphics.line(520, 56 + y_off + 16 - 1, 520 + 81, 56 + y_off)
                    else
                        Draw.setColor(1, 1, 0, 1)
                        love.graphics.rectangle("fill", 520, 55 + y_off, ((enemy.mercy / 100) * 81), 16)

                        if draw_percents and enemy.selectable then
                            Draw.setColor(PALETTE["battle_mercy_text"])
                            love.graphics.print(math.ceil(enemy.mercy) .. "%", 524, 55 + y_off, 0, 1, 0.5)
                        end
                    end
                end
            end
        end

        Draw.setColor(1, 1, 1, 1)
        local arrow_down = page_offset + 3
        while true do
            arrow_down = arrow_down + 1
            if arrow_down > #enemies then
                arrow_down = false
                break
            elseif enemies[arrow_down] then
                arrow_down = true
                break
            end
        end
        local arrow_up = page_offset + 1
        while true do
            arrow_up = arrow_up - 1
            if arrow_up < 1 then
                arrow_up = false
                break
            elseif enemies[arrow_up] then
                arrow_up = true
                break
            end
        end
        if arrow_down then
            Draw.draw(self.arrow_sprite, 20, 120 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if arrow_up then
            Draw.draw(self.arrow_sprite, 20, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end
    elseif Game.battle.state == "PARTYSELECT" then
        if (self.neurometer) then
            self.neurometer.potential_heat = nil
            self.neurometer.potential_power = nil
        end
        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#Game.battle.party / 3) - 1
        local page_offset = page * 3

        Draw.setColor(Game.battle.encounter:getSoulColor())
        Draw.draw(self.heart_sprite, 55, 30 + ((Game.battle.current_menu_y - page_offset) * 30))

        local font = Assets.getFont("main")
        love.graphics.setFont(font)

        for index = page_offset+1, math.min(page_offset+3, #Game.battle.party) do
            Draw.setColor(1, 1, 1, 1)
            love.graphics.print(Game.battle.party[index].chara:getName(), 80, 50 + ((index - page_offset - 1) * 30))

            Draw.setColor(PALETTE["action_health_bg"])
            love.graphics.rectangle("fill", 400, 55 + ((index - page_offset - 1) * 30), 101, 16)

            local percentage = Game.battle.party[index].chara:getHealth() / Game.battle.party[index].chara:getStat("health")
            Draw.setColor(PALETTE["action_health"])
            love.graphics.rectangle("fill", 400, 55 + ((index - page_offset - 1) * 30), math.ceil(percentage * 101), 16)
        end

        Draw.setColor(1, 1, 1, 1)
        if page < max_page then
            Draw.draw(self.arrow_sprite, 20, 120 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if page > 0 then
            Draw.draw(self.arrow_sprite, 20, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end
    end
    if Game.battle.state == "ATTACKING" or self.attacking then
        if (self.neurometer) then
            self.neurometer.potential_heat = nil
            self.neurometer.potential_power = nil
        end
        Draw.setColor(PALETTE["battle_attack_lines"])
        if not Game:getConfig("oldUIPositions") then
            -- Chapter 2 attack lines
            love.graphics.rectangle("fill", 79, 78, 224, 2)
            love.graphics.rectangle("fill", 79, 116, 224, 2)
        else
            -- Chapter 1 attack lines
            local has_index = {}
            for _,box in ipairs(self.attack_boxes) do
                has_index[box.index] = true
            end
            love.graphics.rectangle("fill", has_index[2] and 77 or 2, 78, has_index[2] and 226 or 301, 3)
            love.graphics.rectangle("fill", has_index[3] and 77 or 2, 116, has_index[3] and 226 or 301, 3)
        end
    end
end

return BattleUI