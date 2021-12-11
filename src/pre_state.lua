local Timer = require "lib.timer"

local pre_state = {
    load = function(self)
        self.font = love.graphics.newFont("assets/mr_pixel/Mister Pixel Regular.otf", 40)
        love.graphics.setFont(self.font)

        self.logo = love.graphics.newImage("assets/erik.png")

        local text_list = {
            [[
I remember leaving a few wafer bars in
  one of my toy boxes. I have to find
            them.
            ]],
            [[
  There was a lot of chocolate on my
    birthday. My friends couldn't have
  eaten them all. It must be somewhere.
 I'll start searching from the wardrobe
            first.
            ]],
            [[
  I know I'm not the only one eating
  chocolate in this house. Where could
   they be hiding the chocolates? No
  pressure. Just relax and watch it
            happen!
            ]],
            [[
    I have to look a little more! I
 should have little happy little sweets
over there. We don't make mistakes. We
      just have happy candies!
            ]],
            [[
  Every day is a good day when I eat
   chocolates. Talk to the chocolates,
      make friends with it.
            ]]
        }

        self.text = text_list[math.floor(math.random(1, #text_list))]

        Timer.after(5, function()
            sm:setState("game_state")
        end)
    end,

    update = function(self, dt)
    end,

    draw = function(self, dt, alpha)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.text, (680 - self.font:getWidth(self.text)) / 2,
            (680 - self.font:getHeight(self.text)) / 3)

        love.graphics.setColor(255, 255, 255, alpha)
        -- love.graphics.draw(self.logo, (680 - self.logo:getWidth()) / 2, (680 - self.logo:getHeight()) / 2 - 30)
    end,

    keypressed = function(self, key)
    end
}

return pre_state
