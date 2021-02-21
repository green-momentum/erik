local opening_state = {
    load = function(self)
        love.graphics.setDefaultFilter("nearest", "nearest")
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)
        love.graphics.setColor(0, 1, 0, alpha)
        love.graphics.print("OPENING SCENE.", 100, 100)
    end,

    keypressed = function(self, key)
        sm:setState("game_state")
    end
}

return opening_state
