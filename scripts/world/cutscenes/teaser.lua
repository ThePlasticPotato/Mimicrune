return {
    ---@param cutscene WorldCutscene
    teaser1 = function (cutscene, event)
        Game:setBorder("DEVICE_ERROR")
        local cassidy = cutscene:getCharacter("cassidy")
        local evan = cutscene:getCharacter("evan")
        ---@type Sprite
        local handhold = cutscene:getEvent(19)

        evan.visible = false
        cassidy.visible = false

        cutscene:panTo(SCREEN_WIDTH/2, 1200, 0)
        cutscene:wait(8) -- for prepping recording
        Assets.playSound("wind", 0.75, 1.0)
        cutscene:panTo(SCREEN_WIDTH/2, 700, 4, "in-out-cubic")
        cutscene:wait(4)
        Assets.playSound("wind", 0.75, 0.6)
        cutscene:wait(2)

        
        Game.world.music:play("teaser_240bit")
        Game.world.music:setLooping(false)
        cutscene:text("[speed:0.25][wait:5].[wait:5] .[wait:5] .[wait:5]", "fear", "evan")
        cutscene:text({"[speed:0.25][wait:4].[wait:4][face:worry_avoid] .[wait:4] .[wait:2]", "[speed:0.25][face:worry_side][shake:1]I[shake:0][wait:2][face:worry_side_smile]-It'll be [shake:1]fine[shake:0].[wait:2] [face:worry]We'll[wait:4].[wait:2].[face:worry_avoid][wait:2].[wait:2] [face:worry_side_smile]be [shake:1]okay[shake:0].[wait:4]"}, "worry", "cassidy")
        cutscene:wait(1)
        cutscene:text("[speed:0.25].[wait:2] .[wait:2] .[wait:2] [face:worry_side_smile][shake:1]R[shake:0]-Right.[wait:5][face:worry_side][wait:2][face:worry][wait:4]", "worry_side", "evan")
        cutscene:text("[speed:0.25][wait:8].[face:worry_side][wait:8][face:worry_avoid] .[wait:8] .[wait:8]", "worry_side_smile", "cassidy")
        handhold:setSprite("party/evan/dark/cutscene/now_and_forever")
        handhold:play(0.25, false)
        cutscene:musicWait(20)
        cutscene:panTo(SCREEN_WIDTH/2, 0, 12, "in-out-cubic")

        cutscene:musicWait(35)
        cutscene:fadeOut(4)
    end

}