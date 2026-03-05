local FirstTwisted, super = Class(Encounter)

function FirstTwisted:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* [color:lime]Tension[color:reset] rising.\n* [color:yellow]Mercy[color:reset] is unavailable."

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = false
    self.hide_world = true

    self:addEnemy("twisted/prototype")
    self:addEnemy("twisted/celebracean")

    self.tense = true
end

function FirstTwisted:getVictoryText(text, money, xp)
    if (Game.battle.purified >= 2) then
        Game.battle.music:stop()
        Assets.playSound("DEVICE_MESSAGE")
        return "* You win...?"
    end
    return text
end

return FirstTwisted