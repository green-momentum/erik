local mt = {}
mt.__index = mt

local flux = require 'lib.flux'
local colors = require 'src.colors'

local isKeyPressed = false

function mt:getPixelPosition(cell)
    return self.maze_offset + (cell - 1) * self.size
end

function mt:update(dt, maze)
    flux.update(dt)

    if isKeyPressed == false and love.keyboard.isDown('up', 'down', 'left', 'right') then
        isKeyPressed = true
        local n_row, n_col = self.row, self.col

        if love.keyboard.isDown('up') and n_row - 1 > 0 and maze.cells[n_row][n_col].up then
            n_row = n_row - 1
        elseif love.keyboard.isDown('down') and n_row + 1 < maze.h + 1 and maze.cells[n_row][n_col].down then
            n_row = n_row + 1
        elseif love.keyboard.isDown('left') and n_col - 1 > 0 and maze.cells[n_row][n_col].left then
            n_col = n_col - 1
        elseif love.keyboard.isDown('right') and n_col + 1 < maze.w + 1 and maze.cells[n_row][n_col].right then
            n_col = n_col + 1
        end

        flux.to(self, 0.2, {
            col = n_col,
            row = n_row
        }):oncomplete(function()
            isKeyPressed = false
        end)
    end
end

function mt:draw()
    local x, y = self:getPixelPosition(self.col), self:getPixelPosition(self.row)

    -- TODO: add hero asset here.
    love.graphics.setColor(colors.GREEN_MINERAL)
    love.graphics.rectangle('fill', x, y, self.size, self.size)
end

return {
    new = function(row, col, size, maze_size, maze_offset)
        return setmetatable({
            row = row,
            col = col,
            size = size,
            maze_size = maze_size,
            maze_offset = maze_offset
        }, mt)
    end
}
