local TwistedPopper, super = Class(Wave)

function TwistedPopper:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 15

    --reminder:
    -- mic falls, hits ground with mic hit sound, bursts into notes and a beam upwards
    self.wave_timer = 0
    self.worm = nil
end

function TwistedPopper:spawnWorm(x, y, dir, segments, target)
    segments = segments or 1
    dir = dir or 0
    target = target or Game.battle.soul

    self.worm = {}
    local head = self:spawnBullet("agonyinfestation", x, y, dir, 0, "head", target, nil)
    local lastsegment = head
    table.insert(self.worm, 1, head)
    local lastindex = 1
    for i = 1, segments do
        local segment = self:spawnBullet("agonyinfestation", x, y, dir, 0, "body", target, lastsegment)
        lastsegment = segment
        table.insert(self.worm, i + 1, segment)
        lastindex = i + 1
    end
    local tail = self:spawnBullet("agonyinfestation", x, y, dir, 0, "tail", target, lastsegment)
    table.insert(self.worm, lastindex + 1, tail)

    self.timer:after(1, function () head.should_turn = true end)
end


function TwistedPopper:onStart()
    local popper = self:spawnBullet("partypopper", Game.battle.arena:getRight() + 26, Game.battle.arena:getBottom() + 26)
    self.timer:after(2.05, function() popper:popper() end)
    --self.timer:after(1, function() self:spawnWorm(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 0, 3, Game.battle.soul) end)
end

function TwistedPopper:update()
    super.update(self)
    self.wave_timer = self.wave_timer + DT
end

function TwistedPopper:beforeEnd()
end

return TwistedPopper