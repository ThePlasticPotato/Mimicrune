return function(cutscene)
    Game.legend.music:play("drlegend")
    cutscene:setSpeed(1 / 2.1)

    ---SLIDE #1---------------------------------------------------------------------------------------
    local first = cutscene:slide("legend/deltarune/1")
    first:setScale(2, 2)
    first.x = 123
    first.y = 59
    Game.stage.timer:tween(17, first, { y = -442 }, 'linear')
    local dialogue1 = cutscene:text("Once upon a time,a LEGEND\nwas whispered among shadows.", "left")
    dialogue1.state.typing_sound = "ralsei"
    cutscene:wait(7)
    cutscene:removeText()
    cutscene:text("It was\na LEGEND\nof HOPE.", "far_left") 
    local dialogue2b = cutscene:text("It was\na LEGEND\nof DREAMS.", "far_right")
    dialogue2b.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    cutscene:text("It was\na LEGEND\nof LIGHT.", "far_left")
    local dialogue3b = cutscene:text("It was\na LEGEND\nof DARK.", "far_right")
    dialogue3b.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    local dialogue4 = cutscene:text("This is the legend of\n[wait:15]     DELTA RUNE", "left")
    dialogue4.state.typing_sound = "ralsei"
    cutscene:wait(6.5)
    cutscene:removeText()
    cutscene:removeSlides()
    cutscene:wait(1.5)

    ---SLIDE #2---------------------------------------------------------------------------------------
    local second_a = cutscene:slide("legend/deltarune/2/2a")
    second_a:setScale(2, 2)
    second_a.x = 123
    second_a.y = 59
    local dialogue5 = cutscene:text("For millenia, LIGHT and DARK\nhave lived in balance,", "far_left")
    dialogue5.state.typing_sound = "ralsei"
    cutscene:wait(4.5)
    cutscene:removeText()
    local dialogue5b = cutscene:text("Bringing peace to the WORLD,", "far_left")
    dialogue5b.state.typing_sound = "ralsei"
    cutscene:wait(3.5)
    cutscene:removeText()
    local second_b = cutscene:slide("legend/deltarune/2/2b")
    second_b:setScale(2, 2)
    second_b.x = 123
    second_b.y = 59
    local dialogue5c = cutscene:text("But if this harmony \nwere to shatter....", "left")
    dialogue5c.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeSlides()
    cutscene:removeText()
    local dialogue6 = cutscene:text("A terrible calamity would occur.", "left")
    dialogue6.state.typing_sound = "ralsei"
    dialogue6.x= 80
    dialogue6.y= 136
    cutscene:wait(4.5)
    cutscene:removeText()
    --THIS EFFECT OF FADER IS THE "WHITE SCREEN" TRANSITION, THIS IS A FADE OUT, YOULL NEED TO DEFINE THE FADE IN TO CONTINUE THE CUTSCENE
    Game.legend.fader:fadeOut(function() 
        cutscene:removeSlides()  
    end, { speed = 1, color = { 1, 1, 1 }, music = false }) 
    Game.legend.cover.visible = false --THIS WILL DISABLE THE BLACK "COVERS" , IN ORDER TO MAKE THE SCREEN BIGGER FOR A BIGGER SLIDE
    cutscene:wait(1.5)
    
    ---SLIDE #3---------------------------------------------------------------------------------------
    local third = cutscene:slide("legend/deltarune/3")
    third:setScale(2, 2)
    Game.legend.fader:fadeIn(nil, { speed = 1, color = { 1, 1, 1 } }) -- THE FADE IN
    local dialogue7 = cutscene:text("The sky will run\nblack with terror.", "middle_bottom")
    dialogue7.state.typing_sound = "ralsei"
    cutscene:wait(5)
    cutscene:removeText()
    local dialogue8 = cutscene:text("And the land will\ncrack with fear.", "middle_bottom")
    dialogue8.state.typing_sound = "ralsei"
    cutscene:wait(5)
    cutscene:removeText()
    local dialogue9 = cutscene:text("Then,[wait:5] her heart pounding...", "left_bottom")
    dialogue9.state.typing_sound = "ralsei"
    cutscene:wait(5)
    cutscene:removeText()
    local dialogue10 = cutscene:text("The EARTH will draw\nher final breath.", "middle_bottom")
    dialogue10.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    cutscene:removeSlides()
    
    ---SLIDE #4---------------------------------------------------------------------------------------
    local fourth_a = cutscene:slide("legend/deltarune/4/4a")
    fourth_a:setScale(2, 2)
    local dialogue11 = cutscene:text("Only then,[wait:5] shining with hope...", "left_bottom")
    dialogue11.state.typing_sound = "ralsei"
    cutscene:wait(4.5)
    cutscene:removeText()
    local fourth_b = cutscene:slide("legend/deltarune/4/4b")
    fourth_b:setScale(2, 2)
    local dialogue12 = cutscene:text("Three HEROES appear\nat WORLDS' edge.", "middle_bottom")
    dialogue12.state.typing_sound = "ralsei"
    cutscene:wait(4.5)
    cutscene:removeText()
    cutscene:removeSlides()

    ---SLIDE #5---------------------------------------------------------------------------------------
    local fifth_a = cutscene:slide("legend/deltarune/5/5a")
    fifth_a:setScale(2, 2)
    local dialogue13_a = cutscene:text("A HUMAN,", "text_human")
    dialogue13_a.state.typing_sound = "ralsei"
    cutscene:wait(2)
    local fifth_b = cutscene:slide("legend/deltarune/5/5b")
    fifth_b:setScale(2, 2)
    local dialogue13_b = cutscene:text("A MONSTER,", "text_monster")
    dialogue13_b.state.typing_sound = "ralsei"
    cutscene:wait(2)
    local fifth_a = cutscene:slide("legend/deltarune/5/5c")
    fifth_a:setScale(2, 2)
    local dialogue13_c = cutscene:text("And a PRINCE\nFROM THE DARK.", "text_prince")
    dialogue13_c.state.typing_sound = "ralsei"
    cutscene:wait(5)
    cutscene:removeText()
    cutscene:removeSlides()

    ---SLIDE #6---------------------------------------------------------------------------------------
    local sixth = cutscene:slide("legend/deltarune/6")
    sixth:setScale(2, 2)
    local dialogue14 = cutscene:text("Only they can seal the fountains", "left_bottom")
    dialogue14.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    local dialogue15 = cutscene:text("And banish the ANGEL'S HEAVEN.", "left_bottom")
    dialogue15.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    local dialogue16 = cutscene:text("Only then will balance\nbe restored,", "middle_bottom")
    dialogue16.state.typing_sound = "ralsei"
    cutscene:wait(5)
    cutscene:removeSlides()
    cutscene:removeText()
    local dialogue17 = cutscene:text("And the WORLD saved\nfrom destruction.", "middle_bottom")
    dialogue17.state.typing_sound = "ralsei"
    cutscene:wait(4.5)
    cutscene:removeSlides()
    cutscene:removeText()
    Game.legend.cover.visible = true -- THIS ENABLES THE COVER, BECAUSE WE ARE USING LITTLE IMAGES AGAIN

    ---SLIDE #7---------------------------------------------------------------------------------------
    local sixth = cutscene:slide("legend/deltarune/7")
    sixth:setScale(2, 2)
    sixth.x = 122
    sixth.y = 55
    Game.stage.timer:tween(8, sixth, { y = -160 }, 'linear')
    local dialogue17 = cutscene:text("Today, the FOUNTAIN OF DARKNESS-", "far_left")
    dialogue17.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    local dialogue18 = cutscene:text("The geyser that\ngives this land form-", "left")
    dialogue18.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    local dialogue19 = cutscene:text("Stands tall at the\ncenter of the kingdom", "left")
    dialogue19.state.typing_sound = "ralsei"
    cutscene:wait(4)
    cutscene:removeText()
    Game.stage.timer:tween(4.5, sixth, { x = -37 }, 'linear')
    local dialogue20 = cutscene:text("But recently,[wait:10] another fountain\nhas appeared on the horizon...", "far_left")
    dialogue20.state.typing_sound = "ralsei"
    cutscene:wait(5.5)
    cutscene:removeText()
    local dialogue21 = cutscene:text("And with it,[wait:10] the balance of\nLIGHT and DARK begins to shift...", "far_left")
    dialogue21.state.typing_sound = "ralsei"
    cutscene:wait(8)
    Game.legend.music:stop() --THIS STOPS THE MUSIC 
    Game.legend.fader:fadeOut(function()  -- THIS WILL MAKE THE FADEOUT EFFECT TAKE MORE TIME INSTED OF THE DEFAULT TIME ESTABLISHED
        cutscene:removeSlides()  
    end, { speed = 5.5, color = { 1, 1, 1 }, music = false }) 
end

--If you want to know about the positions or how this code works, check the legendcutscene.lua and legend.lua from the Kristal folder.
-- That should be located in \Kristal\src\engine\game