---@class TwistedClaw : Sprite
local TwistedClaw, super = Class(Sprite)

function TwistedClaw:init(x, y, right, wave)
    super.init(self, "bullets/twistedclaw_open", x, y)
    self.wave = wave
    self.flip_x = right == 1

    Assets.playSound("clopen")
    self.magnetizing = false
    self:setAnimation({"bullets/twistedclaw_open", 0.09, false, ["callback"] = function (sprite) self.wave:startMagnet() ; Assets.playSound("clhiss"); self.magnetizing = true end})
    self.magnet_circles = {}
    self.circle_timer = 0
end

function TwistedClaw:snap()
    Assets.playSound("clhiss")
    self.magnetizing = false
    self:setAnimation({"bullets/twistedclaw_snap", 0.09, false, ["callback"] = function (sprite) self.wave:endSnap(); Assets.playSound("clsnap"); self:setAnimation({"bullets/twistedclaw_postsnap", 0.09, false}) end})
end

function TwistedClaw:retract()
    Assets.playSound("clleave")
    self:setAnimation({"bullets/twistedclaw_leave", 0.09, false, ["callback"] = function (sprite) self.wave:onClawLeave(); self:remove() end})
end

function TwistedClaw:update()
    super.update(self)
    if (self.magnetizing) then
        if (self.circle_timer <= 0) then
            self.circle_timer = 0.25
            local magnet_circle = {
                ["radius"] = 50,
                ["alpha"] = 0
            }
            table.insert(self.magnet_circles, #self.magnet_circles + 1, magnet_circle)
        else
            self.circle_timer = self.circle_timer - DT
        end
    end
    local to_remove = {}
    for i, magnet in ipairs(self.magnet_circles) do
        magnet.radius = magnet.radius - DTMULT * 2
        magnet.alpha = math.max(math.min((50 - magnet.radius) / 50, 0.95), 0)
        if (magnet.radius <= 0) then
            table.insert(to_remove, magnet)
        end
    end
    for _, mag in ipairs(to_remove) do
        TableUtils.removeValue(self.magnet_circles, mag)
    end
end

function TwistedClaw:draw()
    super.draw(self)
    if (self.magnetizing) then
        love.graphics.setLineWidth(2)
        for _, magnet_circle in ipairs(self.magnet_circles) do
            Draw.setColor(0.5,0.5,0.5, magnet_circle.alpha)
            love.graphics.ellipse("line", 103, 78, magnet_circle.radius, magnet_circle.radius)
        end
        Draw.setColor(1,1,1,1)
    end
end

return TwistedClaw