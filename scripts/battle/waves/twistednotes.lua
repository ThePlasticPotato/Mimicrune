local TwistedNotes, super = Class(Wave)

function TwistedNotes:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 10
    self.notes, self.bpm = MidiTimeline:loadMidiTimeline(Assets.getMidiPath("battle_tense_bg"), 2) --MidiSong:loadMidiEvents(Assets.getMidiPath("battle_tense"), { track = 2 })
    self.next_note_idx = 1
    self.last_pitch = 0
    self.bar = 0

    self.original_x = 0
    self.original_y = 0
    self.alive = false
    self.should_start = false
    self.just_fired = false
    self.perfect_notes = 0
    self:setArenaOffset(-82, 0)
    self:setSoulOffset(0, 0)
    self:setArenaSize(30, 142)
    self.notes_fired = 0
end

function TwistedNotes:onStart()
  self.timer:after(0.5, function () self.should_start = true end)
  self.timer:after(8.5, function () self.alive = false end)
  self.timer:after(9.5, function () if (self.perfect_notes == self.notes_fired) then Assets.playSound("mercyadd") end end)
  --swaps the soul to be purple(if you wanna change the whole encounter to use the purple soul then you can move the next few lines to init)
  Game.battle:swapSoul(MusicSoul(nil, nil, 40, 1, 1))
  --Game.battle.soul.speed = 8
  
  --create the strings
  self.strings = {
      self:spawnObject(PurpleString(320-82, Game.battle.arena:getTop()+30, BATTLE_LAYERS["below_soul"], Game.battle.arena.width-16, 0)),
      self:spawnObject(PurpleString(320-82, Game.battle.arena.y, BATTLE_LAYERS["below_soul"], Game.battle.arena.width-16, 0)),
      self:spawnObject(PurpleString(320-82, Game.battle.arena:getBottom()-30, BATTLE_LAYERS["below_soul"], Game.battle.arena.width-16, 0)),
  }

  -- --assign the fourth string(the bottom one) as the soul's current string
  --Game.battle.soul.currentString = self.strings[2]
  -- code here gets called at the start of the wave

  local attackers = self:getAttackers()
  local prototype = attackers[1]
  for i, at in ipairs(attackers) do
    if (i ~= 1) then
      at:setColor(1,1,1,0.5)
    end
  end
  self.original_x = prototype.x
  self.original_y = prototype.y
  prototype:slideTo(prototype.x - 40, SCREEN_HEIGHT/2, 0.5, "out-expo")
end

function TwistedNotes:update()
  local attackers = self:getAttackers()
  local prototype = attackers[1]
    if (not self.alive) then
      if (self.should_start) then
        local function lowerBoundByTime(notes, t)
          local lo, hi = 1, #notes + 1
          while lo < hi do
              local mid = math.floor((lo + hi) / 2)
              if notes[mid].t < t then
                  lo = mid + 1
              else
                  hi = mid
              end
          end
          return lo
        end
        local now = Game.battle.music:tell()
        self.next_note_idx = lowerBoundByTime(self.notes, now)
        self.alive = true
        self.should_start = false
      else
        super.update(self)
        return
      end
    end
    local function midiToPitchMultiplier(midiNote, baseMidiNote)
        baseMidiNote = baseMidiNote or 72 -- C4
        return 2 ^ ((midiNote - baseMidiNote) / 12)
    end
    -- code here gets called every frame
    local LEAD = 0.045 -- 40 ms, tweak 0.02–0.08
    local now = Game.battle.music:tell()
    local target = now + LEAD
    --Kristal.Console:log("Note Count: " .. #self.notes)
    while self.next_note_idx <= #self.notes and self.notes[self.next_note_idx].t <= target do
        local n = self.notes[self.next_note_idx]
        -- Trigger an attack timed to the note:
        --Kristal.Console:log("Testing note")
        -- if (n.type == "noteOn") then
        --   self.spawnNoteAttack(n.key, n.vel)
        --   self.next_note_idx = self.next_note_idx + 1
        --   Assets.stopAndPlaySound("voice/twstproto", 0.5, midiToPitchMultiplier(self.normalizePitch(n.pitch)[1]))
        -- end
        if (n) then
          --Game.battle.soul:shake(0, 1, 0.25, 1/15)
          local duration = Game.battle.music.source:getDuration("seconds")
          local remainder = math.max(duration - Game.battle.music:tell(), 0)
          local numericPitch = self:normalizePitch(n.pitch)[1]
          local new_bar = (numericPitch > self.last_pitch) and MathUtils.clamp(self.bar + 1, 0, 2) or (self.last_pitch > numericPitch) and MathUtils.clamp(self.bar - 1, 0, 2) or self.bar
          local anim = (new_bar == 2) and "note_up" or (new_bar == 0) and "note_down" or "note_center"
          prototype:setAnimation(anim)
          if not self.just_fired then
            self:spawnNoteAttack(n.pitch, n.vel, n.dur)
            self.just_fired = (remainder > (67))
            self.notes_fired = self.notes_fired + 1
          else
            self.just_fired = false
          end
          self.next_note_idx = self.next_note_idx + 1
          local midiNote = self:normalizePitch(n.pitch)[1]
          if midiNote then
            
            local shakeAmount = (remainder <= 10) and 3 or (remainder <= 35) and 2 or (remainder <= (66)) and 1 or 0
            --local pitchBoost = (remainder <= (67)) and 0.0833 or 0 
            Assets.stopAndPlaySound((remainder > (67)) and "voice/twstproto" or "voice/twstproto_keyshift", 0.75, midiToPitchMultiplier(midiNote)) --+ pitchBoost)
          end
      end
    end
    super.update(self)
