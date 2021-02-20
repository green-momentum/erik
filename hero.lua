local mt = {}
mt.__index = mt

function mt:update(dt)
    if love.keyboard.isDown('up') then
        self.y = self.y - dt * self.speed
    end
    if love.keyboard.isDown('down') then
        self.y = self.y + dt * self.speed
    end
    if love.keyboard.isDown('left') then
        self.x = self.x - dt * self.speed
    end
    if love.keyboard.isDown('right') then
        self.x = self.x + dt * self.speed
    end
end

function mt:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

return {
    new = function(x, y)
        return setmetatable({
            x = x,
            y = y,
            w = 16,
            h = 16,
            speed = 220
        }, mt)
    end
}
