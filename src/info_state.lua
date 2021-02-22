local Timer = require "lib.timer"

local info_state = {
    load = function(self)
        self.font = love.graphics.newFont("assets/1980_font.ttf", 40)
        love.graphics.setFont(self.font)

        self.opening_text = [[
 I am Defne. My dad thinks I eat a lot
   of chocolate, and he didn't buy me
chocolate today. However, I did not eat
   them every day! I remember that I
stacked some chocolates in my room. Now
 help me to find the chocolates in my
          room full of toys.
        ]]

        Timer.after(20, function()
            sm:setState("game_state")
        end)
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)
        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.opening_text, (680 - self.font:getWidth(self.opening_text)) / 2,
            (680 - self.font:getHeight(self.opening_text)) / 3)
    end,

    keypressed = function(self, key)
        if key == "space" then
            sm:setState("game_state")
        end
    end
}

return info_state
