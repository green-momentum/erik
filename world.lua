local TILE_SIZE = {
    w = 20,
    h = 20
}

local mt = {}
mt.__index = mt

function mt:add(item)
    self.items[#self.items + 1] = item
end

return {
    new = function()
        return setmetatable({
            items = {},
            TILE_SIZE = TILE_SIZE
        }, mt)
    end
}
