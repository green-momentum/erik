local Tile = require 'src.tile'
local inspect = require 'lib.inspect'

local mt = {}
mt.__index = mt

function mt:create()
    for i = 1, self.h do
        self.cells[i] = {}

        for j = 1, self.w do
            self.cells[i][j] = Tile.new(i, j, self.cellsize)
        end
    end

    self:recurse(1, 1, {})
end

function mt:draw()
    for i = 1, self.h do
        for j = 1, self.w do
            self.cells[i][j]:draw(self.w, self.h, self.offsetx, self.offsety)
        end
    end
end

function mt:recurse(i, j, stack)
    -- print("-----------")
    -- print(i)
    -- print(j)
    -- print("-----------")

    print("-----------")
    print(i)
    print(j)

    self.cells[i][j]:setVisited(true)

    local n = {}

    if j ~= 1 and not self.cells[i][j - 1].visited then
        n[#n + 1] = {
            d = "left",
            i = i,
            j = j - 1
        }
    end

    if j ~= self.w and not self.cells[i][j + 1].visited then
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

    if i ~= self.h and not self.cells[i + 1][j].visited then
        n[#n + 1] = {
            d = "down",
            i = i + 1,
            j = j
        }
    end

    -- print(self.h)
    -- print(inspect(n))
    -- print(inspect(stack))
    print("-----------")

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
        print("####")
        print(inspect(pop))
        print("####")
        self:recurse(pop.i, pop.j, stack)
    end
end

return {
    new = function(w, h, cellsize, offsetx, offsety)
        return setmetatable({
            w = w,
            h = h,
            cellsize = cellsize,
            offsetx = offsetx,
            offsety = offsety,
            cells = {}
        }, mt)
    end
}
