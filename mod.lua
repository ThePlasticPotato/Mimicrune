function Mod:init()
    Assets.newShader("glitch")
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(new_file)
    if new_file then
        Game.world:startCutscene("connection", "connection_established")
        Game.world.player.visible = false
    end
end