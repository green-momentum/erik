local Hero = require 'src.hero'
local Maze = require 'src.maze'

local maze, hero

local SCREEN_SIZE = 256
local CURRENT_LEVEL = 1
local TILE_SIZE = 10
-- local MAZE_SIZE = 21
-- local MAZE_OFFSET = (SCREEN_SIZE - (MAZE_SIZE * TILE_SIZE)) / 2

function diff_curve(x)
  return math.floor(x^0.4 * 5)
end

function love.load()
    math.randomseed(os.time())

    local maze_size = diff_curve(CURRENT_LEVEL)

    local MAZE_OFFSET = (SCREEN_SIZE - (maze_size * TILE_SIZE)) / 2
    maze = Maze.new(maze_size, maze_size, TILE_SIZE, MAZE_OFFSET, MAZE_OFFSET)
    hero = Hero.new(0, 0, TILE_SIZE, MAZE_OFFSET)

    maze:create()
    maze:getStartAndGoal()
    print(CURRENT_LEVEL)
end

function love.keypressed(key)
    if key == "space" then
        CURRENT_LEVEL = CURRENT_LEVEL + 1
        print(CURRENT_LEVEL)
        local maze_size = diff_curve(CURRENT_LEVEL)
        local MAZE_OFFSET = (SCREEN_SIZE - (maze_size * TILE_SIZE)) / 2
        maze = Maze.new(maze_size, maze_size, TILE_SIZE, MAZE_OFFSET, MAZE_OFFSET)

        maze:create()
        maze:getStartAndGoal()
    end
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(2, 2)
    love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

    --hero:draw()
    maze:draw()
end
