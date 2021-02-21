local Camera = require 'lib.camera'
local Flag = require 'src.flag'
local Hero = require 'src.hero'
local Maze = require 'src.maze'
local Timer = require 'src.timer'

local game_state = {
    calculate_zoom = function(self)
        return 3 - (self.current_level ^ 0.5 * 0.338) + self.current_level * 0.0065
    end,

    load = function(self)
        math.randomseed(os.time())

        self.current_level = 1
        self.screen_size = 340
        self.tile_size = 10

        self.timer = Timer.new()
        self.zoom = self:calculate_zoom()

        self.camera = Camera(self.screen_size, self.screen_size)
        self.camera:zoomTo(self.zoom)

        self.maze = Maze.new(self.current_level, self.tile_size, self.screen_size)
        self.maze:create()

        local p = self.maze:getStartAndGoal()

        self.img_flag = love.graphics.newImage("assets/flag.png")
        self.flag = Flag.new(p.goal, self.tile_size, self.maze.offset)

        self.img_hero = love.graphics.newImage("assets/hero.png")
        self.hero = Hero.new(p.start, p.goal, self.tile_size, self.maze.offset)

        -- TODO: Pass to player

        -- self.timer:start(10, function()
        --  print("times up")
        -- end)
    end,

    update = function(self, dt)
        self.timer:update()
        self.hero:update(dt, self.maze, function()
            self.current_level = self.current_level + 1
            self.zoom = self:calculate_zoom()
            self.camera:zoomTo(self.zoom)
            self.maze = Maze.new(self.current_level, self.tile_size, self.screen_size)
            self.maze:create()

            local p = self.maze:getStartAndGoal()
            self.hero = Hero.new(p.start, p.goal, self.tile_size, self.maze.offset)
            self.flag = Flag.new(p.goal, self.tile_size, self.maze.offset)
        end)
    end,

    draw = function(self, dt, alpha)
        self.camera:attach()
        love.graphics.scale(2, 2)
        love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)
        self.maze:draw(alpha)
        self.flag:draw(self.img_flag)
        self.hero:draw(self.img_hero)
        self.camera:detach()

        love.graphics.setColor(0, 1, 0, alpha)
        love.graphics.print("GAME SCENE.", 100, 100)
        -- love.graphics.print(self.timer.limit - self.timer.secs, 250, 100)
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
