local SoundWave, super = Class(Bullet)

function SoundWave:init(x, y, dir)
    -- Last argument = sprite path
    super.init(self, x, y, (Game.battle.tense) and ("bullets/soundwave_twisted") or "bullets/soundwave")

    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = Game.battle.tense and 16 or 12
    self.rotation = dir
    self.destroy_on_hit = false
    self.physics.match_rotation = true
    self.max_bounces = Game.battle.tense and 4 or 2
    self.bounces = 0
    
    self.afterimg_timer = 0
    self.remove_offscreen = true
    self.has_entered_arena = false
    if (Game.battle.tense) then
        self:addFX(ShaderFX("kinoglitch", { ["iTime"] = function () return Kristal.getTime() end, ["scan_line_jitter"] = function () return 0.015 * (5 / 10) end, ["horizontal_shake"] = function () return 0.005 * (5 / 10) end }, false), "glitchy")
    end
    self.last_bounced = "none"

    self.parry = true
end

---half vibecoded slop yippee
function SoundWave:reflectAngle(angle, nx, ny)
    local dx, dy = math.cos(angle), math.sin(angle)

    local nlen = math.sqrt(nx*nx + ny*ny)
    if nlen == 0 then
        return angle, dx, dy
    end
    local nnx, nny = nx / nlen, ny / nlen

    local dot = dx*nnx + dy*nny
    local rx = dx - 2 * dot * nnx
    local ry = dy - 2 * dot * nny

    local newAngle = math.atan2(ry, rx)
    return newAngle, rx, ry
end

function SoundWave:update()
    self.afterimg_timer = self.afterimg_timer - DT
    if (self.afterimg_timer <= 0) then
        local afterimage = AfterImage(self, 0.5)
        self:addChild(afterimage)
        self.afterimg_timer = 0.075
    end

    if (self.bounces < self.max_bounces) and self.has_entered_arena then
        if (Game.battle.arena:collidesWith(self)) then
            self.bounces = self.bounces + 1

            ---@param facing string
            ---@return table<number, number>
            local function getWallFromFacingInward(facing)
                local center_x, center_y = Game.battle.arena:getCenter()
                if (facing == "right") then
                    return { Game.battle.arena:getLeft(), center_y }
                elseif (facing == "left") then
                    return { Game.battle.arena:getRight(), center_y }
                elseif (facing == "up") then
                    return { center_x, Game.battle.arena:getBottom() }
                else
                    return { center_x, Game.battle.arena:getTop() }
                end
            end

            local closestWallFacing = "right"
            local score = 99999999
            for i = 1, 4 do
                local effective_direction = Utils.facingFromAngle((math.pi / 2) * i)
                local wall_center = getWallFromFacingInward(effective_direction)
                local distance = MathUtils.dist(self.x + self.width / 2, self.y + self.height / 2, wall_center[1], wall_center[2])
                if distance < score then
                    closestWallFacing = effective_direction
                    score = distance
                end
            end
            if (self.last_bounced == closestWallFacing) then
                return
            end

            local nx, ny = Utils.getFacingVector(closestWallFacing)
            self.rotation = self:reflectAngle(self.rotation, nx, ny)
            Assets.playSound("metalhit", 0.85, Game.battle.tense and 0.75 or 1)
            self.sprite:flash()
            self.last_bounced = closestWallFacing
        end       
    end
    if not self.has_entered_arena then
        local arena_min_x, arena_min_y = Game.battle.arena:getTopLeft()
        local arena_max_x, arena_max_y = Game.battle.arena:getBottomRight()
        if (self.x < arena_max_x and self.x > arena_min_x) and (self.y < arena_max_y and self.y > arena_min_y) and not (Game.battle.arena:collidesWith(self)) then
            self.has_entered_arena = true
        end
    end
    super.update(self)
end

function SoundWave:reboundOffSoul(soul)
    if (self.bounces < self.max_bounces) and self.has_entered_arena then
        self.bounces = self.bounces + 1
        local ang = MathUtils.angle(soul.x, soul.y, self.x + self.width/2, self.y + self.height/2)
        local approx_nx, approx_ny = Utils.getFacingVector(Utils.facingFromAngle(ang))
        self.rotation = self:reflectAngle(self.rotation, approx_nx, approx_ny)
        Assets.playSound("michit", 0.85, Game.battle.tense and 0.75 or 1)
        self.sprite:flash()
    end
end

function SoundWave:onCollide(soul)
    super.onCollide(self, soul)
    self:reboundOffSoul(soul)
end

function SoundWave:onParry(soul)
    super.onParry(self, soul)
    self:reboundOffSoul(soul)
end


return SoundWave