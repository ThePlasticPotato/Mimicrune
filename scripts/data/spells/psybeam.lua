local spell, super = Class(Spell, "psybeam")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Psybeam"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Psychic Damage"

    -- Menu description
    self.description = "Sends a beam of psychic power ripping through\none foe. Depends on Attack & Magic."

    -- TP cost
    self.cost = 0
    self.pcost = 50
    self.pheat = 10

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    self.cast_anim = "psybeam"
    self.select_anim = "psybeamready"

    -- Tags that apply to this spell
    self.tags = {"psy", "damage"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:getNPCost(chara)
    local cost = super.getNPCost(self, chara)
    if chara and chara:checkWeapon("promisering") then
        cost = cost - 10
    end
    return cost
end

function spell:onCast(user, target)
    local buster_finished = false
    local anim_finished = false
    local function finishAnim()
        anim_finished = true
        if buster_finished then
            Game.battle:finishAction()
        end
    end
    if not user:setAnimation("battle/psybeam", finishAnim) then
        anim_finished = false
        user:setAnimation("battle/attack", finishAnim)
    end
    Game.battle.timer:after(15/30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = RudeBusterBeam(false, x, y, tx, ty, function(pressed)
            local damage = self:getDamage(user, target, pressed)
            if pressed then
                Assets.playSound("scytheburst")
            end
            target:flash()
            target:hurt(damage, user)
            buster_finished = true
            if anim_finished then
                Game.battle:finishAction()
            end
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)
    end)
    return false
end

function spell:getDamage(user, target, pressed)
    local damage = math.ceil((user.chara:getStat("magic") * 6) + (user.chara:getStat("attack") * 12) - (target.defense * 3))
    if pressed then
        damage = damage + 30
    end
    return damage
end

return spell