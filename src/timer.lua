local mt = {}
mt.__index = mt

function mt:update()
    if self.active then
        self.secs = math.floor(love.timer.getTime() - self.start_time)

        if self.oncomplete ~= nil and self.secs >= self.limit then
            self.oncomplete()
        end
    end
end

function mt:start(limit, oncomplete)
    self.start_time = love.timer.getTime()
    self.secs = 0
    self.limit = limit
    self.active = true
    self.oncomplete = oncomplete
end

return {
    new = function()
        return setmetatable({
            start_time = 0,
            current = 0,
            limit = 0,
            remaining = 0,
            active = false,
            oncomplete = nil
        }, mt)
    end
}
