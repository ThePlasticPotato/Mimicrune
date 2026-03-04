local TwistedPizzaWheel, super = Class(Wave)

function TwistedPizzaWheel:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 12

    --reminder:
    -- mic falls, hits ground with mic hit sound, bursts into notes and a beam upwards
    self.wave_timer = 0

    self.targeted_side = nil
    self.warned = false
    self.warning_sprite_top = Sprite("effects/warning_half")
    self.warning_sprite_bot = Sprite("effects/warning_half")
    self.warning_sprite_top.layer = BATTLE_LAYERS["below_soul"]
    self.warning_sprite_bot.layer = BATTLE_LAYERS["below_soul"]
    self.warning_sprite_top.visible = false
    self.warning_sprite_bot.visible = false
    Game.battle:addChild(self.warning_sprite_top)
    Game.battle:addChild(self.warning_sprite_bot)
    self.can_spawn = true
end

function TwistedPizzaWheel:pizzaTime()
    if not (self.can_spawn) then return end
    self.targeted_side = MathUtils.randomInt(0, 2)
    local warning_sprite = (self.targeted_side == 0) and self.warning_sprite_top or self.warning_sprite_bot
    Assets.playSound("alert")
    Assets.playSound("oventimer", 0.75)

    local _, center_y = Game.battle.arena:getCenter()

    local offset = (self.targeted_side == 0) and -38 or 38
    local blink_timer = 0

    self.timer:during(2, function()
        blink_timer = blink_timer + DTMULT
        warning_sprite.visible = math.floor(blink_timer) % 2 == 0
    end, function()
        warning_sprite.visible = false
        self:spawnBullet("pizzawheel", SCREEN_WIDTH + 74, center_y + offset)
    end)
end


function TwistedPizzaWheel:onStart()
    self.warning_sprite_top.x = Game.battle.arena:getLeft() + 1
    self.warning_sprite_bot.x = Game.battle.arena:getLeft() + 1
    self.warning_sprite_top.y = Game.battle.arena:getTop() + 1
    _, self.warning_sprite_bot.y = Game.battle.arena:getCenter()
    self.warning_sprite_bot.y = self.warning_sprite_bot.y + 1
    self.timer:after(0.5, function()
        self:pizzaTime()
    end)
end

function TwistedPizzaWheel:update()
    super.update(self)
    self.wave_timer = self.wave_timer + DT
    if (self.wave_timer >= 11.5) then
        self.can_spawn = false
    end
end

function TwistedPizzaWheel:beforeEnd()
    self.warning_sprite_top:remove()
    self.warning_sprite_bot:remove()
end

return TwistedPizzaWheel