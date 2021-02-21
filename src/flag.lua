local mt = {}
mt.__index = mt

local colors = require 'src.colors'

function mt:draw(asset, alpha)
    love.graphics.setColor(1, 1, 1, alpha)
    love.graphics.draw(asset, self.x + 1, self.y + 1, 0, 0.20, 0.20)
end

function mt:update(goal)
    self.x = (goal.col - 1) * self.size + self.offset
    self.y = (goal.row - 1) * self.size + self.offset
end

return {
    new = function(goal, size, offset)
        local x = (goal.col - 1) * size + offset
        local y = (goal.row - 1) * size + offset

        return setmetatable({
            row = goal.row,
            col = goal.col,
            x = x,
            y = y,
            size = size,
            offset = offset,
            goal = goal
        }, mt)
    end
}
