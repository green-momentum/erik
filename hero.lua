local flux = require 'lib.flux'

local mt = {}
mt.__index = mt
local isKeyPressed = false

function mt:update(dt)
    flux.update(dt)

    if isKeyPressed == false and love.keyboard.isDown('up', 'down', 'left', 'right') then
        local new_x, new_y = self.x, self.y
        isKeyPressed = true

        if love.keyboard.isDown('up') then

            new_y = new_y - 20
        end
        if love.keyboard.isDown('down') then

            new_y = new_y + 20
        end
        if love.keyboard.isDown('left') then

            new_x = new_x - 20
        end
        if love.keyboard.isDown('right') then
            new_x = new_x + 20
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
