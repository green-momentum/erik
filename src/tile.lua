local mt = {}
mt.__index = mt

function mt:setVisited(val)
  self.visited = val
end

function mt:setLeft(val)
  self.left = val
end

function mt:setRight(val)
  self.right = val
end

function mt:setUp(val)
  self.up = val
end

function mt:setDown(val)
  self.down = val
end

function mt:drawLeft(offsetx, offsety)
  local x = (self.col - 1) * self.size + offsetx
  local y = (self.row - 1) * self.size + offsety
  love.graphics.line(x, y, x, y + self.size)
end

function mt:drawRight(offsetx, offsety)
  local x = (self.col - 1) * self.size + offsetx
  local y = (self.row - 1) * self.size + offsety
  love.graphics.line(x + self.size, y, x + self.size, y + self.size)
end

function mt:drawUp(offsetx, offsety)
  local x = (self.col - 1) * self.size + offsetx
  local y = (self.row - 1) * self.size + offsety
  love.graphics.line(x, y, x + self.size, y)
end

function mt:drawDown(offsetx, offsety)
  local x = (self.col - 1) * self.size + offsetx
  local y = (self.row - 1) * self.size + offsety
  love.graphics.line(x, y + self.size, x + self.size, y + self.size)
end

function mt:draw(w, h, offsetx, offsety)
  local x = (self.col - 1) * self.size + offsetx
  local y = (self.row - 1) * self.size + offsety

  love.graphics.setColor(121 / 255, 121 / 255, 121 / 255)

  if (not self.left) then
    self:drawLeft(offsetx, offsety)
  end

  if (not self.right) then
    self:drawRight(offsetx, offsety)
  end

  if (not self.up) then
    self:drawUp(offsetx, offsety)
  end

  if (not self.down) then
    self:drawDown(offsetx, offsety)
  end

  love.graphics.setColor(71 / 255, 67 / 255, 56 / 255)
  --love.graphics.rectangle("fill", x + self.size / 2 - 1, y + self.size / 2 - 1, 2, 2)
  love.graphics.points(x + self.size / 2 - 1, y + self.size / 2 - 1)
end

return {
    new = function(row, col, size)
      return setmetatable({
          row = row,
          col = col,
          size = size,
          visited = false,
          left = false,
          right = false,
          up = false,
          down = false,
        }, mt)
    end
}
