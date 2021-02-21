local flux = require 'lib.flux'

local mt = {}
mt.__index = mt

function mt:setState(key)
    flux.to(self, 1, {
        alpha = 0
    }):oncomplete(function()
        self.current_state = key
        self.states[self.current_state]:load()
        flux.to(self, 1, {
            alpha = 1
        }):oncomplete(function()
            print(self.alpha)
        end)
    end)
end

function mt:update(dt)
    if self.current_state ~= nil then
        return self.states[self.current_state]:update(dt)
    end
end

function mt:draw(dt)
    if self.current_state ~= nil then
        return self.states[self.current_state]:draw(dt, self.alpha)
    end
end

function mt:keypressed(key)
    if self.current_state ~= nil then
        return self.states[self.current_state]:keypressed(key)
    end
end

function mt:register(key, obj)
    self.states[key] = obj
end

return {
    new = function()
        return setmetatable({
            alpha = 1,
            current_state = nil,
            states = {}
        }, mt)
    end
}
