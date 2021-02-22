local Camera = require 'lib.camera'
local Flag = require 'src.flag'
local Hero = require 'src.hero'
local Maze = require 'src.maze'
local Timer = require 'src.timer'

local inspect = require 'lib.inspect'

local game_state = {
    current_level = 0,
    max_level = 30,

    calculate_zoom = function(self)
        return 3 - (self.current_level ^ 0.5 * 0.338) + self.current_level * 0.0065
    end,

    load = function(self)
        self.choco = love.graphics.newImage("assets/flag.png")
        self.font = love.graphics.newFont("assets/1980_font.ttf", 40)
        love.graphics.setFont(self.font)

        self.current_level = self.current_level + 1

        self.text = "FOUND CHOCOLATES: " .. (self.current_level - 1)

        math.randomseed(os.time())

        self.screen_size = 340
        self.tile_size = 10

        self.timer = Timer.new()
        self.timer:start(8 + self.current_level * 2, function()
            self.timer.active = false
            self.current_level = 1
            sm:setState("fail_state")
        end)

        self.zoom = self:calculate_zoom()

        self.camera = Camera(self.screen_size, self.screen_size)
        self.camera:zoomTo(self.zoom)

        self.maze = Maze.new(self.current_level, self.tile_size, self.screen_size)
        self.maze:create()

        local points = self.maze:getStartAndGoal()

        local f_img = self.max_level == self.current_level and "assets/chest.png" or "assets/flag.png"
        self.img_flag = love.graphics.newImage(f_img)
        self.flag = Flag.new(points.goal, self.tile_size, self.maze.offset)

        self.img_hero = love.graphics.newImage("assets/hero.png")
        self.hero = Hero.new(points.start, points.goal, self.tile_size, self.maze.offset)
        self.maze:pushPath(points.start.row, points.start.col)

        -- TODO: Pass to player

        -- self.timer:start(10, function()
        --  print("times up")
        -- end)
    end,

    update = function(self, dt)
        self.timer:update()
        self.hero:update(dt, self.maze, function()
            -- self.zoom = self:calculate_zoom()

            -- self.camera:zoomTo(self.zoom)

            -- self.maze = Maze.new(self.current_level, self.tile_size, self.screen_size)

            -- self.maze:create()
            -- local points = self.maze:getStartAndGoal()

            -- self.hero = Hero.new(points.start, points.goal, self.tile_size, self.maze.offset)
            self.timer.active = false
            if self.current_level == self.max_level then
                sm:setState("ending_state")
            else
                sm:setState("pre_state")
            end
        end)
    end,

    draw = function(self, dt, alpha)
        self.camera:attach()
        love.graphics.scale(2, 2)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)
        self.maze:draw(alpha)
        self.maze:drawPath(alpha)
        self.flag:draw(self.img_flag, alpha)
        self.hero:draw(self.img_hero, alpha)
        self.camera:detach()

        love.graphics.setColor(121 / 255, 121 / 255, 121 / 255, alpha)
        love.graphics.print(self.text, (680 - self.font:getWidth(self.text)) / 2, 10)

        print(inspect(self.timer))
        if self.timer.secs then
            self.time_text = "TIME: " .. (self.timer.limit - self.timer.secs)
            love.graphics.print(self.time_text, (680 - self.font:getWidth(self.time_text)) / 2, 40)
        end
        -- love.graphics.print(self.timer.limit - self.timer.secs, 250, 100)
        love.graphics.setColor(255, 255, 255, alpha)
        love.graphics.draw(self.choco, (680 - self.choco:getWidth()) / 2 - (self.font:getWidth(self.text) / 2) - 25, 10)
    end,

    keypressed = function(self, key)
        if key == "space" then
            self.current_level = self.current_level + 1
            self.zoom = self:calculate_zoom()

            self.camera:zoomTo(self.zoom)
            self.maze = Maze.new(self.current_level, self.tile_size, self.screen_size)

            self.maze:create()
            self.maze:getStartAndGoal()
        else
            -- sm:setState("opening_state")
        end
    end
}

return game_state
