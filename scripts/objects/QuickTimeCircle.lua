local QuickTimeCircle, super = Class(Object)

function QuickTimeCircle:init(x, y, letter, speed, radius, allow_ghost_tapping, remove_on_complete, on_complete)
    self.radius = 30 -- radius for the progress ring
    self.letter = letter
    self.speed = speed or 0.085
    self.on_complete = on_complete or nil
    self.remove_on_complete = remove_on_complete or false
    super:init(self, x, y)


    self.success = false
    self:setOrigin(0.5, 0.5)

    self.collider = CircleCollider(self, 0, 0, self.radius)


    self.inner_radius = 25 -- radius for the middle circle
    self.collider2 = CircleCollider(self, 0, 0, self.inner_radius)
    self.collider2.inverted = true


    self.layer = WORLD_LAYERS["ui"]

    self.font = Assets.getFont("main")


    -- bullet:collidesWith(self.collider)

    self.shot = HitCircle(0, 0, self.speed, (radius or nil))
    self.shot.layer = self.layer + 1
    self:addChild(self.shot)


    self.counter = 0

    self.huge = 2

    if allow_ghost_tapping or false then
        self.huge = math.huge
    end
end

function QuickTimeCircle:onAdd()
    self.counter = 0
end

function QuickTimeCircle:update()
    if Input.pressed(self.letter) then
        --Kristal.Console:log("hi hi hi")
        self.counter = self.counter + 1
    end

    if Input.pressed(self.letter) and self.shot:collidesWith(self.collider) and self.shot:collidesWith(self.collider2) and self.counter < self.huge then
        --print("hi")
        self.success = true
        self.on_complete(self)
    end

    if self.shot.scale_x < 0.31 and self.remove_on_complete then
        self:remove()
    end

    super:update(self)
end

function QuickTimeCircle:draw()
    super:draw(self)
    love.graphics.push()
    love.graphics.translate(self.width / 2, self.height / 2)
    love.graphics.setColor(1, 1, 1, self.alpha - 0.4)
    love.graphics.arc("fill", "pie", 0, 0, self.radius, -math.pi / 2, -math.pi / 2 + (math.pi * 2)) 
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.circle("fill", 0, 0, self.inner_radius)                                                           

    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.setFont(self.font)
    love.graphics.print(Input.getText(self.letter), -15, -16)



    love.graphics.pop()

    if DEBUG_RENDER then
        self.collider:draw(1, 0, 0)
        self.collider2:draw(1, 0, 1)



        Draw.setColor(COLORS.red)
        love.graphics.setFont(Assets.getFont("main_mono"))
        love.graphics.print("can press?:" ..
            (tostring(self.shot:collidesWith(self.collider) and self.shot:collidesWith(self.collider2))))

        love.graphics.print("success:" .. tostring(self.success), 0, 30)

        love.graphics.print("pressed key?:" .. tostring(self.counter), 0, 60)
    end
end

return QuickTimeCircle
