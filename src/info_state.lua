local Timer = require "lib.timer"

local info_state = {
    load = function(self)
        self.font = love.graphics.newFont("assets/1980_font.ttf", 40)
        love.graphics.setFont(self.font)

        self.opening_text = "NARRATIVE TEXT"

        Timer.after(2, function()
            sm:setState("game_state")
        end)
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.opening_text, (680 - self.font:getWidth(self.opening_text)) / 2,
            (680 - self.font:getHeight(self.opening_text)) / 2)
    end,

    keypressed = function(self, key)
    end
}

return info_state
