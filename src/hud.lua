local mt = {}
mt.__index = mt

return {
    new = function()
        return setmetatable({}, mt)
    end
}
