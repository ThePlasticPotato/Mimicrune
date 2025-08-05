---@class DarkMenu
local DarkMenu, super = Utils.hookScript(DarkMenu)

function DarkMenu:init()
    super.super.init(self, 0, -80)

    self.layer = WORLD_LAYERS["ui"]

    self.parallax_x = 0
    self.parallax_y = 0

    self.animation_done = false
    self.animation_timer = 0
    self.animate_out = false

    self.selected_submenu = 1

    self.item_header_selected = 1
    self.equip_selected = 1
    self.power_selected = 1

    self.item_selected_x = 1
    self.item_selected_y = 1

    self.selected_party = 1
    self.party_select_mode = "SINGLE" -- SINGLE, ALL
    self.after_party_select = nil

    self.selected_item = 1

    self.state = "MAIN"
    self.state_reason = nil
    self.heart_sprite = Assets.getTexture("player/heart_menu_small")

    self.ui_select = Assets.newSound("ui_select_camera")
    self.ui_move = Assets.newSound("ui_move_panel")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small_camera")
    self.ui_cant_select = Assets.newSound("ui_error_camera")

    self.font = Assets.getFont("main")
    self.ui_interrupt = Assets.newSound("ui_interrupt_hand")
    self.ui_interrupt:setVolume(0.25)

    self.description_panel = PanelMenuBackground("ui/menu/panels/dark/hand/menu", 0, 0, "hand_open", "hand_open", "ui_move_panel", "ui_select_panel", "ui_error_panel", "ui_cancel_small_camera", nil, 0, 0, false)
    self.description_panel.layer = 10
    self:addChild(self.description_panel)
    self.description = Text("", 20, 10, 540, 80 - 16)
    self.description.visible = false
    self.description_panel:addChild(self.description)

    self.buttons = {}
    self:addButtons()
    self.buttons = Kristal.callEvent(KRISTAL_EVENT.getDarkMenuButtons, self.buttons, self) or self.buttons

    self.sprite = Assets.getTexture("ui/menu/panels/dark/main/top")

    self.box = nil
    self.box_offset_x = 0
    self.box_offset_y = 0
end

function DarkMenu:addButtons()
    -- ITEM
    self:addButton({
        ["state"]          = "ITEMMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/item"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/item_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/item"),
        ["callback"]       = function()
            self.box = DarkItemMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- EQUIP
    self:addButton({
        ["state"]          = "EQUIPMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/equip"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/equip_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/equip"),
        ["callback"]       = function()
            self.box = DarkEquipMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- POWER
    self:addButton({
        ["state"]          = "POWERMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/power"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/power_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/power"),
        ["callback"]       = function()
            self.box = DarkPowerMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- SPELLS
    self:addButton({
        ["state"]          = "SPELLMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/spells"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/spells_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/spells"),
        ["callback"]       = function()
            self.box = DarkSpellMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })

    -- CONFIG
    self:addButton({
        ["state"]          = "CONFIGMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/config"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/config_h"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/config"),
        ["callback"]       = function()
            self.box = DarkConfigMenu()
            self.box.layer = -1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end
    })
end

function DarkMenu:setDescription(text, visible)
    local wasVisible = self.description_panel.operable
    local oldText = self.description.text
    self.description:setText(text)
    if (wasVisible and visible ~= false and oldText ~= text) then self.ui_interrupt:stop() ; self.ui_interrupt:play() end
    if visible ~= nil then
        if (visible ~= wasVisible) then
            if (visible) then
                self.description_panel:open(false, function () self.description.visible = true end)
            else
                self.description.visible = false
                self.description_panel:close(false, nil, false)
            end
        end
    end
end

function DarkMenu:draw()
    Draw.draw(self.sprite, 0, 0)

    Draw.setColor(1, 1, 1, 1)
    if self.buttons[self.selected_submenu].desc_sprite then
        Draw.draw(self.buttons[self.selected_submenu].desc_sprite, 20, 24, 0, 2, 2)
    end

    for i = 1, #self.buttons do
        self:drawButton(i, 120 + ((i - 1) * self:getButtonSpacing()), 20)
    end
    Draw.setColor(1, 1, 1)

    love.graphics.setFont(self.font)
    love.graphics.print(Game:getConfig("darkCurrencyShort") .. " " .. Game.money, 520, 20)

    super.super.draw(self)
end

return DarkMenu