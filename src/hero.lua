local flux = require 'lib.flux'

local mt = {}
mt.__index = mt
local isKeyPressed = false

function mt:update(dt)
    if isKeyPressed == false and love.keyboard.isDown('up', 'down', 'left', 'right') then
        local new_x, new_y = self.x, self.y
        isKeyPressed = true

        if love.keyboard.isDown('up') then
            new_y = new_y - self.size
        end
        if love.keyboard.isDown('down') then
            new_y = new_y + self.size
        end
        if love.keyboard.isDown('left') then
            new_x = new_x - self.size
        end
        if love.keyboard.isDown('right') then
            new_x = new_x + self.size
        end

        flux.to(self, 0.5, {
            x = new_x,
            y = new_y
        }):oncomplete(function()
            isKeyPressed = false
        end)
    end
end

function mt:draw()
    self.x = math.max(self.x, self.offset)
    self.y = math.max(self.y, self.offset)
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

return {
    new = function(x, y, size, offset)
        return setmetatable({
            x = x,
            y = y,
            size = size,
            offset = offset,
            speed = 220
        }, mt)
    end
}
