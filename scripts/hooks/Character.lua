---@class Character : Object
---@field sitting boolean
---@field seat Sittable
---@field pathing boolean
local Character, super = Utils.hookScript(Character)

function Character:init(actor, x, y)
    super.init(self, actor, x, y)
    self.sitting = false
    self.seat = nil
    self.pathing = false
    self.should_sit = false
end

function Character:update()
    super.update(self)
    if (not self.should_sit and self.sitting) then
        self.seat:trySitting(self, self.facing, true)
    end
end

---@param original Sittable
---@param dir string
function Character:attemptSit(original, dir)
    if (self.sitting and self.seat and self.seat.trySitting) then
        self.seat:trySitting(self, self.facing, true)
        if (self.returnToFollowing) then self:returnToFollowing(4) end
        return true
    end
    local sittables = Utils.filter(Game.world.map:getEvents(nil), function (v)
        if (v.trySitting and v.occupied ~= true and v ~= original) then return true end
        return false
    end)
    local closest_valid = nil
    local best_score = 9999
    for index, value in ipairs(sittables) do
        local score = 0
        local distance_from_original = Utils.dist(original.x, original.y, value.x, value.y)
        score = score + distance_from_original
        local distance_from_me = Utils.dist(self.x, self.y, value.x, value.y)
        score = score + distance_from_me
        local facing_bonus = value.facing == original.facing and -100 or 0
        score = score + facing_bonus
        if (score < best_score) then
            closest_valid = value
            best_score = score
        end
    end
    if (closest_valid) then
        local distance_from_me = Utils.dist(self.x, self.y, closest_valid.x, closest_valid.y)
        if (distance_from_me > Game.world:getPathfinderNodeSize() + 1) then
            self:pathfindTo(closest_valid.x, closest_valid.y, {speed = 8, refollow = false, after = function () closest_valid:trySitting(self, self.facing, true) end })
        else
            closest_valid:trySitting(self, self.facing, true)
        end
    end

    return false
end

function Character:pathfindTo(x, y, options)
    self.following = false
    local current_node = Game.world:getNearestNode(self.x, self.y)
    local target_node = Game.world:getNearestValidNode(x, y)
    local path = Game.world:findPathTo(current_node[1], current_node[2], target_node[1], target_node[2], self.collider)
    if (#path == 0) then
        if (self.returnToFollowing) then self:returnToFollowing(4) end
        Kristal.Console:log("Pathfinding failed! Returning...")
        return false
    end
    self.pathing = true
    Kristal.Console:log("Found a path that is " ..#path.." nodes long! Pathfinding...")
    self:walkPath(path, { speed = options and options.speed or 6, loop = false, relative = false, after = function ()
        self.pathing = false
        if options and options.after then options.after() end
        Kristal.Console:log("Pathfinding complete! Arrived at target destination.")
        end }
    )
    return true
end

function Character:draw()
    if DEBUG_RENDER then
        local node = Game.world:getNearestNode(self.x, self.y)
        local neighbors = Game.world:getValidNeighbors(node[1], node[2], self.collider)
        Draw.setColor(1, 1, 1, 0.5)
        for index, value in ipairs(neighbors) do
            local sprite = Assets.getTexture("effects/restoration")
            local world_pos = Game.world:nodePosToWorld(value[1], value[2])
            local relative_x = self.x - world_pos[1]
            local relative_y = self.y - world_pos[2]
            Draw.draw(sprite, relative_x, relative_y, nil, nil, nil, 0.5, 0.5)
        end
        Draw.setColor(1,1,1,1)
    end
    super.draw(self)
end

return Character