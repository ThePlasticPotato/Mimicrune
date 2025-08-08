---@class Map
---@field soul_collision table<Hitbox>
---@field pushable_collision table<Hitbox>
local Map, super = Utils.hookScript(Map)

function Map:init(world, data)
    super.init(self, world, data)
    self.soul_collision = {}
    self.pushable_collision = {}
end

function Map:loadLayer(layer, depth)
    super.loadLayer(self, layer, depth)
    if layer.type == "objectgroup" then
        if Utils.startsWith(layer.name:lower(), "collision") and Utils.endsWith(layer.name:lower(), "soul") then
            self:loadSoulCollision(layer)
        end
        if Utils.startsWith(layer.name:lower(), "pushableCollision") then
            self:loadPushableCollision(layer)
        end
    end
end

function Map:loadSoulCollision(layer)
    Utils.merge(self.soul_collision, self:loadHitboxes(layer))
end

function Map:loadPushableCollision(layer)
    Utils.merge(self.pushable_collision, self:loadHitboxes(layer))
end

return Map