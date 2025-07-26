local Bullet, super = Utils.hookScript(Bullet)

function Bullet:init(x, y, texture)
    super.init(self, x, y, texture)
    self.parry = false
end

function Bullet:onCollide(soul)
    if soul.parry_timer > 0 and self:canParry() then
        Assets.playSound("metalhit", 1.5, 1.5)
        Game:giveTension(8)
        soul.parry_timer = 0
        soul.parry_cd = math.min(soul.parry_cd, 0.75)
        soul.parry_draw_timer = 1.0
        soul.inv_timer = self.inv_timer/2.0
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
    local party_leader = Game.battle.party[1]
    local evan_present = party_leader.chara.name == "Evan"
    local evan_down = party_leader.is_down
    return self.parry and evan_present and not evan_down
end

return Bullet