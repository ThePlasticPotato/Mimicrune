---@class Stage
local Stage, super = Utils.hookScript(Stage)

---@param text string The text to display the objective as.
---@param display_time number The time to display the popup.
---@param popup boolean Whether to display the objective popup.
function Stage:pushObjective(text, display_time, popup)
    Game:setFlag("current_objective", text)
    if (popup) then
        self:addChild(ObjectivePopup(0, 40, nil, nil, text, display_time))
    end
end

return Stage