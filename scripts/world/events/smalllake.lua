--- @class SmallLake : Event
local SmallLake, super = Class(Event)

function SmallLake:init(data)
    super.init(self, data)

    self.lakeTexture = Assets.getTexture("props/lake")
    self:setSprite("props/lake")
    self:setOrigin(0.5, 0.5)

    self.noise1 = Assets.getTexture("misc/water_noise_perlin")
    self.noise2 = Assets.getTexture("misc/water_noise_sparkle")
    self.noise1:setFilter("nearest", "nearest")
    self.noise2:setFilter("nearest", "nearest")

    self.trailCanvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.splashCanvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

    self.trailCanvas:setFilter("nearest", "nearest")
    self.splashCanvas:setFilter("nearest", "nearest")

    love.graphics.push("all")
    love.graphics.setCanvas(self.trailCanvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setCanvas(self.splashCanvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.pop()

    self.splashes = {}
    self.trails = {}

    self.depth = 3

    self:addFX(ShaderFX("water", {
        iTime = function()
            return Kristal.getTime()
        end,
        screenSize = function()
            return { SCREEN_WIDTH, SCREEN_HEIGHT }
        end,
        textureSize = function()
            return { self.lakeTexture:getWidth(), self.lakeTexture:getHeight() }
        end,
        noise1 = self.noise1,
        noise2 = self.noise2,
        trailMask = function()
            return self.trailCanvas
        end,
        splashMask = function()
            return self.splashCanvas
        end,
    }, true))
end

function SmallLake:spawnSplash(x, y, radius, strength, life)
    table.insert(self.splashes, {
        x = x,
        y = y,
        radius = radius or 8,
        strength = strength or 1,
        life = life or 0.4,
        maxLife = life or 0.4
    })
end

function SmallLake:update()
    super.update(self)

    for i = #self.trails, 1, -1 do
        local pulse = self.trails[i]
        pulse.life = pulse.life - DT
        if pulse.life <= 0 then
            table.remove(self.trails, i)
        end
    end

    for i = #self.splashes, 1, -1 do
        local splash = self.splashes[i]
        splash.life = splash.life - DT
        if splash.life <= 0 then
            table.remove(self.splashes, i)
        end
    end
end

function SmallLake:pulseTrail(x, y, strength, radius, life)
    table.insert(self.trails, {
        x = x,
        y = y,
        strength = strength or 1,
        radius = radius or 3,
        life = life or 0.18,
        maxLife = life or 0.18
    })
end

function SmallLake:updateTrailBuffer()
    love.graphics.push("all")
    love.graphics.setCanvas(self.trailCanvas)
    love.graphics.clear(0, 0, 0, 0)

    for _, mark in ipairs(self.trails) do
        local sx, sy = mark.x, mark.y
        local alpha = mark.life / mark.maxLife
        local r = mark.radius + (1.0 - alpha) * 1.5

        love.graphics.setColor(1, 1, 1, 0.3 * alpha * mark.strength)
        love.graphics.circle("fill", sx, sy, r)
    end

    love.graphics.pop()
end

function SmallLake:updateSplashBuffer()
    love.graphics.push("all")
    love.graphics.setCanvas(self.splashCanvas)
    love.graphics.clear(0, 0, 0, 0)

    for _, splash in ipairs(self.splashes) do
        local sx, sy = splash.x, splash.y

        local time = 1.0 - (splash.life / splash.maxLife)
        local alpha = splash.life / splash.maxLife
        local r = splash.radius + time * 10

        love.graphics.setColor(1, 1, 1, 0.35 * alpha * splash.strength)
        love.graphics.ellipse("fill", sx, sy, r * 0.5, r * 0.25)

        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1, 0.8 * alpha * splash.strength)
        love.graphics.ellipse("line", sx, sy, r, r * 0.5)
    end

    love.graphics.pop()
end


function SmallLake:draw()
    self:updateTrailBuffer()
    self:updateSplashBuffer()
    super.draw(self)
end

function SmallLake:onEnter(chara)
	if chara.in_water ~= true then
		local scissor = ScissorFX(0, 0, 1000, chara.height*2 - self.depth * 4)

		--chara:addChild(self.watersprite)
		if not chara.watersprite then
			chara.watersprite = Sprite("misc/watercirc", chara.width/2, chara.height - self.depth)
            chara.watersprite:setOrigin(0.5, 1.0)
			chara.watersprite.color = {0.8918, 1.0, 0.9873}
			chara.watersprite.alpha = 1.0
			chara:addChild(chara.watersprite)
		end

		chara:addFX(scissor, "waterscissor")
		chara.sprite.y = chara.sprite.y + self.depth
		scissor.height = scissor.height + self.depth * 2
		Assets.playSound("noise")
		chara.in_water = true
        chara.water_depth = self.depth
	end
end

function SmallLake:onExit(chara)
    local colliding = {}
    for _, wevent in pairs(Game.world.map:getEvents("smalllake")) do
        table.insert(colliding, wevent:collidesWith(chara))
        --print(wevent:collidesWith(chara))
        
    end

    if TableUtils.contains(colliding, true) == false then
        --chara:removeChild(self.watersprite)
        if chara.watersprite then
            chara:removeChild(chara.watersprite)
            chara.watersprite = nil
        end
        chara:removeFX("waterscissor")
        chara.sprite.y = chara.sprite.y - self.depth
        chara.in_water = false
        chara.water_depth = 0
    end
end

return SmallLake