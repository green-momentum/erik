local Hero = require 'src.hero'
local Maze = require 'src.maze'

local maze, hero

local SCREEN_SIZE = 340
local CURRENT_LEVEL = 1
local TILE_SIZE = 10

function love.load()
    math.randomseed(os.time())

    maze = Maze.new(CURRENT_LEVEL, TILE_SIZE, SCREEN_SIZE)
    hero = Hero.new(0, 0, TILE_SIZE, MAZE_OFFSET)

    maze:create()
    maze:getStartAndGoal()
    print(CURRENT_LEVEL)
end

function love.keypressed(key)
    if key == "space" then
        CURRENT_LEVEL = CURRENT_LEVEL + 1
        print(CURRENT_LEVEL)

        maze = Maze.new(CURRENT_LEVEL, TILE_SIZE, SCREEN_SIZE)
        hero = Hero.new(0, 0, TILE_SIZE, MAZE_OFFSET)

        maze:create()
        maze:getStartAndGoal()
    end
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(1.5, 1.5)
    love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

    --hero:draw()
    maze:draw()
end
