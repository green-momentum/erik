local mt = {}
mt.__index = mt

function mt:add(item)
    self.items[#self.items + 1] = item
end

return {
    new = function()
        return setmetatable({
            items = {}
        }, mt)
    end
}
