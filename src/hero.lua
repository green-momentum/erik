local flux = require 'lib.flux'
local colors = require 'src.colors'
local inspect = require 'lib.inspect'

local mt = {}
mt.__index = mt

local isKeyPressed = false
local isFlipped = false

function mt:update(dt, maze, onEnd)
    if isKeyPressed == false and love.keyboard.isDown('up', 'down', 'left', 'right') then
        isKeyPressed = true
        local n_row, n_col = self.row, self.col

        if love.keyboard.isDown('up') and n_row - 1 > 0 and maze.cells[n_row][n_col].up then
            self.row = self.row - 1
        elseif love.keyboard.isDown('down') and n_row + 1 < maze.size + 1 and maze.cells[n_row][n_col].down then
            self.row = self.row + 1
        elseif love.keyboard.isDown('left') and n_col - 1 > 0 and maze.cells[n_row][n_col].left then
            self.col = self.col - 1
            isFlipped = true
        elseif love.keyboard.isDown('right') and n_col + 1 < maze.size + 1 and maze.cells[n_row][n_col].right then
            self.col = self.col + 1
            isFlipped = false
        end

        print(inspect({self.row, self.col}))

        flux.to(self, 0.15, {
            x = (self.col - 1) * self.size + maze.offset,
            y = (self.row - 1) * self.size + maze.offset,
            jump = 2
        }):oncomplete(function()
            flux.to(self, 0.05, {
                jump = 0
            }):oncomplete(function()
                isKeyPressed = false
                if self.goal.row == self.row and self.goal.col == self.col then
                    onEnd()
                end
            end)
        end)
    end
end

function mt:draw(asset)
    love.graphics.setColor(colors.WHITE)
    local scale_x, scale_y
    if isFlipped then
        love.graphics.translate(asset:getWidth() / 5, 0)
        scale_x, scale_y = -0.20, 0.20
    else
        love.graphics.translate(0, 0)
        scale_x, scale_y = 0.20, 0.20
    end

    love.graphics.draw(asset, self.x + 1, self.y + 1 - self.jump, 0, scale_x, scale_y)
end

return {
    new = function(start, goal, size, offset)
        local x = (start.col - 1) * size + offset
        local y = (start.row - 1) * size + offset

        return setmetatable({
            row = start.row,
            col = start.col,
            x = x,
            y = y,
            size = size,
            goal = goal,
            jump = 0
        }, mt)
    end
}
