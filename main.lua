local World = require 'src.world'
local Flag = require 'src.flag'
local Hero = require 'src.hero'
local Maze = require 'src.maze'

local SCREEN_SIZE = 256
local TILE_SIZE = 20
local MAZE_SIZE = 10
local MAZE_OFFSET = (SCREEN_SIZE - (MAZE_SIZE * TILE_SIZE)) / 2

local flag, hero, maze, world

function love.load()
    math.randomseed(os.time())

    world = World.new()
    maze = Maze.new(MAZE_SIZE, MAZE_SIZE, TILE_SIZE, MAZE_OFFSET, MAZE_OFFSET)
    -- hero = Hero.new(maze, TILE_SIZE)
    -- flag = Flag.new(maze, TILE_SIZE)

    -- TODO: get hero and flag positions from maze.
    hero = Hero.new(0, 0, TILE_SIZE, MAZE_SIZE, MAZE_OFFSET)
    flag = Flag.new(SCREEN_SIZE, SCREEN_SIZE, TILE_SIZE, MAZE_SIZE, MAZE_OFFSET)

    world:add(maze)
    world:add(hero)
    world:add(flag)

    maze:create()
end

function love.keypressed(key)
    if key == "space" then
        maze:create()
    end
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(2, 2)
    love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)

    for _, item in ipairs(world.items) do
        item:draw()
    end
end
