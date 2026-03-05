local TwistedClawgnet, super = Class(Wave)

function TwistedClawgnet:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 999

    --reminder:
    -- mic falls, hits ground with mic hit sound, bursts into notes and a beam upwards
    self.wave_timer = 0
    self.claw_side = 0
    self:setArenaSize(240, 82)
    self.left_claw = nil
    self.right_claw = nil
    self.magnet_strength = 0

    self.bullet_timer = 0
    self.bullets_fired = 0
    self.safe_bullets = 0
    self.perfect_bullets = 0
    self.finished_bullets = 0

    self.celebracean = self:getAttackers()[1] or Game.battle.enemies[2]
    self.original_x = self.celebracean.x
    self.original_y = self.celebracean.y

    self.og_top_left = {0, 0}
    self.og_top_right = {0, 0}
    self.og_bot_left = {0, 0}
    self.og_bot_right = {0, 0}
    self.og_center = {0, 0}

    self.current_top_left = {0,0}
    self.current_top_right = {0,0}
    self.current_bot_left = {0,0}
    self.current_bot_right = {0,0}

    self.solo = true
end

function TwistedClawgnet:startMagnet()
    local magnetsound = Assets.playSound("clmagnet")
    local center_y = self.og_center[2]
    local bullet_target = { ["x"] = (self.claw_side < 1) and (self.og_top_left[1] + 28) or (self.og_top_right[1] - 28), ["y"] = center_y }
    local current_claw = (self.claw_side < 1) and self.left_claw or self.right_claw
    if (self.claw_side < 1) then Game.battle.arena:shake(2,2) else Game.battle.arena:shake(-2, 2) end
    local last_spawn_y = 0
    self.timer:doWhile(function () return magnetsound:isPlaying() end, function()
        self.magnet_strength = MathUtils.approach(self.magnet_strength, 3, DTMULT / 4)
        if (self.magnet_strength >= 2.99) then
            self.magnet_strength = MathUtils.approach(self.magnet_strength, 4.25, DTMULT / 8)
        end
        if (self.claw_side < 1) then
            self.current_top_left = {self.current_top_left[1], MathUtils.approach(self.current_top_left[2], self.og_top_left[2] + 20, DTMULT / 2)}
            self.current_bot_left = {self.current_bot_left[1], MathUtils.approach(self.current_bot_left[2], self.og_bot_left[2] - 20, DTMULT / 2)}
        else
            self.current_top_right = {self.current_top_right[1], MathUtils.approach(self.current_top_right[2], self.og_top_right[2] + 20, DTMULT / 2)}
            self.current_bot_right = {self.current_bot_right[1], MathUtils.approach(self.current_bot_right[2], self.og_bot_right[2] - 20, DTMULT / 2)}
        end
        Game.battle.soul:move(-1 + (self.claw_side * 2), 0, self.magnet_strength * DTMULT)
        if (self.bullet_timer <= 0) and magnetsound:isPlaying() then
            self.bullet_timer = MathUtils.random(0.25, 0.5)
            local is_safe = (MathUtils.randomInt(1, 4) == 1) or (self.safe_bullets == 0)
            if (is_safe) then self.safe_bullets = self.safe_bullets + 1 end
            local spawn_x = (self.claw_side > 0) and -10 or (SCREEN_WIDTH + 10)
            local spawn_y = (MathUtils.random(80, SCREEN_HEIGHT - 80))
            if math.abs(spawn_y - last_spawn_y) < 10 then
                spawn_y = (MathUtils.random(50, SCREEN_HEIGHT - 50))
            end
            local dir = MathUtils.angle(spawn_x, spawn_y, bullet_target.x, bullet_target.y)
            local siz = MathUtils.randomInt(4, 11)
            last_spawn_y = spawn_y
            self:spawnBullet("clawdebris", spawn_x, spawn_y, dir, 16, siz, siz, bullet_target, is_safe)
            self.bullets_fired = self.bullets_fired + 1
        else
            self.bullet_timer = self.bullet_timer - DT
        end
    end, function()

        local refcornertop = (self.claw_side < 1) and self.current_top_left or self.current_top_right
        local refcornerbot = (self.claw_side < 1) and self.current_bot_left or self.current_bot_right
        self.timer:approach(1, refcornertop[2], self.og_top_left[2], function (value) refcornertop[2] = value end, "out-back")
        self.timer:approach(1, refcornerbot[2], self.og_bot_left[2], function (value) refcornerbot[2] = value end, "out-back")
        self.timer:afterCond(function() return (self.bullets_fired) <= self.finished_bullets end, function()
            current_claw:snap()
        end)
    end)
end

