local Empty, super = Class(Wave)

function Empty:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 1
end

return Empty