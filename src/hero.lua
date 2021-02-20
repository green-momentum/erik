local mt = {}
mt.__index = mt

local flux = require 'lib.flux'
local colors = require 'src.colors'

local isKeyPressed = false

function mt:update(dt)
    flux.update(dt)

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

        flux.to(self, 0.2, {
            x = new_x,
            y = new_y
        }):oncomplete(function()
            isKeyPressed = false
        end)
    end
end

function mt:draw()
    self.x = math.min(math.max(self.x, self.maze_offset), self.maze_offset + (self.maze_size - 1) * self.size)
    self.y = math.min(math.max(self.y, self.maze_offset), self.maze_offset + (self.maze_size - 1) * self.size)

    -- TODO: add hero asset here.
    love.graphics.setColor(colors.GREEN_MINERAL)
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

return {
    new = function(x, y, size, maze_size, maze_offset)
        return setmetatable({
            x = x,
            y = y,
            size = size,
            maze_size = maze_size,
            maze_offset = maze_offset
        }, mt)
    end
}
