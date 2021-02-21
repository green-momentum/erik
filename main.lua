local World = require 'src.world'
local Flag = require 'src.flag'
local Hero = require 'src.hero'
local Maze = require 'src.maze'

local SCREEN_SIZE = 340
local CURRENT_LEVEL = 1
local TILE_SIZE = 10
local MAZE_SIZE = 10
local MAZE_OFFSET = (SCREEN_SIZE - (MAZE_SIZE * TILE_SIZE)) / 2

local flag, hero, maze, world

function love.load()
    math.randomseed(os.time())

    world = World.new()
    maze = Maze.new(CURRENT_LEVEL, TILE_SIZE, SCREEN_SIZE)
    hero = Hero.new(1, 1, TILE_SIZE, MAZE_SIZE, MAZE_OFFSET)
    flag = Flag.new(SCREEN_SIZE, SCREEN_SIZE, TILE_SIZE, MAZE_SIZE, MAZE_OFFSET)

    world:add(maze)
    world:add(hero)
    world:add(flag)

    maze:create()
    maze:getStartAndGoal()
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
    hero:update(dt, maze)
end

function love.draw(dt)
    love.graphics.scale(1.5, 1.5)
    love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

    for _, item in ipairs(world.items) do
        item:draw()
    end
end
