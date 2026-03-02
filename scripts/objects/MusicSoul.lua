---@class MusicSoul : Soul
local MusicSoul, super = Class(Soul)

function MusicSoul:init(x, y, scale_size, negative_scales, positive_scales)
    super.init(self, x, y, nil)

    --set the soul's color to purple
    self.color = { 197/255, 75/255, 140/255 }

    scale_size = scale_size or 30
    negative_scales = negative_scales or 1
    positive_scales = positive_scales or 1

    self.scale_size = scale_size
    
    self.scales = negative_scales + 1 + positive_scales
    self.current_scale = negative_scales + 1
    self.last_scale = self.current_scale

    --movement variable for moving left and right, -1 tells it it should move left if it can and 1 is right, left and right colliders do need to be on the current string for their respective directions to work
    self.movement = 0

    --the speed the soul moves at
    self.movement_speed = 40
    --the soul's state, used for logic stuff
    self.state = "IN_POSITION" -- used states: IN_POSITION, MOVING
    self.mode = "VERTICAL" -- used modes: VERTICAL, HORIZONTAL

    --these variables are set when the soul moves to another string, they're used to lerp the soul from their last position on a string to their new position on a string
    self.old_y = 0
    self.old_x = 0

    self.afterimages_count = 0
    self.afterimages_delay = 0
    self.buffered_input = nil
    self.buffer_time = 0
    self.input_cd = 0
end

--- Called every frame from within [`Soul:update()`](lua://Soul.update) if the soul is able to move. \
--- Movement for the soul based on player input should be controlled within this method.
function MusicSoul:doMovement()
    local speed = self.speed

    -- Do speed calculations here if required.

    if self.allow_focus then
        if Input.down("cancel") then speed = speed / 2 end -- Focus mode.
    end

    local move_x, move_y = 0, 0

    -- Keyboard input:
    if Input.pressed("left") then move_x = move_x - 1 end
    if Input.pressed("right") then move_x = move_x + 1 end
    if Input.pressed("up") then move_y = move_y - 1 end
    if Input.pressed("down") then move_y = move_y + 1 end

    self.moving_x = move_x
    self.moving_y = move_y

    if (move_x ~= 0 or move_y ~= 0) and (self.input_cd <= 0) then
        if (self.state == "IN_POSITION") then
            if not self:move(move_x, move_y, speed * DTMULT) then
                self.moving_x = 0
                self.moving_y = 0
            end
            self.input_cd = 0.075
        else
            self.buffered_input = {move_x, move_y}
            self.buffer_time = 2
        end
    end

    if Input.down("parry") and self.parry_cd == 0 and self.inv_timer == 0 then
        self.parry_timer = 0.1
        self.parry_cd = 2
    end
end

function MusicSoul:move(x, y, speed)
    local reference = (self.mode == "VERTICAL") and y or x

    if (reference < 0) then
        if (self.current_scale - 1 > 0) then
            self.current_scale = self.current_scale - 1
            self.state = "MOVING"
            local new_x = (self.mode == "HORIZONTAL") and (self.x - self.scale_size) or self.x
            local new_y = (self.mode == "VERTICAL") and (self.y - self.scale_size) or self.y
            self:slideTo(new_x, new_y, 0.15, "out-expo", function () self.state = "IN_POSITION"; self.sprite:flash(); self.last_scale = self.current_scale end)
            self.afterimages_count = 4
        end
    elseif (reference > 0) then
        if (self.current_scale + 1 <= self.scales) then
            self.current_scale = self.current_scale + 1
            self.state = "MOVING"
            local new_x = (self.mode == "HORIZONTAL") and (self.x + self.scale_size) or self.x
            local new_y = (self.mode == "VERTICAL") and (self.y + self.scale_size) or self.y
            self:slideTo(new_x, new_y, 0.15, "out-expo", function () self.state = "IN_POSITION"; self.sprite:flash(); self.last_scale = self.current_scale end)
            self.afterimages_count = 4
        end
    end
end

function MusicSoul:update()
    super.update(self)
    if (self.input_cd > 0) then
        self.input_cd = self.input_cd - DT
    end
    if (self.afterimages_delay > 0) then self.afterimages_delay = self.afterimages_delay - DT end
    if (self.afterimages_count > 0) and (self.afterimages_delay <= 0) then
        self.afterimages_delay = 0.125
        local afterimage = AfterImage(self, 0.5)
        afterimage.layer = self.layer - 1
        self:addChild(afterimage)
        self.afterimages_count = self.afterimages_count - 1
    end

    if (self.buffered_input) then
        if (self.state == "IN_POSITION") then
            local inp = self.buffered_input
            self:move(unpack(inp))
            self.buffered_input = nil
            self.buffer_time = 0
        end
    end

    if (self.buffer_time > 0) then
        self.buffer_time = self.buffer_time - DT
    else
        self.buffer_time = 0
        self.buffered_input = nil
    end
end

return MusicSoul