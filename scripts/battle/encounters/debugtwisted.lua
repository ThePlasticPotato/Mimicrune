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

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")

    self.tense = true
end

return DebugTwisted