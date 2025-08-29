return function(cutscene)
    Game.legend.music:play("legend")
    Game.legend.music:setLooping(false)
    cutscene:setSpeed(1 / 2.1)
    cutscene:musicWait(0.54)

    ---SLIDE #1---------------------------------------------------------------------------------------
    local first = cutscene:slide("legend/mimicrune/1")
    first:setScale(2, 2)
    first.x = 123
    first.y = 59
    Game.stage.timer:tween(17, first, { y = -442 }, 'linear')
    local dialogue1 = cutscene:textCentered("Once[wait:1] upon a[wait:1] time[wait:2],\nsang in[wait:1] shadowd chimes...", "center")
    dialogue1.state.typing_sound = nil
    cutscene:musicWait(4.9)
    cutscene:removeText()
    local dialogue1b = cutscene:textCentered("'Twas[wait:1] a[wait:1] story,\nof[wait:2] [color:yellow]HOPE[color:reset][wait:2] and[wait:4] [color:maroon]HATE[color:reset]...", "center")
    cutscene:musicWait(8.72)
    cutscene:removeText()
    cutscene:textCentered(" Sands[wait:1] of[wait:2]\n[style:dark][wave:1][color:#b8f1ee]TIME[color:reset][style:none][wave:0][wait:4]\n  for[wait:1] none[wait:1] they[wait:3]\n[style:dark][wave:1][color:#b8f1ee]WAIT[color:reset][style:none].", "far_left") 
    local dialogue2b = cutscene:textCentered("Hands[wait:1] of[wait:2]\n[style:dark][wave:1][color:#39b9b9]SKY[color:reset][style:none][wave:0][wait:4]\nthat[wait:4] gov[wait:2]ern[wait:4]\n[style:dark][wave:1][color:#39b9b9]FATE[color:reset][style:none][wave:0].", "far_right")
    dialogue2b.state.typing_sound = nil
    cutscene:musicWait(12.54)
    cutscene:removeText()
    local dialogue4 = cutscene:textCentered("A[wait:4] [speed:0.23]legend[speed:0.47][wait:5] of\n[wait:15][color:yellow] HEROES[color:reset][wait:4] in rhyme...", "center")
    dialogue4.state.typing_sound = nil
    cutscene:musicWait(18.54)
    cutscene:removeText()
    cutscene:removeSlides()
    cutscene:musicWait(19.63)

    ---SLIDE #2---------------------------------------------------------------------------------------
    local second_a = cutscene:slide("legend/mimicrune/2/2a")
    second_a:setScale(2, 2)
    second_a.x = 123
    second_a.y = 59
    local dialogue5 = cutscene:textCentered("A[wait:2]bove[wait:2] a world[wait:4] of[wait:1] pur[wait:2]est[wait:6] [color:yellow]LIGHT[color:reset],", "center")
    cutscene:musicWait(24.0)
    local second_ab = cutscene:slide("legend/mimicrune/2/2ab")
    second_ab:setScale(2, 2)
    second_ab.x = 123
    second_ab.y = 59
    local dialogue5b = cutscene:textCentered("\nBe[wait:2]neath it[wait:4], grew[wait:2] e[wait:2]ter[wait:2]nal[wait:6] [color:purple][style:dark]NIGHT[style:none][color:reset].", "center")
    cutscene:musicWait(28.36)
    cutscene:removeText()
    local second_b = cutscene:slide("legend/mimicrune/2/2b")
    second_b:setScale(2, 2)
    second_b.x = 123
    second_b.y = 59
    local dialogue5c = cutscene:textCentered("Cor[wait:1]rupt[wait:1]ion[wait:3] spread, the[wait:2] [color:maroon]poi[wait:4]son[color:reset][wait:2] lies,", "center")
    dialogue5c.state.typing_sound = nil
    cutscene:musicWait(32.72)
    local second_b = cutscene:slide("legend/mimicrune/2/2bb")
    second_b:setScale(2, 2)
    second_b.x = 123
    second_b.y = 59
    local dialogue6 = cutscene:textCentered("[shake:1][color:red]CA[wait:2]LAMI[wait:2]TY[shake:0][wait:5][color:reset] shapes from black[wait:2]ened[wait:2] skies...", "center_bottom")
    dialogue6.state.typing_sound = nil
    cutscene:musicWait(35.9)
    --THIS EFFECT OF FADER IS THE "WHITE SCREEN" TRANSITION, THIS IS A FADE OUT, YOULL NEED TO DEFINE THE FADE IN TO CONTINUE THE CUTSCENE
    Game.legend.fader:fadeOut(function() 
        cutscene:removeSlides()  
        cutscene:removeText()
    end, { speed = 1, color = { 1, 1, 1 }, music = false }) 
    Game.legend.cover.visible = false --THIS WILL DISABLE THE BLACK "COVERS" , IN ORDER TO MAKE THE SCREEN BIGGER FOR A BIGGER SLIDE
    cutscene:musicWait(37.09)
    
    ---SLIDE #3---------------------------------------------------------------------------------------
    local third = cutscene:slide("legend/mimicrune/3")
    third:setScale(2, 2)
    Game.legend.fader:fadeIn(nil, { speed = 1, color = { 1, 1, 1 } }) -- THE FADE IN
    local dialogue7 = cutscene:textCentered("The [color:yellow]LIGHT[color:reset] and [color:purple][style:dark]DARK[style:none][color:reset]\nboth burning dire,", "center_bottom")
    dialogue7.state.typing_sound = nil
    cutscene:musicWait(41.45)
    cutscene:removeText()
    local dialogue8 = cutscene:textCentered("A[wait:2] count[wait:2]down[wait:2] to[wait:2] all[wait:5] [color:yellow]HOPE[color:reset]'s[wait:2] ex[wait:2]pire.", "center_bottom")
    dialogue8.state.typing_sound = nil
    cutscene:musicWait(45.81)
    cutscene:removeText()
    cutscene:removeSlides()
    
    ---SLIDE #4---------------------------------------------------------------------------------------
    local fourth_a = cutscene:slide("legend/mimicrune/4/4a")
    fourth_a:setScale(2, 2)
    local dialogue11 = cutscene:textCentered("[wait:1]PUR[wait:2]ITY[wait:2] burns[wait:6] to a [wait:2]bit[wait:2]ter[wait:2] end...", "center_bottom")
    dialogue11.state.typing_sound = nil
    cutscene:musicWait(47.19)
    local fourth_ab = cutscene:slide("legend/mimicrune/4/4b")
    fourth_ab:setScale(2, 2)
    cutscene:musicWait(50.18)
    cutscene:removeText()
    cutscene:removeSlides()

    ---SLIDE #5---------------------------------------------------------------------------------------
    local fourth_b = cutscene:slide("legend/mimicrune/heroes/1")
    fourth_b:setScale(2, 2)
    fourth_b.y = -8
    local dialogue12 = cutscene:textCentered("But,[wait:2] 'lo on[wait:2] [color:yellow]HOPE[color:reset][wait:1] are[wait:1]\nTHREE[wait:2] they send...", "center_bottom")
    dialogue12.state.typing_sound = nil
    cutscene:musicWait(54.54)
    cutscene:removeText()

    local fifth_a = cutscene:slide("legend/mimicrune/heroes/2")
    fifth_a:setScale(2, 2)
    fifth_a.y = -8
    local dialogue13_a = cutscene:textCentered("[color:lime]THE BOY[color:reset],[wait:2]\nall[wait:1] wounds his [color:green]HEART[color:reset] can mend,", "center_bottom")
    cutscene:musicWait(58.9)
    cutscene:removeText()
    local fifth_b = cutscene:slide("legend/mimicrune/heroes/3")
    fifth_b:setScale(2, 2)
    fifth_b.y = -8
    local dialogue13_b = cutscene:textCentered("[color:yellow]THE GIRL[color:reset],[wait:2]\nwhose [color:#b8f1ee][wave:1][style:dark]HOURGLASS[style:none][wave:0][color:reset] is out of sand,", "center_bottom")
    cutscene:musicWait(63.27)
    cutscene:removeText()
    local fifth_c = cutscene:slide("legend/mimicrune/heroes/4")
    fifth_c:setScale(2, 2)
    fifth_c.y = -8
    local dialogue13_c = cutscene:textCentered("[color:purple][style:dark]THE FRIEND[color:reset][style:none],[wait:2]\nalways with them,[wait:2]held[wait:1] in[wait:1] hand,", "center_bottom")
    cutscene:musicWait(67.63)
    cutscene:removeText()
    local fifth_d = cutscene:slide("legend/mimicrune/heroes/5")
    fifth_d:setScale(2, 2)
    fifth_d.y = -8
    cutscene:textCentered("Only [color:yellow]THEY[color:reset][wait:1] hold the [color:green]POWER[color:reset] to\n[wait:2]save[wait:1] this[wait:1] land...", "center_bottom")
    cutscene:musicWait(72)
    cutscene:removeText()
    cutscene:removeSlides()

    ---SLIDE #6---------------------------------------------------------------------------------------
    local sixth = cutscene:slide("legend/mimicrune/6")
    sixth:setScale(2, 2)
    local dialogue14 = cutscene:textCentered("Through[wait:2] the[wait:2] [color:green]POWER[color:reset][wait:2] of[wait:2] HEARTS[wait:2] combined,", "center_bottom")
    dialogue14.state.typing_sound = nil
    cutscene:musicWait(76.09)
    local dialogue15 = cutscene:textCentered("\nthey'll[wait:2] pur[wait:2]if[wait:2]y the [color:maroon]AGONY[color:reset][wait:2] within.", "center_bottom")
    dialogue15.state.typing_sound = nil
    cutscene:musicWait(79.09)
    cutscene:removeText()
    local dialogue16 = cutscene:textCentered("[color:pink][wave:1,30,10]LOVE[wave:0][color:reset][wait:2] and[wait:2] [color:maroon][shake:1]HATE[shake:0][color:reset][wait:2] put[wait:2] face[wait:2] to[wait:2] face,", "center_bottom")
    dialogue16.state.typing_sound = nil
    cutscene:musicWait(82.63)
    local dialogue17 = cutscene:textCentered("\nAnd only[wait:2] [color:#b8f1ee][wave:1][style:dark]TIME[style:none][wave:0][color:reset][wait:6] can tell you[wait:4] just[wait:2]\nwho[wait:4] will[wait:4] win...", "center_bottom")
    cutscene:musicWait(89.45)
    cutscene:removeSlides()
    cutscene:removeText()
    Game.legend.cover.visible = true -- THIS ENABLES THE COVER, BECAUSE WE ARE USING LITTLE IMAGES AGAIN

    cutscene:musicWait(91.63)

    ---SLIDE #7---------------------------------------------------------------------------------------
    local sixth = cutscene:slide("legend/mimicrune/7/7a")
    sixth:setScale(2, 2)
    sixth.x = 123
    sixth.y = 59
    local dialogue17 = cutscene:textCentered("And[wait:2] when[wait:2] [wave:2]all[wave:0][wait:8] [color:yellow]HOPE[color:reset][wait:2] seems[wait:2] gone,", "center")
    cutscene:musicWait(96.0)
    local dialogue18 = cutscene:textCentered("\nAnd[wait:2] the[wait:2] cold[wait:2] seeps[wait:2] through[wait:2] to[wait:2] bone-", "center")
    cutscene:musicWait(100.36)
    cutscene:removeText()
    local dialogue19 = cutscene:textCentered("There[wait:2] you'll[wait:2] find,[wait:8] deep[wait:2] in[wait:2]side,", "center")
    cutscene:musicWait(104.72)
    local seventh = cutscene:slide("legend/mimicrune/7/7b")
    seventh:setScale(2, 2)
    seventh.x = 123
    seventh.y = 59
    local dialogue20 = cutscene:textCentered("\nThe [color:pink][wave:1,30,10]PROMISE[color:reset][wave:0][wait:4] made by[wait:2] [color:lime]heart[wait:2] of[wait:2] lime[color:reset]...", "center")
    cutscene:musicWait(109.09)
    cutscene:removeText()
    local dialogue21 = cutscene:textCentered("And[wait:2] with[wait:2] that[wait:2], the[wait:2] [color:yellow]HE[wait:2]ROES[color:reset]'[wait:2] tale,", "center")
    cutscene:musicWait(113.45)
    local dialogue22 = cutscene:textCentered("\nShall[wait:2] see[wait:2] [color:yellow]HOPE[color:reset][wait:2] and[wait:2] [color:pink][wave:1,30,10]LOVE[color:reset][wave:0][wait:2] pre[wait:2]vail.", "center")
    cutscene:musicWait(117.81)
    cutscene:removeText()
    local eighth = cutscene:slide("legend/mimicrune/7/7c")
    eighth:setScale(2, 2)
    eighth.x = 123
    eighth.y = 59
    local dialogue23 = cutscene:textCentered("With[wait:2] what[wait:2] cost?[wait:4] What[wait:1] might[wait:1] be[wait:2] [color:red][wave:1]lost[wave:0][color:reset]?", "center")
    cutscene:musicWait(121.63)
    cutscene:removeText()
    local dialogue24 = cutscene:textCentered("Who[wait:4] knows...", "center")
    cutscene:musicWait(124.09)
    cutscene:removeText()
    cutscene:removeSlides()
    local dialogue25 = cutscene:textCentered("[speed:0.7]But I'm[wait:2] with[wait:2] you[wait:4] in[wait:2] the[wait:1] dark.", "center")
    dialogue25.state.typing_sound = "party/cassidy"
    dialogue25.y = 158

    cutscene:musicWait(130)
    Game.legend.music:stop() --THIS STOPS THE MUSIC 
    Game.legend.fader:fadeOut(function()  -- THIS WILL MAKE THE FADEOUT EFFECT TAKE MORE TIME INSTED OF THE DEFAULT TIME ESTABLISHED
        cutscene:removeSlides()
        cutscene:removeText()
        cutscene:wait(8)
        cutscene:endCutscene()
    end, { speed = 5.5, color = { 1, 1, 1 }, music = false }) 
end

--If you want to know about the positions or how this code works, check the legendcutscene.lua and legend.lua from the Kristal folder.
-- That should be located in \Kristal\src\engine\game