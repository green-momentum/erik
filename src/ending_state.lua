local Timer = require "lib.timer"

local ending_state = {
    load = function(self)
        self.font = love.graphics.newFont("assets/mr_pixel/Mister Pixel Regular.otf", 40)
        love.graphics.setFont(self.font)

        self.logo = love.graphics.newImage("assets/erik.png")

        self.text = [[
 No! This must be a joke. Only plums in
the chest? This is too bad, it doesn't
 look like chocolate. Why would someone
put the plum in the chest? Why...
        ]]
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.text, (680 - self.font:getWidth(self.text)) / 2, 410)

        love.graphics.setColor(255, 255, 255, alpha)
        love.graphics.draw(self.logo, (680 - self.logo:getWidth()) / 2, (680 - self.logo:getHeight()) / 2 - 30)
    end,

    keypressed = function(self, key)
        if key == "space" then
            sm:setState("opening_state")
        end
    end
}

return ending_state
