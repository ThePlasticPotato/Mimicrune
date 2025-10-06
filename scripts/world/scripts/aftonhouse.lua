return {
    purpleguy = function (event)
        local randSax = MathUtils.random(0, 9)
        Assets.playSound("sax/"..tostring(randSax))
    end
}