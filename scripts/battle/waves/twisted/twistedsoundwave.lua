local TwistedSoundWave, super = Class(Wave)

function TwistedSoundWave:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 12

    --reminder:
    -- mic falls, hits ground with mic hit sound, bursts into notes and a beam upwards
    self.wave_timer = 0

    self.prototype = self:getAttackers()[1]
end

function TwistedSoundWave:onStart()
    self.timer:every(2, function()
        if (self.wave_timer > 11.5) then
            return false
        end

        local start_x = self.prototype.x - 5
        local start_y = self.prototype.y - (self.prototype.height * 3 / 4)
        local angle = MathUtils.angle(start_x, start_y, Game.battle.soul.x, Game.battle.soul.y)
        local picked = TableUtils.pick({"center", "up", "down"})
        local pitch = (picked == "center") and 0.7 or (picked == "up") and 0.9 or 0.5
        self.prototype:setAnimation("note_"..picked)
        --self.prototype:flash()
        Assets.playSound("voice/twstproto", 0.8, pitch)
        self:spawnBullet("soundwave", start_x, start_y, angle)
    end)
end

function TwistedSoundWave:update()
    super.update(self)
    self.wave_timer = self.wave_timer + DT
end

function TwistedSoundWave:beforeEnd()
end

return TwistedSoundWave