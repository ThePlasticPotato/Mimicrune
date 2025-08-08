---@class World
---@field world_soul WorldSoul
local World, super = Utils.hookScript(World)

function World:init(map)
    super.init(self, map)
    self.world_soul = nil
end

--- Gets the collision map for the world
---@return Collider[]
function World:getSoulCollision()
    local col = {}
    for _,collider in ipairs(self.map.soul_collision) do
        table.insert(col, collider)
    end
    for _,child in ipairs(self.children) do
        if child.collider and child.solid then
            table.insert(col, child.collider)
        end
    end
    return col
end

--- Checks whether the input `collider` is colliding with anything in the world
---@param collider      Collider    The collider to check collision for
---@return boolean  collided    Whether a collision was found
---@return Object?  with        The object that was collided with
function World:checkSoulCollision(collider)
    Object.startCache()
    for _,other in ipairs(self:getSoulCollision()) do
        if collider:collidesWith(other) and collider ~= other then
            Object.endCache()
            return true, other.parent
        end
    end
    Object.endCache()
    return false
end

function World:onKeyPressed(key)
    super.onKeyPressed(self, key)
    if self.state == "GAMEPLAY" then
        if Input.isConfirm(key) and self.world_soul and self.world_soul.is_active then
            if self.world_soul:interact() then
                Input.clear("confirm")
            end
        end
    end
end

return World