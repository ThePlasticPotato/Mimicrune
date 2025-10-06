local Tileset, super = HookSystem.hookScript(Tileset)

function Tileset:init(data, path, base_dir)
    self.path = path
    self.base_dir = base_dir or FileSystemUtils.getDirname(self.path)

    self.id = data.id
    self.name = data.name
    self.tile_count = data.tilecount or 0
    self.tile_width = data.tilewidth or 40
    self.tile_height = data.tileheight or 40
    self.margin = data.margin or 0
    self.spacing = data.spacing or 0
    self.columns = data.columns or 0
    self.object_alignment = data.objectalignment or "unspecified"
    self.fill_grid = data.tilerendersize == "grid"
    self.preserve_aspect_fit = data.fillmode == "preserve-aspect-fit"

    self.id_count = self.tile_count

    self.tile_info = {}
    for _,tile in ipairs(data.tiles or {}) do
        local info = {}
        if tile.animation then
            info.animation = {duration = 0, frames={}}
            for _,anim in ipairs(tile.animation) do
                table.insert(info.animation.frames, {id = anim.tileid, duration = anim.duration / 1000})
                info.animation.duration = info.animation.duration + (anim.duration / 1000)
            end
        end
        if tile.image then
            local image_path = FileSystemUtils.absoluteToLocalPath("assets/sprites/", tile.image, self.base_dir)
            info.path = image_path
            info.texture = Assets.getTexture(image_path)
            if not info.texture then
                error("Could not load tileset tile texture: " .. tostring(image_path) .. " [" .. tostring(path) .. "]")
            end
            info.x = tile.x or 0
            info.y = tile.y or 0
            info.width = tile.width or info.texture:getWidth()
            info.height = tile.height or info.texture:getHeight()

            if info.x ~= 0 or info.y ~= 0 or info.width ~= info.texture:getWidth() or info.height ~= info.texture:getHeight() then
                info.quad = love.graphics.newQuad(info.x, info.y, info.width, info.height, info.texture:getWidth(), info.texture:getHeight())
            end
        end
        if (tile.properties and tile.properties["step_sound"]) then
            info.step_sound = tile.properties["step_sound"]
        end
        self.tile_info[tile.id] = info
        self.id_count = math.max(self.id_count, tile.id + 1)
    end

    if data.image then
        local image_path = FileSystemUtils.absoluteToLocalPath("assets/sprites/", data.image, self.base_dir)
        self.texture = Assets.getTexture(image_path)
        if not self.texture then
            error("Could not load tileset texture: " .. tostring(image_path) .. " [" .. tostring(path) .. "]")
        end
    end

    self.quads = {}
    if self.texture then
        local tw, th = self.texture:getWidth(), self.texture:getHeight()
        for i = 0, self.tile_count-1 do
            local tx = self.margin + (i % self.columns) * (self.tile_width + self.spacing)
            local ty = self.margin + math.floor(i / self.columns) * (self.tile_height + self.spacing)
            self.quads[i] = love.graphics.newQuad(tx, ty, self.tile_width, self.tile_height, tw, th)
        end
    end
end

return Tileset