function TwistedClawgnet:endSnap()
    Game.battle:shakeCamera(4, 4, 0.5)
    self.magnet_strength = 0
    local current_claw = (self.claw_side < 1) and self.left_claw or self.right_claw
    --spawn a bunch of debris, probably

    --also spawn a bullet to hurt the player
    local center_y = self.og_center[2]
    local plode = self:spawnBullet("circlesplosion", (self.claw_side < 1) and (self.og_top_left[1] + 28) or (self.og_top_right[1] - 28), center_y, 0, 2)

    plode.damage = 200
    self.timer:after(0.75, function () current_claw:retract() end)
end

function TwistedClawgnet:onClawLeave()
    self.claw_side = self.claw_side + 1
    if (self.claw_side >= 2) then self.timer:after(0.75, function () self:setFinished() end); return end
    ---@type TwistedClaw
    self.right_claw = TwistedClaw(0,0,self.claw_side, self)
    self.right_claw:setOrigin(1, 0.5)
    self.right_claw:setScale(2,2)
    self.right_claw.x = -self.right_claw:getScaledWidth() / 2
    self.right_claw.layer = BATTLE_LAYERS["top"]
    self.right_claw.y = self.og_center[2] - 8
    self:spawnObject(self.right_claw)
end

function TwistedClawgnet:onStart()
    local attackers = Game.battle:getActiveEnemies()
    local prototype = self.celebracean
    for i, at in ipairs(attackers) do
        if (i ~= 2) then
        at:setColor(1,1,1,0.5)
        end
    end
    prototype:slideTo(prototype.x - 40, SCREEN_HEIGHT/2, 0.5, "out-expo")

    self.og_top_left = { Game.battle.arena:getTopLeft() }
    self.og_top_right = { Game.battle.arena:getTopRight() }
    self.og_bot_left = { Game.battle.arena:getBottomLeft() }
    self.og_bot_right = { Game.battle.arena:getBottomRight() }
    self.og_center = { Game.battle.arena:getCenter() }

    self.current_top_left = { Game.battle.arena:getTopLeft() }
    self.current_top_right = { Game.battle.arena:getTopRight() }
    self.current_bot_left = { Game.battle.arena:getBottomLeft() }
    self.current_bot_right = { Game.battle.arena:getBottomRight() }

    self.timer:after(1, function()
        self.left_claw = TwistedClaw(0,0,self.claw_side, self)
        self.left_claw:setOrigin(0, 0.5)
        self.left_claw:setScale(2,2)
        self.left_claw.x = 0
        self.left_claw.y = self.og_center[2] - 8
        self.left_claw.layer = BATTLE_LAYERS["top"]
        self:spawnObject(self.left_claw)
    end)
end

function TwistedClawgnet:update()
    super.update(self)
    self.wave_timer = self.wave_timer + DT

    if (self.og_top_left[1] ~= 0) and (self.og_top_left[2] ~= 0) then
        self:setArenaShape(self.current_top_left, self.current_top_right, self.current_bot_right, self.current_bot_left)
    end
end

function TwistedClawgnet:beforeEnd()
  local attackers = Game.battle:getActiveEnemies()
  local prototype = self.celebracean
  if (self.safe_bullets == self.perfect_bullets) then
    local battler = Game.battle.party[1]
    for i, battl in ipairs(Game.battle.party) do
      if (battl:isTargeted()) then
        battler = battl
        break
      end
    end
    battler:setAnimation("battle/attack", function()
      prototype:flash()
      local damage = MathUtils.round(prototype:getAttackDamage(0, battler, 150))

      local attacksprite = battler.chara:getAttackSprite()
      local dmg_sprite = Sprite(attacksprite or "effects/attack/cut")
      dmg_sprite:setOrigin(0.5, 0.5)
      dmg_sprite:setScale(2.5, 2.5)
      local relative_pos_x, relative_pos_y = prototype:getRelativePos(prototype.width / 2, prototype.height / 2)
      dmg_sprite:setPosition(relative_pos_x + prototype.dmg_sprite_offset[1], relative_pos_y + prototype.dmg_sprite_offset[2])
      dmg_sprite.layer = prototype.layer + 0.01
      table.insert(prototype.dmg_sprites, dmg_sprite)
      local dmg_anim_speed = 1 / 15
      dmg_sprite:play(dmg_anim_speed, false, function(s) s:remove(); TableUtils.removeValue(prototype.dmg_sprites, dmg_sprite) end) -- Remove itself and Remove the dmg_sprite from the enemy's dmg_sprite table when its removed
      prototype.parent:addChild(dmg_sprite)

      battler.chara:onAttackHit(prototype, damage)

      prototype:hurt(damage, battler)
      Game:giveTension(20)
      Assets.playSound("bigcut")
      Game.battle.timer:after(0.5, function () battler:setAnimation("battle/attack_end", function() battler:resetSprite() end) end)
    end)
  end

  
  prototype:slideTo(self.original_x, self.original_y, 0.5, "out-expo")
  for i, at in ipairs(attackers) do
    if (i ~= 2) then
      at:setColor(1,1,1,1)
    end
  end
  prototype:resetSprite()
end

return TwistedClawgnet