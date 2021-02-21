local opening_state = {
    load = function(self)
        self.font = love.graphics.newFont("assets/1980_font.ttf", 40)
        love.graphics.setFont(self.font)
        love.graphics.setDefaultFilter("nearest", "nearest")

        self.logo = love.graphics.newImage("assets/erik_logo.png")

        self.opening_text = "PRESS SPACE TO START THE GAME"
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.opening_text, (680 - self.font:getWidth(self.opening_text)) / 2, 410)

        love.graphics.setColor(255, 255, 255, alpha)
        love.graphics.draw(self.logo, (680 - self.logo:getWidth()) / 2, (680 - self.logo:getHeight()) / 2 - 30)
    end,

    keypressed = function(self, key)
        if key == "space" then
            sm:setState("info_state")
        end
    end
}

return opening_state
