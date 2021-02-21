local Tile = require 'src.tile'
local inspect = require 'lib.inspect'

local mt = {}
mt.__index = mt

function mt:create()
    self.offset = (self.screen_size - (self.size * self.cellsize)) / 2

    for i = 1, self.size do
        self.cells[i] = {}

        for j = 1, self.size do
            self.cells[i][j] = Tile.new(i, j, self.cellsize)
        end
    end

    self:recurse(1, 1, {})
end

function mt:draw(alpha)
    for i = 1, self.size do
        for j = 1, self.size do
            self.cells[i][j]:draw(self.size, self.size, self.offset, self.offset, alpha)
        end
    end
end

function mt:getStartAndGoal()
    local rnd_s = math.floor(math.random(1, self.size))
    local rnd_g = math.floor(math.random(1, self.size))

    self.cells[rnd_s][1]:setLeft(true)
    self.cells[rnd_g][self.size]:setRight(true)

    return {
        start = {
            row = rnd_s,
            col = 1
        },
        goal = {
            row = rnd_g,
            col = self.size
        }
    }
end

function mt:recurse(i, j, stack)
    self.cells[i][j]:setVisited(true)

    local n = {}

    if j ~= 1 and not self.cells[i][j - 1].visited then
        n[#n + 1] = {
            d = "left",
            i = i,
            j = j - 1
        }
    end

    if j ~= self.size and not self.cells[i][j + 1].visited then
        n[#n + 1] = {
            d = "right",
            i = i,
            j = j + 1
        }
    end

    if i ~= 1 and not self.cells[i - 1][j].visited then
        n[#n + 1] = {
            d = "up",
            i = i - 1,
            j = j
        }
    end

    if i ~= self.size and not self.cells[i + 1][j].visited then
        n[#n + 1] = {
            d = "down",
            i = i + 1,
            j = j
        }
    end

    if #n > 0 then
        stack[#stack + 1] = {
            i = i,
            j = j
        }

        local rnd_n = n[math.floor(math.random(1, #n))]

        if rnd_n.d == "left" then
            self.cells[i][j]:setLeft(true)
            self.cells[i][j - 1]:setRight(true)
        end

        if rnd_n.d == "right" then
            self.cells[i][j]:setRight(true)
            self.cells[i][j + 1]:setLeft(true)
        end

        if rnd_n.d == "up" then
            self.cells[i][j]:setUp(true)
            self.cells[i - 1][j]:setDown(true)
        end

        if rnd_n.d == "down" then
            self.cells[i][j]:setDown(true)
            self.cells[i + 1][j]:setUp(true)
        end

        self:recurse(rnd_n.i, rnd_n.j, stack)
    elseif #stack > 0 then
        local pop = table.remove(stack, #stack)
        self:recurse(pop.i, pop.j, stack)
    end
end

return {
    new = function(level, cellsize, screen_size)
        return setmetatable({
            cellsize = cellsize,
            screen_size = screen_size,
            size = math.floor(level ^ 0.4 * 5),
            cells = {}
        }, mt)
    end
}
