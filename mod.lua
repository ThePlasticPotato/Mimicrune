function Mod:init()
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(new_file)
    Game.world.player.visible = false
    -- I'm assuming this logic was commented out for a reason, so I've added a
    -- command line argument `$ love . --force-intro` to bypass it.
    if (Kristal.hasAnySaves() and not (Kristal.Args["force-intro"])) then
        Game.world:mapTransition("fileselect")
    else
        Game:setFlag("has_cell_phone", true)
        Game.world:startCutscene("connection", "streamer_mode")
        Game:setFlag("audible_footsteps", true)
    end

end

function Mod:onDrawText(text, node, state, x, y, scale, font, use_color)
    if not text:includes(DialogueText) then
        return
    end

    if state.temp_shake > 0 then
        if text.timer - state.last_temp_shake >= (1 * DTMULT) then
            state.last_temp_shake = text.timer
            state.offset_x = Utils.round(Utils.random(-state.temp_shake, state.temp_shake))
            state.offset_y = Utils.round(Utils.random(-state.temp_shake, state.temp_shake))
        end
        state.temp_shake = Utils.approach(state.temp_shake, 0, 8 * DT)
    end
end

---@param text Text|DialogueText
function Mod:registerTextCommands(text)
    if not text:includes(DialogueText) then
        return
    end

    text:registerCommand("tempshake", function(text, node, dry)
        text.state.temp_shake = tonumber(node.arguments[1]) or 1
        text.draw_every_frame = true
    end)
end


function Mod:shakifyText(text)
    local no_sound = { "\n", " ", "^", "!", ".", "?", ",", ":", "/", "\\", "|", "*" }
    local output_text = ""
    local is_command = false
    local char = ""

    for i = 1, #text do
        char = text:sub(i, i)
        if char == "[" then
            is_command = true
        end
        
        if not is_command and not Utils.containsValue(no_sound, char) then
            output_text = output_text .. "[tempshake:4]"
        end
        output_text = output_text .. char

        if char == "]" then
            is_command = false
        end
    end
    
    return output_text.."[tempshake:0]"
end
