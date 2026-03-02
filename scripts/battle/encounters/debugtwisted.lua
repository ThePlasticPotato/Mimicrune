local DebugTwisted, super = Class(Encounter)

function DebugTwisted:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* [color:lime]Tension[color:reset] rising.\n* [color:yellow]Mercy[color:reset] is unavailable."

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = false
    self.hide_world = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("twisted/prototype")
    self:addEnemy("twisted/celebracean")

    self.tense = true
end

function DebugTwisted:getVictoryText(text, money, xp)
    if (Game.battle.purified >= 2) then
        Game.battle.music:stop()
        Assets.playSound("DEVICE_MESSAGE")
        return "* You win...?"
    end
    return text
end

-- function DebugTwisted:getNextWaves()
--     local any_enemy_harmonize, any_enemy_selected_pillar = false, false
--     for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
--         if enemy.id == "twisted/prototype" and enemy ~= self then
--             if not any_enemy_harmonize and enemy.harmonize then any_enemy_harmonize = true end
--             if not any_enemy_selected_pillar and enemy.selected_wave == "organikk/pillars" then any_enemy_selected_pillar = true end
--             if any_enemy_harmonize and any_enemy_selected_pillar then break end
--         end
--     end

--     if self.harmonize then
--         return {"organikk/bar_harmonize"}
--     elseif any_enemy_harmonize then
--         return {"organikk/nothing"}
--     elseif any_enemy_selected_pillar then
--         return {"organikk/bar"}
--     else
--         return self.waves
--     end
-- end
return DebugTwisted