---@class Stage
local Stage, super = Utils.hookScript(Stage)

---@param text string The text to display the objective as.
---@param display_time number The time to display the popup.
---@param popup boolean Whether to display the objective popup.
---@param sound string The sound to play.
---@param goner boolean Whether to use Gaster's text style or not.
function Stage:pushObjective(text, display_time, popup, sound, goner)
    Game:setFlag("current_objective", text)
    Game:setFlag("plot", Game:getFlag("plot", 0) + 1)
    if (popup) then
        self:addChild(ObjectivePopup(0, 40, nil, nil, text, display_time, sound, goner))
    end
end

return Stage