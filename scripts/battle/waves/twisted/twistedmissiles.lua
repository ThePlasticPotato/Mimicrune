local TwistedMissiles, super = Class(Wave)

function TwistedMissiles:init()
  super.init(self)

  -- The duration of our wave, in seconds. (Defaults to `5`)
  self.time = 100

  self.missiles_fired = 0
  self.missiles_to_fire = MathUtils.randomInt(2, 5)
  self.missiles_exploded = 0
  self.cooldown = 0
  self.missiles = {}
  self.targeting = false
  self.targeting_done = false
  self.target_sprite = Sprite("bullets/partytarget_twisted", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
  self.target_sprite:setOrigin(0.5, 0.5)
  self.target_sprite:setScale(2,2)
  self.target_sprite:setLayer(BATTLE_LAYERS["below_soul"])
  self.target_sprite.visible = false
  Game.battle:addChild(self.target_sprite)
  self.target_x = 0
  self.target_y = 0
  self.target_blinker = 0
  self.rampup = 1

  self.celebracean = self:getAttackers()[1]
end

function TwistedMissiles:onStart()
  self.target_x = SCREEN_WIDTH / 2
  self.target_y = SCREEN_HEIGHT / 2
  self.timer:after(0.125, function () self:startTargeting() end)
end

function TwistedMissiles:startTargeting()
  self.targeting = true
  Assets.playSound("targetlock")
  self.timer:after(2.5, function () self.targeting_done = true; self.targeting = false end)
end

function TwistedMissiles:fireMissile()
  Assets.playSound("partylaunch")
  local missile = self:spawnBullet("partymissile", self.celebracean.x + 4, self.celebracean.y - 32, "", math.pi * 1.5, 1, {self.target_x, self.target_y}, self)
  local oglayer = missile.layer
  missile.layer = self.celebracean.layer - 1
  self.timer:after(0.25, function () missile.layer = oglayer end)
  missile.remove_offscreen = false
  table.insert(self.missiles, #self.missiles + 1, missile)
  self.missiles_fired = self.missiles_fired + 1
end

function TwistedMissiles:explodeMissile(missile)
  missile.exploded = true
  missile:remove()
  self.missiles_exploded = self.missiles_exploded + 1
  
  Assets.playSound("bomb")
  Game.battle:shakeCamera(4, 4)
  local plosion = self:spawnBullet("circlesplosion", missile.target_x, missile.target_y)
  plosion.layer = plosion.layer + 10
  for x = 1, 8 do
    local angle = math.rad((x - 1) * (360 / 8))
    self:spawnBullet("agonyblob", missile.target_x, missile.target_y, angle, 12)
  end
end

function TwistedMissiles:update()
  if (self.cooldown > 0) then
    self.cooldown = self.cooldown - DT
  end
  self.target_blinker = self.target_blinker + DTMULT * self.rampup
  if (self.targeting) then
    self.rampup = self.rampup + DT
    self.target_sprite.visible = true --(math.floor(self.target_blinker) % 2) == 0
    self.target_sprite.x = MathUtils.approach(self.target_sprite.x, Game.battle.soul.x, DTMULT * self.rampup)
    self.target_sprite.y = MathUtils.approach(self.target_sprite.y, Game.battle.soul.y, DTMULT * self.rampup)
    self.target_sprite.rotation = MathUtils.wrap(self.target_sprite.rotation + DT * self.rampup, 0, 2 * math.pi)
  end

  if (self.targeting_done) then
    self.target_x = self.target_sprite.x
    self.rampup = 1
    self.target_y = self.target_sprite.y
    self.target_sprite.visible = true
    self.target_sprite:flash()
    self.targeting_done = false
    local afterimage = AfterImage(self.target_sprite, 0.5, 0.01)
    self.target_sprite:addChild(afterimage)
    Assets.playSound("icky")
    self.celebracean:setAnimation("volley", function() self:fireMissile(); self.timer:after(0.5, function () self.celebracean:resetSprite() end) end)
    self.cooldown = 0.25
  end

  if (not self.targeting) and (not self.targeting_done) and (self.missiles_fired < self.missiles_to_fire) then
    if (self.cooldown <= 0) then
      self.cooldown = 0
      self:startTargeting()
    end
  end

  if (self.missiles_fired >= self.missiles_to_fire) and (not self.targeting) and (not self.targeting_done) then
    self.target_sprite.visible = false
  end

  if (self.missiles_fired == self.missiles_exploded) and (self.missiles_exploded == self.missiles_to_fire+1) then
    self.timer:after(2, function () self:setFinished() end)
  end
  super.update(self)
end

function TwistedMissiles:beforeEnd()
  self.target_sprite:remove()
  super.beforeEnd(self)
end

return TwistedMissiles