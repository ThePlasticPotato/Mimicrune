function Mod:init()
    Assets.newShader("glitch")
    Assets.newShader("crt")
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(new_file)
    Game.world.player.visible = false
    if (Kristal.hasAnySaves()) then
        Game.world:mapTransition("fileselect")
    else
        Game:setFlag("has_cell_phone", true)
        Game.world:startCutscene("connection", "intro_transition")
        Game:setFlag("audible_footsteps", true)
    end

end