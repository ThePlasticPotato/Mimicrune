local Bullet, super = Utils.hookScript(Bullet)

function Bullet:onCollide(soul)
    if soul.parry_timer > 0 and self:canParry() then
        Assets.playSound("metalhit", 1.5, 1.5)
        Game:giveTension(10)
        soul.parry_timer = 0
        soul.parry_cd = math.min(soul.parry_cd, 0.75)
        soul.parry_draw_timer = 1.0
        soul.inv_timer = self.inv_timer
    else
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    end

    if self.destroy_on_hit then
        self:remove()
    end
end

function Bullet:canParry()
    return true
end

return Bullet