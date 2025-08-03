local PanelMenuBackground, super = Class(Object)

function PanelMenuBackground:init(sprite_location, x, y, open_sound, close_sound, move_sound, select_sound, error_sound, cancel_sound, ambience_sound, anim_x, anim_y)
    self.sprite = Assets.getTexture(sprite_location)
    super.init(self, x, y, self.sprite:getWidth(), self.sprite:getHeight())
    self.open_sprite = Sprite(Assets.getFrames(sprite_location.."_open") or self.sprite, anim_x, anim_y)
    self.close_sprite = Sprite(Assets.getFrames(sprite_location.."_close") or self.sprite, anim_x, anim_y)
    self.close_sprite.visible = false
    self.open_sprite.visible = false

    self.layer = -1

    self.opening = false
    self.closing = false
    self.operable = false

    self.panel_open = Assets.newSound(open_sound)
    self.panel_close = Assets.newSound(close_sound)
    self.ui_move = Assets.newSound(move_sound)
    self.ui_select = Assets.newSound(select_sound)
    self.ui_error = Assets.newSound(error_sound)
    self.ui_cancel = Assets.newSound(cancel_sound)

    self.panel_ambience = nil
    if (ambience_sound ~= nil) then
        self.panel_ambience = Assets.newSound(ambience_sound) or nil
    end
    if (self.panel_ambience ~= nil) then
        self.panel_ambience:setVolume(0.25)
        self.panel_ambience:setLooping(true)
    end
    Game.stage:addChild(self.open_sprite)
    Game.stage:addChild(self.close_sprite)
    self.open_sprite:setLayer(WORLD_LAYERS["below_ui"] -1)
    self.close_sprite:setLayer(WORLD_LAYERS["below_ui"] -1)
end

function PanelMenuBackground:update()
    super.update(self)
end

function PanelMenuBackground:stopAllSounds(ambience)
    self.panel_open:stop()
    self.panel_close:stop()
    self.ui_move:stop()
    self.ui_select:stop()
    self.ui_error:stop()
    self.ui_cancel:stop()
    if (self.panel_ambience ~= nil) then
        self.panel_ambience:stop()
    end

end

function PanelMenuBackground:onAddToStage(stage)
    super.onAddToStage(self, stage)
    self.opening = true
    self.panel_open:stop()
    self.panel_open:play()
    self.open_sprite.visible = true
    self.open_sprite:play(1/20, false, function () 
            self.operable = true
            self.opening = false
            self.open_sprite.visible = false
            if (self.panel_ambience ~= nil) then
                self.panel_ambience:play() 

                end
        end)
end

function PanelMenuBackground:close(immediate, after)
    self.operable = false
    self:stopAllSounds()
    if (immediate ~= true) then
        self.panel_close:play()
        self.closing = true
        self.close_sprite.visible = true
        self.close_sprite:play(1/20, false, function () 
            after()
            self.open_sprite:remove()
            self.close_sprite:remove()
            self:remove()
            end)
    else
        self.panel_close:play()
        after()
        self:remove()
    end
end

function PanelMenuBackground:draw()
    if (not self.opening and not self.closing) then
        Draw.draw(self.sprite, self.x, self.y)
    end
end


return PanelMenuBackground