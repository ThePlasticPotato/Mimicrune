function Mod:init()
    Assets.newShader("glitch")
    Assets.newShader("crt")
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(new_file)
    if new_file then
        Game:setFlag("has_cell_phone", true)
        Game.world:registerCall("test", nil)
        Game.world:startCutscene("connection", "intro_transition")
    end
end