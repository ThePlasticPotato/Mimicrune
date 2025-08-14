---@class WorldCutscene : Cutscene
local WorldCutscene, super = Utils.hookScript(WorldCutscene)

--- Suspends the cutscene until the music reaches a certain runtime.
---@param time number   The song runtime to wait until before resuming the cutscene, in seconds.
---@return any
function WorldCutscene:musicWait(time)
    return self:wait(function() return Game.world.music:tell() >= time end)
end

function WorldCutscene:allowLimitedInteraction()
    Game.world.limited_interaction = true
end

function WorldCutscene:disableLimitedInteraction()
    Game.world.limited_interaction = false
end

return WorldCutscene