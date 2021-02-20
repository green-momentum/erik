local World = require 'src.world'
local Maze = require 'src.maze'
local Hero = require 'src.hero'

local world, maze, hero

function love.load()
    world = World.new()
    maze = Maze:new()
    hero = Hero.new(0, 0, world.TILE_SIZE.w, world.TILE_SIZE.h)

    world:add(maze)
    world:add(hero)
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(2, 2)
    hero:draw()
end
