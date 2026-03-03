local TwistedMicToss, super = Class(Wave)

function TwistedMicToss:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 12

    --reminder:
    -- mic falls, hits ground with mic hit sound, bursts into notes and a beam upwards
    self.wave_timer = 0
end

function TwistedMicToss:spawnMic(x)
end

function TwistedMicToss:explodeMic(mic)
    mic.exploded = true
    mic:remove()
    Assets.playSound("metalhit")
    self:spawnBullet("circlesplosion", mic.x, Game.battle.arena:getBottom(), 0.5, 1)
    self:spawnBullet("micbeam", mic.x, Game.battle.arena:getBottom(), 0.5)
end

function TwistedMicToss:onStart()
    self.timer:every(1, function()
        if (self.wave_timer > 8.5) then
            return false
        end
        local randx = MathUtils.random(Game.battle.arena:getLeft(), Game.battle.arena:getRight())
        local y = -20
        Assets.playSound("whip_throw_only", 0.8, 0.5)
        self:spawnBullet("fallingmic", randx, y)
    end)
end

function TwistedMicToss:update()
    super.update(self)
    self.wave_timer = self.wave_timer + DT
end

function TwistedMicToss:beforeEnd()
end

return TwistedMicToss