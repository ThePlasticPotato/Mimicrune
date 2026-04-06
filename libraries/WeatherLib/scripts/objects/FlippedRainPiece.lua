
-- CUSTOM WEATHER PIECE "TUTORIAL"

local FlippedRainPiece, super = Class("CustomWeatherPiece")

function FlippedRainPiece:init(path, sprite, x, y, speed, handler)
    super.init(self, path, sprite, x, y, speed, handler)

    self.sprite = Sprite(path.."/"..sprite)
    self.sprite:setScale(2)
    self.sprite.inherit_color = true

    self:setPosition(self.x, self.y - (self.sprite.height * 2))
    
    self.blend_mode = "add"
    self.alpha = 0.4

    self.offscreen_sides = {"bottom", "right"} -- the sides of the screen where the weather piece is considered "offscreen"

    self.splash_point = PointCollider(self, self.sprite.width * 2, self.sprite.height * 2)
    self.splash_travel = math.random(SCREEN_HEIGHT * 0.05, SCREEN_HEIGHT * 0.95)
    self.splash_checked = false
end

function FlippedRainPiece:handleMovement()
    self.x, self.y = self.x + self.speed * 0.5 * DTMULT, self.y + self.speed * DTMULT

    -- One-time walkability check at a random depth into the screen
    if not self.splash_checked and self.y - self.inity >= self.splash_travel then
        self.splash_checked = true
        if self:spawnSplashIfWalkable() then
            self:remove()
            return
        end
    end

    if self.y - self.inity > (Game.world.map.height * Game.world.map.tile_height) + 120 then
        MathUtils.approach(self.alpha, 0, DTMULT)
        if self.alpha < 0.5 then self:remove() end
    end
end

function FlippedRainPiece:spawnSplashIfWalkable()
    if self.addto ~= Game.world then return false end
    if not (Game.world and Game.world.map) then return false end
    if (Game.world.map.inside) then return false end
    if not Game.world:inBounds(self.x, self.y) then return false end
    -- if Game.world:checkCollision(self.splash_point, false) then
    --     return false
    -- end
    local tile = Game.world:getSteppableTile(self.x, self.y)
    if tile then
        local splashsize = 1
        if tile["step_sound"] then
            local sound = tile["step_sound"]
            local randpitch = MathUtils.random(-0.15, 0.15)
            if sound and StringUtils.contains(sound, "glass") then
                Assets.playSound("step/heavyglass" .. MathUtils.randomInt(1,3), 0.1, 1 + randpitch)
                splashsize = 2
            end
        end
        local splash = RainSplash(self.x, self.y, self.addto, splashsize)
        self.addto:addChild(splash)
        splash:setLayer(self.layer + 1)
        return true
    end
    return false
end

function FlippedRainPiece:onOffscreen()
    self:remove()
end

return FlippedRainPiece