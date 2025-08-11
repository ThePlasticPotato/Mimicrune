return {
    purpleguy = function (event)
        local randSax = Utils.random(0, 9)
        Assets.playSound("sax/"..tostring(randSax))
    end
}