end

function TwistedNotes:spawnNoteAttack(pitch, velocity, duration)
    -- Our X position is offscreen, to the right
    local x = self:getAttackers()[1].x - 16
    local numericPitch = self:normalizePitch(pitch)[1]
    local new_bar = (numericPitch > self.last_pitch) and MathUtils.clamp(self.bar + 1, 0, 2) or (self.last_pitch > numericPitch) and MathUtils.clamp(self.bar - 1, 0, 2) or self.bar

    local y = MathUtils.lerp(Game.battle.arena.bottom-30, Game.battle.arena.top+30, new_bar * 0.5)
    local unsafe_y1 = MathUtils.lerp(Game.battle.arena.bottom-30, Game.battle.arena.top+30, MathUtils.wrap(new_bar + 1, 0, 3) * 0.5)
    local unsafe_y2 = MathUtils.lerp(Game.battle.arena.bottom-30, Game.battle.arena.top+30, MathUtils.wrap(new_bar - 1, 0, 3) * 0.5)
    -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
    local bullet = self:spawnBullet("safenotebullet", x, y, math.rad(180), 12)
    local bullet2 = self:spawnBullet("notebullet", x, unsafe_y1, math.rad(180), 12)
    local bullet3 = self:spawnBullet("notebullet", x, unsafe_y2, math.rad(180), 12)

    -- Dont remove the bullet offscreen, because we spawn it offscreen
    --bullet.remove_offscreen = false
    self.bar = new_bar
    self.last_pitch = numericPitch
end

function TwistedNotes:normalizePitch(p)
  if type(p) == "number" then
    return { p }
  elseif type(p) == "string" then
    -- If LuaMidi returned note names, convert to MIDI number.
    -- This function assumes format like C4, D#5, etc.
    local noteMap = {
      C=0, ["C#"]=1, Db=1, D=2, ["D#"]=3, Eb=3,
      E=4, F=5, ["F#"]=6, Gb=6, G=7,
      ["G#"]=8, Ab=8, A=9, ["A#"]=10, Bb=10, B=11
    }

    local name, octave = p:match("([A-G][#b]?)(%-?%d+)")
    return { (tonumber(octave)+1)*12 + noteMap[name] }

  elseif type(p) == "table" then
    local out = {}
    for i = 1, #p do
      out[i] = self.normalizePitch(p[i])[1]
    end
    return out
  end

  return {}
end

function TwistedNotes:beforeEnd()
  local attackers = self:getAttackers()
  local prototype = attackers[1]
  if (self.perfect_notes == self.notes_fired) then
    local battler = Game.battle.party[1]
    for i, battl in ipairs(Game.battle.party) do
      if (battl:isTargeted()) then
        battler = battl
        break
      end
    end
    battler:setAnimation("battle/attack", function()
      prototype:flash()
      local damage = MathUtils.round(prototype:getAttackDamage(0, battler, 150))

      local attacksprite = battler.chara:getAttackSprite()
      local dmg_sprite = Sprite(attacksprite or "effects/attack/cut")
      dmg_sprite:setOrigin(0.5, 0.5)
      dmg_sprite:setScale(2.5, 2.5)
      local relative_pos_x, relative_pos_y = prototype:getRelativePos(prototype.width / 2, prototype.height / 2)
      dmg_sprite:setPosition(relative_pos_x + prototype.dmg_sprite_offset[1], relative_pos_y + prototype.dmg_sprite_offset[2])
      dmg_sprite.layer = prototype.layer + 0.01
      table.insert(prototype.dmg_sprites, dmg_sprite)
      local dmg_anim_speed = 1 / 15
      dmg_sprite:play(dmg_anim_speed, false, function(s) s:remove(); TableUtils.removeValue(prototype.dmg_sprites, dmg_sprite) end) -- Remove itself and Remove the dmg_sprite from the enemy's dmg_sprite table when its removed
      prototype.parent:addChild(dmg_sprite)

      battler.chara:onAttackHit(prototype, damage)

      prototype:hurt(damage, Game.battle.party[1])
      Game:giveTension(20)
      Assets.playSound("bigcut")
      Game.battle.timer:after(0.5, function () battler:setAnimation("battle/attack_end", function() battler:resetSprite() end) end)
    end)
  end

  
  prototype:slideTo(self.original_x, self.original_y, 0.5, "out-expo")
  for i, at in ipairs(attackers) do
    if (i ~= 1) then
      at:setColor(1,1,1,1)
    end
  end
  prototype:resetSprite()
end

return TwistedNotes